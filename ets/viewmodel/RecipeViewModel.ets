import {
  DetailedStep,
  Flavor,
  Food,
  HotRecipe,
  Recipe,
  RecipeSelection,
  Seasoning,
  Step,
  StepWithTime
} from "../model/RecipeModel";

/**
 * 创作食谱的数据结构
 */
// 食谱模型类，封装所有操作
class RecipeModel {
  private recipes: Recipe[] = [];

  // 获取所有食谱
  list(): Recipe[] {
    return this.recipes;
  }

  /**
   * 增
   */
  // 添加新食谱
  addRecipe(recipe: Recipe): void {

    this.recipes.push(recipe);
  }

  // 添加食材到指定食谱
  addFood(recipeId: string, food: Food): void {
    const recipe = this.getById(recipeId);
    if (recipe) {
      recipe.foods.push(food);
    }
  }

  // 添加调料到指定食谱
  addSeasoning(recipeId: string, seasoning: Seasoning): void {
    const recipe = this.getById(recipeId);
    if (recipe) {
      recipe.seasonings.push(seasoning);
    }
  }

  // 设置食谱口味
  addFlavor(recipeId: string, flavor: Flavor): void {
    const recipe = this.getById(recipeId);
    if (recipe) {
      recipe.flavor.push(flavor);
    }
  }

  // 添加步骤
  addStep(recipeId: string, step: Step): void {
    const recipe = this.getById(recipeId);
    if (recipe) {
      recipe.steps.push(step);
    }
  }

  // 添加详细步骤到某个步骤
  addDetailedStep(recipeId: string, stepId: number, detailedStep: DetailedStep): void {
    const recipe = this.getById(recipeId);
    if (recipe) {
      const step = recipe.steps.find(s => s.id === stepId);
      if (step) {
        step.detailedSteps.push(detailedStep);
      }
    }
  }

  /**
   * 删
   */
  // 根据ID删除食谱
  removeRecipe(id: string): void {
    this.recipes = this.recipes.filter(recipe => recipe.id !== id);
  }

  // 删除步骤
  removeStep(recipeId: string, stepId: number): void {
    const recipe = this.getById(recipeId);
    if (recipe) {
      recipe.steps = recipe.steps.filter(step => step.id !== stepId);
    }
  }

  /**
   * 改
   */
  // 修改食谱的名称（根据ID）
  updateRecipeName(id: string, newName: string): void {
    const recipe = this.getById(id);
    if (recipe) {
      recipe.name = newName;
    } else {
      console.log(`Recipe with ID ${id} not found`);
    }
  }

  // 更新食谱
  updateRecipe(updatedRecipe: Recipe): void {
    const index = this.recipes.findIndex(recipe => recipe.id === updatedRecipe.id);
    if (index !== -1) {
      this.recipes[index] = updatedRecipe;
    }
  }

  // 修改步骤
  updateStep(recipeId: string, updatedStep: Step): void {
    const recipe = this.getById(recipeId);
    if (recipe) {
      const index = recipe.steps.findIndex(step => step.id === updatedStep.id);
      if (index !== -1) {
        recipe.steps[index] = updatedStep;
      }
    }
  }

  updateDetailedStepContent(recipeId: string, stepId: number, detailedStepIndex: number, newContent: string): void {
    const recipe = this.getById(recipeId);

    if (recipe) {
      const step = recipe.steps.find(s => s.id === stepId);

      if (step) {
        if (detailedStepIndex >= 0 && detailedStepIndex < step.detailedSteps.length) {
          step.detailedSteps[detailedStepIndex].content = newContent;
          console.log(`DetailedStep at index ${detailedStepIndex} in step with ID ${stepId} updated`);
        } else {
          console.log(`DetailedStep index ${detailedStepIndex} is out of range`);
        }
      } else {
        console.log(`Step with ID ${stepId} not found`);
      }
    } else {
      console.log(`Recipe with ID ${recipeId} not found`);
    }
  }

  /**
   * 查
   */


  // 根据ID获取食谱
  getById(id: string): Recipe {
    const recipe = this.recipes.find(recipe => recipe.id === id);
    if (!recipe) {
      throw new Error(`Recipe with id ${id} not found`);
    }
    return recipe;
  }

  // 获取食谱的名称（根据ID）
  getRecipeNameById(id: string): string {
    const recipe = this.getById(id);
    return recipe ? recipe.name : '';
  }

  // 根据ID查询食谱的食物
  getFoodsByRecipeId(id: string): Food[] | undefined {
    const recipe = this.getById(id);
    return recipe ? recipe.foods : undefined;
  }

  // 根据ID查询食谱的调料
  getSeasoningsByRecipeId(id: string): Seasoning[] | undefined {
    const recipe = this.getById(id);
    return recipe ? recipe.seasonings : undefined;
  }

  // 根据ID查询食谱的口味
  getFlavorByRecipeId(id: string): Flavor[] | undefined {
    const recipe = this.getById(id);
    return recipe ? recipe.flavor : undefined;
  }

  // 根据ID查询食谱的步骤
  getStepsByRecipeId(id: string): Step[] {
    const recipe = this.getById(id);
    return recipe.steps;
  }

  // 根据ID查询食谱的步骤
  getDetailedStepsById(recipeId: string, stepId: number): DetailedStep[] {
    const recipe = this.getById(recipeId);
    const steps = recipe.steps
    console.log(JSON.stringify(steps[stepId].detailedSteps) + '?1')
    return steps[stepId].detailedSteps;
  }
}

export const recipeModel = new RecipeModel();

export default recipeModel

/**
 * 管理选择食谱的数据结构
 */
class RecipeSelectionModel {
  private selectedRecipes: RecipeSelection[] = [];

  // Retrieve all recipes
  list(): RecipeSelection[] {
    return this.selectedRecipes;
  }

  // Add a new recipe
  addRecipe(
    name: string,
    isMine: boolean,
    isFrequent: boolean,
    isFavorite: boolean,
    viewsCount: number,
    steps: StepWithTime[],
    successRate?: number
  ): void {
    const existingRecipe = this.selectedRecipes.find((recipe) => recipe.name === name);
    if (existingRecipe) {
      console.log(`Recipe "${name}" already exists in the selection.`);
    } else {
      const newRecipe = new RecipeSelection(name, isMine, isFrequent, isFavorite, viewsCount, steps, successRate);
      this.selectedRecipes.push(newRecipe);
      console.log(`Recipe "${name}" added to the selection.`);
    }
  }

  // Remove a recipe by name
  removeRecipe(name: string): void {
    const index = this.selectedRecipes.findIndex((recipe) => recipe.name === name);
    if (index !== -1) {
      this.selectedRecipes.splice(index, 1);
      console.log(`Recipe "${name}" removed from the selection.`);
    } else {
      console.log(`Recipe "${name}" not found.`);
    }
  }
}

// Create an instance and add 20 recipes
export const recipeSelectionModel: RecipeSelectionModel = new RecipeSelectionModel();

/**
 * 热门食谱的数据结构
 */

// 食谱类别类型
type RecipeCategory = '减脂轻食' | '家常小炒' | '自制小吃' | '滋补汤类' | '面点烘焙' | '宝宝辅食' | '异国料理';


// RecipeModel 类的定义，添加类别支持

export class HotRecipeModel {
  private hotRecipes: HotRecipe[] = [];

  // 获取所有热门食谱
  list(): HotRecipe[] {
    return this.hotRecipes;
  }

  // 添加热门食谱
  addRecipe(recipe: HotRecipe): void {
    this.hotRecipes.push(recipe);
  }

  // 根据ID获取食谱
  getById(id: string): HotRecipe | undefined {
    return this.hotRecipes.find(recipe => recipe.id === id);
  }

  // 根据类别获取热门食谱
  getByCategory(mainCategory: string): HotRecipe[] {
    return this.hotRecipes.filter(recipe => recipe.mainCategory === mainCategory);
  }
}

export const hotRecipeModel: HotRecipeModel = new HotRecipeModel();


// 示例食谱数据
const food1 = new Food("小白菜", "300g");
const seasoning1 = new Seasoning("盐", "1g");
const flavor1 = new Flavor("咸", 2);
const step1 = new Step("准备食材", [new DetailedStep("将小白菜洗净，去掉根部")]);
const step2 = new Step("炒制", [
  new DetailedStep("热锅凉油，将小白菜放入锅中"),
  new DetailedStep("加入盐，快速翻炒至熟")
]);
const recipe1 = new Recipe("1", "清炒小白菜", [step1, step2], [food1], [seasoning1], [flavor1]);

const food2a = new Food("番茄", "2个");
const food2b = new Food("鸡蛋", "2个");
const seasoning2 = new Seasoning("盐", "适量");
const flavor2 = new Flavor("酸甜", 3);
const step3 = new Step("准备食材", [
  new DetailedStep("番茄洗净切块"),
  new DetailedStep("鸡蛋打入碗中，搅拌均匀")
]);
const step4 = new Step("炒制", [
  new DetailedStep("热锅放油，将鸡蛋炒熟备用"),
  new DetailedStep("再放油，炒番茄，加盐"),
  new DetailedStep("将鸡蛋回锅，快速翻炒")
]);
const recipe2 = new Recipe("2", "番茄炒蛋", [step3, step4], [food2a, food2b], [seasoning2], [flavor2]);

const food3 = new Food("五花肉", "500g");
const seasoning3a = new Seasoning("酱油", "30ml");
const seasoning3b = new Seasoning("糖", "10g");
const flavor3 = new Flavor("咸甜", 4);
const step5 = new Step("准备工作", [new DetailedStep("将五花肉切块")]);
const step6 = new Step("炖煮", [
  new DetailedStep("热锅放油，加入糖炒糖色"),
  new DetailedStep("放入五花肉翻炒，加入酱油调味"),
  new DetailedStep("加入水，煮至肉软烂")
]);
const recipe3 = new Recipe("3", "红烧肉", [step5, step6], [food3], [seasoning3a, seasoning3b], [flavor3]);

const food4 = new Food("土豆", "300g");
const seasoning4a = new Seasoning("醋", "10ml");
const seasoning4b = new Seasoning("辣椒", "适量");
const flavor4 = new Flavor("酸辣", 4);
const step7 = new Step("准备", [new DetailedStep("将土豆去皮切丝，用水冲洗")]);
const step8 = new Step("炒制", [
  new DetailedStep("热锅放油，加入辣椒爆香"),
  new DetailedStep("加入土豆丝快速翻炒"),
  new DetailedStep("加入醋，翻炒均匀")
]);
const recipe4 = new Recipe("4", "酸辣土豆丝", [step7, step8], [food4], [seasoning4a, seasoning4b], [flavor4]);

const food5 = new Food("西兰花", "250g");
const seasoning5 = new Seasoning("蒜", "3瓣");
const flavor5 = new Flavor("蒜香", 3);
const step9 = new Step("准备", [
  new DetailedStep("将西兰花洗净切块"),
  new DetailedStep("蒜切末")
]);
const step10 = new Step("炒制", [
  new DetailedStep("热锅放油，加入蒜末炒香"),
  new DetailedStep("加入西兰花翻炒至熟")
]);
const recipe5 = new Recipe("5", "蒜蓉西兰花", [step9, step10], [food5], [seasoning5], [flavor5]);

// 添加食谱到模型中
recipeModel.addRecipe(recipe1);
recipeModel.addRecipe(recipe2);
recipeModel.addRecipe(recipe3);
recipeModel.addRecipe(recipe4);
recipeModel.addRecipe(recipe5);


// 食谱1：番茄炒蛋
const steps1 = [
  new StepWithTime("准备食材", 5),
  new StepWithTime("打蛋和切番茄", 10),
  new StepWithTime("热锅放油，将鸡蛋炒熟备用", 3),
  new StepWithTime("炒番茄，加调料", 8),
  new StepWithTime("混合炒匀，完成", 2),
];
recipeSelectionModel.addRecipe(
  "番茄炒蛋",
  true,
  true,
  true,
  100,
  steps1,
  95
);

// 食谱2：麻辣火锅
const steps2 = [
  new StepWithTime("准备食材", 15),
  new StepWithTime("切肉和蔬菜", 10),
  new StepWithTime("准备火锅底料和汤底", 10),
  new StepWithTime("烧水，加入火锅底料", 5),
  new StepWithTime("放入食材煮熟", 20),
  new StepWithTime("调味，完成", 5),
];
recipeSelectionModel.addRecipe(
  "麻辣火锅",
  false,
  true,
  true,
  200,
  steps2
);

// 食谱3：清蒸鲈鱼
const steps3 = [
  new StepWithTime("准备食材，清洗鲈鱼", 10),
  new StepWithTime("切姜蒜，准备调料", 5),
  new StepWithTime("调味料涂抹在鱼身", 5),
  new StepWithTime("上蒸锅蒸20分钟", 20),
  new StepWithTime("出锅，装盘，完成", 5),
];
recipeSelectionModel.addRecipe(
  "清蒸鲈鱼",
  false,
  false,
  true,
  150,
  steps3,
  98
);

// 食谱4：宫保鸡丁
const steps4 = [
  new StepWithTime("准备食材", 10),
  new StepWithTime("切鸡肉、青椒、干辣椒", 8),
  new StepWithTime("热锅加油，炒鸡肉", 10),
  new StepWithTime("加入辣椒、花生炒匀", 5),
  new StepWithTime("加入调料，炒匀，完成", 5),
];
recipeSelectionModel.addRecipe(
  "宫保鸡丁",
  false,
  true,
  true,
  80,
  steps4,
  96
);

// 食谱5：鱼香肉丝
const steps5 = [
  new StepWithTime("准备食材", 10),
  new StepWithTime("切肉丝，切蔬菜", 8),
  new StepWithTime("热锅加油，炒肉丝", 8),
  new StepWithTime("加入蔬菜炒匀", 5),
  new StepWithTime("加入调料，炒匀，完成", 5),
];
recipeSelectionModel.addRecipe(
  "鱼香肉丝",
  false,
  true,
  true,
  120,
  steps5
);

// 食谱6：炒青菜
const steps6 = [
  new StepWithTime("准备食材，洗菜", 5),
  new StepWithTime("切蒜末，热锅加油", 5),
  new StepWithTime("炒蒜末出香味", 2),
  new StepWithTime("加入青菜炒熟", 5),
  new StepWithTime("加盐调味，炒匀，完成", 3),
];
recipeSelectionModel.addRecipe(
  "炒青菜",
  false,
  false,
  true,
  90,
  steps6,
  99
);

// 食谱7：炖牛肉
const steps7 = [
  new StepWithTime("准备食材，切牛肉", 10),
  new StepWithTime("准备炖汤的香料和调料", 8),
  new StepWithTime("热锅加油，炒香牛肉", 12),
  new StepWithTime("加入香料，炖煮牛肉", 60),
  new StepWithTime("出锅，装盘，完成", 5),
];
recipeSelectionModel.addRecipe(
  "炖牛肉",
  false,
  true,
  true,
  180,
  steps7
);

// 食谱8：蛋炒饭
const steps8 = [
  new StepWithTime("准备食材，打蛋，切蔬菜", 10),
  new StepWithTime("热锅加油，炒蛋", 5),
  new StepWithTime("加入米饭炒匀", 5),
  new StepWithTime("加入蔬菜炒匀", 5),
  new StepWithTime("加入酱油调味，炒匀，完成", 3),
];
recipeSelectionModel.addRecipe(
  "蛋炒饭",
  false,
  true,
  true,
  70,
  steps8,
  98
);

// 食谱9：红烧茄子
const steps9 = [
  new StepWithTime("准备食材，切茄子", 8),
  new StepWithTime("热锅加油，炸茄子", 12),
  new StepWithTime("加入调料炒匀", 5),
  new StepWithTime("加入糖和酱油，炒匀", 5),
  new StepWithTime("炒至茄子软化，完成", 5),
];
recipeSelectionModel.addRecipe(
  "红烧茄子",
  false,
  false,
  true,
  110,
  steps9
);

// 食谱10：干煸四季豆
const steps10 = [
  new StepWithTime("准备食材，洗四季豆", 5),
  new StepWithTime("热锅加油，炸四季豆", 10),
  new StepWithTime("加入蒜末和辣椒，翻炒", 5),
  new StepWithTime("加调料，炒匀，完成", 5),
];
recipeSelectionModel.addRecipe(
  "干煸四季豆",
  false,
  false,
  true,
  90,
  steps10,
  97
);

// 食谱11：蒜蓉蒸虾
const steps11 = [
  new StepWithTime("准备食材，清洗虾", 8),
  new StepWithTime("切蒜末，准备蒸锅", 5),
  new StepWithTime("虾背剪开，涂抹蒜蓉", 5),
  new StepWithTime("放入蒸锅蒸10分钟", 10),
  new StepWithTime("出锅，装盘，完成", 3),
];
recipeSelectionModel.addRecipe(
  "蒜蓉蒸虾",
  false,
  true,
  true,
  60,
  steps11,
  99
);

// 食谱12：酸辣汤
const steps12 = [
  new StepWithTime("准备食材，切豆腐和木耳", 10),
  new StepWithTime("热锅加油，炒香葱姜蒜", 5),
  new StepWithTime("加入汤底，煮开", 10),
  new StepWithTime("加入豆腐、木耳等食材煮熟", 10),
  new StepWithTime("加调味料，完成", 5),
];
recipeSelectionModel.addRecipe(
  "酸辣汤",
  false,
  true,
  true,
  130,
  steps12
);





// 减脂轻食食谱
const hotRecipe1 = new HotRecipe(
  "1",
  "牛油果虾仁沙拉",
  "减脂轻食",
  "沙拉类",
  $r('app.media.R11'),
  [
    new Step("准备食材", [
      new DetailedStep("牛油果去皮切块，虾仁煮熟备用")
    ]),
    new Step("搭配", [
      new DetailedStep("将牛油果、虾仁放入碗中，加入少许橄榄油拌匀")
    ])
  ],
  [new Food("牛油果", "1个"), new Food("虾仁", "100g")],
  [new Seasoning("橄榄油", "适量")],
  [new Flavor("清淡", 3)]
);

const hotRecipe2 = new HotRecipe(
  "2",
  "烟熏三文鱼佐红肠碎",
  "减脂轻食",
  "冷盘", $r('app.media.R12'),
  [
    new Step("准备食材", [
      new DetailedStep("将烟熏三文鱼和红肠切小块")
    ]),
    new Step("搭配", [
      new DetailedStep("将三文鱼和红肠碎混合，摆盘")
    ])
  ],
  [new Food("烟熏三文鱼", "50g"), new Food("红肠", "20g")],
  [],
  [new Flavor("咸香", 3)]
);

const hotRecipe3 = new HotRecipe(
  "3",
  "全麦贝果帕尼尼三明治",
  "减脂轻食",
  "三明治",
  $r('app.media.R13'),
  [
    new Step("准备食材", [
      new DetailedStep("切开全麦贝果，加入帕尼尼配料")
    ]),
    new Step("夹心", [
      new DetailedStep("将贝果夹入火腿、生菜、番茄等食材")
    ])
  ],
  [new Food("全麦贝果", "1个"), new Food("火腿", "1片"), new Food("生菜", "适量")],
  [],
  [new Flavor("清淡", 3)]
);

const hotRecipe4 = new HotRecipe(
  "4",
  "肉夹馍",
  "减脂轻食",
  "主食", $r('app.media.R14'),
  [
    new Step("准备", [new DetailedStep("将白吉馍切开")]),
    new Step("夹肉", [
      new DetailedStep("加入炖煮的五花肉，夹入馍内")
    ])
  ],
  [new Food("白吉馍", "1个"), new Food("五花肉", "100g")],
  [new Seasoning("酱油", "适量")],
  [new Flavor("咸香", 4)]
);

// 家常小炒食谱
const hotRecipe5 = new HotRecipe(
  "5",
  "爆炒双脆",
  "家常小炒",
  "荤素搭配", $r('app.media.R21'),
  [
    new Step("准备食材", [
      new DetailedStep("猪肚和鸡胗洗净切片")
    ]),
    new Step("爆炒", [
      new DetailedStep("热锅放油，加入猪肚和鸡胗翻炒至熟")
    ])
  ],
  [new Food("猪肚", "100g"), new Food("鸡胗", "100g")],
  [new Seasoning("盐", "适量")],
  [new Flavor("咸香", 4)]
);

const hotRecipe6 = new HotRecipe(
  "6",
  "尖椒猪五花",
  "家常小炒",
  "辣味", $r('app.media.R22'),
  [
    new Step("准备食材", [new DetailedStep("猪五花切片，尖椒切段")]),
    new Step("炒制", [
      new DetailedStep("热锅放油，加入猪五花炒香"),
      new DetailedStep("加入尖椒翻炒")
    ])
  ],
  [new Food("猪五花", "200g"), new Food("尖椒", "3个")],
  [new Seasoning("酱油", "适量")],
  [new Flavor("辛辣", 4)]
);

const hotRecipe7 = new HotRecipe(
  "7",
  "鱼香肉丝",
  "家常小炒",
  "传统菜", $r('app.media.R23'),
  [
    new Step("准备食材", [
      new DetailedStep("肉丝腌制，青椒切丝")
    ]),
    new Step("炒制", [
      new DetailedStep("加入肉丝和调味料炒香"),
      new DetailedStep("加入青椒炒匀")
    ])
  ],
  [new Food("肉丝", "200g"), new Food("青椒", "2个")],
  [new Seasoning("豆瓣酱", "1汤匙")],
  [new Flavor("酸甜", 4)]
);

const hotRecipe8 = new HotRecipe(
  "8",
  "西兰花炒肉",
  "家常小炒",
  "荤素搭配", $r('app.media.R24'),
  [
    new Step("准备食材", [
      new DetailedStep("西兰花掰小朵，肉片切好")
    ]),
    new Step("炒制", [
      new DetailedStep("热锅放油，炒肉片至变色"),
      new DetailedStep("加入西兰花翻炒")
    ])
  ],
  [new Food("西兰花", "250g"), new Food("肉片", "100g")],
  [new Seasoning("盐", "适量")],
  [new Flavor("清淡", 3)]
);

hotRecipeModel.addRecipe(hotRecipe1);
hotRecipeModel.addRecipe(hotRecipe2);
hotRecipeModel.addRecipe(hotRecipe3);
hotRecipeModel.addRecipe(hotRecipe4);
hotRecipeModel.addRecipe(hotRecipe5);
hotRecipeModel.addRecipe(hotRecipe6);
hotRecipeModel.addRecipe(hotRecipe7);
hotRecipeModel.addRecipe(hotRecipe8);
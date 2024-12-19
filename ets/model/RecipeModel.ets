/**
 * 创作食谱的数据结构
 */
export let stepIdCounter = 0;

export let detailedStepIdCounter = 0;


export class Ingredient {
  name: string;
  quantity: string;

  constructor(name: string, quantity: string) {

    this.name = name;
    this.quantity = quantity;
  }
}

export class Food extends Ingredient {
}

export class Seasoning extends Ingredient {
}

export class Flavor {
  name: string;
  level: number;

  constructor(name: string, level: number) {
    if (level < 1 || level > 5) {
      throw new Error("Level must be between 1 and 5.");
    }
    this.name = name;
    this.level = level;
  }
}


export class DetailedStep {
  id: number;
  content: string;
  recipeImages?: ResourceStr[];

  constructor(content: string, recipeImages: ResourceStr[] = []) {
    this.id = detailedStepIdCounter++; // 使用自增ID
    this.content = content;
    this.recipeImages = recipeImages;
  }
}

export class Step {
  id: number;
  name: string;
  detailedSteps: DetailedStep[];

  constructor(name: string, detailedSteps: DetailedStep[]) {
    this.id = stepIdCounter++; // 使用自增ID
    this.name = name;
    this.detailedSteps = detailedSteps;
  }
}


export class Recipe {
  id: string;
  name: string;
  steps: Step[];
  foods: Food[];
  seasonings: Seasoning[];
  flavor: Flavor[];

  constructor(id: string, name: string, steps: Step[], foods: Food[], seasonings: Seasoning[], flavor: Flavor[]) {
    this.id = id;
    this.name = name;
    this.steps = steps;
    this.foods = foods;
    this.seasonings = seasonings;
    this.flavor = flavor;
    stepIdCounter = 0
    detailedStepIdCounter = 0

  }
}


/**
 * 选择食谱的数据结构
 */
export class StepWithTime {
  stepName: string;
  duration: number; // Time in minutes

  constructor(stepName: string, duration: number) {
    this.stepName = stepName;
    this.duration = duration;
  }
}

export class RecipeSelection {
  name: string;
  isMine: boolean;
  isFrequent: boolean;
  isFavorite: boolean;
  viewsCount: number;
  successRate?: number;
  steps: StepWithTime[]; // Array of steps with specified time

  constructor(
    name: string,
    isMine: boolean,
    isFrequent: boolean,
    isFavorite: boolean,
    viewsCount: number,
    steps: StepWithTime[],
    successRate?: number
  ) {
    this.name = name;
    this.isMine = isMine;
    this.isFrequent = isFrequent;
    this.isFavorite = isFavorite;
    this.viewsCount = viewsCount;
    this.steps = steps;
    if (isMine) {
      this.successRate = successRate;
    }
  }
}

/**
 * 热门食谱的数据结构
 */
// 食谱类别类型
type RecipeCategory = '减脂轻食' | '家常小炒' | '自制小吃' | '滋补汤类' | '面点烘焙' | '宝宝辅食' | '异国料理';

// 数据结构定义
export class HotRecipe {
  id: string;
  name: string;
  mainCategory: string; // e.g., '减脂轻食', '家常小炒'
  subCategory: string; // e.g., '蔬菜类', '荤菜类'
  imageUrl: ResourceStr; // URL of the recipe's image
  steps: Step[];
  foods: Food[];
  seasonings: Seasoning[];
  flavors: Flavor[];

  constructor(id: string, name: string, mainCategory: string, subCategory: string, imageUrl: ResourceStr, steps: Step[],
    foods: Food[], seasonings: Seasoning[], flavors: Flavor[]) {
    this.id = id;
    this.name = name;
    this.mainCategory = mainCategory;
    this.subCategory = subCategory;
    this.imageUrl = imageUrl;
    this.steps = steps;
    this.foods = foods;
    this.seasonings = seasonings;
    this.flavors = flavors;
  }
}
export class ListAdapter<T> implements IDataSource{

  private list: T[] = []
  private listeners: DataChangeListener[] = [];

  constructor(list: T[] = []) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): T {
    return this.list[index]
  }
  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number,action: (t:T) => void): void {
    action(this.list[index])
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  addData(...t: T[]){
    this.list.push(...t)
    this.notifyDataReload()
  }

  setData(t: T[]){
    this.list = t
    this.notifyDataReload()
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

}
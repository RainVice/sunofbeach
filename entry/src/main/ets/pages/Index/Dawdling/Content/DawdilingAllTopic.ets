import { moyu } from '../../../../api/index'
import { NavDestinationHeader, RefreshList } from '../../../../component/index'
import { FULL_PERCENT } from '../../../../constants/index'
import { ListAdapter } from '../../../../utils/index'

@Component
export struct DawdilingAllTopic {
  @State topics: moyu.Datum[] = []
  @State adapter: ListAdapter<moyu.Datum> = new ListAdapter<moyu.Datum>([])

  async aboutToAppear(): Promise<void> {
    await this.refresh()
  }

  async refresh(){
    this.topics = await moyu.allTopic()
    this.adapter.setData(this.topics)
  }

  build() {
    NavDestination() {
      Column() {
        NavDestinationHeader(){
          Text($r('app.string.all_topic'))
        }

        if (this.adapter){
          RefreshList({
            listAdapter: $adapter,
            itemView: (item, index) => {
              this.gridItem(item as moyu.Datum,index)
            },
            refresh: async () => {
              await this.refresh()
            }
          })
        }
      }
      .padding({ left: 20, right: 20 })
    }
    .hideTitleBar(true)
  }

  @Builder
  gridItem(item: moyu.Datum, index: number) {
    Row({space: 8}) {
      Image(item.cover).autoResize(true).height(50).width(50)
        .alt($r('app.media.image_error'))
      Column({space: 2}) {
        Text(item.topicName)
          .fontSize(14)
          // .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.first_text'))
        Text(item.description)
          .fontSize(12)
          .fontColor($r('app.color.second_text'))
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      if (item.hasFollowed) {
        Text($r('app.string.followed'))
          .fontSize(12)
          .fontColor($r('app.color.selected_background_for_component'))
          .onClick(async () => {
            await moyu.unfollowTopic(item.id)
            this.adapter.notifyDataChange(index,(data) => {
              data.hasFollowed = false
            })
          })

      }
      else {
        Text($r('app.string.follow'))
          .fontSize(12)
          .fontColor($r('app.color.auxiliary'))
          .onClick(async () => {
            if (await moyu.followTopic(item.id)) {
              this.adapter.notifyDataChange(index,(data) => {
                data.hasFollowed = true
              })
            }
          })
      }
    }
    .justifyContent(FlexAlign.Start)
    .width(FULL_PERCENT)
  }
}
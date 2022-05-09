Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046DB51F8CC
	for <lists+linux-nfs@lfdr.de>; Mon,  9 May 2022 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiEIJel (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 May 2022 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiEIJAi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 May 2022 05:00:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CB13FA29;
        Mon,  9 May 2022 01:56:45 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KxZks2yMYzfbS7;
        Mon,  9 May 2022 16:55:33 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 16:56:42 +0800
Subject: Re: [PATCH] MM: handle THP in swap_*page_fs() - count_vm_events()
To:     Yang Shi <shy828301@gmail.com>
CC:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, <linux-nfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>
References: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
 <Ym9pLhqtf61AVrZG@casper.infradead.org>
 <165146932944.24404.17790836056748683378@noble.neil.brown.name>
 <Ym9szKx7qYZTlKF2@casper.infradead.org>
 <CAHbLzkqtjg6yaPp-yktRtUBo5-Yw9rJKvJWH9PDDHxsuHh6Mhw@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <059786bc-191b-8126-0c76-34dbf2e29159@huawei.com>
Date:   Mon, 9 May 2022 16:56:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkqtjg6yaPp-yktRtUBo5-Yw9rJKvJWH9PDDHxsuHh6Mhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2022/5/7 1:26, Yang Shi wrote:
> On Sun, May 1, 2022 at 10:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Mon, May 02, 2022 at 03:28:49PM +1000, NeilBrown wrote:
>>> On Mon, 02 May 2022, Matthew Wilcox wrote:
>>>> On Mon, May 02, 2022 at 02:57:46PM +1000, NeilBrown wrote:
>>>>> @@ -390,9 +392,9 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>>>>>                   struct page *page = sio->bvec[p].bv_page;
>>>>>
>>>>>                   SetPageUptodate(page);
>>>>> +                 count_swpout_vm_event(page);
>>>>>                   unlock_page(page);
>>>>>           }
>>>>> -         count_vm_events(PSWPIN, sio->pages);
>>>>
>>>> Surely that should be count_swpIN_vm_event?
>>>>
>>> I'm not having a good day....
>>>
>>> Certainly shouldn't be swpout.  There isn't a count_swpin_vm_event().
>>>
>>> swap_readpage() only counts once for each page no matter how big it is.
>>> While swap_writepage() counts one for each PAGE_SIZE written.
>>>
>>> And we have THP_SWPOUT but not THP_SWPIN
>>
>> _If_ I understand the swap-in patch correctly (at least as invoked by
>> shmem), it won't attempt to swap in an entire THP.  Even if it swapped
>> out an order-9 page, it will bring in order-0 pages from swap, and then
>> rely on khugepaged to reassemble them.
> 
> Totally correct. The try_to_unmap() called by vmscan would split PMD
> to PTEs then install swap entries for each PTE but keep the huge page
> unsplit.
> 
> BTW, there were patches adding THP swapin support, but they were never merged.

Could you please tell me where the THP swapin patches are ? It would be really helpful
if you can kindly figure that out for me! :)

Thanks a lot!

> 
>>
>> Someone who actually understands the swap code should check that my
>> explanation here is correct.
>>
> .
> 


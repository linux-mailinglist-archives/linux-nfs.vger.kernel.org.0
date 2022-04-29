Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F405143B4
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 10:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355416AbiD2IRB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiD2IQ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 04:16:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4627B10;
        Fri, 29 Apr 2022 01:13:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KqQGr35h0zhYcy;
        Fri, 29 Apr 2022 16:13:24 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:13:39 +0800
Subject: Re: [PATCH 1/2] MM: handle THP in swap_*page_fs()
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <165119280115.15698.2629172320052218921.stgit@noble.brown>
 <165119301488.15698.9457662928942765453.stgit@noble.brown>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f1c1ff7d-9180-4046-613a-8b4656e0bc43@huawei.com>
Date:   Fri, 29 Apr 2022 16:13:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <165119301488.15698.9457662928942765453.stgit@noble.brown>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2022/4/29 8:43, NeilBrown wrote:
> Pages passed to swap_readpage()/swap_writepage() are not necessarily all
> the same size - there may be transparent-huge-pages involves.
> 
> The BIO paths of swap_*page() handle this correctly, but the SWP_FS_OPS
> path does not.
> 
> So we need to use thp_size() to find the size, not just assume
> PAGE_SIZE, and we need to track the total length of the request, not
> just assume it is "page * PAGE_SIZE".
> 
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/page_io.c |   23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index c132511f521c..d636a3531cad 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -239,6 +239,7 @@ struct swap_iocb {
>  	struct kiocb		iocb;
>  	struct bio_vec		bvec[SWAP_CLUSTER_MAX];
>  	int			pages;
> +	int			len;
>  };
>  static mempool_t *sio_pool;
>  
> @@ -261,7 +262,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)

The patch looks good to me. Thanks!

But we might need use count_swpout_vm_event in sio_write_complete. THP_SWPOUT should be
accounted too. And count_vm_events(PSWPOUT, sio->pages) doesn't account the right number
of pages now. Maybe sio_read_complete also needs this fix. Or am I miss something?

Thanks!

>  	struct page *page = sio->bvec[0].bv_page;
>  	int p;
>  
> -	if (ret != PAGE_SIZE * sio->pages) {
> +	if (ret != sio->len) {
>  		/*
>  		 * In the case of swap-over-nfs, this can be a
>  		 * temporary failure if the system has limited
> @@ -301,7 +302,7 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
>  		sio = *wbc->swap_plug;
>  	if (sio) {
>  		if (sio->iocb.ki_filp != swap_file ||
> -		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
> +		    sio->iocb.ki_pos + sio->len != pos) {
>  			swap_write_unplug(sio);
>  			sio = NULL;
>  		}
> @@ -312,10 +313,12 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
>  		sio->iocb.ki_complete = sio_write_complete;
>  		sio->iocb.ki_pos = pos;
>  		sio->pages = 0;
> +		sio->len = 0;
>  	}
>  	sio->bvec[sio->pages].bv_page = page;
> -	sio->bvec[sio->pages].bv_len = PAGE_SIZE;
> +	sio->bvec[sio->pages].bv_len = thp_size(page);
>  	sio->bvec[sio->pages].bv_offset = 0;
> +	sio->len += thp_size(page);
>  	sio->pages += 1;
>  	if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->swap_plug) {
>  		swap_write_unplug(sio);
> @@ -371,8 +374,7 @@ void swap_write_unplug(struct swap_iocb *sio)
>  	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
>  	int ret;
>  
> -	iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages,
> -		      PAGE_SIZE * sio->pages);
> +	iov_iter_bvec(&from, WRITE, sio->bvec, sio->pages, sio->len);
>  	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
>  	if (ret != -EIOCBQUEUED)
>  		sio_write_complete(&sio->iocb, ret);
> @@ -383,7 +385,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
>  	int p;
>  
> -	if (ret == PAGE_SIZE * sio->pages) {
> +	if (ret == sio->len) {
>  		for (p = 0; p < sio->pages; p++) {
>  			struct page *page = sio->bvec[p].bv_page;
>  
> @@ -415,7 +417,7 @@ static void swap_readpage_fs(struct page *page,
>  		sio = *plug;
>  	if (sio) {
>  		if (sio->iocb.ki_filp != sis->swap_file ||
> -		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
> +		    sio->iocb.ki_pos + sio->len != pos) {
>  			swap_read_unplug(sio);
>  			sio = NULL;
>  		}
> @@ -426,10 +428,12 @@ static void swap_readpage_fs(struct page *page,
>  		sio->iocb.ki_pos = pos;
>  		sio->iocb.ki_complete = sio_read_complete;
>  		sio->pages = 0;
> +		sio->len = 0;
>  	}
>  	sio->bvec[sio->pages].bv_page = page;
> -	sio->bvec[sio->pages].bv_len = PAGE_SIZE;
> +	sio->bvec[sio->pages].bv_len = thp_size(page);
>  	sio->bvec[sio->pages].bv_offset = 0;
> +	sio->len += thp_size(page);
>  	sio->pages += 1;
>  	if (sio->pages == ARRAY_SIZE(sio->bvec) || !plug) {
>  		swap_read_unplug(sio);
> @@ -521,8 +525,7 @@ void __swap_read_unplug(struct swap_iocb *sio)
>  	struct address_space *mapping = sio->iocb.ki_filp->f_mapping;
>  	int ret;
>  
> -	iov_iter_bvec(&from, READ, sio->bvec, sio->pages,
> -		      PAGE_SIZE * sio->pages);
> +	iov_iter_bvec(&from, READ, sio->bvec, sio->pages, sio->len);
>  	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
>  	if (ret != -EIOCBQUEUED)
>  		sio_read_complete(&sio->iocb, ret);
> 
> 
> .
> 


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808C504CE6
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Apr 2022 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiDRHCQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Apr 2022 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiDRHCP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Apr 2022 03:02:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D04165B6;
        Sun, 17 Apr 2022 23:59:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Khd8g086qzgYrS;
        Mon, 18 Apr 2022 14:59:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 14:59:34 +0800
Subject: Re: [PATCH 09/10] MM: submit multipage write for SWP_FS_OPS
 swap-space
To:     NeilBrown <neilb@suse.de>
CC:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        <linux-nfs@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <164859751830.29473.5309689752169286816.stgit@noble.brown>
 <164859778128.29473.5191868522654408537.stgit@noble.brown>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <033ccf1a-c6b5-fd77-0ad0-4915ff07bc15@huawei.com>
Date:   Mon, 18 Apr 2022 14:59:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <164859778128.29473.5191868522654408537.stgit@noble.brown>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2022/3/30 7:49, NeilBrown wrote:
> swap_writepage() is given one page at a time, but may be called repeatedly
> in succession.
> For block-device swapspace, the blk_plug functionality allows the
> multiple pages to be combined together at lower layers.
> That cannot be used for SWP_FS_OPS as blk_plug may not exist - it is
> only active when CONFIG_BLOCK=y.  Consequently all swap reads over NFS
> are single page reads.
> 
> With this patch we pass a pointer-to-pointer via the wbc.
> swap_writepage can store state between calls - much like the pointer
> passed explicitly to swap_readpage.  After calling swap_writepage() some
> number of times, the state will be passed to swap_write_unplug() which
> can submit the combined request.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
...
>  
>  static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
>  {
> -	struct swap_iocb *sio;
> +	struct swap_iocb *sio = NULL;
>  	struct swap_info_struct *sis = page_swap_info(page);
>  	struct file *swap_file = sis->swap_file;
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct iov_iter from;
> -	int ret;
> +	loff_t pos = page_file_offset(page);
>  
>  	set_page_writeback(page);
>  	unlock_page(page);
> -	sio = mempool_alloc(sio_pool, GFP_NOIO);
> -	init_sync_kiocb(&sio->iocb, swap_file);
> -	sio->iocb.ki_complete = sio_write_complete;
> -	sio->iocb.ki_pos = page_file_offset(page);
> -	sio->bvec[0].bv_page = page;
> -	sio->bvec[0].bv_len = PAGE_SIZE;
> -	sio->bvec[0].bv_offset = 0;
> -	iov_iter_bvec(&from, WRITE, &sio->bvec[0], 1, PAGE_SIZE);
> -	ret = mapping->a_ops->swap_rw(&sio->iocb, &from);
> -	if (ret != -EIOCBQUEUED)
> -		sio_write_complete(&sio->iocb, ret);
> -	return ret;
> +	if (wbc->swap_plug)
> +		sio = *wbc->swap_plug;
> +	if (sio) {
> +		if (sio->iocb.ki_filp != swap_file ||
> +		    sio->iocb.ki_pos + sio->pages * PAGE_SIZE != pos) {
> +			swap_write_unplug(sio);
> +			sio = NULL;
> +		}
> +	}
> +	if (!sio) {
> +		sio = mempool_alloc(sio_pool, GFP_NOIO);
> +		init_sync_kiocb(&sio->iocb, swap_file);
> +		sio->iocb.ki_complete = sio_write_complete;
> +		sio->iocb.ki_pos = pos;
> +		sio->pages = 0;
> +	}
> +	sio->bvec[sio->pages].bv_page = page;
> +	sio->bvec[sio->pages].bv_len = PAGE_SIZE;

Many thanks for your patch. And sorry for late responding and newbie question. Does swap_writepage_fs
support transhuge page now? We could come across transhuge page here. But bv_len == PAGE_SIZE and pages
== 1 is assumed here. Do we need something like below:

sio->bvec[sio->pages].bv_len = thp_size(page);
sio->pages += thp_nr_pages(page);

Thanks! :)

> +	sio->bvec[sio->pages].bv_offset = 0;
...
> .
> 


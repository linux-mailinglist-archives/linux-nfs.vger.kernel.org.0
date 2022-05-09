Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696A51F904
	for <lists+linux-nfs@lfdr.de>; Mon,  9 May 2022 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiEIJhZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 May 2022 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiEII6v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 May 2022 04:58:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF61B2145;
        Mon,  9 May 2022 01:54:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxZfr4KTXzGpfv;
        Mon,  9 May 2022 16:52:04 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 16:54:51 +0800
Subject: Re: [PATCH v2] MM: handle THP in swap_*page_fs() - count_vm_events()
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Christoph Hellwig <hch@lst.de>, <linux-nfs@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <165146746627.24404.2324091720943354711@noble.neil.brown.name>
 <165146948934.24404.5909750610552745025@noble.neil.brown.name>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <37653eca-e82e-62aa-6829-7413cb844b75@huawei.com>
Date:   Mon, 9 May 2022 16:54:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <165146948934.24404.5909750610552745025@noble.neil.brown.name>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/5/2 13:31, NeilBrown wrote:
> 
> We need to use count_swpout_vm_event() for sio_write_complete() to get
> correct counting.
> 
> Note that THP swap in (if it ever happens) is current accounted 1 for
> each page, whether HUGE or normal.  This is different from swap-out
> accounting.

Agree, there is no THP swap-in now.

> 
> This patch should be squashed into
>     MM: handle THP in swap_*page_fs()
> 

This patch looks good to me. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mm/page_io.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index d636a3531cad..1b8075ef3418 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -280,8 +280,10 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
>  			set_page_dirty(page);
>  			ClearPageReclaim(page);
>  		}
> -	} else
> -		count_vm_events(PSWPOUT, sio->pages);
> +	} else {
> +		for (p = 0; p < sio->pages; p++)
> +			count_swpout_vm_event(sio->bvec[p].bv_page);
> +	}
>  
>  	for (p = 0; p < sio->pages; p++)
>  		end_page_writeback(sio->bvec[p].bv_page);
> 


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5315ADD1B
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIFB4e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Sep 2022 21:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIFB4d (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Sep 2022 21:56:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB729CA3;
        Mon,  5 Sep 2022 18:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CXem7Coa8rRQeskwG7G6nsmprv5fGWmxmm18847sqCA=; b=UuYpAIyS6pZIsEIgEKueahMcwz
        MMyRuf5lkVJe8gIDPhuwBcgSknv1nqJWHA/F+wy3jf4U8SGFH8l5PjW7EfFWEm9Ag0Joql8OVIRPu
        PI+KHx2OpcbkGTmrtsRT0nObFIOEoEmGitrh6eJChWMLLMsgTxCTvlzO8Dkd8TClKbia2ZsCiizoF
        3VFJHo1+lr74X5pDYn3vgvG4iWs6r9jbAv8LGGM9qNxrhSfr2D1PJ9z2pGqaw51ehgLyiQJMScflN
        0n0aISMhkgpRt15GZQUsKgJYive95BdGfkH3fBrdbzCZOhPUpiO91CuMN4RRnW2fEh0WFfHLTAstt
        3nZRfWdQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVNp6-001VtU-Iu; Tue, 06 Sep 2022 01:56:20 +0000
Message-ID: <1636a540-2115-0cdc-aeb3-236fabd78ccb@infradead.org>
Date:   Mon, 5 Sep 2022 18:56:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] fs/nfs/pnfs_nfs.c: fix spelling typo and syntax error in
 comment
To:     Jiangshan Yi <13667453960@163.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220906015027.3963386-1-13667453960@163.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220906015027.3963386-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On 9/5/22 18:50, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo and syntax error in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  fs/nfs/pnfs_nfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> index 657c242a18ff..45a5a66a2e3e 100644
> --- a/fs/nfs/pnfs_nfs.c
> +++ b/fs/nfs/pnfs_nfs.c
> @@ -374,12 +374,12 @@ pnfs_bucket_search_commit_reqs(struct pnfs_commit_bucket *buckets,
>  	return NULL;
>  }
>  
> -/* pnfs_generic_search_commit_reqs - Search lists in @cinfo for the head reqest
> +/* pnfs_generic_search_commit_reqs - Search lists in @cinfo for the head request
>   *				   for @page
>   * @cinfo - commit info for current inode
>   * @page - page to search for matching head request
>   *

Since you are changing the Returns line anyway, please use the documented
kernel-doc syntax for it:

> - * Returns a the head request if one is found, otherwise returns NULL.
> + * Returns the head request if one is found, otherwise returns NULL.

 * Return: the head request if one is found, otherwise %NULL.

>   */
>  struct nfs_page *
>  pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page)

Thanks.
-- 
~Randy

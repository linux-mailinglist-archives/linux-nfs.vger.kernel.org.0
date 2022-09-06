Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAA5ADE88
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 06:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIFEZn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 00:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIFEZm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 00:25:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6A28E0C;
        Mon,  5 Sep 2022 21:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KjGpnaOCoiegcftfzU0dj0F2Me4aFhhK3DZjFApXZm8=; b=zb+LxBkfN6fMtDfzMz18/kuVNr
        IQPwEBNu0xJKIj4at/oCNSMojQGn8qRP1p2xw67S1SQlArvCNhLnuL0nb3s2R1USbaKdgkOiv8dw2
        +nFlRQHDUB8dW/kgm3sOzjJ/BBsE54SIaE3w99cAkBkceRrYyHaS/uh2CcYSJDqdf7P/0ro+V2bIK
        jPsoJmiuoYk8DI+TWhZelI9NZ6XqE+rjxG9SEOGFEp2nIZe/tdelTXE67E3SywxdlMB27IzrT1npY
        vowQYKNIPnF1kzmFkFwxBXq1sIl8a5CSVgZAaQL21lxwGujANqWN0IXy+sQiYb76Usavm9t/CaOAt
        3qI3RwsA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVQ9T-005wFF-F0; Tue, 06 Sep 2022 04:25:31 +0000
Message-ID: <5c2049f2-8bb8-8626-0ed0-433c202227fd@infradead.org>
Date:   Mon, 5 Sep 2022 21:25:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] fs/nfs/pnfs_nfs.c: fix spelling typo and syntax error
 in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220906024119.424210-1-13667453960@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220906024119.424210-1-13667453960@163.com>
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



On 9/5/22 19:41, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo and syntax error in comment.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/nfs/pnfs_nfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> index 657c242a18ff..987c88ddeaf0 100644
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
> - * Returns a the head request if one is found, otherwise returns NULL.
> + * Return: the head request if one is found, otherwise %NULL.
>   */
>  struct nfs_page *
>  pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page)

-- 
~Randy

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56364C31CE
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiBXQpq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiBXQpp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:45:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9F327FE8
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:45:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7067FB8270C
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 16:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C6BC340EC;
        Thu, 24 Feb 2022 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645721113;
        bh=LRVC13u6fVqTDBKb5cF3EyioAYAEQACD7Z7bkhZzZJo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L+vQ5DbN0IIRjtCNtMR7zLQkbCbK4ddEy1INqM6tMoU4sSDHH1Jd57Gwya5+yErMe
         yvwX/tZ5okadlleily83kY4SX5l7fZU6oCdiALV/xghLmWlP5rkHFL7jK1dKOe88lb
         Z09saW82YqtdsG5FixKtOyCz70lHFSXml5bMzsiaGR9CkqS+ftAkHf4uXRvhaH7KG+
         0qqYsVw3AiCqZs4hoetPe6GzjHthISBR8UwO1tihdEV6bOiEN//gfzLbF3pDrWhxpG
         tF2DadsrUbYKv2RpmASlm5sC/3pyw8PNQMl76M5ur1jQ0DWa44b/8DPwZ5UIVuM42m
         WZfcHgY2rFSiw==
Message-ID: <605c45f5fd1830eb98d78dec05ae55a879710e9e.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 24 Feb 2022 11:45:11 -0500
In-Reply-To: <20220224161705.1041788-1-amir73il@gmail.com>
References: <20220224161705.1041788-1-amir73il@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-02-24 at 18:17 +0200, Amir Goldstein wrote:
> The nfsd file cache table can be pretty large and its allocation
> may require as many as 80 contigious pages.
> 
> Employ the same fix that was employed for similar issue that was
> reported for the reply cache hash table allocation several years ago
> by commit 8f97514b423a ("nfsd: more robust allocation failure handling
> in nfsd_reply_cache_init").
> 
> Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org/
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Since v1:
> - Use kvcalloc()
> - Use kvfree()
> 
>  fs/nfsd/filecache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..cc2831cec669 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -632,7 +632,7 @@ nfsd_file_cache_init(void)
>  	if (!nfsd_filecache_wq)
>  		goto out;
>  
> -	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
> +	nfsd_file_hashtbl = kvcalloc(NFSD_FILE_HASH_SIZE,
>  				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
>  	if (!nfsd_file_hashtbl) {
>  		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
> @@ -700,7 +700,7 @@ nfsd_file_cache_init(void)
>  	nfsd_file_slab = NULL;
>  	kmem_cache_destroy(nfsd_file_mark_slab);
>  	nfsd_file_mark_slab = NULL;
> -	kfree(nfsd_file_hashtbl);
> +	kvfree(nfsd_file_hashtbl);
>  	nfsd_file_hashtbl = NULL;
>  	destroy_workqueue(nfsd_filecache_wq);
>  	nfsd_filecache_wq = NULL;
> @@ -811,7 +811,7 @@ nfsd_file_cache_shutdown(void)
>  	fsnotify_wait_marks_destroyed();
>  	kmem_cache_destroy(nfsd_file_mark_slab);
>  	nfsd_file_mark_slab = NULL;
> -	kfree(nfsd_file_hashtbl);
> +	kvfree(nfsd_file_hashtbl);
>  	nfsd_file_hashtbl = NULL;
>  	destroy_workqueue(nfsd_filecache_wq);
>  	nfsd_filecache_wq = NULL;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

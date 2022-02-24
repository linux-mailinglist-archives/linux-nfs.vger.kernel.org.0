Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FA64C3111
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBXQLI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiBXQLH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:11:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59211B6E15
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:10:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A40C5B82684
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 16:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8945C340E9;
        Thu, 24 Feb 2022 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645719001;
        bh=xN7k02oVgsc1lEJ3wUtiHUqc77pMh55TWXW/d6tQcQg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OTwHy78Doz0uLsgDaq7u8nWSDlWOaU7aHZUZ/AVUOXA4WWIwlX1Lp9F7aHKA7u1ZQ
         QBTqC8EsoIGO0kli4eGhE1hsJAy6eIH2XzMqJ8zuY0D/TMzE18KzvbtxOLIuNtnJho
         vhCRVJ2DwiGx+wgBuRKNmG+iww09kuDreJSelvNOcAv6L4YZXZh2rCeq5WjG7qEVfg
         QPJcNchgRjDVOXV/40GaNN01N9MGusrk06SlUAHJyHUBLPUFHUMV8JeGxlC1a5fgKZ
         gbYX2rZw2hDUcSjxAr64WvgAVApj3fJpgw1/vYVAlL44PbfVYH9dc97lftuJ8Dlv/x
         nI8DfM0jlEASw==
Message-ID: <754d6878583f345449cc10317767d81e1b6bd758.camel@kernel.org>
Subject: Re: [PATCH] nfsd: more robust allocation failure handling in
 nfsd_file_cache_init
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 24 Feb 2022 11:09:59 -0500
In-Reply-To: <20220224160119.1034749-1-amir73il@gmail.com>
References: <20220224160119.1034749-1-amir73il@gmail.com>
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

On Thu, 2022-02-24 at 18:01 +0200, Amir Goldstein wrote:
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
>  fs/nfsd/filecache.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 8bc807c5fea4..b75cd6d1e331 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -60,6 +60,9 @@ static struct fsnotify_group		*nfsd_file_fsnotify_group;
>  static atomic_long_t			nfsd_filecache_count;
>  static struct delayed_work		nfsd_filecache_laundrette;
>  
> +#define NFSD_FILE_HASHTBL_SIZE \
> +	array_size(NFSD_FILE_HASH_SIZE, sizeof(*nfsd_file_hashtbl))
> +
>  static void nfsd_file_gc(void);
>  
>  static void
> @@ -632,8 +635,7 @@ nfsd_file_cache_init(void)
>  	if (!nfsd_filecache_wq)
>  		goto out;
>  
> -	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
> -				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
> +	nfsd_file_hashtbl = kvzalloc(NFSD_FILE_HASHTBL_SIZE, GFP_KERNEL);
>  	if (!nfsd_file_hashtbl) {
>  		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
>  		goto out_err;

You'd also need to change to kvfree(), in case it does end up being
vmalloc'ed. Also, I don't see that the new constant adds anything -- you
could just use kvcalloc().

-- 
Jeff Layton <jlayton@kernel.org>

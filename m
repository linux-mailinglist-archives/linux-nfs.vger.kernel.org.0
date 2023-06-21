Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250F6738D3B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFURhO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFURhN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 13:37:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D91BF6;
        Wed, 21 Jun 2023 10:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0716615FF;
        Wed, 21 Jun 2023 17:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4486CC433C0;
        Wed, 21 Jun 2023 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369011;
        bh=J7nyvmMOq5uGyJhdkzpbJfnd/X7LLGSq3eghpnukqY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF9JYUB8TU5UIwVfMIKNMlrZb7nBhZmXF9AteRSiZ1G4cHOTWVzCbdFqTs4PV2UCC
         NdMYXoA84Mm25AQWrOC/Fthcns+rTX+j92yXk9OX84xYWTqkCE/dArFdVCB2EhRn16
         O8cD15Kr6KsD9GG6YvG01cVBjXwKtFt/5hVIr3cLDURBx7SsqnURKgGhtBjuH9qABn
         cv/lUGWgm4h/EDY6VPzdciICe8Xd6JetOXngEYWQx6lwC3AdcZH5fFOAZDJm6/ob+m
         x7frq8wXN38aKEHA9XnUv+Bs9Nx7bQv4VA5Pj1tocNWcje5nLGVJH408vhKZ8/s9ou
         AsN1d9XpK6g3Q==
Date:   Wed, 21 Jun 2023 13:36:48 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 46/79] nfsd: switch to new ctime accessors
Message-ID: <ZJM1MAEmxpIOE/rC@manet.1015granger.net>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-45-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-45-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 21, 2023 at 10:45:59AM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/nfsd/nfsctl.c | 2 +-
>  fs/nfsd/vfs.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1b8b1aab9a15..bebb65d3ad6b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1131,7 +1131,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
>  	/* Following advice from simple_fill_super documentation: */
>  	inode->i_ino = iunique(sb, NFSD_MaxReserved);
>  	inode->i_mode = mode;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  	switch (mode & S_IFMT) {
>  	case S_IFDIR:
>  		inode->i_fop = &simple_dir_operations;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 59b7d60ae33e..febdfdf16ec1 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -520,7 +520,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	nfsd_sanitize_attrs(inode, iap);
>  
> -	if (check_guard && guardtime != inode->i_ctime.tv_sec)
> +	if (check_guard && guardtime != inode_ctime_peek(inode).tv_sec)
>  		return nfserr_notsync;
>  
>  	/*
> -- 
> 2.41.0
> 

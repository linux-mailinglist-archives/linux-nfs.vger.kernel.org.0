Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30F45FB76B
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJKPg5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Oct 2022 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJKPgl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Oct 2022 11:36:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAB2613F;
        Tue, 11 Oct 2022 08:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C02611CB;
        Tue, 11 Oct 2022 15:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C7DC433C1;
        Tue, 11 Oct 2022 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665501926;
        bh=zigySSphTJZp9lr24dvtduewqmrbx3E1Xf1G7eWmO9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e9zMjpEwpvHxazOA8ZaJCtOyU4VtdurNaMqfkh7bZsv98bs4w332p9srfLLsfEEQK
         BIKeyPPOwaolUQKnga5Np/wSEecoMqQXU/FAyKZroOhfNMXKuCbCFWOS4M56XdSy80
         f4Bzv6aPnCTiLnDpH7ckeq6V9scPDm47uwmNQXPKoA8Y4M/97cF5GxLiEAV08ecysZ
         89oKV7qsGvU797Ls8C5AHIGtGSXLlD0ZVCxRzmKbY15oMlnZ4Dq0M1Q655UXm4TnsO
         KhdcI6JLEO4FFWlB+gYn6fTVJ97ACBBUtlqa5Q99BoH2s5XAzi0ke5LUtCe0knr7KH
         HmYV4GmdTmB/g==
Date:   Tue, 11 Oct 2022 10:25:16 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        kernel test robot <yujie.liu@intel.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] NFS: Avoid memcpy() run-time warning for struct sockaddr
 overflows
Message-ID: <Y0WK3MZvxpoXS24n@work>
References: <20221011065243.583650-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011065243.583650-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 10, 2022 at 11:52:43PM -0700, Kees Cook wrote:
> The 'nfs_server' and 'mount_server' structures include a union of
> 'struct sockaddr' (with the older 16 bytes max address size) and
> 'struct sockaddr_storage' which is large enough to hold all the supported
> sa_family types (128 bytes max size). The runtime memcpy() buffer overflow
> checker is seeing attempts to write beyond the 16 bytes as an overflow,
> but the actual expected size is that of 'struct sockaddr_storage'. Adjust
> the pointers to the correct union member. Avoids this false positive
> run-time warning under CONFIG_FORTIFY_SOURCE:
> 
>   memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/all/202210110948.26b43120-yujie.liu@intel.com
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  fs/nfs/fs_context.c | 2 +-
>  fs/nfs/namespace.c  | 2 +-
>  fs/nfs/super.c      | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 4da701fd1424..bffa31bb35b9 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -1540,7 +1540,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
>  		ctx->version		= nfss->nfs_client->rpc_ops->version;
>  		ctx->minorversion	= nfss->nfs_client->cl_minorversion;
>  
> -		memcpy(&ctx->nfs_server.address, &nfss->nfs_client->cl_addr,
> +		memcpy(&ctx->nfs_server._address, &nfss->nfs_client->cl_addr,
>  			ctx->nfs_server.addrlen);
>  
>  		if (fc->net_ns != net) {
> diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
> index 3295af4110f1..2f336ace7555 100644
> --- a/fs/nfs/namespace.c
> +++ b/fs/nfs/namespace.c
> @@ -175,7 +175,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
>  	}
>  
>  	/* for submounts we want the same server; referrals will reassign */
> -	memcpy(&ctx->nfs_server.address, &client->cl_addr, client->cl_addrlen);
> +	memcpy(&ctx->nfs_server._address, &client->cl_addr, client->cl_addrlen);
>  	ctx->nfs_server.addrlen	= client->cl_addrlen;
>  	ctx->nfs_server.port	= server->port;
>  
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 82944e14fcea..8ea7dfdea427 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -823,7 +823,7 @@ static int nfs_request_mount(struct fs_context *fc,
>  	struct nfs_fs_context *ctx = nfs_fc2context(fc);
>  	struct nfs_mount_request request = {
>  		.sap		= (struct sockaddr *)
> -						&ctx->mount_server.address,
> +						&ctx->mount_server._address,
>  		.dirpath	= ctx->nfs_server.export_path,
>  		.protocol	= ctx->mount_server.protocol,
>  		.fh		= root_fh,
> @@ -854,7 +854,7 @@ static int nfs_request_mount(struct fs_context *fc,
>  	 * Construct the mount server's address.
>  	 */
>  	if (ctx->mount_server.address.sa_family == AF_UNSPEC) {
> -		memcpy(request.sap, &ctx->nfs_server.address,
> +		memcpy(request.sap, &ctx->nfs_server._address,
>  		       ctx->nfs_server.addrlen);
>  		ctx->mount_server.addrlen = ctx->nfs_server.addrlen;
>  	}
> -- 
> 2.34.1
> 

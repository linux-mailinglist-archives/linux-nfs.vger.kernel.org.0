Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B640AF9A22
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 21:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKLUAv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 15:00:51 -0500
Received: from fieldses.org ([173.255.197.46]:41368 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLUAv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Nov 2019 15:00:51 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 772B61C89; Tue, 12 Nov 2019 15:00:50 -0500 (EST)
Date:   Tue, 12 Nov 2019 15:00:50 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     chuck.lever@oracle.com, jamie@audible.transient.net,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: v4 support requires CRYPTO_SHA256
Message-ID: <20191112200050.GD8095@fieldses.org>
References: <20191112190155.12872-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112190155.12872-1-smayhew@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks, applied.--b.

On Tue, Nov 12, 2019 at 02:01:55PM -0500, Scott Mayhew wrote:
> The new nfsdcld client tracking operations use sha256 to compute hashes
> of the kerberos principals, so make sure CRYPTO_SHA256 is enabled.
> 
> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
> Reported-by: Jamie Heilman <jamie@audible.transient.net>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 10cefb0c07c7..c4b1a89b8845 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -73,7 +73,7 @@ config NFSD_V4
>  	select NFSD_V3
>  	select FS_POSIX_ACL
>  	select SUNRPC_GSS
> -	select CRYPTO
> +	select CRYPTO_SHA256
>  	select GRACE_PERIOD
>  	help
>  	  This option enables support in your system's NFS server for
> -- 
> 2.17.2

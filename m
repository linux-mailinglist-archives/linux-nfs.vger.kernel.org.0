Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75E5446761
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Nov 2021 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhKEQ5G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Nov 2021 12:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233703AbhKEQ5F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Nov 2021 12:57:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCDF460E9C;
        Fri,  5 Nov 2021 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636131265;
        bh=ME0jCqFRX/NiwfEsOja6gZmVp/gVjEkqBMvTXUcKzvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtOUBcJ6PmQJ2R25tqhiUHux9nwwLcFEue9eZshPnzdXL9U9tfZNYKYPZhWZr6AF8
         JXWnrDKnKRAamHbR0i3+kdt3t7fFZFoeHrSBZnEN8wjVBn9vSj/Gg33o5PQqf/0o+7
         yI31NH9eE8Un1z6CVohCn6/x9lNdoTR9HcewpsKy1f4kUUUDJ9rbHo14ihf6dSAh6P
         4IVar6EuYgt58Lk1XExi8SA95x2lDXXNwjJHg0mMAUP9mN73IdydcXIrafqvgP+lR2
         uXvs48AFBOtQ0hXat4gmJVIwT0zGtBHKRqUF4/gLKp4zpadQyR2Zd1A2psN9HDtGtQ
         4OTR9RsLQeUBA==
Date:   Fri, 5 Nov 2021 09:54:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Don't trace an uninitialised value
Message-ID: <YYVhvS5q3GyuaBAL@archlinux-ax161>
References: <20211105163852.214665-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105163852.214665-1-trondmy@kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 05, 2021 at 12:38:52PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> If fhandle is NULL or fattr is NULL, then 'error' is uninitialised.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  fs/nfs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 8de99f426183..731d31015b6a 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -1798,7 +1798,7 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
>  	}
>  	nfs_set_verifier(dentry, dir_verifier);
>  out:
> -	trace_nfs_lookup_exit(dir, dentry, flags, error);
> +	trace_nfs_lookup_exit(dir, dentry, flags, PTR_ERR_OR_ZERO(res));
>  	nfs_free_fattr(fattr);
>  	nfs_free_fhandle(fhandle);
>  	return res;
> -- 
> 2.33.1
> 

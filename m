Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C438022CF68
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jul 2020 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGXU23 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Jul 2020 16:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgGXU23 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Jul 2020 16:28:29 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65427C0619D3
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jul 2020 13:28:29 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 28EC11C79; Fri, 24 Jul 2020 16:28:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 28EC11C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1595622507;
        bh=1uanzv4u/6A0uIHTkBrKiSc/04s4Y+mAgOdMqyClhs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TI0/HcHqIFumukUaC1JwvdPyk8sqqkJhFTxpkDXXdLxAXP9t7JwMwwKB8jo4WgVfI
         WgVFxqaQufInl9pqWK/6deGZCTeQKJmtxF7OZ1uPie/WmrOOoq+bcmQTlYbBqka8Bl
         VRGlgXazATBVpP/d6Nkwb+toggjC8A+qUZlcChKQ=
Date:   Fri, 24 Jul 2020 16:28:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] SUNRPC: Fix ("SUNRPC: Add "@len" parameter to
 gss_unwrap()")
Message-ID: <20200724202827.GA9244@fieldses.org>
References: <159561664051.1673.12679579228291628238.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159561664051.1673.12679579228291628238.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 24, 2020 at 02:55:07PM -0400, Chuck Lever wrote:
> Braino when converting "buf->len -=" to "buf->len = len -".
> 
> The result is under-estimation of the ralign and rslack values. On
> krb5p mounts, this has caused READDIR to fail with EIO, and KASAN
> splats when decoding READLINK replies.
> 
> As a result of fixing this oversight, the gss_unwrap method now
> returns a buf->len that can be shorter than priv_len for small
> RPC messages. The additional adjustment done in unwrap_priv_data()
> can underflow buf->len. This causes the nfsd_request_too_large
> check to fail during some NFSv3 operations.
> 
> Reported-by: Marian Rainer-Harbach
> Reported-by: Pierre Sauter <pierre.sauter@stwm.de>
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1886277
> Fixes: 31c9590ae468 ("SUNRPC: Add "@len" parameter to gss_unwrap()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/gss_krb5_wrap.c |    2 +-
>  net/sunrpc/auth_gss/svcauth_gss.c   |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> Hi Bruce-
> 
> I can take this in v5.9 if you agree it's a righteous fix.

Righteous!

Well, seems like a reasonable step, anyway.

I just wish I had a more complete understanding.  Anyway,

Reviewed-by: J. Bruce Fields <bfields@redhat.com>

--b.

> Changes since RFC:
> - series squashed into a single patch
> - "pad" is still calculated in unwrap_priv_data for later use
> 
> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> index cf0fd170ac18..90b8329fef82 100644
> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
> @@ -584,7 +584,7 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
>  							buf->head[0].iov_len);
>  	memmove(ptr, ptr + GSS_KRB5_TOK_HDR_LEN + headskip, movelen);
>  	buf->head[0].iov_len -= GSS_KRB5_TOK_HDR_LEN + headskip;
> -	buf->len = len - GSS_KRB5_TOK_HDR_LEN + headskip;
> +	buf->len = len - (GSS_KRB5_TOK_HDR_LEN + headskip);
>  
>  	/* Trim off the trailing "extra count" and checksum blob */
>  	xdr_buf_trim(buf, ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
> index 7d83f54aaaa6..258b04372f85 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -990,7 +990,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
>  
>  	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
>  	pad = priv_len - buf->len;
> -	buf->len -= pad;
>  	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
>  	 * In the krb5p case, at least, the data ends up offset, so we need to
>  	 * move it around. */
> 

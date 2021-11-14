Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06244FBE9
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Nov 2021 22:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhKNWAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 14 Nov 2021 17:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhKNWAv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 14 Nov 2021 17:00:51 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46272C061766
        for <linux-nfs@vger.kernel.org>; Sun, 14 Nov 2021 13:57:57 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 85BDB3F53; Sun, 14 Nov 2021 16:57:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 85BDB3F53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1636927074;
        bh=9qUEnMNmOr9OXy9ogJhp6zaMop57d47bdknbSjOwrwc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=DNzcmxoIQuAI1TqgowHK5yhR7x4rp88zvYOQRdD6t31Rx2xq04QGL+kYq4Qy0BRci
         OFvEzDw2UtjaX5u72cgmdEkP5LIAo/dp2Xv/gptvifLByhbdO1dZPO1y4irZo9Wldv
         Q6LU+ICPvxMI5SEQZLTmpx6V74sDyV0Pmz9Cq+TM=
Date:   Sun, 14 Nov 2021 16:57:54 -0500
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1] NFSD: Fix exposure in nfsd4_decode_bitmap()
Message-ID: <20211114215754.GB6863@fieldses.org>
References: <163692036074.16710.5678362976688977923.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163692036074.16710.5678362976688977923.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Nov 14, 2021 at 03:16:04PM -0500, Chuck Lever wrote:
> rtm@csail.mit.edu reports:
> > nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
> > directs it to do so. This can cause nfsd4_decode_state_protect4_a()
> > to write client-supplied data beyond the end of
> > nfsd4_exchange_id.spo_must_allow[] when called by
> > nfsd4_decode_exchange_id().
> 
> Rewrite the loops so nfsd4_decode_bitmap() cannot iterate beyond
> @bmlen.
> 
> Reported by: rtm@csail.mit.edu
> Fixes: d1c263a031e8 ("NFSD: Replace READ* macros in nfsd4_decode_fattr()")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> Hi Bruce-
> 
> This version is cleaned up slightly and has been tested as follows:
> 
> - I am not able to crash a patched server using rtm's nfsd_1
> - No new FAILUREs with NFSv4.1 pynfs tests
> - No new failures with xfstests on NFSv4.1 or NFSv4.2
> - No new failures with the git regression suite on NFSv4.1 or NFSv4.2
> - No reports of NFS4ERR_BADXDR or GARBAGE_ARGS during xfs or git regr
> 
> Hopefully that exercises enough uses of nfsd4_decode_bitmap() to be
> confident that it is working properly.
> 
> I tested this on top of my XDR tracepoint series, so the line numbers
> might be a little off from your current tree. However, it should
> otherwise apply cleanly.

Got it, thanks.--b.

> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 5ff481e9c85d..479d3452ce6c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -288,11 +288,8 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
>  	p = xdr_inline_decode(argp->xdr, count << 2);
>  	if (!p)
>  		return nfserr_bad_xdr;
> -	i = 0;
> -	while (i < count)
> -		bmval[i++] = be32_to_cpup(p++);
> -	while (i < bmlen)
> -		bmval[i++] = 0;
> +	for (i = 0; i < bmlen; i++)
> +		bmval[i] = (i < count) ? be32_to_cpup(p++) : 0;
>  
>  	return nfs_ok;
>  }

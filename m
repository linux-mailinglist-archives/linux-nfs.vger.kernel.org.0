Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA9471F46
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 03:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhLMCKv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Dec 2021 21:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMCKu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Dec 2021 21:10:50 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA8C06173F
        for <linux-nfs@vger.kernel.org>; Sun, 12 Dec 2021 18:10:50 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id DDDA37044; Sun, 12 Dec 2021 21:10:48 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DDDA37044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1639361448;
        bh=cHVGzMoHvLFoYVqDd2tJq/cXDN24FQ4TQZfKzB8lJho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMDqfXT2ymnoId2m7C1nBOW9WP0OW5kH/2PHccX3tJ90vlOoqXB11b6roiGr18/wF
         ilABGoJsqM5P486AISeQvn1VYt2RiHJ7Al8RZYIb9F4lUSY4oMB5rLX7RT2OC1wr0R
         BH/h7Pu84myjWiPoLKqymeFc8Mgz36DAo1BKzoZ0=
Date:   Sun, 12 Dec 2021 21:10:48 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "rtm@csail.mit.edu" <rtm@csail.mit.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS client can crash server due to overrun in
 nfsd4_decode_bitmap4()
Message-ID: <20211213021048.GA20814@fieldses.org>
References: <97860.1636837122@crash.local>
 <11B4530A-C0A0-4779-A9BA-F0E19B62C5A6@oracle.com>
 <20211113212544.GA27601@fieldses.org>
 <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A3E5D78-AE3C-4F45-8CB1-10F2EDA1D911@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 13, 2021 at 09:31:40PM +0000, Chuck Lever III wrote:
> Sure, but that's more restrictive than what the old decoder
> did. I have this instead (also yet to be tested):
> 
>     NFSD: Fix exposure in nfsd4_decode_bitmap()
>     
>     rtm@csail.mit.edu reports:
>     > nfsd4_decode_bitmap4() will write beyond bmval[bmlen-1] if the RPC
>     > directs it to do so. This can cause nfsd4_decode_state_protect4_a()
>     > to write client-supplied data beyond the end of
>     > nfsd4_exchange_id.spo_must_allow[] when called by
>     > nfsd4_decode_exchange_id().
>     
>     Rewrite the loops so nfsd4_decode_bitmap() cannot iterate beyond
>     @bmlen.
>     
>     Reported by: <rtm@csail.mit.edu>
>     Fixes: d1c263a031e8 ("NFSD: Replace READ* macros in nfsd4_decode_fattr()")
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 10883e6d80ac..c2f753233fcf 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -288,12 +288,8 @@ nfsd4_decode_bitmap4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen)
>         p = xdr_inline_decode(argp->xdr, count << 2);
>         if (!p)
>                 return nfserr_bad_xdr;
> -       i = 0;
> -       while (i < count)
> -               bmval[i++] = be32_to_cpup(p++);
> -       while (i < bmlen)
> -               bmval[i++] = 0;
> -
> +       for (i = 0; i < bmlen; i++)
> +               bmval[i] = (i < count) ? be32_to_cpup(p++) : 0;
>         return nfs_ok;
>  }
> 
> This allows the client to send bitmaps larger than bmval[],
> as the old decoder did, and ensures that decode_bitmap()
> cannot write farther than @bmlen into the bmval array.

But I notice now that your tree has "NFSD: Replace
nfsd4_decode_bitmap4()", which does error out on large bitmaps.
(Noticed because pynfs checks for this case (see GATT4s and similar) and
is seeing BADXDR returns).

--b.

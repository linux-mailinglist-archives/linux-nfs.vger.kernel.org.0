Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF13F9ED9
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 20:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhH0SdH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 14:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhH0SdG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 14:33:06 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C91C061757
        for <linux-nfs@vger.kernel.org>; Fri, 27 Aug 2021 11:32:17 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id EC96F69D6; Fri, 27 Aug 2021 14:32:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org EC96F69D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630089136;
        bh=YfKDEAT122KmxO6jcCzHj+g4i8OA7nYgNDA04JAs/3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifgdLm6naFSAEPHXLQ8Z4rtzDa2oETMI/GAGBia6GFv3dm94CFu3Lp/Zj2AfeRxSm
         NA4qn2rveJN7e3K1/GGEpOwbv8G6gHdR3kINIGr3Ka1NwWRNk81JVvvBvEoJGw3Ucw
         MuJAiZnadyBa45TEOdKtVqVFm6OV3hQmL5prvi7s=
Date:   Fri, 27 Aug 2021 14:32:16 -0400
From:   "J.  Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <20210827183216.GC3915@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <20210826201916.GB10730@fieldses.org>
 <163001583884.7591.13328510041463261313@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163001583884.7591.13328510041463261313@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 27, 2021 at 08:10:38AM +1000, NeilBrown wrote:
> On Fri, 27 Aug 2021, J.  Bruce Fields wrote:
> > On Thu, Aug 26, 2021 at 04:03:04PM +1000, NeilBrown wrote:
> > > +	}
> > > +	if (resp->dir_ino_uniquifier != ino)
> > > +		ino ^= resp->dir_ino_uniquifier;
> > 
> > I guess this check (here and in nfsd_uniquify_ino) is just to prevent
> > returning inode number zero?
> 
> Yep.  The set of valid inode numbers is 1..MAX and that set isn't closed
> under xor.

I was curious....

The NFS specs don't require FILEID to be nonzero as far as I can tell.

Our client doesn't treat fileid 0 specially.  In the case it has to
return a 32-bit inode it xors the high and low parts and makes no effort
I can see to check for the 0 case.

I modified a server to return 0 for FILEID and MOUNTED_ON_FILEID on one
particular file, and an strace shows that's happily passed on to
userspace:

	getdents64(3, [..., {d_ino=0, d_off=2048, d_reclen=32,
	d_type=DT_REG, d_name="LOCKTESTFILE"}]

But ls silently skips that file in the output.  Huh.

--b.

> It is closed (and bijective) under "xor if not equals".
> 
> I've added:
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 5e2d5c352ecd..fed56edf229f 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -1162,6 +1162,7 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *resp, const char *name,
>  			resp->dir_ino_uniquifier = 0;
>  		resp->dir_have_uniquifier = true;
>  	}
> +	/* See comment in nfsd_uniquify_ino() */
>  	if (resp->dir_ino_uniquifier != ino)
>  		ino ^= resp->dir_ino_uniquifier;
>  	if (xdr_stream_encode_u64(xdr, ino) < 0)
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index bbc7ddd34143..6dd8c7325902 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -155,6 +155,9 @@ static inline u64 nfsd_uniquify_ino(const struct svc_fh *fhp,
>  				    const struct kstat *stat)
>  {
>  	u64 u = nfsd_ino_uniquifier(fhp, stat);
> +	/* Neither stat->ino or return value can be zero, so
> +	 * if ->ino is u, return u.
> +	 */
>  	if (u != stat->ino)
>  		return stat->ino ^ u;
>  	return stat->ino;
> 
> Thanks,
> NeilBrown

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA71148C8
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2019 22:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfLEVnT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Dec 2019 16:43:19 -0500
Received: from fieldses.org ([173.255.197.46]:53376 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbfLEVnS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Dec 2019 16:43:18 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 8B1F4BC3; Thu,  5 Dec 2019 16:43:18 -0500 (EST)
Date:   Thu, 5 Dec 2019 16:43:18 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] NFSD fix nfserro errno mismatch
Message-ID: <20191205214318.GC29765@fieldses.org>
References: <20191204201354.17557-1-olga.kornievskaia@gmail.com>
 <20191204201354.17557-3-olga.kornievskaia@gmail.com>
 <20191205213930.GB29765@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205213930.GB29765@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 05, 2019 at 04:39:30PM -0500, bfields wrote:
> On Wed, Dec 04, 2019 at 03:13:53PM -0500, Olga Kornievskaia wrote:
> > There is mismatch between __be32 and u32 in nfserr and errno.
> > 
> ...
> > @@ -1280,7 +1279,7 @@ extern struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
> >  
> >  	copy->c_fh.size = s_fh->fh_handle.fh_size;
> >  	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_base, copy->c_fh.size);
> > -	copy->stateid.seqid = s_stid->si_generation;
> > +	copy->stateid.seqid = cpu_to_be32(s_stid->si_generation);
> 
> This one isn't an errno, and should really be its own patch.  I've split
> it out as follows.--b.

(And applied the others, thanks.)

> 
> commit a1f3cb8bb088
> Author: Olga Kornievskaia <olga.kornievskaia@gmail.com>
> Date:   Wed Dec 4 15:13:53 2019 -0500
> 
>     NFSD: fix seqid in copy stateid
>     
>     s_stid->si_generation is a u32, copy->stateid.seqid is a __be32, so we
>     should be byte-swapping here if necessary.
>     
>     This effectively undoes the byte-swap performed when reading
>     s_stid->s_generation in nfsd4_decode_copy().  Without this second swap,
>     the stateid we sent to the source in READ could be different from the
>     one the client provided us in the COPY.  We didn't spot this in testing
>     since our implementation always uses a 0 in the seqid field.  But other
>     implementations might not do that.
>     
>     You'd think we should just skip the byte-swapping entirely, but the
>     s_stid field can be used for either our own stateids (in the
>     intra-server case) or foreign stateids (in the inter-server case), and
>     the former are interpreted by us and need byte-swapping.
>     
>     Reported-by: kbuild test robot <lkp@intel.com>
>     Fixes: d5e54eeb0e3d ("NFSD add nfs4 inter ssc to nfsd4_copy")
>     Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>     Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ec4f79c8f71e..9a8debc0d725 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1280,7 +1280,7 @@ nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
>  
>  	copy->c_fh.size = s_fh->fh_handle.fh_size;
>  	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_base, copy->c_fh.size);
> -	copy->stateid.seqid = s_stid->si_generation;
> +	copy->stateid.seqid = cpu_to_be32(s_stid->si_generation);
>  	memcpy(copy->stateid.other, (void *)&s_stid->si_opaque,
>  	       sizeof(stateid_opaque_t));
>  

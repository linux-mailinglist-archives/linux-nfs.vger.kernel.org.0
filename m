Return-Path: <linux-nfs+bounces-14581-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81896B86A95
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB64E7A84B3
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A0288C35;
	Thu, 18 Sep 2025 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INZaCORb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B94221F29
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223289; cv=none; b=EGWWr6A3GmNhWJAEh40TeN+30KLzdgLPjdyDc7T9zoFm3WtATr2vRDMUqD9dfAouHh7KriedZgbNeSN3rEC4ywRriup+r9RKsP/VRGLdxhLgzvBTTQ9S5CSG1KGS2dMy/IdfwO3mva2255uBGKZS9r4FisWjGwfrBzuST4EY56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223289; c=relaxed/simple;
	bh=L7DolKJk4UArBVXsFXZDVWTPu4tLCODCMrCpGwNtzOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+UAfqkPNlFrNZtjEKSzWQ0Dy/NqwJE3rx7idvlyKU8ZwNc8hOmwwdJIfAuB/nUNsbyRQQyf+XsBGdJM1j2jzldBG5f/0YfzPQxnAFEzZzUwQagmDGJY/8VrFyIZoiwkA7KduURUJV/Ua8izi/4bTFaSGMU4QqyPBs1PB4Kb7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INZaCORb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D68C4CEE7;
	Thu, 18 Sep 2025 19:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223287;
	bh=L7DolKJk4UArBVXsFXZDVWTPu4tLCODCMrCpGwNtzOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INZaCORbWULWpaFN71AcJWnpib/t8vU6bkRlcWO2p5fistozqhmE1WhjjQyxs2P8F
	 pZXLL2KiFl+UYGD75WtA967Q5KxznQstmc66qNIJ9FTZ8lEEQ4rK/gmGCbtuXPOT7+
	 R+pfUSFk42SgEMp6ZaolKiHmvJaPaqk75sZouB6SHhd7Yx4hzpFsMhYbohjs4HL/Kb
	 VLzVP0pEK+SomXwiAiOJ2K+d5NqyC0RzNCWE7cTUiDPBLkfkdkAJMd940QYsXAEBET
	 pJEWTZjqMwpPTnYVpMZrTFJGxknZj4LQBzrpGbD8Yf1KjodiuUVL5vzIrb2AWv/Eg7
	 q6ZX+w79T/m8Q==
Date: Thu, 18 Sep 2025 15:21:26 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v10 6/7] nfs/localio: add tracepoints for misaligned DIO
 READ and WRITE support
Message-ID: <aMxbtqugI2dhwsF6@kernel.org>
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-7-snitzer@kernel.org>
 <23118649-3dc6-443b-beb7-9360199e93e3@oracle.com>
 <aMxFhX-jHnfv1F24@kernel.org>
 <9d8fb1e9-d40c-4c00-a555-e37ac0d4f290@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8fb1e9-d40c-4c00-a555-e37ac0d4f290@oracle.com>

On Thu, Sep 18, 2025 at 01:55:03PM -0400, Anna Schumaker wrote:
> 
> 
> On 9/18/25 1:46 PM, Mike Snitzer wrote:
> > On Thu, Sep 18, 2025 at 01:33:30PM -0400, Anna Schumaker wrote:
> >> Hi Mike,
> >>
> >> On 9/17/25 2:18 PM, Mike Snitzer wrote:
> >>> Add nfs_local_dio_class and use it to create nfs_local_dio_read,
> >>> nfs_local_dio_write and nfs_local_dio_misaligned trace events.
> >>>
> >>> These trace events show how NFS LOCALIO splits a given misaligned
> >>> IO into a mix of misaligned head and/or tail extents and a DIO-aligned
> >>> middle extent.  The misaligned head and/or tail extents are issued
> >>> using buffered IO and the DIO-aligned middle is issued using O_DIRECT.
> >>>
> >>> This combination of trace events is useful for LOCALIO DIO READs:
> >>>
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_read/enable
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
> >>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
> >>>
> >>> This combination of trace events is useful for LOCALIO DIO WRITEs:
> >>>
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_write/enable
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
> >>>   echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
> >>>   echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
> >>
> >> I'm having a lot of trouble compiling this patch. I'm seeing errors like this:
> >>
> >>
> >> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
> >>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
> >>       | ^
> >> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
> >>  1796 |                  const struct nfs_local_dio *local_dio),\
> >>       |                               ^
> >> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
> >> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
> >>  1796 |                  const struct nfs_local_dio *local_dio),\
> >>       |                               ^
> >> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
> >> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
> >>  1796 |                  const struct nfs_local_dio *local_dio),\
> >>       |                               ^
> >> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
> >> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
> >>  1796 |                  const struct nfs_local_dio *local_dio),\
> >>       |                               ^
> >> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
> >> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
> >>  1796 |                  const struct nfs_local_dio *local_dio),\
> >>       |                               ^
> >> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
> >> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
> >>  1796 |                  const struct nfs_local_dio *local_dio),\
> >>       |                               ^
> >> fs/nfs/nfstrace.h:1800:1: error: declaration of 'struct nfs_local_dio' will not be visible outside of this function [-Werror,-Wvisibility]
> >> fs/nfs/nfstrace.h:1796:17: note: expanded from macro 'DEFINE_NFS_LOCAL_DIO_EVENT'
> >>  1796 |                  const struct nfs_local_dio *local_dio),\
> >>       |                               ^
> >> fs/nfs/nfstrace.h:1800:1: error: incompatible pointer types passing 'const struct nfs_local_dio *' to parameter of type 'const struct nfs_local_dio *' [-Werror,-Wincompatible-pointer-types]
> >>  1800 | DEFINE_NFS_LOCAL_DIO_EVENT(write);
> >>
> >>
> >> Am I missing a patch somewhere along the line?
> >>
> >> Thanks,
> >> Anna
> >>
> >>>
> >>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> >>> ---
> >>>  fs/nfs/internal.h | 10 +++++++
> >>>  fs/nfs/localio.c  | 19 ++++++-------
> >>>  fs/nfs/nfs3xdr.c  |  2 +-
> >>>  fs/nfs/nfstrace.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>  4 files changed, 89 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> >>> index d44233cfd7949..3d380c45b5ef3 100644
> >>> --- a/fs/nfs/internal.h
> >>> +++ b/fs/nfs/internal.h
> >>> @@ -456,6 +456,16 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
> >>>  
> >>>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> >>>  /* localio.c */
> >>> +struct nfs_local_dio {
> >>> +	u32 mem_align;
> >>> +	u32 offset_align;
> >>> +	loff_t middle_offset;
> >>> +	loff_t end_offset;
> >>> +	ssize_t	start_len;	/* Length for misaligned first extent */
> >>> +	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> >>> +	ssize_t	end_len;	/* Length for misaligned last extent */
> >>> +};
> >>> +
> >>>  extern void nfs_local_probe_async(struct nfs_client *);
> >>>  extern void nfs_local_probe_async_work(struct work_struct *);
> >>>  extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
> >>> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> >>> index 768af570183af..cf1533759646e 100644
> >>> --- a/fs/nfs/localio.c
> >>> +++ b/fs/nfs/localio.c
> >>> @@ -322,16 +322,6 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
> >>>  	return iocb;
> >>>  }
> >>>  
> >>> -struct nfs_local_dio {
> >>> -	u32 mem_align;
> >>> -	u32 offset_align;
> >>> -	loff_t middle_offset;
> >>> -	loff_t end_offset;
> >>> -	ssize_t	start_len;	/* Length for misaligned first extent */
> >>> -	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
> >>> -	ssize_t	end_len;	/* Length for misaligned last extent */
> >>> -};
> >>> -
> >>>  static bool
> >>>  nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
> >>>  			  size_t len, struct nfs_local_dio *local_dio)
> >>> @@ -367,6 +357,10 @@ nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
> >>>  	local_dio->middle_len = middle_end - start_end;
> >>>  	local_dio->end_len = orig_end - middle_end;
> >>>  
> >>> +	if (rw == ITER_DEST)
> >>> +		trace_nfs_local_dio_read(hdr->inode, offset, len, local_dio);
> >>> +	else
> >>> +		trace_nfs_local_dio_write(hdr->inode, offset, len, local_dio);
> >>>  	return true;
> >>>  }
> >>>  
> >>> @@ -446,8 +440,11 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
> >>>  		nfs_iov_iter_aligned_bvec(&iters[n_iters],
> >>>  			local_dio->mem_align-1, local_dio->offset_align-1);
> >>>  
> >>> -	if (unlikely(!iocb->iter_is_dio_aligned[n_iters]))
> >>> +	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
> >>> +		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
> >>> +			iocb->hdr->args.offset, len, local_dio);
> >>>  		return 0; /* no DIO-aligned IO possible */
> >>> +	}
> >>>  	++n_iters;
> >>>  
> >>>  	iocb->n_iters = n_iters;
> >>> diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> >>> index 4ae01c10b7e28..e17d729084125 100644
> >>> --- a/fs/nfs/nfs3xdr.c
> >>> +++ b/fs/nfs/nfs3xdr.c
> >>> @@ -23,8 +23,8 @@
> >>>  #include <linux/nfsacl.h>
> >>>  #include <linux/nfs_common.h>
> >>>  
> >>> -#include "nfstrace.h"
> >>>  #include "internal.h"
> >>> +#include "nfstrace.h"
> >>>  
> >>>  #define NFSDBG_FACILITY		NFSDBG_XDR
> >>>  
> > 
> > This change ^ was critical for fixing unknown type issues for 'struct
> > nfs_local_dio' issues on my build. But I haven't seen the issue you've
> > reported above. I'll try applying my changes on very latest upstream
> > tree.
> > 
> > Which tree/branch are you using for your baseline?  Also, which
> > version of gcc (which distro even) are you using?
> 
> I'm using my linux-next branch from: git.linux-nfs.org/projects/anna/linux-nfs.git.
> It's v6.17-rc6 plus the patches I'm planning for the next merge window.

Like I mentioned in another reply in this thread, I've pushed a tree
that is based on your linux-next branch here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=anna-linux-next-6.18

I've verified that this builds fine for me when using either:
EL8.10 with gcc 11.2.1-9
EL9.5 with 11.5.0-5

Which distro and gcc version are you using?

Thanks,
Mike


Return-Path: <linux-nfs+bounces-3677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2629049BA
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75651C2336D
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FF171C4;
	Wed, 12 Jun 2024 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oelF/STy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B002171AF
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718164208; cv=none; b=rKTfgKXECi7OjsjOQwOaWsPEYXhNSvbYkz8fRowkqdPmvVQQFKZMDUM2/ZbU86w+lMRW1zt5yB4Y2TklFDm1iH+qJ3jitQGWYXAz0ITwN4mvFzpwuPBdJWPwLmkH+rX6tmnnI+tMBvaVGyuGjlBT+KcEQSVRqIw/fbuK4mlWhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718164208; c=relaxed/simple;
	bh=EJcjUlGOSGdSnyRm1dEgo2zWPR2rH/FbeOTuXXg5SCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtN/MmTNgnMi4j/3Chom2Jzi56mjM1Pe100kv9m44+DiTWH6SwVKH9LnI83NRlXCBbxlGoYpoyFD2nr4lzJDC7u8KP5tzPEvJev3wFfRFfl8U4MI7aVjM1ocN0mv9OV8Uz+O3HFNZEL4CK0mEhG6N2BmofQlFORlbgX9hjdFGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oelF/STy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC643C32786;
	Wed, 12 Jun 2024 03:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718164208;
	bh=EJcjUlGOSGdSnyRm1dEgo2zWPR2rH/FbeOTuXXg5SCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oelF/STykecZipxcv02wSf8MQdX/npJncQGcqjcKtrq4vN78YwDzwcj0gbero0eiB
	 A9qCcws5Z9S/LYnzE71ai++uhjY22Skjun7urOJJtMLiRsHZw96xaRtv84rdkcFCeI
	 cQSxsxTTOqN+RJT6pYr9/Ftgl16DBalQ6pTGRZclfqLLwfV6AIc0uOU2fOlfPlGN7x
	 Q1u7nBmDKWcJuMAxyYsZR1AI8w+gskRtdHIAkzHIXmuGqNTyS6thCidtNQw2lNskfH
	 JMcGrd8n0DToIPQWLi/n/+L1+kzW/aleode13PApdgMqsSPirQEiMJ5ZTLBCk69QH1
	 JG9zY0wz/+4lA==
Date: Tue, 11 Jun 2024 23:50:06 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 05/15] nfs: move nfs_stat_to_errno to nfs.h
Message-ID: <Zmka7ggqYsmn94Dd@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
 <20240612030752.31754-6-snitzer@kernel.org>
 <171816263943.14261.9166283683437727145@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171816263943.14261.9166283683437727145@noble.neil.brown.name>

On Wed, Jun 12, 2024 at 01:23:59PM +1000, NeilBrown wrote:
> On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > From: Peng Tao <tao.peng@primarydata.com>
> > 
> > So that knfsd can use it to map nfs stat to sys errno as well.
> > 
> > Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/nfs2xdr.c    | 69 ---------------------------------------------
> >  include/linux/nfs.h | 63 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 63 insertions(+), 69 deletions(-)
> > 
> > diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> > index c19093814296..f7ef44829f6e 100644
> > --- a/fs/nfs/nfs2xdr.c
> > +++ b/fs/nfs/nfs2xdr.c
> > @@ -27,9 +27,6 @@
> >  
> >  #define NFSDBG_FACILITY		NFSDBG_XDR
> >  
> > -/* Mapping from NFS error code to "errno" error code. */
> > -#define errno_NFSERR_IO		EIO
> > -
> >  /*
> >   * Declare the space requirements for NFS arguments and replies as
> >   * number of 32bit-words
> > @@ -64,8 +61,6 @@
> >  #define NFS_readdirres_sz	(1+NFS_pagepad_sz)
> >  #define NFS_statfsres_sz	(1+NFS_info_sz)
> >  
> > -static int nfs_stat_to_errno(enum nfs_stat);
> > -
> >  /*
> >   * Encode/decode NFSv2 basic data types
> >   *
> > @@ -1054,70 +1049,6 @@ static int nfs2_xdr_dec_statfsres(struct rpc_rqst *req, struct xdr_stream *xdr,
> >  	return nfs_stat_to_errno(status);
> >  }
> >  
> > -
> > -/*
> > - * We need to translate between nfs status return values and
> > - * the local errno values which may not be the same.
> > - */
> > -static const struct {
> > -	int stat;
> > -	int errno;
> > -} nfs_errtbl[] = {
> 
> Will this array appear in every .o file that is compiled using this .h
> file? That doesn't seem like a good idea.

Ouch, sure looks like it would.  Nice catch.

Mike


> > -	{ NFS_OK,		0		},
> > -	{ NFSERR_PERM,		-EPERM		},
> > -	{ NFSERR_NOENT,		-ENOENT		},
> > -	{ NFSERR_IO,		-errno_NFSERR_IO},
> > -	{ NFSERR_NXIO,		-ENXIO		},
> > -/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> > -	{ NFSERR_ACCES,		-EACCES		},
> > -	{ NFSERR_EXIST,		-EEXIST		},
> > -	{ NFSERR_XDEV,		-EXDEV		},
> > -	{ NFSERR_NODEV,		-ENODEV		},
> > -	{ NFSERR_NOTDIR,	-ENOTDIR	},
> > -	{ NFSERR_ISDIR,		-EISDIR		},
> > -	{ NFSERR_INVAL,		-EINVAL		},
> > -	{ NFSERR_FBIG,		-EFBIG		},
> > -	{ NFSERR_NOSPC,		-ENOSPC		},
> > -	{ NFSERR_ROFS,		-EROFS		},
> > -	{ NFSERR_MLINK,		-EMLINK		},
> > -	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> > -	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> > -	{ NFSERR_DQUOT,		-EDQUOT		},
> > -	{ NFSERR_STALE,		-ESTALE		},
> > -	{ NFSERR_REMOTE,	-EREMOTE	},
> > -#ifdef EWFLUSH
> > -	{ NFSERR_WFLUSH,	-EWFLUSH	},
> > -#endif
> > -	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> > -	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> > -	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> > -	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> > -	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> > -	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> > -	{ NFSERR_BADTYPE,	-EBADTYPE	},
> > -	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> > -	{ -1,			-EIO		}
> > -};
> > -
> > -/**
> > - * nfs_stat_to_errno - convert an NFS status code to a local errno
> > - * @status: NFS status code to convert
> > - *
> > - * Returns a local errno value, or -EIO if the NFS status code is
> > - * not recognized.  This function is used jointly by NFSv2 and NFSv3.
> > - */
> > -static int nfs_stat_to_errno(enum nfs_stat status)
> > -{
> > -	int i;
> > -
> > -	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
> > -		if (nfs_errtbl[i].stat == (int)status)
> > -			return nfs_errtbl[i].errno;
> > -	}
> > -	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
> > -	return nfs_errtbl[i].errno;
> > -}
> > -
> >  #define PROC(proc, argtype, restype, timer)				\
> >  [NFSPROC_##proc] = {							\
> >  	.p_proc	    =  NFSPROC_##proc,					\
> > diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> > index ceb70a926b95..b94f51d17bc5 100644
> > --- a/include/linux/nfs.h
> > +++ b/include/linux/nfs.h
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/sunrpc/msg_prot.h>
> >  #include <linux/string.h>
> > +#include <linux/errno.h>
> >  #include <linux/crc32.h>
> >  #include <uapi/linux/nfs.h>
> >  
> > @@ -46,6 +47,68 @@ enum nfs3_stable_how {
> >  	NFS_INVALID_STABLE_HOW = -1
> >  };
> >  
> > +/*
> > + * We need to translate between nfs status return values and
> > + * the local errno values which may not be the same.
> > + */
> > +static const struct {
> > +	int stat;
> > +	int errno;
> > +} nfs_common_errtbl[] = {
> > +	{ NFS_OK,		0		},
> > +	{ NFSERR_PERM,		-EPERM		},
> > +	{ NFSERR_NOENT,		-ENOENT		},
> > +	{ NFSERR_IO,		-EIO		},
> > +	{ NFSERR_NXIO,		-ENXIO		},
> > +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> > +	{ NFSERR_ACCES,		-EACCES		},
> > +	{ NFSERR_EXIST,		-EEXIST		},
> > +	{ NFSERR_XDEV,		-EXDEV		},
> > +	{ NFSERR_NODEV,		-ENODEV		},
> > +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> > +	{ NFSERR_ISDIR,		-EISDIR		},
> > +	{ NFSERR_INVAL,		-EINVAL		},
> > +	{ NFSERR_FBIG,		-EFBIG		},
> > +	{ NFSERR_NOSPC,		-ENOSPC		},
> > +	{ NFSERR_ROFS,		-EROFS		},
> > +	{ NFSERR_MLINK,		-EMLINK		},
> > +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> > +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> > +	{ NFSERR_DQUOT,		-EDQUOT		},
> > +	{ NFSERR_STALE,		-ESTALE		},
> > +	{ NFSERR_REMOTE,	-EREMOTE	},
> > +#ifdef EWFLUSH
> > +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> > +#endif
> > +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> > +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> > +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> > +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> > +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> > +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> > +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> > +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> > +	{ -1,			-EIO		}
> > +};
> > +
> > +/**
> > + * nfs_stat_to_errno - convert an NFS status code to a local errno
> > + * @status: NFS status code to convert
> > + *
> > + * Returns a local errno value, or -EIO if the NFS status code is
> > + * not recognized.  This function is used jointly by NFSv2 and NFSv3.
> > + */
> > +static inline int nfs_stat_to_errno(enum nfs_stat status)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
> > +		if (nfs_common_errtbl[i].stat == (int)status)
> > +			return nfs_common_errtbl[i].errno;
> > +	}
> > +	return nfs_common_errtbl[i].errno;
> > +}
> > +
> >  #ifdef CONFIG_CRC32
> >  /**
> >   * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
> > -- 
> > 2.44.0
> > 
> > 
> 
> 


Return-Path: <linux-nfs+bounces-3675-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179AD90499E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB324285D7D
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404117C77;
	Wed, 12 Jun 2024 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z8n9Fy6g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WwCMbotB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z8n9Fy6g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WwCMbotB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1845210E6
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162653; cv=none; b=iFHwZB9ZeKcEr9gIOQVRS54mMx2oQ0mHWIlRdH8FFbvUeboxay0S5UFOh4veJd/yrlk/KqeK3VS6fd4iHU01fI/df8bUHYqQMk+mBbPbZctpazWdMCKpVgCBKQYUiolKOYO0TadTSavQU03l9YPZr+VG2H4GMCde5IhzoROLFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162653; c=relaxed/simple;
	bh=My28Zn2RBfMerHklJnC3WxrUMGiY8M5RD5FBHfM9YeQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aJnTvUKpZfuaKikszMGY1uafB4qqBSzCx/vlr7hcH0E9q4hP8VswmWY/Rr5vSGyZvPYC21J3kxACjpiGMw42XtOV5+/r8vf53mYPf7JX9lu+BjjZmWO3eWLduC+YrBBjRgKrD+4WVtZdrVSKgl0HgZTe536q2n/A2pFpNqrMC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z8n9Fy6g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WwCMbotB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z8n9Fy6g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WwCMbotB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCEE620E96;
	Wed, 12 Jun 2024 03:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718162649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E77Zsd/NrrEZWbR0Pr7ZA0G/40uc8LSVHigO1qhzfus=;
	b=Z8n9Fy6gBFqN1vkFV6zrV8/QqISj5ojnh2CWaedCWC2TFV8Dnt9MTCLhRRTfd2tDeX1Ytq
	PqJMjvKPiXozA8F1upnMC1Vfaeh2aGfkr6TcdQVFXThieGxNkdMLzgYeDFOdJzWsiOBX6D
	Ys2M9lzQQvhkhGuSZ7TgFaLBAQmRt4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718162649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E77Zsd/NrrEZWbR0Pr7ZA0G/40uc8LSVHigO1qhzfus=;
	b=WwCMbotBBud7OqWAQ+GGSoevUQCuGVLOJqty4Z2mwjEAGpRpg7ajy1EyOnIqeWJNjZ6jGH
	K8A9VIU/7FqhyXAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718162649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E77Zsd/NrrEZWbR0Pr7ZA0G/40uc8LSVHigO1qhzfus=;
	b=Z8n9Fy6gBFqN1vkFV6zrV8/QqISj5ojnh2CWaedCWC2TFV8Dnt9MTCLhRRTfd2tDeX1Ytq
	PqJMjvKPiXozA8F1upnMC1Vfaeh2aGfkr6TcdQVFXThieGxNkdMLzgYeDFOdJzWsiOBX6D
	Ys2M9lzQQvhkhGuSZ7TgFaLBAQmRt4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718162649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E77Zsd/NrrEZWbR0Pr7ZA0G/40uc8LSVHigO1qhzfus=;
	b=WwCMbotBBud7OqWAQ+GGSoevUQCuGVLOJqty4Z2mwjEAGpRpg7ajy1EyOnIqeWJNjZ6jGH
	K8A9VIU/7FqhyXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2360D137DF;
	Wed, 12 Jun 2024 03:24:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gvyaLdYUaWZ2EAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 03:24:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [RFC PATCH v2 05/15] nfs: move nfs_stat_to_errno to nfs.h
In-reply-to: <20240612030752.31754-6-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>,
 <20240612030752.31754-6-snitzer@kernel.org>
Date: Wed, 12 Jun 2024 13:23:59 +1000
Message-id: <171816263943.14261.9166283683437727145@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.875];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[primarydata.com:email,imap1.dmz-prg2.suse.org:helo,hammerspace.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.27
X-Spam-Level: 

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> From: Peng Tao <tao.peng@primarydata.com>
>=20
> So that knfsd can use it to map nfs stat to sys errno as well.
>=20
> Signed-off-by: Peng Tao <tao.peng@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/nfs2xdr.c    | 69 ---------------------------------------------
>  include/linux/nfs.h | 63 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 69 deletions(-)
>=20
> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> index c19093814296..f7ef44829f6e 100644
> --- a/fs/nfs/nfs2xdr.c
> +++ b/fs/nfs/nfs2xdr.c
> @@ -27,9 +27,6 @@
> =20
>  #define NFSDBG_FACILITY		NFSDBG_XDR
> =20
> -/* Mapping from NFS error code to "errno" error code. */
> -#define errno_NFSERR_IO		EIO
> -
>  /*
>   * Declare the space requirements for NFS arguments and replies as
>   * number of 32bit-words
> @@ -64,8 +61,6 @@
>  #define NFS_readdirres_sz	(1+NFS_pagepad_sz)
>  #define NFS_statfsres_sz	(1+NFS_info_sz)
> =20
> -static int nfs_stat_to_errno(enum nfs_stat);
> -
>  /*
>   * Encode/decode NFSv2 basic data types
>   *
> @@ -1054,70 +1049,6 @@ static int nfs2_xdr_dec_statfsres(struct rpc_rqst *r=
eq, struct xdr_stream *xdr,
>  	return nfs_stat_to_errno(status);
>  }
> =20
> -
> -/*
> - * We need to translate between nfs status return values and
> - * the local errno values which may not be the same.
> - */
> -static const struct {
> -	int stat;
> -	int errno;
> -} nfs_errtbl[] =3D {

Will this array appear in every .o file that is compiled using this .h
file? That doesn't seem like a good idea.

NeilBrown


> -	{ NFS_OK,		0		},
> -	{ NFSERR_PERM,		-EPERM		},
> -	{ NFSERR_NOENT,		-ENOENT		},
> -	{ NFSERR_IO,		-errno_NFSERR_IO},
> -	{ NFSERR_NXIO,		-ENXIO		},
> -/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> -	{ NFSERR_ACCES,		-EACCES		},
> -	{ NFSERR_EXIST,		-EEXIST		},
> -	{ NFSERR_XDEV,		-EXDEV		},
> -	{ NFSERR_NODEV,		-ENODEV		},
> -	{ NFSERR_NOTDIR,	-ENOTDIR	},
> -	{ NFSERR_ISDIR,		-EISDIR		},
> -	{ NFSERR_INVAL,		-EINVAL		},
> -	{ NFSERR_FBIG,		-EFBIG		},
> -	{ NFSERR_NOSPC,		-ENOSPC		},
> -	{ NFSERR_ROFS,		-EROFS		},
> -	{ NFSERR_MLINK,		-EMLINK		},
> -	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> -	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> -	{ NFSERR_DQUOT,		-EDQUOT		},
> -	{ NFSERR_STALE,		-ESTALE		},
> -	{ NFSERR_REMOTE,	-EREMOTE	},
> -#ifdef EWFLUSH
> -	{ NFSERR_WFLUSH,	-EWFLUSH	},
> -#endif
> -	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> -	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> -	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> -	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> -	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> -	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> -	{ NFSERR_BADTYPE,	-EBADTYPE	},
> -	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> -	{ -1,			-EIO		}
> -};
> -
> -/**
> - * nfs_stat_to_errno - convert an NFS status code to a local errno
> - * @status: NFS status code to convert
> - *
> - * Returns a local errno value, or -EIO if the NFS status code is
> - * not recognized.  This function is used jointly by NFSv2 and NFSv3.
> - */
> -static int nfs_stat_to_errno(enum nfs_stat status)
> -{
> -	int i;
> -
> -	for (i =3D 0; nfs_errtbl[i].stat !=3D -1; i++) {
> -		if (nfs_errtbl[i].stat =3D=3D (int)status)
> -			return nfs_errtbl[i].errno;
> -	}
> -	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
> -	return nfs_errtbl[i].errno;
> -}
> -
>  #define PROC(proc, argtype, restype, timer)				\
>  [NFSPROC_##proc] =3D {							\
>  	.p_proc	    =3D  NFSPROC_##proc,					\
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index ceb70a926b95..b94f51d17bc5 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -10,6 +10,7 @@
> =20
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/string.h>
> +#include <linux/errno.h>
>  #include <linux/crc32.h>
>  #include <uapi/linux/nfs.h>
> =20
> @@ -46,6 +47,68 @@ enum nfs3_stable_how {
>  	NFS_INVALID_STABLE_HOW =3D -1
>  };
> =20
> +/*
> + * We need to translate between nfs status return values and
> + * the local errno values which may not be the same.
> + */
> +static const struct {
> +	int stat;
> +	int errno;
> +} nfs_common_errtbl[] =3D {
> +	{ NFS_OK,		0		},
> +	{ NFSERR_PERM,		-EPERM		},
> +	{ NFSERR_NOENT,		-ENOENT		},
> +	{ NFSERR_IO,		-EIO		},
> +	{ NFSERR_NXIO,		-ENXIO		},
> +/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
> +	{ NFSERR_ACCES,		-EACCES		},
> +	{ NFSERR_EXIST,		-EEXIST		},
> +	{ NFSERR_XDEV,		-EXDEV		},
> +	{ NFSERR_NODEV,		-ENODEV		},
> +	{ NFSERR_NOTDIR,	-ENOTDIR	},
> +	{ NFSERR_ISDIR,		-EISDIR		},
> +	{ NFSERR_INVAL,		-EINVAL		},
> +	{ NFSERR_FBIG,		-EFBIG		},
> +	{ NFSERR_NOSPC,		-ENOSPC		},
> +	{ NFSERR_ROFS,		-EROFS		},
> +	{ NFSERR_MLINK,		-EMLINK		},
> +	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
> +	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
> +	{ NFSERR_DQUOT,		-EDQUOT		},
> +	{ NFSERR_STALE,		-ESTALE		},
> +	{ NFSERR_REMOTE,	-EREMOTE	},
> +#ifdef EWFLUSH
> +	{ NFSERR_WFLUSH,	-EWFLUSH	},
> +#endif
> +	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
> +	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
> +	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
> +	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
> +	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
> +	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
> +	{ NFSERR_BADTYPE,	-EBADTYPE	},
> +	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
> +	{ -1,			-EIO		}
> +};
> +
> +/**
> + * nfs_stat_to_errno - convert an NFS status code to a local errno
> + * @status: NFS status code to convert
> + *
> + * Returns a local errno value, or -EIO if the NFS status code is
> + * not recognized.  This function is used jointly by NFSv2 and NFSv3.
> + */
> +static inline int nfs_stat_to_errno(enum nfs_stat status)
> +{
> +	int i;
> +
> +	for (i =3D 0; nfs_common_errtbl[i].stat !=3D -1; i++) {
> +		if (nfs_common_errtbl[i].stat =3D=3D (int)status)
> +			return nfs_common_errtbl[i].errno;
> +	}
> +	return nfs_common_errtbl[i].errno;
> +}
> +
>  #ifdef CONFIG_CRC32
>  /**
>   * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
> --=20
> 2.44.0
>=20
>=20



Return-Path: <linux-nfs+bounces-14151-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9FB5090D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50937B7719
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0D280CC8;
	Tue,  9 Sep 2025 23:07:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FB2571A5
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757459252; cv=none; b=rTR67s3AQ0L5MtX6qIDqBLvorf+/q4/fg/CJ5ebGhXmyfqbgf0Cra284JIuhyKrevJJ+Fnz1Exl9ykOZmG2pK5IJxqTKzUzx0gwQMW3ga5IZ7gJlBy1pOjTr+a7ZWcaKJ7Oseb00zrCca/IGSIUYDoDaVw/f1BQ69ID8dqvtUaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757459252; c=relaxed/simple;
	bh=SEW7Eqp72Zx+vZLbrSugNDVWf7v1QekG3ZiHgiO2gNI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pa4FOuAHgQ2mFicE1nLhV37eyqjUb6BZ3fYjBzsdRakTlqHIDljv2+7mPoOURRe/JpESgORz3BhrT8PP+MsM17TZ2ZrjvFNhMDfe/C27gynjB5l1iTJ6YI/yL8PDzsWQSjXPwTdLNXZvk3ONGUX8j1Adk0Xwvpd87PI8/tJNs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uw7Qj-008sid-Gg;
	Tue, 09 Sep 2025 23:07:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v1 1/3] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
In-reply-to: <20250909190525.7214-2-cel@kernel.org>
References: <20250909190525.7214-1-cel@kernel.org>,
 <20250909190525.7214-2-cel@kernel.org>
Date: Wed, 10 Sep 2025 09:07:17 +1000
Message-id: <175745923799.2850467.5243518123624170237@noble.neil.brown.name>

On Wed, 10 Sep 2025, Chuck Lever wrote:

> +static __be32
> +nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)

<bikeshed>
 should this function have a name which reflects the fact that it is
 getting the dio attrs, not all attrs?
 e.h. nfsd_file_get_dio_attr()
 ....

> @@ -1166,6 +1198,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct n=
et *net,
>  			}
>  			status =3D nfserrno(ret);
>  			trace_nfsd_file_open(nf, status);
> +			if (status =3D=3D nfs_ok)
> +				status =3D nfsd_file_getattr(fhp, nf);
>  		}

I ask because this stanza looks strange. "Why are the file attrs being
got here?" I ask.  Oh, it is really getting the dio attrs - that makes
sense.

</bikeshed>

Thanks,
NeilBrown


>  	} else
>  		status =3D nfserr_jukebox;
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 24ddf60e8434..e3d6ca2b6030 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -54,6 +54,10 @@ struct nfsd_file {
>  	struct list_head	nf_gc;
>  	struct rcu_head		nf_rcu;
>  	ktime_t			nf_birthtime;
> +
> +	u32			nf_dio_mem_align;
> +	u32			nf_dio_offset_align;
> +	u32			nf_dio_read_offset_align;
>  };
> =20
>  int nfsd_file_cache_init(void);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 3edccc38db42..3eb724ec9566 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -696,8 +696,12 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kst=
at *stat)
>  		.mnt		=3D fhp->fh_export->ex_path.mnt,
>  		.dentry		=3D fhp->fh_dentry,
>  	};
> +	struct inode *inode =3D d_inode(p.dentry);
>  	u32 request_mask =3D STATX_BASIC_STATS;
> =20
> +	if (S_ISREG(inode->i_mode))
> +		request_mask |=3D (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
> +
>  	if (fhp->fh_maxsize =3D=3D NFS4_FHSIZE)
>  		request_mask |=3D (STATX_BTIME | STATX_CHANGE_COOKIE);
> =20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index a664fdf1161e..e5af0d058fd0 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1133,6 +1133,33 @@ TRACE_EVENT(nfsd_file_alloc,
>  	)
>  );
> =20
> +TRACE_EVENT(nfsd_file_getattr,
> +	TP_PROTO(
> +		const struct inode *inode,
> +		const struct kstat *stat
> +	),
> +	TP_ARGS(inode, stat),
> +	TP_STRUCT__entry(
> +		__field(const void *, inode)
> +		__field(unsigned long, mask)
> +		__field(u32, mem_align)
> +		__field(u32, offset_align)
> +		__field(u32, read_offset_align)
> +	),
> +	TP_fast_assign(
> +		__entry->inode =3D inode;
> +		__entry->mask =3D stat->result_mask;
> +		__entry->mem_align =3D stat->dio_mem_align;
> +		__entry->offset_align =3D stat->dio_offset_align;
> +		__entry->read_offset_align =3D stat->dio_read_offset_align;
> +	),
> +	TP_printk("inode=3D%p flags=3D%s mem_align=3D%u offset_align=3D%u read_of=
fset_align=3D%u",
> +		__entry->inode, show_statx_mask(__entry->mask),
> +		__entry->mem_align, __entry->offset_align,
> +		__entry->read_offset_align
> +	)
> +);
> +
>  TRACE_EVENT(nfsd_file_acquire,
>  	TP_PROTO(
>  		const struct svc_rqst *rqstp,
> diff --git a/include/trace/misc/fs.h b/include/trace/misc/fs.h
> index 0406ebe2a80a..7ead1c61f0cb 100644
> --- a/include/trace/misc/fs.h
> +++ b/include/trace/misc/fs.h
> @@ -141,3 +141,25 @@
>  		{ ATTR_TIMES_SET,	"TIMES_SET" },	\
>  		{ ATTR_TOUCH,		"TOUCH"},	\
>  		{ ATTR_DELEG,		"DELEG"})
> +
> +#define show_statx_mask(flags)					\
> +	__print_flags(flags, "|",				\
> +		{ STATX_TYPE,		"TYPE" },		\
> +		{ STATX_MODE,		"MODE" },		\
> +		{ STATX_NLINK,		"NLINK" },		\
> +		{ STATX_UID,		"UID" },		\
> +		{ STATX_GID,		"GID" },		\
> +		{ STATX_ATIME,		"ATIME" },		\
> +		{ STATX_MTIME,		"MTIME" },		\
> +		{ STATX_CTIME,		"CTIME" },		\
> +		{ STATX_INO,		"INO" },		\
> +		{ STATX_SIZE,		"SIZE" },		\
> +		{ STATX_BLOCKS,		"BLOCKS" },		\
> +		{ STATX_BASIC_STATS,	"BASIC_STATS" },	\
> +		{ STATX_BTIME,		"BTIME" },		\
> +		{ STATX_MNT_ID,		"MNT_ID" },		\
> +		{ STATX_DIOALIGN,	"DIOALIGN" },		\
> +		{ STATX_MNT_ID_UNIQUE,	"MNT_ID_UNIQUE" },	\
> +		{ STATX_SUBVOL,		"SUBVOL" },		\
> +		{ STATX_WRITE_ATOMIC,	"WRITE_ATOMIC" },	\
> +		{ STATX_DIO_READ_ALIGN,	"DIO_READ_ALIGN" })
> --=20
> 2.50.0
>=20
>=20



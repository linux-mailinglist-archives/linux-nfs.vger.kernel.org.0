Return-Path: <linux-nfs+bounces-14535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82D8B823E6
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7F03B7162
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6DE2F3C36;
	Wed, 17 Sep 2025 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="bEaorG0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRI7Zcgb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4820370B
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150644; cv=none; b=jwCaEv7yn1y9IalazzyY6ZKWtwxInQP+hl9sMCE1TNnYLF3XOFkUeovckZwQyPpWM9etTbuW/BUQOg9TQnqu6BGWwEXPFHOTHZRYFl+/lQjaLXub4LABrnk+FkQ2qFj1rKHLgk4RBL0MDpFge4TpNT3ltuXFiqCEp5sRv3x1ZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150644; c=relaxed/simple;
	bh=yK4n9RQBAdlHhekUIO+sXjaLJqZwVq3njGnV/2gnM44=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZDUg8TJs+4XuPtzovlNAZ8xD8MTn8gI8KooxF2vqdqeBZFtw52dC0qi/oM9CDmo78VnBgZNOmunlX1xZLmmLYutZ+lr4AvukUawxvTTGFGiIkoAhHjIRauAsGaxcW/LSkquIgHkg5dT08oELqlj+rxW9+oS6j/GiIBs1AuiOggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bEaorG0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRI7Zcgb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 25562EC02C1;
	Wed, 17 Sep 2025 19:10:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 17 Sep 2025 19:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758150640; x=1758237040; bh=ih9j2xMqcFZUVxBbsO+nOBLIPSEIvWig9IP
	V46xA4QM=; b=bEaorG0lNG0idbLkxO1V1BRJaD1Z+Af6eCFmoXRlPMZurSqxgHl
	1Kb6+E4IlOhp4xBroYGuBVmbyaKNPrlE8oUiNMdihY+iVBPaH2StMrsuyiCAMLH8
	xcvuJ0NjojQtuwocgckTpb3bJx5jVBvQRQ9dK4vtwqVScgFboZXx1Ds5IeiAk0fB
	4Ton0xYO/9DIlq2LiFdqIPLDeI2C+ezVJffFC1zRDzALujjSnFkMZBwrF42LUhLQ
	JwrGlUFVCnMUWobYABEU8SPAxkFt14VCS3p3iimTv4ULn72x1JbsbL7do3aJOCPB
	kiF26bdoCd1nih/3VKK/gn3bLJT1xhXXBSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758150640; x=
	1758237040; bh=ih9j2xMqcFZUVxBbsO+nOBLIPSEIvWig9IPV46xA4QM=; b=g
	RI7ZcgbOx7DHlIzcv1dLQlSat7rwp1TCwvBQn6rx+dWNl2AxXZTtw7ZdbIWE+/PK
	r/GiClJvbQCnedHso7t47i3XMMqun370KzL8Rtqj8Olzcg9VEihyT8CFFd/1qgYu
	sMBaPHNybNi+Ra6scS/L5dSKywhT1ycddN6Od21jTGs7VAg2hT7fN5t9jJld41Ib
	Y+pHrPK/CfFIZc1/0E6/WRO2Au/+5+M8kgIdk1FO0DhcE52u1x72fROuaBv3lKvI
	Bp540GaW9tcZzzlzDP1hnInkKCssCYh1+m0flXObqg2qzvcZOz2gQXkZeoM78zu8
	xVYq9zEEVWhb9l7lKMuzg==
X-ME-Sender: <xms:7z_LaL7WyyAtO8WJyMFKei0NdF0VAKyMSmj6BFGj-xjIwprbr9YloA>
    <xme:7z_LaJV9pB0BWRfGJpD3U7GWedD9mHht7j5WG2M5Q1ZRttuXHZvxPI0MBirEbosuq
    NiWh2uBYXiQUw>
X-ME-Received: <xmr:7z_LaC7GJkd-yXP6JoImG0lQDgQxskXGbgwsbJNyW4CPQ54AQzeAA040ikLdBAkyZ478Om7UucbUdl3zoJ1-ZmEOuN-pow9HeemC-VNlhzjy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptgfgggfhvfevufgjfhffkfhrsehtqhertd
    dttdejnecuhfhrohhmpefpvghilheurhhofihnuceonhgvihhlsgesohifnhhmrghilhdr
    nhgvtheqnecuggftrfgrthhtvghrnhepleejtdefgeeukeeiteduveehudevfeffvedute
    fgteduhfegvdfgtdeigeeuudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghrtghpth
    htohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhfshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgvhidrtg
    homhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7z_LaMqEbR4aage95WVK96oJBP2h2UYYqOetLF4Drz9hHp-kSn6w5w>
    <xmx:7z_LaNkkV39s0gUACnF7n3RteI0EHyhaI9NerRAky0ajq3EBHO9e6Q>
    <xmx:7z_LaAMdSrcAXdSyeVTjsMp81Hl493QNqBSFxJTq4e2wFbhCDSgQTA>
    <xmx:7z_LaJMQMfhD725Ke-QyJ4756vHzFf5bQ0d0Yo3vm_SqKh2YX7_bEw>
    <xmx:8D_LaJHjdyHXeXaEhnBeIi6MJLgmyFeHz-3MKlH4laN0yf5ioSKNBYqk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 19:10:37 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: jlayton@kernel.org, okorniev@redhat.com, dai.ngo@oracle.com,
 tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/4] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
In-reply-to: =?utf-8?q?=3C175811950708=2E19474=2E3966708920934397510=2Estgit?=
 =?utf-8?q?=4091=2E116=2E238=2E104=2Ehost=2Esecureserver=2Enet=3E?=
References: =?utf-8?q?=3C175811882632=2E19474=2E8126763744508709520=2Estgit?=
 =?utf-8?b?QDkxLjExNi4yMzguMTA0Lmhvc3Quc2VjdXJlc2VydmVyLm5ldD4sIDwxNzU4?=
 =?utf-8?q?11950708=2E19474=2E3966708920934397510=2Estgit=4091=2E116=2E238?=
 =?utf-8?q?=2E104=2Ehost=2Esecureserver=2Enet=3E?=
Date: Thu, 18 Sep 2025 09:10:34 +1000
Message-id: <175815063429.1696783.10619003048352606681@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 18 Sep 2025, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
>=20
> Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get DIO alignment
> attributes from the underlying filesystem and store them in the
> associated nfsd_file. This is done when the nfsd_file is first
> opened for each regular file.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c     |   34 ++++++++++++++++++++++++++++++++++
>  fs/nfsd/filecache.h     |    4 ++++
>  fs/nfsd/nfsfh.c         |    4 ++++
>  fs/nfsd/trace.h         |   27 +++++++++++++++++++++++++++
>  include/trace/misc/fs.h |   22 ++++++++++++++++++++++
>  5 files changed, 91 insertions(+)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 75bc48031c07..78cca0d751ac 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -231,6 +231,9 @@ nfsd_file_alloc(struct net *net, struct inode *inode, u=
nsigned char need,
>  	refcount_set(&nf->nf_ref, 1);
>  	nf->nf_may =3D need;
>  	nf->nf_mark =3D NULL;
> +	nf->nf_dio_mem_align =3D 0;
> +	nf->nf_dio_offset_align =3D 0;
> +	nf->nf_dio_read_offset_align =3D 0;
>  	return nf;
>  }
> =20
> @@ -1048,6 +1051,35 @@ nfsd_file_is_cached(struct inode *inode)
>  	return ret;
>  }
> =20
> +static __be32
> +nfsd_file_get_dio_attrs(const struct svc_fh *fhp, struct nfsd_file *nf)
> +{
> +	struct inode *inode =3D file_inode(nf->nf_file);
> +	struct kstat stat;
> +	__be32 status;
> +
> +	/* Currently only need to get DIO alignment info for regular files */
> +	if (!S_ISREG(inode->i_mode))
> +		return nfs_ok;
> +
> +	status =3D fh_getattr(fhp, &stat);
> +	if (status !=3D nfs_ok)
> +		return status;
> +
> +	trace_nfsd_file_get_dio_attrs(inode, &stat);
> +
> +	if (stat.result_mask & STATX_DIOALIGN) {
> +		nf->nf_dio_mem_align =3D stat.dio_mem_align;
> +		nf->nf_dio_offset_align =3D stat.dio_offset_align;
> +	}
> +	if (stat.result_mask & STATX_DIO_READ_ALIGN)
> +		nf->nf_dio_read_offset_align =3D stat.dio_read_offset_align;
> +	else
> +		nf->nf_dio_read_offset_align =3D nf->nf_dio_offset_align;
> +
> +	return nfs_ok;
> +}
> +
>  static __be32
>  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>  		     struct svc_cred *cred,
> @@ -1166,6 +1198,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct n=
et *net,
>  			}
>  			status =3D nfserrno(ret);
>  			trace_nfsd_file_open(nf, status);
> +			if (status =3D=3D nfs_ok)
> +				status =3D nfsd_file_get_dio_attrs(fhp, nf);
>  		}
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

As an aside - you could use "d_is_reg(p.dentry)" and not need the inode.
It's not worth changing though.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> +
>  	if (fhp->fh_maxsize =3D=3D NFS4_FHSIZE)
>  		request_mask |=3D (STATX_BTIME | STATX_CHANGE_COOKIE);
> =20
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index a664fdf1161e..6e2c8e2aab10 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1133,6 +1133,33 @@ TRACE_EVENT(nfsd_file_alloc,
>  	)
>  );
> =20
> +TRACE_EVENT(nfsd_file_get_dio_attrs,
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
>=20
>=20
>=20



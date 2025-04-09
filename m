Return-Path: <linux-nfs+bounces-11073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F685A82CD4
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D6F44092B
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906A21129A;
	Wed,  9 Apr 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6+/TBs+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1E1DFFD;
	Wed,  9 Apr 2025 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217446; cv=none; b=PwB85qQu+df5kJXUa+xFjyEOGBakDoQ1UDEN+AWspAs1II1UmO8x0FnIDDEzVq8rXiKL9H8jmIe8FKsg/sJqt7LFwTuMj9nJSByUka7JppVKW/1RA7Zlx6i9GvNZsoqpRhdvXZ1myDFASh8IW8yZnADJL1i+70hvyEkLKji3yYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217446; c=relaxed/simple;
	bh=nlvwShOKMLmPkS6eZAmtTpvD+/C/2YPLZjUsWtXhxBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVfxc/MoPTl9gmF5seaXAAlwmY8dvcWL83ALH1GEn1x1soc9PAqIAxYRfjUIvoF0tGjry+MNJDDzANC0Q0ZBMBe1rPIBkoTL4exRomc1utVMtRAuGycz+LPsewyUTbcPseHoMuzY/0GtM0JQuNwMUAmrjf6wOKx2fM8/q+Ez+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6+/TBs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E058AC4CEE2;
	Wed,  9 Apr 2025 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744217445;
	bh=nlvwShOKMLmPkS6eZAmtTpvD+/C/2YPLZjUsWtXhxBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a6+/TBs+85tva7Bxr6WQGfRYT+i8nSV0Zz94xGvtuInNM2zoLUZCrnInkJLqDY7wp
	 YQYQkcL/kxgGjlsBEujyJP4IZuOsRYdmsuNnkvTe97vZh3Lmm/BHbk/lT+jo7R3i7J
	 IoA+idnRrnVWZoB6go0qWfnpXl5xBOYCYjUweO+gnfljemOWRzyig4Xdp4SN1pY8R5
	 zApZT4+lrJ2HukSuVy+UUMXzrRchhEBbbVXixO4YGlLFsJWoEab8+jFU+9NCD3SLpt
	 a/DOq8lU4SU67odW0gPF+mBKyVDqoXOIxch68MNC2Agu1h6Hetqf91csKmHCDiME+m
	 JaO5x7+kj3QVg==
Message-ID: <df78d9806222676667eac8cee4b5ce26ba0e7e10.camel@kernel.org>
Subject: Re: [PATCH v2 06/12] nfsd: add tracepoints around nfsd_create events
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 09 Apr 2025 12:50:43 -0400
In-Reply-To: <078a639b-1f19-48e2-a0cc-f861b67f34c9@oracle.com>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
	 <20250409-nfsd-tracepoints-v2-6-cf4e084fdd9c@kernel.org>
	 <078a639b-1f19-48e2-a0cc-f861b67f34c9@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 11:09 -0400, Chuck Lever wrote:
> On 4/9/25 10:32 AM, Jeff Layton wrote:
> > ...and remove the legacy dprintks.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs3proc.c | 18 +++++-------------
> >  fs/nfsd/nfs4proc.c | 29 +++++++++++++++++++++++++++++
> >  fs/nfsd/nfsproc.c  |  6 +++---
> >  fs/nfsd/trace.h    | 39 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 76 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..ea1280970ea11b2a82f0de8=
8ad0422eef7063d6d 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -14,6 +14,7 @@
> >  #include "xdr3.h"
> >  #include "vfs.h"
> >  #include "filecache.h"
> > +#include "trace.h"
> > =20
> >  #define NFSDDBG_FACILITY		NFSDDBG_PROC
> > =20
> > @@ -380,10 +381,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
> >  	struct nfsd3_diropres *resp =3D rqstp->rq_resp;
> >  	svc_fh *dirfhp, *newfhp;
> > =20
> > -	dprintk("nfsd: CREATE(3)   %s %.*s\n",
> > -				SVCFH_fmt(&argp->fh),
> > -				argp->len,
> > -				argp->name);
> > +	trace_nfsd3_proc_create(rqstp, &argp->fh, S_IFREG, argp->name, argp->=
len);
> > =20
> >  	dirfhp =3D fh_copy(&resp->dirfh, &argp->fh);
> >  	newfhp =3D fh_init(&resp->fh, NFS3_FHSIZE);
> > @@ -405,10 +403,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
> >  		.na_iattr	=3D &argp->attrs,
> >  	};
> > =20
> > -	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
> > -				SVCFH_fmt(&argp->fh),
> > -				argp->len,
> > -				argp->name);
> > +	trace_nfsd3_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->l=
en);
> > =20
> >  	argp->attrs.ia_valid &=3D ~ATTR_SIZE;
> >  	fh_copy(&resp->dirfh, &argp->fh);
> > @@ -471,13 +466,10 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
> >  	struct nfsd_attrs attrs =3D {
> >  		.na_iattr	=3D &argp->attrs,
> >  	};
> > -	int type;
> > +	int type =3D nfs3_ftypes[argp->ftype];
> >  	dev_t	rdev =3D 0;
> > =20
> > -	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
> > -				SVCFH_fmt(&argp->fh),
> > -				argp->len,
> > -				argp->name);
> > +	trace_nfsd3_proc_mknod(rqstp, &argp->fh, type, argp->name, argp->len)=
;
> > =20
> >  	fh_copy(&resp->dirfh, &argp->fh);
> >  	fh_init(&resp->fh, NFS3_FHSIZE);
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 6e23d6103010197c0316b07c189fe12ec3033812..2c795103deaa4044596bd07=
d90db788169a32a0c 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -250,6 +250,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> >  	__be32 status;
> >  	int host_err;
> > =20
> > +	trace_nfsd4_create_file(rqstp, fhp, S_IFREG, open->op_fname, open->op=
_fnamelen);
> > +
> >  	if (isdotent(open->op_fname, open->op_fnamelen))
> >  		return nfserr_exist;
> >  	if (!(iap->ia_valid & ATTR_MODE))
> > @@ -807,6 +809,29 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> >  	return status;
> >  }
> > =20
> > +static umode_t nfs_type_to_vfs_type(enum nfs_ftype4 nfstype)
> > +{
> > +	switch (nfstype) {
> > +	case NF4REG:
> > +		return S_IFREG;
> > +	case NF4DIR:
> > +		return S_IFDIR;
> > +	case NF4BLK:
> > +		return S_IFBLK;
> > +	case NF4CHR:
> > +		return S_IFCHR;
> > +	case NF4LNK:
> > +		return S_IFLNK;
> > +	case NF4SOCK:
> > +		return S_IFSOCK;
> > +	case NF4FIFO:
> > +		return S_IFIFO;
> > +	default:
> > +		break;
> > +	}
> > +	return 0;
> > +}
> > +
>=20
> Wondering what happens when trace points are disabled in the kernel
> build. Maybe this helper belongs in fs/nfsd/trace.h instead as a
> macro wrapper for __print_symbolic(). But see below.
>=20
>=20
> >  static __be32
> >  nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *csta=
te,
> >  	     union nfsd4_op_u *u)
> > @@ -822,6 +847,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> >  	__be32 status;
> >  	dev_t rdev;
> > =20
> > +	trace_nfsd4_create(rqstp, &cstate->current_fh,
> > +			   nfs_type_to_vfs_type(create->cr_type),
> > +			   create->cr_name, create->cr_namelen);
> > +
> >  	fh_init(&resfh, NFS4_FHSIZE);
> > =20
> >  	status =3D fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NO=
P);
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 6dda081eb24c00b834ab0965c3a35a12115bceb7..33d8cbf8785588d38d4ec5e=
fd769c1d1d06c6a91 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -10,6 +10,7 @@
> >  #include "cache.h"
> >  #include "xdr.h"
> >  #include "vfs.h"
> > +#include "trace.h"
> > =20
> >  #define NFSDDBG_FACILITY		NFSDDBG_PROC
> > =20
> > @@ -292,8 +293,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> >  	int		hosterr;
> >  	dev_t		rdev =3D 0, wanted =3D new_decode_dev(attr->ia_size);
> > =20
> > -	dprintk("nfsd: CREATE   %s %.*s\n",
> > -		SVCFH_fmt(dirfhp), argp->len, argp->name);
> > +	trace_nfsd_proc_create(rqstp, dirfhp, S_IFREG, argp->name, argp->len)=
;
> > =20
> >  	/* First verify the parent file handle */
> >  	resp->status =3D fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
> > @@ -548,7 +548,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
> >  		.na_iattr	=3D &argp->attrs,
> >  	};
> > =20
> > -	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, =
argp->name);
> > +	trace_nfsd_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->le=
n);
> > =20
> >  	if (resp->fh.fh_dentry) {
> >  		printk(KERN_WARNING
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 382849d7c321d6ded8213890c2e7075770aa716c..c6aff23a845f06c87e701d5=
7ec577c2c5c5a743c 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -2391,6 +2391,45 @@ TRACE_EVENT(nfsd_lookup_dentry,
> >  	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x name=3D%s",
> >  		  __entry->xid, __entry->fh_hash, __get_str(name))
> >  );
> > +
> > +DECLARE_EVENT_CLASS(nfsd_vfs_create_class,
> > +	TP_PROTO(struct svc_rqst *rqstp,
> > +		 struct svc_fh *fhp,
> > +		 umode_t type,
> > +		 const char *name,
> > +		 unsigned int len),
> > +	TP_ARGS(rqstp, fhp, type, name, len),
> > +	TP_STRUCT__entry(
> > +		SVC_RQST_ENDPOINT_FIELDS(rqstp)
> > +		__field(u32, fh_hash)
> > +		__field(umode_t, type)
> > +		__string_len(name, name, len)
> > +	),
> > +	TP_fast_assign(
> > +		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
> > +		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
> > +		__entry->type =3D type;
> > +		__assign_str(name);
> > +	),
> > +	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x type=3D%s name=3D%s",
> > +		  __entry->xid, __entry->fh_hash,
> > +		  show_fs_file_type(__entry->type), __get_str(name))
> > +);
> > +
> > +#define DEFINE_NFSD_VFS_CREATE_EVENT(__name)						\
> > +	DEFINE_EVENT(nfsd_vfs_create_class, __name,					\
> > +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,		\
> > +			      umode_t type, const char *name, unsigned int len),	\
> > +		     TP_ARGS(rqstp, fhp, type, name, len))
> > +
> > +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_create);
> > +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_mkdir);
> > +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_create);
> > +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mkdir);
> > +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
> > +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
> > +DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);
>=20
> I think we would be better off with one or two new trace points in
> nfsd_create() and nfsd_create_setattr() instead of all of these...
>=20
> Unless I've missed what you are trying to observe...?
>=20

Now I remember why I did it this way. Doing it the way you suggest
makes this all a bit messy:

Most of the callers create files via nfsd_create(), but
nfsd3_create_file calls vfs_create() directly. It does call
nfsd_create_setattr(), but that's really not the right place for this
either, since it's doing a setattr and not the create itself. Notably,
it isn't passed the filename.

Note too that burying this tracepoint down in nfs_create() also means
that error conditions can happen before the tracepoint that may mean
that it won't fire. So, if you're watching the traces to see when
CREATE or MKDIR calls occur, you may miss some of them.

How do you want to proceed?=20
--=20
Jeff Layton <jlayton@kernel.org>


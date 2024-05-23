Return-Path: <linux-nfs+bounces-3351-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593138CD226
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 14:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BAA1F21E5E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3DC1E481;
	Thu, 23 May 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXHCBSQl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77013B7A6
	for <linux-nfs@vger.kernel.org>; Thu, 23 May 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466704; cv=none; b=dN5EHtB1FOQAGMzT1we6XyTHH1yPiTtbTwU8RXX9/Ifk7mXFDIAWfS/8v+SsHGzQWn0V8MzV/WlKo0KiNlXz5CY9YqHph8GtVNitLVQK0EASccLW/nMJqMfOapaMTBahtnCzZa0yMmWtX5STWKyDM9DOVZBMK0MZ8SitGFpnqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466704; c=relaxed/simple;
	bh=Q+6OTM0Y4zLlRDYbEkN4y5toxUnSQC8TL+9LfU8ASqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM1cTUjjEE8FqClUwp8Q6lR3P6pRN6XB5UGbg4cpyTcnd13pI+PbKYNmiaBwn/B3kjoQ1ZqKkaho92xNRwjJ+m4pLDT85OPkisPTkle1UAatuJTJPG3wG00fa1XkXgr8yF2NzutVKSHC9b0oZKibloCCx9qHRCF3Cx1M2WOp9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXHCBSQl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716466702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88tGDa+CIM0/nnfBE4H/4aSEl879vpxwfnvFfB1MYPg=;
	b=NXHCBSQlxll+7/qv8ccFhBWAAYr2JVGPABx81bFJHAtASkHVQii3l2Fwtc+iSnclTxuPae
	9OxSmy5wFSUWAqtZF3HjpqVCGDfS/YV4sj1S+rRpwEAVO5KO0dSlMvMedy8uUFumciXn/j
	Q71m8OX3aBXkN72M8yGcMh5iEpeEX5c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-fZDcmYdcMg28VVvhnG6SLw-1; Thu,
 23 May 2024 08:18:15 -0400
X-MC-Unique: fZDcmYdcMg28VVvhnG6SLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3763C3801FE1;
	Thu, 23 May 2024 12:18:15 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.33.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E41A2100046D;
	Thu, 23 May 2024 12:18:14 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 5038414C51C; Thu, 23 May 2024 08:18:14 -0400 (EDT)
Date: Thu, 23 May 2024 08:18:14 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH] nfs: don't invalidate dentries on transient errors
Message-ID: <Zk80Bm4nuT7eKdD3@aion>
References: <20240522221916.447239-1-smayhew@redhat.com>
 <9ecb1225e5746054c27ca9488d34510147e58edd.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9ecb1225e5746054c27ca9488d34510147e58edd.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, 22 May 2024, Trond Myklebust wrote:

> On Wed, 2024-05-22 at 18:19 -0400, Scott Mayhew wrote:
> > This is a slight variation on a patch previously proposed by Neil
> > Brown
> > that never got merged.
> >=20
> > Prior to commit 5ceb9d7fdaaf ("NFS: Refactor
> > nfs_lookup_revalidate()"),
> > any error from nfs_lookup_verify_inode() other than -ESTALE would
> > result
> > in nfs_lookup_revalidate() returning that error (-ESTALE is mapped to
> > zero).
> >=20
> > Since that commit, all errors result in nfs_lookup_revalidate()
> > returning zero, resulting in dentries being invalidated where they
> > previously were not (particularly in the case of -ERESTARTSYS).
> >=20
> > Fix it by passing the actual error code to
> > nfs_lookup_revalidate_done(),
> > and leaving the decision on whether to=A0 map the error code to zero or
> > one to nfs_lookup_revalidate_done().
> >=20
> > A simple reproducer is to run the following python code in a
> > subdirectory of an NFS mount (not in the root of the NFS mount):
> >=20
> > ---8<---
> > import os
> > import multiprocessing
> > import time
> >=20
> > if __name__=3D=3D"__main__":
> > =A0=A0=A0 multiprocessing.set_start_method("spawn")
> >=20
> > =A0=A0=A0 count =3D 0
> > =A0=A0=A0 while True:
> > =A0=A0=A0=A0=A0=A0=A0 try:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 os.getcwd()
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pool =3D multiprocessing.Pool(10)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pool.close()
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pool.terminate()
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 count +=3D 1
> > =A0=A0=A0=A0=A0=A0=A0 except Exception as e:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 print(f"Failed after {count} iteratio=
ns")
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 print(e)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break
> > ---8<---
> >=20
> > Prior to commit 5ceb9d7fdaaf, the above code would run indefinitely.
> > After commit 5ceb9d7fdaaf, it fails almost immediately with -ENOENT.
> >=20
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> > =A0fs/nfs/dir.c | 24 +++++++++++-------------
> > =A01 file changed, 11 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index ac505671efbd..d9264ed4ac52 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -1635,6 +1635,14 @@ nfs_lookup_revalidate_done(struct inode *dir,
> > struct dentry *dentry,
> > =A0		if (inode && IS_ROOT(dentry))
> > =A0			error =3D 1;
> > =A0		break;
> > +	case -ESTALE:
> > +	case -ENOENT:
> > +		error =3D 0;
> > +		break;
> > +	case -ETIMEDOUT:
> > +		if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
> > +			error =3D 1;
> > +		break;
> > =A0	}
> > =A0	trace_nfs_lookup_revalidate_exit(dir, dentry, 0, error);
> > =A0	return error;
> > @@ -1680,18 +1688,8 @@ static int nfs_lookup_revalidate_dentry(struct
> > inode *dir,
> > =A0
> > =A0	dir_verifier =3D nfs_save_change_attribute(dir);
> > =A0	ret =3D NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
> > -	if (ret < 0) {
> > -		switch (ret) {
> > -		case -ESTALE:
> > -		case -ENOENT:
> > -			ret =3D 0;
> > -			break;
> > -		case -ETIMEDOUT:
> > -			if (NFS_SERVER(inode)->flags &
> > NFS_MOUNT_SOFTREVAL)
> > -				ret =3D 1;
> > -		}
> > +	if (ret < 0)
> > =A0		goto out;
> > -	}
> > =A0
> > =A0	/* Request help from readdirplus */
> > =A0	nfs_lookup_advise_force_readdirplus(dir, flags);
> > @@ -1735,7 +1733,7 @@ nfs_do_lookup_revalidate(struct inode *dir,
> > struct dentry *dentry,
> > =A0			 unsigned int flags)
> > =A0{
> > =A0	struct inode *inode;
> > -	int error;
> > +	int error =3D 0;
> > =A0
> > =A0	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
> > =A0	inode =3D d_inode(dentry);
> > @@ -1780,7 +1778,7 @@ nfs_do_lookup_revalidate(struct inode *dir,
> > struct dentry *dentry,
> > =A0out_bad:
> > =A0	if (flags & LOOKUP_RCU)
> > =A0		return -ECHILD;
> > -	return nfs_lookup_revalidate_done(dir, dentry, inode, 0);
> > +	return nfs_lookup_revalidate_done(dir, dentry, inode,
> > error);
>=20
> Won't this now cause us to skip the special handling of the root
> directory in nfs_lookup_revalidate_done() if the call to
> nfs_lookup_verify_inode() fails with an error?

Yes, it will. I'll send a v2 in a bit.

-Scott
>=20
> > =A0}
> > =A0
> > =A0static int
>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20



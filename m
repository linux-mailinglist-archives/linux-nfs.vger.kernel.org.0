Return-Path: <linux-nfs+bounces-11961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7AAC720B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E7D1882EAF
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548C212FAD;
	Wed, 28 May 2025 20:16:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE1210F49
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463381; cv=none; b=a+U/ygbtdvWewv3Fq6umVMqZJDrDk2zJXpW1aGE6TW8MRIW9EpGZgm8WAuzH4kf8dCnGwKEE/OdKmFLhkEvBoTPS4hV137e3v//7kqTGhBSoxrZj9tzm5uyLpeUwzl5ygy0qEuCTMq576YzrmkWfbuJCuR5rojoY69S6QieRmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463381; c=relaxed/simple;
	bh=gUyq86vBmQW+7aLWpGxfN6tJUYcBptqAklNetII4ay4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpQxWEq2Upj2W1Pyp4cCgjhCYcRom8l9eisd7k+stkk4jafU+OtBYeSK94qo4MdamiNiA3p2Ll4IObBWnQ1k0GBeZ8VzfJMM88krLxcdmvQuE2G6w/teSWYLfsgTCwKodg7w8SDDyjyYBm66j7i3NTEAyV/mCQT0Elmj8wCOXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b38fb692fso5107839f.2
        for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 13:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463377; x=1749068177;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFRYzJKu02F2tNLmDtJqPbvaHloJzRCjDEc2HXuSWrs=;
        b=oY5vN+7mI6l7t2jdflSkiW+tOjgCKHjOqMT1mV2hcKY+ymeD2gKP/ssV6S1wsGLNaZ
         usxhGF3wNQvtDNHpbWjbQ3aIT6RpWqRE90citudfZfdSH+J6rHkycrI1SSFLGbKJcWxL
         ifn1g5/yfBrXZnpZL7uONbdpg8ExPo8n+TZysNHeHVx0kjZDPGmEs3V6FV4HUVoLULQS
         aEi39n7+2wy8184e3QMkzy5O29aS6TmJpOl5FgRORLS5RGwme5METQTgiHrUB5pQYBFH
         li3O6J3CuSazqZYpi4DqDnJhVx5iNGvXBymhlb7FeCYQhdtVIn7WeTHMmHa7sukiGX5l
         Eo2g==
X-Forwarded-Encrypted: i=1; AJvYcCVHp7yy59Fku6u4NIPOK+BElnDL6xaZHNXROy2N+vr3mvkLtNLb3bVTIiTMqehO2q1SWjygR6WPlxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvzKx3Zs2jg5czTIVFUlcIdbeMG/tlrp3gwXrXdGevrtBrQ4Yz
	8803L6Ar2zfcpt5Vs5mhj+6m3jhwJH+QeC0r2vyExCe0CxmRS+n3XCA=
X-Gm-Gg: ASbGncterjNl9KBl0nckDdX1fC5SkinnUwqP5g1NRpnvp5qPib45jWlIEK9Zz8ok9tT
	t4OoLXEAcvRTC0rAh6hBeqAX92bSKS69Do+/xZBmq2dRMF3NaCmqSglzOVs7OpTVe/V8F6bRjkd
	Kdau6/V1px++u75eJV0y//hOZGVg7a3bJXQzGMJubaKyY6qulcE+AAEI4saYKapjccy93RLssth
	EjdSuF3A7lddntiOiqIVvDcAYEyANf2HPJymYsk0VAN27mNOoaUlYyKE5cy2cF2ir0Zgeglukz0
	jS5zNsnHvN077mKti7MaaUbLeCpOMjuxCqkxeqAhrZwlVWkVx9FNosk4e/dTli03qXcvlNluEwV
	mRm2wyjTaJBcu6ffZM8g0eqETS+5OWDXqLkZNnRZHPsYpbz5TdtcMWwk=
X-Google-Smtp-Source: AGHT+IHA4SbkKob6ErWEQwri3aBfok+62qH09j0V+YwYs+XeHHK5F3ydKCHnai8r4MX0Hal5jXXuxw==
X-Received: by 2002:a5d:9f50:0:b0:86c:ee8b:c089 with SMTP id ca18e2360f4ac-86cee8bc1bbmr300057339f.3.1748463377439;
        Wed, 28 May 2025 13:16:17 -0700 (PDT)
Received: from leira.trondhjem.org (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86cea580191sm38638539f.11.2025.05.28.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:16:16 -0700 (PDT)
Message-ID: <291a926b2dd3aba5532c940a5dd18f38ab4c58e3.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] nfs: Add timecreate to nfs inode
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Benjamin Coddington
 <bcodding@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, Lance
 Shelton	 <lance.shelton@hammerspace.com>
Date: Wed, 28 May 2025 16:16:15 -0400
In-Reply-To: <d60ba979c9e2f762f1a4c48ede81e9a83682584b.camel@kernel.org>
References: <cover.1748436487.git.bcodding@redhat.com>
		 <ee8d37a7b6495e95aa2875241e2962d41e57dc14.1748436487.git.bcodding@redhat.com>
		 <a639fc978c9bdc54943301fad6618f8f068203ce.camel@kernel.org>
		 <F0C8CB76-5A7E-45C2-A09B-C608F59A93DC@redhat.com>
	 <d60ba979c9e2f762f1a4c48ede81e9a83682584b.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-28 at 11:27 -0400, Jeff Layton wrote:
> On Wed, 2025-05-28 at 11:13 -0400, Benjamin Coddington wrote:
> > On 28 May 2025, at 8:56, Jeff Layton wrote:
> >=20
> > > On Wed, 2025-05-28 at 08:50 -0400, Benjamin Coddington wrote:
> > > > From: Anne Marie Merritt <annemarie.merritt@primarydata.com>
> > > >=20
> > > > Add tracking of the create time (a.k.a. btime) along with
> > > > corresponding
> > > > bitfields, request, and decode xdr routines.
> > > >=20
> > > > Signed-off-by: Anne Marie Merritt
> > > > <annemarie.merritt@primarydata.com>
> > > > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > > > Signed-off-by: Trond Myklebust
> > > > <trond.myklebust@hammerspace.com>
> > > > ---
> > > > =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 28 ++++++++++++++++++++++------
> > > > =C2=A0fs/nfs/nfs4proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++=
+++++++++++-
> > > > =C2=A0fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
24 ++++++++++++++++++++++++
> > > > =C2=A0fs/nfs/nfstrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3 ++-
> > > > =C2=A0include/linux/nfs_fs.h=C2=A0 |=C2=A0 7 +++++++
> > > > =C2=A0include/linux/nfs_xdr.h |=C2=A0 3 +++
> > > > =C2=A06 files changed, 71 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > > > index 160f3478a835..fd84c24963b3 100644
> > > > --- a/fs/nfs/inode.c
> > > > +++ b/fs/nfs/inode.c
> > > > @@ -197,6 +197,7 @@ void nfs_set_cache_invalid(struct inode
> > > > *inode, unsigned long flags)
> > > > =C2=A0		if (!(flags & NFS_INO_REVAL_FORCED))
> > > > =C2=A0			flags &=3D ~(NFS_INO_INVALID_MODE |
> > > > =C2=A0				=C2=A0=C2=A0 NFS_INO_INVALID_OTHER |
> > > > +				=C2=A0=C2=A0 NFS_INO_INVALID_BTIME |
> > > > =C2=A0				=C2=A0=C2=A0 NFS_INO_INVALID_XATTR);
> > > > =C2=A0		flags &=3D ~(NFS_INO_INVALID_CHANGE |
> > > > NFS_INO_INVALID_SIZE);
> > > > =C2=A0	}
> > > > @@ -522,6 +523,7 @@ nfs_fhget(struct super_block *sb, struct
> > > > nfs_fh *fh, struct nfs_fattr *fattr)
> > > > =C2=A0		inode_set_atime(inode, 0, 0);
> > > > =C2=A0		inode_set_mtime(inode, 0, 0);
> > > > =C2=A0		inode_set_ctime(inode, 0, 0);
> > > > +		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
> > > > =C2=A0		inode_set_iversion_raw(inode, 0);
> > > > =C2=A0		inode->i_size =3D 0;
> > > > =C2=A0		clear_nlink(inode);
> > > > @@ -545,6 +547,10 @@ nfs_fhget(struct super_block *sb, struct
> > > > nfs_fh *fh, struct nfs_fattr *fattr)
> > > > =C2=A0			inode_set_ctime_to_ts(inode, fattr-
> > > > >ctime);
> > > > =C2=A0		else if (fattr_supported &
> > > > NFS_ATTR_FATTR_CTIME)
> > > > =C2=A0			nfs_set_cache_invalid(inode,
> > > > NFS_INO_INVALID_CTIME);
> > > > +		if (fattr->valid & NFS_ATTR_FATTR_BTIME)
> > > > +			nfsi->btime =3D fattr->btime;
> > > > +		else if (fattr_supported &
> > > > NFS_ATTR_FATTR_BTIME)
> > > > +			nfs_set_cache_invalid(inode,
> > > > NFS_INO_INVALID_BTIME);
> > > > =C2=A0		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
> > > > =C2=A0			inode_set_iversion_raw(inode, fattr-
> > > > >change_attr);
> > > > =C2=A0		else
> > > > @@ -1900,7 +1906,7 @@ static int
> > > > nfs_inode_finish_partial_attr_update(const struct nfs_fattr
> > > > *fattr,
> > > > =C2=A0		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME
> > > > |
> > > > =C2=A0		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
> > > > =C2=A0		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER
> > > > |
> > > > -		NFS_INO_INVALID_NLINK;
> > > > +		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
> > > > =C2=A0	unsigned long cache_validity =3D NFS_I(inode)-
> > > > >cache_validity;
> > > > =C2=A0	enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)-
> > > > >change_attr_type;
> > > >=20
> > > > @@ -2219,10 +2225,13 @@ static int nfs_update_inode(struct
> > > > inode *inode, struct nfs_fattr *fattr)
> > > > =C2=A0	nfs_fattr_fixup_delegated(inode, fattr);
> > > >=20
> > > > =C2=A0	save_cache_validity =3D nfsi->cache_validity;
> > > > -	nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
> > > > -			| NFS_INO_INVALID_ATIME
> > > > -			| NFS_INO_REVAL_FORCED
> > > > -			| NFS_INO_INVALID_BLOCKS);
> > > > +	nfsi->cache_validity &=3D
> > > > +		~(NFS_INO_INVALID_ATIME | NFS_INO_REVAL_FORCED
> > > > |
> > > > +		=C2=A0 NFS_INO_INVALID_CHANGE |
> > > > NFS_INO_INVALID_CTIME |
> > > > +		=C2=A0 NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE
> > > > |
> > > > +		=C2=A0 NFS_INO_INVALID_OTHER |
> > > > NFS_INO_INVALID_BLOCKS |
> > > > +		=C2=A0 NFS_INO_INVALID_NLINK | NFS_INO_INVALID_MODE
> > > > |
> > > > +		=C2=A0 NFS_INO_INVALID_BTIME);
> > > >=20
> > >=20
> > > The delta above is a little curious. This patch is just adding
> > > NFS_INO_INVALID_BTIME, but the patch above adds the clearing of
> > > several
> > > other bits as well. Why does this logic change?
> >=20
> > Good point, I wonder if it was based on other attribute work at the
> > time,
> > the original was here:
> > https://lore.kernel.org/linux-nfs/20211227190504.309612-3-trondmy@kerne=
l.org/
> >=20
> > So I think what we're doing here is clearing what we know we don't
> > have to
> > check/update - I think we can drop this entire hunk, its a minor
> > optimization, but hopefully we can get some expert opinion.=C2=A0=C2=A0
> > Trond, do you
> > want me to test with this hunk removed?
>=20
> Looking little closer, I think what happened there is that
> NFS_INO_INVALID_ATTR got unrolled into individual attr flags. So
> there
> may be no net change here (other than adding BTIME).
>=20
> Still, it'd be best to do that in a separate patch, IMO, esp. since
> this is in nfs_update_inode(), which is already so "fiddly".

NFS_INO_INVALID_ATTR is a dinosaur that I'd like to see extinct. We
have fine grained attribute tracking these days, and so keeping the old
coarse grained one around is just confusing.

That said, I'm fine with this being a separate patch.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


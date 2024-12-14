Return-Path: <linux-nfs+bounces-8561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD79F1F77
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046937A05E2
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Dec 2024 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F9193429;
	Sat, 14 Dec 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2WuwTET"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADE946C;
	Sat, 14 Dec 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734188111; cv=none; b=C+0bos/xMkVYsZchNoA85rqEpjWiQWhiu7h2XIgys+3hIomn4wXNoMCVqmCTsCtgBwLnRsxGPiLMH3SaACWyCK0iStRKo4+6bALYS5nMZW5C2T9DjgK9EQonVSiyAdCvy3VTqlp+WRUiEAGGsvbQVAKVQV/AMoPmZrfzKOTbcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734188111; c=relaxed/simple;
	bh=YutngTKAkfNmIEuz/COPClVg1Ux1a/yOfUuvDJf1qn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXNX3PK6p6+3npvKT28lmNEA/LsStau3M9DjhscPZjZ806gKH34dWYKJDPg47ZOGje6cm3F/7P/+vo3Js9q0LZJWoZrSE5zVGmILMOd142ERB591qvkLqsHJ/c7+MtXKxdxRJLjBmCoDATVLAnxzQxXj4RZTkaSTzEfziTp0LLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2WuwTET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC91EC4CED1;
	Sat, 14 Dec 2024 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734188111;
	bh=YutngTKAkfNmIEuz/COPClVg1Ux1a/yOfUuvDJf1qn4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N2WuwTETxGKLAqA4X/rj7QTWQ+THFDbRZEOTEJL2/N1rbfWjdgDk6pmID4OpfXrjU
	 vTCCDP54SZY8dfe9d5u/N4A8Wl+BNmloUoyE2PbyC5F8zvmOlf8X6L5mqkKPTMFYlA
	 Gi+negXp4BJkZQDZRy9eJR4z0AYHBV8ape+IDLQnYIAJT9m86l6LRuQcFFlVbA9MX8
	 S+g7rh8oN8GM/zqCq0qVF0cren+7K2f+37Xe/2o9hl7a/9ikZTxhL6VDpTsne9WeCG
	 hRv172mt/PyNYlCygQ4+epOwwusDzEd2jlhKR1aGA/XharHc2DA69XNRaJ8G/Ch56R
	 fw3r4drdTaLHQ==
Message-ID: <f2284ade0fcda383c29a4be58a3d0eb012bf5ec5.camel@kernel.org>
Subject: Re: [PATCH v5 09/10] nfsd: handle delegated timestamps in SETATTR
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Jonathan Corbet <corbet@lwn.net>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Sat, 14 Dec 2024 09:55:09 -0500
In-Reply-To: <c4835f2b-0edd-49a2-9f61-5bd7090382dc@oracle.com>
References: <20241209-delstid-v5-0-42308228f692@kernel.org>
	 <20241209-delstid-v5-9-42308228f692@kernel.org>
	 <2a3c0a1f-0213-4915-a4c0-a2ba31ae1bbc@oracle.com>
	 <f697868bfa7f219d51ba8251db32b22ad942ecd7.camel@kernel.org>
	 <c4835f2b-0edd-49a2-9f61-5bd7090382dc@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 09:18 -0500, Chuck Lever wrote:
> On 12/13/24 9:14 AM, Jeff Layton wrote:
> > On Thu, 2024-12-12 at 16:06 -0500, Chuck Lever wrote:
> > > On 12/9/24 4:14 PM, Jeff Layton wrote:
> > > > Allow SETATTR to handle delegated timestamps. This patch assumes th=
at
> > > > only the delegation holder has the ability to set the timestamps in=
 this
> > > > way, so we allow this only if the SETATTR stateid refers to a
> > > > *_ATTRS_DELEG delegation.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >    fs/nfsd/nfs4proc.c  | 31 ++++++++++++++++++++++++++++---
> > > >    fs/nfsd/nfs4state.c |  2 +-
> > > >    fs/nfsd/nfs4xdr.c   | 20 ++++++++++++++++++++
> > > >    fs/nfsd/nfsd.h      |  5 ++++-
> > > >    4 files changed, 53 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index f8a10f90bc7a4b288c20d2733c85f331cc0a8dba..fea171ffed623818c61=
886b786339b0b73f1053d 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -1135,18 +1135,43 @@ nfsd4_setattr(struct svc_rqst *rqstp, struc=
t nfsd4_compound_state *cstate,
> > > >    		.na_iattr	=3D &setattr->sa_iattr,
> > > >    		.na_seclabel	=3D &setattr->sa_label,
> > > >    	};
> > > > +	bool save_no_wcc, deleg_attrs;
> > > > +	struct nfs4_stid *st =3D NULL;
> > > >    	struct inode *inode;
> > > >    	__be32 status =3D nfs_ok;
> > > > -	bool save_no_wcc;
> > > >    	int err;
> > > >   =20
> > > > -	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
> > > > +	deleg_attrs =3D setattr->sa_bmval[2] & (FATTR4_WORD2_TIME_DELEG_A=
CCESS |
> > > > +					      FATTR4_WORD2_TIME_DELEG_MODIFY);
> > > > +
> > > > +	if (deleg_attrs || (setattr->sa_iattr.ia_valid & ATTR_SIZE)) {
> > > > +		int flags =3D WR_STATE;
> > > > +
> > > > +		if (setattr->sa_bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS)
> > > > +			flags |=3D RD_STATE;
> > > > +
> > > >    		status =3D nfs4_preprocess_stateid_op(rqstp, cstate,
> > > >    				&cstate->current_fh, &setattr->sa_stateid,
> > > > -				WR_STATE, NULL, NULL);
> > > > +				flags, NULL, &st);
> > > >    		if (status)
> > > >    			return status;
> > > >    	}
> > > > +
> > > > +	if (deleg_attrs) {
> > > > +		status =3D nfserr_bad_stateid;
> > > > +		if (st->sc_type & SC_TYPE_DELEG) {
> > > > +			struct nfs4_delegation *dp =3D delegstateid(st);
> > > > +
> > > > +			/* Only for *_ATTRS_DELEG flavors */
> > > > +			if (deleg_attrs_deleg(dp->dl_type))
> > > > +				status =3D nfs_ok;
> > > > +		}
> > > > +	}
> > > > +	if (st)
> > > > +		nfs4_put_stid(st);
> > > > +	if (status)
> > > > +		return status;
> > > > +
> > > >    	err =3D fh_want_write(&cstate->current_fh);
> > > >    	if (err)
> > > >    		return nfserrno(err);
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index c882eeba7830b0249ccd74654f81e63b12a30f14..a76e35f86021c5657e3=
1e4fddf08cb5781f01e32 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -5486,7 +5486,7 @@ nfsd4_process_open1(struct nfsd4_compound_sta=
te *cstate,
> > > >    static inline __be32
> > > >    nfs4_check_delegmode(struct nfs4_delegation *dp, int flags)
> > > >    {
> > > > -	if ((flags & WR_STATE) && deleg_is_read(dp->dl_type))
> > > > +	if (!(flags & RD_STATE) && deleg_is_read(dp->dl_type))
> > > >    		return nfserr_openmode;
> > > >    	else
> > > >    		return nfs_ok;
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index 0561c99b5def2eccf679bf3ea0e5b1a57d5d8374..ce93a31ac5cec75b0f9=
44d288e796e7a73641572 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -521,6 +521,26 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs =
*argp, u32 *bmval, u32 bmlen,
> > > >    		*umask =3D mask & S_IRWXUGO;
> > > >    		iattr->ia_valid |=3D ATTR_MODE;
> > > >    	}
> > > > +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_ACCESS) {
> > > > +		fattr4_time_deleg_access access;
> > > > +
> > > > +		if (!xdrgen_decode_fattr4_time_deleg_access(argp->xdr, &access))
> > > > +			return nfserr_bad_xdr;
> > > > +		iattr->ia_atime.tv_sec =3D access.seconds;
> > > > +		iattr->ia_atime.tv_nsec =3D access.nseconds;
> > > > +		iattr->ia_valid |=3D ATTR_ATIME | ATTR_ATIME_SET | ATTR_DELEG;
> > > > +	}
> > > > +	if (bmval[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) {
> > > > +		fattr4_time_deleg_modify modify;
> > > > +
> > > > +		if (!xdrgen_decode_fattr4_time_deleg_modify(argp->xdr, &modify))
> > > > +			return nfserr_bad_xdr;
> > > > +		iattr->ia_mtime.tv_sec =3D modify.seconds;
> > > > +		iattr->ia_mtime.tv_nsec =3D modify.nseconds;
> > > > +		iattr->ia_ctime.tv_sec =3D modify.seconds;
> > > > +		iattr->ia_ctime.tv_nsec =3D modify.seconds;
> > > > +		iattr->ia_valid |=3D ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | =
ATTR_DELEG;
> > > > +	}
> > > >   =20
> > > >    	/* request sanity: did attrlist4 contain the expected number of=
 words? */
> > > >    	if (attrlist4_count !=3D xdr_stream_pos(argp->xdr) - starting_p=
os)
> > > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > > index 004415651295891b3440f52a4c986e3a668a48cb..f007699aa397fe39042=
d80ccd568db4654d19dd5 100644
> > > > --- a/fs/nfsd/nfsd.h
> > > > +++ b/fs/nfsd/nfsd.h
> > > > @@ -531,7 +531,10 @@ static inline bool nfsd_attrs_supported(u32 mi=
norversion, const u32 *bmval)
> > > >    #endif
> > > >    #define NFSD_WRITEABLE_ATTRS_WORD2 \
> > > >    	(FATTR4_WORD2_MODE_UMASK \
> > > > -	| MAYBE_FATTR4_WORD2_SECURITY_LABEL)
> > > > +	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
> > > > +	| FATTR4_WORD2_TIME_DELEG_ACCESS \
> > > > +	| FATTR4_WORD2_TIME_DELEG_MODIFY \
> > > > +	)
> > > >   =20
> > > >    #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
> > > >    	NFSD_WRITEABLE_ATTRS_WORD0
> > > >=20
> > >=20
> > > Hi Jeff-
> > >=20
> > > After this patch is applied, I see failures of the git regression sui=
te
> > > on NFSv4.2 mounts.
> > >=20
> > > Test Summary Report
> > > -------------------
> > > ./t3412-rebase-root.sh                             (Wstat: 256 (exite=
d
> > > 1) Tests: 25 Failed: 5)
> > >     Failed tests:  6, 19, 21-22, 24
> > >     Non-zero exit status: 1
> > > ./t3400-rebase.sh                                  (Wstat: 256 (exite=
d
> > > 1) Tests: 38 Failed: 1)
> > >     Failed test:  31
> > >     Non-zero exit status: 1
> > > ./t3406-rebase-message.sh                          (Wstat: 256 (exite=
d
> > > 1) Tests: 32 Failed: 2)
> > >     Failed tests:  15, 20
> > >     Non-zero exit status: 1
> > > ./t3428-rebase-signoff.sh                          (Wstat: 256 (exite=
d
> > > 1) Tests: 7 Failed: 2)
> > >     Failed tests:  6-7
> > >     Non-zero exit status: 1
> > > ./t3418-rebase-continue.sh                         (Wstat: 256 (exite=
d
> > > 1) Tests: 29 Failed: 1)
> > >     Failed test:  7
> > >     Non-zero exit status: 1
> > > ./t3415-rebase-autosquash.sh                       (Wstat: 256 (exite=
d
> > > 1) Tests: 27 Failed: 2)
> > >     Failed tests:  3-4
> > >     Non-zero exit status: 1
> > > ./t3404-rebase-interactive.sh                      (Wstat: 256 (exite=
d
> > > 1) Tests: 131 Failed: 15)
> > >     Failed tests:  32, 34-43, 45, 121-123
> > >     Non-zero exit status: 1
> > > ./t1013-read-tree-submodule.sh                     (Wstat: 256 (exite=
d
> > > 1) Tests: 68 Failed: 1)
> > >     Failed test:  34
> > >     Non-zero exit status: 1
> > > ./t2013-checkout-submodule.sh                      (Wstat: 256 (exite=
d
> > > 1) Tests: 74 Failed: 4)
> > >     Failed tests:  26-27, 30-31
> > >     Non-zero exit status: 1
> > > ./t5500-fetch-pack.sh                              (Wstat: 256 (exite=
d
> > > 1) Tests: 375 Failed: 1)
> > >     Failed test:  28
> > >     Non-zero exit status: 1
> > > ./t5572-pull-submodule.sh                          (Wstat: 256 (exite=
d
> > > 1) Tests: 67 Failed: 2)
> > >     Failed tests:  5, 7
> > >     Non-zero exit status: 1
> > > Files=3D1007, Tests=3D30810, 1417 wallclock secs (11.18 usr 10.17 sys=
 +
> > > 1037.05 cusr 6529.12 csys =3D 7587.52 CPU)
> > > Result: FAIL
> > >=20
> > > The NFS client and NFS server under test are running the same v6.13-r=
c2
> > > kernel from my git.kernel.org nfsd-testing branch.
> > >=20
> > >=20
> >=20
> > I'm not seeing these failures. I ran the gitr suite under kdevops with
> > your nfsd-testing branch (6.13.0-rc2-ge9a809c5714e):
> >=20
> > All tests successful.
> > Files=3D1007, Tests=3D30695, 10767 wallclock secs (13.87 usr 16.86 sys =
+ 1160.76 cusr 17870.80 csys =3D 19062.29 CPU)
> > Result: PASS
> >=20
> > ...and looking at the results of those specific tests, they did run and
> > they did pass.
> >=20
> > I'm rerunning the tests now. It's possible the underlying fs matters.
> > Mine is exporting xfs. Yours?
>=20
> Mine is btrfs, and the NFS version is v4.2 on TCP.
>=20
>=20

Nope, I still can't reproduce this with btrfs either. I'm also using
v4.2 on TCP. I assume you're running this under kdevops, so we should
have a relatively similar environment.

Are you also testing the same commit?
--=20
Jeff Layton <jlayton@kernel.org>


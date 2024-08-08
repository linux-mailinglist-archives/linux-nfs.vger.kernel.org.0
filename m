Return-Path: <linux-nfs+bounces-5263-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A89494BCC8
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 14:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF211F2244A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFDD14A4DB;
	Thu,  8 Aug 2024 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+wwYx/j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9E126F1E
	for <linux-nfs@vger.kernel.org>; Thu,  8 Aug 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118470; cv=none; b=qAkjkkzR/e0hIVIUE8hnLEYEFdMfpK9SlkuPulo2Vyqhow6AvAdHsaaviyWl8y27tIQ30l0lRWZKI7IBPi/cqruc1XvAWpGBa4tKZR7GX2m4vZEkwIpwVePMP9mcu2y2yxSIUwYC4k2an02qTEOawxHKCdmmIRQRco4Rf3rB9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118470; c=relaxed/simple;
	bh=gP4R16BRIcbMR+0pYw7dESQgcRJSVgigc3N/GXIIO14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MY2XWa9YI2YcKF6h8OPZ01k/srm0fYwD5XpT+nEqrEhJmjZ9b53Y/R76/6upoVdawCmu7nbmCSHRUpNclYyqKHlVFp/eiL7KwAlQbRmKsXVdLtwIeWNa7i1JdbEzo6x2Fw2QSydFecSthFMcRjmlzwyw1TJp2pXZJIU00sCb79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+wwYx/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384FFC4AF09;
	Thu,  8 Aug 2024 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723118469;
	bh=gP4R16BRIcbMR+0pYw7dESQgcRJSVgigc3N/GXIIO14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I+wwYx/jjWBB6t4pR7DTbDMLEW1mP1voiCpPSA9lW/Whu3sMDVpFNIi144NjplCOd
	 HcHISDqAKKMmT7AREA5TKmga7kc24/eZJ/UWDWvhjwJkwuRwUK1WmqciV1LETEy4N7
	 NjySAYTI9XANzT7lupaGSvnIRDLv2YOBTUo8PwD+XrdWQBz7k5KenhPr3hUXZKWr+F
	 2e+dqBrZItOLXBjXpQDAVhA+KPf/pnYQyYlNjb2rKe6pVKBFhs8eJQu9xeB8cRfi3q
	 SDlCJbG6dm+y/aTjC507yrE6/d6WfdwrLSEvgcV+RW4rZKn8qRMXvK5w1C+XkWe4FQ
	 zfBmvaug7YJ9A==
Message-ID: <2f37c577c26c69f23345153576b2e1270115d63d.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: move error choice for incorrect object types
 to version-specific code.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Date: Thu, 08 Aug 2024 08:01:08 -0400
In-Reply-To: <172311720624.6062.2536215919435526773@noble.neil.brown.name>
References: <>, <aab4166ae13a4453ea18644da6cc260e41f1b49f.camel@kernel.org>
	 <172311720624.6062.2536215919435526773@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 21:40 +1000, NeilBrown wrote:
> On Thu, 08 Aug 2024, Jeff Layton wrote:
> > On Mon, 2024-07-29 at 11:47 +1000, NeilBrown wrote:
> > > If an NFS operation expect a particular sort of object (file, dir, li=
nk,
> > > etc) but gets a file handle for a different sort of object, it must
> > > return an error.  The actual error varies among version in no-trivial
> > > ways.
> > >=20
> > > For v2 and v3 there are ISDIR and NOTDIR errors, and for any else, on=
ly
> > > INVAL is suitable.
> > >=20
> > > For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYML=
INK
> > > was found when not expected.  This take precedence over NOTDIR.
> > >=20
> > > For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
> > > preference to EINVAL when none of the specific error codes apply.
> > >=20
> > > When nfsd_mode_check() finds a symlink where it expect a directory it
> > > needs to return an error code that can be converted to NOTDIR for v2 =
or
> > > v3 but will be SYMLINK for v4.  It must be different from the error
> > > code returns when it finds a symlink but expects a regular file - tha=
t
> > > must be converted to EINVAL or SYMLINK.
> > >=20
> > > So we introduce an internal error code nfserr_symlink_not_dir which e=
ach
> > > version converts as appropriate.
> > >=20
> > > We also allow nfserr_wrong_type to be returned by
> > > nfsd_check_obj_is_reg() in nfsv4 code) and nfsd_mode_check().  This a
> > > behavioural change as nfsd_check_obj_is_reg() would previously return
> > > nfserr_symiink for non-directory objects that aren't regular files.  =
Now
> > > it will return nfserr_wrong_type for objects that aren't regular,
> > > directory, symlink (so char-special, block-special, sockets), which i=
s
> > > mapped to nfserr_inval for NFSv4.0.  This should not be a problem as =
the
> > > behaviour is supported by RFCs.
> > >=20
> > > As a result of these changes, nfsd_mode_check() doesn't need an rqstp
> > > arg any more.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs3proc.c |  8 ++++++++
> > >  fs/nfsd/nfs4proc.c | 24 ++++++++++++++++--------
> > >  fs/nfsd/nfsd.h     |  5 +++++
> > >  fs/nfsd/nfsfh.c    | 16 +++++++---------
> > >  fs/nfsd/nfsproc.c  |  7 +++++++
> > >  5 files changed, 43 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > > index 31bd9bcf8687..ac7ee24415a3 100644
> > > --- a/fs/nfsd/nfs3proc.c
> > > +++ b/fs/nfsd/nfs3proc.c
> > > @@ -38,6 +38,14 @@ static __be32 map_status(__be32 status)
> > >  	case nfserr_file_open:
> > >  		status =3D nfserr_acces;
> > >  		break;
> > > +
> > > +	case nfserr_symlink_not_dir:
> > > +		status =3D nfserr_notdir;
> > > +		break;
> > > +	case nfserr_symlink:
> > > +	case nfserr_wrong_type:
> > > +		status =3D nfserr_inval;
> > > +		break;
> > >  	}
> > >  	return status;
> > >  }
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 46bd20fe5c0f..cc715438e77a 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -166,14 +166,9 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh=
 *fh)
> > >  		return nfs_ok;
> > >  	if (S_ISDIR(mode))
> > >  		return nfserr_isdir;
> > > -	/*
> > > -	 * Using err_symlink as our catch-all case may look odd; but
> > > -	 * there's no other obvious error for this case in 4.0, and we
> > > -	 * happen to know that it will cause the linux v4 client to do
> > > -	 * the right thing on attempts to open something other than a
> > > -	 * regular file.
> > > -	 */
> > > -	return nfserr_symlink;
> > > +	if (S_ISLNK(mode))
> > > +		return nfserr_symlink;
> > > +	return nfserr_wrong_type;
> > >  }
> > > =20
> > >  static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_s=
tate *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
> > > @@ -184,6 +179,17 @@ static void nfsd4_set_open_owner_reply_cache(str=
uct nfsd4_compound_state *cstate
> > >  			&resfh->fh_handle);
> > >  }
> > > =20
> > > +static __be32 map_status(__be32 status, int minor)
> > > +{
> > > +	if (status =3D=3D nfserr_wrong_type &&
> > > +	    minor =3D=3D 0)
> > > +		/* RFC5661 - 15.1.2.9 */
> > > +		status =3D nfserr_inval;
> > > +
> > > +	if (status =3D=3D nfserr_symlink_not_dir)
> > > +		status =3D nfserr_symlink;
> > > +	return status;
> > > +}
> > >  static inline bool nfsd4_create_is_exclusive(int createmode)
> > >  {
> > >  	return createmode =3D=3D NFS4_CREATE_EXCLUSIVE ||
> > > @@ -2798,6 +2804,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> > >  			nfsd4_encode_replay(resp->xdr, op);
> > >  			status =3D op->status =3D op->replay->rp_status;
> > >  		} else {
> > > +			op->status =3D map_status(op->status,
> > > +						cstate->minorversion);
> > >  			nfsd4_encode_operation(resp, op);
> > >  			status =3D op->status;
> > >  		}
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 593c34fd325a..3c8c8da063b0 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -349,6 +349,11 @@ enum {
> > >  	NFSERR_REPLAY_CACHE,
> > >  #define	nfserr_replay_cache	cpu_to_be32(NFSERR_REPLAY_CACHE)
> > > =20
> > > +/* symlink found where dir expected - handled differently to
> > > + * other symlink found errors by NFSv3.
> > > + */
> > > +	NFSERR_SYMLINK_NOT_DIR,
> > > +#define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
> > >  };
> > > =20
> > >  /* Check for dir entries '.' and '..' */
> > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > index 0130103833e5..8cd70f93827c 100644
> > > --- a/fs/nfsd/nfsfh.c
> > > +++ b/fs/nfsd/nfsfh.c
> > > @@ -62,8 +62,7 @@ static int nfsd_acceptable(void *expv, struct dentr=
y *dentry)
> > >   * the write call).
> > >   */
> > >  static inline __be32
> > > -nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
> > > -		umode_t requested)
> > > +nfsd_mode_check(struct dentry *dentry, umode_t requested)
> > >  {
> > >  	umode_t mode =3D d_inode(dentry)->i_mode & S_IFMT;
> > > =20
> > > @@ -76,17 +75,16 @@ nfsd_mode_check(struct svc_rqst *rqstp, struct de=
ntry *dentry,
> > >  		}
> > >  		return nfs_ok;
> > >  	}
> > > -	/*
> > > -	 * v4 has an error more specific than err_notdir which we should
> > > -	 * return in preference to err_notdir:
> > > -	 */
> > > -	if (rqstp->rq_vers =3D=3D 4 && mode =3D=3D S_IFLNK)
> > > +	if (mode =3D=3D S_IFLNK) {
> > > +		if (requested =3D=3D S_IFDIR)
> > > +			return nfserr_symlink_not_dir;
> > >  		return nfserr_symlink;
> > > +	}
> > >  	if (requested =3D=3D S_IFDIR)
> > >  		return nfserr_notdir;
> > >  	if (mode =3D=3D S_IFDIR)
> > >  		return nfserr_isdir;
> > > -	return nfserr_inval;
> > > +	return nfserr_wrong_type;
> > >  }
> > > =20
> > >  static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int fla=
gs)
> > > @@ -362,7 +360,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *=
fhp, umode_t type, int access)
> > >  	if (error)
> > >  		goto out;
> > > =20
> > > -	error =3D nfsd_mode_check(rqstp, dentry, type);
> > > +	error =3D nfsd_mode_check(dentry, type);
> > >  	if (error)
> > >  		goto out;
> > > =20
> > > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > > index cb7099c6dc78..3d65ab558091 100644
> > > --- a/fs/nfsd/nfsproc.c
> > > +++ b/fs/nfsd/nfsproc.c
> > > @@ -25,6 +25,13 @@ static __be32 map_status(__be32 status)
> > >  	case nfserr_file_open:
> > >  		status =3D nfserr_acces;
> > >  		break;
> > > +	case nfserr_symlink_not_dir:
> > > +		status =3D nfserr_notdir;
> > > +		break;
> > > +	case nfserr_symlink:
> > > +	case nfserr_wrong_type:
> > > +		status =3D nfserr_inval;
> > > +		break;
> > >  	}
> > >  	return status;
> > >  }
> >=20
> > Hi Neil,
> >=20
> > I'm seeing a set of failures in pynfs with this patch (json results
> > attached). I haven't looked in detail yet, but we should probably drop
> > this one for now.
>=20
> Most of the complaints are because pynfs is expecting the incorrect
> error code that nfsd currently returns, rather than the correct one that
> my patch makes it return.
>=20
> There is one where the internal error code of 10101 leaks out.  That is
> NFSERR_SYMLNK_NOT_DIR.
> That certainly requires investigation.
>=20

I'm not sure these error code changes are correct, now that I look. For
instance:

        {
            "classname": "st_readlink",
            "code": "RDLK2r",
            "failure": {
                "err": "Traceback (most recent call last):\n  File \"/data/=
pynfs/nfs4.0/lib/testmod.py\", line 234, in run\n    self.runtest(self, env=
ironment)\n  File \"/data/pynfs/nfs4.0/servertests/st_readlink.py\", line 2=
9, in testFile\n    check(res, NFS4ERR_INVAL, \"READLINK on non-symlink obj=
ects\")\n  File \"/data/pynfs/nfs4.0/servertests/environment.py\", line 270=
, in check\n    raise testmod.FailureException(msg)\ntestmod.FailureExcepti=
on: READLINK on non-symlink objects should return NFS4ERR_INVAL, instead go=
t NFS4ERR_WRONG_TYPE\n",
                "message": "READLINK on non-symlink objects should return N=
FS4ERR_INVAL, instead got NFS4ERR_WRONG_TYPE"
            },
            "name": "testFile",
            "time": "0.003440380096435547"
        },


Looking at RFC7530, the READLINK section (16.25.5) says:

   The READLINK operation is only allowed on objects of type NF4LNK.
   The server should return the error NFS4ERR_INVAL if the object is not
   of type NF4LNK.

Several OPEN cases have errors similar to this one:

        {
            "classname": "st_open",
            "code": "OPEN7s",
            "failure": {
                "err": "Traceback (most recent call last):\n  File \"/data/=
pynfs/nfs4.0/lib/testmod.py\", line 234, in run\n    self.runtest(self, env=
ironment)\n  File \"/data/pynfs/nfs4.0/servertests/st_open.py\", line 183, =
in testSocket\n    check(res, NFS4ERR_SYMLINK, \"Trying to OPEN socket\")\n=
  File \"/data/pynfs/nfs4.0/servertests/environment.py\", line 270, in chec=
k\n    raise testmod.FailureException(msg)\ntestmod.FailureException: Tryin=
g to OPEN socket should return NFS4ERR_SYMLINK, instead got NFS4ERR_INVAL\n=
",
                "message": "Trying to OPEN socket should return NFS4ERR_SYM=
LINK, instead got NFS4ERR_INVAL"
            },
            "name": "testSocket",
            "time": "0.006421566009521484"
        },

RFC7530, 16.16.6:

   If the component provided to OPEN resolves to something other than a
   regular file (or a named attribute), an error will be returned to the
   client.  If it is a directory, NFS4ERR_ISDIR is returned; otherwise,
   NFS4ERR_SYMLINK is returned.  Note that NFS4ERR_SYMLINK is returned
   for both symlinks and for special files of other types; NFS4ERR_INVAL
   would be inappropriate, since the arguments provided by the client
   were correct, and the client cannot necessarily know at the time it
   sent the OPEN that the component would resolve to a non-regular file.

--=20
Jeff Layton <jlayton@kernel.org>


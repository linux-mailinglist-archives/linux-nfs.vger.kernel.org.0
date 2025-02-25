Return-Path: <linux-nfs+bounces-10334-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F9A43F6E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FCA3BAF93
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4FE1DF759;
	Tue, 25 Feb 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD3zlFqE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750422571AD
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486722; cv=none; b=CWmKsfwgJbH1Uq0ULjn3ZsrLtyP9oAZLb6fvm3BggMVm9DBrEbwd27kiqSCz4hx7xNkxrMFXjas3KdnLOO6HkS0SX3rMua/0+PoARzb8rQpYnL5cPVkBN1uLg/GygF4EKM2VKGklB2KcoOdlgG08d3nVTC2+cmF6Kf1V7r6SLaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486722; c=relaxed/simple;
	bh=jtwB8JhSJqQqzHHi+EL63PHxiXLypMIo9e/ik+f1P3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b71Ll3F4l5kzs+NxYdSWaIs77cdkLHwegmAOWf2+yPcXpQhnzpyW6SaR4PyUckUQBYas7IP6Rm6F0prkGsZ2WScc81sX7yxePy04UrHFqcCkmOjvJ8trvf0WtKEAMi6SjMNycqE9DzUBAuwnGe5wt6CR9UGr9dSN64ru4+YA1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD3zlFqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BD9C4CEDD;
	Tue, 25 Feb 2025 12:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740486721;
	bh=jtwB8JhSJqQqzHHi+EL63PHxiXLypMIo9e/ik+f1P3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=vD3zlFqEcB3Umo8KYXLrL8OnmuAuvJ3BT+gxA1oeJQ5GTLRlHtxa1mC6euII2XpCy
	 G4UCA4v+8liTh0duIADx/9f0udQdYEVO29ADpcvKN/jE6g+jEQlIvLepMjpb7Ulea0
	 eMSgYg6kcNuPQBFWpcPNV2vdcp5whBcAPGHHiSqEfStp/lrBx/yz8qQUfPaSFIjY74
	 kRygjOkPlPbubqmzuW5pzNuLeIt13HVMBRZNfAQqs3yThtg5MY0yxkaDE/ri0pX65E
	 7GOGIYOIZenWbkgZ185b+VIfDIRliwoQa/adewoixwbD0i+OcnCt5Y0+jzzBdIFUA9
	 4V+ahTzzIFkpA==
Message-ID: <2b65654e1e06125ba0b02b0beca3771896d4ab5f.camel@kernel.org>
Subject: Re: [PATCH V2 2/2] NFSD: allow client to use write delegation
 stateid for READ
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neilb@suse.de, 
	okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Date: Tue, 25 Feb 2025 07:31:59 -0500
In-Reply-To: <5d54e75f-7c98-4181-a738-dd1844461b6d@oracle.com>
References: <1740181340-14562-1-git-send-email-dai.ngo@oracle.com>
	 <1740181340-14562-3-git-send-email-dai.ngo@oracle.com>
	 <dba0a1c365e0e3276639f7682bf07b3d3e593456.camel@kernel.org>
	 <5d54e75f-7c98-4181-a738-dd1844461b6d@oracle.com>
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

On Mon, 2025-02-24 at 17:10 -0800, Dai Ngo wrote:
> On 2/24/25 7:48 AM, Jeff Layton wrote:
> > On Fri, 2025-02-21 at 15:42 -0800, Dai Ngo wrote:
> > > Allow READ using write delegation stateid granted on OPENs with
> > > OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
> > > implementation may unavoidably do (e.g., due to buffer cache
> > > constraints).
> > >=20
> > > When the server offers a write delegation for an OPEN with
> > > OPEN4_SHARE_ACCESS_WRITE, the file access mode, the nfs4_file
> > > and nfs4_ol_stateid are upgraded as if the OPEN was sent with
> > > OPEN4_SHARE_ACCESS_BOTH.
> > >=20
> > > When this delegation is returned or revoked, the corresponding open
> > > stateid is looked up and if it's found then the file access mode,
> > > the nfs4_file and nfs4_ol_stateid are downgraded to remove the read
> > > access.
> > >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/nfs4state.c | 62 ++++++++++++++++++++++++++++++++++++++++++=
+++
> > >   fs/nfsd/state.h     |  2 ++
> > >   2 files changed, 64 insertions(+)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index b533225e57cf..0c14f902c54c 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -6126,6 +6126,51 @@ nfs4_delegation_stat(struct nfs4_delegation *d=
p, struct svc_fh *currentfh,
> > >   	return rc =3D=3D 0;
> > >   }
> > >  =20
> > > +/*
> > > + * Upgrade file access mode to include FMODE_READ. This is called on=
ly when
> > > + * a write delegation is granted for an OPEN with OPEN4_SHARE_ACCESS=
_WRITE.
> > > + */
> > > +static void
> > > +nfs4_upgrade_rdwr_file_access(struct nfs4_ol_stateid *stp)
> > > +{
> > > +	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > > +	struct nfsd_file *nflp;
> > > +	struct file *file;
> > > +
> > > +	spin_lock(&fp->fi_lock);
> > > +	nflp =3D fp->fi_fds[O_WRONLY];
> > > +	file =3D nflp->nf_file;
> > > +	file->f_mode |=3D FMODE_READ;
> > You can't just do this. Open upgrade/downgrade doesn't exist at the VFS
> > layer currently. It might work with most local filesystems, but more
> > complex filesystems have significant context attached to a file. Just
> > because you've changed it here, doesn't mean that you will _actually_
> > be able to do reads using it.
>=20
> I think allowing read using a write delegation from a OPEN with
> WRONLY is an optional feature and is not a requirement from the
> spec. So if there are filesystems that do not allow this feature
> to work then it is ok; we did not introduce any new problems with
> this feature.
>

This patch is swapping the O_RDWR fd in the nfsd4_file with an O_WRONLY
one that has had FMODE_READ added. That will break on filesystems that
don't actually allow you to do reads on a filp that was opened
O_WRONLY.

> >=20
> > This might even be actively unsafe, as you're bypassing permissions
> > checks here. You never checked whether the file is readable. What if
> > it's write only? Same clients will do an ACCESS check before allowing
> > it, but a hostile actor might be able to exploit this.
>=20
> Apparently the NFS server relies on the NFS client to do permission
> check at time the file is opened. Once the permission check passes and
> the OPEN is successful, then there is no permission check on READ/WRITE.
>=20
> I wrote this pynfs test to verify:
>=20
> def testReadOnWrOnlyFile(t, env):
>      """Test read using open stateid with OPEN4_SHARE_ACCESS_WRITE
>         on file with permission 0222
>=20
>      FLAGS: writedelegations deleg
>      CODE: DELEG28
>      """
>=20
>      # create a file with write-only mode (0222)
>      sess =3D env.c1.new_client_session(b"%s_2" % env.testname(t))
>      filename =3D env.testname(t)
>      res =3D open_create_file(sess, filename, open_create=3DOPEN4_CREATE,
>              attrs=3D{FATTR4_MODE: 0o222}, access=3DOPEN4_SHARE_ACCESS_WR=
ITE, want_deleg=3DFalse)
>      check(res)
>=20
>      # write file content
>      fh =3D res.resarray[-1].object
>      stateid =3D res.resarray[-2].stateid
>      data =3D b"write test data"
>      res =3D write_file(sess, fh, data, 0, stateid)
>      check(res)
>=20
>      # close the file
>      res =3D close_file(sess, fh, stateid)
>      check(res)
>=20
>      # OPEN file with OPEN4_SHARE_ACCESS_WRITE
>      access =3D OPEN4_SHARE_ACCESS_WRITE|OPEN4_SHARE_ACCESS_WANT_NO_DELEG
>      res =3D open_file(sess, filename, access =3D access, want_deleg =3D =
True)

nit: shouldn't want_deleg be False there?

>      check(res)
>=20
>      # READ file using open stateid
>      # Linux NFS server allows READ using open stateid from OPEN4_SHARE_A=
CCESS_WRITE.
>      # However, the file permission mode 0222 then the READ should fail!
>      stateid =3D res.resarray[-2].stateid
>      res =3D sess.compound([op.putfh(fh), op.read(stateid, 0, 10)])
>      check(res, NFS4ERR_ACCESS)
>      res =3D close_file(sess, fh, stateid)
>      check(res)
>=20
> and the test failed with:
>       "OP_READ should return NFS4ERR_ACCESS, instead got NFS4_OK"
>=20
> Am i missing something?
>=20

nfsd actually does check permissions on every READ operation via:

  nfs4_preprocess_stateid_op
     nfs4_check_file
        nfsd_permission

You may be bypassing it via the NFSD_MAY_OWNER_OVERRIDE flag. Does the
above test also fail if the file is owned by a different user than the
one running the test?

>=20
> >=20
> > I think you need to acquire a R/W open from the get-go instead when you
> > intend to grant a delegation, and just fall back to doing a O_WRONLY
> > open if that fails (and don't grant one).
> >=20
> > > +	swap(fp->fi_fds[O_RDWR], fp->fi_fds[O_WRONLY]);
> > > +	clear_access(NFS4_SHARE_ACCESS_WRITE, stp);
> > > +	set_access(NFS4_SHARE_ACCESS_BOTH, stp);
> > > +	__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);	/* incr fi_acce=
ss[O_RDONLY] */
> > > +	spin_unlock(&fp->fi_lock);
> > > +}
> > > +
> > > +/*
> > > + * Downgrade file access mode to remove FMODE_READ. This is called w=
hen
> > > + * a write delegation, granted for an OPEN with OPEN4_SHARE_ACCESS_W=
RITE,
> > > + * is returned.
> > > + */
> > > +static void
> > > +nfs4_downgrade_wronly_file_access(struct nfs4_ol_stateid *stp)
> > > +{
> > > +	struct nfs4_file *fp =3D stp->st_stid.sc_file;
> > > +	struct nfsd_file *nflp;
> > > +	struct file *file;
> > > +
> > > +	spin_lock(&fp->fi_lock);
> > > +	nflp =3D fp->fi_fds[O_RDWR];
> > > +	file =3D nflp->nf_file;
> > > +	file->f_mode &=3D ~FMODE_READ;
> > > +	swap(fp->fi_fds[O_WRONLY], fp->fi_fds[O_RDWR]);
> > > +	clear_access(NFS4_SHARE_ACCESS_BOTH, stp);
> > > +	set_access(NFS4_SHARE_ACCESS_WRITE, stp);
> > > +	spin_unlock(&fp->fi_lock);
> > > +	nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);	/* decr. fi_acces=
s[O_RDONLY] */
> > > +}
> > > +
> > >   /*
> > >    * The Linux NFS server does not offer write delegations to NFSv4.0
> > >    * clients in order to avoid conflicts between write delegations an=
d
> > > @@ -6207,6 +6252,11 @@ nfs4_open_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
> > >   		dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
> > >   		dp->dl_cb_fattr.ncf_initial_cinfo =3D nfsd4_change_attribute(&sta=
t);
> > >   		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> > > +
> > > +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) =3D=3D NFS4_S=
HARE_ACCESS_WRITE) {
> > > +			dp->dl_stateid =3D stp->st_stid.sc_stateid;
> > > +			nfs4_upgrade_rdwr_file_access(stp);
> > > +		}
> > >   	} else {
> > >   		open->op_delegate_type =3D deleg_ts ? OPEN_DELEGATE_READ_ATTRS_DE=
LEG :
> > >   						    OPEN_DELEGATE_READ;
> > > @@ -7710,6 +7760,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struc=
t nfsd4_compound_state *cstate,
> > >   	struct nfs4_stid *s;
> > >   	__be32 status;
> > >   	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> > > +	struct nfs4_ol_stateid *stp;
> > > +	struct nfs4_stid *stid;
> > >  =20
> > >   	if ((status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0))=
)
> > >   		return status;
> > > @@ -7724,6 +7776,16 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstate,
> > >  =20
> > >   	trace_nfsd_deleg_return(stateid);
> > >   	destroy_delegation(dp);
> > > +
> > > +	if (dp->dl_stateid.si_generation && dp->dl_stateid.si_opaque.so_id)=
 {
> > > +		if (!nfsd4_lookup_stateid(cstate, &dp->dl_stateid,
> > > +				SC_TYPE_OPEN, 0, &stid, nn)) {
> > > +			stp =3D openlockstateid(stid);
> > > +			nfs4_downgrade_wronly_file_access(stp);
> > > +			nfs4_put_stid(stid);
> > > +		}
> > > +	}
> > > +
> > >   	smp_mb__after_atomic();
> > >   	wake_up_var(d_inode(cstate->current_fh.fh_dentry));
> > >   put_stateid:
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index 74d2d7b42676..3f2f1b92db66 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -207,6 +207,8 @@ struct nfs4_delegation {
> > >  =20
> > >   	/* for CB_GETATTR */
> > >   	struct nfs4_cb_fattr    dl_cb_fattr;
> > > +
> > > +	stateid_t		dl_stateid;  /* open stateid */
> > >   };
> > >  =20
> > >   static inline bool deleg_is_read(u32 dl_type)

--=20
Jeff Layton <jlayton@kernel.org>


Return-Path: <linux-nfs+bounces-10498-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A998A54A0F
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B65E169692
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14161DC9BB;
	Thu,  6 Mar 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2Oi2n1j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC234156225
	for <linux-nfs@vger.kernel.org>; Thu,  6 Mar 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261941; cv=none; b=uHoiL92yMG4cnjDWzrv66u40pOXpsy6rWVmG3qKTHLHksKLtK+BebU8tLFT6aqbLSWtQD44igA7k1zeq7/02IF+sCK/P06ON0S9UP2zU3fEQFbUdFWBi0Bx8APDgieHd2V3dqb+hwaR5xXZxzgwbx420wNUtKYc9DEgr2tGxsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261941; c=relaxed/simple;
	bh=je9XwBiZyM0HhJoY/UCFFeddKRzYN3s9xMH4QOuofiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aa+S3LGeb9s82KRxNyX4j6+rwvemvxnZiYAusclLIw6uS6a4uiHaQEWq/ymuQxDnEhJTlULeiwQhk1kNoiGZrufnvM/zUT+p1d7H77+Mc0fJpTDZ5v8t/s8rJUXvHVcr6bKs75BMcvbmMidmyglJVM/YIQqbISpHpYrSYi301Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2Oi2n1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B16C4CEE0;
	Thu,  6 Mar 2025 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261941;
	bh=je9XwBiZyM0HhJoY/UCFFeddKRzYN3s9xMH4QOuofiA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z2Oi2n1jy0s/Hvgy4JnZBeedkwaX4cocxY7f2dZOi8zp5YdTbPAfj+cnBt+yDlBSZ
	 KtnvzcbUdGTDqBg76ywOsAqzevk2RDfuC6p/MVx5um4HmX96841SRFbsBDMGTCdClw
	 ng+lZrto4lvtvXeUj5mvFleYXM/OrCkphL3yE/d8BWlbjlQVdGdqQScOvFxvrENjsR
	 UWW2LL6AzAAJybomeeK8evFhhZskCpBE5on/GPGb4+RHo/czFLFOHdROozjqOfhAQ9
	 XOgim5sGsGuc1kQu9mVQVa7ESRP6gUfTHYKgcg+9qUpAhyAMeF88JNHNM5/h2eDarf
	 v5FKuRjVmgi9g==
Message-ID: <30e405d15a33d2fd809a6e8daa8c5bc01e677b84.camel@kernel.org>
Subject: Re: [PATCH V4 2/2] NFSD: allow client to use write delegation
 stateid for READ
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, 
	neilb@suse.de, okorniev@redhat.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, sagi@grimberg.me
Date: Thu, 06 Mar 2025 06:52:19 -0500
In-Reply-To: <deb67458-fe9e-4303-b310-587b404c9d80@oracle.com>
References: <1741120693-2517-1-git-send-email-dai.ngo@oracle.com>
	 <1741120693-2517-3-git-send-email-dai.ngo@oracle.com>
	 <22c1c21fde3a5b17851207664571341e3dcfc315.camel@kernel.org>
	 <ac7d9408-c1fd-4f4b-88a3-162a9f3cf176@oracle.com>
	 <24582f1bb0778852feea0e676b7db163019c1b4b.camel@kernel.org>
	 <96135388-c965-45b0-8c81-03b680136757@oracle.com>
	 <deb67458-fe9e-4303-b310-587b404c9d80@oracle.com>
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

On Wed, 2025-03-05 at 12:59 -0800, Dai Ngo wrote:
> On 3/5/25 12:47 PM, Dai Ngo wrote:
> >=20
> > On 3/5/25 8:08 AM, Jeff Layton wrote:
> > > On Wed, 2025-03-05 at 09:46 -0500, Chuck Lever wrote:
> > > > On 3/5/25 9:34 AM, Jeff Layton wrote:
> > > > > On Tue, 2025-03-04 at 12:38 -0800, Dai Ngo wrote:
> > > > > > Allow READ using write delegation stateid granted on OPENs with
> > > > > > OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRI=
TE
> > > > > > implementation may unavoidably do (e.g., due to buffer cache
> > > > > > constraints).
> > > > > >=20
> > > > > > For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_W=
RITE
> > > > > > a new nfsd_file and a struct file are allocated to use for read=
s.
> > > > > > The nfsd_file is freed when the file is closed by release_all_a=
ccess.
> > > > > >=20
> > > > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > > > ---
> > > > > > =C2=A0 fs/nfsd/nfs4state.c | 44=20
> > > > > > ++++++++++++++++++++++++++++++++++++--------
> > > > > > =C2=A0 1 file changed, 36 insertions(+), 8 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index b533225e57cf..35018af4e7fb 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -6126,6 +6126,34 @@ nfs4_delegation_stat(struct nfs4_delegat=
ion=20
> > > > > > *dp, struct svc_fh *currentfh,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc =3D=3D 0;
> > > > > > =C2=A0 }
> > > > > > =C2=A0 +/*
> > > > > > + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted =
on=20
> > > > > > OPEN
> > > > > > + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_fi=
le and
> > > > > > + * struct file to be used for read with delegation stateid.
> > > > > > + *
> > > > > > + */
> > > > > > +static bool
> > > > > > +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct=
=20
> > > > > > nfsd4_open *open,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_fh *fh, struct nfs4_o=
l_stateid *stp)
> > > > > > +{
> > > > > > +=C2=A0=C2=A0=C2=A0 struct nfs4_file *fp;
> > > > > > +=C2=A0=C2=A0=C2=A0 struct nfsd_file *nf =3D NULL;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0 if ((open->op_share_access & NFS4_SHARE_ACC=
ESS_BOTH) =3D=3D
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 NFS4_SHARE_ACCESS_WRITE) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nfsd_file_acqui=
re_opened(rqstp, fh, NFSD_MAY_READ,=20
> > > > > > NULL, &nf))
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return (false);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp =3D stp->st_stid=
.sc_file;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&fp->fi_l=
ock);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __nfs4_file_get_acc=
ess(fp, NFS4_SHARE_ACCESS_READ);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_access(NFS4_SHA=
RE_ACCESS_READ, stp);
> > > The only other (minor) issue is that this might be problematic vs.
> > > DENY_READ modes:
> > >=20
> > > Suppose someone opens the file SHARE_ACCESS_WRITE and gets back a r/w
> > > delegation. Then someone else tries to open the file
> > > SHARE_ACCESS_READ|SHARE_DENY_READ. That should succeed, AFAICT, but I
> > > think with this patch that would fail because we check the deny mode
> > > before doing the open (and revoking the delegation).
> > >=20
> > > It'd be good to test and see if that's the case.
> >=20
> > Yes, you're correct. The 2nd OPEN fails due to the read access set
> > to the file in nfsd4_add_rdaccess_to_wrdeleg().
> >=20
> > I think the deny mode is used only by SMB and not Linux client, not
> > sure though. What should we do about this, any thought?

Deny modes are a Windows/DOS thing, but they are part of the NFSv4 spec
too. Linux doesn't have a userland interface that allows you to set
them, and they aren't plumbed through the VFS layer, so you can still
do an open locally on the box, even if a deny mode is set. I _think_
BSD might also have support at the VFS layer for share/deny locking but
I don't know for sure.

>=20
> Without this patch, nfsd does not hand out the write delegation and don't
> set the read access so the 2nd OPEN would work. But is that the correct
> behavior because the open stateid of the 1st OPEN is allowed to do read?
>=20

That's a good question.

The main reason the server might allow reads on an O_WRONLY open is
because the client may need to do a RMW cycle if it's doing page-
aligned buffered I/Os. The client really shouldn't allow userland to do
an O_WRONLY open and start issuing read() calls on it, however. So,
from that standpoint I think the original behavior of knfsd does
conform to the spec.

To fix this the right way, we probably need to make the implicit
O_WRONLY -> O_RDRW upgrade for a delegation take some sort of "shadow"
reference. IOW, we need to be able to use the O_RDONLY file internally
and put its reference when the file is closed, but we don't want to
count that reference toward share/deny mode enforcement.=20

>=20
> >=20
> > >=20
> > >=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp =3D stp->st_stid=
.sc_file;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp->fi_fds[O_RDONLY=
] =3D nf;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&fp->fi=
_lock);
> > > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > > +=C2=A0=C2=A0=C2=A0 return (true);
> > > > > no need for parenthesis here ^^^
> >=20
> > Fixed.
> >=20
> > > > >=20
> > > > > > +}
> > > > > > +
> > > > > > =C2=A0 /*
> > > > > > =C2=A0=C2=A0 * The Linux NFS server does not offer write delega=
tions to NFSv4.0
> > > > > > =C2=A0=C2=A0 * clients in order to avoid conflicts between writ=
e delegations=20
> > > > > > and
> > > > > > @@ -6151,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegati=
on=20
> > > > > > *dp, struct svc_fh *currentfh,
> > > > > > =C2=A0=C2=A0 * open or lock state.
> > > > > > =C2=A0=C2=A0 */
> > > > > > =C2=A0 static void
> > > > > > -nfs4_open_delegation(struct nfsd4_open *open, struct=20
> > > > > > nfs4_ol_stateid *stp,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct svc_fh *currentfh)
> > > > > > +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open=
=20
> > > > > > *open,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct svc_fh *fh)
> > > > > > =C2=A0 {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool deleg_ts =3D open->op_deleg=
_want &=20
> > > > > > OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfs4_openowner *oo =3D op=
enowner(stp->st_stateowner);
> > > > > > @@ -6197,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open=
=20
> > > > > > *open, struct nfs4_ol_stateid *stp,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(&open->op_delegate_statei=
d, &dp->dl_stid.sc_stateid,=20
> > > > > > sizeof(dp->dl_stid.sc_stateid));
> > > > > > =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (open->op_share_access=
 & NFS4_SHARE_ACCESS_WRITE) {
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!nfs4_delegatio=
n_stat(dp, currentfh, &stat)) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((!nfsd4_add_rda=
ccess_to_wrdeleg(rqstp, open, fh,=20
> > > > > > stp)) ||
> > > > > extra set of parens above too ^^^
> >=20
> > Fixed.
> >=20
> > > > >=20
> > > > > > + !nfs4_delegation_stat(dp, currentfh, &stat)) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nfs4_put_stid(&dp->dl_stid);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 destroy_delegation(dp);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out_no_deleg;
> > > > > > @@ -6353,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqst=
p,=20
> > > > > > struct svc_fh *current_fh, struct nf
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Attempt to hand out a delegati=
on. No error return, because=20
> > > > > > the
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * OPEN succeeds even if we fail.
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > -=C2=A0=C2=A0=C2=A0 nfs4_open_delegation(open, stp, &resp->csta=
te.current_fh);
> > > > > > +=C2=A0=C2=A0=C2=A0 nfs4_open_delegation(rqstp, open, stp,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &resp->cstate.curre=
nt_fh, current_fh);
> > > > > > =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If there is an existing =
open stateid, it must be updated and
> > > > > > @@ -7098,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int =
flags)
> > > > > > =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (s->sc_type) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SC_TYPE_DELEG:
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&s->sc_fi=
le->fi_lock);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nfsd_file_g=
et(s->sc_file->fi_deleg_file);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&s->sc_=
file->fi_lock);
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SC_TYPE_OPEN:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SC_TYPE_LOCK:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flag=
s & RD_STATE)
> > > > > > @@ -7277,6 +7304,7 @@ nfs4_preprocess_stateid_op(struct svc_rqs=
t=20
> > > > > > *rqstp,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =
=3D find_cpntf_state(nn, stateid, &s);
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return s=
tatus;
> > > > > > +
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D nfsd4_stid_check_stat=
eid_generation(stateid, s,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 nfsd4_has_session(cstate));
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status)
> > > > > Patch itself looks good though, so with the nits fixed up, you ca=
n=20
> > > > > add:
> > > > >=20
> > > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > Dai, I can fix the parentheses in my tree, no need for a v5.
> >=20
> > Thanks Chuck, I will fold these patches into one to avoid potential
> > bisect issue before sending out v5.
> >=20
> > -Dai
> >=20
> > > >=20
> > > >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>


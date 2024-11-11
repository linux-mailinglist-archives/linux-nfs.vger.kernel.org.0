Return-Path: <linux-nfs+bounces-7876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AE9C4588
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307D5282BA1
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8E1AA7B1;
	Mon, 11 Nov 2024 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeC92Sei"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A23155301;
	Mon, 11 Nov 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351768; cv=none; b=SDOpbO2kL1bUxDVndP08Q+z7gAeEmDTxukeZ1DowD0Z9eXgnSa1nxgW2KDNcTvTnZ29xTPwld4FDOUjzsFCMnsWka94RVtDcg7AK1M3wtjpkiYuJgbfz686lN8pREYbqh9f/nXP0GQTgAVnpxHIUB/dMTOTrXSmjkkZ3VL5zFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351768; c=relaxed/simple;
	bh=Tlc3I336ecsvT3/IZ0Gl4e7ymp2adAZD/tyCEC3GcAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ll0ITYCzVn9J4+BGGCTEc0RjSw8Il5tnRxuLotztvZCS+b00fpTiTNgNUnMFZJRry4Rt5pdjqrn7YEmP2i1yTJMAOcDHtKVI7O8wXAilhcr29h2ZyYkBoI14f/Yn1qT+uUCidvrW1nfbShae9rDQBgDczr8oyveuyLXxq9MYyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeC92Sei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26DBC4CECF;
	Mon, 11 Nov 2024 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731351768;
	bh=Tlc3I336ecsvT3/IZ0Gl4e7ymp2adAZD/tyCEC3GcAo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WeC92SeiLzrjtVEQtjPLJOEyi7wJZamAEtfp8piG1ntscwDqLuXXKdu6Acc9XzGfb
	 LHTy/HSj+O5xzH5uoJKQZIhUjm88mwdlG1K5o0k5vtbtC+ne1OThe1ozqVd6zmyzeT
	 qfeYqimA81s1xlMUagopiEfT2kGQWo0viFlYzQax31K8Y4Acq0PPQ4uaTaDigAnx86
	 VSCFX40kNegwXZ5afvAmWhAaNXT5xEPcgfBWeV75XeyM86uwhD03iyC2Rbofx5jD4Y
	 Apfu4WsCnFKp0LWEWZXCTl6x7DnXn6Lfv28StPwXsx7noJvHMfRtpavdFybv8CPRjl
	 Hme60LC6qw4rQ==
Message-ID: <0db24bcf7795600cb05b9a75a2288b88d7b19ce2.camel@kernel.org>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Olga Kornievskaia
 <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 14:02:46 -0500
In-Reply-To: <CAN-5tyG_LiYP4aqEGSCyj8boDRE74+Y_A08Q-=3us-Uh2T+NLA@mail.gmail.com>
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
	 <CAN-5tyEEfJ5p=NUaj+ubzCijq+d9vxT9EBVHvwQYgF=CMtrNTw@mail.gmail.com>
	 <59e803abae0b7441c1440ebd4657e573b1c02dd2.camel@kernel.org>
	 <CAN-5tyH8xw6XtpnXELJfrxibN3P=xRax31pCexcuOtBMZhooxw@mail.gmail.com>
	 <b7f6454176746f5e7a8d75ba41be71e46590a08c.camel@kernel.org>
	 <ZzIa5q8cG5LYW5D7@tissot.1015granger.net>
	 <CAN-5tyGc-jHHCQwLNAH4mFFUqZqdieygCbe+ux7rww5PC7qjMw@mail.gmail.com>
	 <83b950633c5b7f6949939a4d51581196b5757c07.camel@kernel.org>
	 <CAN-5tyEh6MrTBQQt99+VO4FcnX3x1DX7XOpRwmkXFryqzr95Jw@mail.gmail.com>
	 <3c60acaa79ec27ed1ecb8fdc42a2cb75c75c0a25.camel@kernel.org>
	 <14e6f6af974c5c17884c418560f385d051d7bdf7.camel@kernel.org>
	 <CAN-5tyG_LiYP4aqEGSCyj8boDRE74+Y_A08Q-=3us-Uh2T+NLA@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-11 at 13:55 -0500, Olga Kornievskaia wrote:
> On Mon, Nov 11, 2024 at 1:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Mon, 2024-11-11 at 13:17 -0500, Jeff Layton wrote:
> > > On Mon, 2024-11-11 at 12:56 -0500, Olga Kornievskaia wrote:
> > > > On Mon, Nov 11, 2024 at 12:40=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > >=20
> > > > > On Mon, 2024-11-11 at 12:17 -0500, Olga Kornievskaia wrote:
> > > > > > On Mon, Nov 11, 2024 at 9:56=E2=80=AFAM Chuck Lever <chuck.leve=
r@oracle.com> wrote:
> > > > > > >=20
> > > > > > > On Mon, Nov 11, 2024 at 08:22:07AM -0500, Jeff Layton wrote:
> > > > > > > > On Sun, 2024-11-10 at 21:19 -0500, Olga Kornievskaia wrote:
> > > > > > > > > On Sat, Nov 9, 2024 at 2:26=E2=80=AFPM Jeff Layton <jlayt=
on@kernel.org> wrote:
> > > > > > > > > >=20
> > > > > > > > > > On Sat, 2024-11-09 at 13:50 -0500, Olga Kornievskaia wr=
ote:
> > > > > > > > > > > On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <j=
layton@kernel.org> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > nfsd currently only uses a single slot in the callb=
ack channel, which is
> > > > > > > > > > > > proving to be a bottleneck in some cases. Widen the=
 callback channel to
> > > > > > > > > > > > a max of 32 slots (subject to the client's target_m=
axreqs value).
> > > > > > > > > > > >=20
> > > > > > > > > > > > Change the cb_holds_slot boolean to an integer that=
 tracks the current
> > > > > > > > > > > > slot number (with -1 meaning "unassigned").  Move t=
he callback slot
> > > > > > > > > > > > tracking info into the session. Add a new u32 that =
acts as a bitmap to
> > > > > > > > > > > > track which slots are in use, and a u32 to track th=
e latest callback
> > > > > > > > > > > > target_slotid that the client reports. To protect t=
he new fields, add
> > > > > > > > > > > > a new per-session spinlock (the se_lock). Fix nfsd4=
1_cb_get_slot to always
> > > > > > > > > > > > search for the lowest slotid (using ffs()).
> > > > > > > > > > > >=20
> > > > > > > > > > > > Finally, convert the session->se_cb_seq_nr field in=
to an array of
> > > > > > > > > > > > counters and add the necessary handling to ensure t=
hat the seqids get
> > > > > > > > > > > > reset at the appropriate times.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > v3 has a bug that Olga hit in testing. This version=
 should fix the wait
> > > > > > > > > > > > when the slot table is full. Olga, if you're able t=
o test this one, it
> > > > > > > > > > > > would be much appreciated.
> > > > > > > > > > > > ---
> > > > > > > > > > > > Changes in v4:
> > > > > > > > > > > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > > > > > > > > > > - Link to v3: https://lore.kernel.org/r/20241030-bc=
wide-v3-0-c2df49a26c45@kernel.org
> > > > > > > > > > > >=20
> > > > > > > > > > > > Changes in v3:
> > > > > > > > > > > > - add patch to convert se_flags to single se_dead b=
ool
> > > > > > > > > > > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TA=
BLE_MAX
> > > > > > > > > > > > - don't reject target highest slot value of 0
> > > > > > > > > > > > - Link to v2: https://lore.kernel.org/r/20241029-bc=
wide-v2-1-e9010b6ef55d@kernel.org
> > > > > > > > > > > >=20
> > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > - take cl_lock when fetching fields from session to=
 be encoded
> > > > > > > > > > > > - use fls() instead of bespoke highest_unset_index(=
)
> > > > > > > > > > > > - rename variables in several functions with more d=
escriptive names
> > > > > > > > > > > > - clamp limit of for loop in update_cb_slot_table()
> > > > > > > > > > > > - re-add missing rpc_wake_up_queued_task() call
> > > > > > > > > > > > - fix slotid check in decode_cb_sequence4resok()
> > > > > > > > > > > > - add new per-session spinlock
> > > > > > > > > > > > ---
> > > > > > > > > > > >  fs/nfsd/nfs4callback.c | 113 +++++++++++++++++++++=
+++++++++++++++-------------
> > > > > > > > > > > >  fs/nfsd/nfs4state.c    |  11 +++--
> > > > > > > > > > > >  fs/nfsd/state.h        |  15 ++++---
> > > > > > > > > > > >  fs/nfsd/trace.h        |   2 +-
> > > > > > > > > > > >  4 files changed, 101 insertions(+), 40 deletions(-=
)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4c=
allback.c
> > > > > > > > > > > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a=
678333907eaa92db305dada503704c34c15b2 100644
> > > > > > > > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > > > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > > > > > > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct =
xdr_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
> > > > > > > > > > > >         hdr->nops++;
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > > +static u32 highest_slotid(struct nfsd4_session *se=
s)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +       u32 idx;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > > +       idx =3D fls(~ses->se_cb_slot_avail);
> > > > > > > > > > > > +       if (idx > 0)
> > > > > > > > > > > > +               --idx;
> > > > > > > > > > > > +       idx =3D max(idx, ses->se_cb_highest_slot);
> > > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > > +       return idx;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  /*
> > > > > > > > > > > >   * CB_SEQUENCE4args
> > > > > > > > > > > >   *
> > > > > > > > > > > > @@ -432,15 +445,35 @@ static void encode_cb_sequenc=
e4args(struct xdr_stream *xdr,
> > > > > > > > > > > >         encode_sessionid4(xdr, session);
> > > > > > > > > > > >=20
> > > > > > > > > > > >         p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 =
+ 4);
> > > > > > > > > > > > -       *p++ =3D cpu_to_be32(session->se_cb_seq_nr)=
;      /* csa_sequenceid */
> > > > > > > > > > > > -       *p++ =3D xdr_zero;                        /=
* csa_slotid */
> > > > > > > > > > > > -       *p++ =3D xdr_zero;                        /=
* csa_highest_slotid */
> > > > > > > > > > > > +       *p++ =3D cpu_to_be32(session->se_cb_seq_nr[=
cb->cb_held_slot]);    /* csa_sequenceid */
> > > > > > > > > > > > +       *p++ =3D cpu_to_be32(cb->cb_held_slot);    =
       /* csa_slotid */
> > > > > > > > > > > > +       *p++ =3D cpu_to_be32(highest_slotid(session=
)); /* csa_highest_slotid */
> > > > > > > > > > > >         *p++ =3D xdr_zero;                        /=
* csa_cachethis */
> > > > > > > > > > > >         xdr_encode_empty_array(p);              /* =
csa_referring_call_lists */
> > > > > > > > > > > >=20
> > > > > > > > > > > >         hdr->nops++;
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > > +static void update_cb_slot_table(struct nfsd4_sess=
ion *ses, u32 target)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +       /* No need to do anything if nothing change=
d */
> > > > > > > > > > > > +       if (likely(target =3D=3D READ_ONCE(ses->se_=
cb_highest_slot)))
> > > > > > > > > > > > +               return;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > > +       if (target > ses->se_cb_highest_slot) {
> > > > > > > > > > > > +               int i;
> > > > > > > > > > > > +
> > > > > > > > > > > > +               target =3D min(target, NFSD_BC_SLOT=
_TABLE_MAX);
> > > > > > > > > > > > +
> > > > > > > > > > > > +               /* Growing the slot table. Reset an=
y new sequences to 1 */
> > > > > > > > > > > > +               for (i =3D ses->se_cb_highest_slot =
+ 1; i <=3D target; ++i)
> > > > > > > > > > > > +                       ses->se_cb_seq_nr[i] =3D 1;
> > > > > > > > > > > > +       }
> > > > > > > > > > > > +       ses->se_cb_highest_slot =3D target;
> > > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  /*
> > > > > > > > > > > >   * CB_SEQUENCE4resok
> > > > > > > > > > > >   *
> > > > > > > > > > > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4r=
esok(struct xdr_stream *xdr,
> > > > > > > > > > > >         struct nfsd4_session *session =3D cb->cb_cl=
p->cl_cb_session;
> > > > > > > > > > > >         int status =3D -ESERVERFAULT;
> > > > > > > > > > > >         __be32 *p;
> > > > > > > > > > > > -       u32 dummy;
> > > > > > > > > > > > +       u32 seqid, slotid, target;
> > > > > > > > > > > >=20
> > > > > > > > > > > >         /*
> > > > > > > > > > > >          * If the server returns different values f=
or sessionID, slotID or
> > > > > > > > > > > > @@ -484,21 +517,22 @@ static int decode_cb_sequence=
4resok(struct xdr_stream *xdr,
> > > > > > > > > > > >         }
> > > > > > > > > > > >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > > > > > > > > > > >=20
> > > > > > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > > > > > -       if (dummy !=3D session->se_cb_seq_nr) {
> > > > > > > > > > > > +       seqid =3D be32_to_cpup(p++);
> > > > > > > > > > > > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb=
_held_slot]) {
> > > > > > > > > > > >                 dprintk("NFS: %s Invalid sequence n=
umber\n", __func__);
> > > > > > > > > > > >                 goto out;
> > > > > > > > > > > >         }
> > > > > > > > > > > >=20
> > > > > > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > > > > > -       if (dummy !=3D 0) {
> > > > > > > > > > > > +       slotid =3D be32_to_cpup(p++);
> > > > > > > > > > > > +       if (slotid !=3D cb->cb_held_slot) {
> > > > > > > > > > > >                 dprintk("NFS: %s Invalid slotid\n",=
 __func__);
> > > > > > > > > > > >                 goto out;
> > > > > > > > > > > >         }
> > > > > > > > > > > >=20
> > > > > > > > > > > > -       /*
> > > > > > > > > > > > -        * FIXME: process highest slotid and target=
 highest slotid
> > > > > > > > > > > > -        */
> > > > > > > > > > > > +       p++; // ignore current highest slot value
> > > > > > > > > > > > +
> > > > > > > > > > > > +       target =3D be32_to_cpup(p++);
> > > > > > > > > > > > +       update_cb_slot_table(session, target);
> > > > > > > > > > > >         status =3D 0;
> > > > > > > > > > > >  out:
> > > > > > > > > > > >         cb->cb_seq_status =3D status;
> > > > > > > > > > > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(s=
truct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > > > > >         spin_unlock(&clp->cl_lock);
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > > +static int grab_slot(struct nfsd4_session *ses)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +       int idx;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > > +       idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > > > > > > > > > > > +       if (idx < 0 || idx > ses->se_cb_highest_slo=
t) {
> > > > > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > > > > +               return -1;
> > > > > > > > > > > > +       }
> > > > > > > > > > > > +       /* clear the bit for the slot */
> > > > > > > > > > > > +       ses->se_cb_slot_avail &=3D ~BIT(idx);
> > > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > > +       return idx;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  /*
> > > > > > > > > > > >   * There's currently a single callback channel slo=
t.
> > > > > > > > > > > >   * If the slot is available, then mark it busy.  O=
therwise, set the
> > > > > > > > > > > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(=
struct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > > > > >  static bool nfsd41_cb_get_slot(struct nfsd4_callba=
ck *cb, struct rpc_task *task)
> > > > > > > > > > > >  {
> > > > > > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_se=
ssion;
> > > > > > > > > > > >=20
> > > > > > > > > > > > -       if (!cb->cb_holds_slot &&
> > > > > > > > > > > > -           test_and_set_bit(0, &clp->cl_cb_slot_bu=
sy) !=3D 0) {
> > > > > > > > > > > > +       if (cb->cb_held_slot >=3D 0)
> > > > > > > > > > > > +               return true;
> > > > > > > > > > > > +       cb->cb_held_slot =3D grab_slot(ses);
> > > > > > > > > > > > +       if (cb->cb_held_slot < 0) {
> > > > > > > > > > > >                 rpc_sleep_on(&clp->cl_cb_waitq, tas=
k, NULL);
> > > > > > > > > > > >                 /* Race breaker */
> > > > > > > > > > > > -               if (test_and_set_bit(0, &clp->cl_cb=
_slot_busy) !=3D 0) {
> > > > > > > > > > > > -                       dprintk("%s slot is busy\n"=
, __func__);
> > > > > > > > > > > > +               cb->cb_held_slot =3D grab_slot(ses)=
;
> > > > > > > > > > > > +               if (cb->cb_held_slot < 0)
> > > > > > > > > > > >                         return false;
> > > > > > > > > > > > -               }
> > > > > > > > > > > >                 rpc_wake_up_queued_task(&clp->cl_cb=
_waitq, task);
> > > > > > > > > > > >         }
> > > > > > > > > > > > -       cb->cb_holds_slot =3D true;
> > > > > > > > > > > >         return true;
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > >  static void nfsd41_cb_release_slot(struct nfsd4_ca=
llback *cb)
> > > > > > > > > > > >  {
> > > > > > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_se=
ssion;
> > > > > > > > > > > >=20
> > > > > > > > > > > > -       if (cb->cb_holds_slot) {
> > > > > > > > > > > > -               cb->cb_holds_slot =3D false;
> > > > > > > > > > > > -               clear_bit(0, &clp->cl_cb_slot_busy)=
;
> > > > > > > > > > > > +       if (cb->cb_held_slot >=3D 0) {
> > > > > > > > > > > > +               spin_lock(&ses->se_lock);
> > > > > > > > > > > > +               ses->se_cb_slot_avail |=3D BIT(cb->=
cb_held_slot);
> > > > > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > > > > +               cb->cb_held_slot =3D -1;
> > > > > > > > > > > >                 rpc_wake_up_next(&clp->cl_cb_waitq)=
;
> > > > > > > > > > > >         }
> > > > > > > > > > > >  }
> > > > > > > > > > > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb=
(struct nfsd4_callback *cb)
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > >  /*
> > > > > > > > > > > > - * TODO: cb_sequence should support referring call=
 lists, cachethis, multiple
> > > > > > > > > > > > - * slots, and mark callback channel down on commun=
ication errors.
> > > > > > > > > > > > + * TODO: cb_sequence should support referring call=
 lists, cachethis,
> > > > > > > > > > > > + * and mark callback channel down on communication=
 errors.
> > > > > > > > > > > >   */
> > > > > > > > > > > >  static void nfsd4_cb_prepare(struct rpc_task *task=
, void *calldata)
> > > > > > > > > > > >  {
> > > > > > > > > > > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence=
_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > > >                 return true;
> > > > > > > > > > > >         }
> > > > > > > > > > > >=20
> > > > > > > > > > > > -       if (!cb->cb_holds_slot)
> > > > > > > > > > > > +       if (cb->cb_held_slot < 0)
> > > > > > > > > > > >                 goto need_restart;
> > > > > > > > > > > >=20
> > > > > > > > > > > >         /* This is the operation status code for CB=
_SEQUENCE */
> > > > > > > > > > > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequen=
ce_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > > >                  * If CB_SEQUENCE returns an error,=
 then the state of the slot
> > > > > > > > > > > >                  * (sequence ID, cached reply) MUST=
 NOT change.
> > > > > > > > > > > >                  */
> > > > > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held=
_slot];
> > > > > > > > > > > >                 break;
> > > > > > > > > > > >         case -ESERVERFAULT:
> > > > > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held=
_slot];
> > > > > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > > > > >                 ret =3D false;
> > > > > > > > > > > >                 break;
> > > > > > > > > > > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequen=
ce_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > > >         case -NFS4ERR_BADSLOT:
> > > > > > > > > > > >                 goto retry_nowait;
> > > > > > > > > > > >         case -NFS4ERR_SEQ_MISORDERED:
> > > > > > > > > > > > -               if (session->se_cb_seq_nr !=3D 1) {
> > > > > > > > > > > > -                       session->se_cb_seq_nr =3D 1=
;
> > > > > > > > > > > > +               if (session->se_cb_seq_nr[cb->cb_he=
ld_slot] !=3D 1) {
> > > > > > > > > > > > +                       session->se_cb_seq_nr[cb->c=
b_held_slot] =3D 1;
> > > > > > > > > > > >                         goto retry_nowait;
> > > > > > > > > > > >                 }
> > > > > > > > > > > >                 break;
> > > > > > > > > > > >         default:
> > > > > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > > > > >         }
> > > > > > > > > > > > -       nfsd41_cb_release_slot(cb);
> > > > > > > > > > > > -
> > > > > > > > > > > >         trace_nfsd_cb_free_slot(task, cb);
> > > > > > > > > > > > +       nfsd41_cb_release_slot(cb);
> > > > > > > > > > > >=20
> > > > > > > > > > > >         if (RPC_SIGNALLED(task))
> > > > > > > > > > > >                 goto need_restart;
> > > > > > > > > > > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfs=
d4_callback *cb, struct nfs4_client *clp,
> > > > > > > > > > > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > > > > > > > > > > >         cb->cb_status =3D 0;
> > > > > > > > > > > >         cb->cb_need_restart =3D false;
> > > > > > > > > > > > -       cb->cb_holds_slot =3D false;
> > > > > > > > > > > > +       cb->cb_held_slot =3D -1;
> > > > > > > > > > > >  }
> > > > > > > > > > > >=20
> > > > > > > > > > > >  /**
> > > > > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4stat=
e.c
> > > > > > > > > > > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..755=
57e7cc9265517f51952563beaa4cfe8adcc3f 100644
> > > > > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > > > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *=
alloc_session(struct nfsd4_channel_attrs *fattrs,
> > > > > > > > > > > >         }
> > > > > > > > > > > >=20
> > > > > > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(st=
ruct nfsd4_channel_attrs));
> > > > > > > > > > > > +       new->se_cb_slot_avail =3D ~0U;
> > > > > > > > > > > > +       new->se_cb_highest_slot =3D battrs->maxreqs=
 - 1;
> > > > > > > > > > > > +       spin_lock_init(&new->se_lock);
> > > > > > > > > > > >         return new;
> > > > > > > > > > > >  out_free:
> > > > > > > > > > > >         while (i--)
> > > > > > > > > > > > @@ -2132,11 +2135,14 @@ static void init_session(st=
ruct svc_rqst *rqstp, struct nfsd4_session *new, stru
> > > > > > > > > > > >=20
> > > > > > > > > > > >         INIT_LIST_HEAD(&new->se_conns);
> > > > > > > > > > > >=20
> > > > > > > > > > > > -       new->se_cb_seq_nr =3D 1;
> > > > > > > > > > > > +       atomic_set(&new->se_ref, 0);
> > > > > > > > > > > >         new->se_dead =3D false;
> > > > > > > > > > > >         new->se_cb_prog =3D cses->callback_prog;
> > > > > > > > > > > >         new->se_cb_sec =3D cses->cb_sec;
> > > > > > > > > > > > -       atomic_set(&new->se_ref, 0);
> > > > > > > > > > > > +
> > > > > > > > > > > > +       for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MA=
X; ++idx)
> > > > > > > > > > > > +               new->se_cb_seq_nr[idx] =3D 1;
> > > > > > > > > > > > +
> > > > > > > > > > > >         idx =3D hash_sessionid(&new->se_sessionid);
> > > > > > > > > > > >         list_add(&new->se_hash, &nn->sessionid_hash=
tbl[idx]);
> > > > > > > > > > > >         spin_lock(&clp->cl_lock);
> > > > > > > > > > > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *cr=
eate_client(struct xdr_netobj name,
> > > > > > > > > > > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > > > > > > > > > > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, =
NFSPROC4_CLNT_CB_NULL);
> > > > > > > > > > > >         clp->cl_time =3D ktime_get_boottime_seconds=
();
> > > > > > > > > > > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > > > > >         copy_verf(clp, verf);
> > > > > > > > > > > >         memcpy(&clp->cl_addr, sa, sizeof(struct soc=
kaddr_storage));
> > > > > > > > > > > >         clp->cl_cb_session =3D NULL;
> > > > > > > > > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > > > > > > > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848=
d023cb308f0b69916c4ee34b09075708f0de3 100644
> > > > > > > > > > > > --- a/fs/nfsd/state.h
> > > > > > > > > > > > +++ b/fs/nfsd/state.h
> > > > > > > > > > > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > > > > > > > > > > >         struct work_struct cb_work;
> > > > > > > > > > > >         int cb_seq_status;
> > > > > > > > > > > >         int cb_status;
> > > > > > > > > > > > +       int cb_held_slot;
> > > > > > > > > > > >         bool cb_need_restart;
> > > > > > > > > > > > -       bool cb_holds_slot;
> > > > > > > > > > > >  };
> > > > > > > > > > > >=20
> > > > > > > > > > > >  struct nfsd4_callback_ops {
> > > > > > > > > > > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > > > > > > > > > > >         unsigned char cn_flags;
> > > > > > > > > > > >  };
> > > > > > > > > > > >=20
> > > > > > > > > > > > +/* Highest slot index that nfsd implements in NFSv=
4.1+ backchannel */
> > > > > > > > > > > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - =
1)
> > > > > > > > > > >=20
> > > > > > > > > > > Are there some values that are known not to work? I w=
as experimenting
> > > > > > > > > > > with values and set it to 2 and 4 and the kernel oops=
ed. I understand
> > > > > > > > > > > it's not a configurable value but it would still be g=
ood to know the
> > > > > > > > > > > expectations...
> > > > > > > > > > >=20
> > > > > > > > > > > [  198.625021] Unable to handle kernel paging request=
 at virtual
> > > > > > > > > > > address dfff800020000000
> > > > > > > > > > > [  198.625870] KASAN: probably user-memory-access in =
range
> > > > > > > > > > > [0x0000000100000000-0x0000000100000007]
> > > > > > > > > > > [  198.626444] Mem abort info:
> > > > > > > > > > > [  198.626630]   ESR =3D 0x0000000096000005
> > > > > > > > > > > [  198.626882]   EC =3D 0x25: DABT (current EL), IL =
=3D 32 bits
> > > > > > > > > > > [  198.627234]   SET =3D 0, FnV =3D 0
> > > > > > > > > > > [  198.627441]   EA =3D 0, S1PTW =3D 0
> > > > > > > > > > > [  198.627627]   FSC =3D 0x05: level 1 translation fa=
ult
> > > > > > > > > > > [  198.627859] Data abort info:
> > > > > > > > > > > [  198.628000]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =
=3D 0x00000000
> > > > > > > > > > > [  198.628272]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagA=
ccess =3D 0
> > > > > > > > > > > [  198.628619]   GCS =3D 0, Overlay =3D 0, DirtyBit =
=3D 0, Xs =3D 0
> > > > > > > > > > > [  198.628967] [dfff800020000000] address between use=
r and kernel address ranges
> > > > > > > > > > > [  198.629438] Internal error: Oops: 0000000096000005=
 [#1] SMP
> > > > > > > > > > > [  198.629806] Modules linked in: rpcsec_gss_krb5 nfs=
v4 dns_resolver
> > > > > > > > > > > nfs netfs nfnetlink_queue nfnetlink_log nfnetlink blu=
etooth cfg80211
> > > > > > > > > > > rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss =
nfs_acl lockd
> > > > > > > > > > > grace isofs uinput snd_seq_dummy snd_hrtimer vsock_lo=
opback
> > > > > > > > > > > vmw_vsock_virtio_transport_common qrtr rfkill vmw_vso=
ck_vmci_transport
> > > > > > > > > > > vsock sunrpc vfat fat snd_hda_codec_generic snd_hda_i=
ntel
> > > > > > > > > > > snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep=
 snd_seq uvcvideo
> > > > > > > > > > > videobuf2_vmalloc snd_seq_device videobuf2_memops uvc=
 videobuf2_v4l2
> > > > > > > > > > > videodev snd_pcm videobuf2_common mc snd_timer snd vm=
w_vmci soundcore
> > > > > > > > > > > xfs libcrc32c vmwgfx drm_ttm_helper ttm nvme drm_kms_=
helper
> > > > > > > > > > > crct10dif_ce nvme_core ghash_ce sha2_ce sha256_arm64 =
sha1_ce drm
> > > > > > > > > > > nvme_auth sr_mod cdrom e1000e sg fuse
> > > > > > > > > > > [  198.633799] CPU: 5 UID: 0 PID: 6081 Comm: nfsd Kdu=
mp: loaded Not
> > > > > > > > > > > tainted 6.12.0-rc6+ #47
> > > > > > > > > > > [  198.634345] Hardware name: VMware, Inc. VMware20,1=
/VBSA, BIOS
> > > > > > > > > > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > > > > > > > > > [  198.635014] pstate: 11400005 (nzcV daif +PAN -UAO =
-TCO +DIT -SSBS BTYPE=3D--)
> > > > > > > > > > > [  198.635492] pc : nfsd4_sequence+0x5a0/0x1f60 [nfsd=
]
> > > > > > > > > > > [  198.635798] lr : nfsd4_sequence+0x340/0x1f60 [nfsd=
]
> > > > > > > > > > > [  198.636065] sp : ffff8000884977e0
> > > > > > > > > > > [  198.636234] x29: ffff800088497910 x28: ffff0000b1b=
39280 x27: ffff0000ab508128
> > > > > > > > > > > [  198.636624] x26: ffff0000b1b39298 x25: ffff0000b1b=
39290 x24: ffff0000a65e1c64
> > > > > > > > > > > [  198.637049] x23: 1fffe000212e6804 x22: ffff0001097=
34024 x21: 1ffff00011092f16
> > > > > > > > > > > [  198.637472] x20: ffff00010aed8000 x19: ffff0001097=
34000 x18: 1fffe0002de20c8b
> > > > > > > > > > > [  198.637883] x17: 0100000000000000 x16: 1ffff0000fc=
ef234 x15: 1fffe000212e600f
> > > > > > > > > > > [  198.638286] x14: ffff80007e779000 x13: ffff80007e7=
791a0 x12: 0000000000000000
> > > > > > > > > > > [  198.638697] x11: ffff0000a65e1c38 x10: ffff00010ae=
daca0 x9 : 1fffe000215db594
> > > > > > > > > > > [  198.639110] x8 : 1fffe00014cbc387 x7 : ffff0000a65=
e1c03 x6 : ffff0000a65e1c00
> > > > > > > > > > > [  198.639541] x5 : ffff0000a65e1c00 x4 : 00000000200=
00000 x3 : 0000000100000001
> > > > > > > > > > > [  198.639962] x2 : ffff000109730060 x1 : 00000000000=
00003 x0 : dfff800000000000
> > > > > > > > > > > [  198.640332] Call trace:
> > > > > > > > > > > [  198.640460]  nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > > > > > [  198.640715]  nfsd4_proc_compound+0xb94/0x23b0 [nfs=
d]
> > > > > > > > > > > [  198.640997]  nfsd_dispatch+0x22c/0x718 [nfsd]
> > > > > > > > > > > [  198.641260]  svc_process_common+0x8e8/0x1968 [sunr=
pc]
> > > > > > > > > > > [  198.641566]  svc_process+0x3d4/0x7e0 [sunrpc]
> > > > > > > > > > > [  198.641827]  svc_handle_xprt+0x828/0xe10 [sunrpc]
> > > > > > > > > > > [  198.642108]  svc_recv+0x2cc/0x6a8 [sunrpc]
> > > > > > > > > > > [  198.642346]  nfsd+0x270/0x400 [nfsd]
> > > > > > > > > > > [  198.642562]  kthread+0x288/0x310
> > > > > > > > > > > [  198.642745]  ret_from_fork+0x10/0x20
> > > > > > > > > > > [  198.642937] Code: f2fbffe0 f9003be4 f94007e2 52800=
061 (38e06880)
> > > > > > > > > > > [  198.643267] SMP: stopping secondary CPUs
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Good catch. I think the problem here is that we don't c=
urrently cap the
> > > > > > > > > > initial value of se_cb_highest_slot at NFSD_BC_SLOT_TAB=
LE_MAX. Does
> > > > > > > > > > this patch prevent the panic?
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > > > index 3afe56ab9e0a..839be4ba765a 100644
> > > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > > @@ -2011,7 +2011,7 @@ static struct nfsd4_session *allo=
c_session(struct nfsd4_channel_attrs *fattrs,
> > > > > > > > > >=20
> > > > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct=
 nfsd4_channel_attrs));
> > > > > > > > > >         new->se_cb_slot_avail =3D ~0U;
> > > > > > > > > > -       new->se_cb_highest_slot =3D battrs->maxreqs - 1=
;
> > > > > > > > > > +       new->se_cb_highest_slot =3D min(battrs->maxreqs=
 - 1, NFSD_BC_SLOT_TABLE_MAX);
> > > > > > > > > >         spin_lock_init(&new->se_lock);
> > > > > > > > > >         return new;
> > > > > > > > > >  out_free:
> > > > > > > > >=20
> > > > > > > > > It does help. I thought that the CREATE_SESSION reply for=
 the
> > > > > > > > > backchannel would be guided by the NFSD_BC_SLOT_TABLE_MAX=
 value but
> > > > > > > > > instead it seems like it's not. But yes I can see that th=
e highest
> > > > > > > > > slot used by the server is capped by the NFSD_BC_SLOT_TAB=
LE_MAX value.
> > > > > > > >=20
> > > > > > > > Thanks for testing it, Olga.
> > > > > > > >=20
> > > > > > > > Chuck, would you be OK with folding the above delta into 9a=
b4c4077de9,
> > > > > > > > or would you rather I resend the patch?
> > > > > > >=20
> > > > > > > I've folded the above one-liner into the applied patch.
> > > > > > >=20
> > > > > > > I agree with Tom, I think there's probably a (surprising)
> > > > > > > explanation lurking for not seeing the expected performance
> > > > > > > improvement. I can delay sending the NFSD v6.13 merge window =
pull
> > > > > > > request for a bit to see if you can get it teased out.
> > > > > >=20
> > > > > > I would like to raise a couple of issues:
> > > > > > (1) I believe the server should be reporting back an accurate v=
alue
> > > > > > for the backchannel session table size. I think if the
> > > > > > NFSD_BC_SLOT_TABLE_MAX was way lower than the client's value th=
en the
> > > > > > client would be wasting resources for its bc session table?
> > > > >=20
> > > > > Yes, but those resources are 32-bit integer per wasted slot. The =
Linux
> > > > > client allows for up to 16 slots, so we're wasting 64 bytes per s=
ession
> > > > > with this scheme with the Linux client. I didn't think it was wor=
th
> > > > > doing a separate allocation for that.
> > > > >=20
> > > > > We could make NFSD_BC_SLOT_TABLE_MAX smaller though. Maybe we sho=
uld
> > > > > match the client's size and make it 15?
> > > > >=20
> > > > > > ->back_channel->maxreqs gets decoded in nfsd4_decode_create_ses=
sion()
> > > > > > and is never adjusted for the reply to be based on the
> > > > > > NFSD_BC_SLOT_TABLE_MAX. The problem is currently invisible beca=
use
> > > > > > linux client's bc slot table size is 16 and nfsd's is higher.
> > > > > >=20
> > > > >=20
> > > > > I'm not sure I understand the problem here. We don't care about m=
ost of
> > > > > the backchannel attributes. maxreqs is the only one that matters,=
 and
> > > > > track that in se_cb_highest_slot.
> > > >=20
> > > > Client sends a create_session with cba_back_chan_attrs with max_req=
s
> > > > of 16 -- stating that the client can handle 16 slots in it's slot
> > > > table. Server currently doesn't do anything about reflecting back t=
o
> > > > the client its session slot table. It blindly returns what the clie=
nt
> > > > sent. Say NFSD_BC_SLOT_TABLE_MAX was 4. Server would never use more
> > > > than 4 slots and yet the client would have to create a reply cache
> > > > table for 16 slots. Isn't that poor sportsmanship on behalf of the
> > > > linux server?
> > > >=20
> > > >=20
> > >=20
> > > Thanks, that does sound like a bug. I think we can fix that with
> > > another one-liner.  When we allocate the new session, update the
> > > back_channel attrs in the request with the correct maxreqs. Thoughts?
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 15438826ed5b..c35d8fc2f693 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -3885,6 +3885,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> > >       new =3D alloc_session(&cr_ses->fore_channel, &cr_ses->back_chan=
nel);
> > >       if (!new)
> > >               goto out_release_drc_mem;
> > > +     cr_ses->back_channel.maxreqs =3D new->se_cb_highest_slot;
> > >       conn =3D alloc_conn_from_crses(rqstp, cr_ses);
> > >       if (!conn)
> > >               goto out_free_session;
> >=20
> >=20
> > Actually, I think this is better, since we're already modifying things
> > in this section of the code. Also the earlier patch was off-by-one:
> >=20
> > ------------------------8<----------------------
> >=20
> > [PATCH] SQUASH: report the correct number of backchannel slots to clien=
t
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4state.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 15438826ed5b..cfc2190ffce5 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3955,6 +3955,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >         cr_ses->flags &=3D ~SESSION4_PERSIST;
> >         /* Upshifting from TCP to RDMA is not supported */
> >         cr_ses->flags &=3D ~SESSION4_RDMA;
> > +       /* Report the correct number of backchannel slots */
> > +       cr_ses->back_channel.maxreqs =3D new->se_cb_highest_slot + 1;
>=20
> Is the intent that NFSD_BC_SLOT_TABLE_MAX value represents a one off
> value? With this patch if NFSD_BC_SLOT_TABLE_MAX=3D1 the server would
> send back 2 in its CREATE_SESSION reply for the bc table size. Other
> than the wrong value, this patch would indeed reflect back server's cb
> table size.
>=20
>=20

I think the above conversion is correct.

The se_cb_highest_slot represents the highest slotid that the server
will use. IOW, it's indexed starting at 0. "maxreqs" on the other hand
represents the maximum number of requests that can be in flight, so
it's indexed starting at 1.
--=20
Jeff Layton <jlayton@kernel.org>


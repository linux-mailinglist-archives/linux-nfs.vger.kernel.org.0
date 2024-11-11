Return-Path: <linux-nfs+bounces-7879-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536789C490E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113482883EF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590815886D;
	Mon, 11 Nov 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVsfmmo5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE58150990;
	Mon, 11 Nov 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363977; cv=none; b=hA7jiA+Ty9th9OaIkjTmATFFJAZCU1dcwXJv39Ot2kqb1AE734gxeyIK3S+i0Fog5FPNrUqsr7z1GUnYSdKa9fBU56hYGHQnSI6KRae48rX4AlG6p/YGimeAcjdyfV93Qd7ZL047NLC/UjigDXgSEcHnwuGUcNy9QiNoCGNFWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363977; c=relaxed/simple;
	bh=PSv3aEekfTUakoqcOP/BsawFF+DvJ6UTKRASfVCh+Co=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V641oSi76+8Mb4p8LbWFVdofplevJhl3Plao6DnXWr+aT/ZDlHI+kDOoHVtSVvXZ681K9oKhC7NwIRQUFy5WGYQysdDzge5ZnKwItZtlCwkB48dMf6du68eNnZWed4ePbcr6/G44A/d/auKqFHMFu6ht2RGD13J8MSxq4r+xCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVsfmmo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ACCC4CECF;
	Mon, 11 Nov 2024 22:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731363977;
	bh=PSv3aEekfTUakoqcOP/BsawFF+DvJ6UTKRASfVCh+Co=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fVsfmmo5dZg75YsAkF0DOlcr22tXpctqkjCgJ5QMjF1n5XHvAlnSbYmIYIswnl2I/
	 hn7bmQAiK+l4yVm7M+FAMQkIpKZQW0krtRS9Y9DGqUvxZQddE64Y1MekzXJLUueGEr
	 gE+Vj16OkNIR5jXplEMMsDYIX/fUuiP/zn9qqwp8OctgQiDqlDZm7O19IlG8XaJCBX
	 6hGNh88s2vv77NXyIIRglKSUljB67w9L2SvCczS8G92TYKhL0pmMdYaMZLMLUmKrYu
	 BnpU+Db9rXen8EDKdyyk9RHRChdaU9LZ6elSGSQd1Knkb6Q3uwm7xvLJj1zLWsS+GC
	 pWuJIkeP3ycJg==
Message-ID: <01cf85e3093f03193d6422a3cfca7427a387058d.camel@kernel.org>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Olga Kornievskaia
 <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 17:26:15 -0500
In-Reply-To: <CAN-5tyE7Cq-1iqdeoT8T0MTjwOqGc01j+murfqR0HxpahMpGRw@mail.gmail.com>
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org>
	 <CAN-5tyHqDNRm-O+NKNXGG_J91M3vCgz8LVZWUjePpYUyy6Pmsg@mail.gmail.com>
	 <CAN-5tyE7Cq-1iqdeoT8T0MTjwOqGc01j+murfqR0HxpahMpGRw@mail.gmail.com>
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

On Mon, 2024-11-11 at 16:56 -0500, Olga Kornievskaia wrote:
> On Wed, Nov 6, 2024 at 11:44=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu=
> wrote:
> >=20
> > On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >=20
> > > nfsd currently only uses a single slot in the callback channel, which=
 is
> > > proving to be a bottleneck in some cases. Widen the callback channel =
to
> > > a max of 32 slots (subject to the client's target_maxreqs value).
> > >=20
> > > Change the cb_holds_slot boolean to an integer that tracks the curren=
t
> > > slot number (with -1 meaning "unassigned").  Move the callback slot
> > > tracking info into the session. Add a new u32 that acts as a bitmap t=
o
> > > track which slots are in use, and a u32 to track the latest callback
> > > target_slotid that the client reports. To protect the new fields, add
> > > a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to a=
lways
> > > search for the lowest slotid (using ffs()).
> > >=20
> > > Finally, convert the session->se_cb_seq_nr field into an array of
> > > counters and add the necessary handling to ensure that the seqids get
> > > reset at the appropriate times.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > v3 has a bug that Olga hit in testing. This version should fix the wa=
it
> > > when the slot table is full. Olga, if you're able to test this one, i=
t
> > > would be much appreciated.
> >=20
> > I have tested this version. I can confirm that I'm not seeing the
> > softlockup. But the server still does not use the lowest available
> > slot. It is hard for me to describe the algorithm of picking the slot
> > number (in general it still seems to be picking the next slot value,
> > even though slots have been replied to). I have seen slot 0 re-used
> > eventually but it seemed to be when the server came to using slot=3D13.
> >=20
> > The other unfortunate thing that's happening when I use these patches
> > is my test case that recalling delegations and making sure that the
> > state management gets handled properly (ie., the patch that I've
> > submitted to fix a race between the laundromat thread and free_state)
> > is not working. After all the recalls, the server still thinks it has
> > revoked state. I have to debug more to figure out what's going on.
>=20
> I have finally been able to consistently hit the problem and it's not
> a server issue but I can't decide who's at fault here -- client or
> server. While handling the fact that state is revoked the client sends
> what now is a SETATTR (for deleg attributes)+DELEGRETURN (previously
> just a DELEGRETURN). SETATTR fails with BAD_STATEID. Client doesn't do
> anything. Previously (before the deleg attr support) client would sent
> DELEGRETURN and server would fail with DELEG_REVOKED or BAD_STATEID
> and the client would follow up with FREE_STATEID. But now the client
> doesn't send a FREE_STATEID and thus the server is left with "revoked
> state which never was freed".=20
> Now, if the server returned DELEG_REVOKED instead of BAD_STATEID for
> the SETATTR then the problem doesn't happen.
>=20
> Question: is the server incorrect here or is the client incorrect and
> should have (1) either also resent the delegreturn on its own which
> was not processed before and that should have still triggered the
> free_stateid or (2) should have treated bad_stateid error of setattr
> in the delegreturn compound such that it freed the state there.
>=20
>=20

That bit does sound like a server bug. DELEG_REVOKED is a valid return
code for SETATTR. It looks like nfsd4_lookup_stateid() should be
returning DELEG_REVOKED in this situation, so I'm not sure why that's
not working right.

That said, I'm also interested in why delegations are ending up revoked
in the first place.=20

> >=20
> > > ---
> > > Changes in v4:
> > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a2=
6c45@kernel.org
> > >=20
> > > Changes in v3:
> > > - add patch to convert se_flags to single se_dead bool
> > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > > - don't reject target highest slot value of 0
> > > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6e=
f55d@kernel.org
> > >=20
> > > Changes in v2:
> > > - take cl_lock when fetching fields from session to be encoded
> > > - use fls() instead of bespoke highest_unset_index()
> > > - rename variables in several functions with more descriptive names
> > > - clamp limit of for loop in update_cb_slot_table()
> > > - re-add missing rpc_wake_up_queued_task() call
> > > - fix slotid check in decode_cb_sequence4resok()
> > > - add new per-session spinlock
> > > ---
> > >  fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++---=
----------
> > >  fs/nfsd/nfs4state.c    |  11 +++--
> > >  fs/nfsd/state.h        |  15 ++++---
> > >  fs/nfsd/trace.h        |   2 +-
> > >  4 files changed, 101 insertions(+), 40 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db30=
5dada503704c34c15b2 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, s=
truct nfs4_cb_compound_hdr *hdr,
> > >         hdr->nops++;
> > >  }
> > >=20
> > > +static u32 highest_slotid(struct nfsd4_session *ses)
> > > +{
> > > +       u32 idx;
> > > +
> > > +       spin_lock(&ses->se_lock);
> > > +       idx =3D fls(~ses->se_cb_slot_avail);
> > > +       if (idx > 0)
> > > +               --idx;
> > > +       idx =3D max(idx, ses->se_cb_highest_slot);
> > > +       spin_unlock(&ses->se_lock);
> > > +       return idx;
> > > +}
> > > +
> > >  /*
> > >   * CB_SEQUENCE4args
> > >   *
> > > @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xdr_=
stream *xdr,
> > >         encode_sessionid4(xdr, session);
> > >=20
> > >         p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > > -       *p++ =3D cpu_to_be32(session->se_cb_seq_nr);      /* csa_sequ=
enceid */
> > > -       *p++ =3D xdr_zero;                        /* csa_slotid */
> > > -       *p++ =3D xdr_zero;                        /* csa_highest_slot=
id */
> > > +       *p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot])=
;    /* csa_sequenceid */
> > > +       *p++ =3D cpu_to_be32(cb->cb_held_slot);           /* csa_slot=
id */
> > > +       *p++ =3D cpu_to_be32(highest_slotid(session)); /* csa_highest=
_slotid */
> > >         *p++ =3D xdr_zero;                        /* csa_cachethis */
> > >         xdr_encode_empty_array(p);              /* csa_referring_call=
_lists */
> > >=20
> > >         hdr->nops++;
> > >  }
> > >=20
> > > +static void update_cb_slot_table(struct nfsd4_session *ses, u32 targ=
et)
> > > +{
> > > +       /* No need to do anything if nothing changed */
> > > +       if (likely(target =3D=3D READ_ONCE(ses->se_cb_highest_slot)))
> > > +               return;
> > > +
> > > +       spin_lock(&ses->se_lock);
> > > +       if (target > ses->se_cb_highest_slot) {
> > > +               int i;
> > > +
> > > +               target =3D min(target, NFSD_BC_SLOT_TABLE_MAX);
> > > +
> > > +               /* Growing the slot table. Reset any new sequences to=
 1 */
> > > +               for (i =3D ses->se_cb_highest_slot + 1; i <=3D target=
; ++i)
> > > +                       ses->se_cb_seq_nr[i] =3D 1;
> > > +       }
> > > +       ses->se_cb_highest_slot =3D target;
> > > +       spin_unlock(&ses->se_lock);
> > > +}
> > > +
> > >  /*
> > >   * CB_SEQUENCE4resok
> > >   *
> > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_st=
ream *xdr,
> > >         struct nfsd4_session *session =3D cb->cb_clp->cl_cb_session;
> > >         int status =3D -ESERVERFAULT;
> > >         __be32 *p;
> > > -       u32 dummy;
> > > +       u32 seqid, slotid, target;
> > >=20
> > >         /*
> > >          * If the server returns different values for sessionID, slot=
ID or
> > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_=
stream *xdr,
> > >         }
> > >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > >=20
> > > -       dummy =3D be32_to_cpup(p++);
> > > -       if (dummy !=3D session->se_cb_seq_nr) {
> > > +       seqid =3D be32_to_cpup(p++);
> > > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb_held_slot]) {
> > >                 dprintk("NFS: %s Invalid sequence number\n", __func__=
);
> > >                 goto out;
> > >         }
> > >=20
> > > -       dummy =3D be32_to_cpup(p++);
> > > -       if (dummy !=3D 0) {
> > > +       slotid =3D be32_to_cpup(p++);
> > > +       if (slotid !=3D cb->cb_held_slot) {
> > >                 dprintk("NFS: %s Invalid slotid\n", __func__);
> > >                 goto out;
> > >         }
> > >=20
> > > -       /*
> > > -        * FIXME: process highest slotid and target highest slotid
> > > -        */
> > > +       p++; // ignore current highest slot value
> > > +
> > > +       target =3D be32_to_cpup(p++);
> > > +       update_cb_slot_table(session, target);
> > >         status =3D 0;
> > >  out:
> > >         cb->cb_seq_status =3D status;
> > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_client =
*clp, struct nfs4_cb_conn *conn)
> > >         spin_unlock(&clp->cl_lock);
> > >  }
> > >=20
> > > +static int grab_slot(struct nfsd4_session *ses)
> > > +{
> > > +       int idx;
> > > +
> > > +       spin_lock(&ses->se_lock);
> > > +       idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > > +       if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > > +               spin_unlock(&ses->se_lock);
> > > +               return -1;
> > > +       }
> > > +       /* clear the bit for the slot */
> > > +       ses->se_cb_slot_avail &=3D ~BIT(idx);
> > > +       spin_unlock(&ses->se_lock);
> > > +       return idx;
> > > +}
> > > +
> > >  /*
> > >   * There's currently a single callback channel slot.
> > >   * If the slot is available, then mark it busy.  Otherwise, set the
> > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_client=
 *clp, struct nfs4_cb_conn *conn)
> > >  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc=
_task *task)
> > >  {
> > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > >=20
> > > -       if (!cb->cb_holds_slot &&
> > > -           test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> > > +       if (cb->cb_held_slot >=3D 0)
> > > +               return true;
> > > +       cb->cb_held_slot =3D grab_slot(ses);
> > > +       if (cb->cb_held_slot < 0) {
> > >                 rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> > >                 /* Race breaker */
> > > -               if (test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0=
) {
> > > -                       dprintk("%s slot is busy\n", __func__);
> > > +               cb->cb_held_slot =3D grab_slot(ses);
> > > +               if (cb->cb_held_slot < 0)
> > >                         return false;
> > > -               }
> > >                 rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> > >         }
> > > -       cb->cb_holds_slot =3D true;
> > >         return true;
> > >  }
> > >=20
> > >  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> > >  {
> > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > >=20
> > > -       if (cb->cb_holds_slot) {
> > > -               cb->cb_holds_slot =3D false;
> > > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > > +       if (cb->cb_held_slot >=3D 0) {
> > > +               spin_lock(&ses->se_lock);
> > > +               ses->se_cb_slot_avail |=3D BIT(cb->cb_held_slot);
> > > +               spin_unlock(&ses->se_lock);
> > > +               cb->cb_held_slot =3D -1;
> > >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> > >         }
> > >  }
> > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_call=
back *cb)
> > >  }
> > >=20
> > >  /*
> > > - * TODO: cb_sequence should support referring call lists, cachethis,=
 multiple
> > > - * slots, and mark callback channel down on communication errors.
> > > + * TODO: cb_sequence should support referring call lists, cachethis,
> > > + * and mark callback channel down on communication errors.
> > >   */
> > >  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
> > >  {
> > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_t=
ask *task, struct nfsd4_callback
> > >                 return true;
> > >         }
> > >=20
> > > -       if (!cb->cb_holds_slot)
> > > +       if (cb->cb_held_slot < 0)
> > >                 goto need_restart;
> > >=20
> > >         /* This is the operation status code for CB_SEQUENCE */
> > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct rpc=
_task *task, struct nfsd4_callback
> > >                  * If CB_SEQUENCE returns an error, then the state of=
 the slot
> > >                  * (sequence ID, cached reply) MUST NOT change.
> > >                  */
> > > -               ++session->se_cb_seq_nr;
> > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > >                 break;
> > >         case -ESERVERFAULT:
> > > -               ++session->se_cb_seq_nr;
> > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > >                 ret =3D false;
> > >                 break;
> > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct rpc=
_task *task, struct nfsd4_callback
> > >         case -NFS4ERR_BADSLOT:
> > >                 goto retry_nowait;
> > >         case -NFS4ERR_SEQ_MISORDERED:
> > > -               if (session->se_cb_seq_nr !=3D 1) {
> > > -                       session->se_cb_seq_nr =3D 1;
> > > +               if (session->se_cb_seq_nr[cb->cb_held_slot] !=3D 1) {
> > > +                       session->se_cb_seq_nr[cb->cb_held_slot] =3D 1=
;
> > >                         goto retry_nowait;
> > >                 }
> > >                 break;
> > >         default:
> > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > >         }
> > > -       nfsd41_cb_release_slot(cb);
> > > -
> > >         trace_nfsd_cb_free_slot(task, cb);
> > > +       nfsd41_cb_release_slot(cb);
> > >=20
> > >         if (RPC_SIGNALLED(task))
> > >                 goto need_restart;
> > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, s=
truct nfs4_client *clp,
> > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > >         cb->cb_status =3D 0;
> > >         cb->cb_need_restart =3D false;
> > > -       cb->cb_holds_slot =3D false;
> > > +       cb->cb_held_slot =3D -1;
> > >  }
> > >=20
> > >  /**
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f5195=
2563beaa4cfe8adcc3f 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(stru=
ct nfsd4_channel_attrs *fattrs,
> > >         }
> > >=20
> > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel=
_attrs));
> > > +       new->se_cb_slot_avail =3D ~0U;
> > > +       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > > +       spin_lock_init(&new->se_lock);
> > >         return new;
> > >  out_free:
> > >         while (i--)
> > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqs=
tp, struct nfsd4_session *new, stru
> > >=20
> > >         INIT_LIST_HEAD(&new->se_conns);
> > >=20
> > > -       new->se_cb_seq_nr =3D 1;
> > > +       atomic_set(&new->se_ref, 0);
> > >         new->se_dead =3D false;
> > >         new->se_cb_prog =3D cses->callback_prog;
> > >         new->se_cb_sec =3D cses->cb_sec;
> > > -       atomic_set(&new->se_ref, 0);
> > > +
> > > +       for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > > +               new->se_cb_seq_nr[idx] =3D 1;
> > > +
> > >         idx =3D hash_sessionid(&new->se_sessionid);
> > >         list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
> > >         spin_lock(&clp->cl_lock);
> > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(struct=
 xdr_netobj name,
> > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_N=
ULL);
> > >         clp->cl_time =3D ktime_get_boottime_seconds();
> > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > >         copy_verf(clp, verf);
> > >         memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> > >         clp->cl_cb_session =3D NULL;
> > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b69916c=
4ee34b09075708f0de3 100644
> > > --- a/fs/nfsd/state.h
> > > +++ b/fs/nfsd/state.h
> > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > >         struct work_struct cb_work;
> > >         int cb_seq_status;
> > >         int cb_status;
> > > +       int cb_held_slot;
> > >         bool cb_need_restart;
> > > -       bool cb_holds_slot;
> > >  };
> > >=20
> > >  struct nfsd4_callback_ops {
> > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > >         unsigned char cn_flags;
> > >  };
> > >=20
> > > +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel *=
/
> > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > > +
> > >  /*
> > >   * Representation of a v4.1+ session. These are refcounted in a simi=
lar fashion
> > >   * to the nfs4_client. References are only taken when the server is =
actively
> > > @@ -314,6 +317,10 @@ struct nfsd4_conn {
> > >   */
> > >  struct nfsd4_session {
> > >         atomic_t                se_ref;
> > > +       spinlock_t              se_lock;
> > > +       u32                     se_cb_slot_avail; /* bitmap of availa=
ble slots */
> > > +       u32                     se_cb_highest_slot;     /* highest sl=
ot client wants */
> > > +       u32                     se_cb_prog;
> > >         bool                    se_dead;
> > >         struct list_head        se_hash;        /* hash by sessionid =
*/
> > >         struct list_head        se_perclnt;
> > > @@ -322,8 +329,7 @@ struct nfsd4_session {
> > >         struct nfsd4_channel_attrs se_fchannel;
> > >         struct nfsd4_cb_sec     se_cb_sec;
> > >         struct list_head        se_conns;
> > > -       u32                     se_cb_prog;
> > > -       u32                     se_cb_seq_nr;
> > > +       u32                     se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX +=
 1];
> > >         struct nfsd4_slot       *se_slots[];    /* forward channel sl=
ots */
> > >  };
> > >=20
> > > @@ -457,9 +463,6 @@ struct nfs4_client {
> > >          */
> > >         struct dentry           *cl_nfsd_info_dentry;
> > >=20
> > > -       /* for nfs41 callbacks */
> > > -       /* We currently support a single back channel with a single s=
lot */
> > > -       unsigned long           cl_cb_slot_busy;
> > >         struct rpc_wait_queue   cl_cb_waitq;    /* backchannel caller=
s may */
> > >                                                 /* wait here for slot=
s */
> > >         struct net              *net;
> > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d7f=
7b90e250c2913ab23fe 100644
> > > --- a/fs/nfsd/trace.h
> > > +++ b/fs/nfsd/trace.h
> > > @@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
> > >                 __entry->cl_id =3D sid->clientid.cl_id;
> > >                 __entry->seqno =3D sid->sequence;
> > >                 __entry->reserved =3D sid->reserved;
> > > -               __entry->slot_seqno =3D session->se_cb_seq_nr;
> > > +               __entry->slot_seqno =3D session->se_cb_seq_nr[cb->cb_=
held_slot];
> > >         ),
> > >         TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
> > >                 " sessionid=3D%08x:%08x:%08x:%08x new slot seqno=3D%u=
",
> > >=20
> > > ---
> > > base-commit: 3c16aac09d20f9005fbb0e737b3ec520bbb5badd
> > > change-id: 20241025-bcwide-6bd7e4b63db2
> > >=20
> > > Best regards,
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> > >=20
> > >=20

--=20
Jeff Layton <jlayton@kernel.org>


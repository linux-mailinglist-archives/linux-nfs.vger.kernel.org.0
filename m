Return-Path: <linux-nfs+bounces-7844-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AB9C3676
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 03:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9427A2808F7
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC21F931;
	Mon, 11 Nov 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="qYE1XoqU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCD1BC41;
	Mon, 11 Nov 2024 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731291616; cv=none; b=L79m6pjcJpI48UdYeEB66KKCyV/rjfwhhhVPgNtDmeKt4C2oEdA/Pwkdgp/Z13pRz96DA6yrpWtAuN+rne6IikG2i5hiXHfK8KL5q4J4Ty5y0s5t+zChGqLt//qy6XvVLFmuwJikY7EdSkJwFb5iD0Ci9BbcaUkIAA8etAq96A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731291616; c=relaxed/simple;
	bh=b5iYI6B32PGmgd6d/6P8zOnBnWLsCeGfbaPGzQ/jA8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmJfCrGeMmHdGB179/z3/BExpNYSzw8YFJAwOQ2UYQfNDmqgX8XJ2U/oeTY/ueRHzusMruRfeDP3vQWoKsfkfoLIY9mkoxDD02R8NcthJFRVR1jciEPbYbEL+IP3tftjOLwuRCRNciQVCnT6oAWjP2fMw/v9R5AJ8FB4N5DOrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=qYE1XoqU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e13375d3so4622189e87.3;
        Sun, 10 Nov 2024 18:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1731291611; x=1731896411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rZEuNUJAT0rKHb4UzJyw5SNRJ/SFtQ+SpEL36sep+8=;
        b=qYE1XoqUxjPI00raKZ3e1woV9/F8fJfkhXwFRwJrkTD2MOAa/mqfjs2IIuwDgLZz9f
         7nJD4UH/WBaGl3/AMbdaPtQMf4NbE2goj0bcPnoUFOPYWbJo0boHKpn49UfuMNcOIz4V
         TLslyhViQdwlvN0oLutI5B6PQifD3mYFJ0ejnCb5ki1XggYc6kBC4WR1CXRCA2QL/Z5S
         uDxBW0nYELd2ss8fDw/Nr5Wgfe2jpo0ecC4c8+xktt8ocCMe1S8Ibh6wWAT+uQWqnrLs
         +DYAKWxnt9M1rdqcuIseqI1fguoCWJIDgdvJ70z0+U4ipgNdc3Oj+oHgwrbv4uerUAZP
         /EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731291611; x=1731896411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rZEuNUJAT0rKHb4UzJyw5SNRJ/SFtQ+SpEL36sep+8=;
        b=iIYeSp1oHBX4sVsXGeDP6zcszzuYdKW3WjiN9OnwNcPtUg0alx+oTf93asKQuTfrFb
         WIEGA79BFppuZZ2fTvPHdrTmUMO4Cvbqn4q+I8FygLnn2aHJbwVd+gQT6MTzafrX8c2V
         MT7mN4X0JWhAWh0NAh1yalDiJcJgZeeZ6zADZ2mCbsdnK5ioCuLNuHiYXHemYt6dpyEv
         tN9ZokE4CpijZhwVUcHOWTe5E7iosZcfpHQA7XlKQOlPozCyMUH1zXEDGSaqaWIapJav
         79KNLZHhnGqH20GfcotBRXj4w0DR99JB7Ze/2pSO5WtAkLO+R2Ib7+J+NbJUPY6y9Emt
         ncmA==
X-Forwarded-Encrypted: i=1; AJvYcCUfqMKhpS3goaQ1y/mJt5g/Btl1qKRyCDAN4h3hVT4KSWJ5Te0PPCCG69L+AwKgmybBeGONUsL2Zy1w@vger.kernel.org, AJvYcCVfp3jAxE4taw/b+lkQuAP9C2X+myPcxDSeAwh3xDIPyxEPENBGCCQUr4F6JMXjVcJYXOBgknEV13far8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAj36jTsgmy2FCwiGZsw0cWbv8rgI74fzPBIgG/hs9OxR0JmO
	R7DgiQkDJxYMC2+YIPIwQt7NBmCAE8HAYzNdecrE56aAH7ATwEm0rGnAY9d4b25TMCIU4uQDSFC
	5yp+9l87+NeZUR9WEdlJk7QuVJRk=
X-Google-Smtp-Source: AGHT+IEA64bhN5scPcnwN9JtBCj21bX/m+hrNEljkyCrtz/Ag92qPLfFXrdG+Dvox0CpnMcIE07HYG3mWfKawVz7Bvw=
X-Received: by 2002:a2e:a98c:0:b0:2fa:beb5:11cc with SMTP id
 38308e7fff4ca-2ff20284925mr38916611fa.40.1731291611025; Sun, 10 Nov 2024
 18:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org> <CAN-5tyEEfJ5p=NUaj+ubzCijq+d9vxT9EBVHvwQYgF=CMtrNTw@mail.gmail.com>
 <59e803abae0b7441c1440ebd4657e573b1c02dd2.camel@kernel.org>
In-Reply-To: <59e803abae0b7441c1440ebd4657e573b1c02dd2.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Sun, 10 Nov 2024 21:19:59 -0500
Message-ID: <CAN-5tyH8xw6XtpnXELJfrxibN3P=xRax31pCexcuOtBMZhooxw@mail.gmail.com>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 2:26=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2024-11-09 at 13:50 -0500, Olga Kornievskaia wrote:
> > On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > nfsd currently only uses a single slot in the callback channel, which=
 is
> > > proving to be a bottleneck in some cases. Widen the callback channel =
to
> > > a max of 32 slots (subject to the client's target_maxreqs value).
> > >
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
> > >
> > > Finally, convert the session->se_cb_seq_nr field into an array of
> > > counters and add the necessary handling to ensure that the seqids get
> > > reset at the appropriate times.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > > v3 has a bug that Olga hit in testing. This version should fix the wa=
it
> > > when the slot table is full. Olga, if you're able to test this one, i=
t
> > > would be much appreciated.
> > > ---
> > > Changes in v4:
> > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a2=
6c45@kernel.org
> > >
> > > Changes in v3:
> > > - add patch to convert se_flags to single se_dead bool
> > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > > - don't reject target highest slot value of 0
> > > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6e=
f55d@kernel.org
> > >
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
> > >
> > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db30=
5dada503704c34c15b2 100644
> > > --- a/fs/nfsd/nfs4callback.c
> > > +++ b/fs/nfsd/nfs4callback.c
> > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, s=
truct nfs4_cb_compound_hdr *hdr,
> > >         hdr->nops++;
> > >  }
> > >
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
> > >
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
> > >
> > >         hdr->nops++;
> > >  }
> > >
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
> > >
> > >         /*
> > >          * If the server returns different values for sessionID, slot=
ID or
> > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_=
stream *xdr,
> > >         }
> > >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > >
> > > -       dummy =3D be32_to_cpup(p++);
> > > -       if (dummy !=3D session->se_cb_seq_nr) {
> > > +       seqid =3D be32_to_cpup(p++);
> > > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb_held_slot]) {
> > >                 dprintk("NFS: %s Invalid sequence number\n", __func__=
);
> > >                 goto out;
> > >         }
> > >
> > > -       dummy =3D be32_to_cpup(p++);
> > > -       if (dummy !=3D 0) {
> > > +       slotid =3D be32_to_cpup(p++);
> > > +       if (slotid !=3D cb->cb_held_slot) {
> > >                 dprintk("NFS: %s Invalid slotid\n", __func__);
> > >                 goto out;
> > >         }
> > >
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
> > >
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
> > >
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
> > >
> > >  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> > >  {
> > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > >
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
> > >
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
> > >
> > > -       if (!cb->cb_holds_slot)
> > > +       if (cb->cb_held_slot < 0)
> > >                 goto need_restart;
> > >
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
> > >
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
> > >
> > >  /**
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f5195=
2563beaa4cfe8adcc3f 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(stru=
ct nfsd4_channel_attrs *fattrs,
> > >         }
> > >
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
> > >
> > >         INIT_LIST_HEAD(&new->se_conns);
> > >
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
> > >
> > >  struct nfsd4_callback_ops {
> > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > >         unsigned char cn_flags;
> > >  };
> > >
> > > +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel *=
/
> > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> >
> > Are there some values that are known not to work? I was experimenting
> > with values and set it to 2 and 4 and the kernel oopsed. I understand
> > it's not a configurable value but it would still be good to know the
> > expectations...
> >
> > [  198.625021] Unable to handle kernel paging request at virtual
> > address dfff800020000000
> > [  198.625870] KASAN: probably user-memory-access in range
> > [0x0000000100000000-0x0000000100000007]
> > [  198.626444] Mem abort info:
> > [  198.626630]   ESR =3D 0x0000000096000005
> > [  198.626882]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [  198.627234]   SET =3D 0, FnV =3D 0
> > [  198.627441]   EA =3D 0, S1PTW =3D 0
> > [  198.627627]   FSC =3D 0x05: level 1 translation fault
> > [  198.627859] Data abort info:
> > [  198.628000]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > [  198.628272]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [  198.628619]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [  198.628967] [dfff800020000000] address between user and kernel addre=
ss ranges
> > [  198.629438] Internal error: Oops: 0000000096000005 [#1] SMP
> > [  198.629806] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver
> > nfs netfs nfnetlink_queue nfnetlink_log nfnetlink bluetooth cfg80211
> > rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd
> > grace isofs uinput snd_seq_dummy snd_hrtimer vsock_loopback
> > vmw_vsock_virtio_transport_common qrtr rfkill vmw_vsock_vmci_transport
> > vsock sunrpc vfat fat snd_hda_codec_generic snd_hda_intel
> > snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq uvcvideo
> > videobuf2_vmalloc snd_seq_device videobuf2_memops uvc videobuf2_v4l2
> > videodev snd_pcm videobuf2_common mc snd_timer snd vmw_vmci soundcore
> > xfs libcrc32c vmwgfx drm_ttm_helper ttm nvme drm_kms_helper
> > crct10dif_ce nvme_core ghash_ce sha2_ce sha256_arm64 sha1_ce drm
> > nvme_auth sr_mod cdrom e1000e sg fuse
> > [  198.633799] CPU: 5 UID: 0 PID: 6081 Comm: nfsd Kdump: loaded Not
> > tainted 6.12.0-rc6+ #47
> > [  198.634345] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > [  198.635014] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [  198.635492] pc : nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > [  198.635798] lr : nfsd4_sequence+0x340/0x1f60 [nfsd]
> > [  198.636065] sp : ffff8000884977e0
> > [  198.636234] x29: ffff800088497910 x28: ffff0000b1b39280 x27: ffff000=
0ab508128
> > [  198.636624] x26: ffff0000b1b39298 x25: ffff0000b1b39290 x24: ffff000=
0a65e1c64
> > [  198.637049] x23: 1fffe000212e6804 x22: ffff000109734024 x21: 1ffff00=
011092f16
> > [  198.637472] x20: ffff00010aed8000 x19: ffff000109734000 x18: 1fffe00=
02de20c8b
> > [  198.637883] x17: 0100000000000000 x16: 1ffff0000fcef234 x15: 1fffe00=
0212e600f
> > [  198.638286] x14: ffff80007e779000 x13: ffff80007e7791a0 x12: 0000000=
000000000
> > [  198.638697] x11: ffff0000a65e1c38 x10: ffff00010aedaca0 x9 : 1fffe00=
0215db594
> > [  198.639110] x8 : 1fffe00014cbc387 x7 : ffff0000a65e1c03 x6 : ffff000=
0a65e1c00
> > [  198.639541] x5 : ffff0000a65e1c00 x4 : 0000000020000000 x3 : 0000000=
100000001
> > [  198.639962] x2 : ffff000109730060 x1 : 0000000000000003 x0 : dfff800=
000000000
> > [  198.640332] Call trace:
> > [  198.640460]  nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > [  198.640715]  nfsd4_proc_compound+0xb94/0x23b0 [nfsd]
> > [  198.640997]  nfsd_dispatch+0x22c/0x718 [nfsd]
> > [  198.641260]  svc_process_common+0x8e8/0x1968 [sunrpc]
> > [  198.641566]  svc_process+0x3d4/0x7e0 [sunrpc]
> > [  198.641827]  svc_handle_xprt+0x828/0xe10 [sunrpc]
> > [  198.642108]  svc_recv+0x2cc/0x6a8 [sunrpc]
> > [  198.642346]  nfsd+0x270/0x400 [nfsd]
> > [  198.642562]  kthread+0x288/0x310
> > [  198.642745]  ret_from_fork+0x10/0x20
> > [  198.642937] Code: f2fbffe0 f9003be4 f94007e2 52800061 (38e06880)
> > [  198.643267] SMP: stopping secondary CPUs
> >
> >
> >
>
>
> Good catch. I think the problem here is that we don't currently cap the
> initial value of se_cb_highest_slot at NFSD_BC_SLOT_TABLE_MAX. Does
> this patch prevent the panic?
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3afe56ab9e0a..839be4ba765a 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2011,7 +2011,7 @@ static struct nfsd4_session *alloc_session(struct n=
fsd4_channel_attrs *fattrs,
>
>         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_att=
rs));
>         new->se_cb_slot_avail =3D ~0U;
> -       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> +       new->se_cb_highest_slot =3D min(battrs->maxreqs - 1, NFSD_BC_SLOT=
_TABLE_MAX);
>         spin_lock_init(&new->se_lock);
>         return new;
>  out_free:

It does help. I thought that the CREATE_SESSION reply for the
backchannel would be guided by the NFSD_BC_SLOT_TABLE_MAX value but
instead it seems like it's not. But yes I can see that the highest
slot used by the server is capped by the NFSD_BC_SLOT_TABLE_MAX value.


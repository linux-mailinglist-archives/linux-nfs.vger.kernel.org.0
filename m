Return-Path: <linux-nfs+bounces-7845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6A9C367E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 03:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AB2280946
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAE2E62C;
	Mon, 11 Nov 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XcFjB94p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6617F7;
	Mon, 11 Nov 2024 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731291901; cv=none; b=BAiSKqGAUPyJfuj5a3sQloZ48Y0fO0Q4O50v93nKw5jrFGjptDetPEXxsubfhnmdHyNULiGiMVjAwpmDLtG90DlpWGva1qs+XO80ibNnElefshevopV31WFI/zH0rEJ2RXpbQSS6fPL2xqBe8r+thO3b0ee07fVI3XS7/rRleo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731291901; c=relaxed/simple;
	bh=zMloq43BsDR3N0XtDQpUVsdA7lXcAnlyaWEnW+6qYrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jv9UegRbSyQKOXUDUNXKo5go5YhwYjNWjRCruUvWrDpivuM+HHgVZxBR6etz4uvlrL+bGw0Dh9g1fe/bCwlZYfVNdNPnCM/lve8XWS1y0pw4m20pDTyG+n+HLTbKOqwSkX+s1P8u5zrl8Pp4hx5LJabfwlYMbpElOOIHa6Vtvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XcFjB94p; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso33980311fa.0;
        Sun, 10 Nov 2024 18:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1731291897; x=1731896697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvmMQAY0weuM5I5ynP5v+j2/2LjicqZNEa0j4uMCNhw=;
        b=XcFjB94pA6Igv0cDP3yoiu+sVIVQq+MQc3JcNfOGfPHOE27GBoSoIa9ual8GXEPrEx
         TGTJDgxejFKoTW3oYrKDJa1YCeuZaZIJwNLE4ZPUQNzQBPLoZKXzXHrMZmJhK72WrVqP
         wOYCXNrTzaswG3NNNvf/fQa8AaktmJqVv7kzxBBpP2G7GeLIlKNgkHWhGNutfpTD+Xv5
         pWblyG3BL1aN+t1WkhUepo23NiBpTnKzGcc9xe6wW110nJVtMnxnYTcwfcPCbKAtcC9U
         TypQ6qW+iXYSCBvOxW29fV6ytblbu3GYPZdTYr3RatyhaCC1y9PrYBtqaA/Am0bsEkMW
         YRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731291897; x=1731896697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvmMQAY0weuM5I5ynP5v+j2/2LjicqZNEa0j4uMCNhw=;
        b=QfTOw/bLTAs5iqTS4YFhP839i/RL8VL/dxg/zzyCM89jVGgd0zNa56LOD7QMRYO/6t
         HcavEwhM004pzPiJ/+9jRqWxQ0eZHrUVqbh0ImSpcHQIWmLd0LWRAZy7nIsrcts3E/GE
         Hpw72kSt0bEDOW4U7N6UrmyGwSmopevzNgSKJTDy7tlgERHq7fSMsQo6xRYc0bxor6QK
         4WDhz86eMyT17fOfXjm8o3o/2BDL1lFQ2uxPoqI9/QuEwi/mr+dRnGwxcGnn2WS8b9cc
         lJ8ojpSmA6G2388PXMqSWail1XNQxKac6gYQXEWi1bOaP0g9w5OKr1MSbgEOeH84vFFs
         zT0g==
X-Forwarded-Encrypted: i=1; AJvYcCV77qtt5bMiDffTBisrVmMg8J4V+FsBCKIkiTDPS70XrTGtZ/swW2oyav7x0W/OwC4N/Mn1E+rjkZgHqp4=@vger.kernel.org, AJvYcCXvQZyLPErSYkVVY3okzoek9mja+MWoeKtU4rs4RPxnjGy+1/jfGTWt2F+Q7njTVz+JZIlv1uN+tGZk@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUdoEJxX+L60P2AxuKIMF8SSR0VoJjizTlvHih0sJveq31rUp
	yIhPbyu24ak41VBjUo/W3+Y8xEIasNEA/AQXevLf1JuqeuFVNVEsWzLDVW9q/J7OUVBWzPM0IKn
	+GoTn5gdg112safba1RTgiUIK8fw=
X-Google-Smtp-Source: AGHT+IF9BN92tITCv1V6MIWIayQKjOVDbjJQJlXGrmDfhVTBhKQQXWq9DqFMGOhBam2OY+Q4jYyAuLkqy32JcTSRdUg=
X-Received: by 2002:a05:651c:1542:b0:2fb:5035:11da with SMTP id
 38308e7fff4ca-2ff2025fc61mr47563241fa.33.1731291896573; Sun, 10 Nov 2024
 18:24:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org> <CAN-5tyHqDNRm-O+NKNXGG_J91M3vCgz8LVZWUjePpYUyy6Pmsg@mail.gmail.com>
 <CAN-5tyHGgtBv6u4TBtx8+0nQy26fbqBE0ic_orGHUihNoHNa4g@mail.gmail.com> <ec6f82804aac6fa2b75e35c39977703bde38f507.camel@kernel.org>
In-Reply-To: <ec6f82804aac6fa2b75e35c39977703bde38f507.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Sun, 10 Nov 2024 21:24:45 -0500
Message-ID: <CAN-5tyFmEUyZS-hXURdhhETwC-0MPPz0Vnu6oRW6dbZdWanpjA@mail.gmail.com>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 4:10=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2024-11-09 at 14:24 -0500, Olga Kornievskaia wrote:
> > On Wed, Nov 6, 2024 at 11:44=E2=80=AFAM Olga Kornievskaia <aglo@umich.e=
du> wrote:
> > >
> > > On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > >
> > > > nfsd currently only uses a single slot in the callback channel, whi=
ch is
> > > > proving to be a bottleneck in some cases. Widen the callback channe=
l to
> > > > a max of 32 slots (subject to the client's target_maxreqs value).
> > > >
> > > > Change the cb_holds_slot boolean to an integer that tracks the curr=
ent
> > > > slot number (with -1 meaning "unassigned").  Move the callback slot
> > > > tracking info into the session. Add a new u32 that acts as a bitmap=
 to
> > > > track which slots are in use, and a u32 to track the latest callbac=
k
> > > > target_slotid that the client reports. To protect the new fields, a=
dd
> > > > a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to=
 always
> > > > search for the lowest slotid (using ffs()).
> > > >
> > > > Finally, convert the session->se_cb_seq_nr field into an array of
> > > > counters and add the necessary handling to ensure that the seqids g=
et
> > > > reset at the appropriate times.
> > > >
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > > v3 has a bug that Olga hit in testing. This version should fix the =
wait
> > > > when the slot table is full. Olga, if you're able to test this one,=
 it
> > > > would be much appreciated.
> > >
> > > I have tested this version. I can confirm that I'm not seeing the
> > > softlockup. But the server still does not use the lowest available
> > > slot. It is hard for me to describe the algorithm of picking the slot
> > > number (in general it still seems to be picking the next slot value,
> > > even though slots have been replied to). I have seen slot 0 re-used
> > > eventually but it seemed to be when the server came to using slot=3D1=
3.
> > >
> > > The other unfortunate thing that's happening when I use these patches
> > > is my test case that recalling delegations and making sure that the
> > > state management gets handled properly (ie., the patch that I've
> > > submitted to fix a race between the laundromat thread and free_state)
> > > is not working. After all the recalls, the server still thinks it has
> > > revoked state. I have to debug more to figure out what's going on.
> > >
> >
> > I haven't been able to reproduce the cl_revoked list ending non-empty
> > but I have hit it, let's say 2-3times in the 4days that I've been
> > trying various things trying to reproduce it. And thus my attempt at
> > changing the number of callback session slots (and hitting a kernel
> > oops). Still trying.
> >
> > Also another comment is that I don't see having multiple slots help
> > with the issue of having numerous recalls that end up resulting in 6
> > RPC exchanges I've described earlier.
> >
> > Instead what I see is when the server starts setting the SEQUENCE flag
> > of revocable state
> >
>
> Which flag?

When the server has state that it flags for revocation it sets the
SEQ4_STATUS_RECALLABLE_STATE_REVOKED. This is expected behaviour.

> > , then the CB_RECALLs are getting ERR_DELAY error
> > (not there aren't multiple callbacks in flight, perhaps at most 2). So
> > it seems like things are "slowing down" even further. There are about
> > 2-3 CB_RECALLs 3rd getting the reply then OPEN which gets BAD_STATEID,
> > then TEST_STATEID, FREE_STATEID, and then OPEN.
> >
>
> Sounds like a client-side capacity issue? nfs4_callback_recall()
> returns NFS4ERR_DELAY when nfs_delegation_find_inode() returns -EAGAIN.
> Maybe there is something weird going on there? Eventually the server
> has no choice but to revoke an unreturned delegation.

I'm not trying to imply in any matter that there is a problem with
either server or client side. I'm simply trying to state that there
was a theory that having multiple cb_table slots would help in the
case of having a lot of recalled/revoked state.  What I'm finding is
that it doesn't seem so (and possibly makes things just slightly
slower. But no measures were taken so my focus is elsewhere).

> > > > Changes in v4:
> > > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49=
a26c45@kernel.org
> > > >
> > > > Changes in v3:
> > > > - add patch to convert se_flags to single se_dead bool
> > > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > > > - don't reject target highest slot value of 0
> > > > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b=
6ef55d@kernel.org
> > > >
> > > > Changes in v2:
> > > > - take cl_lock when fetching fields from session to be encoded
> > > > - use fls() instead of bespoke highest_unset_index()
> > > > - rename variables in several functions with more descriptive names
> > > > - clamp limit of for loop in update_cb_slot_table()
> > > > - re-add missing rpc_wake_up_queued_task() call
> > > > - fix slotid check in decode_cb_sequence4resok()
> > > > - add new per-session spinlock
> > > > ---
> > > >  fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++-=
------------
> > > >  fs/nfsd/nfs4state.c    |  11 +++--
> > > >  fs/nfsd/state.h        |  15 ++++---
> > > >  fs/nfsd/trace.h        |   2 +-
> > > >  4 files changed, 101 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db=
305dada503704c34c15b2 100644
> > > > --- a/fs/nfsd/nfs4callback.c
> > > > +++ b/fs/nfsd/nfs4callback.c
> > > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr,=
 struct nfs4_cb_compound_hdr *hdr,
> > > >         hdr->nops++;
> > > >  }
> > > >
> > > > +static u32 highest_slotid(struct nfsd4_session *ses)
> > > > +{
> > > > +       u32 idx;
> > > > +
> > > > +       spin_lock(&ses->se_lock);
> > > > +       idx =3D fls(~ses->se_cb_slot_avail);
> > > > +       if (idx > 0)
> > > > +               --idx;
> > > > +       idx =3D max(idx, ses->se_cb_highest_slot);
> > > > +       spin_unlock(&ses->se_lock);
> > > > +       return idx;
> > > > +}
> > > > +
> > > >  /*
> > > >   * CB_SEQUENCE4args
> > > >   *
> > > > @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xd=
r_stream *xdr,
> > > >         encode_sessionid4(xdr, session);
> > > >
> > > >         p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > > > -       *p++ =3D cpu_to_be32(session->se_cb_seq_nr);      /* csa_se=
quenceid */
> > > > -       *p++ =3D xdr_zero;                        /* csa_slotid */
> > > > -       *p++ =3D xdr_zero;                        /* csa_highest_sl=
otid */
> > > > +       *p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot=
]);    /* csa_sequenceid */
> > > > +       *p++ =3D cpu_to_be32(cb->cb_held_slot);           /* csa_sl=
otid */
> > > > +       *p++ =3D cpu_to_be32(highest_slotid(session)); /* csa_highe=
st_slotid */
> > > >         *p++ =3D xdr_zero;                        /* csa_cachethis =
*/
> > > >         xdr_encode_empty_array(p);              /* csa_referring_ca=
ll_lists */
> > > >
> > > >         hdr->nops++;
> > > >  }
> > > >
> > > > +static void update_cb_slot_table(struct nfsd4_session *ses, u32 ta=
rget)
> > > > +{
> > > > +       /* No need to do anything if nothing changed */
> > > > +       if (likely(target =3D=3D READ_ONCE(ses->se_cb_highest_slot)=
))
> > > > +               return;
> > > > +
> > > > +       spin_lock(&ses->se_lock);
> > > > +       if (target > ses->se_cb_highest_slot) {
> > > > +               int i;
> > > > +
> > > > +               target =3D min(target, NFSD_BC_SLOT_TABLE_MAX);
> > > > +
> > > > +               /* Growing the slot table. Reset any new sequences =
to 1 */
> > > > +               for (i =3D ses->se_cb_highest_slot + 1; i <=3D targ=
et; ++i)
> > > > +                       ses->se_cb_seq_nr[i] =3D 1;
> > > > +       }
> > > > +       ses->se_cb_highest_slot =3D target;
> > > > +       spin_unlock(&ses->se_lock);
> > > > +}
> > > > +
> > > >  /*
> > > >   * CB_SEQUENCE4resok
> > > >   *
> > > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_=
stream *xdr,
> > > >         struct nfsd4_session *session =3D cb->cb_clp->cl_cb_session=
;
> > > >         int status =3D -ESERVERFAULT;
> > > >         __be32 *p;
> > > > -       u32 dummy;
> > > > +       u32 seqid, slotid, target;
> > > >
> > > >         /*
> > > >          * If the server returns different values for sessionID, sl=
otID or
> > > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xd=
r_stream *xdr,
> > > >         }
> > > >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > > >
> > > > -       dummy =3D be32_to_cpup(p++);
> > > > -       if (dummy !=3D session->se_cb_seq_nr) {
> > > > +       seqid =3D be32_to_cpup(p++);
> > > > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb_held_slot]) {
> > > >                 dprintk("NFS: %s Invalid sequence number\n", __func=
__);
> > > >                 goto out;
> > > >         }
> > > >
> > > > -       dummy =3D be32_to_cpup(p++);
> > > > -       if (dummy !=3D 0) {
> > > > +       slotid =3D be32_to_cpup(p++);
> > > > +       if (slotid !=3D cb->cb_held_slot) {
> > > >                 dprintk("NFS: %s Invalid slotid\n", __func__);
> > > >                 goto out;
> > > >         }
> > > >
> > > > -       /*
> > > > -        * FIXME: process highest slotid and target highest slotid
> > > > -        */
> > > > +       p++; // ignore current highest slot value
> > > > +
> > > > +       target =3D be32_to_cpup(p++);
> > > > +       update_cb_slot_table(session, target);
> > > >         status =3D 0;
> > > >  out:
> > > >         cb->cb_seq_status =3D status;
> > > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_clien=
t *clp, struct nfs4_cb_conn *conn)
> > > >         spin_unlock(&clp->cl_lock);
> > > >  }
> > > >
> > > > +static int grab_slot(struct nfsd4_session *ses)
> > > > +{
> > > > +       int idx;
> > > > +
> > > > +       spin_lock(&ses->se_lock);
> > > > +       idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > > > +       if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > > > +               spin_unlock(&ses->se_lock);
> > > > +               return -1;
> > > > +       }
> > > > +       /* clear the bit for the slot */
> > > > +       ses->se_cb_slot_avail &=3D ~BIT(idx);
> > > > +       spin_unlock(&ses->se_lock);
> > > > +       return idx;
> > > > +}
> > > > +
> > > >  /*
> > > >   * There's currently a single callback channel slot.
> > > >   * If the slot is available, then mark it busy.  Otherwise, set th=
e
> > > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_clie=
nt *clp, struct nfs4_cb_conn *conn)
> > > >  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct r=
pc_task *task)
> > > >  {
> > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > > >
> > > > -       if (!cb->cb_holds_slot &&
> > > > -           test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> > > > +       if (cb->cb_held_slot >=3D 0)
> > > > +               return true;
> > > > +       cb->cb_held_slot =3D grab_slot(ses);
> > > > +       if (cb->cb_held_slot < 0) {
> > > >                 rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> > > >                 /* Race breaker */
> > > > -               if (test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D=
 0) {
> > > > -                       dprintk("%s slot is busy\n", __func__);
> > > > +               cb->cb_held_slot =3D grab_slot(ses);
> > > > +               if (cb->cb_held_slot < 0)
> > > >                         return false;
> > > > -               }
> > > >                 rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> > > >         }
> > > > -       cb->cb_holds_slot =3D true;
> > > >         return true;
> > > >  }
> > > >
> > > >  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> > > >  {
> > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > > >
> > > > -       if (cb->cb_holds_slot) {
> > > > -               cb->cb_holds_slot =3D false;
> > > > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > > > +       if (cb->cb_held_slot >=3D 0) {
> > > > +               spin_lock(&ses->se_lock);
> > > > +               ses->se_cb_slot_avail |=3D BIT(cb->cb_held_slot);
> > > > +               spin_unlock(&ses->se_lock);
> > > > +               cb->cb_held_slot =3D -1;
> > > >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> > > >         }
> > > >  }
> > > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_ca=
llback *cb)
> > > >  }
> > > >
> > > >  /*
> > > > - * TODO: cb_sequence should support referring call lists, cachethi=
s, multiple
> > > > - * slots, and mark callback channel down on communication errors.
> > > > + * TODO: cb_sequence should support referring call lists, cachethi=
s,
> > > > + * and mark callback channel down on communication errors.
> > > >   */
> > > >  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata=
)
> > > >  {
> > > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc=
_task *task, struct nfsd4_callback
> > > >                 return true;
> > > >         }
> > > >
> > > > -       if (!cb->cb_holds_slot)
> > > > +       if (cb->cb_held_slot < 0)
> > > >                 goto need_restart;
> > > >
> > > >         /* This is the operation status code for CB_SEQUENCE */
> > > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct r=
pc_task *task, struct nfsd4_callback
> > > >                  * If CB_SEQUENCE returns an error, then the state =
of the slot
> > > >                  * (sequence ID, cached reply) MUST NOT change.
> > > >                  */
> > > > -               ++session->se_cb_seq_nr;
> > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > >                 break;
> > > >         case -ESERVERFAULT:
> > > > -               ++session->se_cb_seq_nr;
> > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > >                 ret =3D false;
> > > >                 break;
> > > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct r=
pc_task *task, struct nfsd4_callback
> > > >         case -NFS4ERR_BADSLOT:
> > > >                 goto retry_nowait;
> > > >         case -NFS4ERR_SEQ_MISORDERED:
> > > > -               if (session->se_cb_seq_nr !=3D 1) {
> > > > -                       session->se_cb_seq_nr =3D 1;
> > > > +               if (session->se_cb_seq_nr[cb->cb_held_slot] !=3D 1)=
 {
> > > > +                       session->se_cb_seq_nr[cb->cb_held_slot] =3D=
 1;
> > > >                         goto retry_nowait;
> > > >                 }
> > > >                 break;
> > > >         default:
> > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > >         }
> > > > -       nfsd41_cb_release_slot(cb);
> > > > -
> > > >         trace_nfsd_cb_free_slot(task, cb);
> > > > +       nfsd41_cb_release_slot(cb);
> > > >
> > > >         if (RPC_SIGNALLED(task))
> > > >                 goto need_restart;
> > > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb,=
 struct nfs4_client *clp,
> > > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > > >         cb->cb_status =3D 0;
> > > >         cb->cb_need_restart =3D false;
> > > > -       cb->cb_holds_slot =3D false;
> > > > +       cb->cb_held_slot =3D -1;
> > > >  }
> > > >
> > > >  /**
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f51=
952563beaa4cfe8adcc3f 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(st=
ruct nfsd4_channel_attrs *fattrs,
> > > >         }
> > > >
> > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_chann=
el_attrs));
> > > > +       new->se_cb_slot_avail =3D ~0U;
> > > > +       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > > > +       spin_lock_init(&new->se_lock);
> > > >         return new;
> > > >  out_free:
> > > >         while (i--)
> > > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *r=
qstp, struct nfsd4_session *new, stru
> > > >
> > > >         INIT_LIST_HEAD(&new->se_conns);
> > > >
> > > > -       new->se_cb_seq_nr =3D 1;
> > > > +       atomic_set(&new->se_ref, 0);
> > > >         new->se_dead =3D false;
> > > >         new->se_cb_prog =3D cses->callback_prog;
> > > >         new->se_cb_sec =3D cses->cb_sec;
> > > > -       atomic_set(&new->se_ref, 0);
> > > > +
> > > > +       for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > > > +               new->se_cb_seq_nr[idx] =3D 1;
> > > > +
> > > >         idx =3D hash_sessionid(&new->se_sessionid);
> > > >         list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
> > > >         spin_lock(&clp->cl_lock);
> > > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(stru=
ct xdr_netobj name,
> > > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB=
_NULL);
> > > >         clp->cl_time =3D ktime_get_boottime_seconds();
> > > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > > >         copy_verf(clp, verf);
> > > >         memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> > > >         clp->cl_cb_session =3D NULL;
> > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b6991=
6c4ee34b09075708f0de3 100644
> > > > --- a/fs/nfsd/state.h
> > > > +++ b/fs/nfsd/state.h
> > > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > > >         struct work_struct cb_work;
> > > >         int cb_seq_status;
> > > >         int cb_status;
> > > > +       int cb_held_slot;
> > > >         bool cb_need_restart;
> > > > -       bool cb_holds_slot;
> > > >  };
> > > >
> > > >  struct nfsd4_callback_ops {
> > > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > > >         unsigned char cn_flags;
> > > >  };
> > > >
> > > > +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel=
 */
> > > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > > > +
> > > >  /*
> > > >   * Representation of a v4.1+ session. These are refcounted in a si=
milar fashion
> > > >   * to the nfs4_client. References are only taken when the server i=
s actively
> > > > @@ -314,6 +317,10 @@ struct nfsd4_conn {
> > > >   */
> > > >  struct nfsd4_session {
> > > >         atomic_t                se_ref;
> > > > +       spinlock_t              se_lock;
> > > > +       u32                     se_cb_slot_avail; /* bitmap of avai=
lable slots */
> > > > +       u32                     se_cb_highest_slot;     /* highest =
slot client wants */
> > > > +       u32                     se_cb_prog;
> > > >         bool                    se_dead;
> > > >         struct list_head        se_hash;        /* hash by sessioni=
d */
> > > >         struct list_head        se_perclnt;
> > > > @@ -322,8 +329,7 @@ struct nfsd4_session {
> > > >         struct nfsd4_channel_attrs se_fchannel;
> > > >         struct nfsd4_cb_sec     se_cb_sec;
> > > >         struct list_head        se_conns;
> > > > -       u32                     se_cb_prog;
> > > > -       u32                     se_cb_seq_nr;
> > > > +       u32                     se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX=
 + 1];
> > > >         struct nfsd4_slot       *se_slots[];    /* forward channel =
slots */
> > > >  };
> > > >
> > > > @@ -457,9 +463,6 @@ struct nfs4_client {
> > > >          */
> > > >         struct dentry           *cl_nfsd_info_dentry;
> > > >
> > > > -       /* for nfs41 callbacks */
> > > > -       /* We currently support a single back channel with a single=
 slot */
> > > > -       unsigned long           cl_cb_slot_busy;
> > > >         struct rpc_wait_queue   cl_cb_waitq;    /* backchannel call=
ers may */
> > > >                                                 /* wait here for sl=
ots */
> > > >         struct net              *net;
> > > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > > index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d=
7f7b90e250c2913ab23fe 100644
> > > > --- a/fs/nfsd/trace.h
> > > > +++ b/fs/nfsd/trace.h
> > > > @@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
> > > >                 __entry->cl_id =3D sid->clientid.cl_id;
> > > >                 __entry->seqno =3D sid->sequence;
> > > >                 __entry->reserved =3D sid->reserved;
> > > > -               __entry->slot_seqno =3D session->se_cb_seq_nr;
> > > > +               __entry->slot_seqno =3D session->se_cb_seq_nr[cb->c=
b_held_slot];
> > > >         ),
> > > >         TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
> > > >                 " sessionid=3D%08x:%08x:%08x:%08x new slot seqno=3D=
%u",
> > > >
> > > > ---
> > > > base-commit: 3c16aac09d20f9005fbb0e737b3ec520bbb5badd
> > > > change-id: 20241025-bcwide-6bd7e4b63db2
> > > >
> > > > Best regards,
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> > > >
> > > >
>
> --
> Jeff Layton <jlayton@kernel.org>


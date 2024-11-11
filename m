Return-Path: <linux-nfs+bounces-7871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31599C4443
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270E31F21B45
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051761AA1DC;
	Mon, 11 Nov 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ncZDbJqD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A711AA1DB;
	Mon, 11 Nov 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347785; cv=none; b=trfFcAw5Ru6kONdsuXrhJ5R5Gcvg/yAxjJkBPUpY/7dGkiWc0JzEo8k0gkkVtx9wUwDr0Giz8gmAcJvOtGbnaiB984DzNqxcyaLxnDfJBw6qEg4ehz9RNZgOmDkHqr8nbV+Pp336avfMuCyV/HwgUGLzCpOz2v48N/Ryn1+VZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347785; c=relaxed/simple;
	bh=lSvZGXz0AmHpa1UpYqQY0JGbF6LxShJ2SDChPsGc+VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctZG5UZvJeA9qMIxxQsq5i/Q95nfb+V9Q8QlqGYnNRIEEnllFNjWzdfwUal19i9lENjsakytfyO77+JP0VVA/yHut3S7l5hzit8AVX4q05oPBV+DQNib3lDGkgUfSKn3Sgm3BXqipQg2ahcne+9xZfuyjNcqrzucPPcXHv8ZE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ncZDbJqD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53a007743e7so5692503e87.1;
        Mon, 11 Nov 2024 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1731347781; x=1731952581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzFoQ9Hq+X0qfRrE2ztR/2GettlJWJMGHru7YhyRmBA=;
        b=ncZDbJqD+xTvBuPHfS+7yc2MHjINwtf39x2YRC0f4bnLesn1F8vuSu/66Gbu7iLzMA
         3w3//9R5rGJ/YvuuyqcYFYfKMvSBd13s5/7Nz9ppibFqEguy+x6A1VUMlmOa0YfCXeTj
         Wig2VlMckj99btObfqq18CwpqD0remgHuvRhZSHRv55Li53LNG2rF7olILa3lOa0RHBM
         rO+LNak+YgtCb4dMdB5HWEk7VO5xVYSmyBUaGhCgpNvkQtPot6mTdkTo5cKz0QiccomS
         dT1gChKyhUneAcZN9c/z+7hfyMadzyaJgvk4JOLrkswmD6UPqrUhOlcPcq3P76Fouyva
         /A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347781; x=1731952581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzFoQ9Hq+X0qfRrE2ztR/2GettlJWJMGHru7YhyRmBA=;
        b=n7C0MC5DE6IgLBtY5JWZRKdNXxbNx9SjQsJl62EeBQ3eiwK4Nw3nd0EJ6Zjdb6mr3h
         5LLC9Hql3wWxB7inHYLeIj9U+gTGSED88xyE37EwBXLG/W10GnrVHUg9HkGtyYjFoL1g
         q7Z17A+2k8x8zN5Le4hD9y2xmrQ6mbRmgUTL57My0bjEmDG23hlLN+rV2u2Y7w4zCHbt
         OiHKflyZC2/S43v1wofrZNPxx+kdb7bHEQFZ4bdYRpgsSsTHpb3Zc9h26fYqKrzQKpgm
         os7hTUZ29tN2tW14b6Al14hf5aRK47rS8eYuIIU8LIkzi87GCIKoqXXpzxTJw6rBKmmi
         AEgA==
X-Forwarded-Encrypted: i=1; AJvYcCU2MXj9OaGehLUnLuSjeSHG8g7hbK+sRk0nHNq7ieiYL1gcOSPeIIdpvMQY+EbMAl1PZdMAwP56lTba@vger.kernel.org, AJvYcCUFkO9S7NSSWh7JXR4myjZLPNBKdC2B4z7ziiniuSMEfKfI0sFFRXu2wqSYPDcLHz2IZN9zUP90QpyNZsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEkA9kuml+G+HOWvCr5grVgDi1nNDGPN15TPmxPuDoKLzK0Pk
	PPCGrY5qQHECf/j40B41cIWBcj5YhQeLTiUwDUveE7A6Qxxc1eRa/yA8TTlqNuOudjUEDHpSkpZ
	cglJccR+/CZ0bPAQ/lM5Zpri+/GY=
X-Google-Smtp-Source: AGHT+IHgCc1KoOM2X1qtKHCsK6E1+aznNfJeinfz5iFm2GqgF1Dhc25yN2zeaX4rnFzck7LBPvIKFlAGeK2zYVtWH/g=
X-Received: by 2002:a2e:9a16:0:b0:2fb:3881:35d8 with SMTP id
 38308e7fff4ca-2ff201513dbmr66493551fa.14.1731347780726; Mon, 11 Nov 2024
 09:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org> <CAN-5tyEEfJ5p=NUaj+ubzCijq+d9vxT9EBVHvwQYgF=CMtrNTw@mail.gmail.com>
 <59e803abae0b7441c1440ebd4657e573b1c02dd2.camel@kernel.org>
 <CAN-5tyH8xw6XtpnXELJfrxibN3P=xRax31pCexcuOtBMZhooxw@mail.gmail.com>
 <b7f6454176746f5e7a8d75ba41be71e46590a08c.camel@kernel.org>
 <ZzIa5q8cG5LYW5D7@tissot.1015granger.net> <CAN-5tyGc-jHHCQwLNAH4mFFUqZqdieygCbe+ux7rww5PC7qjMw@mail.gmail.com>
 <83b950633c5b7f6949939a4d51581196b5757c07.camel@kernel.org>
In-Reply-To: <83b950633c5b7f6949939a4d51581196b5757c07.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 11 Nov 2024 12:56:09 -0500
Message-ID: <CAN-5tyEh6MrTBQQt99+VO4FcnX3x1DX7XOpRwmkXFryqzr95Jw@mail.gmail.com>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:40=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Mon, 2024-11-11 at 12:17 -0500, Olga Kornievskaia wrote:
> > On Mon, Nov 11, 2024 at 9:56=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > >
> > > On Mon, Nov 11, 2024 at 08:22:07AM -0500, Jeff Layton wrote:
> > > > On Sun, 2024-11-10 at 21:19 -0500, Olga Kornievskaia wrote:
> > > > > On Sat, Nov 9, 2024 at 2:26=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > > >
> > > > > > On Sat, 2024-11-09 at 13:50 -0500, Olga Kornievskaia wrote:
> > > > > > > On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <jlayton@k=
ernel.org> wrote:
> > > > > > > >
> > > > > > > > nfsd currently only uses a single slot in the callback chan=
nel, which is
> > > > > > > > proving to be a bottleneck in some cases. Widen the callbac=
k channel to
> > > > > > > > a max of 32 slots (subject to the client's target_maxreqs v=
alue).
> > > > > > > >
> > > > > > > > Change the cb_holds_slot boolean to an integer that tracks =
the current
> > > > > > > > slot number (with -1 meaning "unassigned").  Move the callb=
ack slot
> > > > > > > > tracking info into the session. Add a new u32 that acts as =
a bitmap to
> > > > > > > > track which slots are in use, and a u32 to track the latest=
 callback
> > > > > > > > target_slotid that the client reports. To protect the new f=
ields, add
> > > > > > > > a new per-session spinlock (the se_lock). Fix nfsd41_cb_get=
_slot to always
> > > > > > > > search for the lowest slotid (using ffs()).
> > > > > > > >
> > > > > > > > Finally, convert the session->se_cb_seq_nr field into an ar=
ray of
> > > > > > > > counters and add the necessary handling to ensure that the =
seqids get
> > > > > > > > reset at the appropriate times.
> > > > > > > >
> > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > > > > ---
> > > > > > > > v3 has a bug that Olga hit in testing. This version should =
fix the wait
> > > > > > > > when the slot table is full. Olga, if you're able to test t=
his one, it
> > > > > > > > would be much appreciated.
> > > > > > > > ---
> > > > > > > > Changes in v4:
> > > > > > > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > > > > > > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-=
0-c2df49a26c45@kernel.org
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - add patch to convert se_flags to single se_dead bool
> > > > > > > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > > > > > > > - don't reject target highest slot value of 0
> > > > > > > > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-=
1-e9010b6ef55d@kernel.org
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - take cl_lock when fetching fields from session to be enco=
ded
> > > > > > > > - use fls() instead of bespoke highest_unset_index()
> > > > > > > > - rename variables in several functions with more descripti=
ve names
> > > > > > > > - clamp limit of for loop in update_cb_slot_table()
> > > > > > > > - re-add missing rpc_wake_up_queued_task() call
> > > > > > > > - fix slotid check in decode_cb_sequence4resok()
> > > > > > > > - add new per-session spinlock
> > > > > > > > ---
> > > > > > > >  fs/nfsd/nfs4callback.c | 113 +++++++++++++++++++++++++++++=
+++++++-------------
> > > > > > > >  fs/nfsd/nfs4state.c    |  11 +++--
> > > > > > > >  fs/nfsd/state.h        |  15 ++++---
> > > > > > > >  fs/nfsd/trace.h        |   2 +-
> > > > > > > >  4 files changed, 101 insertions(+), 40 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.=
c
> > > > > > > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a67833390=
7eaa92db305dada503704c34c15b2 100644
> > > > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stre=
am *xdr, struct nfs4_cb_compound_hdr *hdr,
> > > > > > > >         hdr->nops++;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static u32 highest_slotid(struct nfsd4_session *ses)
> > > > > > > > +{
> > > > > > > > +       u32 idx;
> > > > > > > > +
> > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > +       idx =3D fls(~ses->se_cb_slot_avail);
> > > > > > > > +       if (idx > 0)
> > > > > > > > +               --idx;
> > > > > > > > +       idx =3D max(idx, ses->se_cb_highest_slot);
> > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > +       return idx;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /*
> > > > > > > >   * CB_SEQUENCE4args
> > > > > > > >   *
> > > > > > > > @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(s=
truct xdr_stream *xdr,
> > > > > > > >         encode_sessionid4(xdr, session);
> > > > > > > >
> > > > > > > >         p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > > > > > > > -       *p++ =3D cpu_to_be32(session->se_cb_seq_nr);      /=
* csa_sequenceid */
> > > > > > > > -       *p++ =3D xdr_zero;                        /* csa_sl=
otid */
> > > > > > > > -       *p++ =3D xdr_zero;                        /* csa_hi=
ghest_slotid */
> > > > > > > > +       *p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_h=
eld_slot]);    /* csa_sequenceid */
> > > > > > > > +       *p++ =3D cpu_to_be32(cb->cb_held_slot);           /=
* csa_slotid */
> > > > > > > > +       *p++ =3D cpu_to_be32(highest_slotid(session)); /* c=
sa_highest_slotid */
> > > > > > > >         *p++ =3D xdr_zero;                        /* csa_ca=
chethis */
> > > > > > > >         xdr_encode_empty_array(p);              /* csa_refe=
rring_call_lists */
> > > > > > > >
> > > > > > > >         hdr->nops++;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void update_cb_slot_table(struct nfsd4_session *ses=
, u32 target)
> > > > > > > > +{
> > > > > > > > +       /* No need to do anything if nothing changed */
> > > > > > > > +       if (likely(target =3D=3D READ_ONCE(ses->se_cb_highe=
st_slot)))
> > > > > > > > +               return;
> > > > > > > > +
> > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > +       if (target > ses->se_cb_highest_slot) {
> > > > > > > > +               int i;
> > > > > > > > +
> > > > > > > > +               target =3D min(target, NFSD_BC_SLOT_TABLE_M=
AX);
> > > > > > > > +
> > > > > > > > +               /* Growing the slot table. Reset any new se=
quences to 1 */
> > > > > > > > +               for (i =3D ses->se_cb_highest_slot + 1; i <=
=3D target; ++i)
> > > > > > > > +                       ses->se_cb_seq_nr[i] =3D 1;
> > > > > > > > +       }
> > > > > > > > +       ses->se_cb_highest_slot =3D target;
> > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /*
> > > > > > > >   * CB_SEQUENCE4resok
> > > > > > > >   *
> > > > > > > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(str=
uct xdr_stream *xdr,
> > > > > > > >         struct nfsd4_session *session =3D cb->cb_clp->cl_cb=
_session;
> > > > > > > >         int status =3D -ESERVERFAULT;
> > > > > > > >         __be32 *p;
> > > > > > > > -       u32 dummy;
> > > > > > > > +       u32 seqid, slotid, target;
> > > > > > > >
> > > > > > > >         /*
> > > > > > > >          * If the server returns different values for sessi=
onID, slotID or
> > > > > > > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(s=
truct xdr_stream *xdr,
> > > > > > > >         }
> > > > > > > >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > > > > > > >
> > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > -       if (dummy !=3D session->se_cb_seq_nr) {
> > > > > > > > +       seqid =3D be32_to_cpup(p++);
> > > > > > > > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb_held_sl=
ot]) {
> > > > > > > >                 dprintk("NFS: %s Invalid sequence number\n"=
, __func__);
> > > > > > > >                 goto out;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > -       if (dummy !=3D 0) {
> > > > > > > > +       slotid =3D be32_to_cpup(p++);
> > > > > > > > +       if (slotid !=3D cb->cb_held_slot) {
> > > > > > > >                 dprintk("NFS: %s Invalid slotid\n", __func_=
_);
> > > > > > > >                 goto out;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       /*
> > > > > > > > -        * FIXME: process highest slotid and target highest=
 slotid
> > > > > > > > -        */
> > > > > > > > +       p++; // ignore current highest slot value
> > > > > > > > +
> > > > > > > > +       target =3D be32_to_cpup(p++);
> > > > > > > > +       update_cb_slot_table(session, target);
> > > > > > > >         status =3D 0;
> > > > > > > >  out:
> > > > > > > >         cb->cb_seq_status =3D status;
> > > > > > > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nf=
s4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > >         spin_unlock(&clp->cl_lock);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int grab_slot(struct nfsd4_session *ses)
> > > > > > > > +{
> > > > > > > > +       int idx;
> > > > > > > > +
> > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > +       idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > > > > > > > +       if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > +               return -1;
> > > > > > > > +       }
> > > > > > > > +       /* clear the bit for the slot */
> > > > > > > > +       ses->se_cb_slot_avail &=3D ~BIT(idx);
> > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > +       return idx;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /*
> > > > > > > >   * There's currently a single callback channel slot.
> > > > > > > >   * If the slot is available, then mark it busy.  Otherwise=
, set the
> > > > > > > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct n=
fs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > >  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, =
struct rpc_task *task)
> > > > > > > >  {
> > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > > > > > > >
> > > > > > > > -       if (!cb->cb_holds_slot &&
> > > > > > > > -           test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D=
 0) {
> > > > > > > > +       if (cb->cb_held_slot >=3D 0)
> > > > > > > > +               return true;
> > > > > > > > +       cb->cb_held_slot =3D grab_slot(ses);
> > > > > > > > +       if (cb->cb_held_slot < 0) {
> > > > > > > >                 rpc_sleep_on(&clp->cl_cb_waitq, task, NULL)=
;
> > > > > > > >                 /* Race breaker */
> > > > > > > > -               if (test_and_set_bit(0, &clp->cl_cb_slot_bu=
sy) !=3D 0) {
> > > > > > > > -                       dprintk("%s slot is busy\n", __func=
__);
> > > > > > > > +               cb->cb_held_slot =3D grab_slot(ses);
> > > > > > > > +               if (cb->cb_held_slot < 0)
> > > > > > > >                         return false;
> > > > > > > > -               }
> > > > > > > >                 rpc_wake_up_queued_task(&clp->cl_cb_waitq, =
task);
> > > > > > > >         }
> > > > > > > > -       cb->cb_holds_slot =3D true;
> > > > > > > >         return true;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void nfsd41_cb_release_slot(struct nfsd4_callback *=
cb)
> > > > > > > >  {
> > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > > > > > > >
> > > > > > > > -       if (cb->cb_holds_slot) {
> > > > > > > > -               cb->cb_holds_slot =3D false;
> > > > > > > > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > +       if (cb->cb_held_slot >=3D 0) {
> > > > > > > > +               spin_lock(&ses->se_lock);
> > > > > > > > +               ses->se_cb_slot_avail |=3D BIT(cb->cb_held_=
slot);
> > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > +               cb->cb_held_slot =3D -1;
> > > > > > > >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> > > > > > > >         }
> > > > > > > >  }
> > > > > > > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct =
nfsd4_callback *cb)
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /*
> > > > > > > > - * TODO: cb_sequence should support referring call lists, =
cachethis, multiple
> > > > > > > > - * slots, and mark callback channel down on communication =
errors.
> > > > > > > > + * TODO: cb_sequence should support referring call lists, =
cachethis,
> > > > > > > > + * and mark callback channel down on communication errors.
> > > > > > > >   */
> > > > > > > >  static void nfsd4_cb_prepare(struct rpc_task *task, void *=
calldata)
> > > > > > > >  {
> > > > > > > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(st=
ruct rpc_task *task, struct nfsd4_callback
> > > > > > > >                 return true;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > -       if (!cb->cb_holds_slot)
> > > > > > > > +       if (cb->cb_held_slot < 0)
> > > > > > > >                 goto need_restart;
> > > > > > > >
> > > > > > > >         /* This is the operation status code for CB_SEQUENC=
E */
> > > > > > > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(=
struct rpc_task *task, struct nfsd4_callback
> > > > > > > >                  * If CB_SEQUENCE returns an error, then th=
e state of the slot
> > > > > > > >                  * (sequence ID, cached reply) MUST NOT cha=
nge.
> > > > > > > >                  */
> > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > > > > >                 break;
> > > > > > > >         case -ESERVERFAULT:
> > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > >                 ret =3D false;
> > > > > > > >                 break;
> > > > > > > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(=
struct rpc_task *task, struct nfsd4_callback
> > > > > > > >         case -NFS4ERR_BADSLOT:
> > > > > > > >                 goto retry_nowait;
> > > > > > > >         case -NFS4ERR_SEQ_MISORDERED:
> > > > > > > > -               if (session->se_cb_seq_nr !=3D 1) {
> > > > > > > > -                       session->se_cb_seq_nr =3D 1;
> > > > > > > > +               if (session->se_cb_seq_nr[cb->cb_held_slot]=
 !=3D 1) {
> > > > > > > > +                       session->se_cb_seq_nr[cb->cb_held_s=
lot] =3D 1;
> > > > > > > >                         goto retry_nowait;
> > > > > > > >                 }
> > > > > > > >                 break;
> > > > > > > >         default:
> > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > >         }
> > > > > > > > -       nfsd41_cb_release_slot(cb);
> > > > > > > > -
> > > > > > > >         trace_nfsd_cb_free_slot(task, cb);
> > > > > > > > +       nfsd41_cb_release_slot(cb);
> > > > > > > >
> > > > > > > >         if (RPC_SIGNALLED(task))
> > > > > > > >                 goto need_restart;
> > > > > > > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callb=
ack *cb, struct nfs4_client *clp,
> > > > > > > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > > > > > > >         cb->cb_status =3D 0;
> > > > > > > >         cb->cb_need_restart =3D false;
> > > > > > > > -       cb->cb_holds_slot =3D false;
> > > > > > > > +       cb->cb_held_slot =3D -1;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /**
> > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc92=
65517f51952563beaa4cfe8adcc3f 100644
> > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_se=
ssion(struct nfsd4_channel_attrs *fattrs,
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfs=
d4_channel_attrs));
> > > > > > > > +       new->se_cb_slot_avail =3D ~0U;
> > > > > > > > +       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > > > > > > > +       spin_lock_init(&new->se_lock);
> > > > > > > >         return new;
> > > > > > > >  out_free:
> > > > > > > >         while (i--)
> > > > > > > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc=
_rqst *rqstp, struct nfsd4_session *new, stru
> > > > > > > >
> > > > > > > >         INIT_LIST_HEAD(&new->se_conns);
> > > > > > > >
> > > > > > > > -       new->se_cb_seq_nr =3D 1;
> > > > > > > > +       atomic_set(&new->se_ref, 0);
> > > > > > > >         new->se_dead =3D false;
> > > > > > > >         new->se_cb_prog =3D cses->callback_prog;
> > > > > > > >         new->se_cb_sec =3D cses->cb_sec;
> > > > > > > > -       atomic_set(&new->se_ref, 0);
> > > > > > > > +
> > > > > > > > +       for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx=
)
> > > > > > > > +               new->se_cb_seq_nr[idx] =3D 1;
> > > > > > > > +
> > > > > > > >         idx =3D hash_sessionid(&new->se_sessionid);
> > > > > > > >         list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]=
);
> > > > > > > >         spin_lock(&clp->cl_lock);
> > > > > > > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_cli=
ent(struct xdr_netobj name,
> > > > > > > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > > > > > > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4=
_CLNT_CB_NULL);
> > > > > > > >         clp->cl_time =3D ktime_get_boottime_seconds();
> > > > > > > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > >         copy_verf(clp, verf);
> > > > > > > >         memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_st=
orage));
> > > > > > > >         clp->cl_cb_session =3D NULL;
> > > > > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > > > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb30=
8f0b69916c4ee34b09075708f0de3 100644
> > > > > > > > --- a/fs/nfsd/state.h
> > > > > > > > +++ b/fs/nfsd/state.h
> > > > > > > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > > > > > > >         struct work_struct cb_work;
> > > > > > > >         int cb_seq_status;
> > > > > > > >         int cb_status;
> > > > > > > > +       int cb_held_slot;
> > > > > > > >         bool cb_need_restart;
> > > > > > > > -       bool cb_holds_slot;
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  struct nfsd4_callback_ops {
> > > > > > > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > > > > > > >         unsigned char cn_flags;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +/* Highest slot index that nfsd implements in NFSv4.1+ bac=
kchannel */
> > > > > > > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > > > > > >
> > > > > > > Are there some values that are known not to work? I was exper=
imenting
> > > > > > > with values and set it to 2 and 4 and the kernel oopsed. I un=
derstand
> > > > > > > it's not a configurable value but it would still be good to k=
now the
> > > > > > > expectations...
> > > > > > >
> > > > > > > [  198.625021] Unable to handle kernel paging request at virt=
ual
> > > > > > > address dfff800020000000
> > > > > > > [  198.625870] KASAN: probably user-memory-access in range
> > > > > > > [0x0000000100000000-0x0000000100000007]
> > > > > > > [  198.626444] Mem abort info:
> > > > > > > [  198.626630]   ESR =3D 0x0000000096000005
> > > > > > > [  198.626882]   EC =3D 0x25: DABT (current EL), IL =3D 32 bi=
ts
> > > > > > > [  198.627234]   SET =3D 0, FnV =3D 0
> > > > > > > [  198.627441]   EA =3D 0, S1PTW =3D 0
> > > > > > > [  198.627627]   FSC =3D 0x05: level 1 translation fault
> > > > > > > [  198.627859] Data abort info:
> > > > > > > [  198.628000]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00=
000000
> > > > > > > [  198.628272]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =
=3D 0
> > > > > > > [  198.628619]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs=
 =3D 0
> > > > > > > [  198.628967] [dfff800020000000] address between user and ke=
rnel address ranges
> > > > > > > [  198.629438] Internal error: Oops: 0000000096000005 [#1] SM=
P
> > > > > > > [  198.629806] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_r=
esolver
> > > > > > > nfs netfs nfnetlink_queue nfnetlink_log nfnetlink bluetooth c=
fg80211
> > > > > > > rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl =
lockd
> > > > > > > grace isofs uinput snd_seq_dummy snd_hrtimer vsock_loopback
> > > > > > > vmw_vsock_virtio_transport_common qrtr rfkill vmw_vsock_vmci_=
transport
> > > > > > > vsock sunrpc vfat fat snd_hda_codec_generic snd_hda_intel
> > > > > > > snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq=
 uvcvideo
> > > > > > > videobuf2_vmalloc snd_seq_device videobuf2_memops uvc videobu=
f2_v4l2
> > > > > > > videodev snd_pcm videobuf2_common mc snd_timer snd vmw_vmci s=
oundcore
> > > > > > > xfs libcrc32c vmwgfx drm_ttm_helper ttm nvme drm_kms_helper
> > > > > > > crct10dif_ce nvme_core ghash_ce sha2_ce sha256_arm64 sha1_ce =
drm
> > > > > > > nvme_auth sr_mod cdrom e1000e sg fuse
> > > > > > > [  198.633799] CPU: 5 UID: 0 PID: 6081 Comm: nfsd Kdump: load=
ed Not
> > > > > > > tainted 6.12.0-rc6+ #47
> > > > > > > [  198.634345] Hardware name: VMware, Inc. VMware20,1/VBSA, B=
IOS
> > > > > > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > > > > > [  198.635014] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DI=
T -SSBS BTYPE=3D--)
> > > > > > > [  198.635492] pc : nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > [  198.635798] lr : nfsd4_sequence+0x340/0x1f60 [nfsd]
> > > > > > > [  198.636065] sp : ffff8000884977e0
> > > > > > > [  198.636234] x29: ffff800088497910 x28: ffff0000b1b39280 x2=
7: ffff0000ab508128
> > > > > > > [  198.636624] x26: ffff0000b1b39298 x25: ffff0000b1b39290 x2=
4: ffff0000a65e1c64
> > > > > > > [  198.637049] x23: 1fffe000212e6804 x22: ffff000109734024 x2=
1: 1ffff00011092f16
> > > > > > > [  198.637472] x20: ffff00010aed8000 x19: ffff000109734000 x1=
8: 1fffe0002de20c8b
> > > > > > > [  198.637883] x17: 0100000000000000 x16: 1ffff0000fcef234 x1=
5: 1fffe000212e600f
> > > > > > > [  198.638286] x14: ffff80007e779000 x13: ffff80007e7791a0 x1=
2: 0000000000000000
> > > > > > > [  198.638697] x11: ffff0000a65e1c38 x10: ffff00010aedaca0 x9=
 : 1fffe000215db594
> > > > > > > [  198.639110] x8 : 1fffe00014cbc387 x7 : ffff0000a65e1c03 x6=
 : ffff0000a65e1c00
> > > > > > > [  198.639541] x5 : ffff0000a65e1c00 x4 : 0000000020000000 x3=
 : 0000000100000001
> > > > > > > [  198.639962] x2 : ffff000109730060 x1 : 0000000000000003 x0=
 : dfff800000000000
> > > > > > > [  198.640332] Call trace:
> > > > > > > [  198.640460]  nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > [  198.640715]  nfsd4_proc_compound+0xb94/0x23b0 [nfsd]
> > > > > > > [  198.640997]  nfsd_dispatch+0x22c/0x718 [nfsd]
> > > > > > > [  198.641260]  svc_process_common+0x8e8/0x1968 [sunrpc]
> > > > > > > [  198.641566]  svc_process+0x3d4/0x7e0 [sunrpc]
> > > > > > > [  198.641827]  svc_handle_xprt+0x828/0xe10 [sunrpc]
> > > > > > > [  198.642108]  svc_recv+0x2cc/0x6a8 [sunrpc]
> > > > > > > [  198.642346]  nfsd+0x270/0x400 [nfsd]
> > > > > > > [  198.642562]  kthread+0x288/0x310
> > > > > > > [  198.642745]  ret_from_fork+0x10/0x20
> > > > > > > [  198.642937] Code: f2fbffe0 f9003be4 f94007e2 52800061 (38e=
06880)
> > > > > > > [  198.643267] SMP: stopping secondary CPUs
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > > > Good catch. I think the problem here is that we don't currently=
 cap the
> > > > > > initial value of se_cb_highest_slot at NFSD_BC_SLOT_TABLE_MAX. =
Does
> > > > > > this patch prevent the panic?
> > > > > >
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index 3afe56ab9e0a..839be4ba765a 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -2011,7 +2011,7 @@ static struct nfsd4_session *alloc_sessio=
n(struct nfsd4_channel_attrs *fattrs,
> > > > > >
> > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_c=
hannel_attrs));
> > > > > >         new->se_cb_slot_avail =3D ~0U;
> > > > > > -       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > > > > > +       new->se_cb_highest_slot =3D min(battrs->maxreqs - 1, NF=
SD_BC_SLOT_TABLE_MAX);
> > > > > >         spin_lock_init(&new->se_lock);
> > > > > >         return new;
> > > > > >  out_free:
> > > > >
> > > > > It does help. I thought that the CREATE_SESSION reply for the
> > > > > backchannel would be guided by the NFSD_BC_SLOT_TABLE_MAX value b=
ut
> > > > > instead it seems like it's not. But yes I can see that the highes=
t
> > > > > slot used by the server is capped by the NFSD_BC_SLOT_TABLE_MAX v=
alue.
> > > >
> > > > Thanks for testing it, Olga.
> > > >
> > > > Chuck, would you be OK with folding the above delta into 9ab4c4077d=
e9,
> > > > or would you rather I resend the patch?
> > >
> > > I've folded the above one-liner into the applied patch.
> > >
> > > I agree with Tom, I think there's probably a (surprising)
> > > explanation lurking for not seeing the expected performance
> > > improvement. I can delay sending the NFSD v6.13 merge window pull
> > > request for a bit to see if you can get it teased out.
> >
> > I would like to raise a couple of issues:
> > (1) I believe the server should be reporting back an accurate value
> > for the backchannel session table size. I think if the
> > NFSD_BC_SLOT_TABLE_MAX was way lower than the client's value then the
> > client would be wasting resources for its bc session table?
>
> Yes, but those resources are 32-bit integer per wasted slot. The Linux
> client allows for up to 16 slots, so we're wasting 64 bytes per session
> with this scheme with the Linux client. I didn't think it was worth
> doing a separate allocation for that.
>
> We could make NFSD_BC_SLOT_TABLE_MAX smaller though. Maybe we should
> match the client's size and make it 15?
>
> > ->back_channel->maxreqs gets decoded in nfsd4_decode_create_session()
> > and is never adjusted for the reply to be based on the
> > NFSD_BC_SLOT_TABLE_MAX. The problem is currently invisible because
> > linux client's bc slot table size is 16 and nfsd's is higher.
> >
>
> I'm not sure I understand the problem here. We don't care about most of
> the backchannel attributes. maxreqs is the only one that matters, and
> track that in se_cb_highest_slot.

Client sends a create_session with cba_back_chan_attrs with max_reqs
of 16 -- stating that the client can handle 16 slots in it's slot
table. Server currently doesn't do anything about reflecting back to
the client its session slot table. It blindly returns what the client
sent. Say NFSD_BC_SLOT_TABLE_MAX was 4. Server would never use more
than 4 slots and yet the client would have to create a reply cache
table for 16 slots. Isn't that poor sportsmanship on behalf of the
linux server?

>
> --
> Jeff Layton <jlayton@kernel.org>


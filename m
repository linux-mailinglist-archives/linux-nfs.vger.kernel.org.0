Return-Path: <linux-nfs+bounces-7875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B399C4568
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 19:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA61F22B24
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 18:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F01A726F;
	Mon, 11 Nov 2024 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fxUTSxn5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC019F113;
	Mon, 11 Nov 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351340; cv=none; b=o3zPpyR6iZSBU+kKszohrAS+0vhypW/7itTaMB8ZNvT/Ddiq1hHSUaEGFcLuEPwMS7/oq/gVYSrmV7nvZi1mDtSEIXyedAX6rgIY3V/kwut/771rAgs5mhWroMUuVfCTA1nuwLvMTLD+uODug+GmZ3guHXsZmzH0VrhrfWw3PRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351340; c=relaxed/simple;
	bh=P0DFGrFAeU88vmLXawLt+Yadok28MJlUatCDcidM/mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lye1wWBn5ZEGvm9x6WX67kJws7vRuQPxMUZ1josmn2+6QPGdM+BGnk75mkgzvCe42hbwGMQtFVWaZ6USjYm1/fP9oXcAXVQe91TSAzIZ+EHknq7XD4Kk2U2Jt8/dM+6tjGFHLg+MPUlD+/VqtPqU9MwHa7LAI1hx6wvbXzI9bXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fxUTSxn5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso40329661fa.2;
        Mon, 11 Nov 2024 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1731351336; x=1731956136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpSrAO6vJmDKW6Ikd7JsQn7Zlx16ZlGi20jcT5/Kgf4=;
        b=fxUTSxn5WzfffyJ0i6oMnXdXVkXOdW+68e1wJi73E04FXNNif8aO08r3dnvguk0hfu
         NYeQ9ULTK3q8NlTTNNV7X7gPUVdShPL030uBm1wpNl4IOJTTZQfnukO1wxHmuBnrouCG
         Hx/NR5DFcIw5kgZKa/6AORwCg1o8jqAqSojSR+JEpdLFkAF6a4aBddmCZi8k+s3gpkAd
         jBeOb+Fc6vnQO2IruURaOjm+5ZS5rqQsbhrOiZp7Ga8OL40xKZzw35bNNs1ZJ/ruzuIX
         BeMGIeT2qjo2dZs7GquPVS7lxAU2+l4la0IHMjT5smBEoddQhBB7c7ZleVWzqGcVCw7x
         YPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731351336; x=1731956136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpSrAO6vJmDKW6Ikd7JsQn7Zlx16ZlGi20jcT5/Kgf4=;
        b=OcmtE1eTQWThHjtz8UMAVxrdlgimWp7v4D1bMkbHYGXePMKiCtTooTcoDwnugJe/UK
         dubD1C+kVfUptAJg+o6JqDH3fC8eNWLA/X61Gk+bsRJrNo7GPYpLsMcFmPjcveLO7aLG
         wfhP9BPgeq3sYp1KV5HkBAG87JLnWa4yq5R9hoBk7CoonZXkj+t9dce8IUrlhlQdL7ow
         bL1/VmmK/HYn4SjjFAySE0suxCa9MaJLpsmoCDFkxBFLz2H2T5FHU+MmLqNP3OK39I7Q
         Pum5NUF5BZ9ZvPFgyDq9lCu9UyEfrw98cf03hUSZSSoPlfKLHBdQq4a4z1a1gxIQq8GQ
         lf0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdMWMrMq4GjBonvd85v/WSbVOqMHTPM152vkrvGb3v+ApneT0w9WfsUQkINPKRBpis5+5icrAPWtXwL+U=@vger.kernel.org, AJvYcCXYixyZJMPlgW0wWgTmNMf1ad708y0vi9NQsZxcbVW/KDcDFJWZ+VLV0drcwJbyZ09gz0kE36Jzvkel@vger.kernel.org
X-Gm-Message-State: AOJu0Yy05ytPBBRjAFrdFz5g1C+zW9zLEzlZsNoFy5JhP5Eduvf/8Ccb
	GrIYIyQRqffsBaRfiT23zCA8bynvXLlXPZ5tNp5qwTwJ+AdPFRpUHHqBzUEbrw9pr0WatcABweW
	JLL6IPbMYyDBQ82vym57RR5/vq9s=
X-Google-Smtp-Source: AGHT+IEXPjKO20bqtJLE7ln1cIzWrZxPjtVG69+OqwQER7vpqDvOc6PGC7hsoovljkMKNry/kP80jEmXb2N6eNWGdlo=
X-Received: by 2002:a05:651c:513:b0:2fb:5a7e:5072 with SMTP id
 38308e7fff4ca-2ff2028a832mr59690441fa.34.1731351335354; Mon, 11 Nov 2024
 10:55:35 -0800 (PST)
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
 <CAN-5tyEh6MrTBQQt99+VO4FcnX3x1DX7XOpRwmkXFryqzr95Jw@mail.gmail.com>
 <3c60acaa79ec27ed1ecb8fdc42a2cb75c75c0a25.camel@kernel.org> <14e6f6af974c5c17884c418560f385d051d7bdf7.camel@kernel.org>
In-Reply-To: <14e6f6af974c5c17884c418560f385d051d7bdf7.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 11 Nov 2024 13:55:23 -0500
Message-ID: <CAN-5tyG_LiYP4aqEGSCyj8boDRE74+Y_A08Q-=3us-Uh2T+NLA@mail.gmail.com>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2024-11-11 at 13:17 -0500, Jeff Layton wrote:
> > On Mon, 2024-11-11 at 12:56 -0500, Olga Kornievskaia wrote:
> > > On Mon, Nov 11, 2024 at 12:40=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > >
> > > > On Mon, 2024-11-11 at 12:17 -0500, Olga Kornievskaia wrote:
> > > > > On Mon, Nov 11, 2024 at 9:56=E2=80=AFAM Chuck Lever <chuck.lever@=
oracle.com> wrote:
> > > > > >
> > > > > > On Mon, Nov 11, 2024 at 08:22:07AM -0500, Jeff Layton wrote:
> > > > > > > On Sun, 2024-11-10 at 21:19 -0500, Olga Kornievskaia wrote:
> > > > > > > > On Sat, Nov 9, 2024 at 2:26=E2=80=AFPM Jeff Layton <jlayton=
@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, 2024-11-09 at 13:50 -0500, Olga Kornievskaia wrot=
e:
> > > > > > > > > > On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <jla=
yton@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > nfsd currently only uses a single slot in the callbac=
k channel, which is
> > > > > > > > > > > proving to be a bottleneck in some cases. Widen the c=
allback channel to
> > > > > > > > > > > a max of 32 slots (subject to the client's target_max=
reqs value).
> > > > > > > > > > >
> > > > > > > > > > > Change the cb_holds_slot boolean to an integer that t=
racks the current
> > > > > > > > > > > slot number (with -1 meaning "unassigned").  Move the=
 callback slot
> > > > > > > > > > > tracking info into the session. Add a new u32 that ac=
ts as a bitmap to
> > > > > > > > > > > track which slots are in use, and a u32 to track the =
latest callback
> > > > > > > > > > > target_slotid that the client reports. To protect the=
 new fields, add
> > > > > > > > > > > a new per-session spinlock (the se_lock). Fix nfsd41_=
cb_get_slot to always
> > > > > > > > > > > search for the lowest slotid (using ffs()).
> > > > > > > > > > >
> > > > > > > > > > > Finally, convert the session->se_cb_seq_nr field into=
 an array of
> > > > > > > > > > > counters and add the necessary handling to ensure tha=
t the seqids get
> > > > > > > > > > > reset at the appropriate times.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > > > > > > > ---
> > > > > > > > > > > v3 has a bug that Olga hit in testing. This version s=
hould fix the wait
> > > > > > > > > > > when the slot table is full. Olga, if you're able to =
test this one, it
> > > > > > > > > > > would be much appreciated.
> > > > > > > > > > > ---
> > > > > > > > > > > Changes in v4:
> > > > > > > > > > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > > > > > > > > > - Link to v3: https://lore.kernel.org/r/20241030-bcwi=
de-v3-0-c2df49a26c45@kernel.org
> > > > > > > > > > >
> > > > > > > > > > > Changes in v3:
> > > > > > > > > > > - add patch to convert se_flags to single se_dead boo=
l
> > > > > > > > > > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABL=
E_MAX
> > > > > > > > > > > - don't reject target highest slot value of 0
> > > > > > > > > > > - Link to v2: https://lore.kernel.org/r/20241029-bcwi=
de-v2-1-e9010b6ef55d@kernel.org
> > > > > > > > > > >
> > > > > > > > > > > Changes in v2:
> > > > > > > > > > > - take cl_lock when fetching fields from session to b=
e encoded
> > > > > > > > > > > - use fls() instead of bespoke highest_unset_index()
> > > > > > > > > > > - rename variables in several functions with more des=
criptive names
> > > > > > > > > > > - clamp limit of for loop in update_cb_slot_table()
> > > > > > > > > > > - re-add missing rpc_wake_up_queued_task() call
> > > > > > > > > > > - fix slotid check in decode_cb_sequence4resok()
> > > > > > > > > > > - add new per-session spinlock
> > > > > > > > > > > ---
> > > > > > > > > > >  fs/nfsd/nfs4callback.c | 113 +++++++++++++++++++++++=
+++++++++++++-------------
> > > > > > > > > > >  fs/nfsd/nfs4state.c    |  11 +++--
> > > > > > > > > > >  fs/nfsd/state.h        |  15 ++++---
> > > > > > > > > > >  fs/nfsd/trace.h        |   2 +-
> > > > > > > > > > >  4 files changed, 101 insertions(+), 40 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4cal=
lback.c
> > > > > > > > > > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a67=
8333907eaa92db305dada503704c34c15b2 100644
> > > > > > > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > > > > > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xd=
r_stream *xdr, struct nfs4_cb_compound_hdr *hdr,
> > > > > > > > > > >         hdr->nops++;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static u32 highest_slotid(struct nfsd4_session *ses)
> > > > > > > > > > > +{
> > > > > > > > > > > +       u32 idx;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > +       idx =3D fls(~ses->se_cb_slot_avail);
> > > > > > > > > > > +       if (idx > 0)
> > > > > > > > > > > +               --idx;
> > > > > > > > > > > +       idx =3D max(idx, ses->se_cb_highest_slot);
> > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > +       return idx;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /*
> > > > > > > > > > >   * CB_SEQUENCE4args
> > > > > > > > > > >   *
> > > > > > > > > > > @@ -432,15 +445,35 @@ static void encode_cb_sequence4=
args(struct xdr_stream *xdr,
> > > > > > > > > > >         encode_sessionid4(xdr, session);
> > > > > > > > > > >
> > > > > > > > > > >         p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + =
4);
> > > > > > > > > > > -       *p++ =3D cpu_to_be32(session->se_cb_seq_nr); =
     /* csa_sequenceid */
> > > > > > > > > > > -       *p++ =3D xdr_zero;                        /* =
csa_slotid */
> > > > > > > > > > > -       *p++ =3D xdr_zero;                        /* =
csa_highest_slotid */
> > > > > > > > > > > +       *p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb=
->cb_held_slot]);    /* csa_sequenceid */
> > > > > > > > > > > +       *p++ =3D cpu_to_be32(cb->cb_held_slot);      =
     /* csa_slotid */
> > > > > > > > > > > +       *p++ =3D cpu_to_be32(highest_slotid(session))=
; /* csa_highest_slotid */
> > > > > > > > > > >         *p++ =3D xdr_zero;                        /* =
csa_cachethis */
> > > > > > > > > > >         xdr_encode_empty_array(p);              /* cs=
a_referring_call_lists */
> > > > > > > > > > >
> > > > > > > > > > >         hdr->nops++;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static void update_cb_slot_table(struct nfsd4_sessio=
n *ses, u32 target)
> > > > > > > > > > > +{
> > > > > > > > > > > +       /* No need to do anything if nothing changed =
*/
> > > > > > > > > > > +       if (likely(target =3D=3D READ_ONCE(ses->se_cb=
_highest_slot)))
> > > > > > > > > > > +               return;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > +       if (target > ses->se_cb_highest_slot) {
> > > > > > > > > > > +               int i;
> > > > > > > > > > > +
> > > > > > > > > > > +               target =3D min(target, NFSD_BC_SLOT_T=
ABLE_MAX);
> > > > > > > > > > > +
> > > > > > > > > > > +               /* Growing the slot table. Reset any =
new sequences to 1 */
> > > > > > > > > > > +               for (i =3D ses->se_cb_highest_slot + =
1; i <=3D target; ++i)
> > > > > > > > > > > +                       ses->se_cb_seq_nr[i] =3D 1;
> > > > > > > > > > > +       }
> > > > > > > > > > > +       ses->se_cb_highest_slot =3D target;
> > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /*
> > > > > > > > > > >   * CB_SEQUENCE4resok
> > > > > > > > > > >   *
> > > > > > > > > > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4res=
ok(struct xdr_stream *xdr,
> > > > > > > > > > >         struct nfsd4_session *session =3D cb->cb_clp-=
>cl_cb_session;
> > > > > > > > > > >         int status =3D -ESERVERFAULT;
> > > > > > > > > > >         __be32 *p;
> > > > > > > > > > > -       u32 dummy;
> > > > > > > > > > > +       u32 seqid, slotid, target;
> > > > > > > > > > >
> > > > > > > > > > >         /*
> > > > > > > > > > >          * If the server returns different values for=
 sessionID, slotID or
> > > > > > > > > > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4r=
esok(struct xdr_stream *xdr,
> > > > > > > > > > >         }
> > > > > > > > > > >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > > > > > > > > > >
> > > > > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > > > > -       if (dummy !=3D session->se_cb_seq_nr) {
> > > > > > > > > > > +       seqid =3D be32_to_cpup(p++);
> > > > > > > > > > > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb_h=
eld_slot]) {
> > > > > > > > > > >                 dprintk("NFS: %s Invalid sequence num=
ber\n", __func__);
> > > > > > > > > > >                 goto out;
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > > > > -       if (dummy !=3D 0) {
> > > > > > > > > > > +       slotid =3D be32_to_cpup(p++);
> > > > > > > > > > > +       if (slotid !=3D cb->cb_held_slot) {
> > > > > > > > > > >                 dprintk("NFS: %s Invalid slotid\n", _=
_func__);
> > > > > > > > > > >                 goto out;
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > -       /*
> > > > > > > > > > > -        * FIXME: process highest slotid and target h=
ighest slotid
> > > > > > > > > > > -        */
> > > > > > > > > > > +       p++; // ignore current highest slot value
> > > > > > > > > > > +
> > > > > > > > > > > +       target =3D be32_to_cpup(p++);
> > > > > > > > > > > +       update_cb_slot_table(session, target);
> > > > > > > > > > >         status =3D 0;
> > > > > > > > > > >  out:
> > > > > > > > > > >         cb->cb_seq_status =3D status;
> > > > > > > > > > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(str=
uct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > > > >         spin_unlock(&clp->cl_lock);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static int grab_slot(struct nfsd4_session *ses)
> > > > > > > > > > > +{
> > > > > > > > > > > +       int idx;
> > > > > > > > > > > +
> > > > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > > > +       idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > > > > > > > > > > +       if (idx < 0 || idx > ses->se_cb_highest_slot)=
 {
> > > > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > > > +               return -1;
> > > > > > > > > > > +       }
> > > > > > > > > > > +       /* clear the bit for the slot */
> > > > > > > > > > > +       ses->se_cb_slot_avail &=3D ~BIT(idx);
> > > > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > > > +       return idx;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /*
> > > > > > > > > > >   * There's currently a single callback channel slot.
> > > > > > > > > > >   * If the slot is available, then mark it busy.  Oth=
erwise, set the
> > > > > > > > > > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(st=
ruct nfs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > > > >  static bool nfsd41_cb_get_slot(struct nfsd4_callback=
 *cb, struct rpc_task *task)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_sess=
ion;
> > > > > > > > > > >
> > > > > > > > > > > -       if (!cb->cb_holds_slot &&
> > > > > > > > > > > -           test_and_set_bit(0, &clp->cl_cb_slot_busy=
) !=3D 0) {
> > > > > > > > > > > +       if (cb->cb_held_slot >=3D 0)
> > > > > > > > > > > +               return true;
> > > > > > > > > > > +       cb->cb_held_slot =3D grab_slot(ses);
> > > > > > > > > > > +       if (cb->cb_held_slot < 0) {
> > > > > > > > > > >                 rpc_sleep_on(&clp->cl_cb_waitq, task,=
 NULL);
> > > > > > > > > > >                 /* Race breaker */
> > > > > > > > > > > -               if (test_and_set_bit(0, &clp->cl_cb_s=
lot_busy) !=3D 0) {
> > > > > > > > > > > -                       dprintk("%s slot is busy\n", =
__func__);
> > > > > > > > > > > +               cb->cb_held_slot =3D grab_slot(ses);
> > > > > > > > > > > +               if (cb->cb_held_slot < 0)
> > > > > > > > > > >                         return false;
> > > > > > > > > > > -               }
> > > > > > > > > > >                 rpc_wake_up_queued_task(&clp->cl_cb_w=
aitq, task);
> > > > > > > > > > >         }
> > > > > > > > > > > -       cb->cb_holds_slot =3D true;
> > > > > > > > > > >         return true;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static void nfsd41_cb_release_slot(struct nfsd4_call=
back *cb)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_sess=
ion;
> > > > > > > > > > >
> > > > > > > > > > > -       if (cb->cb_holds_slot) {
> > > > > > > > > > > -               cb->cb_holds_slot =3D false;
> > > > > > > > > > > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > > > > +       if (cb->cb_held_slot >=3D 0) {
> > > > > > > > > > > +               spin_lock(&ses->se_lock);
> > > > > > > > > > > +               ses->se_cb_slot_avail |=3D BIT(cb->cb=
_held_slot);
> > > > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > > > +               cb->cb_held_slot =3D -1;
> > > > > > > > > > >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> > > > > > > > > > >         }
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(s=
truct nfsd4_callback *cb)
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  /*
> > > > > > > > > > > - * TODO: cb_sequence should support referring call l=
ists, cachethis, multiple
> > > > > > > > > > > - * slots, and mark callback channel down on communic=
ation errors.
> > > > > > > > > > > + * TODO: cb_sequence should support referring call l=
ists, cachethis,
> > > > > > > > > > > + * and mark callback channel down on communication e=
rrors.
> > > > > > > > > > >   */
> > > > > > > > > > >  static void nfsd4_cb_prepare(struct rpc_task *task, =
void *calldata)
> > > > > > > > > > >  {
> > > > > > > > > > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_d=
one(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > >                 return true;
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > -       if (!cb->cb_holds_slot)
> > > > > > > > > > > +       if (cb->cb_held_slot < 0)
> > > > > > > > > > >                 goto need_restart;
> > > > > > > > > > >
> > > > > > > > > > >         /* This is the operation status code for CB_S=
EQUENCE */
> > > > > > > > > > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence=
_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > >                  * If CB_SEQUENCE returns an error, t=
hen the state of the slot
> > > > > > > > > > >                  * (sequence ID, cached reply) MUST N=
OT change.
> > > > > > > > > > >                  */
> > > > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_s=
lot];
> > > > > > > > > > >                 break;
> > > > > > > > > > >         case -ESERVERFAULT:
> > > > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_s=
lot];
> > > > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > > > >                 ret =3D false;
> > > > > > > > > > >                 break;
> > > > > > > > > > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence=
_done(struct rpc_task *task, struct nfsd4_callback
> > > > > > > > > > >         case -NFS4ERR_BADSLOT:
> > > > > > > > > > >                 goto retry_nowait;
> > > > > > > > > > >         case -NFS4ERR_SEQ_MISORDERED:
> > > > > > > > > > > -               if (session->se_cb_seq_nr !=3D 1) {
> > > > > > > > > > > -                       session->se_cb_seq_nr =3D 1;
> > > > > > > > > > > +               if (session->se_cb_seq_nr[cb->cb_held=
_slot] !=3D 1) {
> > > > > > > > > > > +                       session->se_cb_seq_nr[cb->cb_=
held_slot] =3D 1;
> > > > > > > > > > >                         goto retry_nowait;
> > > > > > > > > > >                 }
> > > > > > > > > > >                 break;
> > > > > > > > > > >         default:
> > > > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > > > >         }
> > > > > > > > > > > -       nfsd41_cb_release_slot(cb);
> > > > > > > > > > > -
> > > > > > > > > > >         trace_nfsd_cb_free_slot(task, cb);
> > > > > > > > > > > +       nfsd41_cb_release_slot(cb);
> > > > > > > > > > >
> > > > > > > > > > >         if (RPC_SIGNALLED(task))
> > > > > > > > > > >                 goto need_restart;
> > > > > > > > > > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4=
_callback *cb, struct nfs4_client *clp,
> > > > > > > > > > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > > > > > > > > > >         cb->cb_status =3D 0;
> > > > > > > > > > >         cb->cb_need_restart =3D false;
> > > > > > > > > > > -       cb->cb_holds_slot =3D false;
> > > > > > > > > > > +       cb->cb_held_slot =3D -1;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  /**
> > > > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.=
c
> > > > > > > > > > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557=
e7cc9265517f51952563beaa4cfe8adcc3f 100644
> > > > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *al=
loc_session(struct nfsd4_channel_attrs *fattrs,
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(stru=
ct nfsd4_channel_attrs));
> > > > > > > > > > > +       new->se_cb_slot_avail =3D ~0U;
> > > > > > > > > > > +       new->se_cb_highest_slot =3D battrs->maxreqs -=
 1;
> > > > > > > > > > > +       spin_lock_init(&new->se_lock);
> > > > > > > > > > >         return new;
> > > > > > > > > > >  out_free:
> > > > > > > > > > >         while (i--)
> > > > > > > > > > > @@ -2132,11 +2135,14 @@ static void init_session(stru=
ct svc_rqst *rqstp, struct nfsd4_session *new, stru
> > > > > > > > > > >
> > > > > > > > > > >         INIT_LIST_HEAD(&new->se_conns);
> > > > > > > > > > >
> > > > > > > > > > > -       new->se_cb_seq_nr =3D 1;
> > > > > > > > > > > +       atomic_set(&new->se_ref, 0);
> > > > > > > > > > >         new->se_dead =3D false;
> > > > > > > > > > >         new->se_cb_prog =3D cses->callback_prog;
> > > > > > > > > > >         new->se_cb_sec =3D cses->cb_sec;
> > > > > > > > > > > -       atomic_set(&new->se_ref, 0);
> > > > > > > > > > > +
> > > > > > > > > > > +       for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX;=
 ++idx)
> > > > > > > > > > > +               new->se_cb_seq_nr[idx] =3D 1;
> > > > > > > > > > > +
> > > > > > > > > > >         idx =3D hash_sessionid(&new->se_sessionid);
> > > > > > > > > > >         list_add(&new->se_hash, &nn->sessionid_hashtb=
l[idx]);
> > > > > > > > > > >         spin_lock(&clp->cl_lock);
> > > > > > > > > > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *crea=
te_client(struct xdr_netobj name,
> > > > > > > > > > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > > > > > > > > > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NF=
SPROC4_CLNT_CB_NULL);
> > > > > > > > > > >         clp->cl_time =3D ktime_get_boottime_seconds()=
;
> > > > > > > > > > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > > > >         copy_verf(clp, verf);
> > > > > > > > > > >         memcpy(&clp->cl_addr, sa, sizeof(struct socka=
ddr_storage));
> > > > > > > > > > >         clp->cl_cb_session =3D NULL;
> > > > > > > > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > > > > > > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d0=
23cb308f0b69916c4ee34b09075708f0de3 100644
> > > > > > > > > > > --- a/fs/nfsd/state.h
> > > > > > > > > > > +++ b/fs/nfsd/state.h
> > > > > > > > > > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > > > > > > > > > >         struct work_struct cb_work;
> > > > > > > > > > >         int cb_seq_status;
> > > > > > > > > > >         int cb_status;
> > > > > > > > > > > +       int cb_held_slot;
> > > > > > > > > > >         bool cb_need_restart;
> > > > > > > > > > > -       bool cb_holds_slot;
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > >  struct nfsd4_callback_ops {
> > > > > > > > > > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > > > > > > > > > >         unsigned char cn_flags;
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > > +/* Highest slot index that nfsd implements in NFSv4.=
1+ backchannel */
> > > > > > > > > > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > > > > > > > > >
> > > > > > > > > > Are there some values that are known not to work? I was=
 experimenting
> > > > > > > > > > with values and set it to 2 and 4 and the kernel oopsed=
. I understand
> > > > > > > > > > it's not a configurable value but it would still be goo=
d to know the
> > > > > > > > > > expectations...
> > > > > > > > > >
> > > > > > > > > > [  198.625021] Unable to handle kernel paging request a=
t virtual
> > > > > > > > > > address dfff800020000000
> > > > > > > > > > [  198.625870] KASAN: probably user-memory-access in ra=
nge
> > > > > > > > > > [0x0000000100000000-0x0000000100000007]
> > > > > > > > > > [  198.626444] Mem abort info:
> > > > > > > > > > [  198.626630]   ESR =3D 0x0000000096000005
> > > > > > > > > > [  198.626882]   EC =3D 0x25: DABT (current EL), IL =3D=
 32 bits
> > > > > > > > > > [  198.627234]   SET =3D 0, FnV =3D 0
> > > > > > > > > > [  198.627441]   EA =3D 0, S1PTW =3D 0
> > > > > > > > > > [  198.627627]   FSC =3D 0x05: level 1 translation faul=
t
> > > > > > > > > > [  198.627859] Data abort info:
> > > > > > > > > > [  198.628000]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =
=3D 0x00000000
> > > > > > > > > > [  198.628272]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAcc=
ess =3D 0
> > > > > > > > > > [  198.628619]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D=
 0, Xs =3D 0
> > > > > > > > > > [  198.628967] [dfff800020000000] address between user =
and kernel address ranges
> > > > > > > > > > [  198.629438] Internal error: Oops: 0000000096000005 [=
#1] SMP
> > > > > > > > > > [  198.629806] Modules linked in: rpcsec_gss_krb5 nfsv4=
 dns_resolver
> > > > > > > > > > nfs netfs nfnetlink_queue nfnetlink_log nfnetlink bluet=
ooth cfg80211
> > > > > > > > > > rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nf=
s_acl lockd
> > > > > > > > > > grace isofs uinput snd_seq_dummy snd_hrtimer vsock_loop=
back
> > > > > > > > > > vmw_vsock_virtio_transport_common qrtr rfkill vmw_vsock=
_vmci_transport
> > > > > > > > > > vsock sunrpc vfat fat snd_hda_codec_generic snd_hda_int=
el
> > > > > > > > > > snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep s=
nd_seq uvcvideo
> > > > > > > > > > videobuf2_vmalloc snd_seq_device videobuf2_memops uvc v=
ideobuf2_v4l2
> > > > > > > > > > videodev snd_pcm videobuf2_common mc snd_timer snd vmw_=
vmci soundcore
> > > > > > > > > > xfs libcrc32c vmwgfx drm_ttm_helper ttm nvme drm_kms_he=
lper
> > > > > > > > > > crct10dif_ce nvme_core ghash_ce sha2_ce sha256_arm64 sh=
a1_ce drm
> > > > > > > > > > nvme_auth sr_mod cdrom e1000e sg fuse
> > > > > > > > > > [  198.633799] CPU: 5 UID: 0 PID: 6081 Comm: nfsd Kdump=
: loaded Not
> > > > > > > > > > tainted 6.12.0-rc6+ #47
> > > > > > > > > > [  198.634345] Hardware name: VMware, Inc. VMware20,1/V=
BSA, BIOS
> > > > > > > > > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > > > > > > > > [  198.635014] pstate: 11400005 (nzcV daif +PAN -UAO -T=
CO +DIT -SSBS BTYPE=3D--)
> > > > > > > > > > [  198.635492] pc : nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > > > > [  198.635798] lr : nfsd4_sequence+0x340/0x1f60 [nfsd]
> > > > > > > > > > [  198.636065] sp : ffff8000884977e0
> > > > > > > > > > [  198.636234] x29: ffff800088497910 x28: ffff0000b1b39=
280 x27: ffff0000ab508128
> > > > > > > > > > [  198.636624] x26: ffff0000b1b39298 x25: ffff0000b1b39=
290 x24: ffff0000a65e1c64
> > > > > > > > > > [  198.637049] x23: 1fffe000212e6804 x22: ffff000109734=
024 x21: 1ffff00011092f16
> > > > > > > > > > [  198.637472] x20: ffff00010aed8000 x19: ffff000109734=
000 x18: 1fffe0002de20c8b
> > > > > > > > > > [  198.637883] x17: 0100000000000000 x16: 1ffff0000fcef=
234 x15: 1fffe000212e600f
> > > > > > > > > > [  198.638286] x14: ffff80007e779000 x13: ffff80007e779=
1a0 x12: 0000000000000000
> > > > > > > > > > [  198.638697] x11: ffff0000a65e1c38 x10: ffff00010aeda=
ca0 x9 : 1fffe000215db594
> > > > > > > > > > [  198.639110] x8 : 1fffe00014cbc387 x7 : ffff0000a65e1=
c03 x6 : ffff0000a65e1c00
> > > > > > > > > > [  198.639541] x5 : ffff0000a65e1c00 x4 : 0000000020000=
000 x3 : 0000000100000001
> > > > > > > > > > [  198.639962] x2 : ffff000109730060 x1 : 0000000000000=
003 x0 : dfff800000000000
> > > > > > > > > > [  198.640332] Call trace:
> > > > > > > > > > [  198.640460]  nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > > > > [  198.640715]  nfsd4_proc_compound+0xb94/0x23b0 [nfsd]
> > > > > > > > > > [  198.640997]  nfsd_dispatch+0x22c/0x718 [nfsd]
> > > > > > > > > > [  198.641260]  svc_process_common+0x8e8/0x1968 [sunrpc=
]
> > > > > > > > > > [  198.641566]  svc_process+0x3d4/0x7e0 [sunrpc]
> > > > > > > > > > [  198.641827]  svc_handle_xprt+0x828/0xe10 [sunrpc]
> > > > > > > > > > [  198.642108]  svc_recv+0x2cc/0x6a8 [sunrpc]
> > > > > > > > > > [  198.642346]  nfsd+0x270/0x400 [nfsd]
> > > > > > > > > > [  198.642562]  kthread+0x288/0x310
> > > > > > > > > > [  198.642745]  ret_from_fork+0x10/0x20
> > > > > > > > > > [  198.642937] Code: f2fbffe0 f9003be4 f94007e2 5280006=
1 (38e06880)
> > > > > > > > > > [  198.643267] SMP: stopping secondary CPUs
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Good catch. I think the problem here is that we don't cur=
rently cap the
> > > > > > > > > initial value of se_cb_highest_slot at NFSD_BC_SLOT_TABLE=
_MAX. Does
> > > > > > > > > this patch prevent the panic?
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > > index 3afe56ab9e0a..839be4ba765a 100644
> > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > @@ -2011,7 +2011,7 @@ static struct nfsd4_session *alloc_=
session(struct nfsd4_channel_attrs *fattrs,
> > > > > > > > >
> > > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct n=
fsd4_channel_attrs));
> > > > > > > > >         new->se_cb_slot_avail =3D ~0U;
> > > > > > > > > -       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > > > > > > > > +       new->se_cb_highest_slot =3D min(battrs->maxreqs -=
 1, NFSD_BC_SLOT_TABLE_MAX);
> > > > > > > > >         spin_lock_init(&new->se_lock);
> > > > > > > > >         return new;
> > > > > > > > >  out_free:
> > > > > > > >
> > > > > > > > It does help. I thought that the CREATE_SESSION reply for t=
he
> > > > > > > > backchannel would be guided by the NFSD_BC_SLOT_TABLE_MAX v=
alue but
> > > > > > > > instead it seems like it's not. But yes I can see that the =
highest
> > > > > > > > slot used by the server is capped by the NFSD_BC_SLOT_TABLE=
_MAX value.
> > > > > > >
> > > > > > > Thanks for testing it, Olga.
> > > > > > >
> > > > > > > Chuck, would you be OK with folding the above delta into 9ab4=
c4077de9,
> > > > > > > or would you rather I resend the patch?
> > > > > >
> > > > > > I've folded the above one-liner into the applied patch.
> > > > > >
> > > > > > I agree with Tom, I think there's probably a (surprising)
> > > > > > explanation lurking for not seeing the expected performance
> > > > > > improvement. I can delay sending the NFSD v6.13 merge window pu=
ll
> > > > > > request for a bit to see if you can get it teased out.
> > > > >
> > > > > I would like to raise a couple of issues:
> > > > > (1) I believe the server should be reporting back an accurate val=
ue
> > > > > for the backchannel session table size. I think if the
> > > > > NFSD_BC_SLOT_TABLE_MAX was way lower than the client's value then=
 the
> > > > > client would be wasting resources for its bc session table?
> > > >
> > > > Yes, but those resources are 32-bit integer per wasted slot. The Li=
nux
> > > > client allows for up to 16 slots, so we're wasting 64 bytes per ses=
sion
> > > > with this scheme with the Linux client. I didn't think it was worth
> > > > doing a separate allocation for that.
> > > >
> > > > We could make NFSD_BC_SLOT_TABLE_MAX smaller though. Maybe we shoul=
d
> > > > match the client's size and make it 15?
> > > >
> > > > > ->back_channel->maxreqs gets decoded in nfsd4_decode_create_sessi=
on()
> > > > > and is never adjusted for the reply to be based on the
> > > > > NFSD_BC_SLOT_TABLE_MAX. The problem is currently invisible becaus=
e
> > > > > linux client's bc slot table size is 16 and nfsd's is higher.
> > > > >
> > > >
> > > > I'm not sure I understand the problem here. We don't care about mos=
t of
> > > > the backchannel attributes. maxreqs is the only one that matters, a=
nd
> > > > track that in se_cb_highest_slot.
> > >
> > > Client sends a create_session with cba_back_chan_attrs with max_reqs
> > > of 16 -- stating that the client can handle 16 slots in it's slot
> > > table. Server currently doesn't do anything about reflecting back to
> > > the client its session slot table. It blindly returns what the client
> > > sent. Say NFSD_BC_SLOT_TABLE_MAX was 4. Server would never use more
> > > than 4 slots and yet the client would have to create a reply cache
> > > table for 16 slots. Isn't that poor sportsmanship on behalf of the
> > > linux server?
> > >
> > >
> >
> > Thanks, that does sound like a bug. I think we can fix that with
> > another one-liner.  When we allocate the new session, update the
> > back_channel attrs in the request with the correct maxreqs. Thoughts?
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 15438826ed5b..c35d8fc2f693 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3885,6 +3885,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
> >       new =3D alloc_session(&cr_ses->fore_channel, &cr_ses->back_channe=
l);
> >       if (!new)
> >               goto out_release_drc_mem;
> > +     cr_ses->back_channel.maxreqs =3D new->se_cb_highest_slot;
> >       conn =3D alloc_conn_from_crses(rqstp, cr_ses);
> >       if (!conn)
> >               goto out_free_session;
>
>
> Actually, I think this is better, since we're already modifying things
> in this section of the code. Also the earlier patch was off-by-one:
>
> ------------------------8<----------------------
>
> [PATCH] SQUASH: report the correct number of backchannel slots to client
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 15438826ed5b..cfc2190ffce5 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3955,6 +3955,8 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>         cr_ses->flags &=3D ~SESSION4_PERSIST;
>         /* Upshifting from TCP to RDMA is not supported */
>         cr_ses->flags &=3D ~SESSION4_RDMA;
> +       /* Report the correct number of backchannel slots */
> +       cr_ses->back_channel.maxreqs =3D new->se_cb_highest_slot + 1;

Is the intent that NFSD_BC_SLOT_TABLE_MAX value represents a one off
value? With this patch if NFSD_BC_SLOT_TABLE_MAX=3D1 the server would
send back 2 in its CREATE_SESSION reply for the bc table size. Other
than the wrong value, this patch would indeed reflect back server's cb
table size.

>
>         init_session(rqstp, new, conf, cr_ses);
>         nfsd4_get_session_locked(new);
> --
> 2.47.0
>
>
>


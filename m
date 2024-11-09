Return-Path: <linux-nfs+bounces-7825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D099C2F4A
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 20:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFFB1F2178E
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BD19E99A;
	Sat,  9 Nov 2024 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="if7rXYJe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364819D098;
	Sat,  9 Nov 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731180285; cv=none; b=bU/Dyn4FZbg+KLqkTt8+PZ9gemUBYvBvq+9YuF+M1p3zdMz760dybzj4qfBEsUVNshDU2U1JXtzo0eCzKXJTb7WxzcZUe5bRq2BB9tOQ9ZpGRPd8JI+lFB/C6jACW+Doy3zgq5bz4fHnKh4lTv708vSYW3o1yESW8Ne+fyJCiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731180285; c=relaxed/simple;
	bh=OpHvwvrz/Qyx5qyLx1BNGImUwdqjfr9LMURpbHEB0os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0Foc3Fi4kzRIADpfSW9LmPF8po7X46UDd48P28HWrseMw13t98DVjaW0ltsATb1vPv01NIPwxtqU9tDtknhYrvWcIH+rpy/+3eWXoCjgvjVlCHoAjVtzlWR5/wr6PUBKdncuJcSUvwU2bXzvlWMgvEo+KHdH6DkoIug4bie6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=if7rXYJe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso40813011fa.1;
        Sat, 09 Nov 2024 11:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1731180281; x=1731785081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/Wrl0aJUuOku1n4I+lgJFRSyMr35JtNSM4wGFk6w4w=;
        b=if7rXYJeGzojJOyMseoCfot0MTIljqgNQ8jZXWrzgd4EZ2JHycwAi5zIH5bJl6H+G5
         gE8D6kjJgHURx7exV2Qmy6/LmF8yaut7af8hf/UBDFkpDUcsbOH20NmPxgUMwvOdYVi6
         MPdfoWEbZJI++FG+t6UN2RBdfvZyRQvEyat5oK4+VVJGn4DDDiFLU8zt9ED/iQnoF3Zw
         jpOXvz/wt5UHBFFmdvBpClKZkdhc+/vwtCX1sOU5eSSGbl/a3XSjUyT8+IjNN0YiC+l/
         YraV8SjB0c0e3ferKu7zul73IAdX9hNeVMWkNL/evNy+jgcckrpmj9ofbh64VVaivc9m
         718g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731180281; x=1731785081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/Wrl0aJUuOku1n4I+lgJFRSyMr35JtNSM4wGFk6w4w=;
        b=Cs7wkZKX5FIrxPPLZOvcwJLLUDnsl5bo/WNRonIB8I8aMhyTwYYo0FzzxCiZ2+OWed
         +cp4XaT4iPAUCYE4aWkzmNffsdxzh3vHUhf926/o3W1im5qEJa91Np+eRwJWWYu7m751
         RvAcBvDBre3AaND9JveCrIonTyuWaUOZ/WB93RHJMcEN7OGemY+ZujVTDNHmPHuREXmB
         tWZ93AKMp+fSy8RrirezpnGu3dM95vTEqreR6XIsM1AbuijQEjkCGPh1Nmif/JyDv0lQ
         ZDYA3IADQ2nTdtQLtaeapMVdoaE53ouvmWS/FcEIk/1VfzNp0Mhm2E2UIuHkeEzBnHew
         z3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUXB+ilSNnWKc6Cc2Ae/Zqmw7nTob2dC0xTjRbXMhPXmgWkgA5kanak0QJgwF9Tnvd5XrsZpExhWdTUhsE=@vger.kernel.org, AJvYcCXK09Flix5Q72ZJT5uHKCVcPxfValn9lNV2CWx+KiOR5aq3DGmC21go4wXuGRIzxkQklnmWxH/6MMUp@vger.kernel.org
X-Gm-Message-State: AOJu0YzwuBEqU3R9xmMnDdJE/QFAFVqYOEMfIYFFZobtibXtcdW0Adtl
	L3fDXDof0d6sztCAqTTgrpx5Te8gnzAqS/BhjxWxjQIeUyoV+dJ78vHB9Zqb2yzLadWyZDcFJYa
	qnBfq24sW49VxznR80EWBD+8Atz0=
X-Google-Smtp-Source: AGHT+IEmSYw59h1zrnct/NqP/RnwkfkVgN4eElxSnsUM/PYvTF366RhnkQtlEHWtJ9LXEKESAV3C3VUJzxXZrfr6Cvw=
X-Received: by 2002:a05:651c:1551:b0:2fb:2a96:37fd with SMTP id
 38308e7fff4ca-2ff2028a91cmr56912961fa.29.1731180280908; Sat, 09 Nov 2024
 11:24:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105-bcwide-v4-1-48f52ee0fb0c@kernel.org> <CAN-5tyHqDNRm-O+NKNXGG_J91M3vCgz8LVZWUjePpYUyy6Pmsg@mail.gmail.com>
In-Reply-To: <CAN-5tyHqDNRm-O+NKNXGG_J91M3vCgz8LVZWUjePpYUyy6Pmsg@mail.gmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Sat, 9 Nov 2024 14:24:29 -0500
Message-ID: <CAN-5tyHGgtBv6u4TBtx8+0nQy26fbqBE0ic_orGHUihNoHNa4g@mail.gmail.com>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:44=E2=80=AFAM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>
> On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > nfsd currently only uses a single slot in the callback channel, which i=
s
> > proving to be a bottleneck in some cases. Widen the callback channel to
> > a max of 32 slots (subject to the client's target_maxreqs value).
> >
> > Change the cb_holds_slot boolean to an integer that tracks the current
> > slot number (with -1 meaning "unassigned").  Move the callback slot
> > tracking info into the session. Add a new u32 that acts as a bitmap to
> > track which slots are in use, and a u32 to track the latest callback
> > target_slotid that the client reports. To protect the new fields, add
> > a new per-session spinlock (the se_lock). Fix nfsd41_cb_get_slot to alw=
ays
> > search for the lowest slotid (using ffs()).
> >
> > Finally, convert the session->se_cb_seq_nr field into an array of
> > counters and add the necessary handling to ensure that the seqids get
> > reset at the appropriate times.
> >
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> > v3 has a bug that Olga hit in testing. This version should fix the wait
> > when the slot table is full. Olga, if you're able to test this one, it
> > would be much appreciated.
>
> I have tested this version. I can confirm that I'm not seeing the
> softlockup. But the server still does not use the lowest available
> slot. It is hard for me to describe the algorithm of picking the slot
> number (in general it still seems to be picking the next slot value,
> even though slots have been replied to). I have seen slot 0 re-used
> eventually but it seemed to be when the server came to using slot=3D13.
>
> The other unfortunate thing that's happening when I use these patches
> is my test case that recalling delegations and making sure that the
> state management gets handled properly (ie., the patch that I've
> submitted to fix a race between the laundromat thread and free_state)
> is not working. After all the recalls, the server still thinks it has
> revoked state. I have to debug more to figure out what's going on.
>

I haven't been able to reproduce the cl_revoked list ending non-empty
but I have hit it, let's say 2-3times in the 4days that I've been
trying various things trying to reproduce it. And thus my attempt at
changing the number of callback session slots (and hitting a kernel
oops). Still trying.

Also another comment is that I don't see having multiple slots help
with the issue of having numerous recalls that end up resulting in 6
RPC exchanges I've described earlier.

Instead what I see is when the server starts setting the SEQUENCE flag
of revocable state, then the CB_RECALLs are getting ERR_DELAY error
(not there aren't multiple callbacks in flight, perhaps at most 2). So
it seems like things are "slowing down" even further. There are about
2-3 CB_RECALLs 3rd getting the reply then OPEN which gets BAD_STATEID,
then TEST_STATEID, FREE_STATEID, and then OPEN.

> > ---
> > Changes in v4:
> > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-0-c2df49a26c=
45@kernel.org
> >
> > Changes in v3:
> > - add patch to convert se_flags to single se_dead bool
> > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > - don't reject target highest slot value of 0
> > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-1-e9010b6ef5=
5d@kernel.org
> >
> > Changes in v2:
> > - take cl_lock when fetching fields from session to be encoded
> > - use fls() instead of bespoke highest_unset_index()
> > - rename variables in several functions with more descriptive names
> > - clamp limit of for loop in update_cb_slot_table()
> > - re-add missing rpc_wake_up_queued_task() call
> > - fix slotid check in decode_cb_sequence4resok()
> > - add new per-session spinlock
> > ---
> >  fs/nfsd/nfs4callback.c | 113 ++++++++++++++++++++++++++++++++++++-----=
--------
> >  fs/nfsd/nfs4state.c    |  11 +++--
> >  fs/nfsd/state.h        |  15 ++++---
> >  fs/nfsd/trace.h        |   2 +-
> >  4 files changed, 101 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a678333907eaa92db305d=
ada503704c34c15b2 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stream *xdr, str=
uct nfs4_cb_compound_hdr *hdr,
> >         hdr->nops++;
> >  }
> >
> > +static u32 highest_slotid(struct nfsd4_session *ses)
> > +{
> > +       u32 idx;
> > +
> > +       spin_lock(&ses->se_lock);
> > +       idx =3D fls(~ses->se_cb_slot_avail);
> > +       if (idx > 0)
> > +               --idx;
> > +       idx =3D max(idx, ses->se_cb_highest_slot);
> > +       spin_unlock(&ses->se_lock);
> > +       return idx;
> > +}
> > +
> >  /*
> >   * CB_SEQUENCE4args
> >   *
> > @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(struct xdr_st=
ream *xdr,
> >         encode_sessionid4(xdr, session);
> >
> >         p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > -       *p++ =3D cpu_to_be32(session->se_cb_seq_nr);      /* csa_sequen=
ceid */
> > -       *p++ =3D xdr_zero;                        /* csa_slotid */
> > -       *p++ =3D xdr_zero;                        /* csa_highest_slotid=
 */
> > +       *p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_held_slot]); =
   /* csa_sequenceid */
> > +       *p++ =3D cpu_to_be32(cb->cb_held_slot);           /* csa_slotid=
 */
> > +       *p++ =3D cpu_to_be32(highest_slotid(session)); /* csa_highest_s=
lotid */
> >         *p++ =3D xdr_zero;                        /* csa_cachethis */
> >         xdr_encode_empty_array(p);              /* csa_referring_call_l=
ists */
> >
> >         hdr->nops++;
> >  }
> >
> > +static void update_cb_slot_table(struct nfsd4_session *ses, u32 target=
)
> > +{
> > +       /* No need to do anything if nothing changed */
> > +       if (likely(target =3D=3D READ_ONCE(ses->se_cb_highest_slot)))
> > +               return;
> > +
> > +       spin_lock(&ses->se_lock);
> > +       if (target > ses->se_cb_highest_slot) {
> > +               int i;
> > +
> > +               target =3D min(target, NFSD_BC_SLOT_TABLE_MAX);
> > +
> > +               /* Growing the slot table. Reset any new sequences to 1=
 */
> > +               for (i =3D ses->se_cb_highest_slot + 1; i <=3D target; =
++i)
> > +                       ses->se_cb_seq_nr[i] =3D 1;
> > +       }
> > +       ses->se_cb_highest_slot =3D target;
> > +       spin_unlock(&ses->se_lock);
> > +}
> > +
> >  /*
> >   * CB_SEQUENCE4resok
> >   *
> > @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(struct xdr_stre=
am *xdr,
> >         struct nfsd4_session *session =3D cb->cb_clp->cl_cb_session;
> >         int status =3D -ESERVERFAULT;
> >         __be32 *p;
> > -       u32 dummy;
> > +       u32 seqid, slotid, target;
> >
> >         /*
> >          * If the server returns different values for sessionID, slotID=
 or
> > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(struct xdr_st=
ream *xdr,
> >         }
> >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> >
> > -       dummy =3D be32_to_cpup(p++);
> > -       if (dummy !=3D session->se_cb_seq_nr) {
> > +       seqid =3D be32_to_cpup(p++);
> > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb_held_slot]) {
> >                 dprintk("NFS: %s Invalid sequence number\n", __func__);
> >                 goto out;
> >         }
> >
> > -       dummy =3D be32_to_cpup(p++);
> > -       if (dummy !=3D 0) {
> > +       slotid =3D be32_to_cpup(p++);
> > +       if (slotid !=3D cb->cb_held_slot) {
> >                 dprintk("NFS: %s Invalid slotid\n", __func__);
> >                 goto out;
> >         }
> >
> > -       /*
> > -        * FIXME: process highest slotid and target highest slotid
> > -        */
> > +       p++; // ignore current highest slot value
> > +
> > +       target =3D be32_to_cpup(p++);
> > +       update_cb_slot_table(session, target);
> >         status =3D 0;
> >  out:
> >         cb->cb_seq_status =3D status;
> > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nfs4_client *c=
lp, struct nfs4_cb_conn *conn)
> >         spin_unlock(&clp->cl_lock);
> >  }
> >
> > +static int grab_slot(struct nfsd4_session *ses)
> > +{
> > +       int idx;
> > +
> > +       spin_lock(&ses->se_lock);
> > +       idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > +       if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > +               spin_unlock(&ses->se_lock);
> > +               return -1;
> > +       }
> > +       /* clear the bit for the slot */
> > +       ses->se_cb_slot_avail &=3D ~BIT(idx);
> > +       spin_unlock(&ses->se_lock);
> > +       return idx;
> > +}
> > +
> >  /*
> >   * There's currently a single callback channel slot.
> >   * If the slot is available, then mark it busy.  Otherwise, set the
> > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct nfs4_client *=
clp, struct nfs4_cb_conn *conn)
> >  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_t=
ask *task)
> >  {
> >         struct nfs4_client *clp =3D cb->cb_clp;
> > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> >
> > -       if (!cb->cb_holds_slot &&
> > -           test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) {
> > +       if (cb->cb_held_slot >=3D 0)
> > +               return true;
> > +       cb->cb_held_slot =3D grab_slot(ses);
> > +       if (cb->cb_held_slot < 0) {
> >                 rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> >                 /* Race breaker */
> > -               if (test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D 0) =
{
> > -                       dprintk("%s slot is busy\n", __func__);
> > +               cb->cb_held_slot =3D grab_slot(ses);
> > +               if (cb->cb_held_slot < 0)
> >                         return false;
> > -               }
> >                 rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
> >         }
> > -       cb->cb_holds_slot =3D true;
> >         return true;
> >  }
> >
> >  static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
> >  {
> >         struct nfs4_client *clp =3D cb->cb_clp;
> > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> >
> > -       if (cb->cb_holds_slot) {
> > -               cb->cb_holds_slot =3D false;
> > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > +       if (cb->cb_held_slot >=3D 0) {
> > +               spin_lock(&ses->se_lock);
> > +               ses->se_cb_slot_avail |=3D BIT(cb->cb_held_slot);
> > +               spin_unlock(&ses->se_lock);
> > +               cb->cb_held_slot =3D -1;
> >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> >         }
> >  }
> > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct nfsd4_callba=
ck *cb)
> >  }
> >
> >  /*
> > - * TODO: cb_sequence should support referring call lists, cachethis, m=
ultiple
> > - * slots, and mark callback channel down on communication errors.
> > + * TODO: cb_sequence should support referring call lists, cachethis,
> > + * and mark callback channel down on communication errors.
> >   */
> >  static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
> >  {
> > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_tas=
k *task, struct nfsd4_callback
> >                 return true;
> >         }
> >
> > -       if (!cb->cb_holds_slot)
> > +       if (cb->cb_held_slot < 0)
> >                 goto need_restart;
> >
> >         /* This is the operation status code for CB_SEQUENCE */
> > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_t=
ask *task, struct nfsd4_callback
> >                  * If CB_SEQUENCE returns an error, then the state of t=
he slot
> >                  * (sequence ID, cached reply) MUST NOT change.
> >                  */
> > -               ++session->se_cb_seq_nr;
> > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> >                 break;
> >         case -ESERVERFAULT:
> > -               ++session->se_cb_seq_nr;
> > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> >                 nfsd4_mark_cb_fault(cb->cb_clp);
> >                 ret =3D false;
> >                 break;
> > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(struct rpc_t=
ask *task, struct nfsd4_callback
> >         case -NFS4ERR_BADSLOT:
> >                 goto retry_nowait;
> >         case -NFS4ERR_SEQ_MISORDERED:
> > -               if (session->se_cb_seq_nr !=3D 1) {
> > -                       session->se_cb_seq_nr =3D 1;
> > +               if (session->se_cb_seq_nr[cb->cb_held_slot] !=3D 1) {
> > +                       session->se_cb_seq_nr[cb->cb_held_slot] =3D 1;
> >                         goto retry_nowait;
> >                 }
> >                 break;
> >         default:
> >                 nfsd4_mark_cb_fault(cb->cb_clp);
> >         }
> > -       nfsd41_cb_release_slot(cb);
> > -
> >         trace_nfsd_cb_free_slot(task, cb);
> > +       nfsd41_cb_release_slot(cb);
> >
> >         if (RPC_SIGNALLED(task))
> >                 goto need_restart;
> > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, str=
uct nfs4_client *clp,
> >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> >         cb->cb_status =3D 0;
> >         cb->cb_need_restart =3D false;
> > -       cb->cb_holds_slot =3D false;
> > +       cb->cb_held_slot =3D -1;
> >  }
> >
> >  /**
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc9265517f519525=
63beaa4cfe8adcc3f 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_session(struct=
 nfsd4_channel_attrs *fattrs,
> >         }
> >
> >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_a=
ttrs));
> > +       new->se_cb_slot_avail =3D ~0U;
> > +       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > +       spin_lock_init(&new->se_lock);
> >         return new;
> >  out_free:
> >         while (i--)
> > @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqstp=
, struct nfsd4_session *new, stru
> >
> >         INIT_LIST_HEAD(&new->se_conns);
> >
> > -       new->se_cb_seq_nr =3D 1;
> > +       atomic_set(&new->se_ref, 0);
> >         new->se_dead =3D false;
> >         new->se_cb_prog =3D cses->callback_prog;
> >         new->se_cb_sec =3D cses->cb_sec;
> > -       atomic_set(&new->se_ref, 0);
> > +
> > +       for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > +               new->se_cb_seq_nr[idx] =3D 1;
> > +
> >         idx =3D hash_sessionid(&new->se_sessionid);
> >         list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]);
> >         spin_lock(&clp->cl_lock);
> > @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_client(struct x=
dr_netobj name,
> >         kref_init(&clp->cl_nfsdfs.cl_ref);
> >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NUL=
L);
> >         clp->cl_time =3D ktime_get_boottime_seconds();
> > -       clear_bit(0, &clp->cl_cb_slot_busy);
> >         copy_verf(clp, verf);
> >         memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
> >         clp->cl_cb_session =3D NULL;
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb308f0b69916c4e=
e34b09075708f0de3 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> >         struct work_struct cb_work;
> >         int cb_seq_status;
> >         int cb_status;
> > +       int cb_held_slot;
> >         bool cb_need_restart;
> > -       bool cb_holds_slot;
> >  };
> >
> >  struct nfsd4_callback_ops {
> > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> >         unsigned char cn_flags;
> >  };
> >
> > +/* Highest slot index that nfsd implements in NFSv4.1+ backchannel */
> > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > +
> >  /*
> >   * Representation of a v4.1+ session. These are refcounted in a simila=
r fashion
> >   * to the nfs4_client. References are only taken when the server is ac=
tively
> > @@ -314,6 +317,10 @@ struct nfsd4_conn {
> >   */
> >  struct nfsd4_session {
> >         atomic_t                se_ref;
> > +       spinlock_t              se_lock;
> > +       u32                     se_cb_slot_avail; /* bitmap of availabl=
e slots */
> > +       u32                     se_cb_highest_slot;     /* highest slot=
 client wants */
> > +       u32                     se_cb_prog;
> >         bool                    se_dead;
> >         struct list_head        se_hash;        /* hash by sessionid */
> >         struct list_head        se_perclnt;
> > @@ -322,8 +329,7 @@ struct nfsd4_session {
> >         struct nfsd4_channel_attrs se_fchannel;
> >         struct nfsd4_cb_sec     se_cb_sec;
> >         struct list_head        se_conns;
> > -       u32                     se_cb_prog;
> > -       u32                     se_cb_seq_nr;
> > +       u32                     se_cb_seq_nr[NFSD_BC_SLOT_TABLE_MAX + 1=
];
> >         struct nfsd4_slot       *se_slots[];    /* forward channel slot=
s */
> >  };
> >
> > @@ -457,9 +463,6 @@ struct nfs4_client {
> >          */
> >         struct dentry           *cl_nfsd_info_dentry;
> >
> > -       /* for nfs41 callbacks */
> > -       /* We currently support a single back channel with a single slo=
t */
> > -       unsigned long           cl_cb_slot_busy;
> >         struct rpc_wait_queue   cl_cb_waitq;    /* backchannel callers =
may */
> >                                                 /* wait here for slots =
*/
> >         struct net              *net;
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index f318898cfc31614b5a84a4867e18c2b3a07122c9..a9c17186b6892f1df8d7f7b=
90e250c2913ab23fe 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -1697,7 +1697,7 @@ TRACE_EVENT(nfsd_cb_free_slot,
> >                 __entry->cl_id =3D sid->clientid.cl_id;
> >                 __entry->seqno =3D sid->sequence;
> >                 __entry->reserved =3D sid->reserved;
> > -               __entry->slot_seqno =3D session->se_cb_seq_nr;
> > +               __entry->slot_seqno =3D session->se_cb_seq_nr[cb->cb_he=
ld_slot];
> >         ),
> >         TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
> >                 " sessionid=3D%08x:%08x:%08x:%08x new slot seqno=3D%u",
> >
> > ---
> > base-commit: 3c16aac09d20f9005fbb0e737b3ec520bbb5badd
> > change-id: 20241025-bcwide-6bd7e4b63db2
> >
> > Best regards,
> > --
> > Jeff Layton <jlayton@kernel.org>
> >
> >


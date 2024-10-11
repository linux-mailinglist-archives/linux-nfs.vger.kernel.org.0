Return-Path: <linux-nfs+bounces-7100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC6599AD4E
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E1CB26C96
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF69C19E979;
	Fri, 11 Oct 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blhyvg6K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF681C3F0A
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676895; cv=none; b=QPoFck0d4Z/WkKwQVKF4eTccP6mQ8FsHJXvPTS7/VdunATlejMuiRBMqB8YfIqu9li7eI+XglNq+JuU6qfyDrK99NhGS5/9J9eqB9ZlQAAig1rfoGLD61Mx+C9xpFzjhEvF381HH4b6e3D03HWruI4JVkWmQU4EIcr8XkWD/DQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676895; c=relaxed/simple;
	bh=/DWBKvQagS0Wp6H3EYcCbjltX14fRPftp0PNm4ch5+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMLJq5w1AxQ/MXGnUBvEQa9ryTButTiI5rtOGoGBcLw/sgWY7WFVFxcCUxI55aabI+XQM/6LLZ5j+imYC7FwTOuNDz2UPvIX3V38rbrhif8KxjXhRpn67H8S1wXukSvkVO2PQF5flOPnN8h885+RYP0+RnGJDyCDYEnZH8Pb7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blhyvg6K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728676892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHDuypZTtVZT0WxYjMHnNs3JOH4av880z38/C+Cs02I=;
	b=blhyvg6KPbJ0Dh1p3GB4INHMetf6LS4zG+ywk++KtxN9l47xgkTo0TDxealoTcHHG4fx62
	YuRSkUBppyE8mYk0Q2Zng/UkmDajfzfVBLHNR36xdcfCpNcS4/bTYhw2p3Y2Opu5inxl+J
	DJhyX1iTqK4eyFANFbrc7t4ison+Seg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-g9qIPzTWMJmWjsMqlVCMFA-1; Fri, 11 Oct 2024 16:01:30 -0400
X-MC-Unique: g9qIPzTWMJmWjsMqlVCMFA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a994cd8089aso174333866b.2
        for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676888; x=1729281688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHDuypZTtVZT0WxYjMHnNs3JOH4av880z38/C+Cs02I=;
        b=o+IzPMIv01JVKsiPuOybZWSNBXgbMCjl7EV8BaFsafM2yrjnpywGr/09SU0E+GeUx8
         UoaiEAqzchHjR0/AE91/2XPpstDaL4yE82vf/UNWjDp0d7jrUXtb0LS2E2DPc3Xu6+Dw
         VMe1gK1KMo1vggG3VMnY3JGdEBQhniw/NhlnFs/5ApNFQ7R/JcMJmbk5PdSjpYkWt+TT
         +3Lolt8YglXuO66Lt/s49ZE59M2MEEpM4blqcI97/9uRJpZCxVGWjj+U2cXIUM7FrQae
         WWWxzxYcvaYH4V0qwxtuKaPwxGWi/4dDZhpe1NtbUE1ts3Uc+EiahO74h4M/M+/PP5MC
         S8sA==
X-Forwarded-Encrypted: i=1; AJvYcCVkAqw8dHNU8MX1bHlaBp/42rZHebwd1pdjacmOTnkF/bNmTmwpsGZ9RYyrH4+s1geRYRV25ecDawM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIx1PatCoQYU7snW8YQ//t3ObhNZLRNdjDnB8nkIMfVPHLTmit
	NvwxstWeiPgmjMKDl+NQWOAyIftMrnsUdwXChQWLszQFhrgtklhvI+YxiipHIQLwv/MTw1Jwp3I
	DBBjzWh5sbIFDJeOUFsDq+NKd3XRL1FeOERy4ubXXYvA4DIYeFZvDYYxm5epHgFsyowtqCE4LLc
	2AErjE04sRavhXQmFgTBbVYdSBHS0Fs2JS
X-Received: by 2002:a17:907:2cc2:b0:a8d:439d:5c3c with SMTP id a640c23a62f3a-a99e3b20d62mr73874366b.8.1728676888378;
        Fri, 11 Oct 2024 13:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGzqaLnNTTJDMSJpxjLSBWIDWp1dphCWFd4g5vqnZlvpdthp8xNF7Q+BOq5TKSx8qoxkC8Hl6JDsYnkjncqws=
X-Received: by 2002:a17:907:2cc2:b0:a8d:439d:5c3c with SMTP id
 a640c23a62f3a-a99e3b20d62mr73872066b.8.1728676887892; Fri, 11 Oct 2024
 13:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010221801.35462-1-okorniev@redhat.com> <Zwk4mAhnaoFe43Gy@tissot.1015granger.net>
 <f824c20c2eda23bcd98c75dc5313f0f8da5e6b84.camel@kernel.org>
In-Reply-To: <f824c20c2eda23bcd98c75dc5313f0f8da5e6b84.camel@kernel.org>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Fri, 11 Oct 2024 16:01:16 -0400
Message-ID: <CACSpFtCj5zpLKp_=kbjFkfjK6FOrE_n1oDNC2N20b+07c+Luug@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:17=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2024-10-11 at 10:39 -0400, Chuck Lever wrote:
> > On Thu, Oct 10, 2024 at 06:18:01PM -0400, Olga Kornievskaia wrote:
> > > There is a race between laundromat handling of revoked delegations
> > > and a client sending free_stateid operation. Laundromat thread
> > > finds that delegation has expired and needs to be revoked so it
> > > marks the delegation stid revoked and it puts it on a reaper list
> > > but then it unlock the state lock and the actual delegation revocatio=
n
> > > happens without the lock. Once the stid is marked revoked a racing
> > > free_stateid processing thread does the following (1) it calls
> > > list_del_init() which removes it from the reaper list and (2) frees
> > > the delegation stid structure. The laundromat thread ends up not
> > > calling the revoke_delegation() function for this particular delegati=
on
> > > but that means it will no release the lock lease that exists on
> > > the file.
> > >
> > > Now, a new open for this file comes in and ends up finding that
> > > lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
> > > up trying to derefence a freed delegation stateid. Leading to the
> > > followint use-after-free KASAN warning:
> > >
> > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > kernel: BUG: KASAN: slab-use-after-free in nfsd_breaker_owns_lease+0x=
140/0x160 [nfsd]
> > > kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
> > > kernel:
> > > kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted =
6.11.0-rc7+ #9
> > > kernel: Hardware name: Apple Inc. Apple Virtualization Generic Platfo=
rm, BIOS 2069.0.0.0.0 08/03/2024
> > > kernel: Call trace:
> > > kernel: dump_backtrace+0x98/0x120
> > > kernel: show_stack+0x1c/0x30
> > > kernel: dump_stack_lvl+0x80/0xe8
> > > kernel: print_address_description.constprop.0+0x84/0x390
> > > kernel: print_report+0xa4/0x268
> > > kernel: kasan_report+0xb4/0xf8
> > > kernel: __asan_report_load8_noabort+0x1c/0x28
> > > kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> > > kernel: leases_conflict+0x68/0x370
> > > kernel: __break_lease+0x204/0xc38
> > > kernel: nfsd_open_break_lease+0x8c/0xf0 [nfsd]
> > > kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
> > > kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
> > > kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
> > > kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
> > > kernel: nfsd4_open+0xa08/0xe80 [nfsd]
> > > kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
> > > kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
> > > kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
> > > kernel: svc_process+0x3d4/0x7e0 [sunrpc]
> > > kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
> > > kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
> > > kernel: nfsd+0x270/0x400 [nfsd]
> > > kernel: kthread+0x288/0x310
> > > kernel: ret_from_fork+0x10/0x20
> > >
> > > Proposing to have laundromat thread hold the state_lock over both
> > > marking thru revoking the delegation as well as making free_stateid
> > > acquire state_lock before accessing the list. Making sure that
> > > revoke_delegation() (ie kernel_setlease(unlock)) is called for
> > > every delegation that was revoked and added to the reaper list.
> > >
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > >
> > > --- I can't figure out the Fixes: tag. Laundromat's behaviour has
> > > been like that forever. But the free_stateid bits wont apply before
> > > the 1e3577a4521e ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> > > But we used that fixes tag already with a previous fix for a differen=
t
> > > problem.
> > > ---
> > >  fs/nfsd/nfs4state.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 9c2b1d251ab3..c97907d7fb38 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -6605,13 +6605,13 @@ nfs4_laundromat(struct nfsd_net *nn)
> > >             unhash_delegation_locked(dp, SC_STATUS_REVOKED);
> > >             list_add(&dp->dl_recall_lru, &reaplist);
> > >     }
> > > -   spin_unlock(&state_lock);
> > >     while (!list_empty(&reaplist)) {
> > >             dp =3D list_first_entry(&reaplist, struct nfs4_delegation=
,
> > >                                     dl_recall_lru);
> > >             list_del_init(&dp->dl_recall_lru);
> > >             revoke_delegation(dp);
> > >     }
> > > +   spin_unlock(&state_lock);
> >
> > Code review suggests revoke_delegation() (and in particular,
> > destroy_unhashed_deleg(), must not be called while holding
> > state_lock().
> >
>
> We'd be calling nfs4_unlock_deleg_lease with a spinlock held, which is
> sort of gross.
>
> That said, I don't love this fix either.
>
> >
> > >     spin_lock(&nn->client_lock);
> > >     while (!list_empty(&nn->close_lru)) {
> > > @@ -7213,7 +7213,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstate,
> > >             if (s->sc_status & SC_STATUS_REVOKED) {
> > >                     spin_unlock(&s->sc_lock);
> > >                     dp =3D delegstateid(s);
> > > +                   spin_lock(&state_lock);
> > >                     list_del_init(&dp->dl_recall_lru);
> > > +                   spin_unlock(&state_lock);
> >
> > Existing code is inconsistent about how manipulation of
> > dl_recall_lru is protected. Most instances do use state_lock for
> > this purpose, but a few, including this one, use cl->cl_lock. Does
> > the other instance using cl_lock need review and correction as well?
> >
> > I'd prefer to see this fix make the protection of dl_recall_lru
> > consistent everywhere.
> >
>
> Agreed. The locking around the delegation handling has been a mess for
> a long time. I'd really like to have a way to fix this that didn't
> require having to rework all of this code however.
>
> How about something like this patch instead? Olga, thoughts?

I think this patch will prevent the UAF but it doesn't work for
another reason (tested it too). As the free_stateid operation can come
in before the freeable flag is set (and so the nfsd4_free_stateid
function would not do anything). But it needs to remove this
delegation from cl_revoked which the laundromat puts it on as a part
of revoked_delegation() otherwise the server never clears
recallable_state_revoked. And I think this put_stid() that
free_stateid does is also needed. So what happens is free_stateid
comes and goes and the sequence flag is set and is never cleared.

Laundromat threat when it starts revocation process it either needs to
'finish it' but it needs to make sure that if free_stateid arrives in
the meanwhile it has to wait but still run. Or I was thinking that
perhaps, we can make free_stateid act like delegreturn. but I wasn't
sure if free_stateid is allowed to act like delegreturn. but this also
fixes the problem if the free_stateid arrives and takes the work away
from the laundromat thread then free_stateid finishes the return just
like a delegreturn (which unlocks the lease). But I'm unclear if there
isn't any races between revoke_delegation and destroy_delegation.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 56b261608af4..1ef6933b1ccb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7159,6 +7159,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp,
struct nfsd4_compound_state *cstate,
                        dp =3D delegstateid(s);
                        list_del_init(&dp->dl_recall_lru);
                        spin_unlock(&cl->cl_lock);
+                       destroy_delegation(dp);
                        nfs4_put_stid(s);
                        ret =3D nfs_ok;
                        goto out;



> [PATCH] nfsd: add new SC_STATUS_FREEABLE to prevent race with  FREE_STATE=
ID
>
> Olga identified a race between the laundromat and FREE_STATEID handling.
> The crux of the problem is that free_stateid can proceed while the
> laundromat is still processing the revocation.
>
> Add a new SC_STATUS_FREEABLE flag that is set once the revocation is
> complete. Have nfsd4_free_stateid only consider delegations that have
> this flag set.
>
> Reported-by: Olga Kornievskaia <okorniev@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 3 ++-
>  fs/nfsd/state.h     | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 73c4b983c048..b71a2cc7f2dd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1371,6 +1371,7 @@ static void revoke_delegation(struct nfs4_delegatio=
n *dp)
>                 spin_lock(&clp->cl_lock);
>                 refcount_inc(&dp->dl_stid.sc_count);
>                 list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> +               dp->dl_stid.sc_status |=3D SC_STATUS_FREEABLE;
>                 spin_unlock(&clp->cl_lock);
>         }
>         destroy_unhashed_deleg(dp);
> @@ -7207,7 +7208,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>         spin_lock(&s->sc_lock);
>         switch (s->sc_type) {
>         case SC_TYPE_DELEG:
> -               if (s->sc_status & SC_STATUS_REVOKED) {
> +               if (s->sc_status & SC_STATUS_FREEABLE) {
>                         spin_unlock(&s->sc_lock);
>                         dp =3D delegstateid(s);
>                         list_del_init(&dp->dl_recall_lru);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 874fcab2b183..4f3b941b09d3 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -114,6 +114,7 @@ struct nfs4_stid {
>  /* For a deleg stateid kept around only to process free_stateid's: */
>  #define SC_STATUS_REVOKED      BIT(1)
>  #define SC_STATUS_ADMIN_REVOKED        BIT(2)
> +#define SC_STATUS_FREEABLE     BIT(3)
>         unsigned short          sc_status;
>
>         struct list_head        sc_cp_list;
> --
> 2.47.0
>



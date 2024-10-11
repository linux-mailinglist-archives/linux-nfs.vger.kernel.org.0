Return-Path: <linux-nfs+bounces-7079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D899A59C
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 16:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55AD1B24B4D
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 14:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741E0219C85;
	Fri, 11 Oct 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="B8i7hIXF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721CF219CB4;
	Fri, 11 Oct 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655176; cv=none; b=rp3rREHz4XVHm5NWpo3SsrD3oIe3OBE9QCvTALTVHwVGuXyImrJKQjVAEOVA78bvYYpm04U7qkpJu4NWa0LJl85RJilZia/E8fB/nZUOL9Kv+LZYRjflB4faHucM5QgCYr76R/zwQnOXI2kgRCcJqAYVjSbpLw8GHhqQgc90vF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655176; c=relaxed/simple;
	bh=5wN0fNR0RQR/sSExf9/da6JlcjLqAci7TBnhVZDQbMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohnK3/LnzoLkXTDn1phUetUMI+q14lySfL+Hnehuj8DzVYnkk/fzH7Kh2tOqSVUeoow7pac6tINMB7AXgGVGUj8ZTNS2k/IXXrD3phWeo3cz3SnwggEfuf/3Hlb/GrLY2Doezwv7Uou2v8rq1hDw3W8nwwb1YTc2U2yYgUyGQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=B8i7hIXF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb2f4b282cso10824371fa.2;
        Fri, 11 Oct 2024 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1728655173; x=1729259973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkCcF+Tl/EA4VlABCDtqKbR8XJGq/VzRahZCkp42b/I=;
        b=B8i7hIXFA9j4k0CueSJKC0doEoWL5MBd7ALA+Vs/d6Y4ZSz7eEU4axaatmpymDJESB
         eTHFEiMj/5Gsuk09cQHuEDURXesbE8n31xhoqnX1P3uV5kGgLzGucsZq0gjPtFSIuooY
         BOjDLFQBl4xeGdgAUS68i1p/qLyl/x9viI/8U9uNfkaEsM1ZU8jV37vAEIH4q4ZdPHaq
         iZmpy4/EQRcamdS9NhwTl2LAJyAmLj9eULchsLxTOJeAre8/u4rbdwI/hoBtTHbVtA2R
         WgPmNgEj4nIsD2cHEqTxLUVAz3WJQz6mmfzJzV/q7AOo6fM7POqhfSyiTpyDxLyXZY4J
         zPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728655173; x=1729259973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkCcF+Tl/EA4VlABCDtqKbR8XJGq/VzRahZCkp42b/I=;
        b=sQl+XH9prj1qBsdr0Ve3tq0wGrA1o6ZHh49S/klZI2qB6RvkF0Z5pIpHPCNreSsSzj
         PJZmewQCjftOF8xo5fs6VOL0aeTQQbsjWZHqs+5RqWJmYjVyN5C1vnqo1sI2nhuKjw5u
         DhChuZRxRD3w6TERfsIeA8R925YuD0PBKRUwi7hEkq5RCuOD9QDpbZbjtxFamXVjwoGC
         EiPPFhL0LVrqKXKczTSksWQF5VRRYxSHJ0GZ5FuHf5NjOd+wKsszN7rCqL7Hh+aDEFo9
         EbZehrNNk5wJuxv6aTOBCUnvQxZHr8cqHcgNwqpsnk2WMiPI7UxKf5zzgO7GsXJ/DLtO
         oJgw==
X-Forwarded-Encrypted: i=1; AJvYcCW0NVZoO6kJM2J1z3zLiEbBCgdf5CUsmwZcomR5v56GQA1c8EFsctd/USNM6oct6D7ZSUDF4tvR@vger.kernel.org, AJvYcCWj8HH4kGSGzHJHeRlCG07ath6SvAC458HUjctaNCuPSHojwydzJqMhMGqASymQ9VZrokv3GVyXvxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAj5a1fDfeU6amrpkQV9WWZ2SthAF31dVFQI/IOPEOS3iiqEJo
	JFXWjHCHxG6+scTqteZYEXvChRJQ+bTUBBKsri5gamyU5YsnuP2epFdRYuNwYJDaSKGTxm6AdJt
	anfT7O6tFvrGwCjR6qYTxAPFkaVY=
X-Google-Smtp-Source: AGHT+IG9BtUIoz9OgS8piq2+J/kiiEUdf9tGj5+k99XJ7W8wEanPgdRbDjA8oEVr++FQ4CJW1kOnWvYyK6eD573D1Pk=
X-Received: by 2002:a2e:6109:0:b0:2f5:abe:b6bd with SMTP id
 38308e7fff4ca-2fb32b0242emr13422181fa.42.1728655172251; Fri, 11 Oct 2024
 06:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010221801.35462-1-okorniev@redhat.com> <ae0003013659a34279e3666180cd8b730ca3a2d8.camel@kernel.org>
In-Reply-To: <ae0003013659a34279e3666180cd8b730ca3a2d8.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 11 Oct 2024 09:59:20 -0400
Message-ID: <CAN-5tyEbkbOB+zeo8FfgHMhfz6Ss7rSxaiYaHCWv8KNLfQfYsA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:06=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2024-10-10 at 18:18 -0400, Olga Kornievskaia wrote:
> > There is a race between laundromat handling of revoked delegations
> > and a client sending free_stateid operation. Laundromat thread
> > finds that delegation has expired and needs to be revoked so it
> > marks the delegation stid revoked and it puts it on a reaper list
> > but then it unlock the state lock and the actual delegation revocation
> > happens without the lock. Once the stid is marked revoked a racing
> > free_stateid processing thread does the following (1) it calls
> > list_del_init() which removes it from the reaper list and (2) frees
> > the delegation stid structure. The laundromat thread ends up not
> > calling the revoke_delegation() function for this particular delegation
> > but that means it will no release the lock lease that exists on
> > the file.
> >
> > Now, a new open for this file comes in and ends up finding that
> > lease list isn't empty and calls nfsd_breaker_owns_lease() which ends
> > up trying to derefence a freed delegation stateid. Leading to the
> > followint use-after-free KASAN warning:
> >
> > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > kernel: BUG: KASAN: slab-use-after-free in nfsd_breaker_owns_lease+0x14=
0/0x160 [nfsd]
> > kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
> > kernel:
> > kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not tainted 6.=
11.0-rc7+ #9
> > kernel: Hardware name: Apple Inc. Apple Virtualization Generic Platform=
, BIOS 2069.0.0.0.0 08/03/2024
> > kernel: Call trace:
> > kernel: dump_backtrace+0x98/0x120
> > kernel: show_stack+0x1c/0x30
> > kernel: dump_stack_lvl+0x80/0xe8
> > kernel: print_address_description.constprop.0+0x84/0x390
> > kernel: print_report+0xa4/0x268
> > kernel: kasan_report+0xb4/0xf8
> > kernel: __asan_report_load8_noabort+0x1c/0x28
> > kernel: nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> > kernel: leases_conflict+0x68/0x370
> > kernel: __break_lease+0x204/0xc38
> > kernel: nfsd_open_break_lease+0x8c/0xf0 [nfsd]
> > kernel: nfsd_file_do_acquire+0xb3c/0x11d0 [nfsd]
> > kernel: nfsd_file_acquire_opened+0x84/0x110 [nfsd]
> > kernel: nfs4_get_vfs_file+0x634/0x958 [nfsd]
> > kernel: nfsd4_process_open2+0xa40/0x1a40 [nfsd]
> > kernel: nfsd4_open+0xa08/0xe80 [nfsd]
> > kernel: nfsd4_proc_compound+0xb8c/0x2130 [nfsd]
> > kernel: nfsd_dispatch+0x22c/0x718 [nfsd]
> > kernel: svc_process_common+0x8e8/0x1960 [sunrpc]
> > kernel: svc_process+0x3d4/0x7e0 [sunrpc]
> > kernel: svc_handle_xprt+0x828/0xe10 [sunrpc]
> > kernel: svc_recv+0x2cc/0x6a8 [sunrpc]
> > kernel: nfsd+0x270/0x400 [nfsd]
> > kernel: kthread+0x288/0x310
> > kernel: ret_from_fork+0x10/0x20
> >
> > Proposing to have laundromat thread hold the state_lock over both
> > marking thru revoking the delegation as well as making free_stateid
> > acquire state_lock before accessing the list. Making sure that
> > revoke_delegation() (ie kernel_setlease(unlock)) is called for
> > every delegation that was revoked and added to the reaper list.
> >
>
> Nice detective work!
>
> > CC: stable@vger.kernel.org
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >
> > --- I can't figure out the Fixes: tag. Laundromat's behaviour has
> > been like that forever. But the free_stateid bits wont apply before
> > the 1e3577a4521e ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> > But we used that fixes tag already with a previous fix for a different
> > problem.
> > ---
> >  fs/nfsd/nfs4state.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 9c2b1d251ab3..c97907d7fb38 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6605,13 +6605,13 @@ nfs4_laundromat(struct nfsd_net *nn)
> >               unhash_delegation_locked(dp, SC_STATUS_REVOKED);
> >               list_add(&dp->dl_recall_lru, &reaplist);
> >       }
> > -     spin_unlock(&state_lock);
> >       while (!list_empty(&reaplist)) {
> >               dp =3D list_first_entry(&reaplist, struct nfs4_delegation=
,
> >                                       dl_recall_lru);
> >               list_del_init(&dp->dl_recall_lru);
> >               revoke_delegation(dp);
> >       }
> > +     spin_unlock(&state_lock);
> >
> >       spin_lock(&nn->client_lock);
> >       while (!list_empty(&nn->close_lru)) {
> > @@ -7213,7 +7213,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> >               if (s->sc_status & SC_STATUS_REVOKED) {
> >                       spin_unlock(&s->sc_lock);
> >                       dp =3D delegstateid(s);
> > +                     spin_lock(&state_lock);
> >                       list_del_init(&dp->dl_recall_lru);
> > +                     spin_unlock(&state_lock);
> >                       spin_unlock(&cl->cl_lock);
> >                       nfs4_put_stid(s);
> >                       ret =3D nfs_ok;
>
>
> I'm not thrilled with this patch, but it does seem like it would fix
> the problem. Long term, I think we need to get rid of the state_lock,
> but I don't have a real plan for that just yet as it's not 100% clear
> what it still protects.

I wasn't thrilled with the patch either but I couldn't think of
something else so I thought to see what others think.

My apologies, I also realized that when I tried to make sure I
submitted the patch against the latest code I did this against
nfsd-next not nfsd-fixes. There should have been that line with
changed sc_status to LOCKED. Again, doesn't change the fix, just what
this patch was applied to before sending it...

I'll send out a v2 but also try to test what Trond suggest by doing
locking differently.

>
> As far as a Fixes tag, this bug is likely very old. I'd say it probably
> got introduced here:
>
>     2d4a532d385f nfsd: ensure that clp->cl_revoked list is protected by c=
lp->cl_lock
>
> In any case, let's go with this patch until we can come up with a
> better plan for delegation handling.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>


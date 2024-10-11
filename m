Return-Path: <linux-nfs+bounces-7077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0019F99A549
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A571C2149E
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9CC2185B1;
	Fri, 11 Oct 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="VEL1wg2h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2411804;
	Fri, 11 Oct 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654214; cv=none; b=FaO8YsIbgNSlt+t6Ykm43PGgVDUZQC7UifxjDPcbwUXrf4baFFwINbxXxE1bIO7Rj+GbbWjx0CqnEOL3nXCi+xrkZnTlM/3GtLZ/Ooq2sDGMeHC9qcwYtRxKKly4x16zsqWHhiWbC0dGxP5IQ8lfvdrW4Z6Js9vhSPVm1X2MTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654214; c=relaxed/simple;
	bh=AylHPhTik+Q2+QE2CWmTsOGsVjLnA7DCIBPkES4jHI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxCOAzcl8JF1dWVCaFkqtnF/9/rXPps5il29VyHd/pVb0Dw4h7WXerk2flpkcyRosGeY8dZBcs47Q8Z4+weuQ0/LOm5GV0JumUq1SHVticIucGAiWgYAiYALteZo05R28NBEU9cG+BCRI65JBqqvE/pX9EdG/qf+rIj1RWG0bxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=VEL1wg2h; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb3ce15172so1445151fa.0;
        Fri, 11 Oct 2024 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1728654211; x=1729259011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex3/zGmNs+1/8Sa2ib0yDudMwo0wJJhUhe8J3epEqi0=;
        b=VEL1wg2hP9jdpvMcGTo4+Ht3umfqcTcDUnANA9uRsbf5ivHmT6N2HsUiuM61t3/T5P
         uhXFkaxYZ4+/UJ7AgLn1AN/vaKn74lEwIU+PVM39cbm+sbCtg/ma20/LDWWvq6SkvVCi
         iDdtInzbJWjagOI7YpwWf3vyfD4eQbRgTuzhGxlfsUB3sXVbKzZxnufIbc+8ymeEcGuw
         b4ndSdca9QnsPmgVcf/2ctADwKkmRxcPLXhafloRPj+Nsf9DnTTYGSwmki4l3zizVjCF
         LCOndnkDRBnQCZJ0ytHP4Rwb+AGF+k9EidA3kFjrE0sLAr8eTM5jNt+k9rm2yfe5tZub
         weLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654211; x=1729259011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex3/zGmNs+1/8Sa2ib0yDudMwo0wJJhUhe8J3epEqi0=;
        b=gkFake+6OrwXU7n4pCQwcB/3mu59GJeaTGGPAe3/Fl0eYpfPYwWNd62cXaW4vo0rCd
         FuCvlppQ1Hk+CNbEpl2ck6GpsJ1QUUeYJLi5xc0+KGV6nri/5CwJsTR+7+pKYxTAu2W/
         jq2t67ldwX1adcs8hU/BzeWUQEhwdM8PGDAQ4lO5MwKx95756i8i15HD5+Frbzm/Vrhg
         rYmcPUhk90XaclH/Lb2Nf3w0jxrAy9bst/KeLbHubf8GBK4UAah3oNdFE4gWAcpHf1Su
         EfCw0IJk6gtnF6wOOfF058wpBQUTAYjnPPSA8QROrz7/egJ8VQp3wKU1Xg/QZOKOCUXU
         il7g==
X-Forwarded-Encrypted: i=1; AJvYcCVP/mI45IC1/D9P96T/vRuSiweJUZ4PRi1aCD11GU7zpugbFI997gOoQ+UQPIo6bGKH4YFYrJeipSg=@vger.kernel.org, AJvYcCWd25jWZjwiIqnvTC+Ymk5Qg4O1EygVlLHmhv5wAIE0CihIA+TDQptYbsBgXF6+5ujZuTiQ9S0e@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnvy2/el6RsftqLD7oRNpq3lIPcFzs6jSS+s9mQU0ZVLl/v+qP
	IqaBRRY4ES47xDkRo/gWp6rEQNHFU7/TuEPqT/smI/zGrPHnCbc6CWlsZDNp1KRSgV3IiuM2J3K
	ZCsxvp8UY+2zoJSYBpd0FhwMWOJOqgw==
X-Google-Smtp-Source: AGHT+IGli6xYVLs6tmrxBd3iKwOM8AXzMUDPdlgOobtsh2Z2PfWBTCA233MyAoMo1j1oRel/KbY/e12DpD2yK1wU1U8=
X-Received: by 2002:a05:651c:1546:b0:2ef:2f8a:52d5 with SMTP id
 38308e7fff4ca-2fb30dcc8dfmr9729171fa.8.1728654210325; Fri, 11 Oct 2024
 06:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010221801.35462-1-okorniev@redhat.com> <ae0003013659a34279e3666180cd8b730ca3a2d8.camel@kernel.org>
 <541a46baa2eabd1a4d81520a7153617dd0a0fa7e.camel@hammerspace.com>
In-Reply-To: <541a46baa2eabd1a4d81520a7153617dd0a0fa7e.camel@hammerspace.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 11 Oct 2024 09:43:18 -0400
Message-ID: <CAN-5tyHkQS2VA1JGKoGFbB-TVen5ekqm5o00OE6UeyiU0hRXug@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: fix race between laundromat and free_stateid
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "okorniev@redhat.com" <okorniev@redhat.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:14=E2=80=AFAM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Fri, 2024-10-11 at 09:04 -0400, Jeff Layton wrote:
> > On Thu, 2024-10-10 at 18:18 -0400, Olga Kornievskaia wrote:
> > > There is a race between laundromat handling of revoked delegations
> > > and a client sending free_stateid operation. Laundromat thread
> > > finds that delegation has expired and needs to be revoked so it
> > > marks the delegation stid revoked and it puts it on a reaper list
> > > but then it unlock the state lock and the actual delegation
> > > revocation
> > > happens without the lock. Once the stid is marked revoked a racing
> > > free_stateid processing thread does the following (1) it calls
> > > list_del_init() which removes it from the reaper list and (2) frees
> > > the delegation stid structure. The laundromat thread ends up not
> > > calling the revoke_delegation() function for this particular
> > > delegation
> > > but that means it will no release the lock lease that exists on
> > > the file.
> > >
> > > Now, a new open for this file comes in and ends up finding that
> > > lease list isn't empty and calls nfsd_breaker_owns_lease() which
> > > ends
> > > up trying to derefence a freed delegation stateid. Leading to the
> > > followint use-after-free KASAN warning:
> > >
> > > kernel:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > kernel: BUG: KASAN: slab-use-after-free in
> > > nfsd_breaker_owns_lease+0x140/0x160 [nfsd]
> > > kernel: Read of size 8 at addr ffff0000e73cd0c8 by task nfsd/6205
> > > kernel:
> > > kernel: CPU: 2 UID: 0 PID: 6205 Comm: nfsd Kdump: loaded Not
> > > tainted 6.11.0-rc7+ #9
> > > kernel: Hardware name: Apple Inc. Apple Virtualization Generic
> > > Platform, BIOS 2069.0.0.0.0 08/03/2024
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
> >
> > Nice detective work!
> >
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > >
> > > --- I can't figure out the Fixes: tag. Laundromat's behaviour has
> > > been like that forever. But the free_stateid bits wont apply before
> > > the 1e3577a4521e ("SUNRPC: discard sv_refcnt, and
> > > svc_get/svc_put").
> > > But we used that fixes tag already with a previous fix for a
> > > different
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
> > >             dp =3D list_first_entry(&reaplist, struct
> > > nfs4_delegation,
> > >                                     dl_recall_lru);
> > >             list_del_init(&dp->dl_recall_lru);
> > >             revoke_delegation(dp);
> > >     }
> > > +   spin_unlock(&state_lock);
> > >
> > >     spin_lock(&nn->client_lock);
> > >     while (!list_empty(&nn->close_lru)) {
> > > @@ -7213,7 +7213,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp,
> > > struct nfsd4_compound_state *cstate,
> > >             if (s->sc_status & SC_STATUS_REVOKED) {
> > >                     spin_unlock(&s->sc_lock);
> > >                     dp =3D delegstateid(s);
> > > +                   spin_lock(&state_lock);
> > >                     list_del_init(&dp->dl_recall_lru);
> > > +                   spin_unlock(&state_lock);
> > >                     spin_unlock(&cl->cl_lock);
>
> nfs4_set_delegation() takes these locks in the opposite order, so as it
> stands, this patch introduces a potential ABBA deadlock.
> I suggest moving the state_lock so that it is taken before and released
> after the cl->cl_lock.

I understand the comment about the deadlock and the need but I would
like to make sure if I understand the direction. Are you saying that
the state_lock should be taken in the beginning of the
nfsd4_free_stated() before we take the client lock?

>
>
> > >                     nfs4_put_stid(s);
> > >                     ret =3D nfs_ok;
> >
> >
> > I'm not thrilled with this patch, but it does seem like it would fix
> > the problem. Long term, I think we need to get rid of the state_lock,
> > but I don't have a real plan for that just yet as it's not 100% clear
> > what it still protects.
> >
> > As far as a Fixes tag, this bug is likely very old. I'd say it
> > probably
> > got introduced here:
> >
> >     2d4a532d385f nfsd: ensure that clp->cl_revoked list is protected
> > by clp->cl_lock
> >
> > In any case, let's go with this patch until we can come up with a
> > better plan for delegation handling.
> >
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>


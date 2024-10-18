Return-Path: <linux-nfs+bounces-7284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6132A9A4320
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8528A6B6
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60E13BADF;
	Fri, 18 Oct 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="qUkuwihx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F74207A;
	Fri, 18 Oct 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267294; cv=none; b=S3RnBKCpjqtNvaxzDwYhBXIxSKX/6aAA/xGPKEVpideE/J3fu113Z4MQAjkb6dV35VBKMJ6hOwoztKV5qDLU3lVRObSZWkxqNzBIRSwGWDrBRl/APsQRp8zD5VCdNVlkOmSJqjPt6cmWcQMQrvdsmAV9AIPrF/Kc+uDBIhoH7nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267294; c=relaxed/simple;
	bh=DSH5ljZ8L1mmviwfX60USPqc3+8AOtMoEvMWfwHVDQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J74qZHZKFqWy9IEKLZNQ6/dm4IzE79RAauMFrSwHji5VMgrIfxlg0XSISN9voEi7npugmofNXDfG8KD+pOsv7lXoDB340WTdMmGTX0mDtbhiX9XcpbfiBpxIXvWeRFo4fDd3MroTZJ6PRumUIcfZPElpJodYz5uEzW0Zoh1Hf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=qUkuwihx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso24286441fa.0;
        Fri, 18 Oct 2024 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1729267290; x=1729872090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qa6/zrxAijZfZ594gtPgZYTFwJ6heFddsJmIF0526Q=;
        b=qUkuwihx/GvjLGCRk445WfKobhbPtLwqQnH0tkmp8cOXqb7YRyAYqWv7LPLmYPLlr1
         B1w9S6lRg+vKw/XMjCgOyQlOUZSceK86Vm3bQjEeNtY//d58vhHw3InhyU1GgR5hvKKR
         mytcJQ58SUn5d/SFKnD7PTf3SpMR/W/LpziqnxRonDc/AUfbWH5KDitRFsf6oQg9daIh
         XrkQUvKoKTOvNe455Hak2tZCyikiQWmsZRIS6UXLYtN14P2qbF0b2axszi4LiWeau2pE
         DQHzxWwKozORocyLMZ3Zzwd6Xl4LSYOVe2Uq+Thz6PN778M9gzjhY0H8Un7n2isZJ3J5
         BuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267290; x=1729872090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qa6/zrxAijZfZ594gtPgZYTFwJ6heFddsJmIF0526Q=;
        b=GicgZo9R2LfKfbw9kXUtlCtqvIqQDzk5EoqCAMkG1DlDSE1VL3ttTW4FIj0Esw8610
         ULfkFTMOolA9JRUUtq81K9qswMUMKvFsLRFI2odkNKtDHjnX1iLiJdTTXPbW4sRzB0EO
         FvstIX/yQWPIpXpAdZi5MhFxyTtbA4J94vwb5yi5docLPJTg4SejmGLD1PlotHMJNlny
         dPvz0ZsTd3yRf1X5QxU8IgiqA5/78/oPtY3yNz96V6sIlMN5Y5b3DddM1oELc4BmS/oI
         r1ckFsrPTsCXpOcG+v/7d+1smBPKMvVXLtilTAD8406HsSIXUDVM3ysgcYcIlVaXsnef
         5fRA==
X-Forwarded-Encrypted: i=1; AJvYcCVao+KTmROp99vGHggBPK5U1eKlzfmwELL1chmMIVhoC1PRz8+ExrwQlWxCq6fyGVqb2A3ydtGn@vger.kernel.org, AJvYcCVeeteHp1bH0gaXT9HD17bCGhEkRueBeshp994VwEAaayXDihfHyTf9nRknb5aNd+6RLwKvuxo9PEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrzBgvjRYqtMplyaMgdOKBf5QibKM4XlJpgyiZds5B374eaRL
	sNaG5TUTRycSDVlbZ3hhx3ZSS6GFOLdcixXCbuKkJSs+uSwEHm2N3BKb0a5CaoWsjSQpIIdqqR5
	WRCueO+VUP7tB4spRBTpfRLhLqhaJJw==
X-Google-Smtp-Source: AGHT+IFmnIBjLw07PLoWWJfjIblQm0rk07ULgqC6n11PzzV9UFs7V5ASqZzmHDR6hcX2gqoMS+ki9gJeWslsSKW91vY=
X-Received: by 2002:a2e:be84:0:b0:2fb:4abb:7001 with SMTP id
 38308e7fff4ca-2fb82e8ece5mr15773711fa.2.1729267288285; Fri, 18 Oct 2024
 09:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017222459.79104-1-okorniev@redhat.com> <833fbf2425229ad351e660e7840c67009a3a0ac0.camel@kernel.org>
In-Reply-To: <833fbf2425229ad351e660e7840c67009a3a0ac0.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 18 Oct 2024 12:01:16 -0400
Message-ID: <CAN-5tyFkt_-KZwCusRO6D2C7TVdG6z71V4hCeD=EEM-wYbdMWg@mail.gmail.com>
Subject: Re: [PATCH v2] nfsd: fix race between laundromat and free_stateid
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 9:44=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2024-10-17 at 18:24 -0400, Olga Kornievskaia wrote:
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
> > This patch proposes a fix that's based on adding 2 new additional
> > stid's sc_status values that help coordinate between the laundromat
> > and other operations (nfsd4_free_stateid() and nfsd4_delegreturn()).
> >
> > First to make sure, that once the stid is marked revoked, it is not
> > removed by the nfsd4_free_stateid(), the laundromat take a reference
> > on the stateid. Then, coordinating whether the stid has been put
> > on the cl_revoked list or we are processing FREE_STATEID and need to
> > make sure to remove it from the list, each check that state and act
> > accordingly. If laundromat has added to the cl_revoke list before
> > the arrival of FREE_STATEID, then nfsd4_free_stateid() knows to remove
> > it from the list. If nfsd4_free_stateid() finds that operations arrived
> > before laundromat has placed it on cl_revoke list, it marks the state
> > freed and then laundromat will no longer add it to the list.
> >
> > Also, for nfsd4_delegreturn() when looking for the specified stid,
> > we need to access stid that are marked removed or freeable, it means
> > the laundromat has started processing it but hasn't finished and this
> > delegreturn needs to return nfserr_deleg_revoked and not
> > nfserr_bad_stateid. The latter will not trigger a FREE_STATEID and the
> > lack of it will leave this stid on the cl_revoked list indefinitely.
> >
> > Fixes: 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is
> > protected by clp->cl_lock")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 15 ++++++++++++---
> >  fs/nfsd/state.h     |  2 ++
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index ac1859c7cc9d..cb989802e896 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1370,10 +1370,16 @@ static void revoke_delegation(struct nfs4_deleg=
ation *dp)
> >       if (dp->dl_stid.sc_status &
> >           (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)) {
>
> Now that I look, we'll never call revoke_delegation() without one of
> these bits set. Maybe we should turn that if statement into a
> WARN_ON_ONCE check, and then just do the rest unconditionally.
>
> >               spin_lock(&clp->cl_lock);
> > -             refcount_inc(&dp->dl_stid.sc_count);
>
> If you're going to remove this, then I think you also need to add a
> recount_inc() to nfs4_revoke_states() before the call to
> revoke_delegation().
>
> > +             if (dp->dl_stid.sc_status & SC_STATUS_FREED) {
> > +                     list_del_init(&dp->dl_recall_lru);
> > +                     spin_unlock(&clp->cl_lock);
> > +                     goto out;
> > +             }
>
> The FREEABLE/FREED dance is pretty complex. It'd be nice to have some
> documentation around it. Maybe consider adding a kerneldoc header over
> this function that explains that, and the requirement that you need to
> take an extra reference to the stateid before calling this.
>
> >               list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> > +             dp->dl_stid.sc_status |=3D SC_STATUS_FREEABLE;
> >               spin_unlock(&clp->cl_lock);
> >       }
> > +out:
>
> I'd just move the spin_unlock to here and get rid of the two above.
>
> >       destroy_unhashed_deleg(dp);
> >  }
>
>
> >
> > @@ -6545,6 +6551,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> >               dp =3D list_entry (pos, struct nfs4_delegation, dl_recall=
_lru);
> >               if (!state_expired(&lt, dp->dl_time))
> >                       break;
> > +             refcount_inc(&dp->dl_stid.sc_count);
> >               unhash_delegation_locked(dp, SC_STATUS_REVOKED);
> >               list_add(&dp->dl_recall_lru, &reaplist);
> >       }
> > @@ -7156,7 +7163,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> >               if (s->sc_status & SC_STATUS_REVOKED) {
> >                       spin_unlock(&s->sc_lock);
> >                       dp =3D delegstateid(s);
> > -                     list_del_init(&dp->dl_recall_lru);
> > +                     if (s->sc_status & SC_STATUS_FREEABLE)
> > +                             list_del_init(&dp->dl_recall_lru);
> > +                     s->sc_status |=3D SC_STATUS_FREED;
> >                       spin_unlock(&cl->cl_lock);
> >                       nfs4_put_stid(s);
> >                       ret =3D nfs_ok;
> > @@ -7486,7 +7495,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> >       if ((status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)=
))
> >               return status;
> >
> > -     status =3D nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0=
, &s, nn);
> > +     status =3D nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, S=
C_STATUS_REVOKED|SC_STATUS_FREEABLE, &s, nn);
> >       if (status)
> >               goto out;
> >       dp =3D delegstateid(s);
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 79c743c01a47..35b3564c065f 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -114,6 +114,8 @@ struct nfs4_stid {
> >  /* For a deleg stateid kept around only to process free_stateid's: */
> >  #define SC_STATUS_REVOKED    BIT(1)
> >  #define SC_STATUS_ADMIN_REVOKED      BIT(2)
> > +#define SC_STATUS_FREEABLE   BIT(3)
> > +#define SC_STATUS_FREED              BIT(4)
> >       unsigned short          sc_status;
> >
> >       struct list_head        sc_cp_list;
>
> Other than the problems above, this looks reasonable. Nice work!

Thank you for the comments Jeff! I'll address them all in v3.

> --
> Jeff Layton <jlayton@kernel.org>
>


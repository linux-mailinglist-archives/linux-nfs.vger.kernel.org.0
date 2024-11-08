Return-Path: <linux-nfs+bounces-7750-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4939C2053
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 16:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A81285506
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C956205145;
	Fri,  8 Nov 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="kBbGVy68"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5F206E7D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079692; cv=none; b=G18dYQk9IvBVmLoBSoPlUkWSuj31RJPBaSZ3rBdjeskTFzPLjCqtObyOAAzmm2YSu44O4HhJfZZ46mFO3IfuTJsIp9uhseLgFGioLI6MwSfSbiN59D7EdqVnIpvrpYieTqrdbL+9jNlQBIk8ZOaHXmkIMhV90No1zSBnWHEp/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079692; c=relaxed/simple;
	bh=Fo4GnBXj1I8MBym8FEQUIo6ssABU2t6am7yThkGeG8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gz27wJYTdjwa5FmsUpetY3YKjmuiK4n4LAWgGGOTThwoh9nNefPTpd2BK4cyPZa9lg6MoyprXKFH/KR1/ULUQKx+63XS3Ko+pO/O9U5FAutfBj7f7iLnhnaTi7p3+BWQW/wWLYMW0VDIUrg9jUcuRD/5o/BZHr3ye8E5AMLrSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=kBbGVy68; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f58c68c5so4104622e87.3
        for <linux-nfs@vger.kernel.org>; Fri, 08 Nov 2024 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1731079689; x=1731684489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oPGNPBYTR46g0m2knzptg9RK1LWV4fhxcplIjm3fsk=;
        b=kBbGVy684uG06DmOo2SUqoeZzltsyos4Kj0DUF/29z1rqm8Y5wbOm6OHVfMJemr0gP
         NiBWSkVHpXLuGqshci9EzZgx7aqZdatj+jwgtX9kNj3Jz0KsstSiFjhW5e7z/AABTEG7
         TjoDo1Bsbh6fOxZYinFrvjMNXiAcRAa8jZVzJYuviFXFl4QdUou5nnBsn7CEN3N2jvWw
         bB0uUuq3uR+QVYZjQjntPzJ5S4Pj0YZyvhfyWR1U5K8kqYIPWmV7N3sV7ImVBK9w8BE+
         K21UzysF6gsCU8Wb5Hg7zwlN29caKIoxbvupQ5wp18a/Up+zTsFd5h1jBWpWokcOjmgy
         PGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079689; x=1731684489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oPGNPBYTR46g0m2knzptg9RK1LWV4fhxcplIjm3fsk=;
        b=KXmQ/hzUTqLuCU0A3Nmsvz7tw17Hx7wv6QNhQYnUOzkTHOeKpJI78zRuB0SQ3aNrO3
         WWHh2nbAXRcLJljqLBdbr6WNAJAV7rF6kF08ohPHK0boEUHJJeyZLjVPUtxpCZC73Wfn
         zePMrPb6StVRn5uZ5F8wSEuqw16mmrhJPXZEhVPQ1RNaJuBex0UTXg5ZWQthHdEnUDEY
         +JhOtfYhVJPSej18TB4gfaaE0dvHmO7l8nCl7obDUZmES46u5Wqt0fLXs65x9B85NE67
         RB9lysCOnwHLmJSNQjdfIyWyUjQr/ATX0vJ1KtpILJW1hrUPPyvEIqiorGViJ4E90m51
         ae5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtS1q/GOTizZj+bxAyQQg8S7bRzQVhEYz+SVwhHW2zFImz9A05FHfHd4p41Am7llV6omug10kkkdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BZGrE0WvKNQWYrXvtr1TWuOAEqkvOX2zp1lqo5KbDn84wM6E
	1CGRVlsdzr2AqsOD+ZOEr5mYuqr7OZ/4Z2Yv0iBUvqwsJf5a6G7dtfGU5YNo71KhxDL9CFWvvOp
	2AcrnezHbjkokHT1SHKPTzYfzeHo=
X-Google-Smtp-Source: AGHT+IEMOgClRZwuFOfzU6/6zt3nPktrlNmWpimQBpog1200kJb6/sR434EphylqtJmMvrob4fvOkgBSET46w+CkIDs=
X-Received: by 2002:a2e:bc87:0:b0:2fb:61c0:137 with SMTP id
 38308e7fff4ca-2ff202c1281mr25914851fa.40.1731079688363; Fri, 08 Nov 2024
 07:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024102832-murky-pasty-feca@gregkh> <25BB7B46-50A1-45BC-A10D-70CAB6F2F500@oracle.com>
In-Reply-To: <25BB7B46-50A1-45BC-A10D-70CAB6F2F500@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 8 Nov 2024 10:27:56 -0500
Message-ID: <CAN-5tyG5zwdo8O8ewoPidAZp_FJCpQz=KRPsgsZYa+U5bMkm8g@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] nfsd: fix race between laundromat and
 free_stateid" failed to apply to 6.6-stable tree
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:35=E2=80=AFAM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
> Hi-
>
> I recall we wanted to see this fix in all LTS kernels,
> so this commit was marked "Cc: stable". Unfortunately
> it applied cleanly only to linux-6.11.y.
>
> What is the plan for getting this fix into LTS kernels?

I'm not sure what are the options here? Is it acceptable to write the
same functionality patch (but different) that would apply to earlier
versions?

Just as a side note, it was only reported on the 6.11 kernel.
Personally, I was only able to reproduce it on 6.10 (not before).

> > Begin forwarded message:
> >
> > From: <gregkh@linuxfoundation.org>
> > Subject: FAILED: patch "[PATCH] nfsd: fix race between laundromat and f=
ree_stateid" failed to apply to 6.6-stable tree
> > Date: October 27, 2024 at 8:41:32=E2=80=AFPM EDT
> > To: okorniev@redhat.com, chuck.lever@oracle.com
> > Cc: <stable@vger.kernel.org>
> >
> >
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202410283=
2-murky-pasty-feca@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> >
> > Possible dependencies:
> >
> >
> >
> > thanks,
> >
> > greg k-h
> >
> > ------------------ original commit in Linus's tree ------------------
> >
> > From 8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a Mon Sep 17 00:00:00 2001
> > From: Olga Kornievskaia <okorniev@redhat.com>
> > Date: Fri, 18 Oct 2024 15:24:58 -0400
> > Subject: [PATCH] nfsd: fix race between laundromat and free_stateid
> >
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
> > This patch proposes a fixed that's based on adding 2 new additional
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
> > Fixes: 2d4a532d385f ("nfsd: ensure that clp->cl_revoked list is protect=
ed by clp->cl_lock")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 56b261608af4..d1a2c677be7e 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1359,21 +1359,47 @@ static void destroy_delegation(struct nfs4_dele=
gation *dp)
> > destroy_unhashed_deleg(dp);
> > }
> >
> > +/**
> > + * revoke_delegation - perform nfs4 delegation structure cleanup
> > + * @dp: pointer to the delegation
> > + *
> > + * This function assumes that it's called either from the administrati=
ve
> > + * interface (nfsd4_revoke_states()) that's revoking a specific delega=
tion
> > + * stateid or it's called from a laundromat thread (nfsd4_landromat())=
 that
> > + * determined that this specific state has expired and needs to be rev=
oked
> > + * (both mark state with the appropriate stid sc_status mode). It is a=
lso
> > + * assumed that a reference was taken on the @dp state.
> > + *
> > + * If this function finds that the @dp state is SC_STATUS_FREED it mea=
ns
> > + * that a FREE_STATEID operation for this stateid has been processed a=
nd
> > + * we can proceed to removing it from recalled list. However, if @dp s=
tate
> > + * isn't marked SC_STATUS_FREED, it means we need place it on the cl_r=
evoked
> > + * list and wait for the FREE_STATEID to arrive from the client. At th=
e same
> > + * time, we need to mark it as SC_STATUS_FREEABLE to indicate to the
> > + * nfsd4_free_stateid() function that this stateid has already been ad=
ded
> > + * to the cl_revoked list and that nfsd4_free_stateid() is now respons=
ible
> > + * for removing it from the list. Inspection of where the delegation s=
tate
> > + * in the revocation process is protected by the clp->cl_lock.
> > + */
> > static void revoke_delegation(struct nfs4_delegation *dp)
> > {
> > struct nfs4_client *clp =3D dp->dl_stid.sc_client;
> >
> > WARN_ON(!list_empty(&dp->dl_recall_lru));
> > + WARN_ON_ONCE(!(dp->dl_stid.sc_status &
> > +     (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)));
> >
> > trace_nfsd_stid_revoke(&dp->dl_stid);
> >
> > - if (dp->dl_stid.sc_status &
> > -    (SC_STATUS_REVOKED | SC_STATUS_ADMIN_REVOKED)) {
> > - spin_lock(&clp->cl_lock);
> > - refcount_inc(&dp->dl_stid.sc_count);
> > - list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> > - spin_unlock(&clp->cl_lock);
> > + spin_lock(&clp->cl_lock);
> > + if (dp->dl_stid.sc_status & SC_STATUS_FREED) {
> > + list_del_init(&dp->dl_recall_lru);
> > + goto out;
> > }
> > + list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> > + dp->dl_stid.sc_status |=3D SC_STATUS_FREEABLE;
> > +out:
> > + spin_unlock(&clp->cl_lock);
> > destroy_unhashed_deleg(dp);
> > }
> >
> > @@ -1780,6 +1806,7 @@ void nfsd4_revoke_states(struct net *net, struct =
super_block *sb)
> > mutex_unlock(&stp->st_mutex);
> > break;
> > case SC_TYPE_DELEG:
> > + refcount_inc(&stid->sc_count);
> > dp =3D delegstateid(stid);
> > spin_lock(&state_lock);
> > if (!unhash_delegation_locked(
> > @@ -6545,6 +6572,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> > dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > if (!state_expired(&lt, dp->dl_time))
> > break;
> > + refcount_inc(&dp->dl_stid.sc_count);
> > unhash_delegation_locked(dp, SC_STATUS_REVOKED);
> > list_add(&dp->dl_recall_lru, &reaplist);
> > }
> > @@ -7157,7 +7185,9 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> > s->sc_status |=3D SC_STATUS_CLOSED;
> > spin_unlock(&s->sc_lock);
> > dp =3D delegstateid(s);
> > - list_del_init(&dp->dl_recall_lru);
> > + if (s->sc_status & SC_STATUS_FREEABLE)
> > + list_del_init(&dp->dl_recall_lru);
> > + s->sc_status |=3D SC_STATUS_FREED;
> > spin_unlock(&cl->cl_lock);
> > nfs4_put_stid(s);
> > ret =3D nfs_ok;
> > @@ -7487,7 +7517,9 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> > if ((status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
> > return status;
> >
> > - status =3D nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, 0, &s=
, nn);
> > + status =3D nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG,
> > +      SC_STATUS_REVOKED | SC_STATUS_FREEABLE,
> > +      &s, nn);
> > if (status)
> > goto out;
> > dp =3D delegstateid(s);
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 79c743c01a47..35b3564c065f 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -114,6 +114,8 @@ struct nfs4_stid {
> > /* For a deleg stateid kept around only to process free_stateid's: */
> > #define SC_STATUS_REVOKED BIT(1)
> > #define SC_STATUS_ADMIN_REVOKED BIT(2)
> > +#define SC_STATUS_FREEABLE BIT(3)
> > +#define SC_STATUS_FREED BIT(4)
> > unsigned short sc_status;
> >
> > struct list_head sc_cp_list;
> >
>
> --
> Chuck Lever
>
>


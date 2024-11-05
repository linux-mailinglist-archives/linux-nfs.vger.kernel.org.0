Return-Path: <linux-nfs+bounces-7680-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001B9BD9E0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 00:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F39C280EEA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 23:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACA149C53;
	Tue,  5 Nov 2024 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="LGYgun6l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794D1D1748
	for <linux-nfs@vger.kernel.org>; Tue,  5 Nov 2024 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730850465; cv=none; b=GHh/778iQmyL86/VvMl+bDzFaAb/c76rx8Rnp+c2Vjisd9FLGetY5Vufs7AefexBvV2Gwo82vLHmYMyrGiCe2fpHrAkG6rKSilXLccgQFm7LKSUitjANZ3um+fFXdvhK4f+05bRf9hEHdbh4uecgSdSUt1aeHSbiD0wpDjODkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730850465; c=relaxed/simple;
	bh=ipEHxIf0KGbqpupSkcxl5THWHzbZLAXv3hYqAg9/fKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H39TWiCwZgYaGuy9IKnJWcWvHrqWrVkA7jpPiuUBvsObvhhJXLeZZxTmVmPF2kyZuP5ZXVbirQsRLRJAE1s+/u2nCGFjoN1pyERPb23W0VhNlASF17LVR3UjDH6dfpU5SF4fl3p88R++yC3QYJoKE+Mo++icdJtx4UVXXCkLbZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=LGYgun6l; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb561f273eso48633641fa.2
        for <linux-nfs@vger.kernel.org>; Tue, 05 Nov 2024 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1730850461; x=1731455261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iv84x5tVWCBQFO5uiddCswZzNhGWGga42jMqiBy5IdQ=;
        b=LGYgun6lk2U41nGOcYj7wQJA9L5Pb98v2y75kwHSyyThkZ2rbfJV6pjJ1Cvw6Amwl8
         frzdiMSqqwgE3nIFmkkosm1yhBv9luK0zeGt3Y39j5wBj4P39NgF3Cg67Gf9sPCrF6sr
         vTMcc78RSTBMM8cRzN5fqFSzHWLCBO5MblrNNnQVnPN3oRME5Zch8ce2q/+WAbv+Vwdr
         KwUJf0QMh1GTOoE5eXAUhudnsU6NfUE9hEuKN6Vo0ArkUgFo0AQtH8yPhOILTJAxmZMd
         dcU+GfzDabTcrb+qNXVVSaYwmVSSvaTxE+ZkxExKXlk0WSLS7fA8QzQ3eXav1y3kIkMY
         5qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730850461; x=1731455261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iv84x5tVWCBQFO5uiddCswZzNhGWGga42jMqiBy5IdQ=;
        b=bI3Au0Vtscpt3uBTyxmVqDcrwdHZeG5cnaRQXUUZRjLRucDrE/njNYISY5G2GIrp0n
         KJgVyZIeOMMBF2IKFuwbV71XpmxTlidnyySHN4CdxP/F3ggwrHWdkIXbRJOrTDIGiItL
         swRV1tQHns+raXD+5eSbYj5/v0Ylz8vJ6ygXg+G9ONpAAhm8K1TO17n0QlaAItSygU1K
         +4ix7FhWzEroVwm1RSdlgb/CUr2PJUqHAaDrPNjXHVqdKhsV5rGF8ncyrbBoSFJanvYn
         9KQuAgU9oTI/naDo2/U5lDjCrsJC+wYUQgg8oG1Dfdfl62BVq8L7W5OSV9HRrmVvF1cT
         yj/w==
X-Forwarded-Encrypted: i=1; AJvYcCWnMbCGROdIZik59zfyyQsNKjT7N0dBHMHrRa88WGPf+OAod/bv/H9E2GXzSocb5kIeFTUs2uq02Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQT4U4ZT2kJE9tlhf8xI9IU7FksdQTueAd2tJx91yFPcWXMkq
	7bX5/Qaa9CZABr+zrOzAfjHcrDgL1HMCvjIwDGeJndnZFwLlTpsZO5Nk8IfswXY4qTJaLW1s1e/
	Sz1prRfi0pPrEfWPPESi5FnipPMk=
X-Google-Smtp-Source: AGHT+IGD+e1j/BKrmEPpS815fXYJXmEvx37zwub6UBPv6sLigTxFBOAPhJtPH4zhP7NkA0B3jXxOfPtFNF/CYZUj9vg=
X-Received: by 2002:a05:651c:502:b0:2fb:5c20:43e0 with SMTP id
 38308e7fff4ca-2fd05924b47mr145770851fa.15.1730850460529; Tue, 05 Nov 2024
 15:47:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZyovsQBNlmoSLWED@tissot.1015granger.net> <173084080089.1734440.10665206263775584488@noble.neil.brown.name>
In-Reply-To: <173084080089.1734440.10665206263775584488@noble.neil.brown.name>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 5 Nov 2024 18:47:29 -0500
Message-ID: <CAN-5tyF+FbsxSDEb79FQucM7fRDqw1wa7iegx9t=RvSLgr2nHQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 4:06=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 06 Nov 2024, Chuck Lever wrote:
> > On Tue, Nov 05, 2024 at 11:32:48AM +1100, NeilBrown wrote:
> > > On Tue, 05 Nov 2024, Chuck Lever wrote:
> > > > On Tue, Nov 05, 2024 at 07:30:03AM +1100, NeilBrown wrote:
> > > > > On Tue, 05 Nov 2024, Chuck Lever wrote:
> > > > > > On Mon, Nov 04, 2024 at 03:47:42PM +1100, NeilBrown wrote:
> > > > > > >
> > > > > > > An NFSv4.2 COPY request can explicitly request a synchronous =
copy.  If
> > > > > > > that is not requested then the server is free to perform the =
copy
> > > > > > > synchronously or asynchronously.
> > > > > > >
> > > > > > > In the Linux implementation an async copy requires more resou=
rces than a
> > > > > > > sync copy.  If nfsd cannot allocate these resources, the best=
 response
> > > > > > > is to simply perform the copy (or the first 4MB of it) synchr=
onously.
> > > > > > >
> > > > > > > This choice may be debatable if the unavailable resource was =
due to
> > > > > > > memory allocation failure - when memalloc fails it might be b=
est to
> > > > > > > simply give up as the server is clearly under load.  However =
in the case
> > > > > > > that policy prevents another kthread being created there is n=
o benefit
> > > > > > > and much cost is failing with NFS4ERR_DELAY.  In that case it=
 seems
> > > > > > > reasonable to avoid that error in all circumstances.
> > > > > > >
> > > > > > > So change the out_err case to retry as a sync copy.
> > > > > > >
> > > > > > > Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent as=
ync COPY operations")
> > > > > >
> > > > > > Hi Neil,
> > > > > >
> > > > > > Why is a Fixes: tag necessary?
> > > > > >
> > > > > > And why that commit? async copies can fail due to lack of resou=
rces
> > > > > > on kernels that don't have aadc3bbea163, AFAICT.
> > > > >
> > > > > I had hoped my commit message would have explained that, though I=
 accept
> > > > > it was not as explicit as it could be.
> > > >
> > > > The problem might be that you and I have different understandings o=
f
> > > > what exactly aadc3bbea163 does.
> > >
> > > It might be.
> > > My understanding is that it limits the number of concurrent async
> > > COPY requests to ->sp_nrthreads and once that limit in reached
> > > any further COPY requests that don't explicitly request "synchronous"
> > > are refused with NFS4ERR_DELAY.
> > >
> > > > > kmalloc(GFP_KERNEL) allocation failures aren't interesting.  They=
 never
> > > > > happen for smallish sizes, and if they do then the server is so b=
orked
> > > > > that it hardly matter what we do.
> > > > >
> > > > > The fixed commit introduces a new failure mode that COULD easily =
be hit
> > > > > in practice.  It causes the N+1st COPY to wait indefinitely until=
 at
> > > > > least one other copy completes which, as you observed in that com=
mit,
> > > > > could "run for a long time".  I don't think that behaviour is nec=
essary
> > > > > or appropriate.
> > > >
> > > > The waiting happens on the client. An async COPY operation always
> > > > completes quickly on the server, in this case with NFS4ERR_DELAY. I=
t
> > > > does not tie up an nfsd thread.
> > >
> > > Agreed that it doesn't tie up an nfsd thread.  It does tie up a separ=
ate
> > > kthread for which there is a limit matching the number of nfsd thread=
s
> > > (in the pool).
> > >
> > > Agreed that the waiting happens on the client, but why should there b=
e
> > > any waiting at all?  The client doesn't know what it is waiting for, =
so
> > > will typically wait a few seconds.  In that time many megabytes of sy=
nc
> > > COPY could have been processed.
> >
> > The Linux NFS client's usual delay is, IIRC, 100 msec with
> > exponential backoff.
>
> Yep, up to 15seconds.
>
> >
> > It's possible that the number of async copies is large because they
> > are running on a slow export. Adding more copy work is going to make
> > the situation worse -- and by handling the work with a synchronous
> > COPY, it will tie up threads that should be available for other
> > work.
>
> Should be available for "work" yes, but why "other work"?  Is COPY work
> not as important as READ or WRITE or GETATTR work?
> READ/WRITE are limited to 1MB, sync-COPY to 4MB so a small difference
> that, but it doesn't seem substantial.
>
> >
> > The feedback loop here should result in reducing server workload,
> > not increasing it.
>
> I agree with not increasing it.  I don't see the rational for reducing
> workload, only for limiting it.
>
> >
> >
> > > > By the way, there are two fixes in this area that now appear in
> > > > v6.12-rc6 that you should check out.
> > >
> > > I'll try to schedule time to have a look - thanks.
> > >
> > > > > Changing the handling for kmalloc failure was just an irrelevant
> > > > > side-effect for changing the behaviour when then number of COPY r=
equests
> > > > > exceeded the number of configured threads.
> > > >
> > > > aadc3bbea163 checks the number of concurrent /async/ COPY requests,
> > > > which do not tie up nfsd threads, and thus are not limited by the
> > > > svc_thread count, as synchronous COPY operations are by definition.
> > >
> > > They are PRECISELY limited by the svc_thread count.  ->sp_nrthreads.
> >
> > I was describing the situation /before/ aadc3bbea163 , when there
> > was no limit at all.
> >
> > Note that is an arbitrary limit. We could pick something else if
> > this limit interferes with the dynamic thread count changes.
> >
> >
> > > My current thinking is that we should not start extra threads for
> > > handling async copies.  We should create a queue of pending copies an=
d
> > > any nfsd thread can dequeue a copy and process 4MB each time through
> > > "The main request loop" just like it calls nfsd_file_net_dispose() to=
 do
> > > a little bit of work.
> >
> > Having nfsd threads handle this workload again invites a DoS vector.
>
> Any more so that having nfsd thread handling a WRITE workload?

Isn't a difference between a COPY and a WRITE the fact that the server
has the ability to restrict the TCP window of the client sending the
bytes. And for simplicity's sake, if we assume client/server has a
single TCP stream when the window size is limited then other WRITEs
are also prevented from sending more data. But a COPY operation
doesn't require much to be sent and preventing the client from sending
another COPY can't be achieved thru TCP window size.

> > The 4MB chunk limit is there precisely to prevent synchronous COPY
> > operations from tying up nfsd threads for too long. On a slow export,
> > this is still not going to work, so I'd rather see a timer for this
> > protection; say, 30ms, rather than a byte count. If more than 4MB
> > can be handled quickly, that will be good for throughput.
>
> That sounds like a good goal.  Ideally we would need a way to negotiate
> a window with write-back throttling so that we don't bother reading
> until we know that writing to the page-cache won't block.  Certainly
> worth exploring.
>
> >
> > Note that we still want to limit the number of background copy
> > operations going on. I don't want a mechanism where a client can
> > start an unbounded amount of work on the server.
>
> This isn't obvious to me.  The server makes no promise concerning the
> throughput it will provide.  Having a list of COPY requests that add up
> to many terabytes isn't intrinsically a problem.  Having millions of
> COPY requests in the list *might* be a little bit of a burden.  Using
> __GFP_NORETRY might help put a natural limit on that.
>
> >
> >
> > > > > This came up because CVE-2024-49974 was created so I had to do so=
mething
> > > > > about the theoretical DoS vector in SLE kernels.  I didn't like t=
he
> > > > > patch so I backported
> > > > >
> > > > > Commit 8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be=
 synchronous")

I'm doing the same for RHEL. But the fact that CVE was created seems
like a flaw of the CVE creation process in this case. It should have
never been made a CVE.

> > > > >
> > > > > instead (and wondered why it hadn't gone to stable).
> > > >
> > > > I was conservative about requesting a backport here. However, if a
> > > > CVE has been filed, and if there is no automation behind that
> > > > process, you can explicitly request aadc3bbea163 be backported.
> > > >
> > > > The problem, to me, was less about server resource depletion and
> > > > more about client hangs.
> > >
> > > And yet the patch that dealt with the less important server resource
> > > depletion was marked for stable, and the patch that dealt with client
> > > hangs wasn't??
> > >
> > > The CVE was for that less important patch, probably because it contai=
ned
> > > the magic word "DoS".
> >
> > Quite likely. I wasn't consulted before the CVE was opened, nor was
> > I notified that it had been created.
> >
> > Note that distributions are encouraged to evaluate whether a CVE is
> > serious enough to address, rather than simply backporting the fixes
> > automatically. But I know some customers want every CVE handled, so
> > that is sometimes difficult.
>
> Yes, it needs to be handled.  Declaring it invalid is certainly an
> option for handling it.  I didn't quite feel I could justify that in
> this case.
>
> >
> >
> > > I think 8d915bbf3926 should go to stable but I would like to understa=
nd
> > > why you felt the need to be conservative.
> >
> > First, I'm told that LTS generally avoids taking backports that
> > overtly change user-visible behavior like disabling server-to-server
> > copy (which requires async COPY to work). That was the main reason
> > for my hesitance.
>
> Why does server-to-server require async COPY?
> RFC 7862 section 4.5.  Inter-Server Copy says
>   The destination server may perform the copy synchronously or
>   asynchronously.
> but I see that nfsd4_copy() returns nfs4err_notsupp if the inter-server
> copy_is_sync(), but it isn't immediately obvious to me why.  The patch
> which landed this functionality doesn't explain the restriction.

The choice (my choice) for not implementing a synchronous inter-server
copy was from my understanding that such operation would be taking too
much time and tie up a knfsd thread.

> I guess that with multiple 4MB sync COPY requests the server would need
> to repeatedly mount and unmount the source server which could be
> unnecessary work - or would need to cache the mount and know when to
> unmount it....

The implementation caches the (source server) mount for a period of
time. But needing to issue multiple COPY can eventually impact
performance.

> On the other hand, changing the user-visible behaviour of the client
> unexpected hanging waiting for a server-side copy completion
> notification that it will never get seems like a user-visible change
> that would be desirable.

> I'm starting to see why this is awkward.
>
> >
> > But more importantly, the problem with the automatic backport
> > mechanism is that marked patches are taken /immediately/ into
> > stable. They don't get the kind of soak time that a normally-merged
> > unmarked patch gets. The only way to ensure they get any real-world
> > test experience at all is to not mark them, and then come back to
> > them later and explicitly request a backport.
> >
> > And, generally, we want to know that a patch destined for LTS
> > kernels has actually been applied to and tested on LTS first.
> > Automatically backported patches don't get that verification at all.
>
> I thought it was possible to mark patches to tell the stable team
> exactly what you want.  Greg certainly seems eager to give maintainers as
> much control as they ask for - without requiring them to do anything
> they don't want to do.  If you have a clear idea of what you want, it
> might be good to spell that out and ask how to achieve it.
>
> >
> > My overall preference is that Fixed: patches should be ignored by
> > the automation, and that we have a designated NFSD LTS maintainer
> > who will test patches on each LTS kernel and request their backport.
> > I haven't found anyone to do that work, so we are limping along with
> > the current situation. I recognize, however, that this needs to
> > improve somehow with only the maintainer resources we have.
>
> :-)
>
> Thanks,
> NeilBrown
>
> >
> >
> > > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > > ---
> > > > > > >  fs/nfsd/nfs4proc.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > > index fea171ffed62..06e0d9153ca9 100644
> > > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > > @@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstate,
> > > > > > >             wake_up_process(async_copy->copy_task);
> > > > > > >             status =3D nfs_ok;
> > > > > > >     } else {
> > > > > > > +   retry_sync:
> > > > > > >             status =3D nfsd4_do_copy(copy, copy->nf_src->nf_f=
ile,
> > > > > > >                                    copy->nf_dst->nf_file, tru=
e);
> > > > > > >     }
> > > > > > > @@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstate,
> > > > > > >     }
> > > > > > >     if (async_copy)
> > > > > > >             cleanup_async_copy(async_copy);
> > > > > > > -   status =3D nfserr_jukebox;
> > > > > > > -   goto out;
> > > > > > > +   goto retry_sync;
> > > > > > >  }
> > > > > > >
> > > > > > >  static struct nfsd4_copy *
> > > > > > >
> > > > > > > base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
> > > > > > > --
> > > > > > > 2.47.0
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > Chuck Lever
> > > > > >
> > > > >
> > > >
> > > > --
> > > > Chuck Lever
> > > >
> > >
> >
> > --
> > Chuck Lever
> >
>
>


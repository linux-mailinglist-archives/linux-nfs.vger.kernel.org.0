Return-Path: <linux-nfs+bounces-1471-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4098B83DD9A
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65ACD1C214F6
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21151D522;
	Fri, 26 Jan 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoKXx3fF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997111D524
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283356; cv=none; b=Nh87PzndTkxzLX624xYyxMqySSO+cZmePKNL2WykUZj1q990tFby2oJJ4O3fCCLLVOBQfuhFL5MTowSkHWLiOoQFjsw6rCpoo2V9UXL0A6VKQ6RDEyJ3UDlFM3qR/OOPYQV0U7EVwtaMKyJeZA8nvQJujA5+nuoOK8sSbXqYti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283356; c=relaxed/simple;
	bh=8VQ9NJm9SLR48nn97Asau4POGxrp5D4I4B35DBbHqYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5yeJR0ecwsTsnF8R9i4LFBTUUN5pK1041arlwqWdiBby33TCaiQzazOq5YZ2+3om+Ju7BojAckmYmTN3AwWtfexKqHQpk68oMGLQYlwMX+bwv3TwmH6faf3JENyEwE+V5tAUQ13njDtMPG/MsniSs91QOGhsUsf3QK7EP1NBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoKXx3fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945A4C433F1;
	Fri, 26 Jan 2024 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706283356;
	bh=8VQ9NJm9SLR48nn97Asau4POGxrp5D4I4B35DBbHqYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BoKXx3fFCyOTLiYJCkpXaf3saWdX17DWcG1GEoF0m7yHfRXi7/EMEg4Pr6WHEcjlb
	 uELjgaoHxHUyJbEBpBFIGtP6KW6oP19dVoVFI2GXLcd2LzxMT0JdNp6B3Fcv0mgK3B
	 Tuo25mSrOvT+mkmmB3xvTirhMj44+j+75dteXnC3avqleUr1htvAdURZIdSJw+t4Hs
	 nqYRDRz+CFrt+sTeVtzlN94EGDS8Je3rnSy3kI3jOMBQR1ait5elv8Q4qcpOwkaTjM
	 mTwPP/9+k2pGKBuXE12sRg7eP5r50hovlibm51IFmxdM63mgGjYXBgcL4GpDDfEc/X
	 in36fyqJ+3DlA==
Message-ID: <90bb9cf7608084ca2f321fd8112d758624816766.camel@kernel.org>
Subject: Re: [PATCH v2 10/13] nfsd: move th_cnt into nfsd_net
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Linux NFS Mailing List
	 <linux-nfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Date: Fri, 26 Jan 2024 10:35:54 -0500
In-Reply-To: <94064421-2EBA-45E7-8ECD-5BBCA6BB081C@oracle.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
	 <0fa7bf5b5bbc863180e50363435b5a56c43dc5e3.1706212208.git.josef@toxicpanda.com>
	 <ZbLMJxLWIvomQIzO@tissot.1015granger.net>
	 <20240125215618.GB1602047@perftesting>
	 <889ecfaa124883cd99e40d457562af45b5e97e7d.camel@kernel.org>
	 <1E87E98E-EA7B-4BBD-A9FA-EF4B217141E0@oracle.com>
	 <3b20db588e31be6f39415aa18b5ffb13214c759d.camel@kernel.org>
	 <52460FD0-34B8-4D07-8063-EA4BA5CB3D0B@oracle.com>
	 <c1f798d6cac7299e33b23ba54148ad985263845e.camel@kernel.org>
	 <94064421-2EBA-45E7-8ECD-5BBCA6BB081C@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 15:16 +0000, Chuck Lever III wrote:
>=20
> > On Jan 26, 2024, at 10:03=E2=80=AFAM, Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Fri, 2024-01-26 at 14:27 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jan 26, 2024, at 9:08=E2=80=AFAM, Jeff Layton <jlayton@kernel.or=
g> wrote:
> > > >=20
> > > > On Fri, 2024-01-26 at 13:48 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Jan 26, 2024, at 8:01=E2=80=AFAM, Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > > >=20
> > > > > > On Thu, 2024-01-25 at 16:56 -0500, Josef Bacik wrote:
> > > > > > > On Thu, Jan 25, 2024 at 04:01:27PM -0500, Chuck Lever wrote:
> > > > > > > > On Thu, Jan 25, 2024 at 02:53:20PM -0500, Josef Bacik wrote=
:
> > > > > > > > > This is the last global stat, move it into nfsd_net and a=
djust all the
> > > > > > > > > users to use that variant instead of the global one.
> > > > > > > >=20
> > > > > > > > Hm. I thought nfsd threads were a global resource -- they s=
ervice
> > > > > > > > all network namespaces. So, shouldn't the same thread count=
 be
> > > > > > > > surfaced to all containers? Won't they all see all of the n=
fsd
> > > > > > > > processes?
> > > > > >=20
> > > > > > Each container is going to start /proc/fs/nfsd/threads number o=
f threads
> > > > > > regardless. I hadn't actually grokked that they just get tossed=
 onto the
> > > > > > pile of threads that service requests.
> > > > > >=20
> > > > > > Is is possible for one container to start a small number of thr=
eads but
> > > > > > have its client load be such that it spills over and ends up st=
ealing
> > > > > > threads from other containers?
> > > > >=20
> > > > > I haven't seen any code that manages resources based on namespace=
,
> > > > > except in filecache.c to restrict writeback per namespace.
> > > > >=20
> > > > > My impression is that any nfsd thread can serve any namespace. I'=
m
> > > > > not sure it is currently meaningful for a particular net namespac=
e to
> > > > > "create" more threads.
> > > > >=20
> > > > > If someone would like that level of control, we could implement a
> > > > > cgroup mechanism and have one or more separate svc_pools per net
> > > > > namespace, maybe? </hand wave>
> > > > >=20
> > > >=20
> > > > AFAICT, the total number of threads on the system will be the sum o=
f the
> > > > threads started in each of the containers. They do just go into a b=
ig
> > > > pile, and whichever one wakes up will service the request, so the
> > > > threads aren't associated with the netns, per-se. The svc_rqst's ho=
wever
> > > > _are_ per-netns. So, I don't see anything that ensures that a conta=
iner
> > > > doesn't exceed the number of threads it started on its own behalf.
> > > >=20
> > > > <hand wave>
> > > > I'm not sure we'd need to tie this in to cgroups.
> > >=20
> > > Not a need, but cgroups are typically the way that such
> > > resource constraints are managed, that's all.
> > >=20
> > >=20
> > > > Now that Josef is
> > > > moving some of these key structures to be per-net, it should be fai=
rly
> > > > simple to have nfsd() just look at the th_cnt and the thread count =
in
> > > > the current namespace, and just enqueue the RPC rather than doing i=
t?
> > > > </hand wave>
> > > >=20
> > > > OTOH, maybe I'm overly concerned here.
> > > >=20
> > > >=20
> > > > >=20
> > > > > > > I don't think we want the network namespaces seeing how many =
threads exist in
> > > > > > > the entire system right?
> > > > >=20
> > > > > If someone in a non-init net namespace does a "pgrep -c nfsd" don=
't
> > > > > they see the total nfsd thread count for the host?
> > > > >=20
> > > >=20
> > > > Yes, they're kernel threads and they aren't associated with a parti=
cular
> > > > pid namespace.
> > > >=20
> > > > >=20
> > > > > > > Additionally it appears that we can have multiple threads per=
 network namespace,
> > > > > > > so it's not like this will just show 1 for each individual nn=
, it'll show
> > > > > > > however many threads have been configured for that nfsd in th=
at network
> > > > > > > namespace.
> > > > >=20
> > > > > I've never tried this, so I'm speculating. But it seems like for
> > > > > now, because all nfsd threads can serve all namespaces, they shou=
ld
> > > > > all see the global thread count stat.
> > > > >=20
> > > > > Then later we can refine it.
> > > > >=20
> > > >=20
> > > > I don't think that info is particularly useful though, and it certa=
inly
> > > > breaks expectations wrt container isolation.
> > > >=20
> > > > Look at it this way:
> > > >=20
> > > > Suppose I have access to a container and I spin up nfsd with a
> > > > particular number of threads. I now want to know "did I spin up eno=
ugh
> > > > threads?"
> > >=20
> > > It makes sense to me for a container to ask for one or more
> > > NFSD listeners. But I'm not yet clear on what it means for
> > > a container to try to alter the NFSD thread count, which is
> > > currently global.
> > >=20
> >=20
> > write_threads sets the number of nfsd threads for the svc_serv, which i=
s
> > a per-net object, so serv->sv_nrthreads is only counting the threads fo=
r
> > its namespace.
>=20
> OK. I missed the part where struct svc_serv is per-net, and
> each svc_serv has its own thread pool. Got it.
>=20
>=20
> > Each container that starts an nfsd will contribute "threads" number of
> > nfsds to the pile. When you set "threads" to a different number, the
> > total pile is grown or reduced accordingly. In fact, I'm not even sure
> > we keep a systemwide total.
> >=20
> > What _isn't_ done (unless I'm missing something) is any sort of
> > limitation on the use of those threads. So you could have a container
> > that starts one nfsd thread, but its clients can still have many more
> > RPCs in flight, up to the total number of nfsd's running on the host.
> > Limiting that might be possible, but I'm not yet convinced that it's a
> > good idea.
> >=20
> > It might be interesting to gather some metrics though. How often do the
> > number of RPCs in flight exceed the number of threads that we started i=
n
> > a namespace? Might also be good to gather a high-water mark too?
>=20
> I had a bunch of trace points queued up for this purpose,
> and all that got thrown out by Neil's recent work fixing
> up our pool thread scheduler.
>=20
> I'm not sure that queued requests are all that meaningful
> or even quantifiable. A more meaningful metric is round
> trip time measured on clients.
>=20

I wouldn't try to queue anything just yet, but knowing when a particular
container is exceeding the number of threads it started seems like a
helpful metric. That could be done in a later patch though. I wouldn't
block this work on that.
=20
>=20
> > > > By making this per-namespace as Josef suggests it should be
> > > > fairly simple to tell whether my clients are regularly overrunning =
the
> > > > threads I started. With this info as global, I have no idea what ne=
tns
> > > > the RPCs being counted are against. I can't do anything with that i=
nfo.
> > >=20
> > > That's true. I'm just not sure we need to do anything
> > > significant about it as part of this patch series.
> > >=20
> > > I'm not at all advocating leaving it like this. I agree it
> > > needs updating.
> > >=20
> > > For now, just fill in that thread count stat with the global
> > > thread count, and later when we have a better concept for
> > > what it means to "adjust the nfsd thread count from inside a
> > > container" we can come back and make it make sense.
> >=20
> > It would be good to step back and decide how we think this should work.
> > What would this look like if we were designing it today? Then we can
> > decide how to get there.
> >=20
> > Personally, I think keeping the view inside the container as isolated a=
s
> > possible is the right thing to do.
>=20
> I agree. I would like to get Josef's patches in quickly too.
>=20
> Should that metric report svc_serv::sv_nrthreads instead of
> the global thread count?
>=20

No. The sv_nrthreads is just the same value that /proc/fs/nfsd/threads
shows. The _metric_ should show the th_cnt for that particular
namespace.

It would also be nice to know what the high-water mark for th_cnt is.
IOW, if my containers clients exceeded the number of threads I've
started, then it would be helpful to know by how much.
--=20
Jeff Layton <jlayton@kernel.org>


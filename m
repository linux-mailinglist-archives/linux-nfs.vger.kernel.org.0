Return-Path: <linux-nfs+bounces-4038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C690DFE6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 01:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5DE1F248C0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8768B1849D9;
	Tue, 18 Jun 2024 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPzN5dO9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F151849C0
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753604; cv=none; b=m6QIW9DtPJs49A2yaUQgnGXkytOmIYBQ9//UHfArHLJalzL6yXd64TC3ntTeCvB265nHtwCKkoyHHCznap0ruC/o0SCeAGD4uEErWBKPx8mFjLuzzKEISFnvJfQozzvsb4ePIyhb66pjuwlJtVyvFldDC0Jy4bXXYucHkAibuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753604; c=relaxed/simple;
	bh=tzjRR+CUWe7aku/LNqNMF/HovZn3Q7Kj5aR3+HOtXuo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IKeDijZZe8ak3vwjdpi1SUu67pdoR06fb2tcsL3BpAOwVj0Hl4C/WaFz2FrTdMcHi68rPQsmYtVj+MIcG/rJhDm9QJgkeXaKQ9i0961ZB9d7D7WpSjNHYppP16dQ1euXMsHIh7FupDQRuHg39A+s7vxmQdnzc6N6JmEkVeoUnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPzN5dO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700EEC3277B;
	Tue, 18 Jun 2024 23:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718753604;
	bh=tzjRR+CUWe7aku/LNqNMF/HovZn3Q7Kj5aR3+HOtXuo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MPzN5dO9E2Of2Dtiv8H75Aqr6zg8Xeo7MHgrSqtoN1FTFfzb+99oocEXqS3oTpkLt
	 uMfuvayaJfOBgITPJYcHrMs7O9jRqx4r+CgGZvEGrwObqwcrvOQqcWcPJg4d8OEmf8
	 /0fxTjB9G7KHVrOEvTRVJydqB9Q/lZ5sTxvWQoEdiZTiF4XXrEk/YCSwpRNaa5ez0s
	 4T2Vp5zfb0TExP4kVGgG9F/irdhk6ihK1h936x0JhlU73jmTwzfTeYwTCSOeGnz2wY
	 HXuS8AHKL0t6V4Rxdx8VjrCewFOLB+wRzxpM/6MRk0NADt0IYqPoXJjrBtwEO2+NW1
	 YPmmB6uOXwTYA==
Message-ID: <666773670fb0eace2ce41c586b3d3fe99e54dda1.camel@kernel.org>
Subject: Re: knfsd performance
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>, Dave Chinner
	 <david@fromorbit.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Tue, 18 Jun 2024 19:33:22 -0400
In-Reply-To: <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>
References: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
	 <171875264902.14261.9558408320953444532@noble.neil.brown.name>
	 <E14A0A67-71C7-4ED7-BE4E-525A186B876A@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 23:26 +0000, Chuck Lever III wrote:
>=20
> > On Jun 18, 2024, at 7:17=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Wed, 19 Jun 2024, Jeff Layton wrote:
> > > On Tue, 2024-06-18 at 19:54 +0000, Chuck Lever III wrote:
> > > >=20
> > > >=20
> > > > > On Jun 18, 2024, at 3:50=E2=80=AFPM, Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > >=20
> > > > > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > > > > >=20
> > > > > >=20
> > > > > > > On Jun 18, 2024, at 3:29=E2=80=AFPM, Trond Myklebust
> > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > >=20
> > > > > > > On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > On Jun 18, 2024, at 2:32=E2=80=AFPM, Trond Myklebust
> > > > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > > >=20
> > > > > > > > > I recently back ported Neil's lwq code and sunrpc server
> > > > > > > > > changes to
> > > > > > > > > our
> > > > > > > > > 5.15.130 based kernel in the hope of improving the
> > > > > > > > > performance
> > > > > > > > > for
> > > > > > > > > our
> > > > > > > > > data servers.
> > > > > > > > >=20
> > > > > > > > > Our performance team recently ran a fio workload on a
> > > > > > > > > client
> > > > > > > > > that
> > > > > > > > > was
> > > > > > > > > doing 100% NFSv3 reads in O_DIRECT mode over an RDMA
> > > > > > > > > connection
> > > > > > > > > (infiniband) against that resulting server. I've attached
> > > > > > > > > the
> > > > > > > > > resulting
> > > > > > > > > flame graph from a perf profile run on the server side.
> > > > > > > > >=20
> > > > > > > > > Is anyone else seeing this massive contention for the spi=
n
> > > > > > > > > lock
> > > > > > > > > in
> > > > > > > > > __lwq_dequeue? As you can see, it appears to be dwarfing
> > > > > > > > > all
> > > > > > > > > the
> > > > > > > > > other
> > > > > > > > > nfsd activity on the system in question here, being
> > > > > > > > > responsible
> > > > > > > > > for
> > > > > > > > > 45%
> > > > > > > > > of all the perf hits.
> > > > > > > >=20
> > > > > > > > I haven't seen that, but I've been working on other issues.
> > > > > > > >=20
> > > > > > > > What's the nfsd thread count on your test server? Have you
> > > > > > > > seen a similar impact on 6.10 kernels ?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > 640 knfsd threads. The machine was a supermicro 2029BT-HNR wi=
th
> > > > > > > 2xIntel
> > > > > > > 6150, 384GB of memory and 6xWDC SN840.
> > > > > > >=20
> > > > > > > Unfortunately, the machine was a loaner, so cannot compare to
> > > > > > > 6.10.
> > > > > > > That's why I was asking if anyone has seen anything similar.
> > > > > >=20
> > > > > > If this system had more than one NUMA node, then using
> > > > > > svc's "numa pool" mode might have helped.
> > > > > >=20
> > > > >=20
> > > > > Interesting. I had forgotten about that setting.
> > > > >=20
> > > > > Just out of curiosity, is there any reason why we might not want =
to
> > > > > default to that mode on a NUMA enabled system?
> > > >=20
> > > > Can't think of one off hand. Maybe back in the day it was
> > > > hard to tell when you were actually /on/ a NUMA system.
> > > >=20
> > > > Copying Dave to see if he has any recollection.
> > > >=20
> > >=20
> > > It's at least partly because of the klunkiness of the old pool_thread=
s
> > > interface: You have to bring up the server first using the "threads"
> > > procfile, and then you can actually bring up threads in the various
> > > pools using pool_threads.
> > >=20
> > > Same for shutdown. You have to bring down the pool_threads first and
> > > then you can bring down the final thread and the rest of the server
> > > with it. Why it was designed this way, I have NFC.
> > >=20
> > > The new nfsdctl tool and netlink interfaces should make this simpler =
in
> > > the future. You'll be able to set the pool-mode in /etc/nfs.conf and
> > > configure a list of per-pool thread counts in there too. Once we have
> > > that, I think we'll be in a better position to consider doing it by
> > > default.
> > >=20
> > > Eventually we'd like to make the thread poos dynamic, at which point
> > > making that the default becomes much simpler from an administrative
> > > standpoint.
> >=20
> > I agree that dynamic thread pools will make numa management simpler.
> > Greg Banks did the numa work for SGI - I wonder where he is now.  He wa=
s
> > at fastmail 10 years ago..
>=20
> Dave (cc'd) designed it with Greg, Greg implemented it.
>=20
>=20
> > The idea was to bind network interfaces to numa nodes with interrupt
> > routing.  There was no expectation that work would be distributed evenl=
y
> > across all nodes. Some might be dedicated to non-nfs work.  So there wa=
s
> > expected to be non-trivial configuration for both IRQ routing and
> > threads-per-node.  If we can make threads-per-node demand-based, then
> > half the problem goes away.
>=20
> Network devices (and storage devices) are affined to one
> NUMA node. If the nfsd threads are not on the same node
> as the network device, there is a significant penalty.
>=20
> I have a two-node system here, and it performs consistently
> well when I put it in pool-mode=3Dnuma and affine the network
> device's IRQs to one node.
>=20
> It even works with two network devices (one per node) --
> each device gets its own set of nfsd threads.
>=20
> I don't think the pool_mode needs to be demand based. If
> the system is a NUMA system, it makes sense to split up
> the thread pools and put our pencils down. The only other
> step that is needed is proper IRQ affinity settings for
> the network devices.
>=20

Having them be demand-based is a nice-to-have. Right now, you need to
know how many thread pools (it's not always trivial to tell) and you
have and decide how many threads each gets. There is some cost to
getting that wrong too.

An on-demand thread pool takes a lot of the guesswork out of the
equation (assuming we can get the behavior right, of course).

>=20
> > We could even default to one-thread-pool-per-CPU if there are more than
> > X cpus....
>=20
> I've never seen a performance improvement in the per-cpu
> pool mode, fwiw.
>=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>


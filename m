Return-Path: <linux-nfs+bounces-4007-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8190DD1F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E637281F9A
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075445BE4;
	Tue, 18 Jun 2024 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tshRZ5lz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10639AEC
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741810; cv=none; b=hiUpMlWy/Es8jLpFlfYydeg9d6w+6ZF/sjA4tFDwPJpRwZggf9NYXl0r5s9KoyshEmN3vs/V/htkHAMq+7e8xdGRhWR2ASFZJpsSYfciAWnKb5Wc6HKkqupqVN0jpyOHn8jnc+VTzWViTT8AnUFbp+eaab/TgyFqtWslyigREJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741810; c=relaxed/simple;
	bh=U0HMQZg1l6Q+V2Lt4tLwAkm8pXBlZIOJHT+PHZMI0uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AM7hkSX+yuc5PvV+4tBjscUhYvKi0Ont0OTbn/8pC8IVJSgMF0QEW0sGAv8ZVXe1cddNgpDTbJuhmiyNGQrg8FmkBtDBI/wG7Pv3u1T+3YcMSQ44HoVme/2p2jn7hdAsygg6NftQsS/SHZLj3O1T/jRje6Qb3PpB/boFjdw5V7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tshRZ5lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050DDC3277B;
	Tue, 18 Jun 2024 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718741809;
	bh=U0HMQZg1l6Q+V2Lt4tLwAkm8pXBlZIOJHT+PHZMI0uk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tshRZ5lzeGvuXHNpcJqWd5ytYmKaVIsob94K6ANXJ/6OXU/prhLoG9e41k53qFvP1
	 Yvr4omggEjwtbB0+o5auky+hCWbtl+N3SHrB+b+ucErlNSwlganxMn/ICXUwW8VLtW
	 TRLmkVeBf4gHEPrAzpZFG+MIwDCH36G7XhdaKTPp7LiZQ80G0G/D6grSVOGtWodcaS
	 w3PIb+VYALWkUSoGWZ0n8oL9sgbLeRffxY03XlTH3eEKe1G1Wlpmt8WfQ1FPsOgVx1
	 d+cRKjEwMcvQbdeVDOgW0mlSzD9GIAqCG1SeY5A+UZBrTTIPLZ/mz3fWRZvG1jzCFz
	 4Yh9NR2xTQfrg==
Message-ID: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
Subject: Re: knfsd performance
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, Trond Myklebust
	 <trondmy@hammerspace.com>, Dave Chinner <david@fromorbit.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, "neilb@suse.com"
	 <neilb@suse.com>
Date: Tue, 18 Jun 2024 16:16:47 -0400
In-Reply-To: <7F7971B5-C7C8-4D0B-99CB-2D6CA8235FDD@oracle.com>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>
	 <58A84B36-C121-46F8-ABCB-BE4F212E9C81@oracle.com>
	 <754f3e0f6f962cbd46b2b22e87d9de9f8b285ab4.camel@hammerspace.com>
	 <7FFACD6E-86D2-4D14-BF03-77081B4CFF38@oracle.com>
	 <70766c4bd70742d0da79be50ebaf2eaeb7b18559.camel@hammerspace.com>
	 <7F7971B5-C7C8-4D0B-99CB-2D6CA8235FDD@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 19:54 +0000, Chuck Lever III wrote:
>=20
>=20
> > On Jun 18, 2024, at 3:50=E2=80=AFPM, Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> >=20
> > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > >=20
> > >=20
> > > > On Jun 18, 2024, at 3:29=E2=80=AFPM, Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > >=20
> > > > On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > >=20
> > > > > > On Jun 18, 2024, at 2:32=E2=80=AFPM, Trond Myklebust
> > > > > > <trondmy@hammerspace.com> wrote:
> > > > > >=20
> > > > > > I recently back ported Neil's lwq code and sunrpc server
> > > > > > changes to
> > > > > > our
> > > > > > 5.15.130 based kernel in the hope of improving the
> > > > > > performance
> > > > > > for
> > > > > > our
> > > > > > data servers.
> > > > > >=20
> > > > > > Our performance team recently ran a fio workload on a
> > > > > > client
> > > > > > that
> > > > > > was
> > > > > > doing 100% NFSv3 reads in O_DIRECT mode over an RDMA
> > > > > > connection
> > > > > > (infiniband) against that resulting server. I've attached
> > > > > > the
> > > > > > resulting
> > > > > > flame graph from a perf profile run on the server side.
> > > > > >=20
> > > > > > Is anyone else seeing this massive contention for the spin
> > > > > > lock
> > > > > > in
> > > > > > __lwq_dequeue? As you can see, it appears to be dwarfing
> > > > > > all
> > > > > > the
> > > > > > other
> > > > > > nfsd activity on the system in question here, being
> > > > > > responsible
> > > > > > for
> > > > > > 45%
> > > > > > of all the perf hits.
> > > > >=20
> > > > > I haven't seen that, but I've been working on other issues.
> > > > >=20
> > > > > What's the nfsd thread count on your test server? Have you
> > > > > seen a similar impact on 6.10 kernels ?
> > > > >=20
> > > >=20
> > > > 640 knfsd threads. The machine was a supermicro 2029BT-HNR with
> > > > 2xIntel
> > > > 6150, 384GB of memory and 6xWDC SN840.
> > > >=20
> > > > Unfortunately, the machine was a loaner, so cannot compare to
> > > > 6.10.
> > > > That's why I was asking if anyone has seen anything similar.
> > >=20
> > > If this system had more than one NUMA node, then using
> > > svc's "numa pool" mode might have helped.
> > >=20
> >=20
> > Interesting. I had forgotten about that setting.
> >=20
> > Just out of curiosity, is there any reason why we might not want to
> > default to that mode on a NUMA enabled system?
>=20
> Can't think of one off hand. Maybe back in the day it was
> hard to tell when you were actually /on/ a NUMA system.
>=20
> Copying Dave to see if he has any recollection.
>=20

It's at least partly because of the klunkiness of the old pool_threads
interface: You have to bring up the server first using the "threads"
procfile, and then you can actually bring up threads in the various
pools using pool_threads.

Same for shutdown. You have to bring down the pool_threads first and
then you can bring down the final thread and the rest of the server
with it. Why it was designed this way, I have NFC.

The new nfsdctl tool and netlink interfaces should make this simpler in
the future. You'll be able to set the pool-mode in /etc/nfs.conf and
configure a list of per-pool thread counts in there too. Once we have
that, I think we'll be in a better position to consider doing it by
default.

Eventually we'd like to make the thread poos dynamic, at which point
making that the default becomes much simpler from an administrative
standpoint.
--=20
Jeff Layton <jlayton@kernel.org>


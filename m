Return-Path: <linux-nfs+bounces-13700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52BB28DF7
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F015C176FA0
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B111B42A8B;
	Sat, 16 Aug 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLmlXtCk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2C1EB5B
	for <linux-nfs@vger.kernel.org>; Sat, 16 Aug 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755349309; cv=none; b=cCnPJj4s09xA3Gaql30SiLJgVxAcsCTOz7j2qjh0vVr1cSk5KDQgFZBW36cjCRSDM+OBzhJHSKZx5KuBmcuNUHRyGauaxw3xu/srVBa/RFpgYvWQPvBTR8S0zC/5uVFgwKXgHu4u6yBgiF9UJQSQ/rP+ocm+F//9NKtcQord9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755349309; c=relaxed/simple;
	bh=JJPkTpuhyEnMKE3HI1BpM2TAk2xAx1JdlyKQ9VBwj9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQVSOAau173KUnYirU5ymWUPZzCQCkrE2nqKwcIs+aKrt/yHYHlXmYY5rHVCZdw1LJLLN6XZIYa58BKRXyIklccxPQx+8eWITwJtUOWCqmvWWqwoI96cfTyVaDOWUWXJhUuVI35A/wky4aQpfYqLDQgegoyT7V0Mrf2sr3NeQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLmlXtCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925A8C4CEEF;
	Sat, 16 Aug 2025 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755349309;
	bh=JJPkTpuhyEnMKE3HI1BpM2TAk2xAx1JdlyKQ9VBwj9o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GLmlXtCk6GRAUhTh+jt+MWeEV2Kl8MA8ZNnV33N9KT32PpuG7QMSk+AdMgjUQcQgy
	 P3E3QSA4hQZ/vC9cFP9Fe6xsZoGIquGaAMBYhUf6WtpJKyTKNAxpdD3gDcZ3kYBi85
	 ZcKDFgxiNsaf2gbeD1qIGCovPqJeEaDNlbEokpwFaaIgOf7CZ3GW/lchw3iFsdqkmB
	 UpT0sXnvAD6xojk6o4pNG391PyM2MC7lU1bYfuuXNC0ACsINPGURsxMykXwMmJzQki
	 kD3rOMrYBlOIAHDhmD2QBQL64LGxwbG04qI3gVElKGOU0BeORiun2oA/qI+wH8DKn7
	 KURjlH5xfCCaA==
Message-ID: <972c7790fa69cc64a591b71fcc7a40b2cd477beb.camel@kernel.org>
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Sat, 16 Aug 2025 09:01:47 -0400
In-Reply-To: <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
			 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
		 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
	 <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: multipart/mixed; boundary="=-8bvapLYtaNTodXy5E0kf"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-8bvapLYtaNTodXy5E0kf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-12 at 09:58 -0700, Trond Myklebust wrote:
> On Tue, 2025-08-12 at 07:58 -0400, Jeff Layton wrote:
> > On Thu, 2025-07-31 at 17:56 -0400, Trond Myklebust wrote:
> > > On Wed, 2025-07-30 at 10:52 -0400, Jeff Layton wrote:
> > > > We've been seeing a rather nasty bit of data corruption with NFS
> > > > in
> > > > our
> > > > environment. The clients in this env run a patched v6.9 kernel
> > > > (mostly
> > > > due to GPU driver requirements). Most of the patches are NFS
> > > > containerization fixes.
> > > >=20
> > > > The workload is python scripts writing JSONL files sequentially
> > > > using
> > > > bog-standard buffered write() calls. We're fairly certain that
> > > > userland
> > > > is not seeking so there should be no gaps in the data written.
> > > >=20
> > > > The problem is that we see ranges of written files being replaced
> > > > by
> > > > NULs. The length of the file seemingly doesn't change from what
> > > > it
> > > > should be, but a chunk of it will be zeroed-out. Looking at the
> > > > offsets
> > > > of the zeroed out ranges, the front part of one page is fine, but
> > > > the
> > > > data from some random offset in the page to the end of the page
> > > > is
> > > > zeroes.
> > > >=20
> > > > We have a reproducer but we have to run it in a heavily parallel
> > > > configuration to make it happen, so it's evidently a tight race
> > > > of
> > > > some
> > > > sort.
> > > >=20
> > > > We've turned up some tracepoints and reproduced this twice. What
> > > > we
> > > > see
> > > > in both cases is that the client just doesn't write some section
> > > > of
> > > > the
> > > > file.
> > > >=20
> > > > In the first trace, there was is a gap of 2201 bytes between
> > > > these
> > > > two
> > > > writes on the wire:
> > > >=20
> > > > =C2=A0kworker/u1038:1-2597138 [106] ..... 46138.516795:
> > > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > > offset=3D53248 count=3D1895 stable=3DUNSTABLE
> > > > =C2=A0oil-localfs-252-2605046 [163] ..... 46138.551459:
> > > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > > offset=3D57344 count=3D443956 stable=3DFILE_SYNC
> > > >=20
> > > > The zeroed-out range is from 55143-57344. At the same time that
> > > > the
> > > > file is growing from 53248 to 55143 (due to sequential write()
> > > > activity), the client is kicking off writeback for the range up
> > > > to
> > > > 55143. It's issuing 2 writes, one for 0-53248 and one for 53248-
> > > > 55143
> > > > (note that I've filtered out all but one of the DS filehandles
> > > > for
> > > > brevity):
> > > >=20
> > > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.516414: nfs_size_gr=
ow:
> > > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > > version=3D1753485366409158129 cursize=3D49152 newsize=3D50130
> > > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.516593: nfs_size_gr=
ow:
> > > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > > version=3D1753485366409158129 cursize=3D50130 newsize=3D53248
> > > > =C2=A0kworker/u1038:1-2597138 [106] ..... 46138.516740:
> > > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > > offset=3D0 count=3D53248 stable=3DUNSTABLE
> > > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.516753: nfs_size_gr=
ow:
> > > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > > version=3D1753485366409158129 cursize=3D53248 newsize=3D55143
> > > > =C2=A0kworker/u1038:1-2597138 [106] ..... 46138.516795:
> > > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > > offset=3D53248 count=3D1895 stable=3DUNSTABLE
> > > > =C2=A0kworker/u1037:2-2871862 [097] ..... 46138.517659:
> > > > nfs4_pnfs_write:
> > > > error=3D0 (OK) fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55 offs=
et=3D0
> > > > count=3D53248 res=3D53248 stateid=3D1:0x79a9c471
> > > > layoutstateid=3D1:0xcbd8aaad
> > > > =C2=A0kworker/u1037:2-2871862 [097] ..... 46138.517662:
> > > > nfs_writeback_done: error=3D53248 fileid=3D00:aa:10056165185
> > > > fhandle=3D0x6bd94d55 offset=3D0 count=3D53248 res=3D53248 stable=3D=
UNSTABLE
> > > > verifier=3D5199cdae2816c899
> > > > =C2=A0kworker/u1037:5-2593935 [226] ..... 46138.517669:
> > > > nfs4_pnfs_write:
> > > > error=3D0 (OK) fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > > offset=3D53248
> > > > count=3D1895 res=3D1895 stateid=3D1:0x79a9c471
> > > > layoutstateid=3D1:0xcbd8aaad
> > > > =C2=A0kworker/u1037:5-2593935 [226] ..... 46138.517672:
> > > > nfs_writeback_done: error=3D1895 fileid=3D00:aa:10056165185
> > > > fhandle=3D0x6bd94d55 offset=3D53248 count=3D1895 res=3D1895
> > > > stable=3DUNSTABLE
> > > > verifier=3D5199cdae2816c899
> > > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.518360: nfs_size_gr=
ow:
> > > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > > version=3D1753485366409158129 cursize=3D55143 newsize=3D57344
> > > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.518556: nfs_size_gr=
ow:
> > > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > > version=3D1753485366409158129 cursize=3D57344 newsize=3D60156
> > > >=20
> > > > ...and just after writeback completes, we see the file size grow
> > > > from
> > > > 55143 to the end of the page (57344).
> > > >=20
> > > > The second trace has similar symptoms. There is a lot more
> > > > (smaller)
> > > > write activity (due to memory pressure?). There is a gap of 3791
> > > > bytes
> > > > between these on-the-wire writes, however:
> > > >=20
> > > > =C2=A0kworker/u1036:0-2339252 [217] ..... 479572.054622:
> > > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > > offset=3D221184 count=3D4401 stable=3DUNSTABLE
> > > > =C2=A0kworker/u1030:1-2297876 [042] ..... 479572.074194:
> > > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > > offset=3D229376 count=3D261898 stable=3DUNSTABLE
> > > >=20
> > > > Same situation -- the at page at offset 53248 has 305 bytes on
> > > > it,
> > > > and
> > > > the remaining is zeroed. This trace shows similar racing write()
> > > > and
> > > > writeback activity as in Friday's trace. At around the same time
> > > > as
> > > > the
> > > > client was growing the file over the affected range, writeback
> > > > was
> > > > kicking off for everything up to the affected range (this has
> > > > some
> > > > other wb related calls filtered for brevity):
> > > >=20
> > > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.053987:
> > > > nfs_size_grow:
> > > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > > version=3D1753823598774309300 cursize=3D217088
> > > > newsize=3D220572=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > =C2=A0kworker/u1036:8-2339326 [088] ..... 479572.054008:
> > > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > > offset=3D217088 count=3D3484
> > > > stable=3DUNSTABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20
> > > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054405:
> > > > nfs_size_grow:
> > > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > > version=3D1753823598774309300 cursize=3D220572
> > > > newsize=3D221184=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > =C2=A0kworker/u1036:1-2297875 [217] ..... 479572.054418:
> > > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > > offset=3D220572 count=3D612
> > > > stable=3DUNSTABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=20
> > > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054581:
> > > > nfs_size_grow:
> > > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > > version=3D1753823598774309300 cursize=3D221184
> > > > newsize=3D225280=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054584:
> > > > nfs_size_grow:
> > > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > > version=3D1753823598774309300 cursize=3D225280
> > > > newsize=3D225585=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > =C2=A0kworker/u1036:0-2339252 [217] ..... 479572.054622:
> > > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > > offset=3D221184 count=3D4401
> > > > stable=3DUNSTABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20
> > > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054997:
> > > > nfs_size_grow:
> > > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > > version=3D1753823598774309300 cursize=3D225585
> > > > newsize=3D229376=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.055190:
> > > > nfs_size_grow:
> > > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > > version=3D1753823598774309300 cursize=3D229376
> > > > newsize=3D230598=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > >=20
> > > > Could this be a race between extending an existing dirty page,
> > > > and
> > > > writeback kicking off for the pre-extension range on the page?
> > > > Maybe
> > > > the client is clearing the dirty bit, thinking that the write
> > > > covers
> > > > the dirty range, but it has an outdated idea about what that
> > > > range is
> > > > or doesn't properly check?
> > > >=20
> > > > Traces for both events, filtered on the relevant fileid are
> > > > attached.
> > > > I've rolled patches for some new tracepoints that I'm going to
> > > > attempt
> > > > to turn up next, but I thought that this was a good point to
> > > > solicit
> > > > ideas.
> > > >=20
> > > > Happy to entertain other thoughts or patches!
> > >=20
> > > So... The fact that we are seeing a nfs_size_grow() for the hole at
> > > offset 55143 means that either an existing request was updated, or
> > > a
> > > new one was created in order to cover that hole, and it must have
> > > been
> > > marked as dirty.
> > >=20
> > > I'm not seeing anything in the NFS code that can lose that request
> > > without triggering either the nfs_write_error tracepoint, the
> > > nfs_commit_error tracepoint, the nfs_invalidate_folio tracepoint or
> > > else completing the write.
> > >=20
> > > The only other way I can see this data being lost is if something
> > > is
> > > corrupting folio->private, or if the page cache is somehow managing
> > > to
> > > throw away a dirty folio.
> > > Of the two, there was for a while a netfs bug which would corrupt
> > > folio->private, but I assume you're not using cachefs?
> >=20
> > After staring at this code a lot, I have a theory. But, it seems like
> > we'd be seeing this a lot more if it were correct, so I must be
> > overlooking something.
> >=20
> > Here's the scenario:
> >=20
> > --------------8<--------------
> >=20
> > Userland has written some of a file and the last folio is not full.
> >=20
> > Writeback has kicked off for the inode and is successful.
> > nfs_write_completion() calls nfs_page_end_writeback(). That will
> > unlock
> > the nfs_page (clear PG_BUSY) and leave it attached to the folio, and
> > on
> > the commit list.
> >=20
> > Next a write from userland comes in to extend the file to the end of
> > the page (and beyond). nfs_try_to_update_request() merges the write
> > into the original request and re-marks the page dirty.
> >=20
> > Later the commit runs successfully and the write verifier matches.
> > nfs_commit_release_pages() runs and nfs_inode_remove_request() is
> > called which detaches the nfs_page from the folio.
> >=20
> > Eventually, writeback starts up again and the folio is picked up and
> > submitted by nfs_writepages(), but folio->private is now NULL, and
> > it's
> > ignored.
> >=20
> > But...like I said I feel like we'd hit this all the time if it were
> > possible, even though I don't see what prevents it. If this is a
> > possibility, then the patch may be as simple as something like this?
> >=20
> > diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> > index bb0e78644ffb..72402208fa33 100644
> > --- a/fs/nfs/write.c
> > +++ b/fs/nfs/write.c
> > @@ -1867,7 +1867,7 @@ static void nfs_commit_release_pages(struct
> > nfs_commit_data *data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * returned by the server against all stored ver=
fs.
> > */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (nfs_write_match_verf(verf, req)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We=
 have a match */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio &=
& !folio_test_dirty(folio))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_inode_remove_request(req);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dprin=
tk_cont(" OK\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
next;
>=20
> The call to nfs_clear_request_commit() in nfs_join_page_group() should
> be taking care of removing the page before a COMMIT is sent.
>=20
> During both the writeback and the commit, the nfs_page is locked, so
> won't be available to be updated by nfs_try_to_update_request().

I finally caught something concrete today. I had the attached bpftrace
script running while running the reproducer on a dozen or so machines,
and it detected a hole in some data being written:

-------------8<---------------
Attached 2 probes
Missing nfs_page: ino=3D10122173116 idx=3D2 flags=3D0x15ffff0000000029
Hole: ino=3D10122173116 idx=3D3 off=3D10026 size=3D2262
Prev folio: idx=3D2 flags=3D0x15ffff0000000028 pgbase=3D0 bytes=3D4096 req=
=3D0 prevreq=3D0xffff8955b2f55980
-------------8<---------------

What this tells us is that the page at idx=3D2 got submitted to
nfs_do_writepage() (so it was marked dirty in the pagecache), but when
it got there, folio->private was NULL and it was ignored.

The kernel in this case is based on v6.9, so it's (just) pre-large-
folio support. It has a fair number of NFS patches, but not much to
this portion of the code. Most of them are are containerization fixes.

I'm looking askance at nfs_inode_remove_request(). It does this:

        if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
                struct folio *folio =3D nfs_page_to_folio(req->wb_head);
                struct address_space *mapping =3D folio->mapping;

                spin_lock(&mapping->i_private_lock);
                if (likely(folio)) {
                        folio->private =3D NULL;
                        folio_clear_private(folio);
                        clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
                }
                spin_unlock(&mapping->i_private_lock);
        }

If nfs_page_group_sync_on_bit() returns true, then the nfs_page gets
detached from the folio. Meanwhile, if a new write request comes in
just after that, nfs_lock_and_join_requests() will call
nfs_cancel_remove_inode() to try to "cancel" PG_REMOVE:

static int
nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
{
        int ret;

        if (!test_bit(PG_REMOVE, &req->wb_flags))
                return 0;
        ret =3D nfs_page_group_lock(req);
        if (ret)
                return ret;
        if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
                nfs_page_set_inode_ref(req, inode);
        nfs_page_group_unlock(req);                         =20
        return 0;                                   =20
}                    =20

...but that does not reattach the nfs_page to the folio. Should it?
                        =20
--=20
Jeff Layton <jlayton@kernel.org>

--=-8bvapLYtaNTodXy5E0kf
Content-Disposition: attachment; filename="nfs_write_hole.bt"
Content-Type: text/x-csrc; name="nfs_write_hole.bt"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGxpbnV4L25mc19mcy5oPgojaW5jbHVkZSA8bGludXgvbmZzNC5oPgojaW5jbHVk
ZSA8bGludXgvbmZzX3BhZ2UuaD4KCi8qCiAqIFRoaXMgZG9lcyBnZW5lcmF0ZSBzb21lIGZhbHNl
IHBvc2l0aXZlcyBpZiB3cml0ZWJhY2sgZ29lcyBvdXQgb2YgYXNjZW5kaW5nIG9yZGVyLiBUaGF0
CiAqIHNob3VsZG4ndCBoYXBwZW4gbXVjaC4gTW9zdGx5IHdlJ3JlIGludGVyZXN0ZWQgaW4gdW5h
bGlnbmVkIGdhcHMuCiAqLwoKY29uZmlnID0gewogICAgICAgIHByaW50X21hcHNfb25fZXhpdCA9
IGZhbHNlOwogICAgICAgIG1heF9tYXBfa2V5cyA9IDE2Mzg0Owp9CgpmZW50cnk6bmZzOm5mc19k
b193cml0ZXBhZ2UgewogICAgICAgICRmb2xpbyA9IGFyZ3MuZm9saW87CiAgICAgICAgJGlubyA9
ICRmb2xpby0+bWFwcGluZy0+aG9zdC0+aV9pbm87CiAgICAgICAgJGlkeCA9ICRmb2xpby0+aW5k
ZXg7CiAgICAgICAgJHJlcSA9IChzdHJ1Y3QgbmZzX3BhZ2UgKikkZm9saW8tPnByaXZhdGU7CiAg
ICAgICAgaWYgKCRyZXEgPT0gMCkgewogICAgICAgICAgICAgICAgcHJpbnRmKCJNaXNzaW5nIG5m
c19wYWdlOiBpbm89JWxsdSBpZHg9JWxsdSBmbGFncz0weCVseFxuIiwgJGlubywgJGlkeCwgJGZv
bGlvLT5wYWdlLmZsYWdzKTsKICAgICAgICAgICAgICAgIHJldHVybjsKICAgICAgICB9CiAgICAg
ICAgJHN0YXJ0ID0gKCRpZHggKiA0MDk2KSArICRyZXEtPndiX3BnYmFzZTsKICAgICAgICAkZW5k
ID0gJHN0YXJ0ICsgJHJlcS0+d2JfYnl0ZXM7CiAgICAgICAgJGdhcHNpemUgPSAkc3RhcnQgLSBA
bGFzdGVuZFskaW5vXTsKICAgICAgICBpZiAoKCRpZHggPT0gQGxhc3RpZHhbJGlub10gKyAxKSAm
JiAoJGdhcHNpemUgJSA0MDk2KSkgewogICAgICAgICAgICAgICAgcHJpbnRmKCJIb2xlOiBpbm89
JWxsdSBpZHg9JWx1IG9mZj0lbGx1IHNpemU9JWxsdVxuIiwgJGlubywgJGlkeCwgQGxhc3RlbmRb
JGlub10sICRnYXBzaXplKTsKICAgICAgICAgICAgICAgICRwcmV2Zm9saW8gPSBAbGFzdGZvbGlv
WyRpbm9dOwogICAgICAgICAgICAgICAgJHByZXZmbGFncyA9ICRwcmV2Zm9saW8tPnBhZ2UuZmxh
Z3M7CiAgICAgICAgICAgICAgICAkcHJldnJlcSA9IEBsYXN0cmVxWyRpbm9dOwogICAgICAgICAg
ICAgICAgJHBnYmFzZSA9ICh1aW50MzIpMDsKICAgICAgICAgICAgICAgICRieXRlcyA9ICh1aW50
MzIpMDsKICAgICAgICAgICAgICAgIGlmICgkcHJldnJlcSkgewogICAgICAgICAgICAgICAgICAg
ICAgICAkcGdiYXNlID0gJHByZXZyZXEtPndiX3BnYmFzZTsKICAgICAgICAgICAgICAgICAgICAg
ICAgJGJ5dGVzID0gJHByZXZyZXEtPndiX2J5dGVzOwogICAgICAgICAgICAgICAgfQogICAgICAg
ICAgICAgICAgcHJpbnRmKCJQcmV2IGZvbGlvOiBpZHg9JWx1IGZsYWdzPTB4JWx4IHBnYmFzZT0l
bGx1IGJ5dGVzPSVsbHUgcmVxPSVwIHByZXZyZXE9JXBcbiIsIEBsYXN0aWR4WyRpbm9dLCAkcHJl
dmZsYWdzLCAkcGdiYXNlLCAkYnl0ZXMsICRwcmV2Zm9saW8tPnByaXZhdGUsICRwcmV2cmVxKTsK
ICAgICAgICB9CiAgICAgICAgQGxhc3RpZHhbJGlub10gPSAkaWR4OwogICAgICAgIEBsYXN0Zm9s
aW9bJGlub10gPSAkZm9saW87CiAgICAgICAgQGxhc3RyZXFbJGlub10gPSAkcmVxOwogICAgICAg
IEBsYXN0ZW5kWyRpbm9dID0gJGVuZDsKfQoKZmVudHJ5Om5mczpuZnNfZmlsZV9yZWxlYXNlIHsK
ICAgICAgICAkaW5vZGUgPSBhcmdzLmlub2RlOwogICAgICAgICRmaWxlID0gYXJncy5maWxwOwog
ICAgICAgICRpbm8gPSAkaW5vZGUtPmlfaW5vOwoKICAgICAgICAvLyBGTU9ERV9XUklURSA9PSAw
eDIKICAgICAgICBpZiAoISgkZmlsZS0+Zl9tb2RlICYgMHgyKSkgewogICAgICAgICAgICAgICAg
cmV0dXJuOwogICAgICAgIH0KCiAgICAgICAgaWYgKGhhc19rZXkoQGxhc3RpZHgsICRpbm8pKSB7
CiAgICAgICAgICAgICAgICBkZWxldGUoQGxhc3RpZHgsICRpbm8pOwogICAgICAgIH0KICAgICAg
ICBpZiAoaGFzX2tleShAbGFzdGZvbGlvLCAkaW5vKSkgewogICAgICAgICAgICAgICAgZGVsZXRl
KEBsYXN0Zm9saW8sICRpbm8pOwogICAgICAgIH0KICAgICAgICBpZiAoaGFzX2tleShAbGFzdHJl
cSwgJGlubykpIHsKICAgICAgICAgICAgICAgIGRlbGV0ZShAbGFzdHJlcSwgJGlubyk7CiAgICAg
ICAgfQogICAgICAgIGlmIChoYXNfa2V5KEBsYXN0ZW5kLCAkaW5vKSkgewogICAgICAgICAgICAg
ICAgZGVsZXRlKEBsYXN0ZW5kLCAkaW5vKTsKICAgICAgICB9Cn0K


--=-8bvapLYtaNTodXy5E0kf--


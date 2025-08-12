Return-Path: <linux-nfs+bounces-13579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9DB22E7C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 19:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33CD2A2852
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 16:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9E2FA0E9;
	Tue, 12 Aug 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSLvaGd+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7CC2E7BB6
	for <linux-nfs@vger.kernel.org>; Tue, 12 Aug 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017902; cv=none; b=h/+xKVi/BEUgpbIuylEve8VBzFa1eYMKcZBjy+P2BMKwmb8sedm0Z6T3AAm4rEFnYATaMYNMdeEW34v5pQ48W1Ll0RmxasmzwkvpubvQsvzRdwr0MuZondtOslVN/+VnJ7zjBdY47hGhrHN9LHZkB+lLqa2BMqYPHZN6uY1v49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017902; c=relaxed/simple;
	bh=wWvQLqjCB9qysR4y+L1GCSkxCgVgXc8ufLBEikawHOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZAy7k7K5/5dq+asn/D2n82jQrUj3vCLo9X7k8vU7fjjyoo0tFiP1T6ijIr+aqrfLrYgp4jZx11mefBX6fSHHxMGTtKaIICupRRJ9GlzpGZ3GyUVYUl2OfuAlFy5994XeMV8m9xG4so3pKJMn2r6mPa+IRt+Vig5Js+l/HIuH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSLvaGd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE71C4CEF0;
	Tue, 12 Aug 2025 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755017901;
	bh=wWvQLqjCB9qysR4y+L1GCSkxCgVgXc8ufLBEikawHOM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KSLvaGd+1GR6wi9Qa3FTRcBDniIuk6N6j2Esgoe51dGi7jqmPFGcLKKXEaaBIU14D
	 GbY3OJMrHuMMWy6kh4ystGh3GjjjR+vbba77KdQ+3cKR7GwVXLVtIxp3CIBPLx31BJ
	 j+yYsh+w5bRW7hrXgJpWG2E2/cxZvl2nsMSkeC7uCoSsSnqpuvScNEO8dE5rQG+XZa
	 sLXgVvSbqDgt7yTSzhbw/qAvpL6A+jb+4xAsi48izjyYxKwKLXl+OkOSOMFL5hLi8u
	 AvaPaVG5L2eqFx3PT5yGtFQekHdidz2AwidGeZCFXOURc4VSot8/jnrhblJX2U5NfZ
	 tIR/sC7PfQiTw==
Message-ID: <e583450b5d0ccc5d82fc383f58fc4f02495f5c2c.camel@kernel.org>
Subject: Re: parts of pages on NFS being replaced by swaths of NULs
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Tue, 12 Aug 2025 09:58:20 -0700
In-Reply-To: <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
References: <1c42a7fd9677ad1aa9a3a53eda738b3a6da3728e.camel@kernel.org>
		 <752db17aff35a92b79e4c7bd3003ed890fe91403.camel@kernel.org>
	 <be7114cedde5867041dda00562beebded4cdce9e.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-12 at 07:58 -0400, Jeff Layton wrote:
> On Thu, 2025-07-31 at 17:56 -0400, Trond Myklebust wrote:
> > On Wed, 2025-07-30 at 10:52 -0400, Jeff Layton wrote:
> > > We've been seeing a rather nasty bit of data corruption with NFS
> > > in
> > > our
> > > environment. The clients in this env run a patched v6.9 kernel
> > > (mostly
> > > due to GPU driver requirements). Most of the patches are NFS
> > > containerization fixes.
> > >=20
> > > The workload is python scripts writing JSONL files sequentially
> > > using
> > > bog-standard buffered write() calls. We're fairly certain that
> > > userland
> > > is not seeking so there should be no gaps in the data written.
> > >=20
> > > The problem is that we see ranges of written files being replaced
> > > by
> > > NULs. The length of the file seemingly doesn't change from what
> > > it
> > > should be, but a chunk of it will be zeroed-out. Looking at the
> > > offsets
> > > of the zeroed out ranges, the front part of one page is fine, but
> > > the
> > > data from some random offset in the page to the end of the page
> > > is
> > > zeroes.
> > >=20
> > > We have a reproducer but we have to run it in a heavily parallel
> > > configuration to make it happen, so it's evidently a tight race
> > > of
> > > some
> > > sort.
> > >=20
> > > We've turned up some tracepoints and reproduced this twice. What
> > > we
> > > see
> > > in both cases is that the client just doesn't write some section
> > > of
> > > the
> > > file.
> > >=20
> > > In the first trace, there was is a gap of 2201 bytes between
> > > these
> > > two
> > > writes on the wire:
> > >=20
> > > =C2=A0kworker/u1038:1-2597138 [106] ..... 46138.516795:
> > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > offset=3D53248 count=3D1895 stable=3DUNSTABLE
> > > =C2=A0oil-localfs-252-2605046 [163] ..... 46138.551459:
> > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > offset=3D57344 count=3D443956 stable=3DFILE_SYNC
> > >=20
> > > The zeroed-out range is from 55143-57344. At the same time that
> > > the
> > > file is growing from 53248 to 55143 (due to sequential write()
> > > activity), the client is kicking off writeback for the range up
> > > to
> > > 55143. It's issuing 2 writes, one for 0-53248 and one for 53248-
> > > 55143
> > > (note that I've filtered out all but one of the DS filehandles
> > > for
> > > brevity):
> > >=20
> > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.516414: nfs_size_grow=
:
> > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > version=3D1753485366409158129 cursize=3D49152 newsize=3D50130
> > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.516593: nfs_size_grow=
:
> > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > version=3D1753485366409158129 cursize=3D50130 newsize=3D53248
> > > =C2=A0kworker/u1038:1-2597138 [106] ..... 46138.516740:
> > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > offset=3D0 count=3D53248 stable=3DUNSTABLE
> > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.516753: nfs_size_grow=
:
> > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > version=3D1753485366409158129 cursize=3D53248 newsize=3D55143
> > > =C2=A0kworker/u1038:1-2597138 [106] ..... 46138.516795:
> > > nfs_initiate_write: fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > offset=3D53248 count=3D1895 stable=3DUNSTABLE
> > > =C2=A0kworker/u1037:2-2871862 [097] ..... 46138.517659:
> > > nfs4_pnfs_write:
> > > error=3D0 (OK) fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55 offset=
=3D0
> > > count=3D53248 res=3D53248 stateid=3D1:0x79a9c471
> > > layoutstateid=3D1:0xcbd8aaad
> > > =C2=A0kworker/u1037:2-2871862 [097] ..... 46138.517662:
> > > nfs_writeback_done: error=3D53248 fileid=3D00:aa:10056165185
> > > fhandle=3D0x6bd94d55 offset=3D0 count=3D53248 res=3D53248 stable=3DUN=
STABLE
> > > verifier=3D5199cdae2816c899
> > > =C2=A0kworker/u1037:5-2593935 [226] ..... 46138.517669:
> > > nfs4_pnfs_write:
> > > error=3D0 (OK) fileid=3D00:aa:10056165185 fhandle=3D0x6bd94d55
> > > offset=3D53248
> > > count=3D1895 res=3D1895 stateid=3D1:0x79a9c471
> > > layoutstateid=3D1:0xcbd8aaad
> > > =C2=A0kworker/u1037:5-2593935 [226] ..... 46138.517672:
> > > nfs_writeback_done: error=3D1895 fileid=3D00:aa:10056165185
> > > fhandle=3D0x6bd94d55 offset=3D53248 count=3D1895 res=3D1895
> > > stable=3DUNSTABLE
> > > verifier=3D5199cdae2816c899
> > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.518360: nfs_size_grow=
:
> > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > version=3D1753485366409158129 cursize=3D55143 newsize=3D57344
> > > =C2=A0oil-localfs-252-2605046 [162] ..... 46138.518556: nfs_size_grow=
:
> > > fileid=3D00:aa:10056165185 fhandle=3D0x8bfc64c9
> > > version=3D1753485366409158129 cursize=3D57344 newsize=3D60156
> > >=20
> > > ...and just after writeback completes, we see the file size grow
> > > from
> > > 55143 to the end of the page (57344).
> > >=20
> > > The second trace has similar symptoms. There is a lot more
> > > (smaller)
> > > write activity (due to memory pressure?). There is a gap of 3791
> > > bytes
> > > between these on-the-wire writes, however:
> > >=20
> > > =C2=A0kworker/u1036:0-2339252 [217] ..... 479572.054622:
> > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > offset=3D221184 count=3D4401 stable=3DUNSTABLE
> > > =C2=A0kworker/u1030:1-2297876 [042] ..... 479572.074194:
> > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > offset=3D229376 count=3D261898 stable=3DUNSTABLE
> > >=20
> > > Same situation -- the at page at offset 53248 has 305 bytes on
> > > it,
> > > and
> > > the remaining is zeroed. This trace shows similar racing write()
> > > and
> > > writeback activity as in Friday's trace. At around the same time
> > > as
> > > the
> > > client was growing the file over the affected range, writeback
> > > was
> > > kicking off for everything up to the affected range (this has
> > > some
> > > other wb related calls filtered for brevity):
> > >=20
> > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.053987:
> > > nfs_size_grow:
> > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > version=3D1753823598774309300 cursize=3D217088
> > > newsize=3D220572=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > =C2=A0kworker/u1036:8-2339326 [088] ..... 479572.054008:
> > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > offset=3D217088 count=3D3484
> > > stable=3DUNSTABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054405:
> > > nfs_size_grow:
> > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > version=3D1753823598774309300 cursize=3D220572
> > > newsize=3D221184=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > =C2=A0kworker/u1036:1-2297875 [217] ..... 479572.054418:
> > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > offset=3D220572 count=3D612
> > > stable=3DUNSTABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=20
> > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054581:
> > > nfs_size_grow:
> > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > version=3D1753823598774309300 cursize=3D221184
> > > newsize=3D225280=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054584:
> > > nfs_size_grow:
> > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > version=3D1753823598774309300 cursize=3D225280
> > > newsize=3D225585=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > =C2=A0kworker/u1036:0-2339252 [217] ..... 479572.054622:
> > > nfs_initiate_write: fileid=3D00:96:10067193438 fhandle=3D0xc9992232
> > > offset=3D221184 count=3D4401
> > > stable=3DUNSTABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.054997:
> > > nfs_size_grow:
> > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > version=3D1753823598774309300 cursize=3D225585
> > > newsize=3D229376=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > =C2=A0 oil-localfs-86-727850=C2=A0 [215] ..... 479572.055190:
> > > nfs_size_grow:
> > > fileid=3D00:96:10067193438 fhandle=3D0x14c40498
> > > version=3D1753823598774309300 cursize=3D229376
> > > newsize=3D230598=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > >=20
> > > Could this be a race between extending an existing dirty page,
> > > and
> > > writeback kicking off for the pre-extension range on the page?
> > > Maybe
> > > the client is clearing the dirty bit, thinking that the write
> > > covers
> > > the dirty range, but it has an outdated idea about what that
> > > range is
> > > or doesn't properly check?
> > >=20
> > > Traces for both events, filtered on the relevant fileid are
> > > attached.
> > > I've rolled patches for some new tracepoints that I'm going to
> > > attempt
> > > to turn up next, but I thought that this was a good point to
> > > solicit
> > > ideas.
> > >=20
> > > Happy to entertain other thoughts or patches!
> >=20
> > So... The fact that we are seeing a nfs_size_grow() for the hole at
> > offset 55143 means that either an existing request was updated, or
> > a
> > new one was created in order to cover that hole, and it must have
> > been
> > marked as dirty.
> >=20
> > I'm not seeing anything in the NFS code that can lose that request
> > without triggering either the nfs_write_error tracepoint, the
> > nfs_commit_error tracepoint, the nfs_invalidate_folio tracepoint or
> > else completing the write.
> >=20
> > The only other way I can see this data being lost is if something
> > is
> > corrupting folio->private, or if the page cache is somehow managing
> > to
> > throw away a dirty folio.
> > Of the two, there was for a while a netfs bug which would corrupt
> > folio->private, but I assume you're not using cachefs?
>=20
> After staring at this code a lot, I have a theory. But, it seems like
> we'd be seeing this a lot more if it were correct, so I must be
> overlooking something.
>=20
> Here's the scenario:
>=20
> --------------8<--------------
>=20
> Userland has written some of a file and the last folio is not full.
>=20
> Writeback has kicked off for the inode and is successful.
> nfs_write_completion() calls nfs_page_end_writeback(). That will
> unlock
> the nfs_page (clear PG_BUSY) and leave it attached to the folio, and
> on
> the commit list.
>=20
> Next a write from userland comes in to extend the file to the end of
> the page (and beyond). nfs_try_to_update_request() merges the write
> into the original request and re-marks the page dirty.
>=20
> Later the commit runs successfully and the write verifier matches.
> nfs_commit_release_pages() runs and nfs_inode_remove_request() is
> called which detaches the nfs_page from the folio.
>=20
> Eventually, writeback starts up again and the folio is picked up and
> submitted by nfs_writepages(), but folio->private is now NULL, and
> it's
> ignored.
>=20
> But...like I said I feel like we'd hit this all the time if it were
> possible, even though I don't see what prevents it. If this is a
> possibility, then the patch may be as simple as something like this?
>=20
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index bb0e78644ffb..72402208fa33 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1867,7 +1867,7 @@ static void nfs_commit_release_pages(struct
> nfs_commit_data *data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * returned by the server against all stored verfs.
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (nfs_write_match_verf(verf, req)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We ha=
ve a match */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio && !=
folio_test_dirty(folio))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_inode_remove_request(req);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dprintk_=
cont(" OK\n");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto nex=
t;

The call to nfs_clear_request_commit() in nfs_join_page_group() should
be taking care of removing the page before a COMMIT is sent.

During both the writeback and the commit, the nfs_page is locked, so
won't be available to be updated by nfs_try_to_update_request().

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


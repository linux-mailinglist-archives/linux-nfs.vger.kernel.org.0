Return-Path: <linux-nfs+bounces-13196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F3B0E484
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 22:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01421C27A31
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654617C224;
	Tue, 22 Jul 2025 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ublYC2vh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032F27E7F0
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214618; cv=none; b=bTXNueEt7SLMjzxdhZkkKFftTK5gwdhBkaLNOoxTXKJfOYJEvFYbtaTEwpd+0OkHHmDlKF8p88dRf2FCDwF2XDa4IDRc9nXSddBNAVv4iUzMcuPAlqKa51A/jWDhn6xivlYqOKTU07lSZsgcmZPmYk9Tm7oz6wiz0GVbCJCLWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214618; c=relaxed/simple;
	bh=XCJXNFlUMnMF414R4hZkQVOhGCmU9bFNEief03IWGGs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqYTwrCO7q0qrkq/Qi941wjl/uaz0dy6kqRYDEDA4PajLORhsxEMTbh0r1oevs48pe5NMzyQklok3tZBQ31IOGIHu9kq3LNl4tfXxtT58XBRyKtjKx2DaMEIj1L+SH9zaq5oH60bG4SZij8yKon7rF3+Aco0ceaLOU6dfCbckkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ublYC2vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0485FC4CEEB;
	Tue, 22 Jul 2025 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753214614;
	bh=XCJXNFlUMnMF414R4hZkQVOhGCmU9bFNEief03IWGGs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ublYC2vhfoNeHGeBkKjtHhe223FHo5D84aYWvge2dLOZd4/b9dxKLs55Q/V6Vb9l9
	 S8OLyL7Re2v7b/ulDYQxP9qjsOypnxL/Sjyc3Bg4BFOiB3S0pxxTUkPAlAHK4rjrPZ
	 OkfCTR+lhndfUqGyRs+zUJtHympvrxdoYAb93IKaS2LBeCBmzfFR7EindZUstn1jrV
	 Ll5bRDnVj4n4mNF5AjrYBW918X700OrUtRxFehAXaoflg1lXNuO+Wu3zP2eCP97s3g
	 4ocgleh6gk7jFUetJj8EOxpH3aKZCSRR9wK3EpkrFr3IP+A1tLSPU1uajk7jZWX7bv
	 CcSOV5aULVIYw==
Message-ID: <da5ce5ea155d761f16c8834c9525f46b705da79f.camel@kernel.org>
Subject: Re: delegated timestamp woes
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Thomas Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Tue, 22 Jul 2025 16:03:32 -0400
In-Reply-To: <1b1d82709ee0edb5de4f4ac6d3eb6d72219583e0.camel@kernel.org>
References: <bfa20f4a81e0c2d5df8525476fb29af156f4f5f1.camel@kernel.org>
	 <1b1d82709ee0edb5de4f4ac6d3eb6d72219583e0.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 15:51 -0400, Trond Myklebust wrote:
> On Tue, 2025-07-22 at 15:27 -0400, Jeff Layton wrote:
> > I've been chasing some problems with the git regression testsuite
> > that
> > crop up with delegated timestamps enabled. I've knocked down a couple
> > of problems on the server side, but I'm not sure how to fix the
> > latest
> > issue.
> >=20
> > Most of the problems with gitr suite and delegated timestamps
> > manifest
> > as spurious changes to the timestamps. e.g., it will do a git
> > checkout
> > and then later find that some file in the checkout appears to have
> > changed when it didn't expect that.
> >=20
> > I reproduced one of the problems with some debugging turned up. What
> > we
> > see is this in the wireshark capture (filtered on the filehandle):
> >=20
> > 939238 1753209666.985827 192.168.122.151 =E2=86=92 192.168.122.103 NFS =
486 V4
> > Reply (Call In 939237) OPEN StateID: 0xafa9
> > 939239 1753209666.987808 192.168.122.103 =E2=86=92 192.168.122.151 NFS =
298 V4
> > Call SETATTR FH: 0x68fcd843
> > 939240 1753209666.995860 192.168.122.151 =E2=86=92 192.168.122.103 NFS =
294 V4
> > Reply (Call In 939239) SETATTR
> > 939241 1753209666.999909 192.168.122.103 =E2=86=92 192.168.122.151 NFS =
278 V4
> > Call WRITE StateID: 0xe7e8 Offset: 0 Len: 2
> > 939242 1753209667.019570 192.168.122.151 =E2=86=92 192.168.122.103 NFS =
182 V4
> > Reply (Call In 939241) WRITE
> > 944922 1753209696.313938 192.168.122.103 =E2=86=92 192.168.122.151 NFS =
1514
> > V4 Call SETATTR FH: 0xb6dd63b6 | DELEGRETURN StateID: 0x3eebV4 Call
> > SETATTR FH: 0xcf57bbcb | DELEGRETURN StateID: 0x69ca=C2=A0 ; V4 Call
> > SETATTR FH: 0x68fcd843 | DELEGRETURN StateID: 0xe245=C2=A0 ; V4 Call
> > SETATTR FH: 0x02d757ea | DELEGRETURN StateID: 0xc788=C2=A0 ; V4 Call
> > SETATTR FH: 0x130870b2 | DELEGRETURN StateID: 0x8c12
> > 946410 1753209702.893917 192.168.122.103 =E2=86=92 192.168.122.151 NFS =
254 V4
> > Call GETATTR FH: 0x68fcd843
> > 946411 1753209702.895304 192.168.122.151 =E2=86=92 192.168.122.103 NFS =
310 V4
> > Reply (Call In 946410) GETATTR
> >=20
> > We get an open for write (with no open stateid and delegated
> > timestamps), a write, and then and=C2=A0 setattr|delegreturn. git had t=
he
> > delegated mtime (1753209666.995071118) on file because the delegation
> > allowed getattr() on the client to return before writeback had
> > completed.
> >=20
> > In this case, the setattr for the delegated mtime was for a value
> > older
> > than the existing mtime, so it was ignored. Note that the reply to
>=20
> Uhh... Why is the existing value of the mtime on the server grounds for
> rejecting the delegated mtime? The client owns that value.=20
>=20

From RFC 9754:

   When the time presented is before the original time, then the update
   is ignored.  When the time presented is in the future, the server can
   either clamp the new time to the current time or return NFS4ERR_DELAY
   to the client, allowing it to retry.

In this case, the preceding WRITE operation from the client updated the
mtime and ctime on the server. That operation happened after the mtime
was updated on the client for that write.

Are you suggesting that the server needs to "disable" mtime/ctime
updates from WRITE calls (and I guess atime updates from READs) when
there is a delegation outstanding? If so, that would potentially be
quite ugly in the face of a crash.

> > the
> > WRITE didn't go out until 1753209667.019570, which is after
> > 1753209666.995071118.
> >=20
> > Eventually the client gets the "real" mtime from the server after
> > returning the delegation, which now doesn't match the one git has on
> > file.
> >=20
> > I don't see a way to fix this right offhand. Any thoughts?

--=20
Jeff Layton <jlayton@kernel.org>


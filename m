Return-Path: <linux-nfs+bounces-14093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D65B4670C
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58593B096E
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A659199E94;
	Fri,  5 Sep 2025 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYVkVLVo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155931F95C
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114185; cv=none; b=KVdHz+6UCdySZciE2y0rjskg3GnoRV/KBRwc763q1Pgdyeyah2+lD25L28g1A+JLKZ49pca2UBS+2sC2c6hhQEXFZ4/J1KfclfCn0Ll3kwGKbFs5FaIJrm8SCCmldgn3ePAzDfZOSaOla4sxnelUsxy5mIUkFWPwjis6ljWk4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114185; c=relaxed/simple;
	bh=kCGKvxd9BY8XlLE9dv+w/9XhAH3DXl8D6vrNgmUp0Yo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSG0h9pSBqGj+tD65dmxdWpXesAW77nclRlfXRkfzeF8nMpDWMsPa/TOlBWCwJ5FZVglzeVBsG9i+M5aM9IR7m7p/6mE7WPWVGQF8PHTDhIIIFFRaAMoNav6c26L762PBCQxelr6C/7VzhdOF1pS2IuaD/5RsFZ7ZJUsZ1xwMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYVkVLVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13224C4CEF1;
	Fri,  5 Sep 2025 23:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757114184;
	bh=kCGKvxd9BY8XlLE9dv+w/9XhAH3DXl8D6vrNgmUp0Yo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UYVkVLVoKdoIrG6YeIexu3byWUyh3vUJUI8xgCxAvo+lfY5nHJjCBazhAdm6RMwuo
	 VKI3s2L+Eld+o50i09GCMgm5T1aktVfCV1mGBwA0HGHNz0kNQa7LGXX7r/2gTazrCj
	 nhCpI8Jc7B97CQCqBxjR0WAKlNsjphZ4uCyHfdJ5Sj5uLYO0Ejrqm/6gfohkQrCcHm
	 fJD03Ph1Js95z2dxh5+J5vpoJ4vDbXdsYCaYKbg/IsPYXwHjqAhw9Z5GXIuSX1rehH
	 3oagQTkdh1jqztERACXEbdBhdW6pSwxlat+338fFpA5XZoNZesGhhromz34NZ4C9sN
	 wpWr72kyF8QXg==
Message-ID: <fbbebc3de6c6d505a0590c1323dfe134d338a74d.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: don't fail immediately in
 rpc_wait_bit_killable()
From: Trond Myklebust <trondmy@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, Anna Schumaker	
 <anna@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-nfs@vger.kernel.org
Date: Fri, 05 Sep 2025 19:16:22 -0400
In-Reply-To: <175711230465.2850467.14720425360212114773@noble.neil.brown.name>
References: <3e558c7f675b1f2e87098e58ef06c6f45ecf0a58.camel@kernel.org>
	 <175711230465.2850467.14720425360212114773@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-09-06 at 08:45 +1000, NeilBrown wrote:
> On Sat, 06 Sep 2025, Trond Myklebust wrote:
> > On Thu, 2025-08-28 at 18:12 +0530, Harshvardhan Jha wrote:
> > > Is it possible to get this merged in 6.17? I have tested this and
> > > the
> > > LTP tests pass.
> >=20
> > After much thought, I think I'd rather just revert the commit that
> > caused the issue. I'll work on an alternative for the 6.18
> > timeframe
> > instead.
>=20
> That seems reasonable - thanks.=C2=A0 I'd be curious to know what the
> original issue was.=C2=A0 I'm guess it was CLOSE blocking ??
>=20

A customer of ours was seeing the NFS flush-on-close hanging after the
process itself had been killed. So the patch was really intended to
address the problem of signalled threads. The fact that it also
affected ordinary processes that rely on exit() to close the file
descriptors was due to a brain fart on my part.

> If you do revert, would you consider the following?=C2=A0 I wrote it a
> while
> ago but it became irrelevant with the patch that you might now
> revert.
>=20
> I wonder if it would make sense for some part of bit_wait() (or
> rpc_wait_bit_killable()) to warn if waiting in TASK_KILLABLE when
> PF_EXITING is set.

What I've been thinking is that for a process in the PF_EXITING state,
we might automatically set RPC_TASK_TIMEOUT on any new RPC calls. The
main problem with that is that it could cause loss of data, since
ETIMEDOUT is a fatal error. So perhaps a new flag similar to
RPC_TASK_TIMEDOUT, but that instead sets EINTR?

The reason for doing that rather than changing the wait, is that when
everything is working correctly, we might want to allow the exiting
process to wait for a very large file flush to complete. It's only when
the RPC calls themselves start to hang due to the server being
unavailable, that we want to actually pull the plug.

>=20
> Thanks,
> NeilBrown
>=20

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


Return-Path: <linux-nfs+bounces-9231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEDA1276B
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACD63A1399
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14F144D1A;
	Wed, 15 Jan 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncso5VyH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3386348
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954898; cv=none; b=Ik9fsBA+gD75XC3cTMiUcRvCdsg26rN4Yao6uyiVH/LAdHLl7/adLfKxm7v8dTE/VO9CBbPxyhiEonIkM2OsBNMsVUrCy5/KampiOwMKVtePE3oSibrVzi8F7PK1wUhEuBIVCfdP63wcqyTA0eYXgoRoyghwzNNbzcZ9YdKiyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954898; c=relaxed/simple;
	bh=Nta6X5JcLUBcKeMSk1aK121t+/nWGRCXXRyJpXcD60k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ERx2DdBfZ7QuQWIDhD6nm9BCmsPXIk975NPFNZqgwOrkAIOWj1AOp0DkViDQmoQfUEAJn1zwP/5/nXtlbmTV9gsJqejejQBHfXpW3DTrhdQA/LVRjVRMI4kfC6teU4yHaAa99oPdsDaY9Ieatfa3ObC3uGwWBlr0V3zOZ5MkU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncso5VyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4974FC4CEE1;
	Wed, 15 Jan 2025 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736954896;
	bh=Nta6X5JcLUBcKeMSk1aK121t+/nWGRCXXRyJpXcD60k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ncso5VyHwkTicKNPGsEVnO+bwrQvFPbLQFbUKGCef8cBrZAHGQ7KZShgkbp+tZq8e
	 9tyvfDMkzzNdTg7OCxFJt7HSJ9nfHnsgjCv46GP1VlAeYAv9KyT98AeH7DNkLNuc2p
	 gaIbtGkbiTwWyt8w6drYxwRc24/OioeVNfElYOj36A7iqBBrZ/yp+/FGA+nOeEdmW8
	 p8giROotW0m+PZPaGpLulwSrf6YytQPxyckZ/9QruJRs8gHO9kyqvlcNMyFHlFeLr0
	 GcdjJYZzNSn/WHVVN/8qR22JvzWZk4KBO50Be45MYSgbZ7lH0DbYni69zaJEhPKQje
	 d5cWM6imuUAFw==
Message-ID: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
Subject: Re: [PATCH v2 0/3] nfsdctl: add support for new lockd configuration
 interface
From: Jeff Layton <jlayton@kernel.org>
To: Steve Dickson <steved@redhat.com>, Scott Mayhew <smayhew@redhat.com>
Cc: Yongcheng Yang <yoyang@redhat.com>, linux-nfs@vger.kernel.org
Date: Wed, 15 Jan 2025 10:28:15 -0500
In-Reply-To: <532ea7d0-afe9-47c0-8436-6891a4b63da4@redhat.com>
References: <20250110-lockd-nl-v2-0-e3abe78cc7fb@kernel.org>
	 <Z4bScYOgDwbpyXjt@aion>
	 <659d6f0153daf83ebfcad8d7bdb80adb6aa319b5.camel@kernel.org>
	 <Z4fJz4re4iFyM2FE@aion>
	 <5487afbab2acfe396e1ccc8ba3dfd1256fa00c7b.camel@kernel.org>
	 <532ea7d0-afe9-47c0-8436-6891a4b63da4@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-15 at 10:12 -0500, Steve Dickson wrote:
>=20
> On 1/15/25 9:56 AM, Jeff Layton wrote:
> > On Wed, 2025-01-15 at 09:44 -0500, Scott Mayhew wrote:
> > > On Tue, 14 Jan 2025, Jeff Layton wrote:
> > >=20
> > > > On Tue, 2025-01-14 at 16:09 -0500, Scott Mayhew wrote:
> > > > > On Fri, 10 Jan 2025, Jeff Layton wrote:
> > > > >=20
> > > > > > v2 is just a small update to fix the problems that Scott spotte=
d.
> > > > > >=20
> > > > > > This patch series adds support for the new lockd configuration =
interface
> > > > > > that should fix this RH bug:
> > > > > >=20
> > > > > >      https://issues.redhat.com/browse/RHEL-71698
> > > > > >=20
> > > > > > There are some other improvements here too, notably a switch to=
 xlog.
> > > > > > Only lightly tested, but seems to do the right thing.
> > > > > >=20
> > > > > > Port handling with lockd still needs more work. Currently that =
is
> > > > > > usually configured by rpc.statd. I think we need to convert it =
to
> > > > > > use netlink to configure the ports as well, when it's able.
> > > > > >=20
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > >=20
> > > > > I think the read_nfsd_conf call should be moved out of autostart_=
func
> > > > > and into main (right before the command-line options are parsed).=
  Right
> > > > > now if you enable debugging in nfs.conf, you get the "configuring
> > > > > listeners" and "nfsdctl exiting" messages, but not the "nfsdctl s=
tarted"
> > > > > message.  It's not a big deal though and could be done if additio=
nal
> > > > > debug logging is added in the future.
> > > > >=20
> > > >=20
> > > > That sounds good. We can do that in a separate patch.
> > > >=20
> > > > > Reviewed-by: Scott Mayhew <smayhew@redhat.com>
> > > >=20
> > > > Thanks!
> > >=20
> > > Hey, Jeff.  I was testing this against a kernel without the lockd
> > > netlink patch, and I get this:
> > >=20
> > > Jan 15 09:39:16 systemd[1]: Starting nfs-server.service - NFS server =
and services...
> > > Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl started
> > > Jan 15 09:39:17 sh[1603]: nfsdctl: nfsd not found
> > > Jan 15 09:39:17 sh[1603]: nfsdctl: lockd configuration failure
> > > Jan 15 09:39:17 sh[1603]: nfsdctl: nfsdctl exiting
> > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: knfsd is currently down
> > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: Writing version string to kernel:=
 -2 +3 +4 +4.1 +4.2
> > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET TCP socket.
> > > Jan 15 09:39:17 sh[1601]: rpc.nfsd: Created AF_INET6 TCP socket.
> > >=20
> > > Do we really want it falling back to rpc.nfsd if it can't configure
> > > lockd?  Maybe it should emit a warning instead?
> > >=20
> >=20
> > I thought about that, and I think it's better to error out here.
> >=20
> > Falling back to rpc.nfsd is harmless, and only people who are trying to
> > set the grace period or lockd ports will ever hit this. lockd
> > configuration is a no-op if none of those settings are set.
> >=20
> > > At the very least, NFSD_FAMILY_NAME should no longer be hard-coded in
> > > that "not found" error message in netlink_msg_alloc().
> > >=20
> >=20
> > Yeah, that would be good to fix.
> >=20
>=20
> On a rawhide kernel (6.13.0-0.rc6) the server does
> come up with 'nfsdctl autostart' but with the
> new argument 'nlm' I'm getting
>=20
> $ nfsdctl nlm
> nfsdctl: nfsd not found
>=20

Yeah, that's what Scott pointed out too. We should make that error
message a bit more friendly. It may be a bit before I can get to it. Do
you guys want to propose a patch to fix that?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>


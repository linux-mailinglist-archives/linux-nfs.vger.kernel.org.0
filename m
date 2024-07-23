Return-Path: <linux-nfs+bounces-5018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBC393A36D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7961F23A7B
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164B154BE8;
	Tue, 23 Jul 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFD4ivup"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0D154433
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746820; cv=none; b=kP1bpSTfwIlq1IZRa1FzKGxwAM4ehJBvCBRWXCurez1jw5n9ApU4tR6ltG+DCzEJMhuL6G0sEQ6SEEYnhIM2xN5nn8SBnq8I6IZu1mWCAl2840GR6MyGCuIFxEdsTKX5eyBhXrVpf7enlYQPD+VGodOrHhtRkuMUoz/qKxCrq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746820; c=relaxed/simple;
	bh=sbiejUL7m2hGyKh+nA0uq2pUIy1GdtI/GzU814h8yA8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gN3qYV4XrQB+MBbLQjmT/JS8KnivhIyOWZmIl45DfeVPbVEWkLdvifdV0F9lnEcc7lxcl3BWxN+kvGP6tUtaKJmKfdOCbvUvC451gFiL+H+hQ+JAAGUVjGEDVaP0xqik+C6k2QPK27m0XeBTNl7iATMNIrDm7VHjbB5PafWVKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFD4ivup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4218C4AF09;
	Tue, 23 Jul 2024 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721746820;
	bh=sbiejUL7m2hGyKh+nA0uq2pUIy1GdtI/GzU814h8yA8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=HFD4ivuptHd90LCwirUPsrLk6zuuzHS81W8kafsMJsEQ+hKxS0FxN1oaOHu12hB4f
	 UBcknslmmKcXTVMioXDrsFb2X/nGZBbP8VZKTZcda5GegOph9FmDZJttSQ2Jn1Ygya
	 nfh7Qif3AO0DKWv7BDm7nNK+m3/JS9T11naDMqLHr9QVR5aHIdycpS986XRj6CIFsn
	 0q8SHj9CfBD/VfXFUPkanVrDStN1gKUvqcbDbT5ZfCIHGW/KZ/GeEU08MnOo35VY7P
	 21u0EvpwSXMlD2pNo3ni5rKoMnnCyUHpGwYyG1mrDjergTzgqVVDfAv+Dtz6KTxPD4
	 I/2uTElxS6hgw==
Message-ID: <9b556bf4be06b7200d4912160548aa4a92b04780.camel@kernel.org>
Subject: Re: Limits to number of files opened by remote hosts over NFSv4?
From: Jeff Layton <jlayton@kernel.org>
To: Brian Cowan <brian.cowan@hcl-software.com>, linux-nfs@vger.kernel.org
Date: Tue, 23 Jul 2024 11:00:18 -0400
In-Reply-To: <CAGOwBeW31AThuSLW-aWE0wAz302qaXDaCKCOmmOPjCewB8rkgw@mail.gmail.com>
References: 
	<CAGOwBeW31AThuSLW-aWE0wAz302qaXDaCKCOmmOPjCewB8rkgw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-23 at 10:15 -0400, Brian Cowan wrote:
> I am responsible for supporting an application that opens LOTS of
> files over NFS from a given host, and potentially a few files/host
> from a LOT of clients. We've run into some "interesting" limitations
> from other OS's when it comes to NFSv4...
>=20
> Solaris, for example, "only" allows 10K or so files per NFS export to
> be opened over NFSv4. When you have 2500+ client hosts opening files
> over NFSv4, the Solaris NFS server stops responding to "open" requests
> until an entry in its state table is freed up by a file close. Which
> causes single threaded client processes trying to open said files to
> hang... Luckily we convinced that customer to move the clients back to
> using NFSv3 since they didn't need the additional features of V4.
>=20
> We're also seeing a potential issue with NetApp filers where opening
> too many files from a single host seems to have issues. We're being
> told that DataOnTAP has a per-client-host limit on the number of files
> in the Openstate pool (and not being told what that limit is...) I say
> "potential" since the only report is from things falling apart after
> moving from AIX 7.2 to 7.3 (meaning there is a non-zero chance that
> this is actually an AIX NFS issue). In this case, NFSv3 is not an
> option since NFSv4 ACLs are required...
>=20
> Anyway, as a result, I'm trying to find out if the Linux NFSv4 server
> has a limit on either total number of files, total number of files per
> export, or total files per host.
>=20

An interesting question. There is a practical limit:

Each on-the-wire OPEN takes a stateid, and when we allocate a new one,
we generate its id with an idr hash. That's limited to 2^32 values, so
once you hit that many active stateids you won't be able to create
more.

Note that that includes all stateful objects (open, lock, delegation
and layout stateids), so you may not be able to do that many OPENs
depending on what else is out there.

In principle, we might be able to extend that too, but we'd need some
evidence that someone's workload was hitting that limit.

Beyond that, I can't think of any other limits we might have on being
able to create new stateful objects. I'll chime in again though if I
think of others though.
--=20
Jeff Layton <jlayton@kernel.org>


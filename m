Return-Path: <linux-nfs+bounces-16824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6AC987DA
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F7DA4E2AE2
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213533373A;
	Mon,  1 Dec 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czS9cgjC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0691F461D
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609481; cv=none; b=MhfJwu65iTu/MSXqafAnVwOfjcQUO7hQhoi37mz0Z2MPZpQRBTdPTaWQcbkQSRp2YLvgiAE+ByYS7GGXdLIRgvV5CgRShv7LeufSnbXSnU/vr4kOOZYcZjWOzmsKKOF8U1zE2B1DF4xTGvqf8+uX6Eh+tXSmBg8U+upW/3dNddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609481; c=relaxed/simple;
	bh=kITgaGD+FWQyY2BzAbNS9l0/UyX7RA/Qu4Vp2hyKRXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAs0o56jQBE4d0G9vEJ4UNpmoc++chlB1VFNosrMYinRDo5t1ugYFVvyuicc13vXL0FmXsFrD31HY0W0XgVolpjnVn4R0DjKBZa5q3cJ5B/zPxhP0TvT7USzaMidQcgiBqBdMF/WXb+pmplMsl22/b6NRu9Z/e1YsnlUHy0Ia1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czS9cgjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDE6C116C6;
	Mon,  1 Dec 2025 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764609480;
	bh=kITgaGD+FWQyY2BzAbNS9l0/UyX7RA/Qu4Vp2hyKRXE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=czS9cgjCwSkn1gCfRumgZnHVVCWv9kwc5wxTWgtOgs6No7VSaSgAD5LtF1f5UHp1W
	 Mb54oU/vmJsmGrbQkkDfp9+g0FZ/WYgGB3S8tAmx2W2lv4LsNvO75kI0oIGMw9/odT
	 ps2lCRs+lw+CyZP4cZ0UUXJaqaZh/zUwlvpaTy1Gq54tVDnB9uZh5UmXUd/0Cbsr4p
	 /1U8d+Gf2C8AVb2ET4hpTQnemk82zbHijePPlZdhbpzRguKg/dWCa+FxQ3fIUzfcBT
	 DPXYIoSawk6Ay/yr/urF9rYOoTLHYLxh5nDjEVnRC0qxQKloRg6XarwX3xOg0NPEPv
	 +8RUyso9ybG/Q==
Message-ID: <22defa137c5b30d271a6b76771651ee4346be761.camel@kernel.org>
Subject: Re: [PATCH RFC] NFS: Add some knobs for disabling delegations in
 sysfs
From: Trond Myklebust <trondmy@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org
Date: Mon, 01 Dec 2025 12:17:31 -0500
In-Reply-To: <aS19VL6-SLpejH1r@aion>
References: <20251125001544.18584-1-smayhew@redhat.com>
	 <e49d89f7818c72fb3f7bbb2dd90630394c55c0dc.camel@kernel.org>
	 <aS19VL6-SLpejH1r@aion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-01 at 06:34 -0500, Scott Mayhew wrote:
> On Mon, 24 Nov 2025, Trond Myklebust wrote:
>=20
> > Hi Scott,
> >=20
> > On Mon, 2025-11-24 at 19:15 -0500, Scott Mayhew wrote:
> > > There's occasionally a need to disable delegations, whether it be
> > > due
> > > to
> > > known bugs or simply to give support staff some breathing room to
> > > troubleshoot issues.=C2=A0 Currently the only real method for
> > > disabling
> > > delegations in Linux NFS is via /proc/sys/fs/leases-enable, which
> > > has
> > > some major drawbacks in that 1) it's only applicable to knfsd,
> > > and 2)
> > > it
> > > affects all clients using that server.
> > >=20
> > > Technically it's not really possible to disable delegations from
> > > the
> > > client side since it's ultimately up to the server whether grants
> > > a
> > > delegation or not, but we can achieve a similar affect in
> > > NFSv4.1+ by
> > > manipulating the OPEN4_SHARE_ACCESS_WANT* flags.
> > >=20
> > > Rather than proliferating a bunch of new mount options, add some
> > > sysfs
> > > knobs to allow some of the nfs_server->caps flags related to
> > > delegations
> > > to be adjusted.
> > >=20
> >=20
> > Shouldn't we rather be allowing the application to select whether
> > it
> > wants to request a delegation or not?
> >=20
> > IOW: while there may or may not be a place for a 'big hammer'
> > solution
> > like you propose, should we not rather first try to enable a
> > solution
> > in which someone could add a O_DELEGATION or O_NODELEGATION flag to
> > open() in order to specify what they want.
> >=20
> > That might also allow someone to add an LD_PRELOAD library to add
> > or
> > remove these flags from an existing application's open() calls.
>=20
> Sure, allowing the application to specify whether it wants a
> delegation
> or not would be better... but with open() being governed by POSIX and
> with delegations being an NFS-specific feature, I figured adding open
> flags related to delegations wasn't feasible.=C2=A0 I discussed it with
> Olga,
> and she had the same opinion.=C2=A0 Are we mistaken here?
>=20

O_DIRECT, O_NOATIME, O_PATH and O_TMPFILE are all open modes that are
unsupported by POSIX.
Furthermore, the openat2() system call is designed to be extensible.

> >=20
> > It might also be useful for the directory delegation functionality
> > that
> > Anna and Jeff have been working on...
> >=20
> > Just some food for thought while you're digesting on Thursday :-
> > )...
> >=20

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


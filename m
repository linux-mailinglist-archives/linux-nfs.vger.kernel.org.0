Return-Path: <linux-nfs+bounces-17736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D1D0F3B7
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BFE13041F4D
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Jan 2026 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDFD3164DB;
	Sun, 11 Jan 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSN/ZWvR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C3D50095B
	for <linux-nfs@vger.kernel.org>; Sun, 11 Jan 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768143560; cv=none; b=aKLtO53ghI5D+RlaGERPcqCYZHzTLljfVT1qYHdGvMeajfpzsaplQS6htqwnnimWZDo1gtmKrX1E/NDZ1bEToIw9Jh+LatGaY/CkNZK7m1+d3mbo3L63Idv+PT/NcutWPlkC4Qjs+9/ikdhN86ot0duPbQ7+tOpW0gzjlCrIjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768143560; c=relaxed/simple;
	bh=Xjs4YYupb7quvKsLmSb8POXcywEVOWl/DFxfoRbPZRM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMvaijBqYrI2aY1+1ECq1iKM7/x1N/RNgGQf3nby88cb9QnxEQ+4dFBXubF6pHGBuPRl2EPiqbP+QZS9mNiLiL3f3jRUuTq9YKXYSurefVnnG6/kgyWorc0DYQcTtRlDT5Yqg9LtvExV3BjcKeR3P5DbrRS9uifqgnZjdP/ka48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSN/ZWvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6664C4CEF7;
	Sun, 11 Jan 2026 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768143560;
	bh=Xjs4YYupb7quvKsLmSb8POXcywEVOWl/DFxfoRbPZRM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hSN/ZWvR5jnAG6AiV0iVld98v8cB/jwjxYhhaO76WBglibd4aAYQqKm+QN87s+ATi
	 xEnhZk0zy4ysY+NERT/fHXeBPspxRXi7oMxbe1cQghLOh9Qm+TqrDxF14ReQSJZtmF
	 u0+8hnYkW4Ca+6zVWKAPIs81mfd41XIZDa6JD+tLolUNX8YA24bZEZeElmIK2EpmWv
	 mXdUDCiPaqSxhPB2lMv23KIEXY2jaEcETgf/8ruq9Z6KbMa3KLGDSLWqvg50MJTZS7
	 4DpBCwSh/RwNDdj4UOHiJTn6I5aoOI/3dR+pqpzCGhGs0F0xL5+wofYi0B0jINweMl
	 7JNmpQVJ4vYWw==
Message-ID: <2cd124cf89a2fad61d040c9bec400a86048244ad.camel@kernel.org>
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
From: Trond Myklebust <trondmy@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>, 
	linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Date: Sun, 11 Jan 2026 09:59:18 -0500
In-Reply-To: <391d9e32-afef-4b1c-adf9-422204360c77@nvidia.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
	 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
	 <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
	 <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
	 <211e07b8129353fbec59b44f4859ce22947f222b.camel@kernel.org>
	 <391d9e32-afef-4b1c-adf9-422204360c77@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-11 at 09:03 +0200, Mark Bloch wrote:
> Hi Trond,
>=20
> On 11/01/2026 2:24, Trond Myklebust wrote:
> > Hi Mark,
> >=20
> > On Mon, 2026-01-05 at 10:20 -0500, Trond Myklebust wrote:
> > >=20
> > > OK so if I'm understanding correctly, this is organised as ext4
> > > partitions that are stored in qcow2 images that are again stored
> > > on a
> > > NFSv4.2 partition.
> > >=20
> > > Do these qcow2 images have a file size that is fixed at creation
> > > time,
> > > or is the file size dynamic?
>=20
> The file size is dynamic (with a fixed maximum of 35 GB).
>=20
> > > Also, does changing the "discard" option from "unmap" to "ignore"
> > > make
> > > any difference to the outcome?
>=20
> The discard option is already set to "ignore" in the image.
> Do you want us to test the other options just to see if it makes
> a difference?

I believe in your previous email you had it set as "unmap":

{"driver":"file","filename":"/images/.libvirt/linux-VAGRANTSLASH-
upstream_Z.img","node-name":"libvirt-2-storage","auto-read-
only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-2-
format","read-only":true,"driver":"qcow2","file":"libvirt-2-
storage","backing":null} -blockdev
{"driver":"file","filename":"/images/.libvirt/Y.img","node-
name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}

However if you've already tested with "ignore" and it didn't make a
difference then let's not worry about it.

>=20
> >=20
> > I've been staring at this for several days now, and the only
> > candidate
> > for a bug in the NFS client that I can see is this one. Can you
> > please
> > check if the following patch helps?
>=20
> Thanks for the patch, I'll let the team dealing with the issue know
> and let them test the patch.
> I'll update once I know anything.

Thanks!
--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


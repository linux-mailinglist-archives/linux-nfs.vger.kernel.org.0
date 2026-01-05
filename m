Return-Path: <linux-nfs+bounces-17449-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 831B0CF464A
	for <lists+linux-nfs@lfdr.de>; Mon, 05 Jan 2026 16:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 058C63196770
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jan 2026 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D40318152;
	Mon,  5 Jan 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc+kBwFU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527F306B12
	for <linux-nfs@vger.kernel.org>; Mon,  5 Jan 2026 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626408; cv=none; b=PNZFP6UI18CrUERzMJZr3jt5hdlnA00lqF/IhJhRM1Ia1LLb/7czAn0SweIFNO01loJ2DB4wxnFB/8FG12/AEqVGsUMc6BbOnR6isjHF9dgNd9K9yJwGw+75k3XpxMxF5jVtF5LfGbv6sHR7LbTRBczLtwGtpeie3Fxe+4Tee5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626408; c=relaxed/simple;
	bh=II4ENe3RCdJDU1xiCytrvuH++J16LCcIuRTugKUruZk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ceaf52uvzbgwqbv/NSnU4FGd7VLcYAkgfjJs4sb5ompDBklKW9yAcOW1DkNPCJbiVtvx1vDZFLcjNixwX1qVT6sGeA9JWZzfIcsQRltxnEmDHPTZ4WbRx1UVGVPeqiMfApVf9VrNoEvtDWhAUjYPw7vqlGhOmiRzo6U1AX66H8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc+kBwFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61F7C116D0;
	Mon,  5 Jan 2026 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767626404;
	bh=II4ENe3RCdJDU1xiCytrvuH++J16LCcIuRTugKUruZk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Dc+kBwFUP7ZJSzkNankEjakWRXmOKIAbOMG1KjlsMg0fM6wzo/vREuUjbthvEFseX
	 raLizA9QpeFuGoszZjC9BctJYZoAkAB55AmiiobG5cJGgSAQBrfEUqcueSLsvymutR
	 8KSeMpllb/XLnyv0nsj9enWEyc6MI4i3dtuop+GBwXmjnkcPuCt2Ag7u0DACwOEXz6
	 +JPkwIBvHbUQpa1COGF/6B+LVkT9yWNdypROAnzp0a7DKdnc2TvHeVkBiCWZcAhkX4
	 dnCOWjN0XajIU+Hxxn3YdSh30ZQ/wJ9cdHLFj2AbCe1202XuR0yCcBNgAQE7SXNg29
	 2EwUtt5WZsx1g==
Message-ID: <d6419d6b1e24c2a704a44f6347bfcfa59fa195c2.camel@kernel.org>
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
From: Trond Myklebust <trondmy@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>, 
	linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Date: Mon, 05 Jan 2026 10:20:02 -0500
In-Reply-To: <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
	 <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
	 <3e7d4222-9326-4761-819f-114831919c80@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 16:00 +0200, Mark Bloch wrote:
>=20
>=20
> On 04/01/2026 17:36, Trond Myklebust wrote:
> > On Sun, 2026-01-04 at 11:16 +0200, Mark Bloch wrote:
> > > Hi Trond,
> > >=20
> > > We=E2=80=99ve recently started seeing filesystem issues in our intern=
al
> > > regression runs, and we were able to bisect the problem down to
> > > the following commit:
> > >=20
> > > commit b1817b18ff20e69f5accdccefaf78bf5454bede2
> > > Author: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Date:=C2=A0=C2=A0 Thu Sep 4 18:46:16 2025 -0400
> > >=20
> > > =C2=A0=C2=A0=C2=A0 NFS: Protect against 'eof page pollution'
> > >=20
> > > =C2=A0=C2=A0=C2=A0 This commit fixes the failing xfstest 'generic/363=
'.
> > >=20
> > > =C2=A0=C2=A0=C2=A0 When the user mmaps() an area that extends beyond =
the end of
> > > file, and
> > > =C2=A0=C2=A0=C2=A0 proceeds to write data into the folio that straddl=
es that
> > > eof,
> > > we're
> > > =C2=A0=C2=A0=C2=A0 required to discard that folio data if the user ca=
lls some
> > > function that
> > > =C2=A0=C2=A0=C2=A0 extends the file length.
> > >=20
> > > =C2=A0=C2=A0=C2=A0 Signed-off-by: Trond Myklebust
> > > <trond.myklebust@hammerspace.com>
> > >=20
> > >=20
> > > After this change, we intermittently see EXT4 checksum-related
> > > errors
> > > during boot.
> > > A representative dmesg excerpt is below:
> > >=20
> > > =C2=A0[ 1908.365537] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1908.375449] EXT4-fs error (device vda2):
> > > __ext4_find_entry:1624:
> > > inode #263414: comm updatedb: checksumming directory block 0
> > > =C2=A0[ 1908.382985] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1908.389289] EXT4-fs error (device vda2):
> > > __ext4_find_entry:1624:
> > > inode #263414: comm updatedb: checksumming directory block 0
> > > =C2=A0[ 1909.598811] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #423753: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1909.604308] EXT4-fs error (device vda2):
> > > htree_dirblock_to_tree:1051: inode #423753: comm updatedb:
> > > Directory
> > > block failed checksum
> > > =C2=A0[ 1909.958470] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #423759: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1909.963825] EXT4-fs error (device vda2):
> > > htree_dirblock_to_tree:1051: inode #423759: comm updatedb:
> > > Directory
> > > block failed checksum
> > > =C2=A0[ 1909.985956] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #303617: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1909.991371] EXT4-fs error (device vda2):
> > > __ext4_find_entry:1624:
> > > inode #303617: comm updatedb: checksumming directory block 0
> > > =C2=A0[ 1910.156415] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #423761: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1910.161959] EXT4-fs error (device vda2):
> > > htree_dirblock_to_tree:1051: inode #423761: comm updatedb:
> > > Directory
> > > block failed checksum
> > > =C2=A0[ 1910.171364] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #423735: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1910.177292] EXT4-fs error (device vda2):
> > > htree_dirblock_to_tree:1051: inode #423735: comm updatedb:
> > > Directory
> > > block failed checksum
> > > =C2=A0[ 1910.267721] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #423744: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1910.281838] EXT4-fs error (device vda2):
> > > htree_dirblock_to_tree:1051: inode #423744: comm updatedb:
> > > Directory
> > > block failed checksum
> > > =C2=A0[ 1910.476906] EXT4-fs warning (device vda2):
> > > ext4_dirblock_csum_verify:375: inode #423751: comm updatedb: No
> > > space
> > > for directory leaf checksum. Please run e2fsck -D.
> > > =C2=A0[ 1910.482403] EXT4-fs error (device vda2):
> > > htree_dirblock_to_tree:1051: inode #423751: comm updatedb:
> > > Directory
> > > block failed checksum
> > >=20
> > > The issue has so far only been observed in tests that use a
> > > nested VM
> > > setup.
> > > It does not reproduce deterministically, roughly half of the
> > > nested
> > > VM boots trigger the problem.
> > >=20
> > > Would you mind taking a look or pointing us in the right
> > > direction?
> > > Please let us know if additional information, testing,
> > > or instrumentation would be helpful.
> > >=20
> > > Thanks,
> > > Mark
> >=20
> > I'm having trouble seeing how those issues can be related unless
> > ext4
> > and NFS are somehow sharing the same folios. Does reverting just=20
> > commit b1817b18ff20 and b2036bb65114 actually fix the ext4 problem?
>=20
> Yes, after reverting those two commits we no longer can reproduce it.
>=20
> >=20
> > What does "nested VM" mean in this situation, and what is the
> > storage
> > for the ext4 filesystem that is being corrupted?
> >=20
>=20
> Probably should have explained better, let me do that now.
> Say we have host A.
> On host A we run VM B.
> Inside VM B we run VM C.
>=20
> Inside VM B we have a mount (nfs one)
> X:/images/.libvirt on /images/.libvirt type nfs4
> (rw,relatime,vers=3D4.2,rsize=3D1048576,wsize=3D1048576,namlen=3D255,hard=
,fat
> al_neterrors=3Dnone,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clienta=
ddr=3DY,
> local_lock=3Dnone,addr=3DX)
>=20
> which holds the .img files. We launce QEMU with something like this:
>=20
> {"driver":"file","filename":"/images/.libvirt/linux-VAGRANTSLASH-
> upstream_Z.img","node-name":"libvirt-2-storage","auto-read-
> only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-2-
> format","read-only":true,"driver":"qcow2","file":"libvirt-2-
> storage","backing":null} -blockdev
> {"driver":"file","filename":"/images/.libvirt/Y.img","node-
> name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
>=20
> inside VM C, it's a regular ext4 mount:
> /dev/vda2 on / type ext4 (rw,relatime)
>=20
> Mark
>=20

OK so if I'm understanding correctly, this is organised as ext4
partitions that are stored in qcow2 images that are again stored on a
NFSv4.2 partition.

Do these qcow2 images have a file size that is fixed at creation time,
or is the file size dynamic?
Also, does changing the "discard" option from "unmap" to "ignore" make
any difference to the outcome?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


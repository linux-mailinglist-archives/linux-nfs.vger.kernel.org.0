Return-Path: <linux-nfs+bounces-17433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0ECF11B9
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 16:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBB83007267
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jan 2026 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84226F288;
	Sun,  4 Jan 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXl9+wOl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5526ED41
	for <linux-nfs@vger.kernel.org>; Sun,  4 Jan 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767541010; cv=none; b=UoKhuzwkgDbSCQpgFYGRPEms8v2FSFfpJwZMHr+7/uKa4WPUM14QD6yAt4e23Cxm00QYL40SjAX9mVNUZ1Yrya5Zxyw+gwCkaLElHlBUtwprZgqG4d3iOOSZxms2tYyZNYZL42zrjHxJygz6zdB7Ye5ogmFC5PR93eu3MYgWUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767541010; c=relaxed/simple;
	bh=hIgu4FAjsSL6HZFXgdjEX7xf9ozKV9cpQtmHqyFXYM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjYfdzcLnXHN63++CtWSju3TVdmjz7ewQHQ5DzRdbvlIXic/6jT22FFWoNrqk1dTuipH61G01TXeiKEt7k48PcmRn3x6pnmSGddWqW9q5fHWfJB1HZFxVmpMugoWEN+lbmVUaGr/gr2gnTeBkVBhygEZMaEfA507rs/j1Z7K/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXl9+wOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A74C4CEF7;
	Sun,  4 Jan 2026 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767541010;
	bh=hIgu4FAjsSL6HZFXgdjEX7xf9ozKV9cpQtmHqyFXYM8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nXl9+wOlvTrbpETL1DZSpiaEO1DBdPaHFUSti6WSoLxZrmgNhqGclC/EGOra5+Yng
	 b97vxmChrXCseaqGuZlcx+twA8PGPjzA4wEyy8PkhSgIS4k2ZtGR5wnYHB72hMG1zf
	 qZPIkgiuEpgl9M65lQQ/C+gqVno2pQ+ZmFacNpsuSNMkofwECnlpWRmvT8dcSxRW6B
	 BnSKiOKstFLDP1l2dzjtPxbHgXZSwCz/di96q5X08YcHJO+sTMOhX+OYv2DmVkmT+D
	 rmLCwmOD+0ZNlkEZUpYqNk1VjH1fPGEt0Gg3yaip2o3amwQqIcp8LHjNwO4FQzg466
	 a6+1Q+iouN9UA==
Message-ID: <43278ef7e260f46de5a7130331f30e12b916f89a.camel@kernel.org>
Subject: Re: Possible regression after NFS eof page pollution fix (ext4
 checksum errors)
From: Trond Myklebust <trondmy@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Linoy Ganti <lganti@nvidia.com>, Bar Friedman <bfriedman@nvidia.com>, 
	linux-nfs@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Date: Sun, 04 Jan 2026 10:36:48 -0500
In-Reply-To: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
References: <447f41f0-f3ab-462a-8b59-e27bb2dfcbc0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-04 at 11:16 +0200, Mark Bloch wrote:
> Hi Trond,
>=20
> We=E2=80=99ve recently started seeing filesystem issues in our internal
> regression runs, and we were able to bisect the problem down to
> the following commit:
>=20
> commit b1817b18ff20e69f5accdccefaf78bf5454bede2
> Author: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date:=C2=A0=C2=A0 Thu Sep 4 18:46:16 2025 -0400
>=20
> =C2=A0=C2=A0=C2=A0 NFS: Protect against 'eof page pollution'
>=20
> =C2=A0=C2=A0=C2=A0 This commit fixes the failing xfstest 'generic/363'.
>=20
> =C2=A0=C2=A0=C2=A0 When the user mmaps() an area that extends beyond the =
end of
> file, and
> =C2=A0=C2=A0=C2=A0 proceeds to write data into the folio that straddles t=
hat eof,
> we're
> =C2=A0=C2=A0=C2=A0 required to discard that folio data if the user calls =
some
> function that
> =C2=A0=C2=A0=C2=A0 extends the file length.
>=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Trond Myklebust <trond.myklebust@hammer=
space.com>
>=20
>=20
> After this change, we intermittently see EXT4 checksum-related errors
> during boot.
> A representative dmesg excerpt is below:
>=20
> =C2=A0[ 1908.365537] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1908.375449] EXT4-fs error (device vda2): __ext4_find_entry:1624:
> inode #263414: comm updatedb: checksumming directory block 0
> =C2=A0[ 1908.382985] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #263414: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1908.389289] EXT4-fs error (device vda2): __ext4_find_entry:1624:
> inode #263414: comm updatedb: checksumming directory block 0
> =C2=A0[ 1909.598811] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #423753: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1909.604308] EXT4-fs error (device vda2):
> htree_dirblock_to_tree:1051: inode #423753: comm updatedb: Directory
> block failed checksum
> =C2=A0[ 1909.958470] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #423759: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1909.963825] EXT4-fs error (device vda2):
> htree_dirblock_to_tree:1051: inode #423759: comm updatedb: Directory
> block failed checksum
> =C2=A0[ 1909.985956] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #303617: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1909.991371] EXT4-fs error (device vda2): __ext4_find_entry:1624:
> inode #303617: comm updatedb: checksumming directory block 0
> =C2=A0[ 1910.156415] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #423761: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1910.161959] EXT4-fs error (device vda2):
> htree_dirblock_to_tree:1051: inode #423761: comm updatedb: Directory
> block failed checksum
> =C2=A0[ 1910.171364] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #423735: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1910.177292] EXT4-fs error (device vda2):
> htree_dirblock_to_tree:1051: inode #423735: comm updatedb: Directory
> block failed checksum
> =C2=A0[ 1910.267721] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #423744: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1910.281838] EXT4-fs error (device vda2):
> htree_dirblock_to_tree:1051: inode #423744: comm updatedb: Directory
> block failed checksum
> =C2=A0[ 1910.476906] EXT4-fs warning (device vda2):
> ext4_dirblock_csum_verify:375: inode #423751: comm updatedb: No space
> for directory leaf checksum. Please run e2fsck -D.
> =C2=A0[ 1910.482403] EXT4-fs error (device vda2):
> htree_dirblock_to_tree:1051: inode #423751: comm updatedb: Directory
> block failed checksum
>=20
> The issue has so far only been observed in tests that use a nested VM
> setup.
> It does not reproduce deterministically, roughly half of the nested
> VM boots trigger the problem.
>=20
> Would you mind taking a look or pointing us in the right direction?
> Please let us know if additional information, testing,
> or instrumentation would be helpful.
>=20
> Thanks,
> Mark

I'm having trouble seeing how those issues can be related unless ext4
and NFS are somehow sharing the same folios. Does reverting just=20
commit b1817b18ff20 and b2036bb65114 actually fix the ext4 problem?

What does "nested VM" mean in this situation, and what is the storage
for the ext4 filesystem that is being corrupted?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


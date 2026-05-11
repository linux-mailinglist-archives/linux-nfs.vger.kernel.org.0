Return-Path: <linux-nfs+bounces-21467-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEgbKqjjAWoEmAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21467-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:11:52 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BC50FD1A
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B8F5304638E
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1BF3FADE5;
	Mon, 11 May 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foKLY5sK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E13F7896;
	Mon, 11 May 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508171; cv=none; b=aiKjwl/cX/mv0TuS+oAcJD5sqgN1InEEBWhR4UESh1YbT7BphbrN3JXilS5WoNzhYxq4k2uf4GCWok1dOlRW4EA8g0KCeS136mE5mzcbxX+QGgaiBWDgkQYdut7OquYb9AAWx8LQxKC2lsW18aY5lkjOvGbDbbPH+sW9SYXBKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508171; c=relaxed/simple;
	bh=0UpJUGzPjFdRF+kzA5dFbDzrBSNpqPmuECOqes5zOLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9dmdrNQarRVn/vqoEq/zZV7yONM2GvxSR9SxQiT1Vaon2ba8VcQAxQXCZY133UYY3UFLhY8Qrh10uispJlTsOMyJWqi00/CnaOWK0ivde2iQCIs5YBMoAoocgkPBVTv+vOzhAfJNGeDlBprSlsJvXwjwCW9f8IZllFdArwPm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foKLY5sK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A9CC2BCB0;
	Mon, 11 May 2026 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508171;
	bh=0UpJUGzPjFdRF+kzA5dFbDzrBSNpqPmuECOqes5zOLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foKLY5sKZ8pQXRuGHvimXnKVPDHujO7i9DUihew18ywt0UUkKvpcWEQ+GENjB0qNO
	 NgxndUmM3WbrU08K5mm4wnFTJzeITiV9PHxDxNnq613Oo6dgzvUTfJ4/75GXQsn15r
	 NJlH33gFSvNWgiZUBBYLjmXsJCL/6Obf0osLgh9dqAWq2pC9UmW+zvU5SZ3p1gFd4H
	 9NTj/zHhF5SO3FGYLW42EKJjAe385+WS/DGrVUPgWh3nDkDhNJFaBUjjA4e2Hgsvor
	 uPWR9IEwYD3MjdS9lV9YT2EinL9WsEwAuTWPBfysgN3ObitBAk5eEIS1jm4hwLXEn6
	 xgJjFWUK5GBCA==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Roland Mainz <roland.mainz@nrubsig.org>,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
Date: Mon, 11 May 2026 16:02:31 +0200
Message-ID: <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
C: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=brauner@kernel.org; h=from:subject:message-id; bh=0UpJUGzPjFdRF+kzA5dFbDzrBSNpqPmuECOqes5zOLs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxPmzoE7cS0pi4htne4BtrZubeg2uf/OBf+WBFQOp93 w71crk5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMp2cbIMEfiXshT9YRVMeHy 0dt39r6+sDHh9aLmwo1tk7ifh+3OYWNk+HUvYr/S77VKu596N6437xR9oNG88+uX37/zSzhErP7 +YAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D4BC50FD1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21467-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,nrubsig.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
> Christian, let's lock this one in. I will post subsequent changes
> as delta patches.
> 
> Following on from:
> 
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> 
> [...]

Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.exportfs

[01/15] fs: Move file_kattr initialization to callers
        https://git.kernel.org/vfs/vfs/c/9d3942fa6a55
[02/15] fs: Add case sensitivity flags to file_kattr
        https://git.kernel.org/vfs/vfs/c/72504a889e52
[03/15] fat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/d0d06cfce960
[04/15] exfat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/64a4f2090cb2
[05/15] ntfs3: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/5fff53318cbf
[06/15] hfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/1b25c01375e0
[07/15] hfsplus: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/b9e976dd58ff
[08/15] xfs: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/30617d630d2f
[09/15] cifs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/0f372b05c80c
[10/15] nfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/3ca9954cdc04
[11/15] vboxsf: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/0f5f23d411ac
[12/15] isofs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/d56f6094035c
[13/15] nfsd: Report export case-folding via NFSv3 PATHCONF
        https://git.kernel.org/vfs/vfs/c/5ca2c8f14428
[14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
        https://git.kernel.org/vfs/vfs/c/62c9555937ca
[15/15] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
        https://git.kernel.org/vfs/vfs/c/35188379f010


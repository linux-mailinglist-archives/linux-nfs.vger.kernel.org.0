Return-Path: <linux-nfs+bounces-21473-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLImMzDuAWpHmQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21473-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:56:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1902510ADD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 16:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C2FF3002B1F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D93B401A01;
	Mon, 11 May 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrsxxS6T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16D3FFADC;
	Mon, 11 May 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511402; cv=none; b=asLXdIO0yo2kxZwWiathP4+DFEdHOC5rDf1rBoTfpFKnFqD1RpY0EnBN2WX56oTNs9K7qxcEp/DTGwWr4pQWH2rZy9YHOXkZYaN54P7l/epqYDV/Uaw9RrJVxNkx9nHSt9RepUHb+oEQTVF5Gxkj6ynN7XUtBGNYMftHUhHGs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511402; c=relaxed/simple;
	bh=RbMFSQRfHlsC61fn89QVW4CaFzV0E4rdaOIbFWO+Bzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jpzjd+VagFE0lcyaXJWVTAGXqGn4Qtda2ZZSiXAoQfqhHMS+woHf2wCa0Zp0zoTlsvvGLZ0jEICI+EX0tvsAzfN9HPdtW0X2/OlV0M+mu7nKGSNV5L5WbOB1rpzIVWNjKHnfenKmcwyDVPihas8td5GyPWVFkeCpCMhLlzOHoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrsxxS6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8561DC2BCB0;
	Mon, 11 May 2026 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511401;
	bh=RbMFSQRfHlsC61fn89QVW4CaFzV0E4rdaOIbFWO+Bzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrsxxS6T6cY3TjCGu6OHQPrsLAOetrh6sLmIpD/hrlJl96QfexJKThlojmYOCSTAU
	 /qHcK2fzEFC0oYhzm05gYE5qDnwlffSx8Gl+CqaGv5tgy3A7vRMdxsGEu3OnM84ymS
	 Gn4Rg5EeYTMO1nGC5kroP+VBEu+opZFuUr3A9rzP0mSnHVt2gVkzsEzyjxcKHDxrSC
	 GuYYGhy2A1JTdwhBpZPqIViHt4RHQesh62EM9BJWb3bDCmlkBW4/ci7W1G0HSgyALC
	 yFqs4oGsJhc9QSVCc8QXQqXx3fJcMHcsWwCgO8wGV301WDDEA9+QgbVDx6mi3rE9Zk
	 4fDN3Fp6oD7iA==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
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
Date: Mon, 11 May 2026 16:55:36 +0200
Message-ID: <20260511-verglast-abtropfen-f5fe2ccc79ba@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2780; i=brauner@kernel.org; h=from:subject:message-id; bh=RbMFSQRfHlsC61fn89QVW4CaFzV0E4rdaOIbFWO+Bzs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxvpPbtsTxReIhiawSkz4fxtPZ528qMl/imcesmKL13 /6nsuz9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlc1GdkmHzU8leE55X+3sNn 78m6LK502/+sdc7fo0p/K2XXs3lf+sDI0Gqcuu1Ta8aS/b6pqm89GV3elm66eiFAVePnoS0rlp+ 7zAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A1902510ADD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21473-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,nrubsig.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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

Now on the correct branch and pushed out.

---

Applied to the vfs-7.2.casefold branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.casefold branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: master

[01/15] fs: Move file_kattr initialization to callers
        https://git.kernel.org/vfs/vfs/c/14c3197ecf07
[02/15] fs: Add case sensitivity flags to file_kattr
        https://git.kernel.org/vfs/vfs/c/3035e4454142
[03/15] fat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/c92db2ca726f
[04/15] exfat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/27e0b573dd4a
[05/15] ntfs3: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/eeb7b37b9700
[06/15] hfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/b6fe046c3023
[07/15] hfsplus: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/a6469a15eefe
[08/15] xfs: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/c9da43e4e5c3
[09/15] cifs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/e50bc12f5a36
[10/15] nfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/92d67628a1a9
[11/15] vboxsf: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/ef14aa143f1d
[12/15] isofs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/7bbd51b1d748
[13/15] nfsd: Report export case-folding via NFSv3 PATHCONF
        https://git.kernel.org/vfs/vfs/c/211cb2ba4877
[14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
        https://git.kernel.org/vfs/vfs/c/01ee7c3d2e23
[15/15] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
        https://git.kernel.org/vfs/vfs/c/0164df1d1de7


Return-Path: <linux-nfs+bounces-21092-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJRJDd0e7Gm7UgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21092-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:54:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 208FF464931
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EB6E300B47C
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DE422FF22;
	Sat, 25 Apr 2026 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcm3B2fY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B522E3F0;
	Sat, 25 Apr 2026 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082024; cv=none; b=Sp4FLlXWNE8zGd/gi1Jny/Pmj3WlEVmcoOqExR83uo/DinpMe92o9YI3fSZVq9i5Qnz0InWVv8EUnUnT+KNlIg89MBMLNWuDv0kgiyUqE3+979Od+A0R3+aSlpfPx7rviysoIMO+7QfTY2hw6PgY5BhAJKPAr/hg0bDUWfIyR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082024; c=relaxed/simple;
	bh=McAV5CNKh/R32ZPI5KLOc1CCIaEWTg3RbqF39WjLumM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBf9MIrwY/c04VNqLhtpw1FJt7IutJ9yIemxO0+Q8H6vw6Ri6UnUY9Eu1u5WhIAs+GrbeMDv+9Oa/ijq/PnFryglfo+XtEXBaC11M2OsrtJWopOaJjpmogi0vRU7wWctQ0OYMVsZ4GagWuVqF50NF1aCMNcjBTuPvOVSHoKc1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcm3B2fY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6F5C2BCB5;
	Sat, 25 Apr 2026 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082023;
	bh=McAV5CNKh/R32ZPI5KLOc1CCIaEWTg3RbqF39WjLumM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gcm3B2fYKLJtxa8hvELCu3SPnsWf6ztbABIOOGN9y6Q6Mku3H8vvUvPhEe26cC0Xw
	 Z002rynAe/XRvkHF6aP2PopMkXjR1Wv8hB2mh6JLJsSR79pPLWRTAOMKe2YvL881/L
	 DmHEgCb/DsCfl+V0jk6cYaIteSqEVJU4kF3Avj/Zni2y25qscJdjf21rAVhB8QhduI
	 /WwnIVSD9wmACx2XTUi9Hh6m9KM0iFVtwJKLVypZRpLTk+3lkzTWImU8w84g3bPc9U
	 YqGL0G2wfLBfhf5pTsvQ6DW6aFBKMHH/I07H+7OagTcG7RXH4xVokcYcNmR8isboPy
	 mbCvXANhw3pNg==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:10 -0400
Subject: [PATCH v11 08/15] xfs: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-8-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
 almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
 adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
 hansg@kernel.org, senozhatsky@chromium.org, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=RS1NIQW3n5GlbUoKY0pTlmEy0aDu/j9sxZEq/mBzFA4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6Q6D91o7/MLr7c2zWRs0GCu5gLIEhcOjU7/
 rK0Gf8Oh5yJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l8bkD/kBBqZqXFav38eelQEr/+UzlNvGTeUgVS9X9STU3qv7LpwYVCdXGB8WzzwRr+7Hej9CSTn
 n3jk3qIq5wnKC0c40tNfYadmvQFA9JxWuDuFZe1zukJqTWXuGZ6+Z+Am6LGRRiPOxizUW1C3mJe
 OMYX87ic2p16Ub9McqmRxFhUXXDSfrQtZYiFvm/IBYndrmQNc91C15mMWfM0FvxBosF9lQt+SfK
 3rx4OKRyhtqfqVSED49uc8TSe1ceKHlRJuQdOax3jXSX0jIjPiKB02bF+8uFsB2MtTrn76sMrpD
 jpBv5PdU+/DA2VQyx8u+90lalhH1I99St6XCRyyiCG8VVXO92gaSxMPoN5rO6MxcNre/Hrfb81z
 4wVJncFAXaEbuqWIxo6cMy9og3iNDX8AUddTyemP4Bb6dfBTReddetmqXf7AIf9zzsJGRZU45gz
 GJ84LZLdGAdo9f98rvuXGR8flp4XYcf31g76Z91wIak9nbliy3sPpYJTnmEamYVIT05SK9rXpS0
 wKoSUIjSWxURSsKX8gqaWLjx2LhU8fQGEqqO0j4u3y4cUSD5CcfMgtIvJVTTN33tpa95F5Dm3x5
 A1z+nafZOiH7XEptWSI4JDpBsozEa2cexJwB/fbN1SYaLj7g3Dj67cuNaWO7HFXSGn/GgwKy6PA
 jpxvjWyTsmCFx7w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 208FF464931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21092-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nrubsig.org:email,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem
is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
when the filesystem is formatted with the ASCIICI feature
flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr() in
xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates bs_xflags
directly from xfs_ip2xflags()), so bulkstat consumers and per-inode
queries see a consistent view of the filesystem's case-folding
behavior.

XFS always preserves case. XFS is case-sensitive by default, but
supports ASCII case-insensitive lookups when formatted with the
ASCIICI feature flag.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/libxfs/xfs_inode_util.c | 2 ++
 fs/xfs/xfs_ioctl.c             | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 551fa51befb6..82be54b6f8d3 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -130,6 +130,8 @@ xfs_ip2xflags(
 
 	if (xfs_inode_has_attr_fork(ip))
 		flags |= FS_XFLAG_HASATTR;
+	if (xfs_has_asciici(ip->i_mount))
+		flags |= FS_XFLAG_CASEFOLD;
 	return flags;
 }
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ed9b4846c05f..5a58fb0bad2b 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -472,6 +472,13 @@ xfs_fill_fsxattr(
 
 	fileattr_fill_xflags(fa, xfs_ip2xflags(ip));
 
+	/*
+	 * FS_XFLAG_CASEFOLD is read-only; hide it from the legacy
+	 * flags view so chattr's RMW cycle does not pass it back to
+	 * xfs_fileattr_set().
+	 */
+	fa->flags &= ~FS_CASEFOLD_FL;
+
 	if (ip->i_diflags & XFS_DIFLAG_EXTSIZE) {
 		fa->fsx_extsize = XFS_FSB_TO_B(mp, ip->i_extsize);
 	} else if (ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT) {

-- 
2.53.0



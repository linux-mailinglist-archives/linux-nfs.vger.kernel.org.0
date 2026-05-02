Return-Path: <linux-nfs+bounces-21354-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB22EtgI9mlPRwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21354-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DC4B26B1
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1132301D070
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE89F33D4FB;
	Sat,  2 May 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmAH8LNt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFB2820AC;
	Sat,  2 May 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731719; cv=none; b=qJlivWTCk//7f+TLDDHxIrJCGTqk1bftnI4QEzqsZWVA18z4uzBg5tIv1cqFJsiJaymt1sSspXQu7FiXMjO2JVqtAn+ZwWBmYp912IAdO2mLZf9ZfrJk5bamIU90RYm5LKmBqd2vEbRki9ggQdA3jto36DtHd5Sq8XyiumRRra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731719; c=relaxed/simple;
	bh=29KDob7D6wjAqke0cQHbkTiX/VafLuHXAnmywDOdkA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRuatgPkPIcIHPcQwokFWSfM2PTZ/XcGoo4dAamIVGC9C6qGyC1KId9OCAwKGbrbEWQ9JwMLixkhFtcN68UyC3W//YCfwg/JgxFEQmk2NTqtW9Ggvpggw7vOmOwaRUaPUwkRpFzNS7xZc7WgiC2KaAOS5miXqnSBh41fbS+of88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmAH8LNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E196EC2BCC4;
	Sat,  2 May 2026 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731719;
	bh=29KDob7D6wjAqke0cQHbkTiX/VafLuHXAnmywDOdkA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FmAH8LNtbKByp86SJg6x0fidS+VkTFGu0bW9/NNSFNI5WqhOkTIlHBtzHZnldYj3c
	 Vb3S4linM4xGxAzCEJcOaDrpzapSUajChudnmAtENzBp1daDeN2aoQXAKOp8QE+p42
	 dfqzwAETmDdeL+3TiF5vNN0tj6AM0h5K4vONqvsSVcMc8CUqzWLd1DfLL0oWKSWY3J
	 WwMJOI0mZUHHafXQa96y1bBrwDyf1utcpHEpIDCZ2xBdb34J9P0mh8Hse3mI+PPkXl
	 8l+HJmHrxoumrRgitP2dgJor8nFOZAouvvNdZiPLhwKz/R9WUEa2FqHkTNpkjNlO9j
	 ULFcdtjtc11UQ==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:53 -0400
Subject: [PATCH v13 08/15] xfs: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-8-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=5XtPWdQD9rNyvcNieFdC0PM+y6dNjGmJfHpo+ZOq7bw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghRAsLTlbIsdA+q+yJuO2iAN4VgWvZvmcv9Q
 ZLW5iROxxmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 l5UiD/9UbV/FPlFnUrXSyuCt4v5W83BQJok4mszG//V+BeheN0rL63Wd0Pr+wRLBDtTkXigqsRt
 CFVwxRul/9KiGVlYU9bp3XuAbaveJB7hJk9ZJUu9mDz/YJabMwLg+nbVgyzDMHv3Scgq0T7femF
 Tlb0b65fE7kHyhGdUty4r8Cpg24v6lMx4vuplCIz+NOoKXFFMWGvG1Xq1+NZqMGeUjJAafPN9QQ
 PGWEWNWWTw2vtqFRyHAC4Yii7JLO4f2jJqg0/Huvae4hV/rxTUC/MCBCxkjx1iCiLDaIFSdh5Mt
 4RrdI56tNOI7vWv1ryAXgckgzEpc4LXn7LbtQWUoSM9i02WRYyzLxYF4JaSALBIL7E+bCaZ/YPz
 cJvXcs5nxAlJ6QbbnFLifKY+kWCRuidRrL3YRPUtLAaAg4TD5md4u1BYfcGT8qCQWJb6EFjWGOw
 Hz0TK0PIVhshnWEk9p1QGi+d7v831mddYOjWhHhHP0rYwMG5h1Gv1rXVBi8Eh83xQOpPWLTfg6W
 qX6V2FN4+YCuMnDebexsdLcXQ/fs424eqtBoqX+uFghwXRYstTVxcCz1C79pQjJ0V+c54KrYKHi
 ve3MK0sRjisbA5P5Wv6krvDtFxKJhpIMDHlxdZylQMssXEPqGVG+z/H65j8sZmPwB3RX+yyuLPO
 36o7cXziDSrCR0A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: DF4DC4B26B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21354-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem
is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
when the filesystem is formatted with the ASCIICI feature
flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr()
in xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates
bs_xflags directly from xfs_ip2xflags()), so bulkstat consumers
and per-inode queries see a consistent view of the filesystem's
case-folding behavior.

FS_XFLAG_CASEFOLD is read-only: FS_XFLAG_RDONLY_MASK ensures
FS_IOC_FSSETXATTR strips it, and xfs_flags2diflags() has no
clause for CASEFOLD so the on-disk diflags are unaffected.
The legacy FS_IOC_SETFLAGS path in xfs_fileattr_set() also
allows FS_CASEFOLD_FL through its allowlist on ASCIICI
filesystems so that a chattr read-modify-write cycle does
not fail with EOPNOTSUPP.

XFS always preserves case. XFS is case-sensitive by default,
but supports ASCII case-insensitive lookups when formatted
with the ASCIICI feature flag.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/libxfs/xfs_inode_util.c |  2 ++
 fs/xfs/xfs_ioctl.c             | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

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
index ed9b4846c05f..f8216f74679f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -755,9 +755,23 @@ xfs_fileattr_set(
 	trace_xfs_ioctl_setattr(ip);
 
 	if (!fa->fsx_valid) {
-		if (fa->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL |
-				  FS_NOATIME_FL | FS_NODUMP_FL |
-				  FS_SYNC_FL | FS_DAX_FL | FS_PROJINHERIT_FL))
+		unsigned int allowed = FS_IMMUTABLE_FL | FS_APPEND_FL |
+				       FS_NOATIME_FL | FS_NODUMP_FL |
+				       FS_SYNC_FL | FS_DAX_FL |
+				       FS_PROJINHERIT_FL;
+
+		/*
+		 * FS_CASEFOLD_FL reflects the ASCIICI superblock feature,
+		 * a read-only property. Accept it as a no-op so chattr's
+		 * RMW round-trip succeeds; reject any attempt to enable
+		 * it on a non-ASCIICI filesystem. xfs_flags2diflags()
+		 * has no clause for CASEFOLD, so the bit is dropped from
+		 * the on-disk diflags regardless.
+		 */
+		if (xfs_has_asciici(mp))
+			allowed |= FS_CASEFOLD_FL;
+
+		if (fa->flags & ~allowed)
 			return -EOPNOTSUPP;
 	}
 

-- 
2.53.0



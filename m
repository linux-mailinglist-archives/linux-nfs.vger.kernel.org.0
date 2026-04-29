Return-Path: <linux-nfs+bounces-21285-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH7DGLdJ8mnOpQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21285-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:11:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26413498C6A
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEE29302FA17
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D6421EF4;
	Wed, 29 Apr 2026 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwkTphSZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1E34E744;
	Wed, 29 Apr 2026 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486069; cv=none; b=mGa9GKfCL3ZXNyL5e2c0dv51Rgrv4U9hAw5V+BheLLbJQfZaqxkER6dUEH03yIzcU0dJM7nYLRvYvn2QrajJP8wePIw8HlcYbQniEjQfME7oztNRNrGpOJKKyt/EOZibq1s7isLyDD8xP7AfgEyaotCrN0Fu/diUDv/eKqjbo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486069; c=relaxed/simple;
	bh=29KDob7D6wjAqke0cQHbkTiX/VafLuHXAnmywDOdkA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OI4XsOINCHB69bg9gKOmrFRc0rCDvX17Awez+9vv+rOseyJwjr4k6D0Mka/Se553Rx4MF25TJGF8+dojLIkGW6pHTgmlv90VQ5pdfED3DaAbRDNLHyvhkbZWmQMfa0iM8/7Rajx4Z6p3FnDU3Acw5Wr52AEf0AybECBnSztHNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwkTphSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F309EC2BCC7;
	Wed, 29 Apr 2026 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486068;
	bh=29KDob7D6wjAqke0cQHbkTiX/VafLuHXAnmywDOdkA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QwkTphSZuuJKpR7RpMeiB0Di0S7+PZoPDpqd0FtYs5HP+1/knzIVollqTZ8cW55BI
	 WuT6KATac7Yx0AZz5YSTqjbZZ9EJYgaj2YLep++OxB5GNcozJ3iY3Jr5uTxFkxIjA2
	 EIJT3D4GFwEbCreuwEj/+9jUojxfJi5SAMZG9d9hwFE8ZE6nc0HI3XGwc9Ehn+xZmK
	 tkUlIbCLU1PQk+4jK7cbW1kdaBr7oYbEoFigSQZr97cGqrMs0yOuRANxlCyhYGLmTf
	 ob2/HyYyCy35KuTrOVYnrg/16f7POTQiQBRJ52irPH6WK/yr/YQPs86RE8Z4uvWVlu
	 YQ5P+uc7SsbEQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 14:07:19 -0400
Subject: [PATCH v12 08/15] xfs: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-case-sensitivity-v12-8-8057123bebe0@oracle.com>
References: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
In-Reply-To: <20260429-case-sensitivity-v12-0-8057123bebe0@oracle.com>
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
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjdqEdk0DF+qfmnWHi3Vt1gR9qIy7prabuO7
 y3XbV2QW4SJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3QAKCRAzarMzb2Z/
 l4SlD/96LAlavdzmgMVHUOE01QsUJl9DHewg8oTZ6kj7D5SwFJyVufOwx7eMhpu+2WqqW7zOB4G
 Tui0AGnVTOSG1QYr8ICcGePPH3yXcblegpIrxTtnNvrZnbqY3WJOWXBfC81l//kp3wmiCuk9Txf
 y4dHVS3lV4PCpICHSEVgUPVOlr09L7JeZzHg+RkrPbEpKUSISDYP1SpNt4EWT2jcrAdQbGNg2GZ
 ksB/ke9b7Zbz4o9dupEuf+Gy5oKlT6iBQ2+eWPIGOf+MqNh7t2oETxoyf7lDqpA9LNqwgkt7t4r
 KxWln+7KglK5JwsI9s29dy/SbJaDMmdpg+tBDqy+tNNOBBX7icTHKbJ6f6P787oSTOCTz5ob5p/
 CgRvp6rmSD82RxQTzRY6I9ZeNaSA/rk2j6BRIooPFRr5UQ/PSPQtGZyVV7+dEuSbGiB2HPuy/E5
 IfdhsOXlnDPECn5lo7uBwtrtR1+YlJYIbTCZO1VXKr68KBM5j/VP8JS0ks/X6IUnVxT5+CE0GCN
 +WdTlJpNQZXXBHzxZWBlsD6QEmsdOVCo+HpWmZsQCobfyPzngM7zDa5BKVZgFzDy9ZE+CWdPfny
 W3Lv2MGA8y3zBY6rY9toT+Qx7IcEmmvGm2dXYXoJOs5qvqsy6W96pRnTSLJhGohNl65a2FjXM77
 3kGKMtAht4DPLtA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 26413498C6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21285-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

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



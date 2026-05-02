Return-Path: <linux-nfs+bounces-21353-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJXvGsII9mlPRwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21353-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:22:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A524B268B
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF7F302835A
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09833D4FD;
	Sat,  2 May 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGtBLUSF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7CA33AD81;
	Sat,  2 May 2026 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731714; cv=none; b=d9I2jyvanyesQ8YEr/m7t/jj+rhy8r7sZti2x2hD08NWbgL2WFFtaG/onzmHASBatEWxa2Gj8WkJJXDlISYw0oohL2u01A9QkkgLjgPfAA44eJZfp3bFAdQLKQps5I/6oi4Wkqjf87SxRlZptQwF364g1oJRZmoPi2Cm/px4a+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731714; c=relaxed/simple;
	bh=MCKLEZC7Qx1FnQ0cZy8w8gaJqor/Oy2yvhPP57H1cWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruNMcKOCjuZULLrcCjoIpCYUyA9agNBi9F6s3pc/BbFWnqFaxgiSgNN8iy9XW3CwgcZKLVXb2/qiy7mgads7AlULqhxIFk7oZV6zQUrYvmoRiP8t9E/SP+Mc7/S0nNXvzBkakcDbOW0l491DyXT3SfwMY8pxkBhwnwO8jpcg6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGtBLUSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A4AC2BCB3;
	Sat,  2 May 2026 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731713;
	bh=MCKLEZC7Qx1FnQ0cZy8w8gaJqor/Oy2yvhPP57H1cWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iGtBLUSF+6X2+9FyfJCet7RcIGjsQ3/QE4Aelk7z9F9oqSLPGRLUmlD+WDl7G7DQh
	 UZUnxHQt63NbC+WeuPZkxp1xdYeb/qOyNjy7YnE6ULTlNC6EK/Vfe307gS3hJ8KsNx
	 vg7H0N/4BWWW+EIg7RAUdwnhkbiKSSyB3cxCaJziQxhFSEkw5V0ut0EtzW8abXqG63
	 jo+zTkn7De+sC4BD2+XbqsP+WeJCTcyVM+G4/H9PLfN9mWPqMUDY7yIXQDEBCWrlvp
	 I4mvT1CgArb3YDqxqTjldCtRFJF4/Ei+xNd8u3CqVI/nYhejChEYv2m5Y/kcxZdynp
	 nKvV7GCBPmS3g==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:52 -0400
Subject: [PATCH v13 07/15] hfsplus: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-7-aa853140311f@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yr1QdNRA2c3h2NX2KtSKVIgsso0huI4pF/+aMWQ1VYs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQXlTy0BV79mXGcUu0Hfjx8S0jG9arjDr7z
 y6V7cr4KwmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l07AD/9Iq3bdIv0k7pytSc+UdefTTkptZ2WriQF+ImjlXqgQbAMmyNasFaC7/WT2D/RQV7iYcI+
 GE9iydJujgjH5Q5/Ks9Y/zjEf7qZVJQgRW+g0ogLjyYHEY0dPlAuTEuX4+Vx/DuXVubV/N4udMZ
 tksioir7JVT8BNvcoFzL/MtNvTdn8TB5HfSCZU1iEaYYjxMI37lBPrY+odoEg0FeUzw73pYz3fd
 RpphpprtcwAmLS5giRpLc+FFjRKA2Qh7oRZZr9ETpLsl6DUIp50HQiwXW3HvwN87BLu/ElWvik6
 9kT9LJmr9jQxVClZkO991RjXjiepcmQGeKKQB+FMDYd+IWAjl4ppIDim99PfhoaFD8mJKlF4rLI
 56dyyaaktsD3pExexfZmz/nkVyvYfyYymJAv6HmYXlmB0JM0my23hOlS0fezX39q/8uzcOK0HTv
 X3n9vabqmn10QM6fZQP/n1Mx6oW57grHrOV47pOCJKSzI9d+VjqHqCMHZk5CuC6Njb1yckj3mJL
 UbKVHRavZI7n68qX1cxu8xO8uzJJiNFxaQIQv4Yzwp92qVJhBrR/opfxJal/+FTwgvD/Z3yGSYd
 JkUXiIsXCyJAbiLN/6f0ELx0/o1mxhv6JpQ42feNivM7Aijj0WTnWsPI186WOyMBY7fHl6IGS6C
 rGtgsWvnogTc39Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 14A524B268B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21353-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,nrubsig.org:email,dubeyko.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function via the FS_XFLAG_CASEFOLD flag. HFS+ always preserves case
at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

FS_XFLAG_CASEFOLD is read-only: FS_XFLAG_RDONLY_MASK ensures
FS_IOC_FSSETXATTR strips it. The legacy FS_IOC_SETFLAGS path in
hfsplus_fileattr_set() also allows FS_CASEFOLD_FL through its
allowlist on case-insensitive volumes so that a chattr
read-modify-write cycle does not fail with EOPNOTSUPP.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d05891ec492e..5565c14b4bf6 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -740,6 +740,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -748,6 +749,8 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 		flags |= FS_APPEND_FL;
 	if (hip->userflags & HFSPLUS_FLG_NODUMP)
 		flags |= FS_NODUMP_FL;
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		flags |= FS_CASEFOLD_FL;
 
 	fileattr_fill_flags(fa, flags);
 
@@ -759,13 +762,24 @@ int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	unsigned int allowed = FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL;
 	unsigned int new_fl = 0;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
+	/*
+	 * FS_CASEFOLD_FL reflects HFSPLUS_SB_CASEFOLD, a mount-time
+	 * property. Accept it as a no-op so chattr's RMW round-trip
+	 * succeeds; reject any attempt to enable it on a volume that
+	 * was not formatted case-insensitive.
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		allowed |= FS_CASEFOLD_FL;
+
 	/* don't silently ignore unsupported ext2 flags */
-	if (fa->flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL))
+	if (fa->flags & ~allowed)
 		return -EOPNOTSUPP;
 
 	if (fa->flags & FS_IMMUTABLE_FL)

-- 
2.53.0



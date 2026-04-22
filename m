Return-Path: <linux-nfs+bounces-21006-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOc8B+Ra6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21006-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA0144BB68
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C006D31129AA
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E93A3E66;
	Wed, 22 Apr 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usCmrLv+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361C346AE3;
	Wed, 22 Apr 2026 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900636; cv=none; b=uc1QXqXP+wUQ4kZ5wDH0dxpYxZFjKkSNNwXCCra0sqEpkOIIJ2tBbpXY7Ueu2EJeeIFzv0efH7oOR9pc7DOYB9IuLSlxeVpO/0yekCylrEpnEY5e+U0yVNCKxRXTohFczeTI+i0XjKqq9PJU2lMb4DdDKWfbxpgO+9PzjUhzFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900636; c=relaxed/simple;
	bh=jXYqYekRjpF07wlPDKgx2XWDNqQtTHKbLiod79qFffg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/Y1Ke2j78QI0TpcwGN0IMPOzqMyoih7FBLJVGfmPvH0iIlawr/AJgVhltmfwIJWrbubfiDW+8C+NUFNz3mRYjhkiG3kn09El14f2WhYFL4CiGH5k1mg83u49ej6KIp9otq8e7im6PokvgxU+/GJgh0UF80dpR72BcykivS0pwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usCmrLv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA2DC2BCAF;
	Wed, 22 Apr 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900636;
	bh=jXYqYekRjpF07wlPDKgx2XWDNqQtTHKbLiod79qFffg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=usCmrLv+N705MyXz9QrB8eUi0cUHCIrvFrfNer91Gkil+ZqSe+Uv+mIqL5GktgtFe
	 TjOetSwCQZv+swwRMS72YUTtt9dUGzzlgHD1ppcULa0xQs4RMgPyaJbjvzBZYhSnYq
	 /wFPNefAUCoXjT2xQu7sMk8H5p6E0tyMmqLovYSHiVmrqxVxT9yZGftM7cBHo4NinI
	 /nylz9us8rVzQ2+5u+EJ3ki6J7om5kmWngFJlndHlTasQhfiy2xaZ4ppFhoxGbQKG9
	 AnANcz94N16eJCPW5f579E20MrlPSYW5hGmP3x2x8SrTK8kBfipy9A6ZLdvD9+Cq6D
	 xtdDBTMwMl5Ng==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:02 -0400
Subject: [PATCH v9 08/17] ext4: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-8-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=TxMd9+19zfe1kcd7z7IWDwky99GfiXSk/tT0Rl2ZM5c=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFTp3fLxE8PITfxUL7bNrVobvHogZfU1OlZ
 pifqDEyrSWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l5T9D/96IYMw2tXU48HaQ7/wBu/lmh6O/uthEswp4B3E8zUUOZxJEKKCesvcbZ/FPTIZrz6UIC7
 SFZNP4CtwF7mTNW0vhhKzFeM0BNnWfqxfW6TMHfeH2Qsx8RpFIupMQTFy+3vhwe7C8DtI4fdBQt
 KuYkZ8lkPr0G553naFj2d1hTsPGUmsJw5oZLcOcO578GvDJGDbuKZszGbjbOtsrI4Pp0nAdAzaN
 aJhTDHyvFq34U1NEJErK/floRT9eHqpvvjCO2lYLSmvH2Vu/B2C97+sm7As7hNg1piuL/Y3Looh
 N9J1JXeihuV4fSKG0jhE1apayyNxr5UYwqMvpBmP2psp44JYk0Ghf+72TLltpgiMXJu43PUqNs1
 0Sx46M+sQlhOQY9PJD7VM7cwFLTL1ClWHCmeRUeiA1BAocO1DKDqISuSJRwJbNd/bFbKFK4jaWs
 DDV4ki4Urn91xwjvCDNV6cp6h3btk9OSgzm1ZMtvNIQuDunB3G9KH3Kggi2/Nc3jdvjbIOgFOPA
 VvNZxBTTcP05GaxBa2Ux0CyTCpxRtJdgcrwxDLwl44HaCsMSHJ+YVL+/d3q3pk/fkEGDVGZ79rY
 H5465ibEnCmyFesdM/qK7r057UwKAfoqbRP9cDAYiYLgajXD2D+bJatDIgwaX3+ZENYSHC0cMmz
 jRnC0nP6nYek2bg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21006-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,suse.cz:email]
X-Rspamd-Queue-Id: 8CA0144BB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Report ext4's case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report case-insensitive; otherwise
report case-sensitive (standard POSIX behavior).

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 1d0c3d4bdf47..d1d597a13eeb 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -999,6 +999,13 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * Case folding is a directory attribute in ext4. Set FS_XFLAG_CASEFOLD
+	 * for directories with the casefold attribute; all other inodes use
+	 * standard case-sensitive semantics.
+	 */
+	if (IS_CASEFOLDED(inode))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 

-- 
2.53.0



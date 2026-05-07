Return-Path: <linux-nfs+bounces-21429-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNssK0FU/GlOOAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21429-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 10:58:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 502554E5578
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA5693032DAE
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE393932D8;
	Thu,  7 May 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGxwO/Wh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA039A06F;
	Thu,  7 May 2026 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144094; cv=none; b=rI/PC+Jp7MkSASnriLb545j7XMpBihYj+A0OmljdG/wLImwQ66Yhrsud9wS+CAmgbvqmLL1SXjwgvmwdhkxyj9Qxi1Cv2402hEVFZFw+tjaqLoifU0cw37LbyaQt3iUQ8DTd1RIqyKsoLnj6pNv3qma+89mnXeVAdkI6UaDm+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144094; c=relaxed/simple;
	bh=pwh6ZK7+DyUSteq+vdVu0HYuHs8P3NPOtCprGITxaEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sccUXVfTcYgyj3qBun8ctk0wHm9A37oX3EcdyFwQOC7zbfJLSqyMu2v/BdsjHYliQdL0xczC7fcuNA4TSsVnQZHcs/2Fp+N5OLMj55r26R1Y8kSf+Dy6NmqkdXcr0sgDjMqvZpu8D7Hk7KDii3JGIjlG3TPEKMmOp/LemCyYqJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGxwO/Wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B88C2BCC4;
	Thu,  7 May 2026 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144091;
	bh=pwh6ZK7+DyUSteq+vdVu0HYuHs8P3NPOtCprGITxaEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PGxwO/WhnWaiLe5vPy1RO0Vt1mnrFCvoFPnfIMrC2vlGNM1m2Nui9Y1rUMVDpN4Ne
	 LRUZJeNFc9v3jF9UMKtRjQsg35C1wHJLyuJAw+Tyt1i5qiXQi46/QcZf4s3qkkJAE9
	 B1qp9IBOmD4BuHxzYclexn6jcPxaDxOxGO7fsw15LG2J5Z3XLJEAsW1hRfJc4NT3TX
	 bPgJt0c7zZV9tsNYACpGH7lpeZawtkBGxh0yjmsQhzijwnzgPDplooFfvXVUWayUoZ
	 v0Zv+OWfNDLzGnbXLpjAWr/a0KqeVqiQUTBgXZC52Z1X4Pf7eCcjjhrQp67f0+LoVC
	 gU7dldxlLrnIQ==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 07 May 2026 04:53:05 -0400
Subject: [PATCH v14 12/15] isofs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-case-sensitivity-v14-12-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=eE/CDF09GJkNn3nT+HwwWprfQOLLBRzGLyDUxw4X/sk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL2Q49p5hOskD3m4hITiiHyoRZeUREVxwa2c
 6t3N8etHpeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9gAKCRAzarMzb2Z/
 lxZWEACD/ZqGaHOY/9qPDm5wUREev4kdzBhIdloxMNaess81b8RsbPCGLEpz0z0okkUB4/A14Lv
 B3oSplfs5DGGYaFQ4/3vYRjxYIqmpQEWVPJKhzNtvaAFd/xdIEY2dI9FFsacJfqjBoO65U4CCA3
 XahcgQ0p4WHU3wvmnaUy492rzND+Po0NxZz+VHF5/iCWEilVTca1RN8krmuf6IlthO102jTV/lE
 CGpZX4Vt6x6zXmfgVASelyeNh5CjtumAuD+mlA3FSevPwSVoTkgiqC41WbBxoCxvHCjAa8+aAEt
 FuDL7Dz4Zfc3UlAixWWLO39TDxJnWMq8THMe3Aal+Xz/g4oGeM7KWY0Og1SGTb4jaHHm79x1vY1
 GXLT5LNOIHxIc4DQSUcpLVv0RsCQ5AQqOQqsOaBqAZV9Eu9/BDx2ipRkKW57FC8G/ObPK/CirNK
 TZLufXPruY05n2S1GghycCnz3MCaJYZ67/mwLAqBCQsJ8sP8ccyHDu1tPL9GAbIHbKzKcNRgoT2
 8QtESiYoKGqq5FHENLGtH6hktGKCfY+MlD84tawGebujO3nvwOiffMpwWQUg/jYshOReJ95Zgxp
 7SeuG+uKUA1tnRkR7ONJYR0P7PH45VQkOZ8k7LANRFtL6cSPaBwX8fxmGuOV1js+EzRccTxVCzl
 DmHXGh1OISOMCSw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 502554E5578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21429-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner so
they can provide correct semantics to remote clients. Without
this information, NFS exports of ISO 9660 filesystems cannot
advertise their filename case behavior.

Implement isofs_fileattr_get() to report ISO 9660 case handling
behavior. The 'check=r' (relaxed) mount option enables
case-insensitive lookups and is reported via FS_XFLAG_CASEFOLD.
By default, Joliet extensions operate in relaxed mode while
plain ISO 9660 uses strict (case-sensitive) mode.

Plain ISO 9660 names on the medium are uppercase. When neither
Rock Ridge nor Joliet is in effect, the default 'map=n' option
(and 'map=a') routes lookup and readdir through
isofs_name_translate(), which forces A-Z to a-z. The names
visible to userspace then differ in case from the on-disc form,
so report FS_XFLAG_CASENONPRESERVING in that configuration. Rock
Ridge and Joliet both deliver names as authored, and 'map=o'
emits the raw on-disc name unchanged, so those configurations
remain case-preserving.

Casefolding is a directory property, and the in-tree consumers
(NFSD, ksmbd) issue the query against a directory: NFSD walks
to the parent for non-directory dentries before calling
vfs_fileattr_get(), and ksmbd reports per-share attributes from
the share root. Wire .fileattr_get only on
isofs_dir_inode_operations. The CASEFOLD flag is set in both
fa->fsx_xflags and fa->flags so FS_IOC_FSGETXATTR and
FS_IOC_GETFLAGS agree.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c   | 16 ++++++++++++++++
 fs/isofs/isofs.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 2fd9948d606e..55385a72a4ce 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/filelock.h>
 #include "isofs.h"
+#include <linux/fileattr.h>
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
 {
@@ -267,6 +268,20 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	return result;
 }
 
+int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
+
+	if (sbi->s_check == 'r') {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	if (!sbi->s_joliet_level && !sbi->s_rock &&
+	    (sbi->s_mapping == 'n' || sbi->s_mapping == 'a'))
+		fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	return 0;
+}
+
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
@@ -281,6 +296,7 @@ const struct file_operations isofs_dir_operations =
 const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup = isofs_lookup,
+	.fileattr_get = isofs_fileattr_get,
 };
 
 
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 506555837533..0ec8b24a42ed 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -197,6 +197,9 @@ isofs_normalize_block_and_offset(struct iso_directory_record* de,
 	}
 }
 
+struct file_kattr;
+int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 extern const struct inode_operations isofs_dir_inode_operations;
 extern const struct file_operations isofs_dir_operations;
 extern const struct address_space_operations isofs_symlink_aops;

-- 
2.53.0



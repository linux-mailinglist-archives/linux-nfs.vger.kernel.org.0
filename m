Return-Path: <linux-nfs+bounces-21289-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC3sBGxJ8mnOpQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21289-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:09:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A417B498B64
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ABE5301B172
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01D423179;
	Wed, 29 Apr 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUm5fwJv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD3423168;
	Wed, 29 Apr 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486078; cv=none; b=Pt5va80dB0CeoQ4SbJ97mfxDz83aMTQXUFPsGFhqNcwllDgCh93J30g7zcBFbv9juTjGfsJsB/KymzUgH7J4Fl6PFuqA1/oF7kA7VsA0Peelx6i0kv5CxSKWPZQXej2iJHAN8kQZEDCKl7RgFMvWfWlXhXPw9ftDXlwCp0Wv0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486078; c=relaxed/simple;
	bh=pwh6ZK7+DyUSteq+vdVu0HYuHs8P3NPOtCprGITxaEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bz+gcTvTn6Jn2iwgIojSb1s1BtYg+9BMD7qnT/pmptMmimujInYxE14eQxXFwroimUNr/FVjvV0ktIi62Hm13f0ui/qqElMP8JI9NN33gwZhmGh5cIhl/eS2QADX83wbKIHqiyxLRduC7GpX2m2YRXUywdZ6tzY37eMvz719TGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUm5fwJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE670C2BCC6;
	Wed, 29 Apr 2026 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486078;
	bh=pwh6ZK7+DyUSteq+vdVu0HYuHs8P3NPOtCprGITxaEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cUm5fwJvO94JdjbxFEj77aY3Dc1toIfZ/2e7MT3WBUFdkBc0Cb2ETUOm1TJ2z5SYw
	 bloY2o+z8JIcJOvLoWTPN2iXZJqqbs9xTzlTZVINY+St6ZHFI6gzHUjDvKJ6UK69E9
	 QJJP6c7MFhgXmZRXT1Jurd39OiJqKncwDb9ziXYxJOzEZM3nl8iLLZFC0xt5oERTJd
	 YXOhEsmV6KHl4W9+JCaXZerr2yHZrKtVh2AmH2XIUxKAKHxguMxQcqacZxLwkZBd4C
	 b9ToN2pZ6hvxobefXJQY53YpQe7vnqW8uHN6p5eQJljuY2NubVviR7WYY3lG5yY29i
	 goGqcW8hdVU8Q==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 14:07:23 -0400
Subject: [PATCH v12 12/15] isofs: Implement fileattr_get for case
 sensitivity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-case-sensitivity-v12-12-8057123bebe0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=eE/CDF09GJkNn3nT+HwwWprfQOLLBRzGLyDUxw4X/sk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjdmZb4cmkDdd3o04vNirFUuWuF4YDSCxs1K
 7pRxcmUuAOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3QAKCRAzarMzb2Z/
 l7oDEACRSp9ryOfppWfuFcz+UBqCKY0jeZYBaoM62a7MBA3VqlqHxNx2z1ghpntuPE4yIjU6JKQ
 FEVGfnO96YTMdJaToRwHgaUhFQUq8Dbcs5vKKx7CZnqNajNk2gvIPWhp0hehQaLVVjvGvS8dylO
 e0hGGrLeK/zBYWBzawxUeffUKYepgoPZGiIdkpIiQXKblQxP0qrptc9w6WM40jgQToWobUAnTyk
 RK7IW6ZV0RFNkQxnWzvVPmtAB5xRO0HRbcmeTgdNCOZKu0NfkB+DRNwnVJ78PUJ2MijEVZvuJ+1
 U6o9DxhN44u1oTFVg9fYjRLK/lozB608kOsO0SQfyDsZt9uAzuaIC56y+inPT1/B8Q24318Owle
 3l6kvXDNIOEydHmgSFTdsBfB6uLsAJ+dyl312oimhGW7D0kVsEZk3ILWVe9yWaXY1XncH+MPC77
 i+voYxn17F+KQG8v5yifNZU7gljSp0HJuPZwXroz5y3YeYeSSyPWbO6LSkCdPYtGB6mwPuhan/z
 rf1BcpBKZ/qzyq3KkqOKnh5W8lNBycPpYOBD+NOrwxcwsumtYFM+1+ntyebVlr4nTAkgQ/QfdRT
 H6h5M41pGTkpkLXJmhNhwtx84tUTNuJlSZ3iASbHp1xLm3bn475vhTBrfeabEoSXn5RgX8QXk1L
 mu65n+jQsXelg/w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: A417B498B64
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
	TAGGED_FROM(0.00)[bounces-21289-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nrubsig.org:email,suse.cz:email,oracle.com:mid,oracle.com:email]

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



Return-Path: <linux-nfs+bounces-21292-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DgFFiFK8mnNpQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21292-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:12:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5149498D80
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3384D308AB70
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0583C41C31E;
	Wed, 29 Apr 2026 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp7aPOO+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3E41C2EB;
	Wed, 29 Apr 2026 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486085; cv=none; b=KApq0nTEca1lTOwFZXLlcSIdpHRu9R3ZK3ADdiY5wGr31D+QwYzeaLmeEOO4JFI+ZfB6GQej/fGnUvCsngdjFMBVZWZ50+q2X3J/LDNTH9PuAjoIpi26kNYoUmU4zO6LphmkZmpsdPQRJhg2prqr1se3cBCqL8OKSIHye3SlRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486085; c=relaxed/simple;
	bh=qee/kCsMg8C4eRFPxmiZaknm+clMPDWXLjgwoKgpYx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZU6k68QIom8f1cBvpNYfUA0ggxk3qxZxhPOYLH+Ph+B4RlPBSF+UMlcW4qd1luSjTMc9wwGrJbYVHVlDn8HEpmnh7s/cvtdSWI/OCcK++0XWlpn0pInknkk+xd+FH+wUIIisjuq4uwr3X4fFwreBEpTcu7o+MXkWtSaUKzQmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp7aPOO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2BCC19425;
	Wed, 29 Apr 2026 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777486085;
	bh=qee/kCsMg8C4eRFPxmiZaknm+clMPDWXLjgwoKgpYx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cp7aPOO+0dpAl5comMlMldcJa1APBJg4dyIBsWMJ2dtOrQbwWwziadV1HHKwrhyO2
	 EKu4+yuEtoA6jUBez4Y0IWm7LnpjZ7KIQ0cKbWX4NFBhaQoo8h8ksY6WyypcBJIiWf
	 YVKLHIwg3nRuxX0c7vGmZp0keEDeDDm30aZiICMEh6w5Ltf7b9eGdLSsN7GUeHd2RO
	 KG8J5iHDbC2xwSoCytBzBwqRmnDRaD72VrktoFD4aXdoNzEgYb39fr+hiUjydoGqNK
	 eZvAfEO7UeiBTmVpcpqsgS3jMPggCeKbV1zsEWMalElaMbD0tnnbSQkclFiQ1gT2dT
	 +Oqta2nmBEIpg==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 14:07:26 -0400
Subject: [PATCH v12 15/15] ksmbd: Report filesystem case sensitivity via
 FS_ATTRIBUTE_INFORMATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-case-sensitivity-v12-15-8057123bebe0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=3j19l6mVyr/XReBrhpdSBMPAL80WouHe9sT+TihiyQM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8kjdM8DNWFfItbp41H9vWWe4sjWWzOyQ+8ADF
 lrE33haaFeJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJI3QAKCRAzarMzb2Z/
 l6qCD/49AW4062WfbZHsVpGZySPK2wkZN4kfzlroTWbJi5jHIlMQIwp5bYVt4lATNx2xi3HKgCa
 yItm/0qjXDMJPU9Fn94bdyvedMVogpUZIY/ZRViPTT9ruiASIFp9YTJaUFH3gm+q6lKMGGueSfn
 Z8EN2By/rS44QT2tQtZeRQg+zuoeN0qOLicrbGM8Ug4pCtBZ8RgpvTKfaLyrnDSp4V386qjxeSF
 m6/1X0kKy/gtY/4vezUg9HU0vMFe/Z8hWm7GM3FiUBaQtO3NkImZILcblBqflbk1iwbr7Qyj/ZN
 GolZ7i6mSX43sZPXu2qZvJcXrsjI2l1ZrjkAcd2TiNhxk01B8C29+OkVaZDoYfOFPJ7cem1CUkD
 yF4wuNlaIqyfQ7wUC2gDXnZx464eKD6yuPpBqLgQh5Shi11DAwcJh+bESsAO0t8+6/KX8qiwJ+D
 FmGWua4a6ZHifxfcGv//3z8Lqg/FuYL/G/tSGUlJR3ucsFKGHFkl58j6LSSMV6/nXs5C/WsGKGX
 BXuIrC5tVEveeTCH07Efv3p8TfnjaJqw+kQMv4dnuhYU1F4RwUb/4o3W2yBHobxSWo9aYMfSm/7
 xCr9iOFnAKJYKyohvVvXxada0v9urbMpe8ELrwuwZW6XK/aKH29m1vV2wOnVmP/IH9CA5qJVTgt
 LYV9F6XEAovyiZQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: E5149498D80
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
	TAGGED_FROM(0.00)[bounces-21292-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,nrubsig.org:email]

From: Chuck Lever <chuck.lever@oracle.com>

FS_ATTRIBUTE_INFORMATION responses have always reported
FILE_CASE_SENSITIVE_SEARCH and FILE_CASE_PRESERVED_NAMES
unconditionally. Case-insensitive filesystems like exFAT, and
casefolded directories on ext4 or f2fs, have no way to signal
their actual semantics to SMB clients.

Now that filesystems expose case behavior through ->fileattr_get,
query it via vfs_fileattr_get() and translate the FS_XFLAG_CASEFOLD
and FS_XFLAG_CASENONPRESERVING flags into the corresponding SMB
attributes. Filesystems without ->fileattr_get continue reporting
default POSIX behavior (case-sensitive, case-preserving).

SMB's FS_ATTRIBUTE_INFORMATION reports per-share attributes from
the share root, not per-file. Shares mixing casefold and
non-casefold directories report the root directory's behavior.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee32e61b6d3c..cf0bc453a036 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -14,6 +14,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5541,16 +5542,33 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	case FS_ATTRIBUTE_INFORMATION:
 	{
 		FILE_SYSTEM_ATTRIBUTE_INFO *info;
+		struct file_kattr fa = {};
 		size_t sz;
+		u32 attrs;
+		int err;
 
 		info = (FILE_SYSTEM_ATTRIBUTE_INFO *)rsp->Buffer;
-		info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
-					       FILE_PERSISTENT_ACLS |
-					       FILE_UNICODE_ON_DISK |
-					       FILE_CASE_PRESERVED_NAMES |
-					       FILE_CASE_SENSITIVE_SEARCH |
-					       FILE_SUPPORTS_BLOCK_REFCOUNTING);
+		attrs = FILE_SUPPORTS_OBJECT_IDS |
+			FILE_PERSISTENT_ACLS |
+			FILE_UNICODE_ON_DISK |
+			FILE_SUPPORTS_BLOCK_REFCOUNTING;
 
+		err = vfs_fileattr_get(path.dentry, &fa);
+		/*
+		 * -EINVAL, -EOPNOTSUPP: ntfs-3g and other FUSE
+		 * filesystems that lack FS_IOC_FSGETXATTR support.
+		 */
+		if (err && err != -ENOIOCTLCMD && err != -ENOTTY &&
+		    err != -EINVAL && err != -EOPNOTSUPP) {
+			path_put(&path);
+			return err;
+		}
+		if (!(fa.fsx_xflags & FS_XFLAG_CASEFOLD))
+			attrs |= FILE_CASE_SENSITIVE_SEARCH;
+		if (!(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING))
+			attrs |= FILE_CASE_PRESERVED_NAMES;
+
+		info->Attributes = cpu_to_le32(attrs);
 		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
 
 		if (test_share_config_flag(work->tcon->share_conf,

-- 
2.53.0



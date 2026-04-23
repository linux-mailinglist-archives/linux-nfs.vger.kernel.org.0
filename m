Return-Path: <linux-nfs+bounces-21027-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCdxFAIc6mmUuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21027-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:17:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66870452ACA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CEE430B0FE4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09E23EF677;
	Thu, 23 Apr 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+8CNK6T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E73ED12B;
	Thu, 23 Apr 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949948; cv=none; b=V6UWOROPiK9PSbBo+a5idc4IUkQxA1O6ynucpfyIB/a1IHfL61dxN9nTC6MRD+VlRNHsAdEINz/s/CT65l3LSNJ5jrl7kohb+Rd2LGGnjvxCjlXhIB555SwlV4SXgYmxZJjL8ixnbdJEsi5OA3J6c/0+N1dPj7Tx6CrSj870/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949948; c=relaxed/simple;
	bh=7UJbZffIRnlSy1BsD5KTY53QnosRcT5XUdA8rzeY0m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEyBoke696C/ZiW60xcZP4F5XWH9iteiuIiuGtEY05dxOy45kCTgFM4qMXhkr/iOXgTPDwLUzZSE+i/GEA2jC4X9/f3iUgYXdFlPQHC7GhHPfmiodsAxGoaBBwcobToRa5huzZDUW0DNgCypMS0ej0cnZGHhbRpnZqVf1HbB38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+8CNK6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8622C2BCB6;
	Thu, 23 Apr 2026 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949948;
	bh=7UJbZffIRnlSy1BsD5KTY53QnosRcT5XUdA8rzeY0m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q+8CNK6Ty1dPCj32YKi12DJgeuILKAnyBRpIlf61cLnK+RTqGqCnujyiqkeOrrFXz
	 jDJaAVYPzupJ+M1eAimqvkTh1Uy0GVdjZEgu6V3rfHDTtnPANI356Rq3gpJOGGlaIC
	 E0u10VS6jFOzMiom2mPikCIFd3TmIYnl8LyN9ypBQK1ekAGuAy3zfPL7aFMAICKYiK
	 1bB9gbxlFshmLeVglyRw/tGHFmcpryFso/LsH1EM3QF3XzfwkBoHtEEMimYZcEfsjg
	 ve1hOkdmg5ymqaE//AwwPVzvWAJ3qA+aE5KG89uv4GT/o3wtAsT24mcDO4HAsvekWU
	 eSBZzk/RyUuWA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:05 -0400
Subject: [PATCH v10 02/17] fs: Add case sensitivity flags to file_kattr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-2-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3340;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+pPurO/+pD2WfwcHWQv0N9xleXhBqxhdJ6hocARUJZ4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzV4rncvMnfwromfgLGjORebeuYGgqBGxix
 MODx4f0YwiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 lzuJD/9oett156EXicv6rkJiFAEDCXWQPISxbLgBsKNereRLdeoxArncX+k2TCH+NNCNpGYhmsF
 5rPmzbKsSI4Z8YDHcVcOWFN+uc2KC75iTOUgDQnRLF0dX4wUOCBmozE2jn6XI8McHNRY7B1illr
 z5PX3hGmxY/cfyb5aW9G8383RS1L7a0Z2aymfxPFQVQfM24ugoZ9D4VzTNLiwTQqSGHnuIuvyzD
 eK91r1zb1mYmsRfCOkpEL+3DyA5riUUsJF1x9c9Z/9L4ZVbrEMvTt0s+GIfDUYGTgEBBztfl+PC
 AC3nxLcV8c13VwPMY43FHJyku2am/FL9snNRum6RYgrLQfPnitU/Hj8ZOIOOdVCNO6Y9/uZyh1y
 3n3Sixh3N06mfvsFwVTqT2XG9KC2e8oEB/Ptlw+Lbu84Zv2z4Zp9uTrk4aN37W4gJ9ZQ6Idu74O
 DM+RdPFyt46ik79+6nMzg5M0ODNO5TsygyN5jXHPfM4Lw7scpGMAvCvJ46rP25FA4cGL2jli7zw
 uEKwAlEc6Qe6NPfUjIAbQPad8gGz84jgGgbVLaQmQJcbW8onIwSIOjA3ECF9YyX14wxV29TJCS4
 mLeQMaVYq43CvDhrjWyaSeyo0eWci5orp7Xw0z3rXLUbHJGRYYvVYjqKlJtbuUAjlAZHPFF9VgC
 5whXS5Ywg643qhQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21027-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[33];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:server fail];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 66870452ACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding FS_XFLAG_CASEFOLD and
FS_XFLAG_CASENONPRESERVING flags.

Filesystems report case-insensitive or case-nonpreserving behavior
by setting these flags directly in fa->fsx_xflags. The default
(flags unset) indicates POSIX semantics: case-sensitive and
case-preserving. Both flags are added to FS_XFLAG_RDONLY_MASK so
FS_IOC_FSSETXATTR silently strips them, keeping the new xflags
strictly a reporting interface. Callers that want to toggle
casefolding continue to use FS_IOC_SETFLAGS with FS_CASEFOLD_FL,
the established UAPI on filesystems that support the operation
(ext4 and f2fs on empty directories).

Case sensitivity information is exported to userspace via the
fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
system call.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c           | 4 ++++
 include/linux/fileattr.h | 3 ++-
 include/uapi/linux/fs.h  | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index f429da66a317..bfb00d256dd5 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -37,6 +37,8 @@ void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 		fa->flags |= FS_PROJINHERIT_FL;
 	if (fa->fsx_xflags & FS_XFLAG_VERITY)
 		fa->flags |= FS_VERITY_FL;
+	if (fa->fsx_xflags & FS_XFLAG_CASEFOLD)
+		fa->flags |= FS_CASEFOLD_FL;
 }
 EXPORT_SYMBOL(fileattr_fill_xflags);
 
@@ -67,6 +69,8 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
 	if (fa->flags & FS_VERITY_FL)
 		fa->fsx_xflags |= FS_XFLAG_VERITY;
+	if (fa->flags & FS_CASEFOLD_FL)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 }
 EXPORT_SYMBOL(fileattr_fill_flags);
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 3780904a63a6..58044b598016 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -16,7 +16,8 @@
 
 /* Read-only inode flags */
 #define FS_XFLAG_RDONLY_MASK \
-	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY)
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY | \
+	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
 
 /* Flags to indicate valid value of fsx_ fields */
 #define FS_XFLAG_VALUES_MASK \
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 13f71202845e..2ea4c81df08f 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -254,6 +254,13 @@ struct file_attr {
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
 #define FS_XFLAG_VERITY		0x00020000	/* fs-verity enabled */
+/*
+ * Case handling flags (read-only, cannot be set via ioctl).
+ * Default (neither set) indicates POSIX semantics: case-sensitive
+ * lookups and case-preserving storage.
+ */
+#define FS_XFLAG_CASEFOLD	0x00040000	/* case-insensitive lookups */
+#define FS_XFLAG_CASENONPRESERVING 0x00080000	/* case not preserved */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is

-- 
2.53.0



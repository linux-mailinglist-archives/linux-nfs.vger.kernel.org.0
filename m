Return-Path: <linux-nfs+bounces-21086-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANAAFrQe7GmuUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21086-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:53:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64226464873
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA406300BCA0
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D720246BBA;
	Sat, 25 Apr 2026 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAJ/CuUk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF51A680A;
	Sat, 25 Apr 2026 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082009; cv=none; b=kmxwC3Q9JVMACJ0YugtCEO+gDWeZCoxEiXlBYRrR0HSDi0Y6BUgHXnJCBNAkFmeOQjGeARmCot+zUss3SzFgnxJhh0r3U5hQrLLohSVrUHWbCBeUI8quzVgSeX62MTc+2Ct1vH1Fe3WAmKyhUUYztgl6pNBYFVXrNKQBHItfTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082009; c=relaxed/simple;
	bh=TFF/jZiZrtLjdmF8xjSA6CfyQJOvsGBZ0ycggreXc9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsGYBm64AEYGHrHBp7FNHNgklemihDHKJ1Z1YhaUsBtmTW+u+HM3Prh1maBzOOTZsvR/f/8AM/vOduds/2Xpn9ogb5FAGjh/RJhBkHAX6RbfwRmD2SgplKwz3fGga5q3wKjrIR/FZ+rHoDBb1VlDc7P2kXKvSBdxYArG80Uhk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAJ/CuUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F77C2BCB2;
	Sat, 25 Apr 2026 01:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082008;
	bh=TFF/jZiZrtLjdmF8xjSA6CfyQJOvsGBZ0ycggreXc9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iAJ/CuUkYBRHUgd5Vbk3R/RuxMgydkd1Q6LIHyPEp6KVnjtqQH541808e5rOlhi/N
	 xJaIk8KIl309tG3fxJsIz2dOLkIvk4YMdWbQCy4X+8763pE3WFjtogZlfJ+6c81jhJ
	 d7anFQbPh7MXEI4PA2DVVjQNSHokYmBhniv/yH3jY0uIKMGS95aWiFZ7Ne90lphGFO
	 l3H7iVTSeROA7Yy1lvxoeHkMAd9+DCEjTKGA1PmdKYrDvgUwbMwCMzDlw13GZYDbAb
	 0+v2h/UWhZ1zjA32z/qtjWA2vXrava0BIz6mh78WjGjZBC9HCg8bdXJKNGbu190u4G
	 2MgyyP7UDE0YQ==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:04 -0400
Subject: [PATCH v11 02/15] fs: Add case sensitivity flags to file_kattr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-2-de5619beddaf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=42BtA/ECrX4U52i4InslT9hET7DZ27jCO0bDUKFKJW4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QnCcLxEgVgqxUPTsyyPkPTGM1fwG8lYKAg
 sf1zpx+aSSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l/qtEACCmS3MA/uOWQjFk94bJTW2Zo02V0sdsO47IYXAL+DmIVBmnacrvD2LJdNNMyIKdJgHtHQ
 GKb0TFBuvc3NiwOXlTkQZn5XVmKiYhiMzapxwOT+tMeeQvpUGmzW731Mp1BUwoNPyDJdW/5Kuul
 EGoiFMVzqBQnyBTx6u4EKz5pRGYZYg3q6DvmoLInvN/PbMjnQ6lhcekaXJY34iLQUqk9cF+Nc1y
 ocLCfH5KwM5Ez9EIr2H+jf3J5BBPh4+vXUkvpGCL01OzK2j3EOcubXFZoBsxeHAaTtH4C1D62bB
 e7y8i/cxDq9L1Q316+QHxnNU53WPxIKQwj+UFQIVIwY1px/hIehHn/sSS4dFVyV7ILoYWxliiPp
 gcps9ZU5bNVtk2C8ThjeatIhQGRiACG/J9FiOzgZnF+E/glef20kAf6ZuYzcuZ+cGcUye+RtS5a
 92drAqIv90+Eo9mxYAxsDJqA+5f8N2W0vD1SdmyWYT+gXxG64CCULaJRH21bKfv9y/KP12lttW6
 mnmTB3PqAhuN8VguGQrADzab2S0L1QZLn1KcBvHny3QtT478jXZ1cyMfVIPcsVKsYyJsxl1VE5W
 kRVecsPbDv6pwQ0u9AGsFDnPOfSbg+zpwYOegsYepLUqrbxITMTISc6uKfXD2uH2AYmzk8qzbEu
 I+a1rEar5hUbDsg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 64226464873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21086-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nrubsig.org:email,oracle.com:mid,oracle.com:email]

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
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
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



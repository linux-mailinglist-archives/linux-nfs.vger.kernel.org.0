Return-Path: <linux-nfs+bounces-21348-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNcSHZII9mlPRwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21348-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:22:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8984B25B4
	for <lists+linux-nfs@lfdr.de>; Sat, 02 May 2026 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99C22302173D
	for <lists+linux-nfs@lfdr.de>; Sat,  2 May 2026 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AEC33A708;
	Sat,  2 May 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBqm6Jbp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48926D4DD;
	Sat,  2 May 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731684; cv=none; b=LmbcP3ggHuOQXEt+BYr3ihIu3I1/Z0SwCq4xsIYCY1liJh0GsDwwsOEhjR7a5NfeiHy7xXnbrzd+PJ+2rL7A4/GoNEnEjv/YCjHpMPXqOsX4E9jBXgE2/DKdziX+yoTr3t7Icb19VDWv+8zwvX25gGw13NI53+CI085aWZvbKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731684; c=relaxed/simple;
	bh=TFF/jZiZrtLjdmF8xjSA6CfyQJOvsGBZ0ycggreXc9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qq70FnrcMl+DVbEWIom2DPMilsOvXhaAlpjkx12yfY3D7WFnUgRSiH5SZ2Br5zDrud54jWpQPlcf5xIsgB0pwriwUqD7GMvbweERIEJdv7B5bWBYHhwL88P9pKh1Yhg4X92gu5CqMnX0c3evmnFD5q1nwTULb1wL04X7ms/eyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBqm6Jbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D525C19425;
	Sat,  2 May 2026 14:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777731684;
	bh=TFF/jZiZrtLjdmF8xjSA6CfyQJOvsGBZ0ycggreXc9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eBqm6JbpRK09m+KExsWIch+7qexNWkXHfSuKfQsPH3igH9S0hx55rOI3RECIyDgut
	 ba5hgcKkWHEdgHrELG7V5cu+6Cg8MIy1C2Mw9IxRth2baXXTD//welnTG443nX9+XT
	 aY5rLIEQX8fMsSCu4C28ijmsWtz70KPXPvOpVcJI+B32zuZDzhccQgNL2rhyPOr3xq
	 TCtYd+Un0PMfk5IknQT81pmR4CFNbuAn7NvSnqcVwyRD96Ek9OXKrgAzmGUzITFIhm
	 4ORFmahgyFsoNuXn5fQOvuzYGJU+hFnEJnTBz/P+jOIqqsZGSvzBJLyUlpg9yYZKPr
	 926vI7LDd8fcA==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 02 May 2026 10:20:47 -0400
Subject: [PATCH v13 02/15] fs: Add case sensitivity flags to file_kattr
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260502-case-sensitivity-v13-2-aa853140311f@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=42BtA/ECrX4U52i4InslT9hET7DZ27jCO0bDUKFKJW4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQV+ptopOEb4wuPXE4DInwNk+An3UAx3Qf5
 fBVOOGX8DGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l5l/EAC2A5aQCzII1dTBCddUEb+UL/2uO93cCUFllxX6Zm/t/Z+JqJhz1tPahCAyJA9rUuS/YSM
 07Ykt0E2RrWq/U96W9a4pBcrs3oefHicWW1UHARLONhXkXQmgAbFyN9VzVXlcWOehM6wWxOnBTB
 w+qKTrJx2v6V7OHxLzufRkj9kLE4tbFa5wHGfphUqWDhAGQ3rzKTEcIU5DHCyGcF/QMg8y8zUXk
 fhxN+QRr9CBLG/bmwGkOxhM183F9U5qYNDDuYUKXw9kNjOUABNbZezOX+IWFFb7JJn+A0UNtW39
 eDPcseFtPED7Bpy/tIYQFs70Ts/9HvBvPhwSV8iZel3QhJ1Syf1nAzp1fZ2toFlcoydG1g+Mgs8
 Z8rUyHuwVI4F7eKUnfaa0R/a6FgQ/OifSzLXxNV/Fj+6ztb/DEiLalVAQKJXLIE8klSDe1LXpL3
 v8e5CGdoDT+cETDvSffecXeB8CmE4HYD7/XkvKecxBZn2xI4fljsSaRTAVHC/i4CoeSHN1Oiff/
 4vRX76cWTrqjzjJCfT1UdwJRSSFArYxAGlkXcP1C9oj7sPTR/x214JbqYDG9vTF+ZGF/R1gQyKX
 n3af4+Z+LMuvn0c2LMik5RU+apcS3waaFIvXWmBwuK7jyUF0NNzfVUk9P0jopol+X7eaRnwXeGb
 rBLWb6S8WpyvcjA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: DC8984B25B4
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
	TAGGED_FROM(0.00)[bounces-21348-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,oracle.com:mid,oracle.com:email]

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



Return-Path: <linux-nfs+bounces-21015-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCGOBoVa6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21015-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:32:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD09A44BA82
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD10230C14F9
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138E23A4524;
	Wed, 22 Apr 2026 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEOVPlYi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A83A4511;
	Wed, 22 Apr 2026 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900658; cv=none; b=peeNzJciFakk3YzTfj0mPv53H6n5fnkyyxoyIg5ojFTDRl8+lch297zB+cCCUpp2kYkwaH1HZ9XXZAfgZR4ul0YK79v4MJeXWX4ounLDfBqAnveCbycvey+tvGGNgxsXEC0uPWFiNjaV4ne9UkIZv1AZ9YPxIQvIFHbJkn25dmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900658; c=relaxed/simple;
	bh=yGB+SiukKqXG153GFiqJqhuat+PctFhKpyG9E7K2Nwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNGEVG+OSWIZW1pBWIP73guNmMeD288YzITp0OQWg2Z9BAaPVyLSifWDjRHoCVrMGnoQTenPk0b2ITAK/9r4Ad6xYbi9YYq4B75jTlcFHdHsYoqci9S61MxQq6da1MGTNT6EtMVGFwN7ff9xbc9gGrdV4Cra4Y9LHihDoGILPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEOVPlYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46D4C19425;
	Wed, 22 Apr 2026 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900657;
	bh=yGB+SiukKqXG153GFiqJqhuat+PctFhKpyG9E7K2Nwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WEOVPlYiy41FokHzJ/G3c6LQEKjEa140BOLBum2ty56e48W5ncchnQm34HxR1orSK
	 2j3/TOEzx3WBAwpBlet9UiukU9BnswuxpxPCaAv9NnjM0S8HpZU7YQbpOla3YL4f2Q
	 9Hr4PqJx1YDEFGUhFrjOLoy8EOGinKE9n1UYd5AZC3Zs0QpmP2HXLGnoaP2cJt3VNw
	 iCzI43DWk8neu38UTOipBATiQgLD2nM3EFEwiaOiibCD/06RwM/whf2hhZe5KAUguJ
	 JEa54CvrQdbBVNX+tki2kUGuYTCFFXeamDcxo+8BvTPdlhZkLwNXADC3biNTMLmU+p
	 ROjyOUWLFL8wQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:11 -0400
Subject: [PATCH v9 17/17] ksmbd: Report filesystem case sensitivity via
 FS_ATTRIBUTE_INFORMATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-17-be023cc070e2@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=2nS1LtlO/vmrzHVVaUmzB5jhcNO5BsoFT5yc1yYmaA0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoGIYmy6NHTYqRGKLzunLRkH1VFkkmk3nfRE
 QrXoqRc1COJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 l9JtD/4lsYqo5MVTwAVbK3MDQFPfipoXxMx5tsyzwfZh40XeahxwjqXXRMFQSRuwY2jQOg3BV0E
 4lEofWunivHzQWh1Cgt3noIh70i3Luw+mbNRpnphdJjx0qQTqmk4CG26zOMfw8y131burjTqlgB
 Xtbsi9CV2FsqzJKt3W9KvuWnHvO9044tzCl6Pv2cJVReaHFTSTGAVuoX/7eC1yeNaV0joaNCdHQ
 VkH7niDabdUGlxJ09K/Zu5Nml+Jl/VrPiiU5NWzpVRJ8S7b4nK6TNTSBGHVBme52ClcHBNXbHEF
 YBgUu2JZJxOpDk78wzMaTPjmhoSBgKHx0poogwNRXVZS2FwcmVFmOPitYhsO/mTB8FVc53Y292J
 rLeBq1vL0NSVWqpSd9bZ1hZXroaukxXGY190syIzT26bZ3IdG0WQJX2eNXyEe3/gQPYOmvIBm9b
 1j0M+glgCryYZ7AqyQBnNUfYrxcOxdQu0Evs8DprN6ptEi9Cm6xpliHtzJqK974zY6J6udmG89f
 wTzKocypE6W2wNP2MzL7BJwUcYq9CQ7CFjqHN4IRCg08iKjjtI72VQq/wPOnZs2PHjCq+DJtDlR
 GlWEXv230nLY/lXAYUa+0ijVG6ZfkjDXPSui+aKmqM6UhKWIbnSID54OjV9Voi4iTsGAZwA6A1r
 ufg5mxTsl+M9YvA==
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
	TAGGED_FROM(0.00)[bounces-21015-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: CD09A44BA82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee32e61b6d3c..7e91b578ca28 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -14,6 +14,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5541,16 +5542,28 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
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
+		if (err && err != -ENOIOCTLCMD) {
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



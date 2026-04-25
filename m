Return-Path: <linux-nfs+bounces-21099-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBAwBdgf7GnGUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21099-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:58:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C67BE464B2A
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD2A33070775
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7082517AC;
	Sat, 25 Apr 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+14oXfN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2A1A680A;
	Sat, 25 Apr 2026 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082041; cv=none; b=FJFogCECkPhM2D4+IO6WGLszkdeUjQrrLux7pOgnCsZ7Y/ktWTdgNuPrpFQ5kPFe+WQhql9iw/jFdMVBiwqdhBsvyd+JfHC7x/lU1fN52unHj7W42nd5oxHkijQeR+tZHWAwdhMyc0qe4rHciUYyqvaSpQm+yoQAwPeimVB23x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082041; c=relaxed/simple;
	bh=WLSj6q07XGhooB1eQG/mkk9y+n+R25fNe7TfBGbYD6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NzF2bq7UfJwANGQ/6DSaw/NOYqMCxvN3PzTsIHFQDgCUKSuNsoASeiU+Gs3UbJn46A7hx9LIysiAlgNdGjmKBDLPJXSiv9dMBU1PIBKBBxFKOGSWEHLu1D1OJSKMJtrdtb933TLOguaMvIF+bpDOrssc/7UCA/TO/oBcQtdxMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+14oXfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D17C19425;
	Sat, 25 Apr 2026 01:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082041;
	bh=WLSj6q07XGhooB1eQG/mkk9y+n+R25fNe7TfBGbYD6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f+14oXfNcR0y15fPuFCLp01DM94FDXmSl7es75IIr1L4hSm26GQHflKCsS/T+fCH7
	 IxqfvoCKWbcfqftl4glsZxs+3SLtpgCSHkUnoMkglQnXkjw8a835IAnJcl8opIY16Q
	 xv98I0Bf1eJu9VneyqPhqDYrv1soNLxAtCRxTBoZgaso5zHqEi/IZrDgdjx0pqW+1k
	 q7i/n+YROp2Wc52rxre4Ly05gxHjM/SxH+6EyIOxW92CC92MxiA9etHi4sB1HWl4GK
	 0Gf+QAJNHfBajMT+x7Fie4+Ju0FdgF/okPWs5a5teM3S7e6T5r6L9oGSMyjya+IOR9
	 sQL/+aD7qtmew==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:17 -0400
Subject: [PATCH v11 15/15] ksmbd: Report filesystem case sensitivity via
 FS_ATTRIBUTE_INFORMATION
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-15-de5619beddaf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=bR19bllkdkbQhQ2DCXklF79gERXw2neFVWEG5vaHCMI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6RlXNMlI/rLhCwMFhVMU8ZABGegjkofRPR2
 ncJdim+heqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekQAKCRAzarMzb2Z/
 l1LND/4uqOXdd199YF0FpQLa57v96XaDEDTz2tsuu1Jy8Rm2pkaAXnt2S5mPdS/8jzkzmi8Oi6m
 X8XT6xcacj3KsdAAFTD22vS6WbgVdTAmqK65TET+/SmvLrIeaDdev8EEZnZoBoYSTPSDAcTs7qV
 1Uzz5TZXPXu3LL9lifyrHKczsHxRp/BhX7soqltLsQ/MxdspB+mJfx5/pIOCT9FPWeBmGpkBUFQ
 t9OKuJS/b7g1R1HG1MXBx4SpEXth/mJZ1Y8+k0eeAnED3Tht8jjnMCAaVaqKxHbreQp7dpGLCMs
 j4ROrEqRnwFuKYciW5JQW7Fon0sKdOQmNBiKcE0B3SaJP0v/xGQRvJUOjixSrhd214JwfTiNl5L
 1EUZwcRevf0/4qphDqBbebHD67q0dsygv4qA/5muzo7Bfa1+btVRlfqttC7WyiRVKuAfZ4m9rU0
 HVG15pYcsZmOR5wT9PMxrhUCsRgWMpLtFW5MBUffzk5W5LYIvWxFS1WJg80XNFH2jKKenkyhHeo
 ontQczLzlnKsa/hSS8eetl3DOOvi/08TkI+xVlQAwzjrv9UpaOcOxuS1OOK1n4bHUnSiclMjqhK
 7uTnYGGYWBmJx9yRhyzZXRZ06a/PyRhr6U3THDwc+IzuK3t4jHMf9Y0ul1U2EHaUgGawkyjbTRu
 9PR5DEbJBJC+XtA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: C67BE464B2A
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
	TAGGED_FROM(0.00)[bounces-21099-lists,linux-nfs=lfdr.de];
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
index ee32e61b6d3c..face5390c614 100644
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
+		 * -EINVAL: ntfs-3g and other FUSE filesystems that lack
+		 * FS_IOC_FSGETXATTR support.
+		 */
+		if (err && err != -ENOIOCTLCMD && err != -ENOTTY &&
+		    err != -EINVAL) {
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



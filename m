Return-Path: <linux-nfs+bounces-22552-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E9tvDiGfLmqj0gQAu9opvQ
	(envelope-from <linux-nfs+bounces-22552-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 14:31:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5E681056
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 14:31:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vastdata.com header.s=google header.b="Cn/3lTeT";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22552-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22552-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=vastdata.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31A0E3000FD5
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jun 2026 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6D19995E;
	Sun, 14 Jun 2026 12:31:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098B175A8D
	for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 12:31:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781440285; cv=none; b=Tl8YB3DB4pRNsYDrT3w9hbfwY/2Gvi+kOPl6xHnDv0cpDzGyy4tefa1zjp2yJ/DyVtsd2dJcCN4MZwTv+UnlOk8KB7Yq8wH/ENL57P/567r5moYMbm4gPIFPfJJkpfFMOk4alMt2eYThMp4eicFjkfZLqFV+eQ6tYa/zYWE3Y90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781440285; c=relaxed/simple;
	bh=Jjr3/hs+Sc27IAVo6yHzfZLj0Qaod2OleNJSJh+d8BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oLbEOXNmUhbWxjTgb7pwC1+xwNBGLYXtlgH5lXikaVpK9Fo2h5xxvzWIcZNZTxA4AW3cTNfLA75U21Q1TN+sPR4TipQ/0nx1PifBxHFIkCNBdUeKjTEOsmwQIDkOd2kV3Ia5iDEkwxNtMTaWdrNnlI6zhuTCgNmS1ySG/0SH8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=Cn/3lTeT; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso23015115e9.3
        for <linux-nfs@vger.kernel.org>; Sun, 14 Jun 2026 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1781440283; x=1782045083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl3f6IB/EdYT7ZgQdMViKvqehoODAVVnXXP3yydeXu8=;
        b=Cn/3lTeTIzZUmk5e+XNsswLFWR5LCHrxbivvYTlfjaaHhaQmIj6kOEWOhlfrdQUA3l
         jjavx+laZL6HbC1o9nS6sHuAQBCyqGok79UtSpCv1LXKEKTjC986oIjk3KBMycY8BA8r
         wa1wPsy6G2/xE2qgSz+AXCFVbADwRjP/h/gYkmXJokMaakzb2h4DmXbxEiVYrm76PXZy
         ykgHibFD1XjLLLHtZEpyTsV0pmrVgKV1iGPIWET/b59lc+oFsOZG/cuIWucPOarx3aKq
         2r0kWymAnAtYLqjPBgmTbscPeK+mqw1xS4j1lLM26dHHuU08nrzmheVVJVtRiqO58o59
         DAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781440283; x=1782045083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl3f6IB/EdYT7ZgQdMViKvqehoODAVVnXXP3yydeXu8=;
        b=J20C5xHlW3B6f1WKAfzsf+Ngnw/TdkdO8BYz+vpZTHaI04MWZoWNBNR70cDnR0d3/9
         g9SpO7ufZUxXyKQGFm0BLOiDTfT+kO7XYeJIJx9MwHYfELbMCRLUCjlqbZETaODvufeA
         jvYJEOfqjcbstPtlz2BdSMBJQk5iFIZC02Hvt3mNb14nHc19dSitI7ddKL+Fsrr/yGxw
         ozF2dN+c9M2X89pSiROFafjblqyjkOtgVBRRgGM2fprnjrlq8S3FVWRgMVvNtYDq5U3g
         hAJkrIfQcEQXlfLgAC47/Gkur7fMgMl4WqgDloma3qjyl2VxXctZnmMS0mAsvqRiLBQE
         e9hg==
X-Gm-Message-State: AOJu0Yz196A1gd9KBVOQBTBN7UY6LuzB310/JusNaCSKxJlm5z8ed48T
	tkUhbKufzEQeY2Dn6G3OzoGgbS7RGAdMhFwR/4lXzjn7U2motslnUFAWl+VrW7CmfZjgiYooUHI
	J+ys=
X-Gm-Gg: Acq92OF5FXbH4cD0P67RWHSd+Qn3ZSy94v4eGh9qwU43IxlebcQJ2/12qCXlsnp9uHi
	dhMJVj1q849Qe3t3xvL8/l4t47Y5JViNfirrQfALTVDsoLKyXk6xVR6VTLGGqolk9ZgohjlkPjM
	uzEYAOxDodYPEFO8vhshixMrc/StOGL0ldAiV277AhfsWwVhjERMZXUraFcWGdiuNc2gRvB2De2
	tM8yHnSxBB0jpnRaaAS9XWm46nG+qK0fX8kvea8606VbcutxhRYGX2nQGnWIWnoQD5Ao8FoEIhA
	KAUlLei5lQaSonN5mDd5NpJ+tKxmR2IoVQu3hAnLWkHWeZKGV8P16KujzZRcnmYivCytjk593sN
	84Wazl5mtRJ4EfX0Pj8lnWJPxQJ5Zz0kbnzSVHK7dyamit4TJNAiADcXgO68brU3WylqSSx++2a
	HUy5Hdz15K/JIDueXSIhoumoLWT95N1OTwiB6H3A8EMqfNPn+zvL0Y36wcdw==
X-Received: by 2002:a05:600c:154b:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-4922005e579mr84821315e9.3.1781440282843;
        Sun, 14 Jun 2026 05:31:22 -0700 (PDT)
Received: from l29.vastdata.com ([62.90.223.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm171073985e9.1.2026.06.14.05.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:31:22 -0700 (PDT)
From: Michael Nemanov <michael.nemanov@vastdata.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	neil@brown.name
Cc: linux-nfs@vger.kernel.org,
	michael.nemanov@vastdata.com
Subject: [PATCH] nfs: fix ENXIO on O_CREAT open of existing symlink over NFSv3
Date: Sun, 14 Jun 2026 12:29:11 +0000
Message-ID: <20260614122911.3485467-1-michael.nemanov@vastdata.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[vastdata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[vastdata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[vastdata.com:+];
	FORGED_SENDER(0.00)[michael.nemanov@vastdata.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:linux-nfs@vger.kernel.org,m:michael.nemanov@vastdata.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22552-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.nemanov@vastdata.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFF5E681056

When open(2) is called with O_CREAT on a path that already exists as a
symlink, over an NFSv3 mount with a cold dcache, the kernel returns
ENXIO instead of following the symlink to its target.

Reproducer script (MNT is an NFSv3 mount, kernel is 7.1-rc6):

MNT=/mnt/export
ln -sf /tmp/target $MNT/mylink
echo 3 | sudo tee /proc/sys/vm/drop_caches   # cold dcache

python3 - <<'EOF'
import os
fd = os.open('/mnt/export/mylink', os.O_WRONLY | os.O_CREAT | os.O_APPEND, 0o666)
os.close(fd)
EOF

Expected: success (follow symlink, open target)
Actual:   OSError: [Errno 6] No such device or address

The bug does not trigger when the dcache is warm (e.g. after a prior
stat(2)), because lookup_open() then finds a positive dentry and skips
atomic_open entirely, leaving symlink resolution to the VFS.

Root cause:
nfs_atomic_open_v23(), registered as inode->i_op->atomic_open for
NFSv3, handles O_CREAT by sending a CREATE UNCHECKED RPC. As
implemented in nfsd3_create_file() (fs/nfsd/nfs3proc.c) and as required
by RFC 1813 (3.3.8), when the name already exists as a non-regular file
the server returns NFS3_OK with the existing object's file handle rather
than NFS3ERR_EXIST causing nfs_do_create() to return 0 with the
dentry now pointing to a symlink.
The code then unconditionally calls finish_open(), which dispatches
through inode->i_fop->open(). Symlink inodes never have i_fop set — the
VFS initialises it to &no_open_fops because POSIX requires open(2) to
follow symlinks, never open them directly. no_open() returns -ENXIO.

Fix:
After nfs_do_create() succeeds, verify the returned inode is a regular
file before calling finish_open(). If the object is not regular, return
finish_no_open() so the VFS follows the symlink through the normal open path.
!S_ISREG() is used rather than S_ISLNK() to cover any other non-regular types
a server might return.

Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.")
Signed-off-by: Michael Nemanov <michael.nemanov@vastdata.com>
Tested-by: Michael Nemanov <michael.nemanov@vastdata.com>
---
 fs/nfs/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c5..6c78b06dd8699 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2317,6 +2317,13 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	if (open_flags & O_CREAT) {
 		error = nfs_do_create(dir, dentry, mode, open_flags);
 		if (!error) {
+			/* With UNCHECKED mode, a server may return NFS3_OK for
+			 * a pre-existing non-regular file (e.g. a symlink).
+			 * Let the VFS handle it; calling finish_open() would
+			 * hit no_open() and return -ENXIO.
+			 */
+			if (d_inode(dentry) && !S_ISREG(d_inode(dentry)->i_mode))
+				return finish_no_open(file, dentry);
 			file->f_mode |= FMODE_CREATED;
 			return finish_open(file, dentry, NULL);
 		} else if (error != -EEXIST || open_flags & O_EXCL)
-- 
2.43.7



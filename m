Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD18104392
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Nov 2019 19:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfKTSnb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Nov 2019 13:43:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53435 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfKTSnb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Nov 2019 13:43:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so783596wmc.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Nov 2019 10:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWtKaHD4c8MlSjqmMDbUt3wy9WiLfkw2U8AGc96fq8o=;
        b=jv5mEDHZ+RJlGh6d0Na5XHV0+LQ1gIRMFPkX/YXkCRVYAM89mnP90N7dSqWv1SGjPb
         phQZzdbcTx5HG/6E6sjyx/M+v0fBsumCJZd0Zm1H14R+j6UDZNFgp2/VDvyeorqiKDmH
         aTKlgq/RDK/HaUCR9ThNBwah1eg7EtCFHV6et65AeAtSp7rnjaPhZHTfTymQOytHp+TO
         2JaHyYhn/5jd0xjY1RKSUnGbpXxTqqRorcqb1iq0HocKAcmonwueJoxqGdMsZXaO1LlT
         S+srwCIlJdhSbcp23LGontSjdk9uNrHjHISNblfk7fYa3iFcsq7jeTrSrvH8w8w4pGPw
         AZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWtKaHD4c8MlSjqmMDbUt3wy9WiLfkw2U8AGc96fq8o=;
        b=mqp0MOJtHbL/GLXJ5g8TBNb2iw7N2ebAE47FpIlQobDyBvFYYK9MTfUld++HD1K2SB
         ywp0kAadt/uZIGd9hgZi/d6qQcTPNRKH6qo0vSJUjoNJJu0BFgYov4rUuGrLM4FPC4GN
         D9OO4nurIBODOtRyuFpGnfyuVS3ZkGv6XbnfKd3RYhHqQqeFPIJWoxchauEh6cxPnNTD
         FilS5IVOdF6pCW6HlQPsrSFVvjyguz2hpy5ntIe2zAElIBzax/IaN4NDCxixYPf6J09U
         d33NCd0+BiXNVYpF2RE6umqfpcG6hq+doxyTEaUoupsZpfT8oeljbbThH9vEPQTWVJjQ
         iO0w==
X-Gm-Message-State: APjAAAV+9eSAb/PzIL5fffHQdVh5FsNMYGjyr/H4RfVQls5/e541C7qF
        RgBf70lh0oueOFkejwbeAckWJ/GW
X-Google-Smtp-Source: APXvYqwDYqdgb94ABGaWCMDZBNCoKIkD9afKN2DU/n5/t/IMzzCciZ5uSm5xlkMiLI2Yb5Gxtnmd5Q==
X-Received: by 2002:a1c:7d47:: with SMTP id y68mr5015673wmc.157.1574274937472;
        Wed, 20 Nov 2019 10:35:37 -0800 (PST)
Received: from dell5510.arch.suse.de ([178.21.189.11])
        by smtp.gmail.com with ESMTPSA id s11sm157035wrr.43.2019.11.20.10.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:35:36 -0800 (PST)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Joey Hess <joeyh@debian.org>, Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Petr Vorel <petr.vorel@gmail.com>
Subject: [nfs-utils PATCH 1/1] mount: Do not overwrite /etc/mtab if it's symlink
Date:   Wed, 20 Nov 2019 19:35:29 +0100
Message-Id: <20191120183529.29366-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Joey Hess <joeyh@debian.org>

Some systems have /etc/mtab symlink to /proc/mounts. In that case
mount.nfs complains:
Can't set permissions on mtab: Operation not permitted

See https://bugs.debian.org/476577

This change makes mount.nfs handle symlinked /etc/mtab the way
umount.nfs and util- linux handle it.

Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Joey Hess <joeyh@debian.org>
[ pvorel: took patch from Debian, rebased for 2.4.3-rc1 and created commit
message. Patch is also used in Gentoo. ]
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

if you merge, please keep Joey as the author in git :).

Kind regards,
Petr

 utils/mount/fstab.c | 2 +-
 utils/mount/fstab.h | 1 +
 utils/mount/mount.c | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/utils/mount/fstab.c b/utils/mount/fstab.c
index 8b0aaf1a..146d8f40 100644
--- a/utils/mount/fstab.c
+++ b/utils/mount/fstab.c
@@ -61,7 +61,7 @@ mtab_does_not_exist(void) {
 	return var_mtab_does_not_exist;
 }
 
-static int
+int
 mtab_is_a_symlink(void) {
         get_mtab_info();
         return var_mtab_is_a_symlink;
diff --git a/utils/mount/fstab.h b/utils/mount/fstab.h
index 313bf9b3..8676c8c2 100644
--- a/utils/mount/fstab.h
+++ b/utils/mount/fstab.h
@@ -7,6 +7,7 @@
 #define _PATH_FSTAB "/etc/fstab"
 #endif
 
+int mtab_is_a_symlink(void);
 int mtab_is_writable(void);
 int mtab_does_not_exist(void);
 void reset_mtab_info(void);
diff --git a/utils/mount/mount.c b/utils/mount/mount.c
index 91f10877..92a0dfe4 100644
--- a/utils/mount/mount.c
+++ b/utils/mount/mount.c
@@ -204,6 +204,13 @@ create_mtab (void) {
 	int flags;
 	mntFILE *mfp;
 
+	/* Avoid writing if the mtab is a symlink to /proc/mounts, since
+	   that would create a file /proc/mounts in case the proc filesystem
+	   is not mounted, and the fchmod below would also fail. */
+	if (mtab_is_a_symlink()) {
+		return EX_SUCCESS;
+	}
+
 	lock_mtab();
 
 	mfp = nfs_setmntent (MOUNTED, "a+");
-- 
2.24.0


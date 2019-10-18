Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66292DCCE0
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2019 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502610AbfJRRdr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Oct 2019 13:33:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45177 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfJRRdq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Oct 2019 13:33:46 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so8344737iot.12;
        Fri, 18 Oct 2019 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/8ZkD5unpKQz71lZsRBg9s8TLjbCyqGQCiRLFyW9r0=;
        b=W1TcJrOGUIVkwGk56+jaLhFR/HuKc6Zvd4frTDA0Q6PEjoEnUpbwUoZqC5sFSBeu5k
         nskGHUaDD8DNW1JzZAsjUGz8vVD4Oc1EXlLD0BTbkwx33pZ57/roS/+DPTdjjgf+SY7B
         w2pmkIW9r7Qp7n9CJEZO+lCZWMLYSikrQ4j4CU56Wa8F52haYqDFu8x5MHKhyk/geRRl
         moH83TwNLqMe8cr6uEF/7Hg3DHFiOkYTcPVkriQyLWZjB2nDibjPMwOGT5zPXKMRMcre
         RafpenpBrJLZ9VtIYHQrF9tLQD8HTpNIo6eNGnCr0/awPGmg9adn3tjm5cMBbeQw4AvK
         hEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1/8ZkD5unpKQz71lZsRBg9s8TLjbCyqGQCiRLFyW9r0=;
        b=VUkWsWZ3Gqahx+LXSxMnBmu2IgTEpigP6Q5sDXaEca79cLOXMm1N/d0LoWCLq9TnIn
         4M6EV8el3xgDK4q0J35RPnIJQ4M953n00lpdG3Ecu74lfNyRyu5dlb2HHoMCvp0DqOs5
         cqOtH5PJDAPEW6COCSL6EE5dHVsZCe+DUnAwSPTnvudmV8835Ozb8v81z2t9v2fNK2zI
         j8fwWhfiXTvEcqyUB/BAeMH3OT7ND6DnyZ86fSDalx5QAgx9O9FxuJOCxXskHyWtJhGU
         I+W6F2wVtavhVFFpagx1Vd4Dn2txnQNkjgW03p5uWzvkvSIHf6Wo7AyClusdORNYAU5c
         4yAg==
X-Gm-Message-State: APjAAAU84cq3/+AATK/oKgQ6rDNsLsEJbOuRzoDsZgnM39DBbCG56N6s
        vYcyrVsPEfNoObWjO+mSJ66CiMfa
X-Google-Smtp-Source: APXvYqwtcYHbdSvYFO83Tt7CqUKWHPeFXpGV76jqJPVPpuLjS163z5MP9Eb6A4+wAus6G5JD0daBxg==
X-Received: by 2002:a6b:908:: with SMTP id t8mr2080611ioi.129.1571420025422;
        Fri, 18 Oct 2019 10:33:45 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id m14sm2416871ild.3.2019.10.18.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:33:44 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/2] generic: Create new outfile for 035 over NFS
Date:   Fri, 18 Oct 2019 13:33:42 -0400
Message-Id: <20191018173343.303032-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Rename-overwrites over NFS work with a "silly rename" over the network,
so the nlink count stays at 1 instead of dropping to 0. This is expected
behavior for NFS, so we should use a different golden output file to
account for this.

 See the NFS faq at: nfs.sourceforge.net/#faq_d2 for more information
about silly renames.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 .gitignore                                 | 1 +
 common/rc                                  | 2 +-
 tests/generic/035                          | 4 ++++
 tests/generic/035.cfg                      | 1 +
 tests/generic/{035.out => 035.out.default} | 0
 tests/generic/035.out.nfs                  | 5 +++++
 6 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 tests/generic/035.cfg
 rename tests/generic/{035.out => 035.out.default} (100%)
 create mode 100644 tests/generic/035.out.nfs

diff --git a/.gitignore b/.gitignore
index 02734429..6c11a401 100644
--- a/.gitignore
+++ b/.gitignore
@@ -254,6 +254,7 @@
 /dmapi/src/suite2/src/test_rights
 
 # Symlinked files
+/tests/generic/035.out
 /tests/xfs/033.out
 /tests/xfs/071.out
 /tests/xfs/096.out
diff --git a/common/rc b/common/rc
index cfaabf10..562d48d8 100644
--- a/common/rc
+++ b/common/rc
@@ -2848,7 +2848,7 @@ _link_out_file()
 	local features
 
 	if [ $# -eq 0 ]; then
-		features="$(_get_os_name)"
+		features="$(_get_os_name),$FSTYP"
 		if [ -n "$MOUNT_OPTIONS" ]; then
 			features=$features,${MOUNT_OPTIONS##"-o "}
 		fi
diff --git a/tests/generic/035 b/tests/generic/035
index 44db45e6..8da3bc99 100755
--- a/tests/generic/035
+++ b/tests/generic/035
@@ -6,6 +6,7 @@
 #
 # Check overwriting rename system call
 #
+seqfull=$0
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -29,6 +30,9 @@ _supported_os Linux
 
 _require_test
 
+# Select appropriate golden output based on fstype
+_link_out_file
+
 # real QA test starts here
 
 rename_dir=$TEST_DIR/$$
diff --git a/tests/generic/035.cfg b/tests/generic/035.cfg
new file mode 100644
index 00000000..d02b0ce9
--- /dev/null
+++ b/tests/generic/035.cfg
@@ -0,0 +1 @@
+nfs: nfs
diff --git a/tests/generic/035.out b/tests/generic/035.out.default
similarity index 100%
rename from tests/generic/035.out
rename to tests/generic/035.out.default
diff --git a/tests/generic/035.out.nfs b/tests/generic/035.out.nfs
new file mode 100644
index 00000000..6359197f
--- /dev/null
+++ b/tests/generic/035.out.nfs
@@ -0,0 +1,5 @@
+QA output created by 035
+overwriting regular file:
+nlink is 1, should be 0
+overwriting directory:
+t_rename_overwrite: fstat(3): Stale file handle
-- 
2.23.0


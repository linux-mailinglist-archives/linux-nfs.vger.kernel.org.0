Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D24264F89
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIJTpq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 15:45:46 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:34788 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIJTpk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 15:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599767140; x=1631303140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6IYqoqN49rcKyFd+M8E2CkqUikBu6MG8xK08IhY9Z5g=;
  b=h/hKDJrLgK+J8I+fNMKYV1Z5DRudMxCsYlQuhSRfuhjre1bwQ/gvLoR3
   tcdxIred/DAfOX6aXRxNBh9bOyULwaCqkT7jlWSE9Anfb60EKdizpS5IK
   HiOA8/S0+/+f+wTYlmz0qBg5g8GlArSc6Y48nPZHRd67uV/zl4YrjSERZ
   o=;
X-IronPort-AV: E=Sophos;i="5.76,413,1592870400"; 
   d="scan'208";a="74009304"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Sep 2020 19:43:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id C3F30A1DE9;
        Thu, 10 Sep 2020 19:43:57 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 19:43:57 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 19:43:56 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 10 Sep 2020 19:43:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 9E614C15D0; Thu, 10 Sep 2020 19:43:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <fstests@vger.kernel.org>
CC:     <linux-nfs@vger.kernel.org>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 3/3] fstests: explicitly specify xattr namespace
Date:   Thu, 10 Sep 2020 19:43:55 +0000
Message-ID: <20200910194355.5977-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200910194355.5977-1-fllinden@amazon.com>
References: <20200910194355.5977-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Explicitly specify the xattr namespace required for tests.
This allows tests to be skipped correctly for filesystems
that don't support all xattr namespaces.

This changes all tests that require anything other than
the "user" xattr namespace. When called without arguments
as before, _require_attrs() still defaults to the "user"
namespace, so those tests do not need to be changed.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 tests/generic/062 | 4 ++++
 tests/generic/093 | 2 +-
 tests/generic/097 | 2 +-
 tests/generic/403 | 2 +-
 tests/generic/449 | 2 +-
 tests/overlay/011 | 2 +-
 tests/overlay/026 | 2 +-
 tests/overlay/038 | 2 +-
 tests/overlay/041 | 2 +-
 tests/overlay/045 | 2 +-
 tests/overlay/046 | 2 +-
 tests/overlay/056 | 2 +-
 tests/xfs/063     | 2 +-
 tests/xfs/267     | 2 +-
 tests/xfs/268     | 2 +-
 15 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tests/generic/062 b/tests/generic/062
index cab4b4fa..78c1c95c 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -82,6 +82,10 @@ else
     ATTR_MODES="user trusted"
     ATTR_FILTER="^(user|trusted)"
 fi
+
+_require_attrs $ATTR_MODES
+
+
 for nsp in $ATTR_MODES; do
 	for inode in reg dir lnk dev/b dev/c dev/p; do
 
diff --git a/tests/generic/093 b/tests/generic/093
index 10fdcfc7..7ffcfb7d 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -35,7 +35,7 @@ _supported_fs generic
 _supported_os Linux
 
 _require_test
-_require_attrs
+_require_attrs security
 _require_user
 _require_test_program "writemod"
 _require_command "$SETCAP_PROG" "setcap"
diff --git a/tests/generic/097 b/tests/generic/097
index 39730bb0..c2c82460 100755
--- a/tests/generic/097
+++ b/tests/generic/097
@@ -48,7 +48,7 @@ _supported_fs generic
 _supported_os Linux
 
 _require_test
-_require_attrs
+_require_attrs user trusted
 
 echo -e "\ncreate file foo"
 rm -f $file
diff --git a/tests/generic/403 b/tests/generic/403
index 39c64061..9d9ea539 100755
--- a/tests/generic/403
+++ b/tests/generic/403
@@ -36,7 +36,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_attrs
+_require_attrs trusted
 
 _scratch_mkfs > $seqres.full 2>&1 || _fail "mkfs"
 _scratch_mount
diff --git a/tests/generic/449 b/tests/generic/449
index 21b920bf..129ac9a8 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -39,7 +39,7 @@ _supported_os Linux
 _require_scratch
 _require_test
 _require_acls
-_require_attrs
+_require_attrs trusted
 
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount || _fail "mount failed"
diff --git a/tests/overlay/011 b/tests/overlay/011
index 1d09341b..b491c37a 100755
--- a/tests/overlay/011
+++ b/tests/overlay/011
@@ -37,7 +37,7 @@ _supported_fs overlay
 _supported_os Linux
 _require_test
 _require_scratch
-_require_attrs
+_require_attrs trusted
 
 # Remove all files from previous tests
 _scratch_mkfs
diff --git a/tests/overlay/026 b/tests/overlay/026
index d0d2a5bf..84fc2412 100755
--- a/tests/overlay/026
+++ b/tests/overlay/026
@@ -53,7 +53,7 @@ rm -f $seqres.full
 _supported_fs overlay
 _supported_os Linux
 _require_scratch
-_require_attrs
+_require_attrs trusted
 
 # Remove all files from previous tests
 _scratch_mkfs
diff --git a/tests/overlay/038 b/tests/overlay/038
index 25f9979b..98267d33 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -32,7 +32,7 @@ _supported_os Linux
 # Use non-default scratch underlying overlay dirs, we need to check
 # them explicity after test.
 _require_scratch_nocheck
-_require_attrs
+_require_attrs trusted
 _require_test_program "t_dir_type"
 
 rm -f $seqres.full
diff --git a/tests/overlay/041 b/tests/overlay/041
index 277fb913..d23de4f9 100755
--- a/tests/overlay/041
+++ b/tests/overlay/041
@@ -35,7 +35,7 @@ _supported_os Linux
 # them explicity after test.
 _require_scratch_nocheck
 _require_test
-_require_attrs
+_require_attrs trusted
 _require_test_program "t_dir_type"
 
 rm -f $seqres.full
diff --git a/tests/overlay/045 b/tests/overlay/045
index 34b7ce4c..e5e65734 100755
--- a/tests/overlay/045
+++ b/tests/overlay/045
@@ -33,7 +33,7 @@ rm -f $seqres.full
 _supported_fs overlay
 _supported_os Linux
 _require_scratch_nocheck
-_require_attrs
+_require_attrs trusted
 _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
 
 OVL_XATTR_OPAQUE_VAL=y
diff --git a/tests/overlay/046 b/tests/overlay/046
index 36c74207..fe912ff3 100755
--- a/tests/overlay/046
+++ b/tests/overlay/046
@@ -33,7 +33,7 @@ rm -f $seqres.full
 _supported_fs overlay
 _supported_os Linux
 _require_scratch_nocheck
-_require_attrs
+_require_attrs trusted
 _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
 
 # remove all files from previous tests
diff --git a/tests/overlay/056 b/tests/overlay/056
index dc7b98cb..35169c36 100755
--- a/tests/overlay/056
+++ b/tests/overlay/056
@@ -33,7 +33,7 @@ rm -f $seqres.full
 _supported_fs overlay
 _supported_os Linux
 _require_scratch_nocheck
-_require_attrs
+_require_attrs trusted
 _require_command "$FSCK_OVERLAY_PROG" fsck.overlay
 
 OVL_XATTR_IMPURE_VAL=y
diff --git a/tests/xfs/063 b/tests/xfs/063
index b6d4c03a..85ab1aa8 100755
--- a/tests/xfs/063
+++ b/tests/xfs/063
@@ -32,7 +32,7 @@ _cleanup()
 _supported_fs xfs
 _supported_os Linux
 
-_require_attrs
+_require_attrs trusted user
 
 # create files with EAs
 _create_dumpdir_fill_ea
diff --git a/tests/xfs/267 b/tests/xfs/267
index d13ec19a..f0c60350 100755
--- a/tests/xfs/267
+++ b/tests/xfs/267
@@ -52,7 +52,7 @@ _supported_fs xfs
 _supported_os Linux
 
 _require_tape $TAPE_DEV
-_require_attrs
+_require_attrs trusted
 
 _create_files
 _erase_hard
diff --git a/tests/xfs/268 b/tests/xfs/268
index fa5b9283..07034671 100755
--- a/tests/xfs/268
+++ b/tests/xfs/268
@@ -55,7 +55,7 @@ _supported_fs xfs
 _supported_os Linux
 
 _require_tape $TAPE_DEV
-_require_attrs
+_require_attrs trusted user
 
 _create_files
 _erase_hard
-- 
2.16.6


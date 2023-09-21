Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E627A988F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Sep 2023 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjIURuG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Sep 2023 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjIURtw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Sep 2023 13:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3330DE
        for <linux-nfs@vger.kernel.org>; Thu, 21 Sep 2023 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y0ax/dHqXYgyiJqtUUajFliIPWSkSwMmazUAOco5xqs=;
        b=TEI6aqUbVo9sQq1gTJIfRc+NIY4cP8g40/AHd7FwigoBE4RLhn4Ob0A+JoxIRT5cXvBqfE
        mwDznkVQdE1cJ7fvVgwq59vyWJDoIaAE4//oj9j/V1R2fqOqJwOEQ8Ko3lYn6FBn8ZltVY
        uoh1X+6q/xigS8bnyPzCSwkllYQabHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-3x0h7vyePY6Brrq1DpIKSA-1; Thu, 21 Sep 2023 09:44:09 -0400
X-MC-Unique: 3x0h7vyePY6Brrq1DpIKSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36D958030CB;
        Thu, 21 Sep 2023 13:44:09 +0000 (UTC)
Received: from localhost (yoyang-vm.hosts.qa.psi.pek2.redhat.com [10.73.149.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90286C15BB8;
        Thu, 21 Sep 2023 13:44:08 +0000 (UTC)
From:   Yongcheng Yang <yoyang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, zlang@redhat.com,
        Yongcheng Yang <yoyang@redhat.com>
Subject: [PATCH] generic/471: add a test to check move in mountpoints of the same export
Date:   Thu, 21 Sep 2023 21:43:47 +0800
Message-Id: <20230921134347.839957-1-yoyang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a new test to ckeck file move (rename) operation among
different mount points which are mounting to a same export.

This should be a simple test but it recently unveils an ancient
nfsd bug. Thus let's make it to be a regresstion check.

Signed-off-by: Yongcheng Yang <yoyang@redhat.com>
---

Hi,

There is an ancient nfsd problem just pop up and is now resolved by
the upstream commit [1]. Looks like it's a basic and simple test which
is probably appropriate for the fstest IMO.

This test in nfs will be failed without patch [1]:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root@kvm-07-guest24 xfstests]# ./check -nfs generic/471
FSTYP     	-- nfs
PLATFORM  	-- Linux/x86_64 kvm-07-guest24 5.14.0-abc.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Sep 13 04:59:08 EDT 2023
MKFS_OPTIONS  -- localhost:/export_test2
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 localhost:/export_test2 /mnt_scratch

generic/471 1s ... - output mismatch (see /root/xfstests/results//generic/471.out.bad)
	--- tests/generic/471.out    2023-09-21 05:55:28.514673177 -0400
	+++ /root/xfstests/results//generic/471.out.bad    2023-09-21 08:06:16.935695355 -0400
	@@ -1,2 +1,3 @@
 	QA output created by 471
 	Silence is golden
	+mv: '/mnt_test/mountpoint1-471/A/f' and '/mnt_test/mountpoint1-471/B/f' are the same file
	...
	(Run 'diff -u /root/xfstests/tests/generic/471.out /root/xfstests/results//generic/471.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
  	fdd2630a739819 nfsd: fix change_info in NFSv4 RENAME replies

Ran: generic/471
Failures: generic/471
Failed 1 of 1 tests

[root@kvm-07-guest24 xfstests]#
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

And it can pass after that patch [1] merged:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root@fsqe-r6515-02 xfstests]# ./check -nfs generic/471
FSTYP     	-- nfs
PLATFORM  	-- Linux/x86_64 fsqe-r6515-02 5.14.0-abcd.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Sep 19 08:10:36 EDT 2023
MKFS_OPTIONS  -- localhost:/export_test1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 localhost:/export_test1 /mnt_scratch

generic/471    	0s
Ran: generic/471
Passed all 1 tests

[root@fsqe-r6515-02 xfstests]#
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Also I have just checked the xfs and overlayfs but the latter get failed:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[root@fsqe-r6515-02 xfstests]# ./check generic/471
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 fsqe-r6515-02 5.14.0-abcd.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Sep 19 08:10:36 EDT 2023
MKFS_OPTIONS  -- -f /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt_scratch

generic/471 0s ...  1s
Ran: generic/471
Passed all 1 tests

[root@fsqe-r6515-02 xfstests]#
[root@fsqe-r6515-02 xfstests]# ./check -overlay generic/471
FSTYP         -- overlay
PLATFORM      -- Linux/x86_64 fsqe-r6515-02 5.14.0-abcd.el9.x86_64 #1 SMP PREEMPT_DYNAMIC Tue Sep 19 08:10:36 EDT 2023
MKFS_OPTIONS  -- /mnt_scratch
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /mnt_scratch /mnt_scratch/ovl-mnt

generic/471 0s ... - output mismatch (see /root/xfstests/results//generic/471.out.bad)
    --- tests/generic/471.out	2023-09-21 09:02:14.580495256 -0400
    +++ /root/xfstests/results//generic/471.out.bad	2023-09-21 09:02:51.145345830 -0400
    @@ -1,2 +1,3 @@
     QA output created by 471
     Silence is golden
    +mv: '/mnt_test/ovl-mnt/mountpoint1-471/A/f' and '/mnt_test/ovl-mnt/mountpoint1-471/B/f' are the same file
    ...
    (Run 'diff -u /root/xfstests/tests/generic/471.out /root/xfstests/results//generic/471.out.bad'  to see the entire diff)
Ran: generic/471
Failures: generic/471
Failed 1 of 1 tests

[root@fsqe-r6515-02 xfstests]#
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For now I'm not sure if the overlayfs don't support this operation or
we just need to fix that.

Thanks,
Yongcheng

[1] https://lore.kernel.org/linux-nfs/ZPyMyv1nNFV2whKP@tissot.1015granger.net/T/#t


 tests/generic/471     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/471.out |  2 ++
 2 files changed, 62 insertions(+)
 create mode 100755 tests/generic/471
 create mode 100644 tests/generic/471.out

diff --git a/tests/generic/471 b/tests/generic/471
new file mode 100755
index 00000000..ada48129
--- /dev/null
+++ b/tests/generic/471
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 471
+#
+# Mount the same export to different mount points and move (rename)
+# files among those mount points.
+# This simple test recently unveils an ancient nfsd bug that is fixed
+# by fdd2630a739819 ("nfsd: fix change_info in NFSv4 RENAME replies").
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	$UMOUNT_PROG $testdir1 2>/dev/null
+	$UMOUNT_PROG $testdir2 2>/dev/null
+	cd /
+	rm -r -f $tmp.*
+}
+
+# real QA test starts here
+
+_supported_fs generic
+[ "$FSTYP" = "nfs" ] && \
+	_fixed_by_kernel_commit fdd2630a739819 \
+		"nfsd: fix change_info in NFSv4 RENAME replies"
+
+_require_test
+_require_scratch
+
+echo "Silence is golden"
+
+_scratch_mkfs >> $seqres.full
+testdir1=$TEST_DIR/mountpoint1-$seq
+testdir2=$TEST_DIR/mountpoint2-$seq
+rm -rf $testdir1 $testdir2
+mkdir -p $testdir1 $testdir2
+
+# Don't share the data and attribute caches among mount points for NFS.
+# This caching behavior is necessary to reproduce this issue as we're
+# checking the alignment of each mount point's own unique cache.
+[ "$FSTYP" = "nfs" ] && MOUNT_OPTIONS="-o nosharecache"
+
+SCRATCH_MNT=$testdir1 _scratch_mount
+SCRATCH_MNT=$testdir2 _scratch_mount
+rm -rf $testdir1/{A,B}
+mkdir $testdir1/{A,B}
+touch $testdir1/A/f
+mv $testdir1/A/f $testdir1/B/
+cat $testdir2/B/f
+mv $testdir2/B/f $testdir2/A/
+cat $testdir1/A/f
+mv $testdir1/A/f $testdir1/B/
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/471.out b/tests/generic/471.out
new file mode 100644
index 00000000..260f629e
--- /dev/null
+++ b/tests/generic/471.out
@@ -0,0 +1,2 @@
+QA output created by 471
+Silence is golden
-- 
2.31.1


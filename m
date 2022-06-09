Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060854569F
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jun 2022 23:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiFIVmm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbiFIVmi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 17:42:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712EE66C8C
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 14:42:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E964822093;
        Thu,  9 Jun 2022 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654810952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZ0Hq0qm8ipf5wo4yqdMM0malZSmthJnC8vJcwZJ4SE=;
        b=0mUdtwNTFU4FNTwhpOKcB0rLQAKxG/d/k0BnzmQQ8q/J3QSOPx/4fZNaq14H95XwjYA/Dc
        xnfHViYcnL8khybUtIZCuZuRmN/PdwdoYUChHQG0/shLEzlHdNWxozpUGkUOEBLmSUwOfc
        w9mNh02MgmfXWCiFK+dII2kZOmGL5VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654810952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZ0Hq0qm8ipf5wo4yqdMM0malZSmthJnC8vJcwZJ4SE=;
        b=KjeDzG4ggOzqqJ0h0bZ+nb5DRP2sGXJPRNYam0GRgydSnvmMZ4ZwbgaOJSJl2TVF7G/PoR
        C8sKB+ao3XxSN4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8DF813A8C;
        Thu,  9 Jun 2022 21:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2DMoK0hpomIQDgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:32 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/9] tst_test.sh: Add $TST_ALL_FILESYSTEMS
Date:   Thu,  9 Jun 2022 23:42:19 +0200
Message-Id: <20220609214223.4608-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609214223.4608-1-pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt    |   1 +
 testcases/lib/tst_test.sh | 106 ++++++++++++++++++++++++--------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 65444541e..93073be13 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -199,6 +199,7 @@ simply by setting right '$TST_FOO'.
 [options="header"]
 |=============================================================================
 | Variable name            | Action done
+| 'TST_ALL_FILESYSTEMS'    | Testing on all available filesystems (tst_test.all_filesystems equivalent).
 | 'TST_DEV_EXTRA_OPTS'     | Pass extra 'mkfs' options _after_ device name,
                              to 'tst_mkfs', use with 'TST_FORMAT_DEVICE=1'.
 | 'TST_DEV_FS_OPTS'        | Pass 'mkfs' options _before_ the device name,
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index f9ff9bcb4..d96ce3448 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,23 +28,12 @@ fi
 trap "tst_brk TBROK 'test interrupted'" INT
 trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
 
+# FIXME: debug called more times => check things moved out of it
 _tst_do_exit()
 {
 	local ret=0
 	TST_DO_EXIT=1
 
-	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
-		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
-			$TST_CLEANUP
-		else
-			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
-		fi
-	fi
-
-	if [ "$TST_MOUNT_FLAG" = 1 ]; then
-		tst_umount
-	fi
-
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
 		if ! tst_device release "$TST_DEVICE"; then
 			tst_res TWARN "Failed to release device '$TST_DEVICE'"
@@ -61,8 +50,6 @@ _tst_do_exit()
 		rm $LTP_IPC_PATH
 	fi
 
-	_tst_cleanup_timer
-
 	if [ $TST_FAIL -gt 0 ]; then
 		ret=$((ret|1))
 	fi
@@ -613,17 +600,41 @@ _tst_init_checkpoints()
 	export LTP_IPC_PATH
 }
 
+_prepare_device()
+{
+	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
+		tst_clear_device $TST_DEVICE
+		tst_mkfs $TST_FS_TYPE $TST_DEV_FS_OPTS $TST_DEVICE $TST_DEV_EXTRA_OPTS
+	fi
+
+	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
+		tst_mount
+		TST_MOUNT_FLAG=1
+	fi
+}
+
+_tst_run_tcases_per_fs()
+{
+	for _tst_fs in $(tst_supported_fs); do
+		tst_res TINFO "Testing on $_tst_fs"
+		TST_FS_TYPE="$_tst_fs"
+		_prepare_device
+		_tst_run_iterations
+	done
+}
+
 tst_run()
 {
 	local _tst_i
 	local _tst_data
+	local _tst_fs
 	local _tst_max
 	local _tst_name
 
 	if [ -n "$TST_TEST_PATH" ]; then
 		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='\''"} \t\/:`].*//'); do
 			case "$_tst_i" in
-			DISABLE_APPARMOR|DISABLE_SELINUX);;
+			ALL_FILESYSTEMS|DISABLE_APPARMOR|DISABLE_SELINUX);;
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
@@ -668,12 +679,23 @@ tst_run()
 			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
 	fi
 
-	_tst_setup_timer
+	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
+	[ "$TST_ALL_FILESYSTEMS" = 1 ] && TST_MOUNT_DEVICE=1
 	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
 	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
+	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
+		TST_DEVICE=$(tst_device acquire)
+
+		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
+			unset TST_DEVICE
+			tst_brk TBROK "Failed to acquire device"
+		fi
+		TST_DEVICE_FLAG=1
+	fi
+
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
 		if [ -z "$TMPDIR" ]; then
 			export TMPDIR="/tmp"
@@ -684,35 +706,30 @@ tst_run()
 		chmod 777 "$TST_TMPDIR"
 
 		TST_STARTWD=$(pwd)
-
 		cd "$TST_TMPDIR"
 	fi
 
-	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
-	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
-
-		TST_DEVICE=$(tst_device acquire)
+	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
 
-		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
-			unset TST_DEVICE
-			tst_brk TBROK "Failed to acquire device"
-		fi
+	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"
+	[ -z "$TST_ALL_FILESYSTEMS" ] && _prepare_device
 
-		TST_DEVICE_FLAG=1
+	if [ -n "$TST_ALL_FILESYSTEMS" ]; then
+		_tst_run_tcases_per_fs
+	else
+		_tst_run_iterations
 	fi
 
-	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
+	_tst_do_exit
+}
 
-	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
-		tst_mkfs $TST_FS_TYPE $TST_DEV_FS_OPTS $TST_DEVICE $TST_DEV_EXTRA_OPTS
-	fi
+_tst_run_iterations()
+{
+	local _tst_i=$TST_ITERATIONS
 
-	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
-		tst_mount
-		TST_MOUNT_FLAG=1
-	fi
+	[ "$TST_NEEDS_TMPDIR" = 1 ] && cd "$TST_TMPDIR"
 
-	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
+	_tst_setup_timer
 
 	if [ -n "$TST_SETUP" ]; then
 		if command -v $TST_SETUP >/dev/null 2>/dev/null; then
@@ -724,7 +741,7 @@ tst_run()
 	fi
 
 	#TODO check that test reports some results for each test function call
-	while [ $TST_ITERATIONS -gt 0 ]; do
+	while [ $_tst_i -gt 0 ]; do
 		if [ -n "$TST_TEST_DATA" ]; then
 			tst_require_cmds cut tr wc
 			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
@@ -735,9 +752,22 @@ tst_run()
 		else
 			_tst_run_tests
 		fi
-		TST_ITERATIONS=$((TST_ITERATIONS-1))
+		_tst_i=$((_tst_i-1))
 	done
-	_tst_do_exit
+
+	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
+		if command -v $TST_CLEANUP >/dev/null 2>/dev/null; then
+			$TST_CLEANUP
+		else
+			tst_res TWARN "TST_CLEANUP=$TST_CLEANUP declared, but function not defined (or cmd not found)"
+		fi
+	fi
+
+	if [ "$TST_MOUNT_FLAG" = 1 ]; then
+		tst_umount
+	fi
+
+	_tst_cleanup_timer
 }
 
 _tst_run_tests()
-- 
2.36.1


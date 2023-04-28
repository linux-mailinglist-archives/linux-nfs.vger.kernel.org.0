Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FE6F1C1D
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjD1QAh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346060AbjD1QAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 12:00:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4481D4212
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 09:00:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0532B21F19;
        Fri, 28 Apr 2023 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682697632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXr3jO0Jo+PRsPOiEfh7gt67xxYugYqoebtocvtOm3I=;
        b=aSHtLIq3rmqyAmKke3R8p9bjbaTG2g3cuA5VyP12SUN1jWTr4/S/P2kqrF45dz6hLovSLV
        5GwlfxtmdyhMGrXljkP5/eiouveRRE1gcZ8nRWvWiDgIkeLOmhRQdtV3wfIYNaH85sEJL2
        Jzco+LVOV70vPjc3xYXGyf6gn1/MmHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682697632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXr3jO0Jo+PRsPOiEfh7gt67xxYugYqoebtocvtOm3I=;
        b=QCc8Pqc5EE6j87To8A3rJSsocw5KX9hAfOsHnyUn0qudWJr1HubutfLNkqivPqWaKe7e2u
        4cvGPCUNX1fvUzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC019138FA;
        Fri, 28 Apr 2023 16:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SJqDK5/tS2SRbQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 16:00:31 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/4] nfs: Run on all filesystems
Date:   Fri, 28 Apr 2023 18:00:38 +0200
Message-Id: <20230428160038.3534905-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428160038.3534905-1-pvorel@suse.cz>
References: <20230428160038.3534905-1-pvorel@suse.cz>
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

Use variables:
* TST_ALL_FILESYSTEMS=1 to run on all filesystems
* TST_FORMAT_DEVICE=1 to get loop device formatted
* TST_MOUNT_DEVICE=1 to get it mounted

Filesystems (tested the usual LTP way on loop device) are used for
server side (exportfs), client side (NFS mount) is kept outside of it.

For some reason umounting needs some time before NFS server stops using
underlying loop device. Also exportfs needs time before files can be
removed. Otherwise second umounting fails:

nfs07 4 TINFO: Cleaning up testcase
umount: /var/tmp/LTP_nfs07.FNZ7yCbqZe/mntpoint: target is busy.
nfs07 4 TINFO: umount(/var/tmp/LTP_nfs07.FNZ7yCbqZe/mntpoint) failed, try 1 ...
nfs07 4 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
umount: /var/tmp/LTP_nfs07.FNZ7yCbqZe/mntpoint: target is busy.

Solved with adding two sleeps for 1 sec (using less is not enough,
specially for nfs07.sh).

Skipping some problematic filesystems:
* exfat
Although it works on some systems (e.g. openSUSE Tumbleweed
with kernel 6.2.8-1-default, nfs-utils 2.6.2, exfatprogs 1.2.0), it
fails on other systems (e.g. SLES 15-SP4 with kernel 5.14.21, nfs-utils
2.1.1, exfatprogs 1.0.4 or Debian 12 bookworm with kernel 6.1.0-6-amd64,
nfs-utils 2.6.2, exfatprogs 1.2.0)

* tmpfs on nfs-utils < 2
tmpfs fails on nfs-utils 1.3.3:
nfs07 1 TINFO: mount.nfs: (linux nfs-utils 1.3.3)
nfs07 1 TINFO: setup NFSv4.2, socket type tcp
nfs07 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4.2 10.0.0.2:/tmp/LTP_nfs07.cex71Q5bxw/mntpoint/4.2/tcp /tmp/LTP_nfs07.cex71Q5bxw/4.2/0
mount.nfs: mount(2): No such file or directory
mount.nfs: mounting 10.0.0.2:/tmp/LTP_nfs07.cex71Q5bxw/mntpoint/4.2/tcp failed, reason given by server: No such file or directory
mount.nfs: timeout set for Mon Apr 24 21:34:02 2023
mount.nfs: trying text-based options 'proto=tcp,vers=4.2,addr=10.0.0.2,clientaddr=10.0.0.1'
nfs07 1 TBROK: mount command failed

But it works on nfs-utils 2.1.1 on SLE15-SP4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v3.

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 042fea5e4..1c6657a14 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -28,7 +28,10 @@ NFS_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
 TST_OPTS="v:t:$TST_OPTS"
 TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
-TST_NEEDS_TMPDIR=1
+TST_ALL_FILESYSTEMS=1
+TST_SKIP_FILESYSTEMS="exfat"
+TST_MOUNT_DEVICE=1
+TST_FORMAT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
@@ -68,7 +71,7 @@ get_remote_dir()
 	local v="$1"
 	local n="$2"
 
-	echo "$TST_TMPDIR/$v/$n"
+	echo "$TST_MNTPOINT/$v/$n"
 }
 
 nfs_get_remote_path()
@@ -165,6 +168,7 @@ nfs_setup()
 	local local_dir
 	local remote_dir
 	local mount_dir
+	local util_version
 
 	if [ "$(stat -f . | grep "Type: nfs")" ]; then
 		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
@@ -178,6 +182,14 @@ nfs_setup()
 
 	tst_res TINFO "$(mount.nfs -V)"
 
+	util_version=$(mount.nfs -V | sed 's/.*nfs-utils \([0-9]\)\..*/\1/')
+	if ! tst_is_int "$util_version"; then
+		tst_brk TBROK "Failed to detect mount.nfs major version"
+	fi
+	if [ "$TST_FS_TYPE" = "tmpfs" ] && [ "$util_version" -lt 2 ]; then
+		tst_brk TCONF "Testing tmpfs requires nfs-utils > 1"
+	fi
+
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
 		tst_res TINFO "setup NFSv$i, socket type $type"
@@ -210,6 +222,7 @@ nfs_cleanup()
 		grep -q "$local_dir" /proc/mounts && umount $local_dir
 		n=$(( n + 1 ))
 	done
+	sleep 1
 
 	n=0
 	for i in $VERSION; do
@@ -219,12 +232,15 @@ nfs_cleanup()
 		if tst_net_use_netns; then
 			if test -d $remote_dir; then
 				exportfs -u *:$remote_dir
+				sleep 1
 				rm -rf $remote_dir
 			fi
 		else
 			tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
+			sleep 1
 			tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
 		fi
+
 		n=$(( n + 1 ))
 	done
 }
-- 
2.40.0


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC915456A0
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jun 2022 23:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiFIVmo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jun 2022 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbiFIVmi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jun 2022 17:42:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB866CB4
        for <linux-nfs@vger.kernel.org>; Thu,  9 Jun 2022 14:42:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 637611FED0;
        Thu,  9 Jun 2022 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654810954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ou4b2uw8GMytBNI/2irjvNV6al/t73iXIzF0aCsPw20=;
        b=NrOk083Ob306Q3MP0igsyFn1Mdt/0NVYb/u4y57zfPxWmxE3u62Bi8fZZWtSZAMG2SgbTs
        qx5d09EHT+mUgFJUTm+zCjftTOhGC3gU579g29HEKKa/zaSiWliFKPSiLGhSiA3ibpgu10
        wRb2+7/bakPxspfJBPEm/hWqFaT5ltI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654810954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ou4b2uw8GMytBNI/2irjvNV6al/t73iXIzF0aCsPw20=;
        b=/EB0/mR9ViRUIPPZCIIPQYZ699U9gG5a5N37tdSBDoedGIkQaV8Hbc/X5l6uDz++pEyLEE
        QEOUS0vWIM4J8BAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F3AB13A8C;
        Thu,  9 Jun 2022 21:42:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kDvLCUppomIQDgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:34 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Subject: [RFC][PATCH v2 9/9] nfs: Use TST_ALL_FILESYSTEMS=1
Date:   Thu,  9 Jun 2022 23:42:23 +0200
Message-Id: <20220609214223.4608-10-pvorel@suse.cz>
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
Hi NFS developers,

your comments are welcome. This is an effort how to support NFS tests on
all filesystems available on SUT. Using $TST_MNTPOINT means test run in
loop, each time different filesystem is used. It's implemented via
formatted loop device (the same way as in LTP C API).

Code is also at: https://github.com/pevik/ltp/tree/shell/all_filesystems.v2

But this requires restarting NFS server (otherwise legacy testcases/lib/daemonlib.sh
would have to be used), which is IMHO not optimal.

Without that (or only run 'systemctl reload nfs-server' or exportfs -r
on remote side) it cannot be umounted after testing - debugging with
fuser, code at:
https://github.com/pevik/ltp/commit/3656d035d43445a107154ef397ef1db2fad2c4f0

The problem is that loop device is still referenced by nfs server and
thus cannot be unmounted. Can this be somehow fixed? Is it even wanted
to have tests on loop device (the only reasonable way to support more
filesystems)? Also tests will run much longer (we could filter out some
filesystems not supported, if there are any).

# LTP_SINGLE_FS_TYPE=ext2 PATH="/opt/ltp/testcases/bin:$PATH" nfs07.sh -v 3 -t tcp -i3
## NOTE: testing itself is OK
nfs07 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfs07 1 TINFO: add local addr 10.0.0.2/24
nfs07 1 TINFO: add local addr fd00:1:1:1::2/64
nfs07 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfs07 1 TINFO: add remote addr 10.0.0.1/24
nfs07 1 TINFO: add remote addr fd00:1:1:1::1/64
nfs07 1 TINFO: Network config (local -- remote):
nfs07 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfs07 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfs07 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
tst_supported_fs_types.c:148: TINFO: WARNING: testing only ext2
tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
nfs07 1 TINFO: Testing on ext2
nfs07 1 TINFO: Formatting ext2 with opts='/dev/loop0'
nfs07 1 TINFO: timeout per run is 0h 5m 0s
nfs07 1 TINFO: mount.nfs: (linux nfs-utils 2.6.1)
nfs07 1 TINFO: setup NFSv3, socket type tcp
nfs07 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=3 10.0.0.2:/tmp/LTP_nfs07.A3PIB82iUv/mntpoint/3/tcp /tmp/LTP_nfs07.A3PIB82iUv/mntpoint/3/0
nfs07 1 TPASS: All files and directories were correctly listed
nfs07 2 TPASS: All files and directories were correctly listed
nfs07 3 TPASS: All files and directories were correctly listed
nfs07 4 TINFO: Cleaning up testcase

## DEBUGGING CODE in nfs_cleanup()
nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w ($TST_TMPDIR)
                     USER        PID ACCESS COMMAND
/tmp/LTP_nfs07.P1XS9smc5w:
                     root     kernel mount /tmp
                     root       2125 ..c.. tst_timeout_kil
nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint ($TST_MNTPOINT)
                     USER        PID ACCESS COMMAND
/tmp/LTP_nfs07.P1XS9smc5w/mntpoint:
                     root     kernel mount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint
nfs07 4 TINFO: fuser -mv /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0
                     USER        PID ACCESS COMMAND
/tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0:
                     root     kernel mount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0

## from nfs_cleanup()
## grep -q "$local_dir" /proc/mounts && umount $local_dir
nfs07 4 TINFO: umount /tmp/LTP_nfs07.P1XS9smc5w/mntpoint/3/0
umount: /tmp/LTP_nfs07.P1XS9smc5w/mntpoint: target is busy.

## The rest is not relevant as the problem is above
## tst_umount from tst_test.sh trying hard to umount
nfs07 4 TINFO: umount(/tmp/LTP_nfs07.P1XS9smc5w/mntpoint) failed, try 1 ...
nfs07 4 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
umount: /tmp/LTP_nfs07.P1XS9smc5w/mntpoint: target is busy.
nfs07 4 TINFO: umount(/tmp/LTP_nfs07.P1XS9smc5w/mntpoint) failed, try 2 ...
nfs07 4 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
...
nfs07 4 TINFO: umount(/tmp/LTP_nfs07.P1XS9smc5w/mntpoint) failed, try 50 ...
nfs07 4 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
nfs07 4 TWARN: Failed to umount(/tmp/LTP_nfs07.P1XS9smc5w/mntpoint) after 50 retries

## if ! tst_device release "$TST_DEVICE"; then in _tst_do_exit() in tst_test.sh
tst_device.c:255: TWARN: ioctl(/dev/loop1, LOOP_CLR_FD, 0) no ENXIO for too long

Usage
tst_device acquire [size [filename]]
tst_device release /path/to/device

tst_device clear /path/to/device

## rm -r "$TST_TMPDIR" in _tst_do_exit() in tst_test.sh
nfs07 4 TWARN: Failed to release device '/dev/loop1'
rm: cannot remove '/tmp/LTP_nfs07.P1XS9smc5w/mntpoint': Device or resource busy
rm: cannot remove '/tmp/LTP_nfs07.P1XS9smc5w/mntpoint': Device or resource busy
nfs07 4 TINFO: AppArmor enabled, this may affect test results
nfs07 4 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
nfs07 4 TINFO: loaded AppArmor profiles: none

Kind regards,
Petr

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 25 ++++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index af7d46a21..a6557177b 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -28,7 +28,7 @@ NFS_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
 TST_OPTS="v:t:$TST_OPTS"
 TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
-TST_NEEDS_TMPDIR=1
+TST_ALL_FILESYSTEMS=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
@@ -63,7 +63,7 @@ nfs_get_remote_path()
 	done
 
 	v=${1:-$v}
-	echo "$TST_TMPDIR/$v/$type"
+	echo "$TST_MNTPOINT/$v/$type"
 }
 
 nfs_server_udp_enabled()
@@ -162,8 +162,8 @@ nfs_setup()
 			tst_brk TCONF "UDP support disabled on NFS server"
 		fi
 
-		local_dir="$TST_TMPDIR/$i/$n"
-		remote_dir="$TST_TMPDIR/$i/$type"
+		local_dir="$TST_MNTPOINT/$i/$n"
+		remote_dir="$TST_MNTPOINT/$i/$type"
 		mkdir -p $local_dir
 
 		nfs_setup_server $(($$ + n))
@@ -174,7 +174,7 @@ nfs_setup()
 	done
 
 	if [ "$n" -eq 1 ]; then
-		cd ${VERSION}/0
+		cd $TST_MNTPOINT/$VERSION/0
 	fi
 }
 
@@ -190,19 +190,22 @@ nfs_cleanup()
 
 	local n=0
 	for i in $VERSION; do
-		local_dir="$TST_TMPDIR/$i/$n"
-		grep -q "$local_dir" /proc/mounts && umount $local_dir
+		type=$(get_socket_type $n)
+		remote_dir="$TST_MNTPOINT/$i/$type"
+		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
+		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
 		n=$(( n + 1 ))
 	done
 
 	n=0
 	for i in $VERSION; do
-		type=$(get_socket_type $n)
-		remote_dir="$TST_TMPDIR/$i/$type"
-		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
-		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
+		local_dir="$TST_MNTPOINT/$i/$n"
+
+		grep -q "$local_dir" /proc/mounts && umount $local_dir
 		n=$(( n + 1 ))
 	done
+
+	systemctl restart nfs-server
 }
 
 . tst_net.sh
-- 
2.36.1


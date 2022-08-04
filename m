Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4496589B8D
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiHDMUA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiHDMT7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 08:19:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4663826AD2
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 05:19:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA41620FB0;
        Thu,  4 Aug 2022 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659615596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ganAk8Biqarzg14uiXeLH2Z9aMYAKLnAxtmJQDbKiyc=;
        b=DAX2VrjElcjJExZRMwZoWYMXR4EfqZNSzL5h6M7RJPhyNGqHeayYVKmLe5fUU6TL2/Nr3u
        hUqXx7AClrfJoHxA2LBzkDIowTklO2ccZ5LaT5sJTMSouqgpgFcYOp72jvspK12hF616jf
        6rbEfroOYg1GQOSb8TMsZfGQ4jBHciA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659615596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ganAk8Biqarzg14uiXeLH2Z9aMYAKLnAxtmJQDbKiyc=;
        b=HPXpnSvxhmQF9GvLgJRX7+TvHpOLHow2RMX4ggTS8oI9fgFafkrKmdzOLFB86PiADCY1Eb
        CnN2ByW1SBLlHJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FC2D13A94;
        Thu,  4 Aug 2022 12:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CI/IGGy562L2PQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:56 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
        Li Wang <liwang@redhat.com>, Martin Doucha <mdoucha@suse.cz>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        automated-testing@yoctoproject.org, linux-nfs@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Subject: [RFC][PATCH v3 10/10] nfs: Use TST_ALL_FILESYSTEMS=1
Date:   Thu,  4 Aug 2022 14:19:46 +0200
Message-Id: <20220804121946.19564-11-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* restart_daemon nfs-server + tst_sleep 500ms
  But still sometimes last test TCONF due server not being ready
  (restart is not reliable) :(
* Skip NTFS and vfat (NTFS is problematic, vfat IMHO does not make sense
  to test).

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 28 +++++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index af7d46a21..b9872bb31 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -8,6 +8,7 @@ VERSION=${VERSION:=3}
 NFILES=${NFILES:=1000}
 SOCKET_TYPE="${SOCKET_TYPE:-udp}"
 NFS_TYPE=${NFS_TYPE:=nfs}
+TST_SKIP_FILESYSTEMS="ntfs,vfat"
 
 nfs_usage()
 {
@@ -28,7 +29,7 @@ NFS_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
 TST_OPTS="v:t:$TST_OPTS"
 TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
-TST_NEEDS_TMPDIR=1
+TST_ALL_FILESYSTEMS=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
@@ -63,7 +64,7 @@ nfs_get_remote_path()
 	done
 
 	v=${1:-$v}
-	echo "$TST_TMPDIR/$v/$type"
+	echo "$TST_MNTPOINT/$v/$type"
 }
 
 nfs_server_udp_enabled()
@@ -162,8 +163,8 @@ nfs_setup()
 			tst_brk TCONF "UDP support disabled on NFS server"
 		fi
 
-		local_dir="$TST_TMPDIR/$i/$n"
-		remote_dir="$TST_TMPDIR/$i/$type"
+		local_dir="$TST_MNTPOINT/$i/$n"
+		remote_dir="$TST_MNTPOINT/$i/$type"
 		mkdir -p $local_dir
 
 		nfs_setup_server $(($$ + n))
@@ -174,7 +175,7 @@ nfs_setup()
 	done
 
 	if [ "$n" -eq 1 ]; then
-		cd ${VERSION}/0
+		cd $TST_MNTPOINT/$VERSION/0
 	fi
 }
 
@@ -190,19 +191,24 @@ nfs_cleanup()
 
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
+	restart_daemon nfs-server
+	tst_sleep 500ms
 }
 
+. daemonlib.sh
 . tst_net.sh
-- 
2.37.1


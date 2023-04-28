Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E796F1C1C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbjD1QAg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjD1QAf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 12:00:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B32D67
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 09:00:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3783121EE6;
        Fri, 28 Apr 2023 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682697630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8owDjlaj9rMqZvzHKtIqAfiPFCaR46SvpKpIm6sW/E=;
        b=K4jEYBHHeV6aU+hotmEAiRwBBMH38Es9QMwMi/Hyzkz37yHfhkqyFCCsawlf5pgYNvK5L8
        +deyoJjlz+hWYYxdhBeVCJEB/kM7DCq3Z8+9Nkql5LPVApxrttzblEN77YAHNMtfVqvPJp
        bFe0cdxV/svAkkF4Ap5ySafJJdkyT2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682697630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N8owDjlaj9rMqZvzHKtIqAfiPFCaR46SvpKpIm6sW/E=;
        b=hnB+2hVJSOiy8ab3MYfdIDXdrV0hw1fAT3yQBuX1k7EKxbwsTgUnatXclr2YLFQHa9K+0A
        XlCHw4zudkkKMLDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDA75138FA;
        Fri, 28 Apr 2023 16:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CLZYNJ3tS2SRbQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 16:00:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, NeilBrown <neilb@suse.de>,
        Cyril Hrubis <chrubis@suse.cz>, linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/4] nfs_lib.sh: Cleanup local and remote directories setup
Date:   Fri, 28 Apr 2023 18:00:35 +0200
Message-Id: <20230428160038.3534905-2-pvorel@suse.cz>
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

Logic for creating local and remote directories was on more places.
Create get_local_dir() and get_remote_dir() functions to keep it on
single place.

local dir is needed in nfs_mount(), but was defined in nfs_setup()
and reused local variable with shell inheritance (ugly!), because there
were all parameters from loop.  Similarly, remote dir is needed in
both nfs_mount() and nfs_setup_server(), but created with shell
inheritance in nfs_setup().  Pass these params to nfs_mount() and
nfs_setup_server() and define variables with new functions
get_local_dir() and get_remote_dir().

Use get_remote_dir() in nfs_get_remote_path().

Move cd to local directory to the end of nfs_mount() (it used to cd
after nfs_mount(), but only if -v parameter contained single version,
but it does not harm to always cd).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v3.

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 52 ++++++++++++++-------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index af7d46a21..1b5604ab5 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2016-2022
+# Copyright (c) Linux Test Project, 2016-2023
 # Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 
@@ -53,6 +53,24 @@ get_socket_type()
 	done
 }
 
+# directory mounted by NFS client
+get_local_dir()
+{
+	local v="$1"
+	local n="$2"
+
+	echo "$TST_TMPDIR/$v/$n"
+}
+
+# directory on NFS server
+get_remote_dir()
+{
+	local v="$1"
+	local n="$2"
+
+	echo "$TST_TMPDIR/$v/$n"
+}
+
 nfs_get_remote_path()
 {
 	local v
@@ -63,7 +81,7 @@ nfs_get_remote_path()
 	done
 
 	v=${1:-$v}
-	echo "$TST_TMPDIR/$v/$type"
+	echo "$(get_remote_dir $v $type)"
 }
 
 nfs_server_udp_enabled()
@@ -78,8 +96,8 @@ nfs_server_udp_enabled()
 
 nfs_setup_server()
 {
-
-	local fsid="$1"
+	local remote_dir="$1"
+	local fsid="$2"
 	local export_cmd="exportfs -i -o fsid=$fsid,no_root_squash,rw *:$remote_dir"
 
 	[ -z "$fsid" ] && tst_brk TBROK "empty fsid"
@@ -97,10 +115,14 @@ nfs_setup_server()
 
 nfs_mount()
 {
-	local opts="$1"
+	local local_dir="$1"
+	local remote_dir="$2"
+	local opts="$3"
 	local host_type=rhost
 	local mount_dir
 
+	mkdir -p "$local_dir"
+
 	tst_net_use_netns && host_type=
 
 	if [ $TST_IPV6 ]; then
@@ -131,6 +153,8 @@ nfs_mount()
 
 		tst_brk TBROK "mount command failed"
 	fi
+
+	cd "$local_dir"
 }
 
 nfs_setup()
@@ -162,20 +186,12 @@ nfs_setup()
 			tst_brk TCONF "UDP support disabled on NFS server"
 		fi
 
-		local_dir="$TST_TMPDIR/$i/$n"
-		remote_dir="$TST_TMPDIR/$i/$type"
-		mkdir -p $local_dir
-
-		nfs_setup_server $(($$ + n))
-
-		nfs_mount "-o proto=$type,vers=$i"
+		remote_dir="$(get_remote_dir $i $type)"
+		nfs_setup_server "$remote_dir" "$(($$ + n))"
+		nfs_mount "$(get_local_dir $i $n)" "$remote_dir" "-o proto=$type,vers=$i"
 
 		n=$(( n + 1 ))
 	done
-
-	if [ "$n" -eq 1 ]; then
-		cd ${VERSION}/0
-	fi
 }
 
 nfs_cleanup()
@@ -190,7 +206,7 @@ nfs_cleanup()
 
 	local n=0
 	for i in $VERSION; do
-		local_dir="$TST_TMPDIR/$i/$n"
+		local_dir="$(get_local_dir $i $n)"
 		grep -q "$local_dir" /proc/mounts && umount $local_dir
 		n=$(( n + 1 ))
 	done
@@ -198,7 +214,7 @@ nfs_cleanup()
 	n=0
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
-		remote_dir="$TST_TMPDIR/$i/$type"
+		remote_dir="$(get_remote_dir $i $type)"
 		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
 		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
 		n=$(( n + 1 ))
-- 
2.40.0


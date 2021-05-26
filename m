Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13A391E32
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 19:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhEZRfe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 13:35:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhEZRfe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 May 2021 13:35:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09DE6218D6;
        Wed, 26 May 2021 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622049911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SK1nOwApoB060hVZEHApU/oevSCROkupDp1uSU4WGFk=;
        b=eol3yfsPu1+ki1WlO3dEloXfMopIP7VeNBzybI9iOwNRwjiZpGF8uJIrMEZ6IaChBSP65f
        45Cz+88N1L9x6J/RacxdvF7iU4pfGnm6lJGSK5sS4jzAslHvGVGTFBRsxXrd5jbzEyML1R
        146B+67PF2ixneNqtMxqSWB92SEOsAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622049911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SK1nOwApoB060hVZEHApU/oevSCROkupDp1uSU4WGFk=;
        b=Ge4MWO6Pw33JbeSTrAQ0K8vWWMZDoq67pkE5E+ZPS45V8M/Qw1ThPImUxwb1Fe7juZFAqS
        v6yyCQEStlgYddBg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id C090811A98;
        Wed, 26 May 2021 17:25:10 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
        linux-nfs@vger.kernel.org
Subject: [LTP PATCH v2 3/3] nfs_lib.sh: Check running rpc.mountd, rpc.statd
Date:   Wed, 26 May 2021 19:25:03 +0200
Message-Id: <20210526172503.18621-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526172503.18621-1-pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NOTE: we're not checking rpcbind/portmap which is required for NFSv3,
as it's rpc.mountd dependency.

Deliberately not add pgrep as required dependency.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* check for rpc.mountd, rpc.statd
(previsously checked for rpc.mountd, rpcbind/portmap)

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 26b670c35..9bef1b86a 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -27,7 +27,7 @@ TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
+TST_NEEDS_CMDS="$TST_NEEDS_CMDS exportfs mount"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
 TST_NEEDS_DRIVERS="nfsd"
@@ -110,11 +110,6 @@ nfs_mount()
 
 nfs_setup()
 {
-	# Check if current filesystem is NFS
-	if [ "$(stat -f . | grep "Type: nfs")" ]; then
-		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
-	fi
-
 	local i
 	local type
 	local n=0
@@ -123,6 +118,16 @@ nfs_setup()
 	local remote_dir
 	local mount_dir
 
+	if [ "$(stat -f . | grep "Type: nfs")" ]; then
+		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
+	fi
+
+	if tst_cmd_available pgrep; then
+		for i in rpc.mountd rpc.statd; do
+			pgrep $i > /dev/null || tst_brk TCONF "$i not running"
+		done
+	fi
+
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
 		tst_res TINFO "setup NFSv$i, socket type $type"
-- 
2.31.1


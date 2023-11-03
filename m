Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115F67E0100
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Nov 2023 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbjKCKLD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Nov 2023 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347786AbjKCKLC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Nov 2023 06:11:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F213E;
        Fri,  3 Nov 2023 03:10:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACBC433C7;
        Fri,  3 Nov 2023 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699006258;
        bh=hy5EV4sR4yz3zAHZYgoj1HfAxunSfRMU8lTP11JOGFg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UVMpTv8+gH/tpaomJ0+e/TeBVbFo9WZ47PL52wHCVW2q9WdkQ/ZQcLw3oUUYFP7MM
         IwnSqP6901vRxGjyEcPU4HGaZyN2cia2b8yNDu/9J7k08cVqIEkG2RmdKJzpMtFqGj
         LhcREJ2xMi3P9aKJnVrwX4D+4lDp+hhuooHKSja0G3aW4fOxuncZJ2cH9moI54CkKu
         YsEzmQC8hsJ6bcl/pzJnps0LnGbCeqv9B+krSijMVIF2slGsVOfjrVBSc6sK6P52nQ
         ilYYWpN6pI65citM7/0DlmRdghBa6LVp2OBDAefCZ2sg6ElNAKY8VLeciXaCGJcCZA
         1PJ4mBneFwKDA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 03 Nov 2023 06:10:51 -0400
Subject: [PATCH 3/3] nfs: print fileid in lookup tracepoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-nfs-6-8-v1-3-a2aa9021dc1d@kernel.org>
References: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
In-Reply-To: <20231103-nfs-6-8-v1-0-a2aa9021dc1d@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hy5EV4sR4yz3zAHZYgoj1HfAxunSfRMU8lTP11JOGFg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlRMcwerZerSmW0zQ23tKiLtc/KI/L1+K8h3qeS
 2vhQR5NQmqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZUTHMAAKCRAADmhBGVaC
 FWbtD/9tXHGqmIca1dJtzDkko7bd2dQ9/06sp6/+hv53Mxkc6v9GLa5b3Fql0lK5JrjAw5dL6ZB
 2oeuBUuuk8C5RBYyepA5U74xRTelZoetsy9FiDx6kbLPne4IzMcSuJrpgFP0Wp4H5QydF5b9YLs
 WQAkB/LCwOlcDz+nit/zToeouvGqYuFnQ0CsM5zUsxCVXG0so2y8zPMzd6auxIsmOIS7xQggxy/
 dx439lGP+MY4dKMfsdIt5bfjWA6JBDFGTGvIIq922JH6FahCBXN5EQME9y+Y+W4PuXqShpNh25h
 Vs04QRaBDiuJ9UhvlChslR6xroQUNo4zFZhbrBtRJjVv55TAh7PU/vKsjCwwHu8IWcjr4zkk1Bk
 +kfP5he5uIzoRefutumKoHDjabZwt+G7L2zkp8Ln+SDSF0bjlxAo/Art9oNiuXMcp4H8ZP4X+J4
 sJkTc91aWlAzcuDQVxGgo+d83Rh1BZ6RzHZIBkv+bbN/AqScHnC4gXfgwyivF+A5xVnES1+OCoJ
 Bg6vJ1ulGRnVH2dq+Q974BzqsXDDAEX+YbTybtRlD9GNYn+ZsEBmJAS9qyAGVq3s5jyKGVkUdvT
 WW4XcI7BsoK8fTFUGxaDUEWJYcZinWmyzJxCDhPjkysO8X8hSdq7AwAB//IigJCIV/1IKfql9/r
 CI2Zhh+O4SAYAtw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With this we can see the dentry -> inode linkage that's being
revalidated. A fileid of 0 means "negative dentry".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8ad1bed09295..de3adc4a2ce0 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -400,6 +400,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
+			__field(u64, fileid)
 			__string(name, dentry->d_name.name)
 		),
 
@@ -407,16 +408,18 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
+			__entry->fileid = d_is_negative(dentry) ? 0 : NFS_FILEID(d_inode(dentry));
 			__assign_str(name, dentry->d_name.name);
 		),
 
 		TP_printk(
-			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
+			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s fileid=%llu",
 			__entry->flags,
 			show_fs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
-			__get_str(name)
+			__get_str(name),
+			__entry->fileid
 		)
 );
 
@@ -444,6 +447,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
+			__field(u64, fileid)
 			__string(name, dentry->d_name.name)
 		),
 
@@ -452,17 +456,19 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error < 0 ? -error : 0;
 			__entry->flags = flags;
+			__entry->fileid = d_is_negative(dentry) ? 0 : NFS_FILEID(d_inode(dentry));
 			__assign_str(name, dentry->d_name.name);
 		),
 
 		TP_printk(
-			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
+			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s fileid=%llu",
 			-__entry->error, show_nfs_status(__entry->error),
 			__entry->flags,
 			show_fs_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
-			__get_str(name)
+			__get_str(name),
+			__entry->fileid
 		)
 );
 

-- 
2.41.0


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588EB68B10A
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Feb 2023 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBEQ6t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Feb 2023 11:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBEQ6s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Feb 2023 11:58:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C234418A8B
        for <linux-nfs@vger.kernel.org>; Sun,  5 Feb 2023 08:58:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3399560BAA
        for <linux-nfs@vger.kernel.org>; Sun,  5 Feb 2023 16:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6F5C433D2
        for <linux-nfs@vger.kernel.org>; Sun,  5 Feb 2023 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675616325;
        bh=/NXXuHm13ASan+IZxOj9DNwijRpAhvGXys+IJrHi/nc=;
        h=Subject:From:To:Date:From;
        b=bXw42lCsHnCJh2+GsqiNTX+vbRzisKELYHfvZAEVuP523aAYXoWGJUg7UopeyqvDX
         Eqfv8EFstDD+9d2yKJoUFL82Wwj8XydpvJwma8gMsF+llePECjIaWjVpMUUL25KPjs
         41JRN6YU1Ftdiym6tKLuRL+FglC9FGvvzRFdBSvPHMHssl//PvsUrQCruThpuWHWk2
         3/lNE4OfBgwFfB1HRraJVgGXeeWG1WqXtLlNNA7C35kkgHzzWjwZybDK1PBiazGewC
         zdVcJJV9jVLWb7CgJlvyXLUcavW3BZMDzqtCoTsMFerstdR2QruW4/IAQVy5slvxoS
         Mh9024KomRWjA==
Subject: [PATCH] SUNRPC: Fix occasional warning when destroying
 gss_krb5_enctypes
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 05 Feb 2023 11:58:44 -0500
Message-ID: <167561632453.5062.10189976782458528125.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

I'm guessing that the warning fired because there's some code path
that is called on module unload where the gss_krb5_enctypes file
was never set up.

name 'gss_krb5_enctypes'
WARNING: CPU: 0 PID: 6187 at fs/proc/generic.c:712 remove_proc_entry+0x38d/0x460 fs/proc/generic.c:712

destroy_krb5_enctypes_proc_entry net/sunrpc/auth_gss/svcauth_gss.c:1543 [inline]
gss_svc_shutdown_net+0x7d/0x2b0 net/sunrpc/auth_gss/svcauth_gss.c:2120
ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
setup_net+0x9bd/0xe60 net/core/net_namespace.c:356
copy_net_ns+0x320/0x6b0 net/core/net_namespace.c:483
create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
copy_namespaces+0x410/0x500 kernel/nsproxy.c:179
copy_process+0x311d/0x76b0 kernel/fork.c:2272
kernel_clone+0xeb/0x9a0 kernel/fork.c:2684
__do_sys_clone+0xba/0x100 kernel/fork.c:2825
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Reported-by: syzbot+04a8437497bcfb4afa95@syzkaller.appspotmail.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/svcauth_gss.c |   13 +++++++------
 net/sunrpc/netns.h                |    1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 19f0190a0b97..9c843974bb48 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1529,18 +1529,19 @@ static int create_krb5_enctypes_proc_entry(struct net *net)
 {
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 
-	if (!proc_create_data("gss_krb5_enctypes", S_IFREG | 0444,
-			      sn->proc_net_rpc,
-			      &gss_krb5_enctypes_proc_ops, net))
-		return -ENOMEM;
-	return 0;
+	sn->gss_krb5_enctypes =
+		proc_create_data("gss_krb5_enctypes", S_IFREG | 0444,
+				 sn->proc_net_rpc, &gss_krb5_enctypes_proc_ops,
+				 net);
+	return sn->gss_krb5_enctypes ? 0 : -ENOMEM;
 }
 
 static void destroy_krb5_enctypes_proc_entry(struct net *net)
 {
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
 
-	remove_proc_entry("gss_krb5_enctypes", sn->proc_net_rpc);
+	if (sn->gss_krb5_enctypes)
+		remove_proc_entry("gss_krb5_enctypes", sn->proc_net_rpc);
 }
 
 #else /* CONFIG_PROC_FS */
diff --git a/net/sunrpc/netns.h b/net/sunrpc/netns.h
index 7ec10b92bea1..4efb5f28d881 100644
--- a/net/sunrpc/netns.h
+++ b/net/sunrpc/netns.h
@@ -33,6 +33,7 @@ struct sunrpc_net {
 	int pipe_version;
 	atomic_t pipe_users;
 	struct proc_dir_entry *use_gssp_proc;
+	struct proc_dir_entry *gss_krb5_enctypes;
 };
 
 extern unsigned int sunrpc_net_id;



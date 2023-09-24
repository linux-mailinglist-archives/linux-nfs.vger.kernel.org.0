Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA017ACAFB
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Sep 2023 19:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjIXRUu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Sep 2023 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjIXRUt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Sep 2023 13:20:49 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C3EF1
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 10:20:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-351365e47f6so3209335ab.1
        for <linux-nfs@vger.kernel.org>; Sun, 24 Sep 2023 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695576042; x=1696180842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFwefuO62Ed0z8sLvNpL+yMKYOhHMwAPKrI9k88Ri30=;
        b=Euhb48bWPoLRKZq04fi5lvOYgusHQrafT3Orsk0FwpnOBDzgAsCA5o23J8A/Ugth1D
         KYeMRDv8RAcrmC4xj1eXzWS2bD5ADWk3nSYH4EQRATCsOqcyN9+6oZ1UsQRZGGGUShyt
         H4432sMtQ6DgnTIHdn36GW3w/4RVKZUq4lxgma8EcrokcLkyN/8yLhwPV/U5VuTOWFTC
         kSD/7Wqztv+yHmYbYEC7V8jkLca1ENx9S41+ValmpW5/yZCVIDogpUD0wO2evksulOiZ
         GAkCBFE69GwfHGZqxMKqXd1pADBhlCk2YCXOZ+XmuYXKTDXdhFWjSO9OMKqfXcZv2N3H
         cG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695576042; x=1696180842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFwefuO62Ed0z8sLvNpL+yMKYOhHMwAPKrI9k88Ri30=;
        b=nTwJZVmAdb3QUxQG4D7qVNRibS9GGu62wKUsdQUYWaPI38/JrrI1qseJUSyIedncT+
         f5HeXbVMhv3xNT3UL64hcC140FXdyMxUszM1oLcss9k0GmqmiXTBLzDNoaaG1QaK0Iyv
         az0f4mi+Ki1/NB/aWWFiKO6o4f2ULc3hrjX36A4tbdMgoFy2lJ55KQVBnWYCwIeSn7ja
         ReLtqNZTJ24P8xOnESRkb6nAtid9phQSRgRFbAoLS3BAwAVHU3llZ1HCvfh5hsGXKho0
         ekJ0coY2JwER++daFPFztLBmQUmqtfKm0NOgqeZ9w8w2iJUoqQAuTmv7u/54aFm9KBfw
         QWtQ==
X-Gm-Message-State: AOJu0YzhTazSr5+EwnF8areummzMU9DZCy7IccNRB8+VIROxisfveXm9
        5k62qQyk78n354L4wwVi2A==
X-Google-Smtp-Source: AGHT+IGP9nfcy42bZjgmymHt0jwDhrDZQCw5QbBrqxbjy87+h1LQrxRbFFw8og6iN45Krukl9b0P7Q==
X-Received: by 2002:a05:6e02:1bce:b0:34f:4334:f01f with SMTP id x14-20020a056e021bce00b0034f4334f01fmr6610777ilv.12.1695576042441;
        Sun, 24 Sep 2023 10:20:42 -0700 (PDT)
Received: from localhost.localdomain (50-36-86-126.alma.mi.frontiernet.net. [50.36.86.126])
        by smtp.gmail.com with ESMTPSA id z3-20020a92d183000000b0034f1bb427dbsm2416477ilz.60.2023.09.24.10.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 10:20:42 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <aglo@umich.edu>
Subject: [PATCH v2] NFSv4: Fix a state manager thread deadlock regression
Date:   Sun, 24 Sep 2023 13:14:15 -0400
Message-ID: <20230924171415.352964-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Commit 4dc73c679114 reintroduces the deadlock that was fixed by commit
aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock") because it
prevents the setup of new threads to handle reboot recovery, while the
older recovery thread is stuck returning delegations.

Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c  |  4 +++-
 fs/nfs/nfs4state.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5deeaea8026e..a19e809cad16 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10652,7 +10652,9 @@ static void nfs4_disable_swap(struct inode *inode)
 	 */
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
 
-	nfs4_schedule_state_manager(clp);
+	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
+	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+	wake_up_var(&clp->cl_state);
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 0bc160fbabec..9a5d911a7edc 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1209,16 +1209,26 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
+	struct rpc_clnt *clnt = clp->cl_rpcclient;
+	bool swapon = false;
 
-	if (clp->cl_rpcclient->cl_shutdown)
+	if (clnt->cl_shutdown)
 		return;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
-	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
-		wake_up_var(&clp->cl_state);
-		return;
+
+	if (atomic_read(&clnt->cl_swapper)) {
+		swapon = !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE,
+					   &clp->cl_state);
+		if (!swapon) {
+			wake_up_var(&clp->cl_state);
+			return;
+		}
 	}
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
+
+	if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
+		return;
+
 	__module_get(THIS_MODULE);
 	refcount_inc(&clp->cl_count);
 
@@ -1235,8 +1245,9 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 			__func__, PTR_ERR(task));
 		if (!nfs_client_init_is_complete(clp))
 			nfs_mark_client_ready(clp, PTR_ERR(task));
+		if (swapon)
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs4_clear_state_manager_bit(clp);
-		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs_put_client(clp);
 		module_put(THIS_MODULE);
 	}
@@ -2748,22 +2759,25 @@ static int nfs4_run_state_manager(void *ptr)
 
 	allow_signal(SIGKILL);
 again:
-	set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state);
 	nfs4_state_manager(clp);
-	if (atomic_read(&cl->cl_swapper)) {
+
+	if (test_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) &&
+	    !test_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state)) {
 		wait_var_event_interruptible(&clp->cl_state,
 					     test_bit(NFS4CLNT_RUN_MANAGER,
 						      &clp->cl_state));
-		if (atomic_read(&cl->cl_swapper) &&
-		    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
+		if (!atomic_read(&cl->cl_swapper))
+			clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
+		if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
+		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
 			goto again;
 		/* Either no longer a swapper, or were signalled */
+		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 	}
-	clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 
 	if (refcount_read(&clp->cl_count) > 1 && !signalled() &&
 	    test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
-	    !test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state))
+	    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state))
 		goto again;
 
 	nfs_put_client(clp);
-- 
2.41.0


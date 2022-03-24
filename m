Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E764E6500
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Mar 2022 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiCXOYM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Mar 2022 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiCXOYL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Mar 2022 10:24:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27A11C0B
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:22:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d142so3614852qkc.4
        for <linux-nfs@vger.kernel.org>; Thu, 24 Mar 2022 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2db9+PHBgbEkl1+OZIYhzWgF91KkrEdbve2piXwHT6s=;
        b=TnkqhALj3P9DeBbmOoG1SRsjYlS6I6IHXq15X6w/DLSq5KH01oG543rh7BzVAssQ6w
         N2ZZNSF0HU9QIqNmMWOzXqHrhlFPim9SGnpOr2zJ47rZnUheekgXuaQfJLjD4VYmcnKe
         YtTTw9r7PfBZ1fj3QPuQ6ApouGeu21ZMtKAi6E6DWXAImEEO9n0F2LoftpMqtvD5CyOO
         m+cI+TyxnorEyCFB5uYJYHPerNzPF4Nc/O+RAByUPRVKFG/fBmvMuJoyXfRTa2xa7S6A
         j2qAgv+FxD/Lo0QIc33pu62MjA2Wm5Tva6EQDS8Fa1GFmGH97U2RaLhqMI7u3Sd31Rqj
         QtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2db9+PHBgbEkl1+OZIYhzWgF91KkrEdbve2piXwHT6s=;
        b=Fu2/mG5og8iZwwGvx3eGfscYZ7ciX+AR1xskJHcbCVIFZUG9jMixEY7WYzXRosQNTL
         aU0CZ07gP363nQm49buByzsS4BnirCUHSq+AhPdFHn10YmKwWfx7MnLToEHE1bJLOhkz
         5kexG6/a78MrH5D5XjMNzayQW/VvTCq7ITwZpE6JyAli+R3MYr6yVN9uilgrF8hvPPPx
         fw9cP6bVvQXklSzMJrPjFdIck+FmLal5BgoEo1QiZAkRS7WXE0xGNqUQleupMqGjMEJf
         mTMrGDBhbY++pJi67RkkYbP0a0jg2gFYsjOyPTGKys/v3qXGwjhi4/SbHhyyPAFo/7U0
         P3pQ==
X-Gm-Message-State: AOAM530SwYyKT8r9IzZ0Di23jC8cxTS+93SXySMyTA+r7OBfREWeGFdn
        oqyf6UeCgHFJmOc/5rp7Cz3n9QDcbYU=
X-Google-Smtp-Source: ABdhPJznSPvQAqdMDoYU16lFVQKOrHDynuCDM9DRu1g0xeAG98OcV/jMPfETykLz5xSJCx9Av26eqA==
X-Received: by 2002:a05:620a:1903:b0:67d:243b:a8ae with SMTP id bj3-20020a05620a190300b0067d243ba8aemr3560485qkb.142.1648131756109;
        Thu, 24 Mar 2022 07:22:36 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id bl3-20020a05620a1a8300b0067d4cd00231sm1651860qkb.135.2022.03.24.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:22:35 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1: don't retry BIND_CONN_TO_SESSION on session error
Date:   Thu, 24 Mar 2022 10:22:32 -0400
Message-Id: <20220324142232.63492-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

There is no reason to retry the operation if a session error had
occurred in such case result structure isn't filled out.

Fixes: dff58530c4ca ("NFSv4.1: fix handling of backchannel binding in BIND_CONN_TO_SESSION")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 ++++++++-
 fs/nfs/nfs4proc.c                               | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..cdef24eef648 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5639,7 +5639,7 @@
 			pernode	    one pool for each NUMA node (equivalent
 				    to global on non-NUMA machines)
 
-	sunrpc.tcp_slot_table_entries=
+	sunrpc.max_tcp_slot_table_entries=
 	sunrpc.udp_slot_table_entries=
 			[NFS,SUNRPC]
 			Sets the upper limit on the number of simultaneous
@@ -5648,6 +5648,13 @@
 			improve throughput, but will also increase the
 			amount of memory reserved for use by the client.
 
+	sunrpc.tcp_slot_table_entries=
+			[NFS,SUNRPC]
+			Sets the minimum limit on the number of simultaneous
+			RPC calls that can be sent from the client to a
+			server. RPC session table then would dynamically grow
+			until it reaches the max_tcp_slot_table_entries.
+
 	suspend.pm_test_delay=
 			[SUSPEND]
 			Sets the number of seconds to remain in a suspend test
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dd7a4c2a3f05..e3f5b380cefe 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8340,6 +8340,7 @@ nfs4_bind_one_conn_to_session_done(struct rpc_task *task, void *calldata)
 	case -NFS4ERR_DEADSESSION:
 		nfs4_schedule_session_recovery(clp->cl_session,
 				task->tk_status);
+		return;
 	}
 	if (args->dir == NFS4_CDFC4_FORE_OR_BOTH &&
 			res->dir != NFS4_CDFS4_BOTH) {
-- 
2.27.0


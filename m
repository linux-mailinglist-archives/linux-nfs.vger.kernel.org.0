Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A179B6D9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbjIKV7H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbjIKS5E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 14:57:04 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF71B8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:56:58 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-575f45e255dso2977897eaf.2
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694458618; x=1695063418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9FA10xdzo3rI/p2Oc+v/6tnWHhSYIWVUzHlU2v7eYk=;
        b=VvAHsN+geQ+fxlpSMummDCxFn2YmSv3GDJOp9KZp/fgoSO3ukIcwjMj6H4LXfZnRNZ
         7gsvlYuWYYgeT1PO64UP/MmyWuEU+4ybr5sHpUZoZbZJzEEPQHz8/+D1WVCe6paDK6jZ
         2STCCx2R7Elbncg3p2BGXencKAPqKrAgt+vwWLp8BXvgmEpeWvSYshPJh6BQMqInvdUM
         b9wNdWf+mNrltbQlGTWYCWOyLTY7NYWa1k8OZbDk/GIHfL0SX0uvbdh1DsJe/LXqqtcy
         Kk5gQ7jAbsTbgzH6nH24gWp9sPNTSf8Or+A3EBjkMHeJS7YzSK7vsz/sjGxouQatJatr
         KgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458618; x=1695063418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9FA10xdzo3rI/p2Oc+v/6tnWHhSYIWVUzHlU2v7eYk=;
        b=PUsv5Y0NZcp2EyC014F7fyGD9MVFKEeD9Pi8LwcRByDOn+tnYojEgibMqwTj0dYYPM
         nY2caOFbjoECXtPIrQMGdm/dEWN2elpXR4+bSWwIOn3Cg2tro7GReycOmOmGYaLAroOw
         h3DdpbVNovByVCTERc3YTqjQdaDPILNwouvXFN/+hfI42GADLijjhvdpc6dMINtZK6al
         ray8ZWkSZkRUfGdRCqlEJGwlUwCgyAs7FMWS/AaVo456OStxoMVtfWDPO+DIagp4SbW6
         7yt4RrIY+V9BbIKSwNOUSMbn591cAONAziv2XavqON9C8r2JJ3G6WJbW7H3FaeaoW5os
         dFIA==
X-Gm-Message-State: AOJu0Yw1fJqX53z8KavcNkjdIeJiZCT0y1y8MTlwzRzsdmLpXJwmHPyU
        Uck5OKujreUBRjlWbBfNpHFXe/LvzQ==
X-Google-Smtp-Source: AGHT+IEmMe45P4eyqFhQgjrxzGmP8x65sHDhR8/H2Z6ptaGjq0UvSODK2ChEZv/idB86WvhG0Tx2qg==
X-Received: by 2002:a05:6358:729e:b0:140:f08c:2b50 with SMTP id w30-20020a056358729e00b00140f08c2b50mr7138047rwf.6.1694458617701;
        Mon, 11 Sep 2023 11:56:57 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id e15-20020a0caa4f000000b006263a9e7c63sm3106068qvb.104.2023.09.11.11.56.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:56:57 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4: Add a parameter to limit the number of retries after NFS4ERR_DELAY
Date:   Mon, 11 Sep 2023 14:50:30 -0400
Message-ID: <20230911185031.11903-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911185031.11903-1-trond.myklebust@hammerspace.com>
References: <20230911185031.11903-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When using a 'softerr' mount, the NFSv4 client can get stuck waiting
forever while the server just returns NFS4ERR_DELAY. Among other things,
this causes the knfsd server threads to busy wait.
Add a parameter that tells the NFSv4 client how many times to retry
before giving up.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 fs/nfs/nfs4_fs.h                              |  2 ++
 fs/nfs/nfs4proc.c                             | 25 +++++++++++++++++++
 fs/nfs/super.c                                |  8 +++++-
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 722b6eca2e93..62af591ee2ad 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3517,6 +3517,13 @@
 			[NFS] set the TCP port on which the NFSv4 callback
 			channel should listen.
 
+	nfs.delay_retrans=
+			[NFS] specifies the number of times the NFSv4 client
+			retries the request before returning an EAGAIN error,
+			after a reply of NFS4ERR_DELAY from the server.
+			Only applies if the softerr mount option is enabled,
+			and the specified value is >= 0.
+
 	nfs.enable_ino64=
 			[NFS] enable 64-bit inode numbers.
 			If zero, the NFS client will fake up a 32-bit inode
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 4c9f8bd866ab..29b91482e5f4 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -209,6 +209,7 @@ struct nfs4_exception {
 	struct inode *inode;
 	nfs4_stateid *stateid;
 	long timeout;
+	unsigned short retrans;
 	unsigned char task_is_privileged : 1;
 	unsigned char delay : 1,
 		      recovering : 1,
@@ -546,6 +547,7 @@ extern unsigned short max_session_slots;
 extern unsigned short max_session_cb_slots;
 extern unsigned short send_implementation_id;
 extern bool recover_lost_locks;
+extern short nfs_delay_retrans;
 
 #define NFS4_CLIENT_ID_UNIQ_LEN		(64)
 extern char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN];
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 832fa226b8f2..99c054a6c7b5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -585,6 +585,21 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 	return 0;
 }
 
+/*
+ * Track the number of NFS4ERR_DELAY related retransmissions and return
+ * EAGAIN if the 'softerr' mount option is set, and we've exceeded the limit
+ * set by 'nfs_delay_retrans'.
+ */
+static int nfs4_exception_should_retrans(const struct nfs_server *server,
+					 struct nfs4_exception *exception)
+{
+	if (server->flags & NFS_MOUNT_SOFTERR && nfs_delay_retrans >= 0) {
+		if (exception->retrans++ >= (unsigned short)nfs_delay_retrans)
+			return -EAGAIN;
+	}
+	return 0;
+}
+
 /* This is the error handling routine for processes that are allowed
  * to sleep.
  */
@@ -595,6 +610,11 @@ int nfs4_handle_exception(struct nfs_server *server, int errorcode, struct nfs4_
 
 	ret = nfs4_do_handle_exception(server, errorcode, exception);
 	if (exception->delay) {
+		int ret2 = nfs4_exception_should_retrans(server, exception);
+		if (ret2 < 0) {
+			exception->retry = 0;
+			return ret2;
+		}
 		ret = nfs4_delay(&exception->timeout,
 				exception->interruptible);
 		goto out_retry;
@@ -623,6 +643,11 @@ nfs4_async_handle_exception(struct rpc_task *task, struct nfs_server *server,
 
 	ret = nfs4_do_handle_exception(server, errorcode, exception);
 	if (exception->delay) {
+		int ret2 = nfs4_exception_should_retrans(server, exception);
+		if (ret2 < 0) {
+			exception->retry = 0;
+			return ret2;
+		}
 		rpc_delay(task, nfs4_update_delay(&exception->timeout));
 		goto out_retry;
 	}
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2284f749d892..929e122ff34b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1368,6 +1368,7 @@ unsigned short max_session_cb_slots = NFS4_DEF_CB_SLOT_TABLE_SIZE;
 unsigned short send_implementation_id = 1;
 char nfs4_client_id_uniquifier[NFS4_CLIENT_ID_UNIQ_LEN] = "";
 bool recover_lost_locks = false;
+short nfs_delay_retrans = -1;
 
 EXPORT_SYMBOL_GPL(nfs_callback_nr_threads);
 EXPORT_SYMBOL_GPL(nfs_callback_set_tcpport);
@@ -1378,6 +1379,7 @@ EXPORT_SYMBOL_GPL(max_session_cb_slots);
 EXPORT_SYMBOL_GPL(send_implementation_id);
 EXPORT_SYMBOL_GPL(nfs4_client_id_uniquifier);
 EXPORT_SYMBOL_GPL(recover_lost_locks);
+EXPORT_SYMBOL_GPL(nfs_delay_retrans);
 
 #define NFS_CALLBACK_MAXPORTNR (65535U)
 
@@ -1426,5 +1428,9 @@ MODULE_PARM_DESC(recover_lost_locks,
 		 "If the server reports that a lock might be lost, "
 		 "try to recover it risking data corruption.");
 
-
+module_param_named(delay_retrans, nfs_delay_retrans, short, 0644);
+MODULE_PARM_DESC(delay_retrans,
+		 "Unless negative, specifies the number of times the NFSv4 "
+		 "client retries a request before returning an EAGAIN error, "
+		 "after a reply of NFS4ERR_DELAY from the server.");
 #endif /* CONFIG_NFS_V4 */
-- 
2.41.0


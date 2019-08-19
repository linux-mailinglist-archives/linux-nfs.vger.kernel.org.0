Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD81794E1B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfHST3H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 15:29:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40409 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfHST3H (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 15:29:07 -0400
Received: by mail-io1-f66.google.com with SMTP id t6so6844024ios.7
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2019 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTeskTxSL+DtGp0TXc7KVfC4/gZtxXq4wbGQc6DfmlI=;
        b=qBVg/pTEPso7o7LkHBouWY01sElYyq/GZynstc5n7WnEeLUTBePpiXOMrUvWbBZMTt
         hUfl7jci90IpL79DJmiE6Y/S5lp+sBx1WZoj5CrZW+37WRG9xp2YltfRobnfrLsspek8
         H73Nvy5R8GUiRx80SFxvHtO8nfexItbGIX85rpFgj/K7S+s81DMLoXQZWevgdeDNKjfv
         Pk2aao/MVV1zxaA6E3nk2faublDo2fo+jhyNCq1IdN+EK73cR+bGutSvkrj3cqQKUbc2
         3qN4F/I1YbNIq8eVru9wq3aKZZts/eEjC2yD5ErRklat82/nxfli4w77FZqO0pRUTiMu
         b6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FTeskTxSL+DtGp0TXc7KVfC4/gZtxXq4wbGQc6DfmlI=;
        b=lWdAzVBH+U0uVKM0YiFNcV5UHgG8EOyDokgc7hgvz/qCMsNxsEE+9JOvShfFQWUJvT
         8ADpYTcKmwxLZ5tlgtfpjC4nUlRZxCi0jf6sK0WXhAn5waz5ujdpfbYP2n92jpcXyjCz
         IcnKQxRCFrwGvlbIrXj6M8k8QCJEUL/VVSDqrS6eS8Fl7MnsTwe3PejWArAPTdm6pJ5N
         CavCbfza3b6o8Et1YUIkWpo5Wl7izalvkCerNw9oL0xg6Qx/F04E9xF51GRcfyvrgng5
         g3Y6OIjEu6yFpxWaIOZO7SbgTJTHCHkbHC+wk3LYN3WRKB65IPxzVvjpLf7dpLglVuSG
         UxyA==
X-Gm-Message-State: APjAAAWt+GIGCzb4jwTFkPODbxuZK9Cz4kLBwHaBjCqQOC7Vfut3Jcfb
        71pVHjpVoMTKJIFbKU0O5S0=
X-Google-Smtp-Source: APXvYqwit5her6GcaK3H9PGAQSHIFfV6c6lIy6LdNz3A6kcJkpTS/MlKYb+jf4z31PW+p5xNzFTWpw==
X-Received: by 2002:a6b:7217:: with SMTP id n23mr15717401ioc.194.1566242946712;
        Mon, 19 Aug 2019 12:29:06 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.gmail.com with ESMTPSA id v23sm16243957ioh.58.2019.08.19.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:29:06 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 5/6] NFS: Have nfs41_proc_secinfo_no_name() call nfs4_call_sync_custom()
Date:   Mon, 19 Aug 2019 15:28:59 -0400
Message-Id: <20190819192900.19312-6-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We need to use the custom rpc_task_setup here to set the
RPC_TASK_NO_ROUND_ROBIN flag on the RPC call.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1b7863ec12d3..df12af8f6b36 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9365,18 +9365,32 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_resp = &res,
 	};
 	struct rpc_clnt *clnt = server->client;
+	struct nfs4_call_sync_data data = {
+		.seq_server = server,
+		.seq_args = &args.seq_args,
+		.seq_res = &res.seq_res,
+	};
+	struct rpc_task_setup task_setup = {
+		.rpc_client = server->client,
+		.rpc_message = &msg,
+		.callback_ops = server->nfs_client->cl_mvops->call_sync_ops,
+		.callback_data = &data,
+		.flags = RPC_TASK_NO_ROUND_ROBIN,
+	};
 	const struct cred *cred = NULL;
 	int status;
 
 	if (use_integrity) {
 		clnt = server->nfs_client->cl_rpcclient;
+		task_setup.rpc_client = clnt;
+
 		cred = nfs4_get_clid_cred(server->nfs_client);
 		msg.rpc_cred = cred;
 	}
 
 	dprintk("--> %s\n", __func__);
-	status = nfs4_call_sync(clnt, server, &msg, &args.seq_args,
-				&res.seq_res, RPC_TASK_NO_ROUND_ROBIN);
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	status = nfs4_call_sync_custom(&task_setup);
 	dprintk("<-- %s status=%d\n", __func__, status);
 
 	put_cred(cred);
-- 
2.22.1


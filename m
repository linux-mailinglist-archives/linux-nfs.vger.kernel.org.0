Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25A64B78DF
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Feb 2022 21:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiBOS06 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 13:26:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBOS04 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 13:26:56 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9378BF50
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 10:26:45 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p7so18373927qvk.11
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcGW3wlwlAcS7KVIk0cl1012yM22NJRBNkL1I1tu6DI=;
        b=kl03c5SW8htJTKxCjUZCwppW+19G3ynNC/cVv0t3drX1naSqvfKLXOaha3lGHNW5sT
         dvgA6UEzyykodFo2y3VrrFibKTcZoJEUYyoDfcECfui/A93mDw5QGplJo2/ZbiYtOVtL
         gZ5BPcFV584g98L6QSViXQ4jYtAxuPKmNj+nnLfXtoRv60vqPM1CwXQtjSIV2q5gTnv3
         SpIGrIL2Al8nly3OWSlJCnCX4NU69NVtjnkhQLnL9a/25qtMf7HUj1eZnPwFA3dfSm6U
         HhHHY0TMDMdTYCEnb5YgHY4enD6DyQJWoccgRZRFsMwQ5x+lU9Tp3vX1VbZA41VBdidf
         RqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcGW3wlwlAcS7KVIk0cl1012yM22NJRBNkL1I1tu6DI=;
        b=IsY2AY9eG2frUiQ3rDsEJDnjIYktFkdHChJkQ46SXircMn+3/SMqmFD7LENp9WwXgX
         gc636e8wIMNOoitup3x9+YkAvTkNJ5zsZO4Hue/n9xEGRavos2xHeCOeXUWRMXtjCBQN
         O714W9zgNqgkY7Ov4Jega0sFx+Ag3q94wpd5Boe4BlE6j+zCdeQpAK5FYvLYzueYDVJj
         vnsptBnfGLTGYQNRlS5BqM/m6TUlDR2vrryIwtgjaxf2vPoahsjrulnnGyLr4j9bUAiG
         t9mbO+q/9Hfmwz2N+SyySCkydmVzTouLeSE0kH+P56lWB/Ap8ZG50Nd718Hi36AUmdL0
         HwSg==
X-Gm-Message-State: AOAM533daiXIcsTNOAPDaxfepWbiTqIPp7fKemXzvBG+3gqiNPrZeOd7
        uH1fXaUxCWcMoo0xQoNSmMdgsYKQZsIGvQ==
X-Google-Smtp-Source: ABdhPJzgiDYylANj4dwpXQMizl32IfzofBWbpYKdeO2WxEaY0QPxOlPfpABKlnzLIE5NWlkRjzBM+A==
X-Received: by 2002:a05:6214:5006:: with SMTP id jo6mr300771qvb.55.1644949604410;
        Tue, 15 Feb 2022 10:26:44 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:6013:ae57:cac3:2abd])
        by smtp.gmail.com with ESMTPSA id n19sm10095495qtk.66.2022.02.15.10.26.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Feb 2022 10:26:43 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 restrict GETATTR fs_location query to the main transport
Date:   Tue, 15 Feb 2022 13:26:41 -0500
Message-Id: <20220215182641.46271-1-olga.kornievskaia@gmail.com>
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

In the presence of trunking transports, it's helpful to make sure
that during the migration event, the GETATTR for fs_location attribute
happens on the main transport.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d9bc64ba2ae7..e32dd69df818 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8013,6 +8013,18 @@ static int _nfs41_proc_get_locations(struct nfs_server *server,
 		.rpc_resp	= &res,
 		.rpc_cred	= cred,
 	};
+	struct nfs4_call_sync_data data = {
+		.seq_server = server,
+		.seq_args = &args.seq_args,
+		.seq_res = &res.seq_res,
+	};
+	struct rpc_task_setup task_setup_data = {
+		.rpc_client = clnt,
+		.rpc_message = &msg,
+		.callback_ops = server->nfs_client->cl_mvops->call_sync_ops,
+		.callback_data = &data,
+		.flags = RPC_TASK_NO_ROUND_ROBIN,
+	};
 	int status;
 
 	nfs_fattr_init(&locations->fattr);
@@ -8020,8 +8032,7 @@ static int _nfs41_proc_get_locations(struct nfs_server *server,
 	locations->nlocations = 0;
 
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 1);
-	status = nfs4_call_sync_sequence(clnt, server, &msg,
-					&args.seq_args, &res.seq_res);
+	status = nfs4_call_sync_custom(&task_setup_data);
 	if (status == NFS4_OK &&
 	    res.seq_res.sr_status_flags & SEQ4_STATUS_LEASE_MOVED)
 		status = -NFS4ERR_LEASE_MOVED;
-- 
2.27.0


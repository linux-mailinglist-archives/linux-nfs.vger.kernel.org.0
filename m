Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA3F4FF789
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Apr 2022 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiDMNYe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Apr 2022 09:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiDMNYe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Apr 2022 09:24:34 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B698C56426
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 06:22:12 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 14so1068479ily.11
        for <linux-nfs@vger.kernel.org>; Wed, 13 Apr 2022 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SgUeAP4QU+c4mPduEB84zV/WiQ3XbpMLr4xPBTd65w=;
        b=glka5is9PgUfXr/g3Nzt46BTyPcGNVJu6W14bWQVovuN0E6CB9o3J5VLyNjndhlki/
         lkWOBiLUVwJAiSy5W5nQu2JujHSS84aFF6tSnSn93WFyTPp9sKZ3oHTjHk+yI4jLXWF2
         Q0tD24lnI/Y0YjP3paRe+YsgAyerTp+lN42m2lKmNUoOLfS73nw4aNK4kFs6/ZBy+u1c
         Hv/06Lh0Vksg10WHq/HHhIkMAeN0DQ0/uIKHI1YUp0j3YFYnvyDrUhZyE0jn5WMc/7za
         Qd6Ll0tgh1+hSdL7VwPcnevePdO1a2e0MPX5ixuk2EOcIOcTPvXw1FtazlnWKughOWus
         rviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SgUeAP4QU+c4mPduEB84zV/WiQ3XbpMLr4xPBTd65w=;
        b=6R8G1eXN5kYMzxFGtisAPI0TK+EmeiiPgZ0TspT6AHy3RcRkDvMvLPgjaz1h0E2ryC
         CuH2Eaa46wavF07Etyb4AyS927D3hgf4Snz0spnud9aRgpeWgT5rK6pxiacfNg/QNCZi
         MNhMin7B+zTQ0E9GeaDsqMJQezCku05zNKoQBFVwvWMZtEb4XLVUtok5qxfDVbMfHmcZ
         gh7Na2l66F0XSHGP7Be0Yk5TGWjsbtUFz1j4fDJywJL1pMmoWdtFhc9P7qpsz0XsUUrx
         azwV4BP/Lz0CS7FvXbgVlr/5dYlbXHWygwZ25WkEeMdyRtZuA21oOOWaFouMOW44XLo2
         UdYA==
X-Gm-Message-State: AOAM532+U0WbzO9B/GSW6KEDK2w+mhfWYRD6vX5xWYiCRGgPJU46gKK0
        yAfXMdphoj6okeUHgjsi5b0=
X-Google-Smtp-Source: ABdhPJzip1CChli/O2wOmyqCFRQfECYmQtHNzu8mSjVM84utcUEY1ehRrQaNxDhn4Jia8XxbZA5ymA==
X-Received: by 2002:a05:6e02:1c41:b0:2ca:8a04:ad8d with SMTP id d1-20020a056e021c4100b002ca8a04ad8dmr11550570ilg.195.1649856132049;
        Wed, 13 Apr 2022 06:22:12 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d56:8f42:40d4:63e0])
        by smtp.gmail.com with ESMTPSA id a2-20020a056e02120200b002cac7c342a2sm3386514ilq.46.2022.04.13.06.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:22:10 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 mark qualified async operations as MOVEABLE tasks
Date:   Wed, 13 Apr 2022 09:22:07 -0400
Message-Id: <20220413132207.52825-1-olga.kornievskaia@gmail.com>
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

Mark async operations such as RENAME, REMOVE, COMMIT MOVEABLE
for the nfsv4.1+ sessions.

Fixes: 85e39feead948 ("NFSv4.1 identify and mark RPC tasks that can move between transports")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 16106f805ffa..f593bad996af 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4780,7 +4780,11 @@ static void nfs4_proc_unlink_setup(struct rpc_message *msg,
 
 static void nfs4_proc_unlink_rpc_prepare(struct rpc_task *task, struct nfs_unlinkdata *data)
 {
-	nfs4_setup_sequence(NFS_SB(data->dentry->d_sb)->nfs_client,
+	struct nfs_client *clp = NFS_SB(data->dentry->d_sb)->nfs_client;
+
+	if (clp->cl_minorversion)
+		task->tk_flags |= RPC_TASK_MOVEABLE;
+	nfs4_setup_sequence(clp,
 			&data->args.seq_args,
 			&data->res.seq_res,
 			task);
@@ -4823,7 +4827,11 @@ static void nfs4_proc_rename_setup(struct rpc_message *msg,
 
 static void nfs4_proc_rename_rpc_prepare(struct rpc_task *task, struct nfs_renamedata *data)
 {
-	nfs4_setup_sequence(NFS_SERVER(data->old_dir)->nfs_client,
+	struct nfs_client *clp = NFS_SERVER(data->old_dir)->nfs_client;
+
+	if (clp->cl_minorversion)
+		task->tk_flags |= RPC_TASK_MOVEABLE;
+	nfs4_setup_sequence(clp,
 			&data->args.seq_args,
 			&data->res.seq_res,
 			task);
@@ -5457,7 +5465,11 @@ static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
 static int nfs4_proc_pgio_rpc_prepare(struct rpc_task *task,
 				      struct nfs_pgio_header *hdr)
 {
-	if (nfs4_setup_sequence(NFS_SERVER(hdr->inode)->nfs_client,
+	struct nfs_client *clp = NFS_SERVER(hdr->inode)->nfs_client;
+
+	if (clp->cl_minorversion)
+		task->tk_flags |= RPC_TASK_MOVEABLE;
+	if (nfs4_setup_sequence(clp,
 			&hdr->args.seq_args,
 			&hdr->res.seq_res,
 			task))
@@ -5595,7 +5607,11 @@ static void nfs4_proc_write_setup(struct nfs_pgio_header *hdr,
 
 static void nfs4_proc_commit_rpc_prepare(struct rpc_task *task, struct nfs_commit_data *data)
 {
-	nfs4_setup_sequence(NFS_SERVER(data->inode)->nfs_client,
+	struct nfs_client *clp = NFS_SERVER(data->inode)->nfs_client;
+
+	if (clp->cl_minorversion)
+		task->tk_flags |= RPC_TASK_MOVEABLE;
+	nfs4_setup_sequence(clp,
 			&data->args.seq_args,
 			&data->res.seq_res,
 			task);
-- 
2.27.0


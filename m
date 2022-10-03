Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F075F34BC
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Oct 2022 19:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJCRor (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Oct 2022 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJCRon (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Oct 2022 13:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE5C339
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 10:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC6161195
        for <linux-nfs@vger.kernel.org>; Mon,  3 Oct 2022 17:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B544C4347C;
        Mon,  3 Oct 2022 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664819076;
        bh=U/ajbWiZiy/3y7Ei2/ZUIip3krZuU+SEv1n69J+sxA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J32B7Au6RG52nAvCPqpJptR4HoUmmXCm3nAZCGGc6l8WQEv6y7EGok9Go+bEiIP0s
         DPf1bYAMeBp5WZo/eWwXcRjN+uJk4DWvqasm227i+YfszrO2E8g7bEoz3Upr7NXvhi
         2z3CKkRNCt1HbtueShUzgq/Ok1b0+fF81EFa5LQu9IogvqeWbx0CjH+i/p04IT2jAq
         sOWZD7yo7c1ntkS55U6KOqMhGZUh1iwODIk9aZbkrj8sUU6gqoNbFxvvd549oPYnjw
         wPcLLatu2WaOBzCrhpHAwvW1rgs8Jt3CotpYd3vlVHk/sxW2ptKanekGxbGh6ykpFF
         yxTZQTyYFicYw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH 3/3] NFSv4.2: Add a tracepoint for listxattr
Date:   Mon,  3 Oct 2022 13:44:33 -0400
Message-Id: <20221003174433.476685-3-anna@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003174433.476685-1-anna@kernel.org>
References: <20221003174433.476685-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This can be defined as simply an NFS4_INODE_EVENT() since we don't have
the name of a specific xattr to list. This roughly matches readdir,
which also uses an NFS4_INODE_EVENT() tracepoint.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42proc.c | 1 +
 fs/nfs/nfs4trace.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index c4791ca00df1..ced9170701b6 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1320,6 +1320,7 @@ static ssize_t _nfs42_proc_listxattrs(struct inode *inode, void *buf,
 
 	ret = nfs4_call_sync(server->client, server, &msg, &arg.seq_args,
 	    &res.seq_res, 0);
+	trace_nfs4_listxattr(inode, ret);
 
 	if (ret >= 0) {
 		ret = res.copied;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 650c9353826f..2cff5901c689 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2542,6 +2542,8 @@ DECLARE_EVENT_CLASS(nfs4_xattr_event,
 DEFINE_NFS4_XATTR_EVENT(nfs4_getxattr);
 DEFINE_NFS4_XATTR_EVENT(nfs4_setxattr);
 DEFINE_NFS4_XATTR_EVENT(nfs4_removexattr);
+
+DEFINE_NFS4_INODE_EVENT(nfs4_listxattr);
 #endif /* CONFIG_NFS_V4_2 */
 
 #endif /* CONFIG_NFS_V4_1 */
-- 
2.37.3


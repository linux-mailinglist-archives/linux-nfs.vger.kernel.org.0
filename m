Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D98679F20
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Jan 2023 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjAXQpx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Jan 2023 11:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjAXQpp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Jan 2023 11:45:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BEDC172
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 08:45:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61AE6612C3
        for <linux-nfs@vger.kernel.org>; Tue, 24 Jan 2023 16:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C24CC433EF;
        Tue, 24 Jan 2023 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674578740;
        bh=ZxvdVlLAgNfs7iXN01G1MGedkPS12UVipWw8G+kupTU=;
        h=From:To:Cc:Subject:Date:From;
        b=mdjCKpd19/cb6QQrun9pz8A6PjPUbiH75TNx2UM1IDVyC6SrDPTmjvY4ve7nzhPrW
         y3Vz0PYM8/V8OuseHReVPDZeHTdlbUb/IDfs8PBpbGlm4RvXakGprbg49+L2ejjwSJ
         aAMsmFBVEfUO2zap11BIzLWg+lnEA6w8yerYfPqmKivcWr5xVs96bFYQjdzeztzO4f
         tq+fOYO4NcCYuyVdlQU8uXP6JSNiyZLgJudVNCQIIYHdZqi60mtJvIgGjs+6zSy0Ro
         PB4JKEkDg5TC/UHhEI6jD0d2xRikGm9ECrg42uT777HluxzkJbIUJAhiKLOwDv+jlF
         LKrzPVOWKkmtQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: remove fs/nfsd/fault_inject.c
Date:   Tue, 24 Jan 2023 11:45:38 -0500
Message-Id: <20230124164538.163641-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
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

This file is no longer built at all.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/fault_inject.c | 142 -----------------------------------------
 1 file changed, 142 deletions(-)
 delete mode 100644 fs/nfsd/fault_inject.c

diff --git a/fs/nfsd/fault_inject.c b/fs/nfsd/fault_inject.c
deleted file mode 100644
index 76bee0a0d308..000000000000
--- a/fs/nfsd/fault_inject.c
+++ /dev/null
@@ -1,142 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2011 Bryan Schumaker <bjschuma@netapp.com>
- *
- * Uses debugfs to create fault injection points for client testing
- */
-
-#include <linux/types.h>
-#include <linux/fs.h>
-#include <linux/debugfs.h>
-#include <linux/module.h>
-#include <linux/nsproxy.h>
-#include <linux/sunrpc/addr.h>
-#include <linux/uaccess.h>
-#include <linux/kernel.h>
-
-#include "state.h"
-#include "netns.h"
-
-struct nfsd_fault_inject_op {
-	char *file;
-	u64 (*get)(void);
-	u64 (*set_val)(u64);
-	u64 (*set_clnt)(struct sockaddr_storage *, size_t);
-};
-
-static struct dentry *debug_dir;
-
-static ssize_t fault_inject_read(struct file *file, char __user *buf,
-				 size_t len, loff_t *ppos)
-{
-	static u64 val;
-	char read_buf[25];
-	size_t size;
-	loff_t pos = *ppos;
-	struct nfsd_fault_inject_op *op = file_inode(file)->i_private;
-
-	if (!pos)
-		val = op->get();
-	size = scnprintf(read_buf, sizeof(read_buf), "%llu\n", val);
-
-	return simple_read_from_buffer(buf, len, ppos, read_buf, size);
-}
-
-static ssize_t fault_inject_write(struct file *file, const char __user *buf,
-				  size_t len, loff_t *ppos)
-{
-	char write_buf[INET6_ADDRSTRLEN];
-	size_t size = min(sizeof(write_buf) - 1, len);
-	struct net *net = current->nsproxy->net_ns;
-	struct sockaddr_storage sa;
-	struct nfsd_fault_inject_op *op = file_inode(file)->i_private;
-	u64 val;
-	char *nl;
-
-	if (copy_from_user(write_buf, buf, size))
-		return -EFAULT;
-	write_buf[size] = '\0';
-
-	/* Deal with any embedded newlines in the string */
-	nl = strchr(write_buf, '\n');
-	if (nl) {
-		size = nl - write_buf;
-		*nl = '\0';
-	}
-
-	size = rpc_pton(net, write_buf, size, (struct sockaddr *)&sa, sizeof(sa));
-	if (size > 0) {
-		val = op->set_clnt(&sa, size);
-		if (val)
-			pr_info("NFSD [%s]: Client %s had %llu state object(s)\n",
-				op->file, write_buf, val);
-	} else {
-		val = simple_strtoll(write_buf, NULL, 0);
-		if (val == 0)
-			pr_info("NFSD Fault Injection: %s (all)", op->file);
-		else
-			pr_info("NFSD Fault Injection: %s (n = %llu)",
-				op->file, val);
-		val = op->set_val(val);
-		pr_info("NFSD: %s: found %llu", op->file, val);
-	}
-	return len; /* on success, claim we got the whole input */
-}
-
-static const struct file_operations fops_nfsd = {
-	.owner   = THIS_MODULE,
-	.read    = fault_inject_read,
-	.write   = fault_inject_write,
-};
-
-void nfsd_fault_inject_cleanup(void)
-{
-	debugfs_remove_recursive(debug_dir);
-}
-
-static struct nfsd_fault_inject_op inject_ops[] = {
-	{
-		.file     = "forget_clients",
-		.get	  = nfsd_inject_print_clients,
-		.set_val  = nfsd_inject_forget_clients,
-		.set_clnt = nfsd_inject_forget_client,
-	},
-	{
-		.file     = "forget_locks",
-		.get	  = nfsd_inject_print_locks,
-		.set_val  = nfsd_inject_forget_locks,
-		.set_clnt = nfsd_inject_forget_client_locks,
-	},
-	{
-		.file     = "forget_openowners",
-		.get	  = nfsd_inject_print_openowners,
-		.set_val  = nfsd_inject_forget_openowners,
-		.set_clnt = nfsd_inject_forget_client_openowners,
-	},
-	{
-		.file     = "forget_delegations",
-		.get	  = nfsd_inject_print_delegations,
-		.set_val  = nfsd_inject_forget_delegations,
-		.set_clnt = nfsd_inject_forget_client_delegations,
-	},
-	{
-		.file     = "recall_delegations",
-		.get	  = nfsd_inject_print_delegations,
-		.set_val  = nfsd_inject_recall_delegations,
-		.set_clnt = nfsd_inject_recall_client_delegations,
-	},
-};
-
-void nfsd_fault_inject_init(void)
-{
-	unsigned int i;
-	struct nfsd_fault_inject_op *op;
-	umode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
-
-	debug_dir = debugfs_create_dir("nfsd", NULL);
-
-	for (i = 0; i < ARRAY_SIZE(inject_ops); i++) {
-		op = &inject_ops[i];
-		debugfs_create_file(op->file, mode, debug_dir, op, &fops_nfsd);
-	}
-}
-- 
2.39.1


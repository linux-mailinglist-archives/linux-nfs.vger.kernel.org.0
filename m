Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3487BA148
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbjJEOsF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 10:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjJEOpp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 10:45:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897382C292
        for <linux-nfs@vger.kernel.org>; Thu,  5 Oct 2023 07:27:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9786C3279E;
        Thu,  5 Oct 2023 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696511440;
        bh=LxKcAbPkS1cN5cY1R9jQZD6PER+7X5ZwZdPa6n8vJGg=;
        h=Subject:From:To:Cc:Date:From;
        b=Ju6KwXVz3gkwfKkmEA3JF3RM+/2VRh1g1trHhqI0As4yUigUHpPWgpwcJBsZ6isKm
         ew2AN+WZ150cZNuv7SPIoqxDV6TNCVT9aOnQhM2BiQB04A89TRPBXW15majKXBdd1U
         Mzlv1OdMSCmt7NCfug/NvCk2Wf4ncl2XtgZl1MK/nuoiH6raasAI7A0Z1j0ywpxcuk
         WE0MhJuj/ES+eXZ0U4R1P13sjnMO8jKsDSeEuYmjCXfKbYm1Ed+FHb2ePp1NmXYNgU
         K00wiM4HO4Tz2YVQWHx+VREZKU82u1DMnynnwyay/tU1TZiAGTw1bPKed10iRNCIj9
         jazG71SlqTDBA==
Subject: [PATCH RFC] tools: ynl: Add source files for nfsd netlink protocol
From:   Chuck Lever <cel@kernel.org>
To:     kuba@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
        linux-nfs@vger.kernel.org
Date:   Thu, 05 Oct 2023 09:10:38 -0400
Message-ID: <169651139213.16787.3812644920847558917.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/ynl/generated/Makefile    |    2 -
 tools/net/ynl/generated/nfsd-user.c |   95 +++++++++++++++++++++++++++++++++++
 tools/net/ynl/generated/nfsd-user.h |   33 ++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/generated/nfsd-user.c
 create mode 100644 tools/net/ynl/generated/nfsd-user.h

Hi Jakub-

Should I include this with the nfsd netlink protocol patches already
in nfsd-next, or do you want to take it after those have been merged?


diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index f8817d2e56e4..c1935b01902e 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -14,7 +14,7 @@ YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 
 TOOL:=../ynl-gen-c.py
 
-GENS:=ethtool devlink handshake fou netdev
+GENS:=ethtool devlink handshake fou netdev nfsd
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generated/nfsd-user.c
new file mode 100644
index 000000000000..fec6828680ce
--- /dev/null
+++ b/tools/net/ynl/generated/nfsd-user.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd.yaml */
+/* YNL-GEN user source */
+
+#include <stdlib.h>
+#include <string.h>
+#include "nfsd-user.h"
+#include "ynl.h"
+#include <linux/nfsd_netlink.h>
+
+#include <libmnl/libmnl.h>
+#include <linux/genetlink.h>
+
+/* Enums */
+static const char * const nfsd_op_strmap[] = {
+	[NFSD_CMD_RPC_STATUS_GET] = "rpc-status-get",
+};
+
+const char *nfsd_op_str(int op)
+{
+	if (op < 0 || op >= (int)MNL_ARRAY_SIZE(nfsd_op_strmap))
+		return NULL;
+	return nfsd_op_strmap[op];
+}
+
+/* Policies */
+struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_MAX + 1] = {
+	[NFSD_A_RPC_STATUS_XID] = { .name = "xid", .type = YNL_PT_U32, },
+	[NFSD_A_RPC_STATUS_FLAGS] = { .name = "flags", .type = YNL_PT_U32, },
+	[NFSD_A_RPC_STATUS_PROG] = { .name = "prog", .type = YNL_PT_U32, },
+	[NFSD_A_RPC_STATUS_VERSION] = { .name = "version", .type = YNL_PT_U8, },
+	[NFSD_A_RPC_STATUS_PROC] = { .name = "proc", .type = YNL_PT_U32, },
+	[NFSD_A_RPC_STATUS_SERVICE_TIME] = { .name = "service_time", .type = YNL_PT_U64, },
+	[NFSD_A_RPC_STATUS_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
+	[NFSD_A_RPC_STATUS_SADDR4] = { .name = "saddr4", .type = YNL_PT_U32, },
+	[NFSD_A_RPC_STATUS_DADDR4] = { .name = "daddr4", .type = YNL_PT_U32, },
+	[NFSD_A_RPC_STATUS_SADDR6] = { .name = "saddr6", .type = YNL_PT_BINARY,},
+	[NFSD_A_RPC_STATUS_DADDR6] = { .name = "daddr6", .type = YNL_PT_BINARY,},
+	[NFSD_A_RPC_STATUS_SPORT] = { .name = "sport", .type = YNL_PT_U16, },
+	[NFSD_A_RPC_STATUS_DPORT] = { .name = "dport", .type = YNL_PT_U16, },
+	[NFSD_A_RPC_STATUS_COMPOUND_OPS] = { .name = "compound-ops", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest nfsd_rpc_status_nest = {
+	.max_attr = NFSD_A_RPC_STATUS_MAX,
+	.table = nfsd_rpc_status_policy,
+};
+
+/* Common nested types */
+/* ============== NFSD_CMD_RPC_STATUS_GET ============== */
+/* NFSD_CMD_RPC_STATUS_GET - dump */
+void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp)
+{
+	struct nfsd_rpc_status_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp->obj.saddr6);
+		free(rsp->obj.daddr6);
+		free(rsp->obj.compound_ops);
+		free(rsp);
+	}
+}
+
+struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct nfsd_rpc_status_get_list);
+	yds.cb = nfsd_rpc_status_get_rsp_parse;
+	yds.rsp_cmd = NFSD_CMD_RPC_STATUS_GET;
+	yds.rsp_policy = &nfsd_rpc_status_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_RPC_STATUS_GET, 1);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	nfsd_rpc_status_get_list_free(yds.first);
+	return NULL;
+}
+
+const struct ynl_family ynl_nfsd_family =  {
+	.name		= "nfsd",
+};
diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generated/nfsd-user.h
new file mode 100644
index 000000000000..b6b69501031a
--- /dev/null
+++ b/tools/net/ynl/generated/nfsd-user.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd.yaml */
+/* YNL-GEN user header */
+
+#ifndef _LINUX_NFSD_GEN_H
+#define _LINUX_NFSD_GEN_H
+
+#include <stdlib.h>
+#include <string.h>
+#include <linux/types.h>
+#include <linux/nfsd_netlink.h>
+
+struct ynl_sock;
+
+extern const struct ynl_family ynl_nfsd_family;
+
+/* Enums */
+const char *nfsd_op_str(int op);
+
+/* Common nested types */
+/* ============== NFSD_CMD_RPC_STATUS_GET ============== */
+/* NFSD_CMD_RPC_STATUS_GET - dump */
+struct nfsd_rpc_status_get_list {
+	struct nfsd_rpc_status_get_list *next;
+	struct nfsd_rpc_status_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void nfsd_rpc_status_get_list_free(struct nfsd_rpc_status_get_list *rsp);
+
+struct nfsd_rpc_status_get_list *nfsd_rpc_status_get_dump(struct ynl_sock *ys);
+
+#endif /* _LINUX_NFSD_GEN_H */



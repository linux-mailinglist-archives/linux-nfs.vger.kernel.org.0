Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCC4D0D5
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFTOvW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:22 -0400
Received: from fieldses.org ([173.255.197.46]:43452 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFTOvW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 2679264EE; Thu, 20 Jun 2019 10:51:21 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 09/16] nfsd: add more information to client info file
Date:   Thu, 20 Jun 2019 10:51:08 -0400
Message-Id: <1561042275-12723-10-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561042275-12723-1-git-send-email-bfields@redhat.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Add ip address, full client-provided identifier, and minor version.
There's much more that could possibly be useful but this is a start.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dd89dc05f6ee..430cea90a715 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -42,6 +42,7 @@
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/jhash.h>
+#include <linux/string_helpers.h>
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -2214,6 +2215,13 @@ find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
 	return s;
 }
 
+static void seq_quote_mem(struct seq_file *m, char *data, int len)
+{
+	seq_printf(m, "\"");
+	seq_escape_mem_ascii(m, data, len);
+	seq_printf(m, "\"");
+}
+
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
@@ -2227,6 +2235,10 @@ static int client_info_show(struct seq_file *m, void *v)
 	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: 0x%llx\n", clid);
+	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
+	seq_printf(m, "name: ");
+	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
+	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
 	drop_client(clp);
 
 	return 0;
-- 
2.21.0


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E679E4D0DD
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfFTOvZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:25 -0400
Received: from fieldses.org ([173.255.197.46]:43450 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbfFTOvW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 35DFB67FD; Thu, 20 Jun 2019 10:51:21 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 13/16] nfsd: create get_nfsdfs_clp helper
Date:   Thu, 20 Jun 2019 10:51:12 -0400
Message-Id: <1561042275-12723-14-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561042275-12723-1-git-send-email-bfields@redhat.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Factor our some common code.  No change in behavior.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7867372363ff..63f6b87e178e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2216,6 +2216,15 @@ find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
 	return s;
 }
 
+static struct nfs4_client *get_nfsdfs_clp(struct inode *inode)
+{
+	struct nfsdfs_client *nc;
+	nc = get_nfsdfs_client(inode);
+	if (!nc)
+		return NULL;
+	return container_of(nc, struct nfs4_client, cl_nfsdfs);
+}
+
 static void seq_quote_mem(struct seq_file *m, char *data, int len)
 {
 	seq_printf(m, "\"");
@@ -2226,14 +2235,12 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
-	struct nfsdfs_client *nc;
 	struct nfs4_client *clp;
 	u64 clid;
 
-	nc = get_nfsdfs_client(inode);
-	if (!nc)
+	clp = get_nfsdfs_clp(inode);
+	if (!clp)
 		return -ENXIO;
-	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: 0x%llx\n", clid);
 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
@@ -2444,15 +2451,13 @@ static struct seq_operations states_seq_ops = {
 
 static int client_states_open(struct inode *inode, struct file *file)
 {
-	struct nfsdfs_client *nc;
 	struct seq_file *s;
 	struct nfs4_client *clp;
 	int ret;
 
-	nc = get_nfsdfs_client(inode);
-	if (!nc)
+	clp = get_nfsdfs_clp(inode);
+	if (!clp)
 		return -ENXIO;
-	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
 
 	ret = seq_open(file, &states_seq_ops);
 	if (ret)
-- 
2.21.0


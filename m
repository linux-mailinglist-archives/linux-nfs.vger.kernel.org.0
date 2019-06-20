Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729924D0DA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFTOvY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:24 -0400
Received: from fieldses.org ([173.255.197.46]:43452 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfFTOvX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:23 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 420D66805; Thu, 20 Jun 2019 10:51:21 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 16/16] nfsd: decode implementation id
Date:   Thu, 20 Jun 2019 10:51:15 -0400
Message-Id: <1561042275-12723-17-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561042275-12723-1-git-send-email-bfields@redhat.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Decode the implementation ID and display in nfsd/clients/#/info.  It may
be help identify the client.  It won't be used otherwise.

(When this went into the protocol, I thought the implementation ID would
be a slippery slope towards implementation-specific workarounds as with
the http user-agent.  But I guess I was wrong, the risk seems pretty low
now.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 30 ++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 21 +++++++++------------
 fs/nfsd/state.h     |  4 ++++
 fs/nfsd/xdr4.h      |  3 +++
 4 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8f35e440ef14..4fcbb5d809a6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1899,6 +1899,8 @@ static void __free_client(struct kref *k)
 	free_svc_cred(&clp->cl_cred);
 	kfree(clp->cl_ownerstr_hashtbl);
 	kfree(clp->cl_name.data);
+	kfree(clp->cl_nii_domain.data);
+	kfree(clp->cl_nii_name.data);
 	idr_destroy(&clp->cl_stateids);
 	kmem_cache_free(client_slab, clp);
 }
@@ -2261,6 +2263,15 @@ static int client_info_show(struct seq_file *m, void *v)
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
+	if (clp->cl_nii_domain.data) {
+		seq_printf(m, "Implementation domain: ");
+		seq_quote_mem(m, clp->cl_nii_domain.data,
+					clp->cl_nii_domain.len);
+		seq_printf(m, "\nImplementation name: ");
+		seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
+		seq_printf(m, "\nImplementation time: [%ld, %ld]\n",
+			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
+	}
 	drop_client(clp);
 
 	return 0;
@@ -2901,6 +2912,22 @@ static bool client_has_state(struct nfs4_client *clp)
 		|| !list_empty(&clp->async_copies);
 }
 
+static __be32 copy_impl_id(struct nfs4_client *clp,
+				struct nfsd4_exchange_id *exid)
+{
+	if (!exid->nii_domain.data)
+		return 0;
+	xdr_netobj_dup(&clp->cl_nii_domain, &exid->nii_domain, GFP_KERNEL);
+	if (!clp->cl_nii_domain.data)
+		return nfserr_jukebox;
+	xdr_netobj_dup(&clp->cl_nii_name, &exid->nii_name, GFP_KERNEL);
+	if (!clp->cl_nii_name.data)
+		return nfserr_jukebox;
+	clp->cl_nii_time.tv_sec = exid->nii_time.tv_sec;
+	clp->cl_nii_time.tv_nsec = exid->nii_time.tv_nsec;
+	return 0;
+}
+
 __be32
 nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -2927,6 +2954,9 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	new = create_client(exid->clname, rqstp, &verf);
 	if (new == NULL)
 		return nfserr_jukebox;
+	status = copy_impl_id(new, exid);
+	if (status)
+		goto out_nolock;
 
 	switch (exid->spa_how) {
 	case SP4_MACH_CRED:
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 52c4f6daa649..3bb147822205 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1398,7 +1398,6 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 		goto xdr_error;
 	}
 
-	/* Ignore Implementation ID */
 	READ_BUF(4);    /* nfs_impl_id4 array length */
 	dummy = be32_to_cpup(p++);
 
@@ -1406,21 +1405,19 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 		goto xdr_error;
 
 	if (dummy == 1) {
-		/* nii_domain */
-		READ_BUF(4);
-		dummy = be32_to_cpup(p++);
-		READ_BUF(dummy);
-		p += XDR_QUADLEN(dummy);
+		status = nfsd4_decode_opaque(argp, &exid->nii_domain);
+		if (status)
+			goto xdr_error;
 
 		/* nii_name */
-		READ_BUF(4);
-		dummy = be32_to_cpup(p++);
-		READ_BUF(dummy);
-		p += XDR_QUADLEN(dummy);
+		status = nfsd4_decode_opaque(argp, &exid->nii_name);
+		if (status)
+			goto xdr_error;
 
 		/* nii_date */
-		READ_BUF(12);
-		p += 3;
+		status = nfsd4_decode_time(argp, &exid->nii_time);
+		if (status)
+			goto xdr_error;
 	}
 	DECODE_TAIL;
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 81852cbf6b0a..8cb20cab012b 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -317,6 +317,10 @@ struct nfs4_client {
 	clientid_t		cl_clientid;	/* generated by server */
 	nfs4_verifier		cl_confirm;	/* generated by server */
 	u32			cl_minorversion;
+	/* NFSv4.1 client implementation id: */
+	struct xdr_netobj	cl_nii_domain;
+	struct xdr_netobj	cl_nii_name;
+	struct timespec		cl_nii_time;
 
 	/* for v4.0 and v4.1 callbacks: */
 	struct nfs4_cb_conn	cl_cb_conn;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index feeb6d4bdffd..a5222fc9ea44 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -410,6 +410,9 @@ struct nfsd4_exchange_id {
 	int		spa_how;
 	u32             spo_must_enforce[3];
 	u32             spo_must_allow[3];
+	struct xdr_netobj nii_domain;
+	struct xdr_netobj nii_name;
+	struct timespec nii_time;
 };
 
 struct nfsd4_sequence {
-- 
2.21.0


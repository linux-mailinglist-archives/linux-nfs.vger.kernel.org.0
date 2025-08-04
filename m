Return-Path: <linux-nfs+bounces-13397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF80B199D9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A991E3B3724
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 01:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7131EDA2B;
	Mon,  4 Aug 2025 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmCL89dt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D21EA7CC
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270973; cv=none; b=JATm5EyAN/Sq4WYwvD5K/2J50MUXxhUXkwjAyMNKbPX0Bqm58kgwDSfoKqT14d6E7Mxx3LUA0OMjwqRI4jmxQoqELkoqGhXU9IFhsw6mdF1EhDOXq6TVebnL3xUIQwRxXw8z8PIg4YV3cbxkcg/a63Gp4EbcQJlUaYeFer48vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270973; c=relaxed/simple;
	bh=Rw35dnIPY6YspraQMs7zvZ3aQUL9wTrozG8sOoiQXSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2/Y5kT1tuJEV2W7VCzFH5pSJ6v3+6jHm7mV0NbVYwKtpHbm/tzK0du99BsCKWWTUlClKOBiHR0m9IKlu9CchCrq0ypxg+tNlnt7erdgVWHOq7ZpiFRpSmpYamaqcUSUnt/5aFFk/c3xSTPojuQuwPxY8TcuwH55urzIj6xwwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmCL89dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C36C4CEF9
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 01:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754270971;
	bh=Rw35dnIPY6YspraQMs7zvZ3aQUL9wTrozG8sOoiQXSk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HmCL89dt1o5xK+Nhgi000mq0Bo2HzRuYwuj6L1n8J3CUZOhl/giqgMj/aAqFElMIu
	 8AmJaUDKqRcZ/s8XZzrfeloUmx36kih53F1YU/QlfP9bqLCjJTZskF1r1+SDwRvTzb
	 W9krci87IaUt8yISW5obWUHVGx1+yb+zKcOVxVeJu7ntyEsTTbRbTufH3zw8wtj+Ra
	 3WRf1I62DhoxwACADMOzarQEiat7a3D3mNIDoRtMOL1TouR2YRKd5iHUENi17ozQci
	 L45RldvJ7rD8nMQXUiG76npoMz4jUy1VeQmPRiCAoE6g1MFbuO9I1NwbxyHN2HnbRf
	 id0NZ9iff+PBQ==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Remove duplicate lookups, capability probes and fsinfo calls
Date: Sun,  3 Aug 2025 18:29:29 -0700
Message-ID: <c7c737e442abb6984cef194fd8d66acab2e0b83f.1754270543.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754270543.git.trond.myklebust@hammerspace.com>
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When crossing into a new filesystem, the NFSv4 client will look up the
new directory, and then call nfs4_server_capabilities() as well as
nfs4_do_fsinfo() at least twice.

This patch removes the duplicate calls, and reduces the initial lookup
to retrieve just a minimal set of attributes.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h     |  5 ++-
 fs/nfs/nfs4getroot.c | 14 +++----
 fs/nfs/nfs4proc.c    | 87 ++++++++++++++++++++------------------------
 3 files changed, 48 insertions(+), 58 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index d3ca91f60fc1..c34c89af9c7d 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -63,7 +63,7 @@ struct nfs4_minor_version_ops {
 	bool	(*match_stateid)(const nfs4_stateid *,
 			const nfs4_stateid *);
 	int	(*find_root_sec)(struct nfs_server *, struct nfs_fh *,
-			struct nfs_fsinfo *);
+				 struct nfs_fattr *);
 	void	(*free_lock_state)(struct nfs_server *,
 			struct nfs4_lock_state *);
 	int	(*test_and_free_expired)(struct nfs_server *,
@@ -296,7 +296,8 @@ extern int nfs4_call_sync(struct rpc_clnt *, struct nfs_server *,
 extern void nfs4_init_sequence(struct nfs4_sequence_args *, struct nfs4_sequence_res *, int, int);
 extern int nfs4_proc_setclientid(struct nfs_client *, u32, unsigned short, const struct cred *, struct nfs4_setclientid_res *);
 extern int nfs4_proc_setclientid_confirm(struct nfs_client *, struct nfs4_setclientid_res *arg, const struct cred *);
-extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh *, struct nfs_fsinfo *, bool);
+extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh *,
+				struct nfs_fattr *, bool);
 extern int nfs4_proc_bind_conn_to_session(struct nfs_client *, const struct cred *cred);
 extern int nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cred);
 extern int nfs4_destroy_clientid(struct nfs_client *clp);
diff --git a/fs/nfs/nfs4getroot.c b/fs/nfs/nfs4getroot.c
index 1a69479a3a59..e67ea345de69 100644
--- a/fs/nfs/nfs4getroot.c
+++ b/fs/nfs/nfs4getroot.c
@@ -12,30 +12,28 @@
 
 int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh, bool auth_probe)
 {
-	struct nfs_fsinfo fsinfo;
+	struct nfs_fattr *fattr = nfs_alloc_fattr();
 	int ret = -ENOMEM;
 
-	fsinfo.fattr = nfs_alloc_fattr();
-	if (fsinfo.fattr == NULL)
+	if (fattr == NULL)
 		goto out;
 
 	/* Start by getting the root filehandle from the server */
-	ret = nfs4_proc_get_rootfh(server, mntfh, &fsinfo, auth_probe);
+	ret = nfs4_proc_get_rootfh(server, mntfh, fattr, auth_probe);
 	if (ret < 0) {
 		dprintk("nfs4_get_rootfh: getroot error = %d\n", -ret);
 		goto out;
 	}
 
-	if (!(fsinfo.fattr->valid & NFS_ATTR_FATTR_TYPE)
-			|| !S_ISDIR(fsinfo.fattr->mode)) {
+	if (!(fattr->valid & NFS_ATTR_FATTR_TYPE) || !S_ISDIR(fattr->mode)) {
 		printk(KERN_ERR "nfs4_get_rootfh:"
 		       " getroot encountered non-directory\n");
 		ret = -ENOTDIR;
 		goto out;
 	}
 
-	memcpy(&server->fsid, &fsinfo.fattr->fsid, sizeof(server->fsid));
+	memcpy(&server->fsid, &fattr->fsid, sizeof(server->fsid));
 out:
-	nfs_free_fattr(fsinfo.fattr);
+	nfs_free_fattr(fattr);
 	return ret;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c7c7ec22f21d..7d2b67e06cc3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4240,15 +4240,18 @@ static int nfs4_discover_trunking(struct nfs_server *server,
 }
 
 static int _nfs4_lookup_root(struct nfs_server *server, struct nfs_fh *fhandle,
-		struct nfs_fsinfo *info)
+			     struct nfs_fattr *fattr)
 {
-	u32 bitmask[3];
+	u32 bitmask[3] = {
+		[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
+		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FSID,
+	};
 	struct nfs4_lookup_root_arg args = {
 		.bitmask = bitmask,
 	};
 	struct nfs4_lookup_res res = {
 		.server = server,
-		.fattr = info->fattr,
+		.fattr = fattr,
 		.fh = fhandle,
 	};
 	struct rpc_message msg = {
@@ -4257,27 +4260,20 @@ static int _nfs4_lookup_root(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_resp = &res,
 	};
 
-	bitmask[0] = nfs4_fattr_bitmap[0];
-	bitmask[1] = nfs4_fattr_bitmap[1];
-	/*
-	 * Process the label in the upcoming getfattr
-	 */
-	bitmask[2] = nfs4_fattr_bitmap[2] & ~FATTR4_WORD2_SECURITY_LABEL;
-
-	nfs_fattr_init(info->fattr);
+	nfs_fattr_init(fattr);
 	return nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 }
 
 static int nfs4_lookup_root(struct nfs_server *server, struct nfs_fh *fhandle,
-		struct nfs_fsinfo *info)
+			    struct nfs_fattr *fattr)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
 	int err;
 	do {
-		err = _nfs4_lookup_root(server, fhandle, info);
-		trace_nfs4_lookup_root(server, fhandle, info->fattr, err);
+		err = _nfs4_lookup_root(server, fhandle, fattr);
+		trace_nfs4_lookup_root(server, fhandle, fattr, err);
 		switch (err) {
 		case 0:
 		case -NFS4ERR_WRONGSEC:
@@ -4290,8 +4286,9 @@ static int nfs4_lookup_root(struct nfs_server *server, struct nfs_fh *fhandle,
 	return err;
 }
 
-static int nfs4_lookup_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
-				struct nfs_fsinfo *info, rpc_authflavor_t flavor)
+static int nfs4_lookup_root_sec(struct nfs_server *server,
+				struct nfs_fh *fhandle, struct nfs_fattr *fattr,
+				rpc_authflavor_t flavor)
 {
 	struct rpc_auth_create_args auth_args = {
 		.pseudoflavor = flavor,
@@ -4301,7 +4298,7 @@ static int nfs4_lookup_root_sec(struct nfs_server *server, struct nfs_fh *fhandl
 	auth = rpcauth_create(&auth_args, server->client);
 	if (IS_ERR(auth))
 		return -EACCES;
-	return nfs4_lookup_root(server, fhandle, info);
+	return nfs4_lookup_root(server, fhandle, fattr);
 }
 
 /*
@@ -4314,7 +4311,7 @@ static int nfs4_lookup_root_sec(struct nfs_server *server, struct nfs_fh *fhandl
  * negative errno value.
  */
 static int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
-			      struct nfs_fsinfo *info)
+			      struct nfs_fattr *fattr)
 {
 	/* Per 3530bis 15.33.5 */
 	static const rpc_authflavor_t flav_array[] = {
@@ -4330,8 +4327,9 @@ static int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
 	if (server->auth_info.flavor_len > 0) {
 		/* try each flavor specified by user */
 		for (i = 0; i < server->auth_info.flavor_len; i++) {
-			status = nfs4_lookup_root_sec(server, fhandle, info,
-						server->auth_info.flavors[i]);
+			status = nfs4_lookup_root_sec(
+				server, fhandle, fattr,
+				server->auth_info.flavors[i]);
 			if (status == -NFS4ERR_WRONGSEC || status == -EACCES)
 				continue;
 			break;
@@ -4339,7 +4337,7 @@ static int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
 	} else {
 		/* no flavors specified by user, try default list */
 		for (i = 0; i < ARRAY_SIZE(flav_array); i++) {
-			status = nfs4_lookup_root_sec(server, fhandle, info,
+			status = nfs4_lookup_root_sec(server, fhandle, fattr,
 						      flav_array[i]);
 			if (status == -NFS4ERR_WRONGSEC || status == -EACCES)
 				continue;
@@ -4363,28 +4361,22 @@ static int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
  * nfs4_proc_get_rootfh - get file handle for server's pseudoroot
  * @server: initialized nfs_server handle
  * @fhandle: we fill in the pseudo-fs root file handle
- * @info: we fill in an FSINFO struct
+ * @fattr: we fill in a bare bones struct fattr
  * @auth_probe: probe the auth flavours
  *
  * Returns zero on success, or a negative errno.
  */
 int nfs4_proc_get_rootfh(struct nfs_server *server, struct nfs_fh *fhandle,
-			 struct nfs_fsinfo *info,
-			 bool auth_probe)
+			 struct nfs_fattr *fattr, bool auth_probe)
 {
 	int status = 0;
 
 	if (!auth_probe)
-		status = nfs4_lookup_root(server, fhandle, info);
+		status = nfs4_lookup_root(server, fhandle, fattr);
 
 	if (auth_probe || status == NFS4ERR_WRONGSEC)
-		status = server->nfs_client->cl_mvops->find_root_sec(server,
-				fhandle, info);
-
-	if (status == 0)
-		status = nfs4_server_capabilities(server, fhandle);
-	if (status == 0)
-		status = nfs4_do_fsinfo(server, fhandle, info);
+		status = server->nfs_client->cl_mvops->find_root_sec(
+			server, fhandle, fattr);
 
 	return nfs4_map_errors(status);
 }
@@ -10351,10 +10343,10 @@ nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data, bool sync)
  * Use the state managment nfs_client cl_rpcclient, which uses krb5i (if
  * possible) as per RFC3530bis and RFC5661 Security Considerations sections
  */
-static int
-_nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
-		    struct nfs_fsinfo *info,
-		    struct nfs4_secinfo_flavors *flavors, bool use_integrity)
+static int _nfs41_proc_secinfo_no_name(struct nfs_server *server,
+				       struct nfs_fh *fhandle,
+				       struct nfs4_secinfo_flavors *flavors,
+				       bool use_integrity)
 {
 	struct nfs41_secinfo_no_name_args args = {
 		.style = SECINFO_STYLE_CURRENT_FH,
@@ -10398,9 +10390,9 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 	return status;
 }
 
-static int
-nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
-			   struct nfs_fsinfo *info, struct nfs4_secinfo_flavors *flavors)
+static int nfs41_proc_secinfo_no_name(struct nfs_server *server,
+				      struct nfs_fh *fhandle,
+				      struct nfs4_secinfo_flavors *flavors)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
@@ -10412,7 +10404,7 @@ nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 
 		/* try to use integrity protection with machine cred */
 		if (_nfs4_is_integrity_protected(server->nfs_client))
-			err = _nfs41_proc_secinfo_no_name(server, fhandle, info,
+			err = _nfs41_proc_secinfo_no_name(server, fhandle,
 							  flavors, true);
 
 		/*
@@ -10422,7 +10414,7 @@ nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 		 * the current filesystem's rpc_client and the user cred.
 		 */
 		if (err == -NFS4ERR_WRONGSEC)
-			err = _nfs41_proc_secinfo_no_name(server, fhandle, info,
+			err = _nfs41_proc_secinfo_no_name(server, fhandle,
 							  flavors, false);
 
 		switch (err) {
@@ -10438,9 +10430,8 @@ nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 	return err;
 }
 
-static int
-nfs41_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
-		    struct nfs_fsinfo *info)
+static int nfs41_find_root_sec(struct nfs_server *server,
+			       struct nfs_fh *fhandle, struct nfs_fattr *fattr)
 {
 	int err;
 	struct page *page;
@@ -10456,14 +10447,14 @@ nfs41_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
 	}
 
 	flavors = page_address(page);
-	err = nfs41_proc_secinfo_no_name(server, fhandle, info, flavors);
+	err = nfs41_proc_secinfo_no_name(server, fhandle, flavors);
 
 	/*
 	 * Fall back on "guess and check" method if
 	 * the server doesn't support SECINFO_NO_NAME
 	 */
 	if (err == -NFS4ERR_WRONGSEC || err == -ENOTSUPP) {
-		err = nfs4_find_root_sec(server, fhandle, info);
+		err = nfs4_find_root_sec(server, fhandle, fattr);
 		goto out_freepage;
 	}
 	if (err)
@@ -10488,8 +10479,8 @@ nfs41_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
 			flavor = RPC_AUTH_MAXFLAVOR;
 
 		if (flavor != RPC_AUTH_MAXFLAVOR) {
-			err = nfs4_lookup_root_sec(server, fhandle,
-						   info, flavor);
+			err = nfs4_lookup_root_sec(server, fhandle, fattr,
+						   flavor);
 			if (!err)
 				break;
 		}
-- 
2.50.1



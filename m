Return-Path: <linux-nfs+bounces-6027-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F9965552
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 04:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FB91C224DA
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 02:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E7380;
	Fri, 30 Aug 2024 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oVhB6u1Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IJGR9Uyq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oVhB6u1Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IJGR9Uyq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C64D8CB
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985584; cv=none; b=fVgm25de6EmVzRy68GIp3dAL3WFSfqLDakowHUmxUqhCfHBQ7n9gv+++ctqNO++urU8cbr1Zegjy4MKlRuhdNbgYVUz+rboRMY4bJd2P4jV2fBMXmiCOAYqNNZUN3/O9vELI2mMyadaVdck2zjafAJrYOn+HG4h8PmulqFeoqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985584; c=relaxed/simple;
	bh=ZkB9Je2W03YxRPtD5kV6VCvi1IJ4zrWAq6oFboSeQ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5UQKLMEzQdkRpTtxvpBekECxUYqejG9+hC/JDv7mCnEhECTlkaoEAShntC7XyOiUws/WS6oxAq/2W45oRQ6GVo5Mb921kSaMR9Mk9YaHM0Kk1T23BfksaXllsibicvhRoxMwTwac2JSw8zPTI2O0WjjuJN4hx4OpLPFGgeBjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oVhB6u1Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IJGR9Uyq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oVhB6u1Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IJGR9Uyq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CFB31F791;
	Fri, 30 Aug 2024 02:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj0UU+McX2u5MOjAxzpLgEYERfLGW4+J5tFgLGXNUQA=;
	b=oVhB6u1ZVPsc5bnZzpOJxfokChni4csZCclqOZGHuiLFxLja+YCBXVD4g/MwJOd1POua0d
	SUudSYuKYgjYGufdnf5VEfE59JTnNI7Nk8pUnzGMJZRm/MRmXUQ/AEthSeCyJf3nWaxGWv
	xQXXo0cUZepi4HLyxr3eiOJK8XD1zFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj0UU+McX2u5MOjAxzpLgEYERfLGW4+J5tFgLGXNUQA=;
	b=IJGR9Uyq4nBgGR4gA5NxCdf0/q/251tZvTnUPYu5tFRrNx1h4EZU/uktThC+0aO0lCzSVv
	2M6FbfE/kS5PYJCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724985580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj0UU+McX2u5MOjAxzpLgEYERfLGW4+J5tFgLGXNUQA=;
	b=oVhB6u1ZVPsc5bnZzpOJxfokChni4csZCclqOZGHuiLFxLja+YCBXVD4g/MwJOd1POua0d
	SUudSYuKYgjYGufdnf5VEfE59JTnNI7Nk8pUnzGMJZRm/MRmXUQ/AEthSeCyJf3nWaxGWv
	xQXXo0cUZepi4HLyxr3eiOJK8XD1zFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724985580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj0UU+McX2u5MOjAxzpLgEYERfLGW4+J5tFgLGXNUQA=;
	b=IJGR9Uyq4nBgGR4gA5NxCdf0/q/251tZvTnUPYu5tFRrNx1h4EZU/uktThC+0aO0lCzSVv
	2M6FbfE/kS5PYJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF163136A4;
	Fri, 30 Aug 2024 02:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V3LJKOow0Wb4FwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 02:39:38 +0000
From: NeilBrown <neilb@suse.de>
To: Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 17/25] nfsd: implement server support for NFS_LOCALIO_PROGRAM
Date: Fri, 30 Aug 2024 12:20:30 +1000
Message-ID: <20240830023531.29421-18-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240830023531.29421-1-neilb@suse.de>
References: <20240830023531.29421-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

From: Mike Snitzer <snitzer@kernel.org>

The LOCALIO auxiliary RPC protocol consists of a single "UUID_IS_LOCAL"
RPC method that allows the Linux NFS client to verify the local Linux
NFS server can see the nonce (single-use UUID) the client generated and
made available in nfs_common.  The server expects this protocol to use
the same transport as NFS and NFSACL for its RPCs.  This protocol
isn't part of an IETF standard, nor does it need to be considering it
is Linux-to-Linux auxiliary RPC protocol that amounts to an
implementation detail.

The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
XDR methods are used instead of the less efficient variable sized
methods.

The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
Linux Kernel Organization       400122  nfslocalio

After a successful handshake the client will hold a non-counted
reference to the server's network namespace.  On namespace shutdown
these non-counted references will be invalidated.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
[neilb: factored out and simplified single localio protocol]
Co-developed-by: NeilBrown <neil@brown.name>
Signed-off-by: NeilBrown <neil@brown.name>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/localio.c   | 77 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfsctl.c    | 16 ++++++++++
 fs/nfsd/nfsd.h      |  4 +++
 fs/nfsd/nfssvc.c    | 23 +++++++++++++-
 include/linux/nfs.h |  7 +++++
 6 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 637402eecb61..491bf5017d34 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -13,12 +13,15 @@
 #include <linux/nfs.h>
 #include <linux/nfs_common.h>
 #include <linux/nfslocalio.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
 #include <linux/string.h>
 
 #include "nfsd.h"
 #include "vfs.h"
 #include "netns.h"
 #include "filecache.h"
+#include "cache.h"
 
 /**
  * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
@@ -112,3 +115,77 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
 /* Compile time type checking, not used by anything */
 static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
+
+/*
+ * UUID_IS_LOCAL XDR functions
+ */
+
+static __be32 localio_proc_null(struct svc_rqst *rqstp)
+{
+	return rpc_success;
+}
+
+struct localio_uuidarg {
+	uuid_t			uuid;
+};
+
+static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
+{
+	struct localio_uuidarg *argp = rqstp->rq_argp;
+	struct net *net = SVC_NET(rqstp);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
+			  net, rqstp->rq_client);
+
+	return rpc_success;
+}
+
+static bool localio_decode_uuidarg(struct svc_rqst *rqstp,
+				   struct xdr_stream *xdr)
+{
+	struct localio_uuidarg *argp = rqstp->rq_argp;
+	u8 uuid[UUID_SIZE];
+
+	if (decode_opaque_fixed(xdr, uuid, UUID_SIZE))
+		return false;
+	import_uuid(&argp->uuid, uuid);
+
+	return true;
+}
+
+static const struct svc_procedure localio_procedures1[] = {
+	[LOCALIOPROC_NULL] = {
+		.pc_func = localio_proc_null,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 0,
+		.pc_name = "NULL",
+	},
+	[LOCALIOPROC_UUID_IS_LOCAL] = {
+		.pc_func = localio_proc_uuid_is_local,
+		.pc_decode = localio_decode_uuidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct localio_uuidarg),
+		.pc_argzero = sizeof(struct localio_uuidarg),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "UUID_IS_LOCAL",
+	},
+};
+
+#define LOCALIO_NR_PROCEDURES ARRAY_SIZE(localio_procedures1)
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      localio_count[LOCALIO_NR_PROCEDURES]);
+const struct svc_version localio_version1 = {
+	.vs_vers	= 1,
+	.vs_nproc	= LOCALIO_NR_PROCEDURES,
+	.vs_proc	= localio_procedures1,
+	.vs_dispatch	= nfsd_dispatch,
+	.vs_count	= localio_count,
+	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
+	.vs_hidden	= true,
+};
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index e2d953f21dde..9c65db8d3f44 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -216,6 +216,8 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+	/* Local clients to be invalidated when net is shut down */
+	struct list_head	local_clients;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 64c1b4d649bc..01e383d692ab 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -18,6 +18,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
+#include <linux/nfslocalio.h>
 
 #include "idmap.h"
 #include "nfsd.h"
@@ -2257,6 +2258,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 	nfsd_proc_stat_init(net);
+	INIT_LIST_HEAD(&nn->local_clients);
 
 	return 0;
 
@@ -2268,6 +2270,19 @@ static __net_init int nfsd_net_init(struct net *net)
 	return retval;
 }
 
+/**
+ * nfsd_net_pre_exit - Disconnect localio clients from net namespace
+ * @net: a network namespace that is about to be destroyed
+ *
+ * This invalidated ->net pointers held by localio clients
+ * while they can still safely access nn->counter.
+ */
+static __net_exit void nfsd_net_pre_exit(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfs_uuid_invalidate_clients(&nn->local_clients);
+}
 /**
  * nfsd_net_exit - Release the nfsd_net portion of a net namespace
  * @net: a network namespace that is about to be destroyed
@@ -2285,6 +2300,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 
 static struct pernet_operations nfsd_net_ops = {
 	.init = nfsd_net_init,
+	.pre_exit = nfsd_net_pre_exit,
 	.exit = nfsd_net_exit,
 	.id   = &nfsd_net_id,
 	.size = sizeof(struct nfsd_net),
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b0d3e82d6dcd..232a873dc53a 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -146,6 +146,10 @@ extern const struct svc_version nfsd_acl_version3;
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+extern const struct svc_version localio_version1;
+#endif
+
 struct nfsd_net;
 
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 13c69aa40d1c..eec4a9803c4a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -80,6 +80,15 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+static const struct svc_version *localio_versions[] = {
+	[1] = &localio_version1,
+};
+
+#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
+
+#endif /* CONFIG_NFSD_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
@@ -128,6 +137,18 @@ struct svc_program		nfsd_programs[] = {
 	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
 	},
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	{
+	.pg_prog		= NFS_LOCALIO_PROGRAM,
+	.pg_nvers		= NFSD_LOCALIO_NRVERS,
+	.pg_vers		= localio_versions,
+	.pg_name		= "nfslocalio",
+	.pg_class		= "nfsd",
+	.pg_authenticate	= svc_set_client,
+	.pg_init_request	= svc_generic_init_request,
+	.pg_rpcbind_set		= svc_generic_rpcbind_set,
+	}
+#endif /* IS_ENABLED(CONFIG_NFSD_LOCALIO) */
 };
 
 bool nfsd_support_version(int vers)
@@ -949,7 +970,7 @@ nfsd(void *vrqstp)
 }
 
 /**
- * nfsd_dispatch - Process an NFS or NFSACL Request
+ * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
  * @rqstp: incoming request
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index ceb70a926b95..5ff1a5b3b00c 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -13,6 +13,13 @@
 #include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
+/* The localio program is entirely private to Linux and is
+ * NOT part of the uapi.
+ */
+#define NFS_LOCALIO_PROGRAM		400122
+#define LOCALIOPROC_NULL		0
+#define LOCALIOPROC_UUID_IS_LOCAL	1
+
 /*
  * This is the kernel NFS client file handle representation
  */
-- 
2.44.0



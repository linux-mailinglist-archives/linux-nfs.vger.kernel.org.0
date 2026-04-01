Return-Path: <linux-nfs+bounces-20602-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE54MZJ2zWnYdgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20602-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:48:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0037FF19
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33163302F38B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6101F1932;
	Wed,  1 Apr 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8V5crTC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5730C62D
	for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2026 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072715; cv=none; b=AMZfctzLAgV7SLi3BatDyYMoExttgdYXNmomig+TcQeP/IDzZJZ0oHHSzmrELw5qfIjL+vYaX+EH03IdJkpc+k0aRBWfofnN2M+JsndafAhC6Awi2YXyov42odiYvqf2ruH67DEgGFi45dArJlx5Ke7riCNIOFLxkvZJhDVYNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072715; c=relaxed/simple;
	bh=MIawscDzMwcdDHmCytX9FTLicxult7SPqIZhevQrc/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D49d/1Ys9F7RiZbhXRouBUoRRqvdn1Zc3ixZKfA+w0hGOxPrcVBG5VhYIGMs8DBqMadktaI2UmtifKXMNJfm6mJOYoGy/fViYS4YzZGXaaFrgZOEVq9BljTGM77LrqmQ0+mLynLiK/2HaAmKmex16NWK0ZWRx2G/U7BWID8VvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8V5crTC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3595485abbbso42666a91.2
        for <linux-nfs@vger.kernel.org>; Wed, 01 Apr 2026 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775072714; x=1775677514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ILPcdOAlFLDQ1M/h8Zfpg04MJ61ulMteVybRV3p/w4=;
        b=M8V5crTCDOPwCgF/mo16DV9TxDa08+maksXJ5Zv1VmTMxqAR0NvcTdNBWLl5D5h3hb
         U8i1XfsAdVAwA2TEhNR7F/BJozdH5aBwcvnYB9zYTjGwg7xlfb58MG6lmKEQ1ksFN7J5
         v4EyBSXUWmCHuteMBv60Z08y5AI2Ln1q0Uft5DI3gZChsniPdUr5kmPOQpqNRT1AU/RF
         n895SKBGdduNgH6oJTkLR9h5PqdRNaVcDyjfCeIOwBCLqTFIUbzhalES7aOxBXwUjtGQ
         N5Zp3itpxEz5ChLa05oxgscT00NPN8N2Ghw2lMNmjFM5dJHYk5Vo9xIgmP9SeExSX2Gl
         Homw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072714; x=1775677514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ILPcdOAlFLDQ1M/h8Zfpg04MJ61ulMteVybRV3p/w4=;
        b=odS8c2vtvIhVFbxR/z8P6Q8X1Fq8I4jhTTa25ojo4bz0WRtzpREJ8DXbtUrrwqxsHw
         Q5aIaC/dXx91ux+F7WGT7RuT1QzaHWqXQiTBkMn0j9t9/OLIQFcnHq9LJo/wkRLuXRVv
         Pda+HT/sAD/i98KnPh2E2C0S/3YBv6AThWZdn9nTTSnT5nEKRKyPbG/Q7uLclTZuLVut
         g0YBFj+Sfin93ugOR2cOZaAezSqGssy9TcYXFkC2LTugfr7NFUV73++isKaCjOQ2uKHU
         8bnRNilXAu/eTm62kmJnipOpSo+tNRqT3+SdqbjzmwwJq6uC664FG6Yn9bG+OTMEocRO
         LdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXwcbbW6mOXoQ1sBehywjMY45LYw4kRn68jncmAudkO5nj/VHLkksDXkfjyM+bfcJASVG6QsmJiEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZh/Mly8XZhQOn0HGw3q7PKiHmUeZHZHfYnNMf3q6+dgzppBvJ
	YLQzJOxcUN+SJTz13PHycddXAeERB9Xdar+zu1IcHvSSc67OxgoSOTBudsCjBItjcgomXOPHcNc
	ilQ==
X-Received: from pgdj2.prod.google.com ([2002:a05:6a02:5202:b0:c76:bc8f:4eb4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224e:b0:35d:974d:8f3
 with SMTP id 98e67ed59e1d1-35dc6edc187mr4602486a91.15.1775072713480; Wed, 01
 Apr 2026 12:45:13 -0700 (PDT)
Date: Wed,  1 Apr 2026 19:44:58 +0000
In-Reply-To: <20260401194501.2269200-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401194501.2269200-1-praan@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260401194501.2269200-3-praan@google.com>
Subject: [RFC PATCH 2/4] nfs: add NFS_CAP_P2PDMA and detect transport support
From: Pranjal Shrivastava <praan@google.com>
To: trond.myklebust@hammerspace.com, anna@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com, 
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20602-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13C0037FF19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The NFS server capabilities bitmask (server->caps) is currently full,
utilizing all 32 bits of the existing unsigned int. Expand the bitmask
to 64 bits (u64) to allow for new feature flags.

Introduce a new capability bit, NFS_CAP_P2PDMA, to indicate that the
local mount is backed by hardware and a transport capable of PCI
Peer-to-Peer DMA.

Update nfs_server_set_init_caps() to query the underlying SunRPC
transport for P2PDMA support during the mount process. If the transport
(e.g., RDMA) signals support, set the NFS_CAP_P2PDMA bit in the mount's
capabilities. This allows the high-performance Direct I/O path to
efficiently determine if it should allow P2P memory buffers.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/client.c           |  8 +++++
 fs/nfs/nfs4_fs.h          |  2 +-
 fs/nfs/super.c            |  2 +-
 include/linux/nfs_fs_sb.h | 67 ++++++++++++++++++++-------------------
 4 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index be02bb227741..f177cf098d44 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -712,6 +712,8 @@ static void nfs4_server_set_init_caps(struct nfs_server *server)
 
 void nfs_server_set_init_caps(struct nfs_server *server)
 {
+	struct rpc_xprt *xprt;
+
 	switch (server->nfs_client->rpc_ops->version) {
 	case 2:
 		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
@@ -725,6 +727,12 @@ void nfs_server_set_init_caps(struct nfs_server *server)
 		nfs4_server_set_init_caps(server);
 		break;
 	}
+
+	rcu_read_lock();
+	xprt = rcu_dereference(server->client->cl_xprt);
+	if (xprt->ops->supports_p2pdma && xprt->ops->supports_p2pdma(xprt))
+		server->caps |= NFS_CAP_P2PDMA;
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);
 
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index b48e5b87cb2a..a309cc739fa3 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -60,7 +60,7 @@ enum nfs4_client_state {
 struct nfs_seqid_counter;
 struct nfs4_minor_version_ops {
 	u32	minor_version;
-	unsigned init_caps;
+	u64	init_caps;
 
 	int	(*init_client)(struct nfs_client *);
 	void	(*shutdown_client)(struct nfs_client *);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a318581f85b..b2de13a355df 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -672,7 +672,7 @@ int nfs_show_stats(struct seq_file *m, struct dentry *root)
 	show_implementation_id(m, nfss);
 
 	seq_puts(m, "\n\tcaps:\t");
-	seq_printf(m, "caps=0x%x", nfss->caps);
+	seq_printf(m, "caps=0x%llx", nfss->caps);
 	seq_printf(m, ",wtmult=%u", nfss->wtmult);
 	seq_printf(m, ",dtsize=%u", nfss->dtsize);
 	seq_printf(m, ",bsize=%u", nfss->bsize);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 4daee27fa5eb..e66818c7a0b8 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -175,7 +175,7 @@ struct nfs_server {
 #define NFS_AUTOMOUNT_INHERIT_RSIZE	0x0002
 #define NFS_AUTOMOUNT_INHERIT_WSIZE	0x0004
 
-	unsigned int		caps;		/* server capabilities */
+	__u64			caps;		/* server capabilities */
 	__u64			fattr_valid;	/* Valid attributes */
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
@@ -299,36 +299,37 @@ struct nfs_server {
 };
 
 /* Server capabilities */
-#define NFS_CAP_READDIRPLUS	(1U << 0)
-#define NFS_CAP_HARDLINKS	(1U << 1)
-#define NFS_CAP_SYMLINKS	(1U << 2)
-#define NFS_CAP_ACLS		(1U << 3)
-#define NFS_CAP_ATOMIC_OPEN	(1U << 4)
-#define NFS_CAP_LGOPEN		(1U << 5)
-#define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
-#define NFS_CAP_CASE_PRESERVING	(1U << 7)
-#define NFS_CAP_REBOOT_LAYOUTRETURN	(1U << 8)
-#define NFS_CAP_OFFLOAD_STATUS	(1U << 9)
-#define NFS_CAP_ZERO_RANGE	(1U << 10)
-#define NFS_CAP_DIR_DELEG	(1U << 11)
-#define NFS_CAP_OPEN_XOR	(1U << 12)
-#define NFS_CAP_DELEGTIME	(1U << 13)
-#define NFS_CAP_POSIX_LOCK	(1U << 14)
-#define NFS_CAP_UIDGID_NOMAP	(1U << 15)
-#define NFS_CAP_STATEID_NFSV41	(1U << 16)
-#define NFS_CAP_ATOMIC_OPEN_V1	(1U << 17)
-#define NFS_CAP_SECURITY_LABEL	(1U << 18)
-#define NFS_CAP_SEEK		(1U << 19)
-#define NFS_CAP_ALLOCATE	(1U << 20)
-#define NFS_CAP_DEALLOCATE	(1U << 21)
-#define NFS_CAP_LAYOUTSTATS	(1U << 22)
-#define NFS_CAP_CLONE		(1U << 23)
-#define NFS_CAP_COPY		(1U << 24)
-#define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
-#define NFS_CAP_LAYOUTERROR	(1U << 26)
-#define NFS_CAP_COPY_NOTIFY	(1U << 27)
-#define NFS_CAP_XATTR		(1U << 28)
-#define NFS_CAP_READ_PLUS	(1U << 29)
-#define NFS_CAP_FS_LOCATIONS	(1U << 30)
-#define NFS_CAP_MOVEABLE	(1U << 31)
+#define NFS_CAP_READDIRPLUS	(1ULL << 0)
+#define NFS_CAP_HARDLINKS	(1ULL << 1)
+#define NFS_CAP_SYMLINKS	(1ULL << 2)
+#define NFS_CAP_ACLS		(1ULL << 3)
+#define NFS_CAP_ATOMIC_OPEN	(1ULL << 4)
+#define NFS_CAP_LGOPEN		(1ULL << 5)
+#define NFS_CAP_CASE_INSENSITIVE	(1ULL << 6)
+#define NFS_CAP_CASE_PRESERVING	(1ULL << 7)
+#define NFS_CAP_REBOOT_LAYOUTRETURN	(1ULL << 8)
+#define NFS_CAP_OFFLOAD_STATUS	(1ULL << 9)
+#define NFS_CAP_ZERO_RANGE	(1ULL << 10)
+#define NFS_CAP_DIR_DELEG	(1ULL << 11)
+#define NFS_CAP_OPEN_XOR	(1ULL << 12)
+#define NFS_CAP_DELEGTIME	(1ULL << 13)
+#define NFS_CAP_POSIX_LOCK	(1ULL << 14)
+#define NFS_CAP_UIDGID_NOMAP	(1ULL << 15)
+#define NFS_CAP_STATEID_NFSV41	(1ULL << 16)
+#define NFS_CAP_ATOMIC_OPEN_V1	(1ULL << 17)
+#define NFS_CAP_SECURITY_LABEL	(1ULL << 18)
+#define NFS_CAP_SEEK		(1ULL << 19)
+#define NFS_CAP_ALLOCATE	(1ULL << 20)
+#define NFS_CAP_DEALLOCATE	(1ULL << 21)
+#define NFS_CAP_LAYOUTSTATS	(1ULL << 22)
+#define NFS_CAP_CLONE		(1ULL << 23)
+#define NFS_CAP_COPY		(1ULL << 24)
+#define NFS_CAP_OFFLOAD_CANCEL	(1ULL << 25)
+#define NFS_CAP_LAYOUTERROR	(1ULL << 26)
+#define NFS_CAP_COPY_NOTIFY	(1ULL << 27)
+#define NFS_CAP_XATTR		(1ULL << 28)
+#define NFS_CAP_READ_PLUS	(1ULL << 29)
+#define NFS_CAP_FS_LOCATIONS	(1ULL << 30)
+#define NFS_CAP_MOVEABLE	(1ULL << 31)
+#define NFS_CAP_P2PDMA		(1ULL << 32)
 #endif
-- 
2.53.0.1185.g05d4b7b318-goog



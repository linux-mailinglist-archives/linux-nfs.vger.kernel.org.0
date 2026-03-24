Return-Path: <linux-nfs+bounces-20366-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO6THazKwmmIlgQAu9opvQ
	(envelope-from <linux-nfs+bounces-20366-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 18:32:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69FF31A0E2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1DB43020871
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956E408230;
	Tue, 24 Mar 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnLRgbWU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689140822B;
	Tue, 24 Mar 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373539; cv=none; b=nDv8kuO+p+uZAaUrYPeFBifvL1wSkS2lf8A0sKGvR440KFwoJKQ0NGYLBw8nichuN6Hiydt2TpF816AI0ta9liRRJUABcPJzNzqgba9PZWnEANdQDlH6JwWTsNQ0G8dOKsWXOsFOn836fmxBu+jZ8nc7woCWUH+/bp/qR0Qhm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373539; c=relaxed/simple;
	bh=KX7ezovIpRtNvZ/WETR7KgqRPNjNPl6LwdPkAvVt7wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWbcwQWHWDFCTnTLcBcrq4ZGURv7ddHYEpY9BZBVglcJgRahwUZMlxfhHkO/abtbSxXJlV75Y74PtPBMLPIKth1aHyeGEcGG4y9F319mWSTPOHBkTo3NqoaxEKWvnJVqjRehGFmD47tO7Shni8rCyC8aAb/852aDqPZ7zOi4G2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnLRgbWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF35C2BC9E;
	Tue, 24 Mar 2026 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774373539;
	bh=KX7ezovIpRtNvZ/WETR7KgqRPNjNPl6LwdPkAvVt7wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YnLRgbWUZRNThFU1myixTut9Kh6kys0BbMDwv/o6iZpKu3uPhjJd+YalcL0gJDwH/
	 JUBgBso+RQe6dVQIHCpRy43VbrA6zkdNpVmKtn1vR09MisysVVtXofJOp8G8uJevSN
	 1QjwasMbRAUovPskO1h/8zzDuJb/neGjLxr3NPznPOIyixcLNBipX0Ik1ZRmk0kDxm
	 w5ELI+oipikwiWyMLqVTMGg2ypH8B17NyMxR3a5MiPKPep7aVuFn2yY4BwvxNXm1VQ
	 PqBm4kSEfEcuFNn5mZn78edoQUSO4JWlMibfmgRLoasK21yWHNeJsgmelBlI6sN5hK
	 skv4/XALKU0NQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 24 Mar 2026 13:32:12 -0400
Subject: [PATCH v2 2/2] nfs: update inode ctime after removexattr operation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
In-Reply-To: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4210; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KX7ezovIpRtNvZ/WETR7KgqRPNjNPl6LwdPkAvVt7wk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpwsqgJQUx246016YMSNxNz8qxAQ2W8eROHx4tP
 w2m2hBNdRaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacLKoAAKCRAADmhBGVaC
 FXCqEACejOn80eOot6ONWGQRvG2PaR7MOjGUYwZG2p/LkbTkCl/gHvOQPKysorkcZJNvxC/65LE
 ee+BcHj9HNu2AVNmaDpVBbyqmLQpSyX0A5JPFv4Zqd2x3I7lUgSVQlpKyTbLT0ObtVPIR9/nyZH
 +EsG1PN3XfQkF2yLzjV2CQtG602SJwR7eoYPttZxZXzcATimYQ0al9/gQjjOsXL6Xi59e0jARFx
 5h+75uEw4ZG/PUHF4CJS3ASfYSr2IxU/R6w5yA5BfR973Cj8iNzeV+S6NkZkKjk9YjwhYl1r46S
 EamUulRHTrrvS2C65Z2OdbswGX4d+3ioIqTJzciDY0Dvmzef7o2ioYwne6N6bB0MXTyj4Q7Rwwb
 poy6aYBUh0H5RCEFywxx/s/hLi1vYLwSAZwvhF6QCRUB3EfhA8Yru49kwVneckN4m8S8UGmOQM/
 37C/O5v3NbELhfcuLQn2NCnaQacDnjvn7qFXKhTslu5OVMVZaR0kaT9mKIEJJ7ZAtBkpmJRbWFj
 Xl1R9i+yZrwRVZoQxz5k0VLXoT9IkRbADuys9G2p7Wo9ZNvgRtZhqyHq8W4uOCjfrodAMjpSE+b
 Qbdrm9sTG3+6io4waeSmkacdPhyo3qmXDUHllLKiXx+ZxXtg2MQr/I65q6BYkcarznMswMJ0ZQl
 7CyNwAzXlFaeX4g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20366-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: E69FF31A0E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfstest generic/728 fails with delegated timestamps. The client does a
removexattr and then a stat to test the ctime, which doesn't change. The
stat() doesn't trigger a GETATTR because of the delegated timestamps, so
it relies on the cached ctime, which is wrong.

The setxattr compound has a trailing GETATTR, which ensures that its
ctime gets updated. Follow the same strategy with removexattr.

Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for extended attributes")
Reported-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
 fs/nfs/nfs42xdr.c       | 10 ++++++++--
 include/linux/nfs_xdr.h |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55b3621977ac83bb98f7c20 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, struct file *dst_f,
 static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
+	__u32 bitmask[NFS_BITMASK_SZ];
 	struct nfs42_removexattrargs args = {
 		.fh = NFS_FH(inode),
+		.bitmask = bitmask,
 		.xattr_name = name,
 	};
-	struct nfs42_removexattrres res;
+	struct nfs42_removexattrres res = {
+		.server = server,
+	};
 	struct rpc_message msg = {
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR],
 		.rpc_argp = &args,
@@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct inode *inode, const char *name)
 	int ret;
 	unsigned long timestamp = jiffies;
 
+	res.fattr = nfs_alloc_fattr();
+	if (!res.fattr)
+		return -ENOMEM;
+
+	nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
+			 inode, NFS_INO_INVALID_CHANGE);
+
 	ret = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
 	    &res.seq_res, 1);
 	trace_nfs4_removexattr(inode, name, ret);
-	if (!ret)
+	if (!ret) {
 		nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
+		ret = nfs_post_op_update_inode(inode, res.fattr);
+	}
 
+	kfree(res.fattr);
 	return ret;
 }
 
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bfc60f5981396958084d627 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -263,11 +263,13 @@
 #define NFS4_enc_removexattr_sz		(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putfh_maxsz + \
-					 encode_removexattr_maxsz)
+					 encode_removexattr_maxsz + \
+					 encode_getattr_maxsz)
 #define NFS4_dec_removexattr_sz		(compound_decode_hdr_maxsz + \
 					 decode_sequence_maxsz + \
 					 decode_putfh_maxsz + \
-					 decode_removexattr_maxsz)
+					 decode_removexattr_maxsz + \
+					 decode_getattr_maxsz)
 
 /*
  * These values specify the maximum amount of data that is not
@@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc_rqst *req,
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
 	encode_removexattr(xdr, args->xattr_name, &hdr);
+	encode_getfattr(xdr, args->bitmask, &hdr);
 	encode_nops(&hdr);
 }
 
@@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rpc_rqst *req,
 		goto out;
 
 	status = decode_removexattr(xdr, &res->cinfo);
+	if (status)
+		goto out;
+	status = decode_getfattr(xdr, res->fattr, res->server);
 out:
 	return status;
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a210c8e11c20a54d6ed9dad 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
 struct nfs42_removexattrargs {
 	struct nfs4_sequence_args	seq_args;
 	struct nfs_fh			*fh;
+	const u32			*bitmask;
 	const char			*xattr_name;
 };
 
 struct nfs42_removexattrres {
 	struct nfs4_sequence_res	seq_res;
 	struct nfs4_change_info		cinfo;
+	struct nfs_fattr		*fattr;
+	const struct nfs_server		*server;
 };
 
 #endif /* CONFIG_NFS_V4_2 */

-- 
2.53.0



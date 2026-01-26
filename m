Return-Path: <linux-nfs+bounces-18498-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAJAOMzGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18498-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201A8CCF3
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B843026179
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F8288C96;
	Mon, 26 Jan 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5aIYC+p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A16288C81
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457342; cv=none; b=J4EPprlheNKI65mpTvYXwCHXfco+JFz3c/hCTFflB00SSXbnW04DSiKSeIf32BEXmRJznkg9BKlfJs7CBt3Fp79mIPrIjId9e1XlYRFCE203WZYVSSUWkqhw/GhYvjftaQpNH4v2I3yVyQ/EwEB6nDcG8REM/XN2CpMGtPRIolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457342; c=relaxed/simple;
	bh=lLGz9KKYTYeI/A2rNuJOOLBB3p8v8xrt4xCR5JMbsE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7n3lMD0+rm753ve9oBs/hqB5ajcUPY3MJcPc6HWnAWp6qvUZTfx3gphGr/Xkj7LqQLAAKVspDgzwu4Qdaq4Cqww0ps2FMIvZPkjeJiOScUu950YN3I8HvWpy81uhfuQ6jL2nFZXGXE1vyPng31AZMBSM+67BOcfKWz3o8TXcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5aIYC+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EC0C2BC86;
	Mon, 26 Jan 2026 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457342;
	bh=lLGz9KKYTYeI/A2rNuJOOLBB3p8v8xrt4xCR5JMbsE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5aIYC+pU3ZY2OMLPXGAvo2L43COa/GtuQ978pXFUmti+1Y4IlpF5yQLUP6NXS5ts
	 q4NGcoVuspo4dF7FkYtPoar9EN4VBvORJzKluaDBFH0J9NAuUoejc66fYvRSSiXrJU
	 CKBb13kXUMtzGA9Nn9b7QYZw6Z/sB6SmipFDxopmQ/RJAOcynPGNMxu6N0ggH7Lczm
	 tlpOVwIdMQpdxVCqa3MPUgjA1RUXbHbExHHQM7x4ql3QoMKlMSE8u3IhUZ0GWj9iVQ
	 sAkhifBblqnyV732gDoOW6tL7orm5LP/MvfgzsO2KjLFNGT+2S1X6tcMltLe1oF32o
	 UYthwNGKC298w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 05/14] lockd: Relocate nlmsvc_unlock API declarations
Date: Mon, 26 Jan 2026 14:55:26 -0500
Message-ID: <20260126195535.154697-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126195535.154697-1-cel@kernel.org>
References: <20260126195535.154697-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18498-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8201A8CCF3
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The nlmsvc_unlock_all_by_sb() and nlmsvc_unlock_all_by_ip()
functions are part of lockd's external API, consumed by other
kernel subsystems. Their declarations currently reside in
linux/lockd/lockd.h alongside internal implementation details,
which blurs the boundary between lockd's public interface and
its private internals.

Moving these declarations to linux/lockd/bind.h groups them
with other external API functions and makes the separation
explicit. This clarifies which functions are intended for
external use and reduces the risk of internal implementation
details leaking into the public API surface.

Build-tested with allyesconfig; no functional changes.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c            | 2 +-
 include/linux/lockd/bind.h  | 7 +++++++
 include/linux/lockd/lockd.h | 6 ------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 39d711e25bff..4d8e3c1a7be3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -11,7 +11,7 @@
 #include <linux/fs_context.h>
 
 #include <linux/sunrpc/svcsock.h>
-#include <linux/lockd/lockd.h>
+#include <linux/lockd/bind.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/gss_api.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 2f5dd9e943ee..82eca0a13ccc 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -21,6 +21,7 @@
 struct svc_rqst;
 struct rpc_task;
 struct rpc_clnt;
+struct super_block;
 
 /*
  * This is the set of functions for lockd->nfsd communication
@@ -80,4 +81,10 @@ extern int	nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, vo
 extern int	lockd_up(struct net *net, const struct cred *cred);
 extern void	lockd_down(struct net *net);
 
+/*
+ * Cluster failover support
+ */
+int nlmsvc_unlock_all_by_sb(struct super_block *sb);
+int nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
+
 #endif /* LINUX_LOCKD_BIND_H */
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 195e6ce28f6e..0d883f48ec21 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -311,12 +311,6 @@ void		  nlmsvc_mark_resources(struct net *);
 void		  nlmsvc_free_host_resources(struct nlm_host *);
 void		  nlmsvc_invalidate_all(void);
 
-/*
- * Cluster failover support
- */
-int           nlmsvc_unlock_all_by_sb(struct super_block *sb);
-int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
-
 static inline struct file *nlmsvc_file_file(const struct nlm_file *file)
 {
 	return file->f_file[O_RDONLY] ?
-- 
2.52.0



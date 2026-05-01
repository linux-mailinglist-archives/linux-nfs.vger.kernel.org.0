Return-Path: <linux-nfs+bounces-21338-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PdqO8i+9GkDEQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21338-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:55:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573D4AD69D
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD9CE305B001
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DD3CC9FF;
	Fri,  1 May 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drl23h8A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66D282F06;
	Fri,  1 May 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647098; cv=none; b=CqIHLY1iiBJ4JXG9a94NqTMPs0NLICAa5PFLDxprU9tpfs+OgP3z27ZyX3eMJdWWnAA4A8h8zAxOCon0Crdt8xs0E+mEt10SPDUId08a340KYQg2Ca4GlmP6sGLmATEOLY3tC4ISSL5F5sal565bcZP74mFVTL3w0bIdU5dzVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647098; c=relaxed/simple;
	bh=YJvX++/TOSEoCT9FDL0cK+WZPvAVTeY5+PDOETC4zak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2VtSewwXPOLBhIRoFVdZfZaWcFL8wO5xL8X9s1gNSsvxb6fBPg1jL3X+DhPo95UtPfvNyYuuKL+r5qx9HZotceJ69mxKUtPa3NaDD7wZiGbI6TVlijT7QzunbYESGEqYnYqKJPKLq+ZwkjZ8CLZZQEZ34YazQ+d2ruuxC6ivsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drl23h8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115BAC2BCB9;
	Fri,  1 May 2026 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647097;
	bh=YJvX++/TOSEoCT9FDL0cK+WZPvAVTeY5+PDOETC4zak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=drl23h8AzFIDUzQKNUZx7Ths5lkGdPNeqgkErE8ZQw1NnOgSpnYJI186avfNtQDyQ
	 NjO8kcrNtGURqSNlhyUFRcH0hocF5EeZCAPa/FOTbuPmXBUStD0+hA4xVip8ZF71Ho
	 +oU5/eCVHBfgSX2wKRQJHLIP0TyHWgDtAlPB++tK9OPOuwz6aQ7+wn1zRiRCqacSGy
	 mHQ5HF9UhlIUdoZguvfP6E1MUUgZLQ1h9XEk3QyRFI+2XsApZwUpPKXlYnDR1Xcal7
	 vEkGNSyrRu01QPJNOmmmaD68kgYd5VQ6U017jdmC+skz2z09Cc2zWw+2w/52bIiMrG
	 M9P/ImNRHtyqw==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 01 May 2026 10:51:11 -0400
Subject: [PATCH 5/6] SUNRPC: Hold cd->net for the lifetime of cache files
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-cache-uaf-fix-v1-5-a49928bf4817@oracle.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
In-Reply-To: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Yang Erkun <yangerkun@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4135;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=opUXJ8QSMXMhGvSCYmr3N2cvOEFPM22XT2C7DGYtB/Y=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9L3wXaAj328si78RqUKwzBaCg/yg+JQ6/k191
 iglg3y8RdKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafS98AAKCRAzarMzb2Z/
 l7jjD/992F7uxDk2Kd3QWuJNY4LJw8JBti1AIXNSB/dLGho6jo6c8BIC5TxB4hd04+eToW6fO2a
 cnXRk8Q79Xtz6TLg6mSSeUVhm+cDTCLdct6loyDqTnuI4J44BLSZ2nnTFQBs05hJDuX7mi4hl5o
 wWWdA4/ugNChSfeI4ZiVFkSD3sJAvSQnnUwRgsomqg9HoUI2F/3UdLn2rlPApwM6VY10WJdYaue
 WRs4vD1bZu9rL/A1Y0Qo5eA7vbLIo9riBRLvPZ84JsuTJ4rjFy9Nnd1tz+hXI6rhwsOnb8pivWh
 Mf3z3EqEyKfdpP/74vnxOEsr9s7WoqBOQbg914SKeF3MqGEN5OdtrGHVuwHcQRANXxpg3vRyzZl
 BJLmGrz9XerGLo0PN/t97T0AYwR7RdGhhu7rmZRNcNn+B6XY8ZIwQh3zizU1z0jR40sTvFu4deP
 evZjsl/nXOiqtk5gE5NTgB95mb/blZ2v8WFURmxzJDjKdgHY3u1g1l4lZebb9VimEVBkRf7yu4d
 YPo9GEqToanxfz6fqlGQgCWrjibbbyJA8qgi+27TKOswexhbadaKC7vtowiyrBhlXpTSybjtBDl
 P9Kj/4bZqmUtiefwjpDggchDOuok0Nq9ITwzsLjzINtXhvDN12JmvSzaFX9UPHESN0id1naxFS6
 oWCVgXqRiT4gtZQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 8573D4AD69D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21338-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Each per-net sunrpc cache exposes three files under
/proc/net/rpc/<cachename>/: content, channel, and flush.
Their open helpers (content_open, cache_open, open_flush) take a
reference on cd->owner via try_module_get() but no reference on
cd->net. When the network namespace exits, cache_unregister_net()
followed by cache_destroy_net() free cd->hash_table and cd
synchronously without RCU deferral. Any subsequent operation on
the still-open file dereferences the freed cache_detail.

The fault produced by sosreport on aarch64 and ppc64le shows the
typical signature: cache_check_rcu() faults reading h->flags off
a garbage cache_head pointer that came from __cache_seq_start()
walking a freed cd->hash_table. Commit e7fcf179b82d ("NFSD: Hold
net reference for the lifetime of /proc/fs/nfs/exports fd") closed
this hole only for the /proc/fs/nfs/exports file, which has its own
open path; the sunrpc cache files were left exposed.

Take a get_net(cd->net) in content_open(), cache_open(), and
open_flush() once the open has otherwise succeeded, and a matching
put_net() at the tail of each release helper. Holding the net
reference for the open file lifetime prevents the namespace from
exiting while a cache fd is open, which in turn prevents
cache_destroy_net() from running and freeing cd from under the
reader.

put_net() can drop the last namespace reference, in which case
__put_net() queues net_cleanup_work on netns_wq. That work runs
ops_undo_list() on another CPU, which invokes sunrpc_exit_net()
and frees cd via cache_destroy_net(). The release helper must
not dereference cd after put_net(): cache_release(),
content_release(), and release_flush() therefore capture
cd->owner and cd->net into local variables before calling
put_net(net) and module_put(owner).

Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Closes: https://lore.kernel.org/linux-nfs/8cf80f450085ac17164e8fa1391e9635@linux.ibm.com/
Fixes: 1b10f0b603c0 ("SUNRPC: no need get cache ref when protected by rcu")
Assisted-by: Claude:claude-opus-4-7[1m]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/cache.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 733bcd3daa46..be7a0c8c416e 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1037,6 +1037,7 @@ static int cache_open(struct inode *inode, struct file *filp,
 	if (filp->f_mode & FMODE_WRITE)
 		atomic_inc(&cd->writers);
 	filp->private_data = rp;
+	get_net(cd->net);
 	return 0;
 }
 
@@ -1044,6 +1045,8 @@ static int cache_release(struct inode *inode, struct file *filp,
 			 struct cache_detail *cd)
 {
 	struct cache_reader *rp = filp->private_data;
+	struct module *owner;
+	struct net *net;
 
 	if (rp) {
 		struct cache_request *rq = NULL;
@@ -1080,7 +1083,10 @@ static int cache_release(struct inode *inode, struct file *filp,
 		atomic_dec(&cd->writers);
 		cd->last_close = seconds_since_boot();
 	}
-	module_put(cd->owner);
+	owner = cd->owner;
+	net = cd->net;
+	put_net(net);
+	module_put(owner);
 	return 0;
 }
 
@@ -1466,14 +1472,19 @@ static int content_open(struct inode *inode, struct file *file,
 
 	seq = file->private_data;
 	seq->private = cd;
+	get_net(cd->net);
 	return 0;
 }
 
 static int content_release(struct inode *inode, struct file *file,
 		struct cache_detail *cd)
 {
+	struct module *owner = cd->owner;
+	struct net *net = cd->net;
 	int ret = seq_release(inode, file);
-	module_put(cd->owner);
+
+	put_net(net);
+	module_put(owner);
 	return ret;
 }
 
@@ -1482,13 +1493,18 @@ static int open_flush(struct inode *inode, struct file *file,
 {
 	if (!cd || !try_module_get(cd->owner))
 		return -EACCES;
+	get_net(cd->net);
 	return nonseekable_open(inode, file);
 }
 
 static int release_flush(struct inode *inode, struct file *file,
 			struct cache_detail *cd)
 {
-	module_put(cd->owner);
+	struct module *owner = cd->owner;
+	struct net *net = cd->net;
+
+	put_net(net);
+	module_put(owner);
 	return 0;
 }
 

-- 
2.53.0



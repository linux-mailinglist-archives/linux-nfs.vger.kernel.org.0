Return-Path: <linux-nfs+bounces-18874-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDA1Lzjyi2lXdwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18874-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 04:06:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F023120D9A
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 04:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47B253013D66
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Feb 2026 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A40E3358A3;
	Wed, 11 Feb 2026 03:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="QLdJZrdx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497E2ECE9D
	for <linux-nfs@vger.kernel.org>; Wed, 11 Feb 2026 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770779167; cv=none; b=CIs0vIIrQ0+UZ52M9ZYbsefydXpOEn7iP6swKLtkO7V/5QF9zHqbxnNs6qXhfscQBKrhyK973HnquWpt/V5mvZBsL5/ud2X0p2vO7C893pS8rZT6Zezg6mB1yYx9sXGJlCBsi9eX0Ht+vwl/zVk/1KPw7DalO57T1IqDkyX10V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770779167; c=relaxed/simple;
	bh=npc2dbBOGo7Aif7S5+nDohPa5CRcvAM4noA1HV94vxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrQ0JX5/sXhhOyh8bFm0eJlOoeLSGXQvzGvjjzcJKzlgTaq34t1TICcKmbhgtSWC+qCU3FCJjcOzZUdlalfc55iS09C3lgfjoLVfXyHYdOcoqzzIsB+SnQIrqVjgBiPjr6gHZq8PfiK/vxdFqooVEpA1bGqWWtEu3uxiOzbMm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=QLdJZrdx; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1770779164;
	bh=cEK/QkXNtxabPBN96UfAuh6tuWmLKbXJW7876CwA5zw=;
	h=From:Subject:Date:Message-Id;
	b=QLdJZrdxF4OfpdjSypN1n9RQr5eooXi1tvyAo8O6FtLwwEJrdd8GIeBXySMpZAw9q
	 9p2JebEpBmWyR+xYZO+9jnCn99clqmKJxUeuMzANTox4nJcViecsr0Cztg7ZMKGpM5
	 DIRNpT0Y6fYROQV/Hjqyn3dFdX+ssgpLefRj5eTk=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.21) with ESMTP
	id 698BF1F200002A1A; Wed, 11 Feb 2026 11:05:24 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 6981733408340
X-SMAIL-UIID: 20AF8401DD9D4EF6ADD6BCF3D67D7D2A-20260211-110524-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	jlayton@kernel.org
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 6.6.y] nfsd: don't ignore the return code of svc_proc_register()
Date: Wed, 11 Feb 2026 11:05:22 +0800
Message-Id: <20260211030522.2697146-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18874-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[sina.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[sina.cn];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,sina.cn:mid,sina.cn:dkim,sina.cn:email,oracle.com:email]
X-Rspamd-Queue-Id: 0F023120D9A
X-Rspamd-Action: no action

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 930b64ca0c511521f0abdd1d57ce52b2a6e3476b ]

Currently, nfsd_proc_stat_init() ignores the return value of
svc_proc_register(). If the procfile creation fails, then the kernel
will WARN when it tries to remove the entry later.

Fix nfsd_proc_stat_init() to return the same type of pointer as
svc_proc_register(), and fix up nfsd_net_init() to check that and fail
the nfsd_net construction if it occurs.

svc_proc_register() can fail if the dentry can't be allocated, or if an
identical dentry already exists. The second case is pretty unlikely in
the nfsd_net construction codepath, so if this happens, return -ENOMEM.

Reported-by: syzbot+e34ad04f27991521104c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-nfs/67a47501.050a0220.19061f.05f9.GAE@google.com/
Cc: stable@vger.kernel.org # v6.9
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ Update the cleanup path to use nfsd_stat_counters_destroy. This ensures
 the teardown logic is correctly paired with nfsd_stat_counters_init, as
 required by the current NFSD implementation.]
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 fs/nfsd/nfsctl.c | 9 ++++++++-
 fs/nfsd/stats.c  | 4 ++--
 fs/nfsd/stats.h  | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 78ebdf20c1ef..4703e2a93568 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1526,17 +1526,24 @@ static __net_init int nfsd_net_init(struct net *net)
 	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_program;
+	if (!nfsd_proc_stat_init(net)) {
+		retval = -ENOMEM;
+		goto out_proc_error;
+	}
+
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
-	nfsd_proc_stat_init(net);
 
 	return 0;
 
+out_proc_error:
+	nfsd_stat_counters_destroy(nn);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
 out_idmap_error:
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 9f606fa08bd4..0a629a18831f 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -115,11 +115,11 @@ void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-void nfsd_proc_stat_init(struct net *net)
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
+	return svc_proc_register(net, &nn->nfsd_svcstats, &nfsd_proc_ops);
 }
 
 void nfsd_proc_stat_shutdown(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index d2753e975dfd..b1f7d21cbcd1 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -15,7 +15,7 @@ void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
 int nfsd_stat_counters_init(struct nfsd_net *nn);
 void nfsd_stat_counters_destroy(struct nfsd_net *nn);
-void nfsd_proc_stat_init(struct net *net);
+struct proc_dir_entry *nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
-- 
2.34.1



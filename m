Return-Path: <linux-nfs+bounces-22109-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEZhBSxHG2qwAgkAu9opvQ
	(envelope-from <linux-nfs+bounces-22109-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:23:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39B613345
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 22:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8A2301FF8C
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 20:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B7329C6B;
	Sat, 30 May 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSHt7gan"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4F2594B9
	for <linux-nfs@vger.kernel.org>; Sat, 30 May 2026 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780172481; cv=none; b=ODELBRhG4r+ssvVpr/Ub5Wxpia0+LiZb/7T5iqZDuGzt3fAwMb1N26Iy1gMlaCx9E7qHetIblMEhaUGkNBlJXBfteFzZ7IDAmHoeVqdz4Us1j0+pHi5aBWNMw30bxGB2ExkLrVLCT/P4t4dgc7AVmIyYAr5dyP809Pq6nsbsJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780172481; c=relaxed/simple;
	bh=pS7lRWJEi8WwXysZHxVWf2sQXmw23Qq8sKR8bJGZgZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpF3BUuQCGamspJ990UlLr4pipkrbgYTBxvsqy7R8yvMYk3uUCWcBiIzibALgHjuTuRGIaG78VuAWxlKQSw02h7xVRnv2g1teKmIPinewooWQp/OFF9cAT+sE0yg4rqGFZZVhQv2DR9jtrT/3H9EnwAjNyF1I2kc+So5tqXSiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSHt7gan; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17F41F00899;
	Sat, 30 May 2026 20:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780172480;
	bh=z+ieNsbydErYIGEijCcKOD4Bam6UxULwvLX9YJQdx5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eSHt7ganrCQkvba0HWOUHDI6Qyv0gKiav58b475WGI72ZW/cS7kRihcCdiPIDeFU3
	 0Zvb1KLWteyE2E0+KgwMJ2y6JLXei/vcVQrIaf06HQqKJMwFpoxlD8cVe4A7ETvY9n
	 GGqYHHXKilV0RN0rfIBc4cC0MqVLzROSWrnbmTYvHiEYgF7DwqUy/Y6WFgHBTdTW3p
	 Bx1kJepkL3cvi4oXDWGNZx6Nn0O5e20KN60y6XaJ++zMOorbg9FX9ZDS8iMbArnBGo
	 oiLseOa87tQkgSV9toCutY7QCzNxiyYDSahl+Jk/G5MKBfPs62tQTZ22QyrAs6+eBj
	 /p3CIzes2J3iw==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 30 May 2026 16:21:07 -0400
Subject: [PATCH 1/2] sunrpc: init gssp_lock before publishing proc entry
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-tier2-local-v1-1-fc294d34848a@oracle.com>
References: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
In-Reply-To: <20260530-tier2-local-v1-0-fc294d34848a@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chris Mason <clm@meta.com>, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4613;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=roPRkjRs1A3RS0Av+N7SgIzMZnRfYdANDpYWH/w55IU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqG0a+fTJy877fanVhtG28035fOuLz0iKNgVChX
 46Jwo9d3jqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahtGvgAKCRAzarMzb2Z/
 lyKRD/4nG3aw9TtxNbXeMsE0WOcsjNjRG6nC0gX6jIiO4a+yx9x8yxIpkx5VQBk5eP0L/0hdjNs
 0eC7qDJfT3/dogRJM8AG44WyXfCfbDpfnfSnH/t1Myf2lbaLoaxO+/wcJKlfFxwkExOVGxrYRXG
 KqT7p1Lby+CMCfHBRmHd8McnYghdGv+PBqR2CWW+Kcfw3NiwiC41MuOOVm5DiWG7AiQmPvnZzdR
 tFfLLA7tGUSUmLkE4UP+yj/D3QDaCWataaJssEjFB3PSYP1BaKeRFcPOMbkF2Edt3yXwsgqKw5M
 OfvsIb1HlCwa989In5HFDgEMOAQf8N/gyLX+11lJuc/ZfvlLNZDavpHfbk9FwQVdtBoe7but8Wc
 h6H3ibz4O1ZvZF0cPLw7kbS5P480t6K9EkFoL3P4LEvqOVv7BMfpO4A3vlVYcMGgqajNy3PlfnR
 sCXp8aUe6MN4l7P9pPDenNG0Y3tWbUXSE8zxP1jpGFn3BTKL9uv7wi9Wpv/Zx9kglO6F2+5Gkgm
 TguKeLl9tTIg1CArlHE6G5cP7WdVIOeoBGmqzeREu/5LS3xJSp0QK8AUYyUi33p+0j3U3vT9Jux
 qZnvSRQu9t+0zL9txCgCe4Hena80tLpzlbTqFtCEbq2t0/9RLA99kuSU74ZoeQ+w20ja0HRYtxl
 wm3kXpMoi1VgIDg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22109-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,oracle.com:mid,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A39B613345
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

create_use_gss_proxy_proc_entry() publishes /proc/net/rpc/use-gss-proxy
via proc_create_data() before init_gssp_clnt() runs mutex_init() on
sn->gssp_lock.  Once the dentry is linked under proc_subdir_lock it is
immediately reachable from userspace, so a write that lands in the
window drives set_gssp_clnt() into mutex_lock() on a zero-initialized
struct mutex.

    create_use_gss_proxy_proc_entry(net)
      proc_create_data("use-gss-proxy", ...)   /* dentry live */
      init_gssp_clnt(sn)
        mutex_init(&sn->gssp_lock)             /* too late */

    write_gssp()
      set_gssp_clnt(net)
        mutex_lock(&sn->gssp_lock)             /* uninitialized */
        gssp_rpc_create(...)
        sn->gssp_clnt = clnt
        mutex_unlock(&sn->gssp_lock)

The window spans only the two statements between proc_create_data()
returning and init_gssp_clnt(), so a writer reaches it only if the
registering thread is preempted there while another task is already
opening the freshly published file.  register_pernet_subsys() runs in
preemptible context under pernet_ops_rwsem, so that preemption is
possible, and the window widens on auth_rpcgss module load, when the
proc entry is created for every live net namespace whose tasks are
already running.  A writer that wins the race locks a zero-filled
struct mutex.  On CONFIG_DEBUG_MUTEXES the missing magic value trips a
"lock used without init" splat; on a production kernel the fast path
acquires the lock via CMPXCHG(owner, 0, current).  In the latter case
a second writer that arrives before init_gssp_clnt() re-zeroes owner
can enter set_gssp_clnt() concurrently, shut down the first writer's
clnt while it is still in use, and leak the loser's clnt.

Fix by initializing sn->gssp_lock in sunrpc_init_net() so its lifetime
matches the sunrpc_net it lives in.  sn->gssp_clnt is already NULL from
the kzalloc that backs net_generic storage, so the lazy helper is no
longer needed; drop init_gssp_clnt(), its prototype, and the call from
create_use_gss_proxy_proc_entry().  sunrpc.ko is a build-time
dependency of auth_rpcgss.ko, so sunrpc_init_net() has always run on
every netns before any auth_gss pernet init can publish the proc
entry.

Fixes: 030d794bf498 ("SUNRPC: Use gssproxy upcall for server RPCGSS authentication.")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_rpc_upcall.c | 6 ------
 net/sunrpc/auth_gss/gss_rpc_upcall.h | 1 -
 net/sunrpc/auth_gss/svcauth_gss.c    | 1 -
 net/sunrpc/sunrpc_syms.c             | 1 +
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.c b/net/sunrpc/auth_gss/gss_rpc_upcall.c
index 0fa4778620d9..b7f70b1adb18 100644
--- a/net/sunrpc/auth_gss/gss_rpc_upcall.c
+++ b/net/sunrpc/auth_gss/gss_rpc_upcall.c
@@ -121,12 +121,6 @@ static int gssp_rpc_create(struct net *net, struct rpc_clnt **_clnt)
 	return result;
 }
 
-void init_gssp_clnt(struct sunrpc_net *sn)
-{
-	mutex_init(&sn->gssp_lock);
-	sn->gssp_clnt = NULL;
-}
-
 int set_gssp_clnt(struct net *net)
 {
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
diff --git a/net/sunrpc/auth_gss/gss_rpc_upcall.h b/net/sunrpc/auth_gss/gss_rpc_upcall.h
index 31e96344167e..b3c2b2b90798 100644
--- a/net/sunrpc/auth_gss/gss_rpc_upcall.h
+++ b/net/sunrpc/auth_gss/gss_rpc_upcall.h
@@ -29,7 +29,6 @@ int gssp_accept_sec_context_upcall(struct net *net,
 				struct gssp_upcall_data *data);
 void gssp_free_upcall_data(struct gssp_upcall_data *data);
 
-void init_gssp_clnt(struct sunrpc_net *);
 int set_gssp_clnt(struct net *);
 void clear_gssp_clnt(struct sunrpc_net *);
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 8e8aceb31270..f112f5814f7e 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1468,7 +1468,6 @@ static int create_use_gss_proxy_proc_entry(struct net *net)
 			      &use_gss_proxy_proc_ops, net);
 	if (!*p)
 		return -ENOMEM;
-	init_gssp_clnt(sn);
 	return 0;
 }
 
diff --git a/net/sunrpc/sunrpc_syms.c b/net/sunrpc/sunrpc_syms.c
index ab88ce46afb5..1a3884a0376a 100644
--- a/net/sunrpc/sunrpc_syms.c
+++ b/net/sunrpc/sunrpc_syms.c
@@ -57,6 +57,7 @@ static __net_init int sunrpc_init_net(struct net *net)
 	INIT_LIST_HEAD(&sn->all_clients);
 	spin_lock_init(&sn->rpc_client_lock);
 	spin_lock_init(&sn->rpcb_clnt_lock);
+	mutex_init(&sn->gssp_lock);
 	return 0;
 
 err_pipefs:

-- 
2.54.0



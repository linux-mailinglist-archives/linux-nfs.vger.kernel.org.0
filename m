Return-Path: <linux-nfs+bounces-21337-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHLBOXC+9GkDEQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21337-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:53:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDEA4AD677
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295AF3042247
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F43CEB90;
	Fri,  1 May 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQrZlQz5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB33CD8B5;
	Fri,  1 May 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647096; cv=none; b=EZAV+b/62dTcd+GaPq+pcBDJ3/tU2mRTEfS5tTT85LxsiHHe2Hxy1ig8uka3MpWzXPJeE06BCaS/TALj2RXMzyk9P+PM6ydTHfiBv8EW9uXPPGO691EHHO0iFTMBYlEI/2DvlheBc5tZgO4GGqudORb2VDmypG4PSgsLP+iWRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647096; c=relaxed/simple;
	bh=bbS7Hvj+elJ6Hlp+4O+j+mJOOr6RrqQNSeYM+ZJAdAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ap21FN+i3wbJvw+dWaWiGRSFLRkl0yiNu8PxT/Hrfcs1nmhKxoD7D9YDDKScFr2/K8xHFX2MdEcpVsX+d02OL3qxFIcOZEgxhoV0IFeW64jMnod5lso9UFlMYJnLoM314Eq/ofeaorkv761Blk4yv28l7C1b7oKDnyvp8sqR4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQrZlQz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9539FC2BCB4;
	Fri,  1 May 2026 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647095;
	bh=bbS7Hvj+elJ6Hlp+4O+j+mJOOr6RrqQNSeYM+ZJAdAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQrZlQz5oH9xjNJyRcDws+4dv52mk60v30I5mNT1LcHhkH1T9qDL3oKCcRjJJ4fKX
	 JzB319WSWosRPNq7nS+NAWmsGk2QJQO/wZcGaZcygtN9VWdVNvtPJASu0OFZrR8ksI
	 MYT0CcD4WryIXU3o/wzCSniFs6DxjB2D+7R8Gedb0swRtKaIm/Stce4yONbE0xfL4O
	 ovUvtNa05xodOJDIikzy0n8O6JSxaHYon/ltGiRCAIce1WRRrSI4COiMSa/bAFIPY2
	 ryDPaEZcy1SHnaYBUss1mHC3YFUgnOfSw2JgqaPs5G+Zfb7s5sr6y3wkR7G6Jue/HM
	 q++0c8MnZyw2A==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 01 May 2026 10:51:10 -0400
Subject: [PATCH 4/6] SUNRPC: Use shared release pattern for the unix_gid
 cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-cache-uaf-fix-v1-4-a49928bf4817@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=6LhmQM+mCkrBZotHwoovj5QO/zCfh6oXMp4HfVQlhB0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9L3wnpS9Sx2etwsOFk5FodhOGOzvbtWDXfHH0
 VqmEJfiTn+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafS98AAKCRAzarMzb2Z/
 lwqRD/0YHnEn1hyeqXT1SlJa4XrFOGh0UQwjgRESQRdbU0mjwaqlFtfTWkHyLm9jkeCVUflrvG/
 JIQS6Ylf+F4me2zB3/WM3uMfGksr7o6jNor7ScUx3VibcWez638VkhA8CBpUqboXCkuJJarPGEq
 tFBU5FXPiwAi0Pp09f8M3K28S/pt9dqxuHuDEvZbRUzMsy+twZDvDXsesam5J2n1ROc+E/fNc8k
 FcS/sg40/As8jFgEaLACjlEgKt0piMNwPuwyvqykkZ52PxjNz6Um6niqeqGqx89wnMJz4R0R2+K
 45M4REhXQt1wWfGERFhByPDXHvxUiG7KFk9xILZC+bw1Lyr5/swCMeWKTLrhmms5eMM8VSYnSfd
 Kz0vVQI5ZHhXP3kSOO9w1FOZVWC6qYPT2auqQdaDSt+HySeXUIOgL+VrmuvTq7PAylKjUGpCut+
 aCxwXOr6AlRZyY+DwFT8nTAYZrlmy7KmU/qRgyEtmb26CtWI6CJnTbzYO7gwdzRCFrv43zAdJsN
 CKnuQxUTrhjdYsU7W7kvLSKHlK7aYpBNdRIHe14rJ8dIVYDL0LPvgtouOiTZ0EGt9fFRJH1jkWc
 Uj0w+05VsfBGSkVzKBai7cBLuEK5eLli4Sd5UPxK2mfhHDKMGJ95DymMEKJmFUtfJ9Makve/VKp
 ++mRijnbbPwe3GA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 8BDEA4AD677
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
	TAGGED_FROM(0.00)[bounces-21337-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

unix_gid_put() is already correct in that put_group_info() runs
inside its call_rcu() callback, after the RCU grace period.
This patch is a consistency change rather than a bug fix:
the three other cache_detail .put callbacks (svc_export,
svc_expkey, ip_map) now use the queue_rcu_work() pattern via
sunrpc_cache_queue_release(), and routing unix_gid through the same
path keeps a single release mechanism for all four caches.

Replace the rcu_head field with an rcu_work, rename
unix_gid_free() to unix_gid_release() and convert it to take
a work_struct, and have unix_gid_put() invoke INIT_RCU_WORK()
and sunrpc_cache_queue_release() in place of call_rcu().
Switch unix_gid_cache_destroy() to sunrpc_cache_destroy_net()
so per-namespace teardown waits for outstanding release work
before freeing the cache_detail.

Assisted-by: Claude:claude-opus-4-7[1m]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcauth_unix.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 14688813c242..762cf03574b4 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -420,7 +420,7 @@ struct unix_gid {
 	struct cache_head	h;
 	kuid_t			uid;
 	struct group_info	*gi;
-	struct rcu_head		rcu;
+	struct rcu_work		rwork;
 };
 
 static int unix_gid_hash(kuid_t uid)
@@ -428,23 +428,23 @@ static int unix_gid_hash(kuid_t uid)
 	return hash_long(from_kuid(&init_user_ns, uid), GID_HASHBITS);
 }
 
-static void unix_gid_free(struct rcu_head *rcu)
+static void unix_gid_release(struct work_struct *work)
 {
-	struct unix_gid *ug = container_of(rcu, struct unix_gid, rcu);
-	struct cache_head *item = &ug->h;
+	struct unix_gid *ug = container_of(to_rcu_work(work),
+					   struct unix_gid, rwork);
 
-	if (test_bit(CACHE_VALID, &item->flags) &&
-	    !test_bit(CACHE_NEGATIVE, &item->flags))
+	if (test_bit(CACHE_VALID, &ug->h.flags) &&
+	    !test_bit(CACHE_NEGATIVE, &ug->h.flags))
 		put_group_info(ug->gi);
 	kfree(ug);
 }
 
 static void unix_gid_put(struct kref *kref)
 {
-	struct cache_head *item = container_of(kref, struct cache_head, ref);
-	struct unix_gid *ug = container_of(item, struct unix_gid, h);
+	struct unix_gid *ug = container_of(kref, struct unix_gid, h.ref);
 
-	call_rcu(&ug->rcu, unix_gid_free);
+	INIT_RCU_WORK(&ug->rwork, unix_gid_release);
+	sunrpc_cache_queue_release(&ug->rwork);
 }
 
 static int unix_gid_match(struct cache_head *corig, struct cache_head *cnew)
@@ -899,8 +899,7 @@ void unix_gid_cache_destroy(struct net *net)
 
 	sn->unix_gid_cache = NULL;
 	cache_purge(cd);
-	cache_unregister_net(cd, net);
-	cache_destroy_net(cd, net);
+	sunrpc_cache_destroy_net(cd, net);
 }
 
 static struct unix_gid *unix_gid_lookup(struct cache_detail *cd, kuid_t uid)

-- 
2.53.0



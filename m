Return-Path: <linux-nfs+bounces-21336-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEhqDHC+9GkDEQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21336-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:53:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CFF4AD670
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E2E3041AA8
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502493CEB87;
	Fri,  1 May 2026 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDa2/pg8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2A3CCFB0;
	Fri,  1 May 2026 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647096; cv=none; b=oNygRyy0EPATEFZ5X4jmyl61PeW0sNGnQf9yaPiqs14myBKO3bH+KK3xd2bg4OQhKyZpYElGlirqyDyypYY4JdYs0hJHd/8EFhWPGC12/h0uA9OssFk8AqEv3G29wa4N4EZgp9/uZPpMr+xcSQHvz2P7Is0a7lwJGK/abA2Dp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647096; c=relaxed/simple;
	bh=uTVfM0ocfHbzm/p/1pxNJ122SwRDL801DcpPT5VWWkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MR4rpQYwqA0NH1+zSQjhjTnCd+j/vMB4Jh3RXO5iBWb79yLVAU7dcvRVQgf/WDXrcaP7p0096F8D6Y0zEX7m/3En0vT5vh7ye//mp5yu7+kC5snN59+XiISn+aBjnNo+02cwMxqIb5iWbkV6d3rXeyzyqclanyvNos6pt3msNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDa2/pg8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B074C4AF09;
	Fri,  1 May 2026 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647094;
	bh=uTVfM0ocfHbzm/p/1pxNJ122SwRDL801DcpPT5VWWkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SDa2/pg8+4c1D7pAoHN1Vv4Hz1SrYnzeKbyBZpQiZDALKDVMwE1vCy8XJBmO2E+8b
	 znemji3tK7t/gXY7f2XhDcYPcff3f0yXZDcQYKcyvYbRBljfpqykRUHOy6bYVYkOTL
	 0bu3ppiDoUHtT9yaXLFwswoWlcI35fzf9iBgoNnHXBQ95emctOu5H/AaCf0MB/B+E/
	 jXrpo4f6H/dy7CYlXRGaUhU1XJ9oekPkDNm56AtvqE2GBBPLjWIB0mzjVf1WgxiOMG
	 UkKPoFSOHJBmKv0BKMdEsUqrfwiRxfKAAqd6CP+dQRI6tDK/xxt7iKbopbNp2dJOmu
	 1RnPmSx7td9zw==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 01 May 2026 10:51:09 -0400
Subject: [PATCH 3/6] SUNRPC: Defer ip_map sub-object cleanup past RCU grace
 period
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-cache-uaf-fix-v1-3-a49928bf4817@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3103;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=sb+xxxOHmR0sxCWTQowT0Yl00Gq2aGRg+yOkr62nVJc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9L3wdukcWshwWSO7EzcyK2oM5/K93QyrjUPOb
 Xfp/eUVPxuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafS98AAKCRAzarMzb2Z/
 l6hvEAC5AidwWZ/9SzSuZgP8+2rI4OLcfjHaUQQDBvZdN7bG2OpriCMWAO0/N/nmmDmv2PO8khU
 FyYmbj5EEmVTZKRQ5fjDXGRQpb+EkHlxadiy1EqTuDpiwRV16rzZ9Nsmc31IM9oA0jzRKb3V80n
 3861q6cmj2DtGZseLe9ttCQbHIx8/Nkqvuf45b0KA9v5qOZzCiyNnDy6DOTcUfu7523NxE6bIvp
 xQXC/UBbBKD5OracJHoKux0bY5Vqyu1PaT2beZmmMqXZL4M53JWgZ6sKz+eiIlGpEWeNphkop77
 yKRR2f6WRoECdFJgKCQ7Bd7UKHC1+uYQccveJ0qQqrToMQHIEsWMlid4RgWg0STTTpqs55B/77o
 3Yyk4Etgswm+3mYXKc/3Hy2bON1HcjL9yGSw+WS9+e/GqCdy1OxreF/3d68DNFT58DCT76ghMoF
 9G0jB/tNkvOXh8OxNonjZxFOwbnNtbvGXoma9LZ37v9yqKrgepsTd8qSYe/kWFZ6wktCYSTxHAk
 Sl4JQk5FS/LB40D4Uuct2R8LV0chtQOdsJNTE9FQ6gKKcTiL5XajVPnDN5lff7+TeR8/uM9nRMb
 LWLPKpX90UHEC3Y1yO/tkKEO/ypUu3rZZD/r+2I/RMgv5SVD6JoiAwn3D7iC8taJH1RAJGQ1BJJ
 lhWXhIfEn/Zj5xg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 81CFF4AD670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21336-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

ip_map_put() is already correct in that auth_domain_put() of
im->m_client reaches svcauth_unix_domain_release(), which defers
the actual kfree() of the unix_domain with call_rcu(); the ip_map
itself is freed via kfree_rcu(). Readers in c_show() under
cache_seq_start_rcu() therefore observe both objects until the
next RCU grace period.

This patch is a consistency change rather than a bug fix. The
svc_export and svc_expkey caches were converted to the
queue_rcu_work() pattern in commit 48db892356d6 ("NFSD: Defer
sub-object cleanup in export put callbacks") because path_put()
and auth_domain_put() must run in process context after the RCU
grace period. The next patch routes unix_gid through the same
mechanism. Sending ip_map through sunrpc_cache_queue_release()
unifies all four cache_detail .put callbacks on a single release
path and removes the implicit reliance on every current and
future auth_ops .domain_release implementation deferring its own
kfree() behind call_rcu().

Replace the rcu_head field with an rcu_work, move the kfree() and
auth_domain_put() into a new ip_map_release() taking a
work_struct, and have ip_map_put() invoke INIT_RCU_WORK() and
sunrpc_cache_queue_release() in place of kfree_rcu(). Switch
ip_map_cache_destroy() to sunrpc_cache_destroy_net() so
per-namespace teardown waits for outstanding release work
before freeing the cache_detail.

Assisted-by: Claude:claude-opus-4-7[1m]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcauth_unix.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 64a2658faddb..14688813c242 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -103,18 +103,26 @@ struct ip_map {
 	char			m_class[8]; /* e.g. "nfsd" */
 	struct in6_addr		m_addr;
 	struct unix_domain	*m_client;
-	struct rcu_head		m_rcu;
+	struct rcu_work		m_rwork;
 };
 
+static void ip_map_release(struct work_struct *work)
+{
+	struct ip_map *im = container_of(to_rcu_work(work),
+					 struct ip_map, m_rwork);
+
+	if (test_bit(CACHE_VALID, &im->h.flags) &&
+	    !test_bit(CACHE_NEGATIVE, &im->h.flags))
+		auth_domain_put(&im->m_client->h);
+	kfree(im);
+}
+
 static void ip_map_put(struct kref *kref)
 {
-	struct cache_head *item = container_of(kref, struct cache_head, ref);
-	struct ip_map *im = container_of(item, struct ip_map,h);
+	struct ip_map *im = container_of(kref, struct ip_map, h.ref);
 
-	if (test_bit(CACHE_VALID, &item->flags) &&
-	    !test_bit(CACHE_NEGATIVE, &item->flags))
-		auth_domain_put(&im->m_client->h);
-	kfree_rcu(im, m_rcu);
+	INIT_RCU_WORK(&im->m_rwork, ip_map_release);
+	sunrpc_cache_queue_release(&im->m_rwork);
 }
 
 static inline int hash_ip6(const struct in6_addr *ip)
@@ -1569,6 +1577,5 @@ void ip_map_cache_destroy(struct net *net)
 
 	sn->ip_map_cache = NULL;
 	cache_purge(cd);
-	cache_unregister_net(cd, net);
-	cache_destroy_net(cd, net);
+	sunrpc_cache_destroy_net(cd, net);
 }

-- 
2.53.0



Return-Path: <linux-nfs+bounces-22912-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q8tJMSVyRWqwAQsAu9opvQ
	(envelope-from <linux-nfs+bounces-22912-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:01:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 436186F13A5
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 22:01:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="XK/K9yfH";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22912-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22912-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD4BE30C3A37
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1893815E3;
	Wed,  1 Jul 2026 19:57:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ABC3B2FCC;
	Wed,  1 Jul 2026 19:57:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935836; cv=none; b=RKZzvlBADUr0HSn5bZsHm0gE+VGdMpSaMVi5HRf48P7ryYtnJuL0P5RUYaz21fwwkKLOaE4doN5So76HfcnEuwJ1RKZyWmOYmGDn2/2+ZghB/mpnBNnSKzQJqc5RuxQLNoCGH+0/G84hReptCWJcksBUh5EXVr8Dq4yMM6ZCnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935836; c=relaxed/simple;
	bh=S98u0vURVTChn+wbGWAytnSStuKzPkQucWZNMJ+E7fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWHX0N8dDpIORshJzK9sXdxfdOKRsUfSJ7Uk6Sg6Bo2benDn1VPNAksDK89T0cjALkFLWls9+j03AUJUVRvEPPX5jbJTnKaXa4m1gZhFmwbvJyBqCmvGmsYaj+Lk0Hr9PbJGu+AIdkDY3jgHwElDO/to1LbKdBIO16ZhhTGpwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK/K9yfH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAAC1F00A3A;
	Wed,  1 Jul 2026 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935834;
	bh=/yQvWbSx6QEA4rcU3qAjBq7l/V/wwH8QLrEk3gSnX1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XK/K9yfHBINc534ZvExWMcxMVLLZScMLVz+eZ6JjVfEnYFM6CrZQCfpbWXvfj/Rtm
	 ua+8CBWFqEnYDl6hOpNi5RbcCYh1EiUDA/vx/r/w8oa4KsOG0jY80eRQPk9F7bbEIg
	 TB4u7a3YRlR+6KJh34GIl27VZkA1HvbNsQ8OrqyoDz2EDdoqw96E85TQSLtFKVGw0X
	 2PqyyUeM/p3gzUHYnrmPkxF7/PKfIEiJDP5sbOfNg3bY8cywYNRwjk7pR2wbNHIvHp
	 W58KiBJd62/mZfEpThPBhrOvEHQi5NFvcWjZA+FnNbW/ZarbTDkZ1ALOROSntVqQHI
	 KKk+ujP+V6mOw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 01 Jul 2026 15:56:58 -0400
Subject: [PATCH v4 3/4] sunrpc: guarantee a thread per CPU-bearing node
 when auto-distributing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-sunrpc-pool-mode-v4-3-b3d867e4c8f9@kernel.org>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
In-Reply-To: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=S98u0vURVTChn+wbGWAytnSStuKzPkQucWZNMJ+E7fg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqRXEViSyiV3W9LTJqNDPlD9bhzHiURWBaB9bh/
 FNBxrqD9x2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakVxFQAKCRAADmhBGVaC
 FTZ3D/9bR+S1SxjkZCYEQcUymLpZjYN/NfOL4rKp3FgUfGVQStFgt0j0yhHWpjL7hriews+NV2T
 NP110IApjhuIra0ZR7nrYoNoVL1O9VSbmu7MuT/ugCVpMgxpYElibwjats1WkXsKD2BBZ2XZupx
 BWpqvIamRf7y8vwz7jP6+8pvlBPDpcYhPrO0wl5V7vuFzwOWNUJlz1A0DEwbzx7VIalDcYh8ElV
 figCuoXpRnD7nakNP4vcDHPS2nV7CFsTn55kfPFPmuG0MkhpITG/vOOkCerhzjLYbVaa5cifLyA
 v594ZtL/jYFGtR7LTCrk2nH/se4WNQOVg7tS2gCOsdb9j+vMAXbXM+aZ1U6XaRXDMFiMK9ccmPW
 Xigd+K3pBMt0GK3UZ6YsuR158SIbquQklDzDcG/XdXTWRd1sueUxGhRxeNPtYulloykCyfTOlag
 t3NuEXj2WbsDJ2Bvlyjl4ADy3WkrNVyRbh7G52WlcZZsugE6jnw+/L+7+YllLOpboBSpYnCi0oq
 OTHl9xYv+StBbGfjpO230Bw8RXPYW8M5dtjTX+EXaZcnW2QRklCwcZetkSXZm2m3pVF6WMvlKqb
 r4XwAn5+krYR7dA8suxe5KpV2jlo1FzD8/sU24druYeGmc/Nt+tcEsOcrtvRXCKQXRyBCjmizqO
 ZIK4Cb9Z48Ha73A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22912-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 436186F13A5

svc_set_num_threads() spreads the requested thread count evenly across
the service's pools. In pernode mode each pool maps to a NUMA node, and
svc_pool_for_cpu() steers an incoming transport to the pool for the node
it arrived on. When fewer threads than pools are requested, even
distribution leaves some nodes' pools empty, and a transport steered to
an empty pool has no thread to service it.

Floor each CPU-bearing node's pool at one thread when auto-distributing a
non-zero count, so no such pool is left empty. The resulting total may
exceed the requested count. This only affects the auto-distribute path
(a single-value array, i.e. svc_set_num_threads()); callers that set
per-pool counts explicitly via svc_set_pool_threads() are unchanged and
may still set a pool to zero. Nodes without CPUs (e.g. memory-only nodes)
get no thread, as nothing is steered to them.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index c9fba7edaace..ae93a6f51087 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -837,6 +837,12 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
  * are multiple pools then the new threads or victims will be distributed
  * evenly among them.
  *
+ * When @nrservs is non-zero but smaller than the number of pools, even
+ * distribution would leave some pools empty. Since each pool maps to a
+ * NUMA node and only services transports steered to that node, every
+ * pool whose node has CPUs is instead guaranteed at least one thread.
+ * The resulting total may therefore exceed @nrservs.
+ *
  * Caller must ensure mutual exclusion between this and server startup or
  * shutdown.
  *
@@ -861,6 +867,15 @@ svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
 			--remain;
 		}
 
+		/*
+		 * Don't let a node's pool sit empty while threads are
+		 * being auto-distributed: a transport steered there would
+		 * have nothing to service it.
+		 */
+		if (threads == 0 && nrservs &&
+		    nr_cpus_node(svc_pool_map_get_node(pool->sp_id)))
+			threads = 1;
+
 		err = svc_set_pool_threads(serv, pool, min_threads, threads);
 		if (err)
 			break;

-- 
2.54.0



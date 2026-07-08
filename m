Return-Path: <linux-nfs+bounces-23168-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uzyAFP07TmrVJQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23168-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 14:01:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2EF726195
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 14:00:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lwJnXufL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23168-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23168-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 602723011A47
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6B3FFFA4;
	Wed,  8 Jul 2026 12:00:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A595423A63;
	Wed,  8 Jul 2026 12:00:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512053; cv=none; b=mJSK8bTT/bJLB/Hm5I2NAVgpFG1tykAd+luuGW4vI+biJvTmjnN3nrlmshRdRslCpMcE7qxUOw20y4SNvl+l20k/62QLBYfc0fdYSRfvcAXrSMVAjmLfgKLvAF0kU3XFrwqfTrh21gHhDL6cmdtQMy+xIwxlWgHi72Cmp1/pYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512053; c=relaxed/simple;
	bh=b/AbzeQoexgmoq7XYciNSWtkPOPv1wBY2uMOQqWCqNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H2dddTWt38FlbsP6oEK32WeqRUIirUq0kdZ4G/dDKcQTCc1ZZbtE/5KcevSRJOJkpuw723KUdELvGUoDmKtev8xbRn841dgcVYW5st8Iauv/6JNBUObGxW837XZoX188rpwHrGZ5ABAxEtzhum6J8uDGG63WXlohLGVDsithqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwJnXufL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556B91F000E9;
	Wed,  8 Jul 2026 12:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783512052;
	bh=6Dt1bbqReDzkwzcN0sJtDGn5HBkCvFNhTbdFtvl5U7A=;
	h=From:Date:Subject:To:Cc;
	b=lwJnXufLcxLxdNnmrQu0e7JZhMVzEob/7wVSRmbM63DX3OrlGt2t5Y83w+v84LeJq
	 5LozoLw/CrGak8jf5TRFREMF+mNE5FFYcxtdBAbOV3V+CeTgMqPywUme5mwfB/j+CG
	 FEpq+8nmrnl2vh0etyNFZyvEtMgWniqZ1EDrTJtwgUlzz9znDcX9k2lY8xuPvWXAEZ
	 B+3xvecgwvgdh93nWNY1cvuLiSa5h+PE48k6WSyrjdjprIMQK7HR26ail7/aIvBNfl
	 1mEtK54HuBhasORE+NXJfmWEaevdEsDEb7X0Dkq0AiRGuw2OZ4b3p4At3m7rbhjyle
	 f8fae0UjFbGmA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Jul 2026 08:00:26 -0400
Subject: [PATCH] sunrpc: drop unneeded nrpools check in svc_pool_for_cpu()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-pool-mode-v1-1-98e9e106ebf3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3YL8/Bzd3PyUVF2jNLNUoxQzUyNDcxMloPqCotS0zAqwWdGxtbU
 AW8Q301sAAAA=
X-Change-ID: 20260708-pool-mode-2f6e2d652174
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=b/AbzeQoexgmoq7XYciNSWtkPOPv1wBY2uMOQqWCqNs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqTjvm5YtnZOY+LrnYagneoYlmJi/h6mEHS4SK9
 Wbm/meRh2GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak475gAKCRAADmhBGVaC
 Fc/pEACGMsRYjSNnANfgA7qNfQ3UnnK0rVkfGtAbnQfFy1+DXKM2k10QN+q1J6WDlQTzEpBFwgW
 ArbrYhHxn+GYxnP5Q4LGtNhwwoqyTWRaghepGq3/blzdqo3BELw8zeyH5sDnBc1/OSFCA/I+nim
 0wd0ygfx2RRKxK57aFAPsaFbcB3q2c6E1yUHilSzIeeOD2O9JDp78RhDHX8UdoJAIP1ZMAAzVx0
 3z9dF/FPNM0c1yrqzbdq4zvmcRnqp0bBrIw4GYK/E4iwteL3ryaCm23B2COu2p6IY6Rv71PPXe+
 uFM9gSiCMc/XuE7LOHO7EG90LM/hEOYhANE9FTA54G6Wg+7e9O5VPUf3z0Re105J5tK5zlnAlP+
 mQ7+ZC4CoGqMDGOk7TmfwM2PbXOCzh+uzK6d0qCcnqza05r/4Hf9/baBLoxB487MC8SFrLIhGeK
 Vlzonokx3rwskrBl03XBy3CT/Xwd/dtIh0CokhbWik531fCPoes3poYL+SQecUvOmXmWlWoSDCN
 uBTlTcGrD6Cflol6n/vRPQIngbhcAvrWVECAZNCFxJhNdpfi+acuc+roLNw4sq2ipyLuFy6Gf0b
 Srow99RvZzKWUPy8EqymU8Y68WZiKHI+kwky98TI++uYwKs/ukMtGKjogydHv2sLqNQAbi4PI/V
 Rw2XKzsNHpKgtZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-23168-lists,linux-nfs=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[brown.name:query timed out];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	RSPAMD_EMAILBL_FAIL(0.00)[neil.brown.name:query timed out,jlayton@kernel.org:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C2EF726195

As Neil pointed out in review:

"The values stored in svc_pool_map.to_pool are all less than
 svc_pool_map.npools.  So that if() condition cannot be true."

Drop the useless check from this hotpath.

Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Chuck, feel free to fold this into 5/5 of the pool_mode series.
---
 net/sunrpc/svc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 13d63f6b1d88..a098e1c13ca3 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -269,10 +269,6 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	if (nrpools <= 1)
 		return serv->sv_pools;
 
-	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())];
-	if (pidx >= nrpools)
-		pidx = 0;
-
 	/*
 	 * It's possible to have a pool with no threads. Userland can just set
 	 * things up this way directly. Also, when threads are autodistributed
@@ -284,6 +280,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
 	 * populated pool, trading NUMA locality for a guarantee that the
 	 * transport is serviced.
 	 */
+	pidx = m->to_pool[cpu_to_node(raw_smp_processor_id())];
 	for (i = 0; i < nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[pidx];
 

---
base-commit: 9435623ac560654825a62ee4b628ae4bbaa87920
change-id: 20260708-pool-mode-2f6e2d652174

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



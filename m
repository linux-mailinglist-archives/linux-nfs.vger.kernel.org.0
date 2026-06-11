Return-Path: <linux-nfs+bounces-22513-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rEENELcUK2pU2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22513-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:04:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C66674ECD
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:04:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i9pUnwLO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22513-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22513-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3813305B084
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AC3A9622;
	Thu, 11 Jun 2026 20:01:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5863A7F47;
	Thu, 11 Jun 2026 20:01:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208087; cv=none; b=VZYfO8w6ABaC+x2476kFVH3fHiBQWthUScOQmSaX19JK0UpZ5tWYx21duD7T2kOL6F+GXpXc66739p4hlJwM1kp3R+BKiiiNiOAGi/lZQpQFvTZU9Nzxbq+wEs26i2rVJ+Gv1iqVswShZzAEIrUaDsRs1qERbUSpa+nwxEK27qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208087; c=relaxed/simple;
	bh=YBqZWnvNS9uriMTrTmA/sTnLcvDhtHboQIRiMr+9iPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwxX/K3q43A53ib2t6zM91S2t8mPLdsBUYs5sMFEmgb5l5w1OFSJfigvveNZA72SLYOo8FqZ2ZMOPpvqgnOvVj4juur25CCZeSeYVRzic5Q4JteQOGFPe6rkjmEpZdxeJra0m1IETkT0LpzqyK3WizvJ/5qRBFVDHCKqqtGVhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9pUnwLO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6C01F00A3E;
	Thu, 11 Jun 2026 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208085;
	bh=5xEvz/sZONYaVq46iVZ68/Vo8Vo3q+jbHPP3dR1d4Go=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i9pUnwLOAc1l1CiDcQUH7VRg+hxZEc99i6yhu93WL6qEbsbTocox4F9ub5lTVDLoq
	 Zg2Hg60qSzKnid9/15e+YOOAdLIaDu3UmCerJxi1LFvLl6ma/HGXGjgr7e7mTFEVRq
	 KBOB9PiYeDG6E4A6ZhZ5As5s/a1OvyMoQRIWJwIf3KB8rEay9GgQYvXzoBRj8iu+wu
	 Uo9Ox99ddosvAOZnQsPIpkoBq216A3qI2z0v3Q7Mv4XbtiPvlN7JD4Wh3mNq6kfkJM
	 PdRADTHwaX8SXE/4hMfZ48HI+ezxOGEB5zF7rVfZfwqecW5NXOh/WRHRxpgLqFIRx7
	 fpDEzh9S8lZuA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:01:02 -0400
Subject: [PATCH v2 19/21] nfsd: restore rq_status_counter to even on all
 nfsd_dispatch() exit paths
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-19-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3388; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YBqZWnvNS9uriMTrTmA/sTnLcvDhtHboQIRiMr+9iPk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxQAPnwqX3ZY4DE/EAt9zHLYPSWxRMFzWYSGs
 aA6CYu+3eGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisUAAAKCRAADmhBGVaC
 FaVvEAC2fkMIGVadQUh/qz8rDQn6mOxvzz9vvrQ2Lq5zhAxyu1v5RkAJjVLgIpWyz8/XGbO9+Gi
 wG/YGb+MrWwXhYnwtZsOCQfqS4nVGL/fwYTTU+x171Ni5jnL7UK857rOP3MqB1QSWPoqkNr2dhA
 FLO+f13LT36ni9f8MZ406+Ou/XI//waBhQR0GYEzAaivAMSPCtcTLg+V/QleiE2oEDKcpHwhi7k
 Bc9SEMLcynnsB2lB0sWxsst5aDRS350b+MMRSYw+ESd0jp4xfZLvPXMAw4zWX2/PMcNjAeYEaFc
 K7mil7yatsRIEuaVk4S4RzzsjKJVemn9ZYzvBuf9+drsPeerQfIBjrcdsfFfsjd7Xe4+5qHS6zV
 5PQxvgJbbLekzo/dpIpB0N5hhCrrFK+IUo8Xw8RWBJ4qgzmcpdDR1Y8rtNoQBe6etclMNNYwKjS
 FCDN/kXQVFjBl+bwtzfCWlAeUvcekMSuTXmr3qf+6sy2Yft0dVS5xzbsuFYmZIIYaYkQ9vYc0g+
 eh5AJqp9+/nWiXik18NyOTvvj66yAwDzbe59dGnUk4TskGuaVR6KRCcokTSrsl0vDtQR3t8ZNp1
 gf0yCImPCUgyEyOP6lcG1cilTt9jr/jBU8CmYkfUYGX35/pltnilbaAcs6XSqhxz86x5Y6nAFUb
 mhLHflN6MHSjJDQ==
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22513-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5C66674ECD

nfsd_dispatch() sets rq_status_counter to an odd value once a request has
been decoded, and back to an even value once it has been fully processed,
forming a seq-lock like protocol with the lockless reader in
nfsd_nl_rpc_status_get_dumpit().

Only the fully successful path restored the counter to even. The cache-hit
(RC_REPLY), drop (RC_DROPIT / RQ_DROPME) and encode-error paths all return
after the odd-valued store without ever bringing the counter back to even.
Once one of those paths is taken, rq_status_counter is left odd: the next
request's decode ORs in 1 (still odd) and only a subsequent successful
encode restores even. While stuck odd, the dumpit reader treats the rqstp
fields as stable and its retry check compares against the same unchanging
odd value, so it never detects concurrent mutation. This exposes actively
mutating fields (e.g. args->ops / args->opcnt during compound decode and
release) to the lockless reader, which can read past the end of the
8-element inline ops array.

Add a helper that advances the counter to the next even value and call it
on every return path that follows the odd-valued store. The decode-error
path is left untouched as it is reached before the counter is set odd.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfssvc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index b8e8d80e984c..a8ea4dbfa56b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -966,6 +966,20 @@ nfsd(void *vrqstp)
 	return 0;
 }
 
+/*
+ * Set rq_status_counter back to an even value, indicating that the rqstp
+ * fields are no longer meaningful to a lockless reader. This pairs with the
+ * odd-valued store made once the request has been decoded, and must run on
+ * every return path that follows it so that the seq-lock like protocol used
+ * by nfsd_nl_rpc_status_get_dumpit() is not left permanently odd. The store
+ * also advances the counter so a concurrent reader detects the transition.
+ */
+static void nfsd_status_counter_set_idle(struct svc_rqst *rqstp)
+{
+	smp_store_release(&rqstp->rq_status_counter,
+			  (rqstp->rq_status_counter | 1) + 1);
+}
+
 /**
  * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
  * @rqstp: incoming request
@@ -1028,14 +1042,9 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
-	/*
-	 * Release rq_status_counter setting it to an even value after the rpc
-	 * request has been properly processed.
-	 */
-	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
-
 	nfsd_cache_update(rqstp, rp, ntli->ntli_cachetype, nfs_reply);
 out_cached_reply:
+	nfsd_status_counter_set_idle(rqstp);
 	return 1;
 
 out_decode_err:
@@ -1046,12 +1055,14 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 out_update_drop:
 	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
 out_dropit:
+	nfsd_status_counter_set_idle(rqstp);
 	return 0;
 
 out_encode_err:
 	trace_nfsd_cant_encode_err(rqstp);
 	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
 	*statp = rpc_system_err;
+	nfsd_status_counter_set_idle(rqstp);
 	return 1;
 }
 

-- 
2.54.0



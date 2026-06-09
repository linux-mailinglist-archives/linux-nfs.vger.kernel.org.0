Return-Path: <linux-nfs+bounces-22412-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zPJUO/5SKGq8CAMAu9opvQ
	(envelope-from <linux-nfs+bounces-22412-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:53:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570D66315F
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 19:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UpnG+FCX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22412-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22412-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7715230DAE8B
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C14DB572;
	Tue,  9 Jun 2026 17:47:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416D4DB553;
	Tue,  9 Jun 2026 17:47:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027276; cv=none; b=c0QUrbRObjJixwNhok6+WkJg8l+Sln2TekA9MRDhVrNiCyIRl8ADPGcgxSknTpk7ndSLEhsRutINAAKd57s+vB+hcPsdew5QRgD5FLmL+1YJRShQJff2UR/+TLtPauo7D5GoyBpYapHGwKqXtC7UJlaYR/HISevvwulWk5BjRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027276; c=relaxed/simple;
	bh=SGVML8/1QqskLJed4yUO8FvGPh9ZtpDIjSZZATjRmKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ice9Ws4wwv3a5Z7irHIW/XMY5SCABM/EaYmQPlgId8voSawZNyZI80DAKfqe1RPKaGRKERAoEvZGWW3u+G/ZCvJWmFXbaiGuD/WAJYQG2SajPSrM88c2/AQ3fusQTI1Cxy6fQdKNZJNTzaXHfZTcDDiSXiQS431WHOSB2+noCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpnG+FCX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7DF1F00893;
	Tue,  9 Jun 2026 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027274;
	bh=twCe8wG19LFgnuYWOroWZUvWCE5na0M/92aSTFpzL0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UpnG+FCXwgynEumHKV3R/xYQg88b3rFAlQZRlnK6e4wMicdugwuPmIufpKDIxUoJ+
	 jSY4Y5mXYeLrs0j9ZfzDH8woaZqoDyQ/8P/G+riSSyvVz1VUlg9fCMwq1Ptf8Xb/qB
	 s9sN55bo9vPF4F7hfzzjh8v69lKpa0fr3YDYjn4CXntps6XzPRkJku/+pS7N4buW2s
	 YwrhPtMBLrlj4Rw7BhKOUirsYCNXOS1nl0ffy0Sw1YCxpHV+lLJ4i0dACOOLsqi2+p
	 WszqQub8+zbUdx/RziklMruGfby60Wc6wqmeusgjW5nSMx+rSwIiPQYZd/Mzrsly/5
	 Va4bdX4nyznBw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:26 -0400
Subject: [PATCH 05/19] sunrpc: defer rq_argp and rq_resp free until after
 RCU grace period
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-nfsd-testing-v1-5-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SGVML8/1QqskLJed4yUO8FvGPh9ZtpDIjSZZATjRmKY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG6ISin6pD4vSEJj0M8eBzWWYM4enaVWgcOp
 aNt3t7mzL2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRugAKCRAADmhBGVaC
 FSFxD/0SQP1ncWZshtiC1XSGNN5AwFmWRrnYdp0CC4WeRemf7QmaFoM9nndgNigDq8NjhfCS2jL
 rFWTiogv9bFqwXPY3BD/UmCyngGDARQ4k3Pty2kSEeR83bC0/hB0R4hz8QwrtCTao7a8mR+fBLA
 GyW08qPjtF1vrl9iLV/Oxu6abexc8l7EjmoNp4f250Vuzzt9fYu4yNiasVOUj+OmgzzAYz0odpB
 dPTOJW446YeADHoNjjEEiYwd8ia8Y8e+7DfNWysnUcBu0HOPvvI22zs9CXs8eMPAQ8uLQYjecJC
 pL+/wQm7s8ftcSI44hj9JHFfOWCeQnaqG2VqL7SoOY6GNBom3oaAw6XagEmuisp0LtGiSdlY/+f
 NLtzITQd+6/MgTRC8tzhn36NdSWGVVJnYU1M2uwElLw40XAqqTxESjWhlEsQOkhyIpcGvqfwctb
 lFY7R2x6VVh98Uh5NQzhCdk2BY3uZhk1wWqsj0rIjQMBjghnfztz0vQIKdReiC8rs60aSvWDGtK
 uloul7dJE7AmHNETScufSbwMXQQRwoffg5cBkHnVhZhzOwzHOWbBSUWrZNrrRPyZ1NS1U2lIOTr
 Q63l+F78pTkr4wm4g73N4wWhX9ZEznnI19gatwig4AFt9TJi1aQ5uApFmnea9PiIfgSCS/lQS0V
 EUnb7ejM1BVQoLg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22412-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8570D66315F

svc_rqst_free() frees rqstp->rq_argp and rqstp->rq_resp synchronously
via kfree(), but defers the rqstp struct free via kfree_rcu().  After
svc_exit_thread() calls list_del_rcu() and svc_rqst_free(), there is
a window where RCU readers that started before list_del_rcu() can still
traverse the thread list and find the rqstp.  These readers (e.g.
nfsd_nl_rpc_status_get_dumpit()) dereference rqstp->rq_argp, which has
already been freed — a use-after-free.

Fix this by moving the kfree of rq_argp and rq_resp into an explicit
call_rcu() callback alongside the struct free.  Resources not accessed
by RCU readers (bvec, buffer pages, scratch folio, auth_data) remain
synchronously freed.

Fixes: 812443865c5f ("sunrpc: add a rcu_head to svc_rqst and use kfree_rcu to free it")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 009373737ea9..a7d893bc2d73 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -716,6 +716,15 @@ svc_release_buffer(struct svc_rqst *rqstp)
 	}
 }
 
+static void svc_rqst_free_rcu(struct rcu_head *head)
+{
+	struct svc_rqst *rqstp = container_of(head, struct svc_rqst, rq_rcu_head);
+
+	kfree(rqstp->rq_resp);
+	kfree(rqstp->rq_argp);
+	kfree(rqstp);
+}
+
 static void
 svc_rqst_free(struct svc_rqst *rqstp)
 {
@@ -724,10 +733,8 @@ svc_rqst_free(struct svc_rqst *rqstp)
 	svc_release_buffer(rqstp);
 	if (rqstp->rq_scratch_folio)
 		folio_put(rqstp->rq_scratch_folio);
-	kfree(rqstp->rq_resp);
-	kfree(rqstp->rq_argp);
 	kfree(rqstp->rq_auth_data);
-	kfree_rcu(rqstp, rq_rcu_head);
+	call_rcu(&rqstp->rq_rcu_head, svc_rqst_free_rcu);
 }
 
 static struct svc_rqst *

-- 
2.54.0



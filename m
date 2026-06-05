Return-Path: <linux-nfs+bounces-22310-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ocSLFm4KI2rkgwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22310-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:42:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFAF64A449
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 19:42:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VbSBk7p1;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22310-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22310-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 331D430465D6
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03D43955E0;
	Fri,  5 Jun 2026 17:34:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00539524B;
	Fri,  5 Jun 2026 17:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680896; cv=none; b=HPcEE6tYdUWWmef2dBRs7IgI85gIhZa9CJOhR9FnKZvtUCi8ZeQCCgd8/5gytW9bVRI4Wnkv6xmBdD8r9PGKRdNBSBmi8oXm+lcDHvWrrdi2B3ErZJNf+5BLNrK85OlyvY/8eyUNtSl4O4m1zCDrGGkwdJQZ2u9SFMS+e1jTTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680896; c=relaxed/simple;
	bh=XYSve/+uQA77SS95oXidJN2Gy+GZI0dbAAVfdnBdi/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKj+s8MJBcL/5ugCOCYV55OACPwQ2/B9RTfwaXFeHldr/Y0HWpq+OHRyGXDI9EmIMdlqiaaiTJ+x43mqJ2A5NiPouiWpDiE7tVCfrj5lSKgDHGhytI2S+1YmWazgUyv+A7Hgwc86wmtzdnbZI77Kf7UDj+JKSnPvs3DgfsqcnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbSBk7p1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DC1F008A0;
	Fri,  5 Jun 2026 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680894;
	bh=g55QuqUSk/40xpvuxGLJQn0UX5R2gfamQPjzHvhk1NY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VbSBk7p1bv6rd3D8tQfrGABpk3u6B4Dp9YBPSaV8iOpMqFW7mdQmiiuOl3isjdsLG
	 vlF3F3ibJ9bmfx9hgNm6h4CoDFy+os4rhEyTo3HVgL72cfmJbp+KFKTg1hbDc7aX6W
	 Ay4JIumhDjp1bstPKn3fDhPdeMtWnMJI0LusquAWJ2OuISZf35UycPi/HtfYKVmTw2
	 JgcAsBcZXGGB8pTa+S0ScXezQ1mI9vQ34WX1QLarvCUeLzVFI/JDYVxQIOovP4PJVP
	 0Rv2F1B72+pLXH/xCw27DZtI+bSYOWfPJJG0heBtrp3KmUbWHczGTujipboFjC0cZE
	 E+Ew2y1s6DN2Q==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 05 Jun 2026 13:34:39 -0400
Subject: [PATCH 5/9] handshake: Add a kunit test for the completion gate
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-tls-session-tags-v1-5-47bd1d94d552@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
In-Reply-To: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4421;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=q9p1RD/hlCvKDQf1Fv844KE76NPfyXDv+t6N8hl0+WA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIwi4wziu/pmHJ8Ki4gLtxmWoL0sMnxDdjY9g3
 zZrxQpqqDCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiMIuAAKCRAzarMzb2Z/
 l89CD/0W8uTG4DvPZJn0BaPegvmXcG9n1TiHYDsi88WKENlzGr72/2OCpTVqoCd6pUmOFp/oBXh
 rqiiaTnkffdr3JdMCj8NjCVw2eMPvpoFofqxQz2b1AU0ZykLydkHfQoM7PoLgSO8HQ3Qqd+Yazi
 HSB95ivSvCgx5iAtTrfoPKs2lp79MAN80M4U6xZNx/e6uSyqspxECd6fc0sQh1ykBhffdGAyWHD
 7rrfwp6uJWVfyquOgk1CsQfbX54T36pE0VKDAfuZR80gVn9mQHnurYVxp3qUTovXpFZ50BxLoAS
 36JoOYqj/q50EOFO0K3nlZJEQzu4I36nu+ff0KYayGKAbqUsp6/Tu4HiSZrJ8h5aQvVhYdD4DAK
 swdIAsLS06YYQz/+6iImtrcvkCI/TbIf0dwtKj66UnUg2lm8GDAuPL0hLmsrZrFAmapCZAHoab9
 jbKf80hUnaH1Ck0+iq7iVRYoQE6nubdFaASYAeHu2ki2r/zyLvpUt63/gwvKYDc7RP2p4yrwHA4
 t1aJR62DrjIaMGYRTrCz8BGs9GGVmWCfLVU7DKeEyCUpvzOSyKJTpKEgb/kZNsy/G8Iz+SzwpZp
 n0jqOUyCGMXWF9mu4FsuDRJKrTk8S9Vub6SigXCp/4ictOTGpUCi6cbl4xS5oFaEDM58g+VwsLD
 MAdtgTPuC2+c4sA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22310-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEFAF64A449

From: Chuck Lever <chuck.lever@oracle.com>

The DONE netlink op runs with parallel_ops, so duplicate or
concurrent DONE downcalls for the same socket can both reach
the same handshake_req. The split try/finish pair guarantees
that exactly one caller drives completion to the consumer's
hp_done callback; this invariant lets the session-tag publish
step transfer ownership safely.

Exercise the gate's idempotency with a kunit case: submit and
accept a request, call handshake_try_complete() twice in
sequence and assert the second returns false, drive
handshake_finish_complete() once, then call handshake_complete()
again and confirm hp_done fired exactly once across the
sequence.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/handshake/handshake-test.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 net/handshake/request.c        |  2 ++
 2 files changed, 74 insertions(+)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..c172b7a9750f 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -430,6 +430,74 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	fput(filp);
 }
 
+static int handshake_try_complete_done_count;
+
+static void test_done_count_func(struct handshake_req *req, unsigned int status,
+				 struct genl_info *info)
+{
+	handshake_try_complete_done_count++;
+}
+
+static struct handshake_proto handshake_req_alloc_proto_count = {
+	.hp_handler_class	= HANDSHAKE_HANDLER_CLASS_TLSHD,
+	.hp_accept		= test_accept_func,
+	.hp_done		= test_done_count_func,
+};
+
+static void handshake_try_complete_test1(struct kunit *test)
+{
+	struct handshake_req *req, *next;
+	struct handshake_net *hn;
+	struct socket *sock;
+	struct file *filp;
+	struct net *net;
+	bool first, second;
+	int err;
+
+	/* Arrange */
+	handshake_try_complete_done_count = 0;
+
+	req = handshake_req_alloc(&handshake_req_alloc_proto_count, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, req);
+
+	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
+			    &sock, 1);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
+	KUNIT_ASSERT_NOT_NULL(test, sock->sk);
+	sock->file = filp;
+
+	err = handshake_req_submit(sock, req, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, err, 0);
+
+	net = sock_net(sock->sk);
+	hn = handshake_pernet(net);
+	KUNIT_ASSERT_NOT_NULL(test, hn);
+
+	/* Pretend to accept this request */
+	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
+	KUNIT_ASSERT_PTR_EQ(test, req, next);
+
+	/* Act */
+	first = handshake_try_complete(req);
+	second = handshake_try_complete(req);
+	handshake_finish_complete(req, 0, NULL);
+	/* handshake_complete() re-enters the gate via
+	 * handshake_try_complete(). With the gate already taken,
+	 * hp_done must not fire a second time.
+	 */
+	handshake_complete(req, 0, NULL);
+
+	/* Assert */
+	KUNIT_EXPECT_TRUE(test, first);
+	KUNIT_EXPECT_FALSE(test, second);
+	KUNIT_EXPECT_EQ(test, handshake_try_complete_done_count, 1);
+
+	fput(filp);
+}
+
 static struct handshake_req *handshake_req_destroy_test;
 
 static void test_destroy_func(struct handshake_req *req)
@@ -522,6 +590,10 @@ static struct kunit_case handshake_api_test_cases[] = {
 		.name			= "req_cancel after done",
 		.run_case		= handshake_req_cancel_test3,
 	},
+	{
+		.name			= "try_complete gate is exclusive",
+		.run_case		= handshake_try_complete_test1,
+	},
 	{
 		.name			= "req_destroy works",
 		.run_case		= handshake_req_destroy_test1,
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2215a9916727..96c27efa9958 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -311,6 +311,7 @@ bool handshake_try_complete(struct handshake_req *req)
 {
 	return !test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags);
 }
+EXPORT_SYMBOL_IF_KUNIT(handshake_try_complete);
 
 /**
  * handshake_finish_complete - Deliver completion to the consumer
@@ -341,6 +342,7 @@ void handshake_finish_complete(struct handshake_req *req, unsigned int status,
 	/* Handshake request is no longer pending */
 	sock_put(sk);
 }
+EXPORT_SYMBOL_IF_KUNIT(handshake_finish_complete);
 
 void handshake_complete(struct handshake_req *req, unsigned int status,
 			struct genl_info *info)

-- 
2.54.0



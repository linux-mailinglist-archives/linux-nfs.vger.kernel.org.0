Return-Path: <linux-nfs+bounces-22702-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id caw5OxKXNWqo0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22702-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0A96A77C1
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nlqmNqvB;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22702-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22702-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9990F300B8E9
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9581A3438BD;
	Fri, 19 Jun 2026 19:22:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CF53451A9
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896973; cv=none; b=POj3Q7d4SYKUtWPJD4WthxTmaPAOYD/FPKjxykgbVz1NITrHmjL6Hdx09PL68ygvLsOSq2JhqjJ6t2ooDtE6sQbIWip9HQ6fxu1Bm8pgybatUVlFYRRavbmThiKcJ26wS437CzAdrC0nJWU1FUny6sHkYbXVMPtqS7d1EMgy8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896973; c=relaxed/simple;
	bh=E+6qzYdKgS4YqznItLOjUhSzAn+xgzN0iqHfwsmM4cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRFT+H/CSnaW3JinNOB/sTLevNqr1B3sk4WOBvSy5tO893Ark++uQq0OIJQtyyjogwlx00HFLwxiZwSJtZK+BqkiD9EdLPPn81eHSnTO8Hj5ctINA/CYS66o69U4UWRqCM4n/jMGPVSE+MAoelfzwU/M1wdHmVzmx2/RCYF9Nv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlqmNqvB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414591F00ACF;
	Fri, 19 Jun 2026 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896969;
	bh=70bIAjAcLi1mcmGVPHJ0Ji+ghCc/93HMxPaHTeC4AiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nlqmNqvB1ZjCKaDBuxEcLnHWhYtDJhKfF1XheAnPPqyXZxQpI5Ey1K/ZfoZBPVj6Y
	 QJhU2GNlqo0LkohalznvP0w4YuZH9zJyeNKR0T/U5h3HIyf1vllcxLPcnPCiKwnh/v
	 fLp4DStL5TD7YJQOJG36Kcfb3IqpyHfLZSNyPo/j0d0qWfdZ3Q44stmkfXNRXsHFQp
	 VI6CNPHiOHs4l+3yGmnkAmwUouZUmVDwvX0ExeQM3ftSmGqkh53yzqslWQrU5Enbzn
	 +ygDXLeMYk245zdVaYF4EnOU3Q6fcsyhsxzQ5Wk/PvmW1FvYlCe/O/My2tNbiP90XT
	 lsv7HKK6CWv1w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:27 -0400
Subject: [PATCH pynfs v3 08/26] server41tests: test mkdir triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-8-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=E+6qzYdKgS4YqznItLOjUhSzAn+xgzN0iqHfwsmM4cY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb660NqrGoM1ZtuWG/NE1cURkzOoSY1e1V9d
 rEqSMUfr82JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+gAKCRAADmhBGVaC
 FVJoD/93f9N28RyTwf6gQLZ2efBBUBhFJacr3EYhOchrQPyQUUMEWF15PL1XNMB4fOOzhonF2HX
 eWV2GIVNR5kzunTe4JmXYbc7K12CENqh/PbwOYgBWZR+4br/0WETmc/bHfowK1JdmOwVnAA9ivP
 RYX6QZWmOv8yFCpyd0Jfmd2F3hlFIX5UR/eMZm7VqXHSwVLVQAX1lfKjWRF586oZ1mS+lcORFkL
 0PbwBljNUyJp+SfjTL/6l+qZ4jLzEKMcbSxGNG0gVIbTZ+mQy0PIgYOf5d6Aq2Tgmr7Q9lgC00g
 LUMMGYkJRajHSNsenawGIK70tNIz9aUG4zk0zwKTFXr53o2c16AAgFFLQ+8s34fWVJoGRB1/gqA
 Ne3JiQePg5HgPQy7nOZ1iFUW1hewIcqTqTkR9g6CNkKvCB8EWebFilIJe2W2kjaI2jOSDbwQUVY
 Pf3g4ZCetu96nuQ/vfUPD4GGYM3Vgmpj0QDICnttvJ3X9RK/5RzAwcTU/ZIs7y7X4nmzTX/z8GE
 V+hHobMxYzBH0hEE04JfiF9neU/g6Ak5tu6WX/EbKwzkaCQY9AWAjrJPJyD1E4iFHJJ4b4Ve/ib
 RwpxU6MNk8qDx7FSWfzNYtIyCTVIUV7B3IzFuBeWgagWl4h15IqppYltSaABgFoSLeY6c+YPMNJ
 e+Gjf1dAikSUtzg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22702-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:smayhew@redhat.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA0A96A77C1

Get a dir delegation with no notification mask, then create a
subdirectory from a second client. Verify that the server issues
a CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index b968035d0446..b27e68eea5f6 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -219,3 +219,26 @@ def testDirDelegRenameRecall(t, env):
     check(res)
 
     close_file(sess1, file_fh, stateid=open_stateid)
+
+def testDirDelegMkdirRecall(t, env):
+    """Verify mkdir triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG5
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # Create a subdirectory from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    create_op = [ op.putfh(fh),
+                  op.create(createtype4(NF4DIR), env.testname(t),
+                            {FATTR4_MODE: 0o755}) ]
+    slot = sess2.compound_async(create_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.54.0



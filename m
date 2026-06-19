Return-Path: <linux-nfs+bounces-22705-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOf+EBaXNWqq0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22705-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A56A77C9
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hntN5lf9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22705-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22705-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1612E3018760
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B2345753;
	Fri, 19 Jun 2026 19:22:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F9345CBF
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896975; cv=none; b=DVZqTUnlmqnO3pbqKJywqVlZicvCYU9WF24fIRrZZvPEcN92NvPC9ofqtOncwLsbX33aEta54omQ8r8gChSmG8fU/mqwjbjGKsRsJuEZMKYxoaE9wZU0wznCAd7qgCVAvnFGfkqgYZpbtFQWwKFHGm2UAvZJol8Ogcw7SoPc44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896975; c=relaxed/simple;
	bh=uRofFB4Prf7mjZ4oMeahaIY9KLObU9TLXtJkHDL0/NE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGdtcVbLmNeewqJdYrFBnDGf1xliOa2e8+ApRDQ+FxKKJSp55aDUkkW9xIAlaEq3q3b5KDgO8WXlVI+uDY6eLLvU1xfAGqcdC3WrR+j0RYJl3J6abCT9iJB5a3WDhr8USiLp+JrjzZCgmYixPDEL5CMV2hM1qDLXB+p33miXL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hntN5lf9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700FF1F00AC4;
	Fri, 19 Jun 2026 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896970;
	bh=VW6SQuVrO0rjFprztUCQwZ7xcxgfqwW4QC4JF995nkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hntN5lf9SZwlUoDFZBM/p0ck7T0IF5yWXSiEgHm4LJq4JeKTnDfFyXox5jm0dBGD8
	 lhm6WcWTdJqPjqkyvOCKI8fbIKjJd0lPonx3FLYtNsNH8EoC7ptcH2cA+6Sea5lliL
	 8WnjtKJZt8NUC61cdbtTZ8pH1SslBCU42XhR8IN7qJqAlquOi09qqn4zHxkOWqCW0v
	 9dEiXgTvwbFHXWVRsvLLxOKpnAA0Y4uqs2BJC2q8A1NMK9GXkoeh5gPnQndOlsRuYl
	 VoyIZ28PUw2amvYoXBsQG8+wxYGKdOxdaXixtgGzO3Hwe+c/sSbhmdkmu5G0h8RS60
	 jLTIhHuOgnd0A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:28 -0400
Subject: [PATCH pynfs v3 09/26] server41tests: test link triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-9-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uRofFB4Prf7mjZ4oMeahaIY9KLObU9TLXtJkHDL0/NE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb6/6jIXibtYO1MyF/ckqQitx1aOU0rEBCCU
 Oyjpwf8aaSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+gAKCRAADmhBGVaC
 FfDmD/9Kp4XoqUTrapmE9MClR2MG1IVoaa6WDu6u2Q/spVV/9NOOJJmQN2Ppdq5veNDybu7PoPm
 qUal5/0PsIaxQ6XmY8V0cOnU0t1z38xHxOaF3RaMX+2MVepLpPGO3laqheeoFhnp4YL/wKspLto
 D/FkVI99cfwlqDi//e0i5M+c3RWknjlVnrmQ9Xgp9FbJthV15FTFoAQWoqCyYotog6+87JQJJho
 Q+PsSGfs5GBB6q6SVlKVg/qn8X7YVERE66CVslwq7lkhnSCkRfvR75FFjuOERhYwGm0I+ff/YAw
 oK5zlXEZedjfLvk7/tdTAxjgqIgT6nQVMaIUp6MfXyxnchYXbZz0s+559bjr/x4cDyCmzgx37lN
 tWsmBUt7Q92+peIKFKZBlZ0tK3yzwLoz1fk5pfuM639RTylJyY7oPXPyFAoS2+ToBxSGnpVMqJO
 6yWjHXBLZvD6knKXuCtGdhTBqW2ER7YI0fHHZd46uDFMkp8V/0y2hALpzcLJY2l71YuL0cMuLZc
 gj2PkFAzuAOj9i08f3ZINJJFg0ummvPFD7dXipJiJPYUFu+1zFznYGYL7yf3+YGcQBoGXtfrpWN
 YZCiy9oY1bl4HDGmRQIOhZVG8FqrMwN+FspvtL8fn+KE9FT4mH9/VULmGoYv9szscUJqvZKVy95
 8USCq8Iw3awkpJQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22705-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A73A56A77C9

Get a dir delegation with no notification mask, create a file, then
hard-link it to a new name from a second client. Verify that the
server issues a CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index b27e68eea5f6..008e45d4cf64 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -242,3 +242,39 @@ def testDirDelegMkdirRecall(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegLinkRecall(t, env):
+    """Verify link triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG6
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # Create a file from sess1
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess1.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+    close_file(sess1, file_fh, stateid=open_stateid)
+
+    # Link the file to a new name from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    link_op = [ op.putfh(file_fh), op.savefh(),
+                op.putfh(fh),
+                op.link(b"%s_link" % env.testname(t)) ]
+    slot = sess2.compound_async(link_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.54.0



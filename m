Return-Path: <linux-nfs+bounces-22706-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Q7ZASaXNWq30gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22706-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5862A6A77E7
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FL/ywmm2";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22706-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22706-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC89306DA87
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAAD345CCA;
	Fri, 19 Jun 2026 19:22:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82481343D7B
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896977; cv=none; b=unL03XggRWI03ldaxrmO61tSrGVXkwqxC/WRMcnClYmGPrcRL1w3YDLDjxifubhkjK5XZQ5WDZJn/2E0NDli+Ycxk3zk8di1mhnD8ICeTUoWmJTe+0NVU1pNHFT64HAps+IO8Rld8l2niOM6bcyD3bPsvjWhjA0ogCQXNG/spBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896977; c=relaxed/simple;
	bh=ox5LyQmELRlskUVv5OHVVCj1Ji/pkbSQrDkERtP37eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsN9KsVCqu/taScX4mmu5KjGqKSRQTNYbG56JzaUpXHudb/rbSKxo916kSXuTrQs4YNbALgurM7FJSx1SXjeCLmL/O0sNzclkgJpmS+UJTvGD5NzhFEiMDY+YqSEmKp9TmuuArMf7p/1tqNEJcIaQoTQw0zQMaAol6hrTqMM/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL/ywmm2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E41F00A3A;
	Fri, 19 Jun 2026 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896968;
	bh=iTM19ddU10+cnckqwAlS2v2iqOm2FngyxUgjnMSJvZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FL/ywmm2oiuoRsSXSE+Ilqg336PD4k/+oF670Ukh/4BRtM4r49yQv8EAICMK9QA2k
	 VeVM9aPFGX3ngIQAnNm0S3gH2bJ9VR9gILllPIW8FFuC1YeUEPTPEB8va8P99mcVdf
	 VnScA3Pv24Ogi58h7bP2V52SY8qztOWhI05pisvI+8/kwNvQFs2vaNbojUM/T21IbH
	 Pr1CfQ349zBugUlv8TkU4ktM93Xb6qvYSBzS5E7V4BpsLyFrx9TUBBHJa0M2+2frg5
	 ZmyM2rqW2riwoXBGgwUpMZFAZ85NxMHgnosZpGyMzNHDAgETQSP2UgHolfaNIsZTI/
	 IhuALuhsk8cvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:26 -0400
Subject: [PATCH pynfs v3 07/26] server41tests: test rename triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-7-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ox5LyQmELRlskUVv5OHVVCj1Ji/pkbSQrDkERtP37eo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb6/hCBpf8ulqyImtS4V01DKvbitWyNg/ENg
 YEM7SsxGduJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+gAKCRAADmhBGVaC
 Fd98EACHcxYophham8GK71aSOsYDj0Ni/lq3n87YBJahC2KR7RGGgqKnD/lRwUW7iIqqfXzQf5Q
 EPW3qpgH8ESlVSNRQq47nA3IhpmJA3pBuZTcMxeci3Qr0xC3hhnpF+PVybWpIGsTN31qxv4fVwV
 /GbyHb/Da+oyOZYmBH9BDa4imMO5PQanGSVt2Tsw7DAriMF8iArcsQeZbK08dIdIBY8v/g/mkK1
 AAt5jygD+WhoqUrcI9BM8RiDP+vUoBGFmkayuAtKLeIUjxTrQzy1AA3BdKMhp2Q9USNYDakvVjP
 A+RT+TeFvOXJOzK/OygStwgExmuDHd1m+JnR8ZEzXWkLl/6JQESUItcEQWUnXttbiSFUNQh7HHl
 nJTsR+B7Swku+kclvrJ++q61JtqgAm3rFhq3Z2deR3jlUiS6x/OHuLbYQt6Bw+2qDxlu3lPH1Mv
 GQ+/YfxIgJdkH6KPlq4yyaJPNO8QWC9sdK2FvNHMYrvRFi3APq1L0NiZohjWPpjdwcfhKWmQGkj
 781vvcTepRxkrQD60RCkShU31wpuTabvbpXSXBQOvSpZlWyLgkQ4EGQVoFl6tO49fOab3hwwpa1
 ywmV1gPa44Lj91iCb7mq7ezOa7l/8PqXNoJffvjA6PDWgYZM5Gx/LMhjXLsznalpeQodc4aY/3+
 DbPK7QIop0JeCgQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22706-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5862A6A77E7

Get a dir delegation with no notification mask, create a file, then
rename it from a second client. Verify that the server issues a
CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index b2afc7cccb01..b968035d0446 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -182,3 +182,40 @@ def testDirDelegRemoveRecall(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegRenameRecall(t, env):
+    """Verify rename triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG4
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
+
+    # Rename the file from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    rename_op = [ op.putfh(fh), op.savefh(),
+                  op.putfh(fh),
+                  op.rename(env.testname(t), b"%s_2" % env.testname(t)) ]
+    slot = sess2.compound_async(rename_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)
+
+    close_file(sess1, file_fh, stateid=open_stateid)

-- 
2.54.0



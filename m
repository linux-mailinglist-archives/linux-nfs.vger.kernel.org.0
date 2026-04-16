Return-Path: <linux-nfs+bounces-20920-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGpMHBUo4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20920-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFE413AE1
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91E93147DC7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64932FA10;
	Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdWs45Wb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A6335072
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363308; cv=none; b=KXRkCU3C/Kdo9XFX+HKHs67OG9Z/lMZ+V2TlzUVztDo7slHOaFygZmvRfvsj/cHBWUAoLRFNxoIr4GgEx7bMrvjkpPrJ2h62nWAeXNogzEO65ysRVgL+pMv/pBiTzjenwPKovOZUCwCf7H/LfW4EpVlsAxG8vvwso7gCsQynDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363308; c=relaxed/simple;
	bh=69yqMworEtYuoPL9Me1tURG4VPrJlZEKCjp+YU3Szo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnhKueQbLvLFlOVbAKF4fAMLTrJ9y2MVbh3ZTlGGjZieWafAmxLiufGyyKFCIzqhJTDhlKmXxLl9BmcYKic3G2/CV24mXzoV8aMnIvA+K3d8Tvwdjq5o3gbKi9GI77zdWuKqX2v9adEXLKoO4QRLu07hMpgPwcYruSb/2aZeFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdWs45Wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBAC2BCB0;
	Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363308;
	bh=69yqMworEtYuoPL9Me1tURG4VPrJlZEKCjp+YU3Szo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RdWs45WbTddzozbd2zRFzyBoXD1lvq1YB95lIy/HcqWPsiSrm5gnADXx3NlyX3q+n
	 ynkzOqTUQCu989sUO2fiU1W34NYXCcWXriiRjLtKCXclhqfec3l/zTz3GozFngAEaT
	 sIJupz9A1IUkVhEn6eNux3nGpkMvOTrm6RILLCnYV++iD8mCtt1ocFObNkBQHw+Dwf
	 vpZopbZ+ax8f9eUa3CTVQOd3UUXbyxBMrhlrcjmLR0bmqPNPH4z4NjbmEeUotZHtRD
	 WPWMZXvjuLKP/NrGvxg4YKmCyILB28939RtyfLw2UsuOkqCKZJvOEGaGg1C5oVxLhR
	 wT2XuLxpma93A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:50 -0700
Subject: [PATCH pynfs v2 18/25] server41tests: test DELEGRETURN stops
 notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-18-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=69yqMworEtYuoPL9Me1tURG4VPrJlZEKCjp+YU3Szo4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScixN4yuKWUECxbWJS6Y1mb7RdXu+obmV3xl
 9JamP68LkyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIgAKCRAADmhBGVaC
 FWhVD/4mOdzTxlmcRhCG4pmNoikrh1E+33L9hFfmCbGs/LmLr2fuYqJYQyyDucH6H6cD0UqB7S5
 isKSqIdPDNDqUREe8kGWApKKmE1PvEZoctlEUs4R1UV7vkPlOrbd4GX+Gxu7EfqVasoL4KLBGW8
 s1RtXTcG/MXyZa/nQAUBHj3fa8a9R0XT6Pmaft0ErzPbUJ40h/YVBTT2MSkq6MRrbLKdaUdBRbB
 8jGlLwB9uhi/x8eh5xVr8IqxVDxNvWnmP9WVqlCXmyTEIXTf2LSJDVffOzwX8t90CvPLoqAqomA
 TVrYQn+BJegUkIZyJyMVVvxkUDENpniWXWa90UsLPWWDnf2twaxVOjqeDo5vkpcIwB6eYIlch6g
 564w0IxHIX7qAm2uAU+7+yn3XnlL1DSXGxCCSwQAS9SMP6zIjoN5NTCW8j7MVxfEGbKlAPv5UuV
 ryQ/iyn58PfjOJBKuWFfBzABAAru/y2MRZiHo+uQeT1MGNyu/DulRgH273Un+2e+9zxQExwOcLs
 eIQQm9dtL1CSrYPP76pBKgs+P6FIU/5MFUOVHyKD6lMYiW+/ZNX9s3i1oSK5f/RtMGR9KfTWtcM
 /7KIHaaCgSY/rwgFKz0b19Evo1ioNJt8ne9uLekCtKFY1ViznpNJpz6BafqZLznYoA6q3F0bYbC
 cTHxKgGFYMI4hiA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20920-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12BFE413AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get a dir delegation with ADD_ENTRY notifications, immediately
return it with DELEGRETURN, then create a file from a second
client. Verify no callbacks are received after the delegation
was returned.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 282fbbb9e09c..376c49c71d7e 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -605,3 +605,41 @@ def testDirDelegMkdir(t, env):
         fail("Expected ADD notification, got %d" % evt_type)
     if evt.nad_new_entry.ne_file != env.testname(t):
         fail("Wrong directory name in ADD notification")
+
+def testDirDelegReturnStopsNotify(t, env):
+    """Verify DELEGRETURN stops notifications
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG15
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Immediately return the delegation
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)
+
+    # Now create a file from a second client
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim) ]
+    res = sess2.compound(open_op)
+    check(res)
+
+    # Wait briefly -- should NOT get any callback
+    completed = cb.wait(2)
+
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    if cb.got_notify or cb.got_recall:
+        fail("Received callback after DELEGRETURN")

-- 
2.53.0



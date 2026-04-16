Return-Path: <linux-nfs+bounces-20918-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EXkElkn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20918-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1E413A44
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17C923033554
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863D33262A;
	Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDN3Nbak"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63752332616
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363307; cv=none; b=cpGKbX0jVXazTzHU/wfEUhnknyYFVT66W+DLs0zR9tm4VKBx+fKlzpcVR4MNwXQ/DX2KCdbgyAnTpXj7soAluwlw0bS3N+KWfBbftYsajr8CoZk0f0zSAq9fM9u6QzER8zkwmy1DuUcazEGPDzw1+g9vOMvDo1AWPg6YmQKqXCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363307; c=relaxed/simple;
	bh=p+lxxOukPHiVh34qvcLdXL5SjRMo+YKuJ/p0q0aHK2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4iXAyUgiHOPILrXZaw1q+3ubuWS9cfSxhp6EArATYNpl0MSa+k+42JEnxEHpiR8iux08YeOULgPApMjT5fQbFTwZanKkqU3DD3XXBLRH4zzsaEUvaOYReguDl8FKg7SiY442prRtzpB9f6hyBgKFFIWLeLfDhUmisR+P3YkZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDN3Nbak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CA4C2BCB5;
	Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363307;
	bh=p+lxxOukPHiVh34qvcLdXL5SjRMo+YKuJ/p0q0aHK2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DDN3NbakQQzAQy3eKKRDaCRDPlqvDwebjbKkwa0LxWV5nG4PSJK72hsBeADDug7za
	 vuyNdmlwDaQdI+rIGlz7/5lCOdGezQvFFnSTyFRcuopjDkkrJcuToR4jNS1PJuFEG4
	 Z81GfI6SJBAX9H0ZpoTwo8iyTJg6xr5lnJKeUPwYoVvynrpZV6QoVxHhc9/MsxxxYh
	 sMY1OXb36u97HF373QaSAcmymzkyXoMeuYIcbqxuatSgGZqlOXRF1WCAIiSHhbxurW
	 VClVIeQCYR3dAtg/ynxzuTHSmJd6LfJuvPUhJXY7lMFkIqYqIKZFUxa3C3k9e6NuuI
	 m+7ZyNal9hqAQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:48 -0700
Subject: [PATCH pynfs v2 16/25] server41tests: test CHANGE_DIR_ATTRS
 notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-16-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2779; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=p+lxxOukPHiVh34qvcLdXL5SjRMo+YKuJ/p0q0aHK2c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4SchBEWdJ/oeWgUwLNO1AsLQYlPXo80BMPDiS
 R5tymbkE9WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIQAKCRAADmhBGVaC
 FdwOEADOIK4HcfxGvZYIAiPBHIS+W6RkEHpeHwFXn19F9q+ecCTsVwJw5msSaApwZPWnRIkpBIY
 z91AluOhLg1ilb6geKvDT3B+QupKAmfZSVtTnjIt57irVem5h2WAIRjuQS3XZXbyAyvWctAAK4T
 lYasc2e9V+g87s3bf7+OM5UGigaGBLhR4Px0RpmIlcaGoGmpahH7fMgQmJP4hNgbAYVkmPVYNZG
 ze6+zZ2GT0Y5kDCNGfSVsnTzGpz5NehogLnxk+vSKxS8C3bBwqiIZXe9SUjTwFTnlyl8MWXquHK
 +qwyacj+GbfHIPQ516+cdUtXFwtZTwNo6p2KYYJIPQpgrKGI+LD+VBO/uAJ8Cte8YuBcnvqqoyQ
 y4o7DFECG4mtHmygl8wU5+ocfbxLNbGFWCPdXI1Nfti+w9mVmjxWYvIEg/Ih5yBI0QTwKOkHyOc
 xvcmc4TOj5+7XfySPZP+kQ7XH4xPKBxg90s7OByXQ/TK+Mw799P+iZBfAIf6CfgWdtv6FASudK8
 x6Uw+wno60c8M6z4vUq2oMiz7bawvDj9nX44QzZEp87Q89YYEjp1noxGdGHzAstSao4jTpS8B5C
 hdNG+akp6LNwFTumxOOB0Q5gxLzG7Jukb2seu9VJxqRiKoDdctKjOLxaevpSJ81bIVa7fotggZb
 RR3T6tjln2lgz7A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20918-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45A1E413A44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with CHANGE_DIR_ATTRS and ADD_ENTRY
notifications. Create a file from a second client. Verify the
server sends a CHANGE_DIR_ATTRS notification with directory
attributes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index b5b81b3e509e..e4d922be9d2c 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -522,3 +522,53 @@ def testDirDelegChildAttrs(t, env):
     attr_dict = nfs4lib.fattr2dict(attrs)
     if FATTR4_SIZE in attr_dict and attr_dict[FATTR4_SIZE] != 0:
         fail("Expected size 0 for new file, got %d" % attr_dict[FATTR4_SIZE])
+
+def testDirDelegDirAttrs(t, env):
+    """Verify CHANGE_DIR_ATTRS notification on directory change
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG13
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_CHANGE_DIR_ATTRS,
+                                      NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess2.compound(open_op)
+    check(res)
+
+    completed = cb.wait(2)
+
+    delegreturn_op = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(delegreturn_op)
+    check(res)
+
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")
+
+    # Look for a CHANGE_DIR_ATTRS event among the changes
+    found_dir_attrs = False
+    for change in cb.changes:
+        evt_type, evt = decode_notify_event(change)
+        if evt_type == NOTIFY4_CHANGE_DIR_ATTRS:
+            found_dir_attrs = True
+            attrs = evt.na_changed_entry.ne_attrs
+            if not any(attrs.attrmask):
+                fail("No directory attributes in CHANGE_DIR_ATTRS notification")
+            break
+
+    if not found_dir_attrs:
+        fail("No CHANGE_DIR_ATTRS notification found")

-- 
2.53.0



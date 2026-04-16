Return-Path: <linux-nfs+bounces-20917-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPMDBVcn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20917-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E41413A3D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D93F03033489
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFDB2773CA;
	Thu, 16 Apr 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8UKyFYh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893033554B
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363307; cv=none; b=RMG0K0cnmF0cz7+u1DKWlU7fgPL0X8EwBvkFrAf2dweFTBfPm1Itq7FXRG8S+VeqcP270ndIjArSGTNmd73H7oIC2wmhlIKCrYdifqccb5Swp8c2ByWUZfd2Wd1v9UGvMUpPqr/jd+2KtSxRAfg64l6isspidmf9jjinhCRhSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363307; c=relaxed/simple;
	bh=z0YxhM5SYTH5Df9VZ4di1cMSLemdEqyYtm2UxLDN6wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWLfBaLTS1wu1Slfi7dL5+49pb5k5sQ+WZxBfgZCLu4LbQ5lj62B+LRVO8ey1TNp+A9P692xd0nfmWe6SEusivSydS/q+9+5A7TswzowLDlCh+LYSKhWbT54mc8Zu6cLRaRAXLbt+5PGxR/w7NVoPgBHqnxx7ZnUUkbvHpoBs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8UKyFYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96543C2BCAF;
	Thu, 16 Apr 2026 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363306;
	bh=z0YxhM5SYTH5Df9VZ4di1cMSLemdEqyYtm2UxLDN6wQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H8UKyFYhKX0iEXPvcGPgbS9Hnt5w2qLIlsGECLjClgDAB6lePt0PkcRmbp6bor4k7
	 1xjAWNBwsMkRgGiw2fymNW7b8jwUjWrVJ5LJynqkftQjaKKvCg+DU+y9F6D6N6zXBZ
	 jxZdrpNtvqQB/r5fZYVFYqc4YwD8T3BEuguFeTANyeUSwW9YPCL+Aw3xh66/o1umVn
	 39t9bA3gKYI4enFH/Wk8Hp3YGc9mDULXaWeNRKVQ4RcOPChpE2wLo4ZafGgYLVZiNA
	 e3xyL+RlVUcGAe27uoIgN5KISoA3Q9y4aE/vNWbOROYIUcI9C/26dcnTB9QxCBZevl
	 QzdXyOshE1H2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:47 -0700
Subject: [PATCH pynfs v2 15/25] server41tests: verify child attributes in
 ADD notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-15-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=z0YxhM5SYTH5Df9VZ4di1cMSLemdEqyYtm2UxLDN6wQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4Schvlq1fPSfRdvULG+2mg3fFAXzDxQF2CDOJ
 p44TGqAaSWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIQAKCRAADmhBGVaC
 FagyD/0W92/RqSe8C4W39QSVMB1x/yuwn/v5vMRTVkBuc6HbZX3OJi5M9m3RRkfO9xzWxQijmxq
 M+yRVkpEKtymdbLpjJfPIiooT0xjo0xgzSnTPHiVLQy13gkb63v6FUYyz2bJWGlCW9N17LoSY8/
 aRJQF1B1f82PKsT5vNFK4QCLOGYLhntSABZi4fd/CXZxIvlbWlnwS60YWMzXmWBH/KgP/LrDClT
 vfZTeUpOV2dXQ/I7imGF7u46QZLR9mI97/kYspeFptKC5JV5CgUKnPlFz78AhYS835bVtH5ZRqb
 XurL6kVksiUT8reMi2KGpnHD1CO9/3gTHCqpCScEHEbH2PfgNCnQBtF40Ed+Fq4NO3zNZvkt/qD
 LrFe8hNiu+EDLRUdN56vy+fzbJqUeW/b1zU5jdkFCz3nY9e0F4IfrSLaxvayoKhBg3MmPRSVXB3
 6HJ2onz/lnoqNpKo4yWsgZBT31Jy314R6p+Llg84neZvS1G0De47wNRCxMxmzmRirR6HjxK6Ipe
 596Ex1oeetwuOq+gA5Bzf8n43uwf3XPG4a+TY5gVW1oEfL4lbbzMfHJmasIPLCFg/OFJfJusrZX
 iJbhLjidy/nfBWdqAyXr3JgidJ1qHVSPDU1mkRWPoCgUXCc3VlYMYtEfaNG3Zh+Ov5XGtwHHK1y
 0FifhjWm4Puz/RQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20917-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55E41413A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with ADD_ENTRY notifications. Create a file
from a second client. Verify the ADD notification includes child
attributes with a correct size.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 2c1cb846cb4b..b5b81b3e509e 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -475,3 +475,50 @@ def testDirDelegRename(t, env):
         fail("Expected RENAME notification, got %d" % evt_type)
     if evt.nrn_old_entry.nrm_old_entry.ne_file != env.testname(t):
         fail("Wrong old entry name in RENAME notification")
+
+def testDirDelegChildAttrs(t, env):
+    """Verify child attributes are present in ADD notification
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG12
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
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
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_ADD_ENTRY:
+        fail("Expected ADD notification, got %d" % evt_type)
+
+    attrs = evt.nad_new_entry.ne_attrs
+    if not any(attrs.attrmask):
+        fail("No child attributes in ADD notification")
+    attrs.attrmask = bitmap4_to_int(attrs.attrmask)
+    attr_dict = nfs4lib.fattr2dict(attrs)
+    if FATTR4_SIZE in attr_dict and attr_dict[FATTR4_SIZE] != 0:
+        fail("Expected size 0 for new file, got %d" % attr_dict[FATTR4_SIZE])

-- 
2.53.0



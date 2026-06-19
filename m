Return-Path: <linux-nfs+bounces-22711-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EwZrETSXNWrG0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22711-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD06A77FF
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CYpwGiqy;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22711-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22711-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9664B307A0C5
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5749345751;
	Fri, 19 Jun 2026 19:23:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6B347BD7
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896982; cv=none; b=BEm2wwglQoUPg+1fm36lnHMIauVjx/1Wsz8fhMb6k/hb32fpYt0x0ofp9W12YkLJvS2fG5qJhNt0t11HTYGFz2olhmGXSTQVlgAh0l0lky5jZsPjlUHBMuXFhmk3LuyqFjCR/2p74Sx5smo7DpdP0Km2Ff7R26vQaX6JE8RFgRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896982; c=relaxed/simple;
	bh=RbtajG/WZG8CKZYfodNUheLiBp63+C8qreMDFJOqKE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bcq9l5VMrBxO+zla57APkrrJ2aLUU2wMuOVa5J25ozP0SJl3dWI47Ms8h54DYk0Lqq0nSQNZ+aJxmznUhpGZSqSq1IGpZaJzD7khx3lNofHtevS/DnwHze9Pg3jRbZExPWgmV27xNI7XlZoQFiKZ60RcHeCAhDTtULoo6Z57SMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYpwGiqy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968E91F00A3E;
	Fri, 19 Jun 2026 19:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896977;
	bh=OojuOIHTCVCAVO0KKBEZXhl0Otwgdu89czd6BOVWJSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CYpwGiqyIHKPBV7eyd1sAXTQE+Lpl7EIcvkp5cTDpd6tboj2KpbfaTyIOoTw16f3H
	 ZurPxX+dxkB+VBWi3n0qKmVIo4sBPaHWF/dpL5SRnZgzh0JGcNk+/r+bweVt/3/3tf
	 WPYpmHvUk1GLbNIMosMmXWcpx4b8HJZv+6CACAkSDlmjGwDq2E6s4s8jH1MfbUMlu1
	 zmT4bCI1JcVBvGDJpHmYpemC61OaQm6tv+DfStikXLd71jtN+Zj5dTrRu3s5BzgJ1E
	 QW2OC3YFTDlFayXv/KXFzaTQUMxPAVmjCGtBG21t+FG8WR/H5ggS1XsE6mwNL/x4eV
	 wmaLGtGdAE32g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:34 -0400
Subject: [PATCH pynfs v3 15/26] server41tests: verify child attributes in
 ADD notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-15-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2820; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RbtajG/WZG8CKZYfodNUheLiBp63+C8qreMDFJOqKE4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb7sJn85WhpVfloD94xYQT2N98cPobDZwU66
 fC8jhMH8TeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+wAKCRAADmhBGVaC
 FeILEACRoCmnWwPKZXD754fSrfinJPCGLtXE6k4FXlAge+apw/ply95le6nL8JyMdiVhHbOVeCb
 He/zzUAx2hz5bFI2kcenhQj6B9UJRx9Pj/5cHH31Q9Qyt64sigWe2p5rmyzdxRBPe0TDj6FCQGl
 VCwpG8dq/Afp7V7rHY+orA1NP4yWpxaE4zeyxvJIv3rtFiQJykks3gxhEkPa8ZidQn6qFZe+bIH
 4ChQQPMkMjS9HCnRkD5jZS6w6NsRYJYGWu52uAiAkTyMiarJ2Bfbp8QR9KULbelVXmm1o33HG1o
 OME2psi8ntLiQCCX30B8OW50O7zlUcY0R0PyiOLwu3VIL5XIF/buL2Z2qQhr51neRuYdkxOCJ6V
 4YsH5aiCt16w4JtqUxJzcnBvIO0V5OMrw/72lsU20f+9chCkCXfijyy7Ke6kO1ui3CzcgQGVVnE
 mrC1+PeEWkndaPwAAmr0XomN+kLc7fj/EUsGnn76B+4yf35AtDWfRmd2/hD0Bci/J9oXdk4cL/B
 Q96LGieqwwCSRtv1d5A/h68Ai7qnkBz61DOKilgxCE0d1E5KT6o+NK6LPAIq1vLZaJ22bEPglru
 4t68++1dT/cSJ2eOGHPQZqNaZQHxzMjYhi2NzpqgXIzRM+vYMnpi8/7Z2ZnwY730X3HmDbtvUAK
 3OgB51ZYsKmcRCw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22711-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BFD06A77FF

Request a dir delegation with ADD_ENTRY notifications. Create a file
from a second client. Verify the ADD notification includes child
attributes with a correct size.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 00d74b2c7300..a12fa13878e4 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -507,3 +507,54 @@ def testDirDelegRename(t, env):
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
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+
+    completed = cb.wait(2)
+
+    delegreturn_op = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(delegreturn_op)
+    check(res)
+
+    close_file(sess2, file_fh, stateid=open_stateid)
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
2.54.0



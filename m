Return-Path: <linux-nfs+bounces-22713-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +4D6LzmXNWrH0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22713-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580426A7802
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hB3u70Jb;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22713-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22713-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E3130892D2
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC633F5AC;
	Fri, 19 Jun 2026 19:23:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA222345753
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896985; cv=none; b=YvRV+MLrDUhiyc+T/MLaeBXxF/DoUuJdW3BpBXUm+i6hNVBs7xFt0NlT5akljcyFJQlGznLbhTb19byCQO37hAZdc4uYK1KBJOtF0oVxWPlHA6RO9HXiu0pGhdYX67962B6R5zZEaqGrptFgkd0c4/wQw5yqZhCh8VdC25UKZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896985; c=relaxed/simple;
	bh=mOpwBuXIVP73hoaPnwaHpf9wrAFu9kPas9EoFF8Wx4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbcCYCCA5Ti5aTSU7OAN7XjikfPZQT41aVi2nlFOGsKTwUUvK0SX8bQ2Gmcu+LWN7xDNZnO5J2DYasmESnEocyMJN986N99hkTDQeGLHXj2I0kwDDE8FobAR6zon8apbppr91nS4l7AymfsRTVGulhhBw+EIKGmFEtZh/EMzHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB3u70Jb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A751F00AC4;
	Fri, 19 Jun 2026 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896979;
	bh=oGiWXwHaFxBZ1LhKxeSNQ+ubVNQUcPlBrSpPLe0DrWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hB3u70JbaIryAMXVxWKkg8R8Uu3Ok+3Jux0AqAiPaGRO9+iAQi/hiPeJi6UCD8RcH
	 7IuEAV74UKqjGc7lLTOX7OE5xcfFmhvs0wKXssNlLKQo3qXsV7OO5QwEFQiF35Llh0
	 RmA1d6kPFtG4ErDZuijFGERq+KarlYa+eZuSKFsqcRWl04uCZk3ePzjIkioOgyN8hj
	 zG9/+VA8F2P/XP2xdkjwTio8TAgMEL54kYspR9/4xZsFfF+PNJBKnJ120DkHHl+2KL
	 XGaSvaqRuirzA25gXx0P9qM+rV46CeJdOGEp1gGRRdJERESowzsnkkPI64yUxaM1Mx
	 DFORo6YJhvp7g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:36 -0400
Subject: [PATCH pynfs v3 17/26] server41tests: test mkdir triggers ADD
 notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-17-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mOpwBuXIVP73hoaPnwaHpf9wrAFu9kPas9EoFF8Wx4s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb8uLQv+IIG+0L6pXPXapztpANZ3M38eXitu
 upwdXdfs9yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/AAKCRAADmhBGVaC
 FajHEACCjHUUPjGJn9I17awKWu97ebaVYpwgVc5arbloy3zGsyo7X8BJhB2aA8d4TkLwgWTcq5h
 lU0AyUusZwe7LZ8KIa5AvIe00/+kAWsYmHBborlNezfcpt4Z+h6P99cPooUVXiTkSkMK3RbhcKf
 KXoAXwyzwQ9PPVJn57ZxnqCj1mGV3ac653SXQxVxZp/tEGmfyS0ZTjit7CPG8ckqS68lxWnE/yP
 JlSqAuLn1WldjZJ/GcBiH0roqoz2Ow7Gk/LM+wB0tg1jozDgMAmrMxux0lK+wI9vrBgRyWh7i6c
 Q2y9WtzTa5xqFODlgrZJQgdTBD4qzfQRlrFwqQgFo8WZkqu1q8RwNPeq7frRMlUiRkAD3N+u9GM
 c+D2NT1Saeg26CO5DFGn9RsdOQlnQa7wntb/2D4cjNQiiy4fkBvYYgyYJVEoOCoD2CAARj2EMU0
 NqgMheUHEPCUqvfGy+XjbAOOzvkV4SW/8itdBEVM51BWkWhwd0A0KzznONlsK4ufCD5ZO6uqMpC
 yapIbfAks5CtR60+K3PWkxYUL/UZHyMF38CDkpP+m0BVaFQtBd0nkxVH9XFp8tNoxYibK0wGeBd
 v22lDKn3trZ7iX+pY9h1JekgQ/3E/Eq8JxY4BcXZyVpK+naJD1D+9poRJVrD99ZsVmFeqpAo4hK
 cxrhP6T27vp9r/Q==
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
	TAGGED_FROM(0.00)[bounces-22713-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 580426A7802

Request a dir delegation with ADD_ENTRY notifications. Create a
subdirectory from a second client. Verify the server sends a
CB_NOTIFY with the correct ADD event.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 752fec3df185..ec4e2bc0e961 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -612,3 +612,36 @@ def testDirDelegDirAttrs(t, env):
 
     if not found_dir_attrs:
         fail("No CHANGE_DIR_ATTRS notification found")
+
+def testDirDelegMkdir(t, env):
+    """Verify mkdir triggers ADD notification
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG14
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    topdir = c.homedir + [t.code.encode('utf8')]
+    subdir = topdir + [env.testname(t)]
+    res = create_obj(sess2, subdir)
+    check(res)
+
+    completed = cb.wait(2)
+
+    delegreturn_op = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(delegreturn_op)
+    check(res)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")
+
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_ADD_ENTRY:
+        fail("Expected ADD notification, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != env.testname(t):
+        fail("Wrong directory name in ADD notification")

-- 
2.54.0



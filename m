Return-Path: <linux-nfs+bounces-22716-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pCS8KCOXNWq20gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22716-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AACF56A77DE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RT8EUW6v;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22716-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22716-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2EF3300F27A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC0348C55;
	Fri, 19 Jun 2026 19:23:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8A346FB0
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896987; cv=none; b=QXl65jWNDLPpkh6B7xO/9GZ18OWhcoolcd0SAMDGfEFRXsj8WKh+P+VKBuged635mIs2Z+7Vy8T3gWWLiQo4+fRqETe9K/9vGQsUhr9dBgcn6lGpgDV3dz+4HNH+MjK2A2qTqjzgKEfKqSY9M72uy/oKF9/BxYIbK8GVusNJia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896987; c=relaxed/simple;
	bh=4hfAXtRHZCfr3lLdFDl6xYQXgHeZ6VYOczYHNkEJCuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ByRbsuVp+lDFYNxmbeRNeU9plCr+XqrMP4bDvJltH7ZmmxrFRXe3u3RvCpDZabgfl2yiWrOcUaj09sMbwHqvjWo0gswYl6sK1ILOm4XpV/1N4f1sq9+rpsmSYauPYthwr8uTnryrSPGymU4o0MrVrq1A0QjuVxpHIsBbXew2ObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT8EUW6v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7D41F00A3E;
	Fri, 19 Jun 2026 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896984;
	bh=j83LE8hP/6fp2PgBu4D8cGizO6oj7UpInrGQwr9JA2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RT8EUW6vSLqiHnwfDiqa6/8FGqtfM6pVyXo/AZM3N/qvnDpivq65Z1/BlIkdxRQdQ
	 gMhK9Vw2ds3xd0Ymc54M4IAEdzsH1cIOlO/XwrvX+o+kD22U0E/FJsSpjnS0Qe91or
	 MVKcAPPS8HP0nCGOsXw52OouxeOLPojJLm4NN+1waPJSP/6vmvjZ7RZR4/FE0Updpj
	 Dpc96NiTFWnbLi2T0nF3a30XUOB2ElcyEtJutrGtgoYKO8UvR1CHTdcul+fLTDpkv3
	 ppH8TXi2A8XTdgkWRRGnyP2lw0oyf4t64rI3C4SC1M5LhSgjHcXxDFCrgqA77+5RWx
	 DfxIqxgEHF8lA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:40 -0400
Subject: [PATCH pynfs v3 21/26] server41tests: test cross-directory rename
 ADD notification on target
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-21-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3237; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4hfAXtRHZCfr3lLdFDl6xYQXgHeZ6VYOczYHNkEJCuI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb95M3iWJrxaAueE2KKwSYoAom3T+51hbGu6
 t4X7imcx2mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/QAKCRAADmhBGVaC
 Fed5EACq26Zmh7rd4eGs/LY05aDqx8LYpm2DYETpcfEDuoAbYKCAJdAsFVB7C0DY9hi+PEkji2k
 dcqhg22o3ms/oqZP2bcSIY2tIUX9vzJ3zx5joHLU7IW04Hv/eRLvu0u9L9/Vyfe7dGTcv9r6Fpu
 r2wNBdw7iKbxKAvtmONMxgkXM2q1XD85KFlhq/z5ZFprQOmC+WlBaU6fF79xGrApnml6BRDTaVn
 +htM4qyvjFwRyFZtnoXxNdM6YZ3FAiO6os4CuxRe0WRTDyy6n1hDMJhNwbqBQazkROLR5FPBC1z
 eSLAs6cxwC/wLnR8evCCV0ZTwiYVJr3dOrogdLZ2644DpixyHrVHZGhNYstDYe5144IvM5/IFII
 hnwIgLh07lGxSZNcryiUUcgURzc3FIVXSxrsBZi5my566N9dPz/6O0p0HnXi2H/aoVfEbthD6LC
 i9vJb2IsGCJPfjyB5/DGMCwbSNZ+7EDUaDmTtA725ZFXKnqusAhd1rp8a2zAB9VWuW+uFBJvd8x
 kfvpmWy1wNU3JFfETUsgGn11VvBtZY5/xt9qgy3g3Yi4Q6GZCPeXxDdukESqwN7mRK2hFI3DnqX
 pfcXGNhnczRA/z7GmRsELUSIJpq3YTi5SHGYASHZqqBFihOwddq+SuTQgen6gXK1Rqswv9XM6wn
 GzvWHCsLg7yTRTw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22716-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AACF56A77DE

Verify that a cross-directory rename generates a NOTIFY4_ADD_ENTRY
notification on the target directory's delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 0751cf1ec47e..43e9ce4cb4d2 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -795,3 +795,63 @@ def testDirDelegCrossRename(t, env):
         fail("Expected REMOVE notification for cross-dir rename, got %d" % evt_type)
     if evt.nrm_old_entry.ne_file != env.testname(t):
         fail("Wrong entry name in REMOVE notification")
+
+def testDirDelegCrossRenameTarget(t, env):
+    """Verify cross-directory rename generates ADD notification on target
+
+    Per RFC 8881bis Section 27.4.6, a rename across directories sends
+    a REMOVE notification to the source directory and an ADD notification
+    to the target directory.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG18
+    """
+    c = env.c1
+    cb = threading.Event()
+
+    # Create a source directory (not delegated) and a file in it
+    srcdir = c.homedir + [b"%s_src" % t.code.encode('utf8')]
+    sess1 = c.new_client_session(b"%s_1" % env.testname(t))
+    res = create_obj(sess1, srcdir)
+    check(res)
+
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    src_fh = res.resarray[-1].object
+    open_op = [ op.putfh(src_fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess1.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+    close_file(sess1, file_fh, stateid=open_stateid)
+
+    # Get a dir delegation on the target directory
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Rename the file into the delegated target directory from sess2
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    topdir = c.homedir + [t.code.encode('utf8')]
+    oldpath = srcdir + [env.testname(t)]
+    newpath = topdir + [env.testname(t)]
+    res = rename_obj(sess2, oldpath, newpath)
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
+        fail("Expected ADD notification for cross-dir rename target, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != env.testname(t):
+        fail("Wrong entry name in ADD notification")

-- 
2.54.0



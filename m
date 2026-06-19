Return-Path: <linux-nfs+bounces-22718-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /uWLFkaXNWrQ0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22718-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B28726A780A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IigF7grl;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22718-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22718-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96AE230AAD89
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565E3446A7;
	Fri, 19 Jun 2026 19:23:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032753451DA
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896989; cv=none; b=mVuHVZEZFAgZJph9PMWv81ZklsGNdBUuuFICcLyGOYdVP1t4t2HH/QYGsGN68y63R03F+CpjwiskkJiBe2SuXIfKRuSP53gQ7xvm+/VRTP/9xSUmlwXTucV1E6ZXjNW+Y2G9oqYKkXIWPfgK2GBatXZ1CavIciGUh7AIz3zgrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896989; c=relaxed/simple;
	bh=vwWJCFYnR3FOqOShcUo6IPuvyH1Oq4y0pHf3CeTfed0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0nElTD70WalPq0e8ZSz37hdudbLF0EUmLkDuNEn0ykWV5kur7ZlGLtk5QTP+0YPh/iUUtdxaUve+/jm2qTfap4YUyZLCGrtJs7ePjlG1PwtwaeyG71q7ODIRKlNpKWPtZ+DJO54IS/1K32s31aRCPbrCaWLwMx4tZsY8rR5SvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IigF7grl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F3E1F00ACA;
	Fri, 19 Jun 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896985;
	bh=7qT5k+9cs5ZBL/56OZWhBerJ8Da2BXynf6lxWPfSzE4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IigF7grl6D9y4Ckks97Ae1lt0OMlVDWGjUNP/rguQDnu94b/DocUJxOh3DOBI/Dky
	 z1VUoeUDHFTWqeXd/MeFxP+mX61k6muqY0DgKRRROU48LPemREehm4MGCiOUEPFFRu
	 OlYQU4V86rGO61L3H+EsMrLjvc0M2kzutUAvTgnVH93EwFaB/H5DrjXVM+fNyCa+yo
	 NxXN/VKVaW6DGOoL+f9s/SWbBisSiryt5iKy4h3dit5l0hu1c+OSxxno3IoatqiBAA
	 PM3aW5IgfKfMQWgoGkT5oShx/9xfbhnMo0liYy1VMK9ilNwTw9g2IGLrPCXL2zwcxc
	 DibJBXQWfQM+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:41 -0400
Subject: [PATCH pynfs v3 22/26] server41tests: test link triggers ADD
 notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-22-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vwWJCFYnR3FOqOShcUo6IPuvyH1Oq4y0pHf3CeTfed0=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGo1lv3IDAT/XrEY6Q5jFzB4tdYFAVYhYubKKDMuF2G9F5eqt
 4kCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJqNZb9AAoJEAAOaEEZVoIV98YP/3zi
 sPpRJqZN+qR+VAH4IeEMF8Zb/iJRfvEczAyyzpFqRG2/wOq/Cu7/7XTuiHURr3po8b4oCw8cKDs
 5uzJcVLsG3IJcM2csQZDy7VHsYdd39GxuAzvs3si1TBiVTLatQ6umNhuUbO3fjI7v3G5xwev6MG
 IVyxow5ISxNCKko9ffK3WoXIPVcf9P6sHfJEYmglYDfkJS9m1Y9FQjC+Tgn5z0Pa1UnGnV0kYMp
 wO39YQOoTAwLU3bLWqO1KA6x927CczZCC4J0TqJD/PTvU4pceK4ndQ0RexrA8j8bJBcPUaB1tOJ
 X9BITNzqp/TJQIiR4egHzCCll++Gyln5EKFScJNO9ttUElQxp3m0M3sKpDFuGC4wd2eWeDg2/ga
 qe35JBuMEbDwE94dV1N8GN8wbeeeRb3fkRv2/0QtyXKzbUBwHu/4MiWmrklazUDMCwQzs54vzvT
 PI7yrs2MPJNKnkK3H5d91hViudz+KvBPRay2fP06ERkqbEr9lum+dM/gVr6qd5s7kfZ6lAnobCV
 I/jDFvQxes1FOwJL7BsArKFU7rgpsyUP+fohle14Pf43IRm3RNYPci4BnrbTcC/JeCjHLSiut93
 x5oBcLjsTF4rmzZA9gMm0ELlmaWQHc/YnLjJ3c+6cE8ruORk3hMnsetovhoF/8eaACIJJ1tRcpx
 y32cE
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
	TAGGED_FROM(0.00)[bounces-22718-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: B28726A780A

Verify that creating a hard link triggers a NOTIFY4_ADD_ENTRY
notification on the directory's delegation.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 43e9ce4cb4d2..973ac5b8f934 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -855,3 +855,59 @@ def testDirDelegCrossRenameTarget(t, env):
         fail("Expected ADD notification for cross-dir rename target, got %d" % evt_type)
     if evt.nad_new_entry.ne_file != env.testname(t):
         fail("Wrong entry name in ADD notification")
+
+def testDirDelegLinkNotify(t, env):
+    """Verify hard link triggers ADD notification
+
+    Per RFC 8881bis Section 27.4.4, the server sends an ADD notification
+    when a hard link is being created to an existing file.
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG19
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Create a file in the delegated directory from sess1
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
+    # Clear the notification state from the create
+    cb.clear()
+    cb.got_notify = False
+
+    # Link the file to a new name from sess2
+    link_name = b"%s_link" % env.testname(t)
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    link_op = [ op.putfh(file_fh), op.savefh(),
+                op.putfh(fh),
+                op.link(link_name) ]
+    res = sess2.compound(link_op)
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
+        fail("Expected ADD notification for link, got %d" % evt_type)
+    if evt.nad_new_entry.ne_file != link_name:
+        fail("Wrong entry name in ADD notification")

-- 
2.54.0



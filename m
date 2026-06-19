Return-Path: <linux-nfs+bounces-22720-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DnbINCmXNWq80gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22720-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E30C6A77EF
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mG69qJbr;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22720-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22720-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D09E30185AC
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E2B345CCA;
	Fri, 19 Jun 2026 19:23:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD734389C
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:23:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896991; cv=none; b=GYzb0kb1/qaXEdWuDrbU26WPFgRR4ioOyelIke0ETIPS6kmjr63qxOJHuWsjba1APXGUxdmDnJI9cPTWCGQOe1j5c6ZOTqc4Q6vZCqS6hz1VV52viveNVNjdykYvJ3EltjSkkqQ7pz8XlvOfYep43UcThHnW7oeCOI32qsi+cA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896991; c=relaxed/simple;
	bh=SR5UKMt92mgGsJhGeW0XqmfqSNElnyHL5IXGUoHQmn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BMJLLdA/Vy/HdyVw/Y6mD/hyrtqzsJ9OXvYd7RaU0oT0DMEZCDrwsb8/1/PNzEwDUhYx6nIrGMRUPYJrYdaLZmMSJXDg/cP6Gkf7q0WpI8OPejkvwoUHSdFPWEU/sqJU/v3BjuDqbN+krL7DqiIKpqOWu617hMIXIrtH0JpGsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG69qJbr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E06A1F00ADB;
	Fri, 19 Jun 2026 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896981;
	bh=GqF2Jg08K/gF3kp5/Zly87rNTQTiElMChrPpDc4wkX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mG69qJbrGxQE0I77887mlZ2OuOKrogAOTBu+31f5lNv1GJiOfoFqUnpiQmN0b2oSO
	 k9+94O6RaOw7xYMHujF7/oL+vTDBIIxaI4xJih9OZmsJFlmCPPHPs4FoCtqWEoSWJY
	 pRPU3SigA7VOD7o75k+jxZLwGB6rcc8XJehlHVS/+ZpgQBdK8w3EOI4aQu/8Ik/gwN
	 7JscsqpQfmtvrhBFRwHbGnrTRglSi3r2WhIw7FCe1OxE+rAVkOP9Ci7R7dae4O3zD8
	 xH3blmcnpgSk6v5MfklNX/7DcgKUUR0nJAzTO3jkoeOrSrjqls/MljjndPco9jVLou
	 q++SdyRVYFYcA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:37 -0400
Subject: [PATCH pynfs v3 18/26] server41tests: test DELEGRETURN stops
 notifications
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-18-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SR5UKMt92mgGsJhGeW0XqmfqSNElnyHL5IXGUoHQmn0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb8bLUDG01QHlNemgn7rXmTwhVY1lLWnRJrX
 gpY2S60JvqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW/AAKCRAADmhBGVaC
 FRUWEACtI98v6b3cJ5f/K7qgukhnx2nrKo3jpFRJ1CT6sJm2ATAFuP8rLZVMoibp/bJ7ZrCJfYN
 knPnkKa1ZgiOwUCsEV/+wEXY0r1+9iIuAK+IXq4EhY9SdpEdRVm/N/0tHzfidp4RKrgjHK04ocZ
 mt/Nlht3xmzdZrrpDJoR69VY0fRQqPUVYw7rsdYFTkwRKwBZjTza/KVlKG4HsMIVH8b/wYPWG7q
 DG/2cVuHCLUtFf1ofSJt00aP/iaKrRTmaVJgKoMVjQj3GkxWMYlMca/6mVxfYrzSeuJVS5HcRTr
 KGAtORuITQ03Y28ZZWUKC84khJMLauwTbiseaOuYTklsjwHxCIhcKrRB7+P0zGJ1v9uFwBuSYdd
 lspH6nS1kOY+RyJeJ1d1r4w6lus+tQpfg7FKEoy2EJTZvk9E30ZBCi0u6DgNirVskCGjGsiG7OE
 FWrDY2Q7Loj+kIY4HlzD+Uw38sDTOSN/heZ6W8n3tOdoyxBV5YcGazhLvRkvxQEgKvE8V+r2M2i
 i/JTCtSaNWsIMpIW7MId1kju9TYAYe+pnxXDdD2zFEreniyGhw6pXTksDX82e2LC8TdccCLuwEs
 GxpiiRhmn7inadHZunqVgSyKKhYgKztcY8ipSIrDxBd/1EFGIj/21Ox7+tEx24MT4fSFATnCsEj
 mGoIOAzxoaEi+0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22720-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E30C6A77EF

Get a dir delegation with ADD_ENTRY notifications, immediately
return it with DELEGRETURN, then create a file from a second
client. Verify no callbacks are received after the delegation
was returned.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index ec4e2bc0e961..c4778da61dcd 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -645,3 +645,45 @@ def testDirDelegMkdir(t, env):
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
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess2.compound(open_op)
+    check(res)
+    open_stateid = res.resarray[-2].stateid
+    file_fh = res.resarray[-1].object
+
+    # Wait briefly -- should NOT get any callback
+    completed = cb.wait(2)
+
+    close_file(sess2, file_fh, stateid=open_stateid)
+
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    if cb.got_notify or cb.got_recall:
+        fail("Received callback after DELEGRETURN")

-- 
2.54.0



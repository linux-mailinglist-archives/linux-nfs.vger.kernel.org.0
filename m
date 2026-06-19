Return-Path: <linux-nfs+bounces-22707-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dSYNARmXNWqu0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22707-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C236A77CE
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:23:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MVYp3GTR;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22707-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22707-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D9FC30038CC
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6128F31F99E;
	Fri, 19 Jun 2026 19:22:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8233C195
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896978; cv=none; b=OqJnjZabvPgLJQpcMw8zA8CnSLgrdI4R1n3nZImPPijiyFrQ7JFFS6zPc9RMmj++F7Q0JC8dqBEVPLKtCCwC4F/6KAq6bWyHnCIN8Qa4cyg+/rcewVwq0sJPWklMzYi6aYJykts+dtZTe2JMyRyFUCjSBn5jy47HzOXyM3gE5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896978; c=relaxed/simple;
	bh=8kLQLSTPxUrpyCHkG9Wh3IBk45CuQ4h2biMWjl+3yZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lh3dj1WpESgc3HMTnoZin0xFpXCnxwvr6iDfPOOX8k0vWaaIkGsPQ5BgW9JaMCf+29OL8gJ/2Plj0WuDfVb+dM0gdo0Jb4CekM6hGcVXuuitrMX43io3MwF1bIRRqTEMAtTLrEt9h2KVO2YSAo5t9UVr4X0CCm3x8s7Biejzk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVYp3GTR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE07D1F00ADB;
	Fri, 19 Jun 2026 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896972;
	bh=7sAjOKN1TKssALnu25uAYIef+D2RUpGOCu7+XMeVXRY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MVYp3GTRxB2b1jyki2I+c3SZOuSqyXOk1/PJWn6avXcOYzfW/YG4f3/cXOIZRscar
	 sKBlQnWfQVHsLZRfYlsEvrPAPELGUKV6f5EzZUKj5Oe2IyOA+NQZVAyuLCeanRNNgy
	 0StzhZZ9HBjUnAscWvggO/1YaCRU34Cn0na9PjW46LER6D1G3/mqksSkf9j0BCmmmZ
	 L4jRo6zTxqmdq4r75BNz6nGuPAF5qb7V1sx3kONSRzaUhpd7a9UTWoTpTwwS14nABp
	 i9PKw62oKRmSYV0CELGqYb+cQW9CTWAbeJVIkRVi2TN1GjYqzt6r1BozDSLvMpn8zA
	 BhVC8n/t5Loeg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:30 -0400
Subject: [PATCH pynfs v3 11/26] server41tests: test unrequested
 notification type triggers recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-11-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2353; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=8kLQLSTPxUrpyCHkG9Wh3IBk45CuQ4h2biMWjl+3yZI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb6JHUf2rP5qK8VcEMv/OdGseNbcdNwj46B6
 89KVTPiQZmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+gAKCRAADmhBGVaC
 Fe1CD/4k7g4oNBi4P2wWRZSBjY18RjbYKZ1gTXNFhCCNnn8spOV85IKgsXtk6IqLlj4NSBOB2BW
 hHCB07a9etd6AAKUvrJIs/buwf4+9UmBfBVUMJkm8IQDBDcalJ2pspa9COZfP3xSbNfPdp79/YT
 jVXadVdAwfmZYIVKbZTDjUfp4kdeLVDpxtUnACUu7DY5vQLLCEp6H3UB0EDArrf7SfPFN6Lx6Ws
 U97mh/3FjJTtq5z06jDo3sHnp8z+o++syeCma/UbQy1QBM1D0WTerCffT0Y/x3PBkt4sr0bGjn/
 tF6r4N4fZLWy4SajdDs+DL6d0TcvqA0/3H1geySKRx5txjufgKT2UGlX8nKpIdScrlb4dsojVGw
 whLPzWmkP5CwUxK56c3aSeV3fxAFFGR+tXRSJxqj1VHO2IJgNuarfKqqn4M7qj0UvS0rwLA/ac3
 GhrzCSEgBzsJmgI5xEXpM0lqH3jpSHPYvqUPbBc+2GA+3n3xTTpIFvHfNVewdHHorcdd7Z0ywYw
 gP7wgL0NIWblRRCjqxx/IVkXLZBg8CQfs7tBspox/IBa/rdDmzEXLWIFDWydwMGa8wOmdlxzx3Z
 eH98iNWrn9d9d1stWhCgMDBf/EQhqGPLb3yr68Jv+IGc7E+YR9C+UBzB6edlnbeI+xoR/gjLvzS
 93pWey7HAg80d/g==
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
	TAGGED_FROM(0.00)[bounces-22707-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0C236A77CE

Request a dir delegation with only REMOVE notifications. Trigger
an ADD event from a second client. Verify the server issues a
CB_RECALL instead of CB_NOTIFY since ADD was not requested.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 4afcc40f515a..8fe2ba54fc67 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -315,3 +315,42 @@ def testDirDelegNoGflag(t, env):
         fail("Got CB_NOTIFY without GFLAG_EXTEND")
     if not cb.got_recall:
         fail("Expected CB_RECALL without GFLAG_EXTEND, but didn't get one")
+
+def testDirDelegFiltering(t, env):
+    """Verify unrequested notification type triggers recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG8
+    """
+    c = env.c1
+    cb = threading.Event()
+    # Only request REMOVE notifications
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_REMOVE_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    # Trigger an ADD event (not requested) from a second client
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    slot = sess2.compound_async(open_op)
+    completed = cb.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)
+
+    # Reap the async open and close any file it created
+    res = sess2.listen(slot)
+    if res.status == NFS4_OK:
+        open_stateid = res.resarray[-2].stateid
+        file_fh = res.resarray[-1].object
+        close_file(sess2, file_fh, stateid=open_stateid)
+
+    if not cb.got_recall:
+        fail("Expected CB_RECALL for unrequested notification type")

-- 
2.54.0



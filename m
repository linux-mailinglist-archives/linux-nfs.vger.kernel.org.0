Return-Path: <linux-nfs+bounces-22703-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bGBnBhGXNWqn0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22703-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B96776A77BD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Dp8J+75v;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22703-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22703-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 981353019172
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC163346784;
	Fri, 19 Jun 2026 19:22:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847133F5B8
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896973; cv=none; b=K6WHyp+++jLVaHtNGfFfNX/a/iI8d0wyHT73I3qu4cVIqLsscpatmhdf/iFItDTH5uWYHBVQSwJoY3LgavAt+5vz1UMc5LN+Teb8hjh5sZ0MhxWDVxT40kT743tR07F+ubKrrqUpINo6VKYyjICXYAhBWErQ0U08psGBhzFx2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896973; c=relaxed/simple;
	bh=cvqAoGDYrqi82bqzL5DmEvpP8S3c+BYtcI0pCjBq5Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iU73X3bGAMqM9NwmFdrNFLmV1+lL6oiTrKbTcmxqe3rg5xp4/irqnThFK3F6uGndYm/F8VqXNtxJTmUkJyxyAUR+4jp3DjwEo2cme82BgEzMG45XcsXO6lJhsm4kwdJUHE7Zus6BXQjQ9inAK0KV3/Hp1SxKV8z4mTIFNUlD/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp8J+75v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CA21F00A3E;
	Fri, 19 Jun 2026 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896964;
	bh=rcOwOEJU1oQaIi9Bi3Lj2n+mLHCh9CoA0q1Ot+vw2C0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dp8J+75vgN/Pu2Sc0fE2NchfBEK/kyJeMzZrShEjCeqS/8NPwxUciHYPVx++tQDJR
	 Qc11EudCsDZwb0rNXeArd7SySiTx3aNpTGsGU46HAdDrhX27UCQTCjyG5zy7NB1rdI
	 MCymGAIGWfh2H88iBA+LfSjgeUa7XwEGoC4uU8FUiFbuy0AIv4z/LJ0p5OilZh4YDJ
	 SCAu0yjxWeeOs14YZvr93qnNu/xqfrUejM/4bFBXDzYSFAMjB2Q9lEaxg76l4NvIW1
	 s/mvUOVixJQ6O4DOf2ASKhwV78IZlHLuJANyqYdvVVxMKYDjJ7lGwQZ39GOcYaLjsY
	 qTY308VRrznsA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:23 -0400
Subject: [PATCH pynfs v3 04/26] server41tests: add a test for duplicate
 GET_DIR_DELEGATION requests
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-4-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cvqAoGDYrqi82bqzL5DmEvpP8S3c+BYtcI0pCjBq5Sc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb5f5UpSvNzZ3NWDTllIJaUJx/esa+W8nzVj
 NyLnilg8IWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+QAKCRAADmhBGVaC
 FR2aEACJZLruxyTX+4UHLfg68SemIqcktN63ljSEwyPj+04Qy4oxerm7tGE0j+ZY0n39iL+vldo
 XMMOrosmydgdyTgLumNFQY7ITD1Yl54MBulZTc46ELyy9/Pv6NI6ddCq9IGf72paKVxlIC+Bwwl
 ZMexeaJhT2ZFOXnGKZvuJ54NWPcmfCTtrQMuFYle0WB+comY50tSXKR6wpgRhsOHjdv52GzyIf+
 Vrob3JhTFMd5uok6btNQsFnfWYjzuQPhfZi/0JVoT4aN7HPlams/usqCtVjpZgmoqXSinKNWSdj
 dPcPUHBa1ur0jorRSUCkTyM4Av8KuOmq00pNLhPPKt85vugYBtH0C45Rz0Q839Ir1mYXhI9Fw86
 /0H8fZdPS2UZFvWv9i/XejT9WetxfCe6/sz+GIzJ8QZaE1T1BDAQXCwmWA0SnrJ0m2ALcNZmxfG
 Dt5jFwjUtJyR1ZW48sIfoxqOAhTpgZ8/oCtSuBgXmuX6QByoo7+32y9vRc/ytteJeT3/X7CklJa
 dmPguS/HCeiDnK+AdKV/YKfUYS1m7LQWjC057DFyjxSIIbzgJiJDPjL3CIaVUpUpOaJ+kxfNZQC
 aQn0aeUg7p/7n2LS+tcVl9Cum0HvprNtTWDkf8jQqL1WyjtOr7M1D9oJvThVPf4uSZ25RWG3fWw
 rxOWTNzOhfN6lIg==
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
	TAGGED_FROM(0.00)[bounces-22703-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: B96776A77BD

---
 nfs4.1/server41tests/st_dir_deleg.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 99768389cfa8..f47d1f6ac053 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -107,3 +107,29 @@ def testDirDelegSimple(t, env):
         open_stateid = res.resarray[-2].stateid
         file_fh = res.resarray[-1].object
         close_file(sess2, file_fh, stateid=open_stateid)
+
+def testDirDelegDuplicate(t, env):
+    """Test that server returns GDD4_UNAVAIL on duplicate GDD4 request
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG2
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # get a dir deleg with no notifications
+    ops = [ op.putfh(fh), op.get_dir_delegation(False,
+                                                nfs4lib.list2bitmap([]),
+                                                zerotime, zerotime,
+                                                nfs4lib.list2bitmap([]),
+                                                nfs4lib.list2bitmap([]))]
+    res = sess1.compound(ops)
+    check(res)
+    nfstatus = res.resarray[-1].gddr_res_non_fatal4.gddrnf_status
+    if (nfstatus != GDD4_UNAVAIL):
+        fail("Server replied to duplicate request with %d" % nfstatus)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.54.0



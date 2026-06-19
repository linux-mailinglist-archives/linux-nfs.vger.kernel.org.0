Return-Path: <linux-nfs+bounces-22699-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JjfdJQuXNWqi0gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22699-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B76A77B0
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 21:22:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kGJpCPaO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22699-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22699-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7259300D178
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930B3469FA;
	Fri, 19 Jun 2026 19:22:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E782345CBF
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 19:22:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896969; cv=none; b=TPD+VxU+jUk+pnZWQZROJ8aGrQDz12DP3AwhXwoJ2ly1WKI82RwEmAhzg4HOmz3tkyhL9GKbZDyCe12TIqd2Rj8U32LWc42jPIFu/JwyBCXd/RP8c3bpCrYwfehAT8XuXpsDYQ4C9dQNm3NPv5h0lJjIrkDOimIjOrht+DA/qR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896969; c=relaxed/simple;
	bh=GExISphd7E0rAvfC1eos9tvRQAemQlo/NCkmDYsHfGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIU8qGuPPzU+w+oAiI/tdSt++DvnPi5EhtdUMR5FXB4adm834tcoKKeDEBehp7dZeZQ/C9Aw11oO+9LJAunhnqiPCn6rSxbBgwCIZn9W0ZWFX2c+0hBbYhDcoZi/ImTF2DngtFX47E11nRjquPc40sKE7b+mB/53Q/glvBpsO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGJpCPaO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A291F00ACA;
	Fri, 19 Jun 2026 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781896965;
	bh=EY6xmh+N1xxBGxZJWiD6wnDTCuWzIm23OrQGbn9aD5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kGJpCPaOR1up//ZiQnrNRDYS9HdeiHCghYsg1SVMX5j9eXIBuARjCpAtDnrBZtaWP
	 9awakdO4mA4/fp5G4DNPaMp2LWoJsbdq1jrCQDlC/ThCWrPb2vTx3pd/9Rj2p+C9/G
	 0+xAQCQzwVH+TWwmqZhC1RpfSROMPsWJKu8kLKLfsx+3sL1Iqel8UcIp2tA4oeYQlt
	 7zyHmMvb7vTGWBKoizvIMKKASc+neDai/cUBSM9aS0XpcwoR5h5LyZGkDRZDRSgamU
	 n+19NaU6F0Nd3quAO6JptP4y+f/eaGd6Rbif/iEyggkluyMzko38W3Xh043OGDmb8Z
	 l2EF8hCtqAJTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 15:22:24 -0400
Subject: [PATCH pynfs v3 05/26] server41tests: pass_warn() when server
 doesn't support dir delegations
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dir-deleg-v3-5-1077ce8aab1b@kernel.org>
References: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
In-Reply-To: <20260619-dir-deleg-v3-0-1077ce8aab1b@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Scott Mayhew <smayhew@redhat.com>, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GExISphd7E0rAvfC1eos9tvRQAemQlo/NCkmDYsHfGE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNZb5SAB9+o0TK4CcIyxBfWVj5chMPS/BQtMiv
 7J4BuIrHVaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajWW+QAKCRAADmhBGVaC
 Ff+nEAClDg+wcDhbCQFG9j6mzpzQaYQ2JQPqUSj06wfh9S0JiVrSKHFKsmwgUtsBbmzax2PYJtp
 nw0D1wFc57pYri1+wR1kZYnMZk54Nh1/+ADZ3h8vWk4a4lnnM0HRk2QyPz/YTkG5aLqJjEoZni3
 nTXU5j+XEKjn/jhyblQwnRECMyu+x3A4QPUTBRQfQa8o2/2Z8Z/9gutd7qcF/nFGqNdrun0epHt
 M1ymbW0KcISzmJbf6BntuV8LLTEyFHKNgvTyALjFv9c7B0yezMrA2ffUyxtRIM52KBJlH7Qgy71
 XY9RUclBQQPDsGaQJQihKe/ASJJ+cTxFaOiMLUM5wooi47KpkjwZ6tza6eASIgnC90DqG8Ok/zT
 cfaUavweF/7AC3LctuTBn+N7LIMoemDQav5Bm5OdpVDh0ZDrxtBQa16fDBVJX1UtCeazYwTGDBC
 hrdiuRt17gn6Jn5SCQa3Zc8XzjnL1EtMsW0YKOvvrcNkjXy+BZ1g0aW4wRnf90Een1S4d/2H5+l
 yDC2QzYx0b6CrklaMx3djQu3opH3cTVa2bGB2jtK18sRj30u0mbUnxfi19CeXlHUB+8/ZiuEkpJ
 Hdp4vex3+WaYIow9P8h0sQ7u4KLlygGvRB78+UbqlFtgFjRzvIuUtKgbFEIA1iXaJ5/+tbdmpFW
 pJOtLEEwYcmxUHQ==
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
	TAGGED_FROM(0.00)[bounces-22699-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB5B76A77B0

Instead of just failing the test when GET_DIR_DELEGATION isn't supported
or the server doesn't hand out a directory delegation, have it pass with
a warning instead. This should make it safe to keep the directory
delegation tests in the "all" group.

Also, when receiving a directory delegation, vet that it got the
requested notifications. Just pass_warn() if it didn't.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index f47d1f6ac053..5f46c08316e3 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -65,14 +65,29 @@ def _getDirDeleg(t, env, notify_mask, cb):
     check(res)
     fh = res.resarray[-1].object
 
-    ops = [ op.putfh(fh), op.get_dir_delegation(False,
-                                                nfs4lib.list2bitmap(notify_mask),
+    mask_bm = nfs4lib.list2bitmap(notify_mask)
+    ops = [ op.putfh(fh), op.get_dir_delegation(False, nfs4lib.list2bitmap(notify_mask),
                                                 zerotime, zerotime,
                                                 nfs4lib.list2bitmap([]),
                                                 nfs4lib.list2bitmap([]))]
     res = sess1.compound(ops)
-    check(res)
+    check(res, [NFS4_OK, NFS4ERR_NOTSUPP])
+    if (res.status == NFS4ERR_NOTSUPP):
+        t.pass_warn("Server doesn't support GET_DIR_DELEGATION")
+
+    nf = res.resarray[-1].gddr_res_non_fatal4
+    if nf.gddrnf_status == GDD4_UNAVAIL:
+        t.pass_warn("Server reported that delegation on new dir was unavailable.")
+    elif nf.gddrnf_status != GDD4_OK:
+        t.fail("Server returned unknown non-fatal status code.")
+
     deleg = res.resarray[-1].gddrnf_resok4.gddr_stateid
+    if NOTIFY4_GFLAG_EXTEND in notify_mask and \
+       nf.gddrnf_resok4.gddr_notification != mask_bm:
+        ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+        res = sess1.compound(ops)
+        t.pass_warn("Server didn't offer the necessary directory notifications for this test")
+
     return (sess1, fh, deleg)
 
 def testDirDelegSimple(t, env):

-- 
2.54.0



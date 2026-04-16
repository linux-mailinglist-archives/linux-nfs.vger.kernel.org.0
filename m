Return-Path: <linux-nfs+bounces-20911-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOeYBvIn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20911-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A78413AA6
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7817630FF3E8
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288B3358A7;
	Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZXlHp2P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56433262A
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363304; cv=none; b=a9Gl/7O/rPswFK348mrgUk0hdQZDYMjU5KlkK1jp9sd6DlrYZKYT1XgS3eGSJEURnY3BxSzidZX6E2v9xoQo32iwmIbt2f106ntZvlth9zHN9SWaWtA25Rr8kjbh9Ir1hOSWcuQFNEgCHP3Er5c4eSlB68MOwqOPP+rVWCxwg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363304; c=relaxed/simple;
	bh=dMSlyyMAvZnDk+k5ysQFwPnbLF6NNykKuZ0zrJxg7dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jhb5wJ2pn/4qdtDxNUmfsQj4yQs92OP2cNzqcAWQ/yAaDBGBQi5+Gwt3lB0ZBw6al2mOhTWdhc6wabCkq7bhBcRZ3klR0QvcrU6SjU8cjgY886uR8jK7NFZXTcOMnS/xSlzAR2aYYWROKtTkIFVKzvmVFIWahC69uyPRz/sUgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZXlHp2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C23C2BCAF;
	Thu, 16 Apr 2026 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363304;
	bh=dMSlyyMAvZnDk+k5ysQFwPnbLF6NNykKuZ0zrJxg7dw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CZXlHp2Pv+z7D4GFe7NOK3quS9Yz/4p6V92tCt73Yd/oaJSOo62z1olp7roTnVFH3
	 giSduiO077klWAwiSypWGCw8jqHg44fHqG0rFilOesr14+fOXlAKB7TDF7MaKuMZW4
	 RTmVE5DYCh/nW2BqHQceveEr/g2nlzemdL9iS37TqwjdcHbx6JnKbBORlx2JCtezZF
	 i5tO/QGNZBRVJ+O43zwtlTOrx9j+zF972DcFiwWql95z7vT7kmJweCkeO0p785FN4W
	 jgA/dk2r/hQ6gr9MBwYzuZtYfeCogqg/6yaIgGLXM+wUa6jpLb/M76nICdcZxsVOB0
	 +7bKInVNjrGAQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:41 -0700
Subject: [PATCH pynfs v2 09/25] server41tests: test link triggers dir
 delegation recall
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-9-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dMSlyyMAvZnDk+k5ysQFwPnbLF6NNykKuZ0zrJxg7dw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScgUhLuCNWsawt7EAKl4iLCaDKaYlnLQ31IJ
 CQMEfqNko+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIAAKCRAADmhBGVaC
 FVQ2D/9dt+YhBL/o4Hcqi2nS7gnxosPA727vxa3XN24RMll7E4/XZsFM4vroSL9sjUOBs2dhOUJ
 rC4ZEDydA5LeccmNJH3g7eLF+x2j6YwCWZRBpzb0yJrSGRgSvIJnoEhtYZ+gcs/MXIOeJuc0TFU
 QW8XmVxZ5bltG/eMaS62B/RsG00YabH+GEA7kZv+JvDHnCs/e/BOBFDoor+tICFqgzsorDUu38V
 NMU/ZJdnYHJd1OGC9rhCtelFiMbmXN/xlBgfDUAaNI3YJgyMY8J0kCtD95bqFEiPJvuzF6/InDM
 nEG/6rn8dsxt3A6LOepy5dE/r50psgMaAuPL4F0frOnqLjscDWBVNAus6286geB9TJ/zOMR4pQ4
 UezHjal/bExztyGleYM4wjQzPgo2jOKQiOJ2bNIioJTyYdvS01cWli4bdSUHNHywLnNabqnszHb
 yGqiiGgW9P8/2bsM2QQy3zZfznzB38R2RHmpSfNiml6deHVePrAQlzC3+xi3cyTx/EAzzVTmvXc
 pwmZ5eafvqKRmMPRGnd/M4rFYAAxiep9FwMX64ga7mGaD2uQnD7kjH1X412oYWyUb75fZmopDsO
 TlLjSPMLF1FAcnOwW8eKW7xQbMrY/YdMFOQFgNCT1YjI9isnzuaZI0Zo3wMD7MpJnZOrbxks6L6
 IFBQe6IAlxWDIkA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20911-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96A78413AA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Get a dir delegation with no notification mask, create a file, then
hard-link it to a new name from a second client. Verify that the
server issues a CB_RECALL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 4c483950fd4a..808323b89ffa 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -231,3 +231,39 @@ def testDirDelegMkdirRecall(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
+
+def testDirDelegLinkRecall(t, env):
+    """Verify link triggers dir delegation recall
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG6
+    """
+    c = env.c1
+    recall = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env, [], recall)
+
+    # Create a file from sess1
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
+    # Link the file to a new name from sess2 -- should trigger recall
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    link_op = [ op.putfh(file_fh), op.savefh(),
+                op.putfh(fh),
+                op.link(b"%s_link" % env.testname(t)) ]
+    slot = sess2.compound_async(link_op)
+    completed = recall.wait(2)
+    env.sleep(.1)
+
+    ops = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(ops)
+    check(res)

-- 
2.53.0



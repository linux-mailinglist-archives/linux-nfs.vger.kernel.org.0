Return-Path: <linux-nfs+bounces-20906-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA3WJNMn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20906-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32921413A80
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFA6A30DF69A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A48334C1F;
	Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4RFUEAD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B43346B4
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363302; cv=none; b=S9S+mO3aptpypJE3eU5p3JbqtbbWxxpFC3lEHe0C+fIWV8wxRbBPzUK+H14/bF1eSo+oM5LfeDf4cA5EwCottQkCsGKg3p9Mqsb6a9Go1QKSmaMNcHxwrydOV9HhD7etgtV2SJLYHOw0beFO/ZzGIXsmHhhgnIrD8tNYKLfZ+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363302; c=relaxed/simple;
	bh=avxjDdkHKwHde1qZoTgbC1HVwR/1oYCOUsB1ltqH234=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcEPA99zjGST0t0b7eetqqy2A7RFsq2Lvt/9oBbFW73jxJ9NLrgXUQQfuh5feWKfndX6MTRD9/jaQjgrR6YYQssxKZzXwsY9kYTa8lcaKTtvkfv6yRA9XZ+QXBxt4KKp8Yr1JWkr/zS5RuXsvBoJnfiHT5OIXo0wSMoP87o+gUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4RFUEAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC31C2BCB8;
	Thu, 16 Apr 2026 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363302;
	bh=avxjDdkHKwHde1qZoTgbC1HVwR/1oYCOUsB1ltqH234=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L4RFUEADZgBJIb6ntGcb9ojuNfTQDZS1lnc3OAN3I6AH03/lDNteIfwaJQ15ITYeG
	 PszcpNp84mS2s0f64Jhb0T1s/pNDVKfU6se07vhg50hd5ZTZkSrr6kCXNCrEQk7Ynr
	 BRKDzVzuuo6tXGJ9TQ0pEKYvUECyPaCMKwDLAk3sc/4vLtdTeQPsxtq6Z5Hb/Xck+a
	 3MmQSPEkh5oooIRTfEUvukSTnbFeISm5G/UiPICaTLJIkElgA/nw2E8rOXlGPpklV1
	 vOjXZO5NsTtLnIVVBOxu1qN7tFDvS9jxr2NOR2vJlB6FtEQPRgKmH0ym8UCQanGUsi
	 xbo/lqDHWrM0w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:36 -0700
Subject: [PATCH pynfs v2 04/25] server41tests: add a test for duplicate
 GET_DIR_DELEGATION requests
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-4-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=avxjDdkHKwHde1qZoTgbC1HVwR/1oYCOUsB1ltqH234=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4ScfCRJuqnF7pppEzkXI1sUah5lBs9qX4fkaz
 wwCQxjOCc6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnHwAKCRAADmhBGVaC
 FS3GD/9VobAYxXOBNP2nWUFxYapBgNzSTZBgiWwji7mB3lMxrDhz1I9fs8Izda1NjUsDN/1jTxw
 Q8DD8dnU4ll1YUle/tAv0OUsF5EAVSWtzEkcpd53AlsrGO/BmTe2gkjsXesj43zfwDlu08EdS4V
 XQHLO7rM1U//MZ8MJJn6seELEbdmy0XCORMEXQQgNB7LJ5K0kbvqObzO+TKTQqi6whbn1qsyOjU
 dJTrgcaVPa9mqV8bZQ2brc/UOso4YsBUIqNNq6MZfIAr2/+3fhuf8KL07E4Q79ZyKzsxNvTo6J1
 MPgJ363FhrXABWfWUmI/xuRvrLPGXFZWU8YdOFEuhHeiX427yR5nByEN9U0XyLfZaCn594PRAxU
 IRUbVoNbSoVCVc0usysOlvWAaGBWm/eU7Qe4J7lJyNtVskL7ttL0yHKtscyWB5WYN2VPX7IjG9b
 dGrTGZldNDl68nXaytjx6meAk4ul/9It0IN9arsVuYhlYiUIHTY80zbTctNF/mJl4Uq4iD7lAyO
 xqp31ouB10QeAjuYXytTLsMvjzS0LbdjTuEs80gfZMdL1vKkD+ctSO/SSrGymlZhNwv1tCXLIJp
 Oat0AUlFNip9YtIxVkW9HdakWDJf6DtbGyBM0I9PbczHVTHuY91vpENVx31jAWfNqBFbLUuJE87
 HJyquGEGlakgr8Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20906-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32921413A80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 nfs4.1/server41tests/st_dir_deleg.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index ab4387f0bd9b..e062cbe27bff 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -100,3 +100,29 @@ def testDirDelegSimple(t, env):
     ops = [ op.putfh(fh), op.delegreturn(deleg) ]
     res = sess1.compound(ops)
     check(res)
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
2.53.0



Return-Path: <linux-nfs+bounces-23220-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id spdvC3fyT2rVqwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23220-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC83734CAD
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:11:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gPpXmR7+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23220-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23220-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C36DF3071A59
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518A357D0A;
	Thu,  9 Jul 2026 19:02:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545B3B8D70
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jul 2026 19:02:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623773; cv=none; b=DA6SVcMatbm5GTatLX7G+mD3YbVR3HphnDP7Ul8hkuJNFXDuBngOhwQ2khyjpoUxzTEAV21lb+FC+Dwi9ZY69Pk4BD+qvxlFMcxU0abG//eO0cgR/G2DOMTTXP9J1JmXuY5SZwjxUM5cwB0v49tAsU+UwKHdDvyAJtt16fMUi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623773; c=relaxed/simple;
	bh=NMeuMhp4uDX/aOGqAKaNqGcea5wHgkkTLnf7XNrD9e8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHVdWJvnEgnGBibb+3nSPcJOXrsLIWQLgZmzFpn7yrPQzo/LCEGpW7juwGdZyjwFBIrVm/5gB9l0ZvjoAcEa2r7U+UsDN/Kee3dG6wvZNI1wsu/VyNgBL/nxay1j+P0Hw33P/SDt0ujaKGYhR+d89MkhtMDXk2LxdKtDZERddIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPpXmR7+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B801F00ACF;
	Thu,  9 Jul 2026 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623772;
	bh=59BGDAKin2LKHF4u/T6X+jdBF+rSmeCIpiMXGwhOva4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gPpXmR7+eP5kBK2pRJoCBY5JB2jqawbtV3+9+zS91f+Jq0SCik8vzBpLTmMwx3Sxj
	 FBuVKaoYr14Dpm2nKKG0Qyfts8BHbdKzHP/4v/yI/FTwHrRUhw9N137g7BRPoGd+CI
	 BeZ5oJuuFeAghUwWT9jONDUUllMLARdJMsZf5EG0Y6PW2kePw19dT5SnKsrd6q0xs4
	 oQu/vP3+1cHnM2gpbf5gyTOeih+Y4Ai2UD5Zw/Ux2bD3PSqMvm+trbAKW+cLOZjFyX
	 sFai3pWGCq3/HGk6QXNKAggrGfwuzqMnCCvaEfDrjRsYKtDyzc694gt3WrImSlmBxw
	 InybBrAay51Lw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 15:02:35 -0400
Subject: [PATCH pynfs 07/13] server41tests: test COPY with bad destination
 stateid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-copy-v1-7-849bf581d7cb@kernel.org>
References: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
In-Reply-To: <20260709-copy-v1-0-849bf581d7cb@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NMeuMhp4uDX/aOGqAKaNqGcea5wHgkkTLnf7XNrD9e8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT/BTT2Hb+Ns40/arxv9F91FSGoJxowwmhCHdv
 OZdVjx85UeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/wUwAKCRAADmhBGVaC
 FVS/EACcAETKBeKURMJtkbiGu2oTyFJ3S3Fo8VQg72LQthPSbF0itzTtebLAnnuEXhyva2oLUnH
 qhTPnCv9BxHf7B9wmV3NeO2+POgrepyf+9z33MHfqV8lOcTwvS9IOfUiBbqqVK4loOaw9TLDFPM
 7SVwssctiwgCuM7LcYRP/lwkPCm/TTPsk/jn8FAlPv1RnPTy60XhLLI9qIOivIbDBjeNrjI/IH2
 GeXnW2oBd/AKghWUbgq2PWzHjGYkCXgP7s5wUeorYpUcDKxfO1P5jKVWdlAVSzfv1Ed+bWR0mBU
 G4vUKxpJzV1l7g6z+OW2BPBC6veqDkdN+2y84h1yNBolJrFciM7sx14+znY+XIs0qTcaQsU7TMC
 ax/PAXp4F8kEoCrr491WUi+Yi2ziTDe0efH4mD7ds0RXZY17PlGQyftKqINcCsvy3u68zO2/+CV
 HKaAq9Qf7GBJYlF7hUTxuAzCXnuYXGiOePDsV77VUqjEOXr8xRn1079fL6vBZq94rLmYCXkLqKe
 +rujE9jLsKkV1S1S3DGYRPTDQ3crP9vXG1na6/JVEdcKS3nr1XbI7Kxqb91fVMMamDYaLQAyoad
 YdfudyZF3iQEudeSctVh5yuH+if1ej5AkYZUuQfECCaDFbvebsDyFVypmSzuEaw8XpRStQaiaS8
 1l/QKfpyc2cp3vw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23220-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:calum.mackay@oracle.com,m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DC83734CAD

Add testCopyBadDestStateid (COPY9) which verifies the server returns
NFS4ERR_BAD_STATEID when the COPY destination stateid is invalid.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_copy.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/nfs4.1/server41tests/st_copy.py b/nfs4.1/server41tests/st_copy.py
index 1918f3da2bdf..6be3c70ccfab 100644
--- a/nfs4.1/server41tests/st_copy.py
+++ b/nfs4.1/server41tests/st_copy.py
@@ -272,3 +272,18 @@ def testCopyBadSourceStateid(t, env):
     res = _do_copy(sess, src_fh, _bad_stateid(), dst_fh, dst_stateid,
                    count=1024, synchronous=1)
     check(res, NFS4ERR_BAD_STATEID, msg="COPY with bad source stateid")
+
+def testCopyBadDestStateid(t, env):
+    """COPY with an invalid destination stateid should fail
+
+    FLAGS: copy
+    CODE: COPY9
+    """
+    sess = env.c1.new_client_session(env.testname(t))
+    src_fh, src_stateid = _create_and_open(sess, env.testname(t))
+    write_file(sess, src_fh, b"data", 0, src_stateid)
+    dst_fh, _dst_stateid = _create_and_open(sess, env.testname(t) + b"_dst")
+
+    res = _do_copy(sess, src_fh, src_stateid, dst_fh, _bad_stateid(),
+                   count=4, synchronous=1)
+    check(res, NFS4ERR_BAD_STATEID, msg="COPY with bad dest stateid")

-- 
2.55.0



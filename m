Return-Path: <linux-nfs+bounces-20921-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC0BKTEn4Wl0pwAAu9opvQ
	(envelope-from <linux-nfs+bounces-20921-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87426413A27
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 437C63052A2C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F60263C9F;
	Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOCa48oZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6F332EBC
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363308; cv=none; b=HkAV6XFnF46hfPb8Ca0b3f4jlRdG4fbXCEu6r8WjVzGeIoHWaxVzAy/CEQAK6JHO426ipkzY8lPQ20p8W4dFpgalLG/mC7FlOUHTuyhAmhln51CBzbkPVKAagdwkESTUzvq7eguWMCm+1/NU1WKBN9LW+biKgJQYs4S0Q0xnWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363308; c=relaxed/simple;
	bh=XIZD1mvkMv3lAl0STT993JqtMK8qJ6xc/D9qqN+so9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VO0RY34fIFKyeeUmRn9GeJgTbnxNySTgB4AlVZDW0piRd5QCnk6Fa8oemlMTE+xWCf6grLM0Axgb3yG+WLa0p6PKKt/vMd+lSirkcGq6XHDl/cZbI/Kk3B2FZohNglrDuOFu0e2NSsN6G2iNCA0bhGsW/ajhaWUSLf75+WsBq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOCa48oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEC2C2BCB7;
	Thu, 16 Apr 2026 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363308;
	bh=XIZD1mvkMv3lAl0STT993JqtMK8qJ6xc/D9qqN+so9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oOCa48oZE4ZhgPLPWNhias5knHT7iXc0oCyLUmT3EeaX1kofJ685vVXFLvK2OSFBC
	 omuu98n9nC/gqbSNGhXDzHvlCB99ZeeawO9qYtdXO1xCM2zoPlqWXZJgH2MQAq0ybl
	 XSpsI5F8+TkHNiChw/YacoxR93GH+CuzhQJxy7F90xTRZ2RgL7/hI/4sLZwsa6kKL7
	 FOIpdn3BHYgd3YuUKeHEJp0WDGPO9w9EJlMKdT122LW348fy91+Bo3IcQGU7ADNgH9
	 gdkTsD6a+l8nZXvFIJkegB09bHhE+KPkb8AdN7egIL/oIsWxV+hC++4pRZr2YBMvEz
	 KQcmMR9Wuar+A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 11:14:51 -0700
Subject: [PATCH pynfs v2 19/25] server41tests: verify filehandle in ADD
 notification
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-19-fad510db5941@kernel.org>
References: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-fad510db5941@kernel.org>
To: Calum Mackay <calum.mackay@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2657; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XIZD1mvkMv3lAl0STT993JqtMK8qJ6xc/D9qqN+so9o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4SciWeGNa7JhXX0ST6Fs/FPpn/ldvogBTKWpH
 7z6dKvXADSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEnIgAKCRAADmhBGVaC
 FcToD/wLCt0ppSrISgNaHAg6vo5wwoMAQ0Wvr4Vytzv+E4a8CTmxUFNHwOBZDiWOn9+CN1l8CrM
 Re5oeZpcfdqkgr4LwSUC2eERGL7zsSSnjMP1b4vd7Qgtd6bnWjlaIRrRcQdPGKRevVM2cpTt5A9
 F+R7/4+XU6Qlss9fd7OUKpu9uZchQy20DHfX1Z/dU/+sejOKx3O7LFCBRFedAJdKkr/L+yjoV9H
 i5je38RaxY+U5RWFi7PWP1ETBsAH13N+aTdAdwcZIoRk0xWHavFXR+2JVE8QjkME0LebTz1lTNy
 798TgajKTzQXGaXPh/TXauW8aHqOs7FaMP8GkZ/Yyx6gKGvLkgU/GpQWDdio4oeZarDZv3KiB6T
 3fXITAa9jox8Y/W/HO3fE6B+zdFLD6BwJNYIO0cWWZ4QuTZBIXdkb6R6oicqTKDYqgfwv6y2fZn
 vv46N6Q8xu5OaY/2SeCOU1msEKryJKQEIddbO9K1/w2kEQ9U3W0q/4i+IKwZrOH5uFj1mbBrXu7
 MtIuG/COYQYxpjVSzs7QD+GhR/LzE3wBqwsKEJKfBWFIJWUbtV74o9VXR3gm2xEV7uIc/Pvwri4
 WEVH/ou9FAbO9fL+6/q5ty6lKnsyTlXEo2yPaxObGJ6+EvZ15kNKvSg3pBpBgbwsS4XzObrpQR1
 bAEvj/CJ7/7u4XQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20921-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87426413A27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Request a dir delegation with ADD_ENTRY notifications. Create a file
from a second client, recording its filehandle via GETFH. Verify the
ADD notification includes a filehandle attribute that matches.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 nfs4.1/server41tests/st_dir_deleg.py | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/nfs4.1/server41tests/st_dir_deleg.py b/nfs4.1/server41tests/st_dir_deleg.py
index 376c49c71d7e..8ad34881e694 100644
--- a/nfs4.1/server41tests/st_dir_deleg.py
+++ b/nfs4.1/server41tests/st_dir_deleg.py
@@ -643,3 +643,51 @@ def testDirDelegReturnStopsNotify(t, env):
 
     if cb.got_notify or cb.got_recall:
         fail("Received callback after DELEGRETURN")
+
+def testDirDelegFilehandle(t, env):
+    """Verify filehandle in ADD notification matches GETFH result
+
+    FLAGS: dirdeleg all
+    CODE: DIRDELEG16
+    """
+    c = env.c1
+    cb = threading.Event()
+    sess1, fh, deleg = _getDirDeleg(t, env,
+                                     [NOTIFY4_ADD_ENTRY,
+                                      NOTIFY4_GFLAG_EXTEND], cb)
+
+    sess2 = c.new_client_session(b"%s_2" % env.testname(t))
+    claim = open_claim4(CLAIM_NULL, env.testname(t))
+    owner = open_owner4(0, b"owner")
+    how = openflag4(OPEN4_CREATE, createhow4(GUARDED4, {FATTR4_SIZE:0}))
+    open_op = [ op.putfh(fh), op.open(0,
+                                      OPEN4_SHARE_ACCESS_WRITE | OPEN4_SHARE_ACCESS_WANT_NO_DELEG,
+                                      OPEN4_SHARE_DENY_NONE, owner, how, claim), op.getfh() ]
+    res = sess2.compound(open_op)
+    check(res)
+    file_fh = res.resarray[-1].object
+
+    completed = cb.wait(2)
+
+    delegreturn_op = [ op.putfh(fh), op.delegreturn(deleg) ]
+    res = sess1.compound(delegreturn_op)
+    check(res)
+
+    remove_op = [ op.putfh(fh), op.remove(env.testname(t)) ]
+    res = sess2.compound(remove_op)
+    check(res)
+
+    if (not completed or not cb.got_notify):
+        fail("Didn't receive a CB_NOTIFY from the server!")
+
+    evt_type, evt = decode_notify_event(cb.changes[0])
+    if evt_type != NOTIFY4_ADD_ENTRY:
+        fail("Expected ADD notification, got %d" % evt_type)
+
+    attrs = evt.nad_new_entry.ne_attrs
+    attrs.attrmask = bitmap4_to_int(attrs.attrmask)
+    attr_dict = nfs4lib.fattr2dict(attrs)
+    if FATTR4_FILEHANDLE not in attr_dict:
+        fail("No filehandle in ADD notification attributes")
+    if attr_dict[FATTR4_FILEHANDLE] != file_fh:
+        fail("Filehandle in notification doesn't match GETFH result")

-- 
2.53.0



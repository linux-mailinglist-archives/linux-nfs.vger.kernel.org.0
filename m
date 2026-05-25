Return-Path: <linux-nfs+bounces-21915-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJW5EetBFGo3LQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21915-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:34:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B75CA92E
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 735F5300381B
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88D2C08C8;
	Mon, 25 May 2026 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccuY94zl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB73770B
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712485; cv=none; b=s+MH/1U31B4JKEKrRoCk1maMp3/iUbNMQZpBBtN2TWYOECjSYefBvtqTXQkXWsDefdxICL0dENzklJaZjZ3C8EXa7bFjrQCR/BFswziCdY+h3tuxrLgMwk/aDdCh/PJipfrXD66RYLPXdSch1OMnKAGVJAxSFEZUeu6Jt/5+u8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712485; c=relaxed/simple;
	bh=EDx1Vl57kFSBdZhsgZvtxn4zlhXkMFw1fdA815trwRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=STtwD+5tq+7AA6WJWJNaT8/x9Xb5wxfhZjrdy/dIWuv13G7T6AciXKtMxrmRuB2AoSJ8kkdFR/ouNynqrVGhPWuMGQxK/EhfXWhnHlTistleu6nmlBKU/RNL57ytwuizM+IjypUxwg96y+4VHrwoIE9hwU1DIKalfOIcJxFzH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccuY94zl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F701F000E9;
	Mon, 25 May 2026 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712483;
	bh=7+bBIg7tM+M3eAk5kEu2/ouBajQB2vZqFUvzQc55RKk=;
	h=From:Date:Subject:To:Cc;
	b=ccuY94zlbolpeqMrkHB4es9RT9M0Gzs3jSI+zlgCJbKx/PXKyFynZ0ez+aMXTq8Cy
	 kqKv3z4cuNBX0RsJ0BQdUlHehnV9jTq4CvTe05Q4GU84QdcdbFdNrimW6PMfjA/u/e
	 N8EmXnYUMI650qYLhQG6t8CJCSofSbgn1p2NreUSf7sOwBkYR678lVJZvqUd3u9p1l
	 W+xXrzHw4nNfM5qt2t7dtgu/E672kHU2tMz8gFr1ZAr+XGq41Jqasc6qHOD4btOd4i
	 x5ZNHJuZlHXZaKI5mRh4gCdcguBg2zIUjrHwbHa7TyGX/C+DPs060IHoZtF3bdFAKd
	 2Dd0rtGOd1xyQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 25 May 2026 08:34:29 -0400
Subject: [PATCH] support: mark unused arguments in netlink handlers with
 UNUSED()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fixes-v1-1-b4247bf20c91@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3bTMitRiXaMUS4vUFDOjlLTEVCWg2oKiVLAEUGl0bG0tAI6Pqnp
 XAAAA
X-Change-ID: 20260525-fixes-2d98ed62dfae
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EDx1Vl57kFSBdZhsgZvtxn4zlhXkMFw1fdA815trwRU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFEHeP6W/dvgMhBHUynLhpBmBPMuoZP0rxn6wd
 iH+StAcTEmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahRB3gAKCRAADmhBGVaC
 FT2kEACBPQM5HjTHisjvGHsfBqfqm0mlvpDJt4rfBZ8dCYy1njlakL50JzrnxFXv3L5MC/hU9OU
 bZDeG06B8LrWnViv6MMnp4OditXGwSfRDubJk0zrXNyYfBDA4Ezqr1L54xJvTcWnuXWl5lU1BUt
 ql1vg+CFtOs5p1AeFcRXtUsIHmpHUXXIIGXtENl7VGJeh6MBAeXwuLrqxsAVelucQQTqRHEdVNH
 DlRtPjf8uYAZFH8sd/Vb/9Q1Aes04zxn2w3zS/5BJ84phYvxgD8OEQk1b1oo6CFKrC1GCyPDm2q
 7h1Y1QMF/cAoBGYacW0P9kx2Y5mG30t2bT9RQmTPfBjOJEZPjkXFwyq60UcbFZhe1jjOwKoXESO
 YCnXpcRxskuPN+FRGbEFNwxNTM+UhMbonzpmyIHNORildcn2L/o+vwVXBttPiXW5MgonhIFDh9/
 X7ROR1YcAgnEHA7cuhdmnfDOHcDLtl+yq98GokUq4qKdrjcUPbiROOw0qDN6DUOV0umUr27XrJZ
 Dxzi2YlTVIKlFwZnFTYDuzW/QmcTQ9m7RchO/MlbnQNHrraVHFrVrOH6eRaeJjfYgnN89A90VJi
 0YG3G1KDAxzFXKcJq53YdyskxSLrfVNk6jtB8hv3AhJy2thw/+YqTbj4bPVPfId2o1JeDmQcabt
 kp7Wb/W/OQEAhHg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21915-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4D6B75CA92E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the project's UNUSED() macro from nfslib.h to suppress
-Wunused-parameter warnings on the error_handler, finish_handler,
and ack_handler callback parameters that are required by the
libnl callback signatures but not referenced in the function bodies.

Fixes: 3ddc8e81240f ("exportfs: release NFSv4 state when last client is unexported")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Just some fixes for some new warnings I saw crop up recently.
---
 support/nfs/nfsdnl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/support/nfs/nfsdnl.c b/support/nfs/nfsdnl.c
index ece0b57afd4b..ded035b90b1f 100644
--- a/support/nfs/nfsdnl.c
+++ b/support/nfs/nfsdnl.c
@@ -16,6 +16,7 @@
 #include <netlink/msg.h>
 #include <netlink/attr.h>
 
+#include "nfslib.h"
 #include "xlog.h"
 #include "nfsdnl.h"
 
@@ -27,7 +28,7 @@
 
 #define NFSDNL_BUFSIZE	(4096)
 
-static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
+static int error_handler(struct sockaddr_nl *UNUSED(nla), struct nlmsgerr *err,
 			 void *arg)
 {
 	int *ret = arg;
@@ -35,14 +36,14 @@ static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
 	return NL_STOP;
 }
 
-static int finish_handler(struct nl_msg *msg, void *arg)
+static int finish_handler(struct nl_msg *UNUSED(msg), void *arg)
 {
 	int *ret = arg;
 	*ret = 0;
 	return NL_SKIP;
 }
 
-static int ack_handler(struct nl_msg *msg __attribute__((unused)),
+static int ack_handler(struct nl_msg *UNUSED(msg),
 		       void *arg)
 {
 	int *ret = arg;

---
base-commit: a806c9d65662ecf5d40c00d60a514e13ada8d76e
change-id: 20260525-fixes-2d98ed62dfae

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



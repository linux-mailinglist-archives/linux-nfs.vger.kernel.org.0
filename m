Return-Path: <linux-nfs+bounces-7302-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911949A4B49
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 07:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077172839F6
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 05:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395051CC8A3;
	Sat, 19 Oct 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="YmjwPFxs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwiKaTZ9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7EF29AF
	for <linux-nfs@vger.kernel.org>; Sat, 19 Oct 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729315430; cv=none; b=nNxY4+gLMJBNT5F0QG6gZ6nSIVo2gToHKjclhg6uypnnRwKkabTI4ZPcwkCvx5cKlPoodGwhhhXpoaaaYjJ1hKqaN4VlyOYEcwSzUrmOIHQznNleKf/Q7gOitHRMmd0QKcAIvdSU1gfB9W1uMpToev3MjA1ApaBQUyk7zlM6QAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729315430; c=relaxed/simple;
	bh=HPwQR+8u4Y+R1iiMk1pNO7fgsGZySKT9Y56Lv2WFNa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPGDqZjEyLhexPtZOGVIr0OFe7FraYwhCALXCwr+t1BEAJ4nJZuHyYoh7T+u9nI3jya2Qpja+P84NVpKahNpgqOzgK9GV2tVXCJgb4AJN8Dw1S49BYRxO4mHVeMdqOUkkfsLNYZc37Q8+yGKxW+5GOIUHTbYnJHkKWeiRmwANCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=YmjwPFxs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iwiKaTZ9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D5DA11401A1;
	Sat, 19 Oct 2024 01:23:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 19 Oct 2024 01:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1729315426; x=1729401826; bh=xUVE0NgXMBmiceTMebckt
	nxXXRgxBqOlLraiu55hJJk=; b=YmjwPFxsLV1CRP98dZVEX9giyLAFOHOfUDwJY
	03v7LA2inHmi+Tku6BBB5DpDGhut2OnHA+C9wfi56TzSbYG/32h86wWqdOU8PAcz
	s1LMsE/u+TiBgEBMbPdFmokzwvm/3w7dcTdjFcr1FEDGYK8SAV1czjg9XrUhqc/z
	V8wLouGZjIaL9p8JAgB17RSYUafd9KIB6BLgErpsQmYDYjCEuVMcoIpqJnFPQDPK
	DbpJLBJjidBd8yZqJ57cqFK1GVXaAwIXVn9q2AxMy7QAaZjrCleUGjCKO2M0RVkc
	xTmEpmhHTey3Vo1/ZBDqEAwB6mi0fbVL61+rb3NEjJfbRdkNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729315426; x=1729401826; bh=xUVE0NgXMBmiceTMebcktnxXXRgx
	BqOlLraiu55hJJk=; b=iwiKaTZ9LWkGJjHnmrOOOGgDtuUCfBssXePLgYirooXC
	kVggyMQvDUUsYtMNggoVG6KNsIi8bl0MbIpGyn7N39Xn1PKE6H+y7dNDavYHQoyu
	5AvH2hTJZ6LQDo+T//+T/qEzi7Ha2Hx9DYL3L7YSlHpj3FU02GOYNpdJKRejDFxm
	IDL6iqcPW6urbEdWw3EHAKA9G7QaP7xIl263ERkqzUqHR+w9imVgXNqNwRPvojGA
	Q2DmqFWbOikjCeo8JI4DX5ngQvTYPoRBCEhnnEtvu0Q1Se6OMVR7qwkDQJeUwEmz
	y7sVbiJnr66Z+U3Xs2pd/AojtHFqNTS5mWxEMboMcg==
X-ME-Sender: <xms:YkITZ0UgKl1nG3mhNUnzewtl0kmMfIcGjp7QMTxCB9rykNoNPnZXVQ>
    <xme:YkITZ4nXf2HDxLxITplMLryfB7JuI5GRuXLxNHdUyA1qzFN39HwdoirvEi5h3pdY0
    ZVTKW5qE7fj>
X-ME-Received: <xmr:YkITZ4YzwNYdGK0zjNDTDCjWv60QS0hpLU-nigUz8mjAwcxXUACuj8TNNSKPrCBwUx3HebhVdM0JOs7j5Rs-BgzqU3ablMRngeN61rxlWpXiI5LbFK_qQC6idg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtf
    frrghtthgvrhhnpedutdfhveehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddt
    gffgheduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrrghvvghnsehthhgvmhgrfidrnhgvthdprhgtphht
    thhopehhvggurhhitghksehruhhtghgvrhhsrdgvughupdhrtghpthhtohepshhtvghvvg
    gusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:YkITZzXAixbu1nWMyM0R4up6qGwSHqgNd9pIfLnWLjj2k3Md68ySZg>
    <xmx:YkITZ-k4UIvygXHYoZ_LSzdfzW4WZOXx8U1-OvNxTNzmSI63oRx9ew>
    <xmx:YkITZ4ct_Gl4UXJG6eCz9xhjWh0JnwfOyxUVo6UglvuXpCkEeCckWQ>
    <xmx:YkITZwE-WC40guBmxai79TSSPwD-arGmF8icY7yzfBU7lGAvZJgi9A>
    <xmx:YkITZ_Ar-bHJ7sUa63ekXDqRgZKVKBMjdDOa6R4NEEGVr5TSUB_EOuvB>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 01:23:44 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: linux-nfs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>,
	Charles Hedrick <hedrick@rutgers.edu>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH] nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
Date: Sat, 19 Oct 2024 13:23:35 +0800
Message-ID: <20241019052340.28225-1-raven@themaw.net>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
these functions are not thread safe.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 utils/gssd/gssd_proc.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
index 2ad84c59..01331485 100644
--- a/utils/gssd/gssd_proc.c
+++ b/utils/gssd/gssd_proc.c
@@ -489,7 +489,10 @@ success:
 static int
 change_identity(uid_t uid)
 {
-	struct passwd	*pw;
+	struct passwd  pw;
+	struct passwd *ppw;
+	char *pw_tmp;
+	long tmplen;
 	int res;
 
 	/* drop list of supplimentary groups first */
@@ -502,15 +505,25 @@ change_identity(uid_t uid)
 		return errno;
 	}
 
+	tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (tmplen < 0)
+		tmplen = 16384;
+
+	pw_tmp = malloc(tmplen);
+	if (!pw_tmp) {
+		printerr(0, "WARNING: unable to allocate passwd buffer\n");
+		return errno ? errno : ENOMEM;
+	}
+
 	/* try to get pwent for user */
-	pw = getpwuid(uid);
-	if (!pw) {
+	res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
+	if (!ppw) {
 		/* if that doesn't work, try to get one for "nobody" */
-		errno = 0;
-		pw = getpwnam("nobody");
-		if (!pw) {
+		res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
+		if (!ppw) {
 			printerr(0, "WARNING: unable to determine gid for uid %u\n", uid);
-			return errno ? errno : ENOENT;
+			free(pw_tmp);
+			return res ? res : ENOENT;
 		}
 	}
 
@@ -521,12 +534,13 @@ change_identity(uid_t uid)
 	 * other threads. To bypass this, we have to call syscall() directly.
 	 */
 #ifdef __NR_setresgid32
-	res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, pw->pw_gid);
+	res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, pw.pw_gid);
 #else 
-	res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw->pw_gid);
+	res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
 #endif
+	free(pw_tmp);
 	if (res != 0) {
-		printerr(0, "WARNING: failed to set gid to %u!\n", pw->pw_gid);
+		printerr(0, "WARNING: failed to set gid to %u!\n", pw.pw_gid);
 		return errno;
 	}
 
-- 
2.46.2



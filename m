Return-Path: <linux-nfs+bounces-4300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6DA916EF9
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 19:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC37F1C2227D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5017624A;
	Tue, 25 Jun 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIHj/BTC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECE1487E9;
	Tue, 25 Jun 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335966; cv=none; b=qOOmMe0zxQjMhRRG+BJD3BTJ7iYEDHx1thPLEeoybIbLJbSpdEjLWuDqFL+prX5vS6oO/Kq4tHumEHLH7JPhfdJIoiHrB1vwIlIlK8NbuyuETTqpcYs92I/IkBHB8A2PEhClmQEjfXeuPH+KCXUwrAUq9jewcRY1xqSg3RZsD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335966; c=relaxed/simple;
	bh=h/AKdpG7oZDTaW9GmHMwq1B9ya/BDafXlMiQN5HZ9rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SGLLCZ3DgELjsiqcc2OO1V0UvnQ7scLVu6RRCOxnq1I/VpWXtyJXFoOkI1gPhy94alAcU2qM8n/RQAcLyyIL+SFAGQjGZ/1fAiaTakI1pn3LckWh4usOox7dciTmV/Vgbm1Ymswt0ZkA7DX3AVG9aeLmPWUNfSHbISVfGYH1H9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIHj/BTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765C1C32781;
	Tue, 25 Jun 2024 17:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719335966;
	bh=h/AKdpG7oZDTaW9GmHMwq1B9ya/BDafXlMiQN5HZ9rE=;
	h=From:Date:Subject:To:Cc:From;
	b=IIHj/BTCqShy/I1ee7z7XGRgn+1KkhA2PCid5pcmHysKjopizvuCSU/T5FpII5ucC
	 Onnl3/jjJKVVuYFOT4uklv78ntgiyOg6Q8GP5YQ99zqWk8M/nLqurdwnnuk/1l6ODq
	 cD6M6c0b6zCBrpwHrTqe56Vcgfv53Bj0t5K0A46rgt0H5uc7LQmP4n0KH8v1fn+4Xu
	 IO4HWb8E+mT897+SaXjpf9R6bTHSGJRJSwAgM0aP895piOGx+FIL+KGmjvn07yPwbG
	 jUD5kIdmvb48p2GsRXAsqbyGDpldRHDA41pukZHhKh2uLYFX911ox54gWZLnnr1bed
	 MY16Brww6V1hw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 25 Jun 2024 13:19:12 -0400
Subject: [PATCH] nfsd: fix a regression in threads procfile interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-nfsd-testing-v1-1-89c4782c5a2e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA/8emYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNT3by04hTdktTiksy8dF0Lk5Q0S0sjI/PUpEQloJaCotS0zAqwcdG
 xtbUASJ5oGF4AAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=h/AKdpG7oZDTaW9GmHMwq1B9ya/BDafXlMiQN5HZ9rE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmevwZ3jgyTPkHKWGTqRNfT5yOkOwmdwsl5eTas
 m9F/FjznDCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZnr8GQAKCRAADmhBGVaC
 FW3LEACQzwD9w+gmkQyj6E+E6kpGz5bYF0Rf5QKeU/6OvJPOvGnTj188nZ6BaMbE2JLNmKcTwIj
 y1oS8OY1eMHOeLnfJ/A/613LUIvSQE1nmNoHB3RIXfApzGk9IJ5kSEt7807AfIOy4K0+GFDo2dH
 rrkBxn7CGBy+ZLGr0/DrYyrxi5+ggiHeVyK5t+N+9tM9fC7l3oPTJXvLl9TtHx1gIhRe8BQHjEB
 J2bQFeP7TyNHR/CXW2XV5hAbYPByJe7TnY89bwUGEmd7aaXO7LiowZp1NGYD9CO49tiySVtgK4k
 k9CMGkROzBjSzC5ZRe8Ok5ZTnfwfXs90jRdagxQqm6UpvQTfC4UOx+fBxXA84w0kffo7HJO9SDI
 5bcf9ERRW0R3050PJRfwHK28t9ExgRbnLPaYYm+oc+0T+CXs4NqCLrLaWQei/9jauYy12QCg2M4
 KCQ90lJapl7ohYwthZ8RW4YqGUUYJ5HFsjJY4m73GLuX8gAHmm0fn1kuC1k1vXbaQjNe6e8/Iez
 Il1fDsRPCuwuT3Aee/vRjOxyJJ/TnomRq/D3qjfELdx84kBRewRQaaXRJB2ZkyRl+yinmyLEIFX
 oDJwwjIHFcHsiij6eulvQTbl/hKTib5lKL950fJZHl189DruTHA/SVu6ONnDZnH69Ox+rAktwJX
 9PD091Bi7yTqg0A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The old threads interface passed in NULL for the pool here which tells
svc_set_num_threads to distribute the count over all the available
pools. Fix the logic to handle this case correctly.

Fixes: bbb07968d5e2 ("nfsd: make nfsd_svc take an array of thread counts")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
It's probably best to squash this into bbb07968d5e2.
---
 fs/nfsd/nfssvc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9edb4f7c4cc2..23e73190687f 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -735,6 +735,13 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	if (nn->nfsd_serv == NULL || n <= 0)
 		return 0;
 
+	/*
+	 * Special case: When n == 1, pass in NULL for the pool, so that the
+	 * change is distributed equally among them.
+	 */
+	if (n == 1)
+		return svc_set_num_threads(nn->nfsd_serv, NULL, nthreads[0]);
+
 	if (n > nn->nfsd_serv->sv_nrpools)
 		n = nn->nfsd_serv->sv_nrpools;
 

---
base-commit: 26086b8c567f3f758cdf3e1fc2ae205095751cb8
change-id: 20240625-nfsd-testing-84df99227eba

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



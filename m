Return-Path: <linux-nfs+bounces-3893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A1C90AD61
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 13:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271271F228D3
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 11:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AD6194C6A;
	Mon, 17 Jun 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khLP/TUt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504C19308B;
	Mon, 17 Jun 2024 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625253; cv=none; b=IyhTPWH8EpQVwLgwfeeB2vHaHJ8Ms82ysok3TyLdYqJSGl/wj8R4Etlug/QVB+vi7m0DCZTxa5lWFcJTHXloT4vrdPDStslI1rviAt9uhkZUisKhLITEaLXNU7fDlmoVnAR9PdN4O2kn1h8dJJi/MYWPHUUSbhStC2/XLLIpDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625253; c=relaxed/simple;
	bh=nLSa833g+m/0FkCeHBJpkevPf3ESa1dp0aQQiOtYnIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VwgwRhR3rb3ekxG7SCJkjTJDdu1XnVA00vfJtJsl5509iZoMpInJiLTWTYIS8vm5ce+aFMl3w1IpTFTULZV5dtImZgJPswMhhjI49VY3lz4fBAYLJtTRKA22Dx8GqHS4mmt0nbY8pM0ZmMA+DA3bfXtKNrYJNisjgTlFSL3ciDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khLP/TUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CB4C4AF1D;
	Mon, 17 Jun 2024 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718625253;
	bh=nLSa833g+m/0FkCeHBJpkevPf3ESa1dp0aQQiOtYnIQ=;
	h=From:Date:Subject:To:Cc:From;
	b=khLP/TUtmjhbhL9Y5EqX8xXX2mj1IHhOURpSOWDW4Qm94csdO+DXUVyYLhWq9SUvM
	 h0LGQZz2+8En7B42gqamcHBa2NXTH/VN1F2dXg0nYolGHqFJgmoljKJ8aWNlIpj6Rb
	 qMG1oz5WmuksI4tez6dAKi4WFL2UnumRrafMmnHYu6huKE4OqRiusUOcMjABPORFc8
	 qltzAz22worC8una6e9XjhIwzXoTEuvHremTCP5d9L68kEE5kvVpFwzXux4OCV8dSK
	 2AUe86xy4yN6R9iSdzHbbTJl7FFAONh0U0BTMuIKEgdOeQc/KYF7T7RsoRHJ+Tq6he
	 fDt4cb3GK0bxA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 17 Jun 2024 07:54:08 -0400
Subject: [PATCH] nfsd: fix oops when reading pool_stats before server is
 started
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-nfsd-next-v1-1-5833b297015a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN8jcGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0Nz3by04hTdvNSKEl0LU0vjNHNjUxOTNFMloPqCotS0zAqwWdGxtbU
 ANtGriFsAAAA=
To: Sourabh Jain <sourabhjain@linux.ibm.com>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nLSa833g+m/0FkCeHBJpkevPf3ESa1dp0aQQiOtYnIQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmcCPkIhYUTbbqVOCUeZRek5q6N6Iew0Q8VmkYo
 IbwPENw54+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZnAj5AAKCRAADmhBGVaC
 FYq2D/900e8Er8Rpjm4+KYi/JpFv82lQskupSfshlWR0Ny2OjVRJvacayGEo9L324JksuEuwLzu
 LFGq8hIBt+uXzgKe/EL3ayzPhBrla9v0WRnhEBt8/nItR6KX/28zTeRSAJnmwxa/oAGsTRDsdCf
 M4DV2lgxB1VALcG+OCUciPcMVxsUv+R3iMYVCCvZ5NGm0zNLoCPKgz1xk9dzKvXRX2fQcmIhEB8
 m31oG6b+f3Fs+fvrIFIigYmjM2IGgmIOkJGXI5VE+ObftGsbpjG2xgHzyCPq9UxF92WBhAKVCfH
 NnXHqdgzgecpReQPl5prorhMQG67IoOGH7TtNMuEsvS28l5VcV0qP9z496X6s5aaGsdz87caC0R
 kN9KwcRtaUvOzOmfP3jTHQHQXzCIOUvHGe7Bb5N8qD/vhkCrwm+NPW3lac/5X9KAINEJ6nN3g5q
 faejCz4ZX+o1wyuayvQ56puvGdKtGR+r+1ce8R84C8vhxI+94i9324zCM3RVxVRCVnzYOc1CgwF
 tfI/xWO578WB84RafJMy/tr0KiYj4zzBMoFmHgzN+BM1rpsin72u+qfRKry9VogxjXUT/12CDrk
 57qPjrlejdOOyBIEYNYWuDvqdYtAWVkAsulDoygyvcpn+5tyYlDeWrAmFBruLACiIblu4/2LKch
 swVl9q+lxwNVJsQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Sourbh reported an oops that is triggerable by trying to read the
pool_stats procfile before nfsd had been started. Move the check for a
NULL serv in svc_pool_stats_start above the mutex acquisition, and fix
the stop routine not to unlock the mutex if there is no serv yet.

Fixes: 7b207ccd9833 ("svc: don't hold reference for poolstats, only mutex.")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc_xprt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d3735ab3e6d1..b757a8891813 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1422,12 +1422,13 @@ static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
 
 	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
 
+	if (!si->serv)
+		return NULL;
+
 	mutex_lock(si->mutex);
 
 	if (!pidx)
 		return SEQ_START_TOKEN;
-	if (!si->serv)
-		return NULL;
 	return pidx > si->serv->sv_nrpools ? NULL
 		: &si->serv->sv_pools[pidx - 1];
 }
@@ -1459,7 +1460,8 @@ static void svc_pool_stats_stop(struct seq_file *m, void *p)
 {
 	struct svc_info *si = m->private;
 
-	mutex_unlock(si->mutex);
+	if (si->serv)
+		mutex_unlock(si->mutex);
 }
 
 static int svc_pool_stats_show(struct seq_file *m, void *p)

---
base-commit: 4ddfda417a50309f17aeb85f8d1a9a9efbc7d81c
change-id: 20240617-nfsd-next-8593f73544f5

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



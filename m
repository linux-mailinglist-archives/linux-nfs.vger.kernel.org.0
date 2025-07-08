Return-Path: <linux-nfs+bounces-12948-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12684AFD641
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 20:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AFF543D50
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B14121ADAE;
	Tue,  8 Jul 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGT0nG3Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2049021ABCB;
	Tue,  8 Jul 2025 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751998514; cv=none; b=HTyPUJeSuKdM3CvNWq6d444wXYDSNVPcZtFPl1PubuV2o94T5wSntgFdRbnYK3MDHKO9O+LnTdQ1si/bJ6icwN9MboVrte5Um2tkBd4qkvI8fjI0f7R85OYfI8Ne6xiIbBj8N6CTlFPW7BuWXwxgGdyssDNte/4R+njukuLunx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751998514; c=relaxed/simple;
	bh=p2mo/KuMBdg894Nffz/9wmkmAd5guwKs4vdlsERSJOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e7fVBlGW6zYhZOM9oaQvMjCzc8aKCZHiYhxE4hj7TDs0lwY88LVtAA8fDRgUjpltIxw8ogZnnug5k4Z0djo/W7SsX/XDN+J5hEZfCKVPnHX7JHSjA7+nrlbfQZBNbEqOrY3p3yPjH7h/5JYzxko++woygqZpC2YK8wt73wRVJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGT0nG3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E231BC4CEED;
	Tue,  8 Jul 2025 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751998513;
	bh=p2mo/KuMBdg894Nffz/9wmkmAd5guwKs4vdlsERSJOw=;
	h=From:Date:Subject:To:Cc:From;
	b=lGT0nG3Qgd5H4+Y6NBBCrWnGYbKREW+/X98zSeJRke135QKJohOIwl+6KOIblSfVH
	 ylKUAZ2yxpDrDc8zBWUkdO35Xc6BLbo3oIue4iwHwq6rbtwiZ6r68wv6K1l3fQ1b1L
	 XSPOvTmKXVgL0xDy0emY0VeFxPl1QvJwGnMJeDDcJt1JPLgaBNJ2lqkwcgSjUUckea
	 GuSDTaPFagoeqjRp7JxyArOWu4eXpkqRrlEswW+UkjzK+47n8/jmUBEnXaeHBAKydp
	 9U8ZWhzDCnWTC/IxSV9yfHDfxwsmBf3XXIyJLwOLd0tunS8MP7XdXk1DyjY0/Asmg/
	 JeuzDXy91xueA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 08 Jul 2025 14:14:53 -0400
Subject: [PATCH] sunrpc: delay pc_release callback until after the reply is
 sent
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-rpc-6-17-v1-1-28c4d6079103@kernel.org>
X-B4-Tracking: v=1; b=H4sIABxgbWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3aKCZF0zXUNz3bTUVHMzs0QTE6NUYyWg8oKi1LTMCrBR0bG1tQC
 MuBoqWgAAAA==
X-Change-ID: 20250708-rpc-6-17-fee766a442e3
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=p2mo/KuMBdg894Nffz/9wmkmAd5guwKs4vdlsERSJOw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBobWAmRI0e83EevzoLZJG973bu4jjrlh2owk6Ak
 q/wZMME00aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaG1gJgAKCRAADmhBGVaC
 FVgCEACGT+8ICwz8Q0K8Oj+t3toLXX5gFhf4FtRdoJaIfGhR5SDMsN3HSzB4OXZWsePtEXtu6ui
 UoB3xaDZgtRboAdYtqsshSz5mz2pPcvIfgsNF50rjfh+VpfDNAeFzHVmSdDy9k5R7zKAsGorlwH
 nxSeVZH0ajQflcNVzh+ObPvjMoXqO01H1/Ae57ZOtF7SEpWkK7FceuZBGhWIhFZuV3V5FxV+mWZ
 YQNLMeY8Jge5hVvZ1tLzhMdrrwAvofKhvM0rX/PQZtsLg5A+Dr/4Eo3eA0jkakVayVcyAnhFWMY
 pmN7eKDt8BliRMFOynLHh+bKNz52lSNwp/35IfCgkj83IaOCZCXoAo0xkrrEDxbpEJnHq1y6jri
 NfOOBHgrIaYO6hHWup/tUJlmiQoiDKxaVx9GWkXJnNgRU0CiIvbHxOkoW0rsXKt4B2dkA13kKlT
 OHd2PmlhDclJAqNZYErjjO8OO4qpCiwOqN9tNOFnhi9/1egYPKmb1PPsCtN4OzOEbEzMFJ/qJ9/
 NdhieuVL255vyJ6YFssdRSMi/HtpvuV5GdSbZrHn0AoZ28QYVIC80S8+SRHkFLP2y7648yl5vVs
 Jxp5er+rHrScLEG5MTIb40au+hVq0xLzzVWHjtPmgSyDuoHKnGa8uNBaPZ0qPRnkBXTK2l+f+gu
 QtSw2TJqKoVPXnw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The server-side sunrpc code currently calls pc_release before sending
the reply. Change svc_process and svc_process_bc to call pc_release
after sending the reply instead.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I think this patch makes sense on its own, on the general principle of
expediting the reply. In my own testing, it doesn't seem to make any
difference in performance, probably owing to the fact that most
pc_release operations are very lightweight.
---
 net/sunrpc/svc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b1fab3a6954437cf751e4725fa52cfc83eddf2ab..fc70e13b1cb99a4ac4cbaa919f5a91d285844b11 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1426,8 +1426,6 @@ svc_process_common(struct svc_rqst *rqstp)
 
 	/* Call the function that processes the request. */
 	rc = process.dispatch(rqstp);
-	if (procp->pc_release)
-		procp->pc_release(rqstp);
 	xdr_finish_decode(xdr);
 
 	if (!rc)
@@ -1526,6 +1524,14 @@ static void svc_drop(struct svc_rqst *rqstp)
 	trace_svc_drop(rqstp);
 }
 
+static void svc_release_rqst(struct svc_rqst *rqstp)
+{
+	const struct svc_procedure *procp = rqstp->rq_procinfo;
+
+	if (procp && procp->pc_release)
+		procp->pc_release(rqstp);
+}
+
 /**
  * svc_process - Execute one RPC transaction
  * @rqstp: RPC transaction context
@@ -1565,9 +1571,12 @@ void svc_process(struct svc_rqst *rqstp)
 	if (unlikely(*p != rpc_call))
 		goto out_baddir;
 
-	if (!svc_process_common(rqstp))
+	if (!svc_process_common(rqstp)) {
+		svc_release_rqst(rqstp);
 		goto out_drop;
+	}
 	svc_send(rqstp);
+	svc_release_rqst(rqstp);
 	return;
 
 out_baddir:
@@ -1635,6 +1644,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	if (!proc_error) {
 		/* Processing error: drop the request */
 		xprt_free_bc_request(req);
+		svc_release_rqst(rqstp);
 		return;
 	}
 	/* Finally, send the reply synchronously */
@@ -1648,6 +1658,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	timeout.to_maxval = timeout.to_initval;
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
 	task = rpc_run_bc_task(req, &timeout);
+	svc_release_rqst(rqstp);
 
 	if (IS_ERR(task))
 		return;

---
base-commit: f4407c6fb86dc485e98052aebc0d39c8ced46e70
change-id: 20250708-rpc-6-17-fee766a442e3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



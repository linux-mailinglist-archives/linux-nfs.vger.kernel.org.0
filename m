Return-Path: <linux-nfs+bounces-14155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332AAB50945
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Sep 2025 01:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7D1681AF6
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB9D2882A5;
	Tue,  9 Sep 2025 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVlsrA0E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586822877E0
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460799; cv=none; b=JSG+YIjbL/jKJW4Tf0jLEOQ4mqodYOg5Hc7MDlYIcqFtIJp4M5woq0E9SOYqpyz0veKOTceBWoA8xnU+LusT9A1qtMUbCMFcR3HxJqcfRgHJx59aC4vN7AtYdEl72XhaASlMx+Q3cZjTgeBHAz/AUc6bfuTOGrCxmDRbRTKd/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460799; c=relaxed/simple;
	bh=KqYehND7eQBlPIzXdcH2BBkTAzoFHCXIkhRt0zu+eTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsrjmtgbEA+OsrjFGG2yrrxzAotfgWmIAxdV7qNaky54Y8VJTH2f5BrVMqxHT14zLZwgLKXGuh0wn0mwz0lQQjYPpNwQrB9BV7yrgNKMV6XuZkpsXYRcvvHAPwLS59kxqv5kY8crmP4/Ez53FyfB6Ba4jrwN1N6hUw8zQnaMQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVlsrA0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90ECC4CEF4;
	Tue,  9 Sep 2025 23:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757460797;
	bh=KqYehND7eQBlPIzXdcH2BBkTAzoFHCXIkhRt0zu+eTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVlsrA0Ef0sM+ouDAvQ6xjev/12pmk9jZo54ItQ0jbz9RzGE1jWeZLUgvrfchrxaR
	 3MtrK1uDAt4+zEM2zWCn8F7Anu2yd/389CRXtWAhkJ7Yb8ePy3Nu+PiP3us56NPkqe
	 motQ0chPloB7Fs98V48lshKeXtP8wR8dwEr+EIejLDLNoDShxVyRWOiihakBrg8TpO
	 GW19QWr3Z67JFBpHZeZA/PTQrKz3Gehm8FxSHCVUbBLccniEHPGMszxmoHEDem96C2
	 T6ho5tGWYx18C2dtwJVf6/8IEp1wOm6z4Wtlqiq0zZIin1noK1gSOQ8PeS5A5rxNrp
	 O/OCDYExoxPiA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] sunrpc: add an extra reserve page to svc_serv_maxpages()
Date: Tue,  9 Sep 2025 19:33:14 -0400
Message-ID: <20250909233315.80318-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250909233315.80318-1-snitzer@kernel.org>
References: <20250909233315.80318-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd_iter_read() might need two extra pages when a READ payload is not
DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor() are
mutually exclusive (so reuse page reserved for nfsd_splice_actor).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/sunrpc/svc.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e64ab444e0a7f..190c2667500e2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -163,10 +163,13 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
  * pages, one for the request, and one for the reply.
  * nfsd_splice_actor() might need an extra page when a READ payload
  * is not page-aligned.
+ * nfsd_iter_read() might need two extra pages when a READ payload
+ * is not DIO-aligned -- but nfsd_iter_read() and nfsd_splice_actor()
+ * are mutually exclusive (so reuse page reserved for nfsd_splice_actor).
  */
 static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
 {
-	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1 + 1;
 }
 
 /*
-- 
2.44.0



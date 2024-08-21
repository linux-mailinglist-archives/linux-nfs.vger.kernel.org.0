Return-Path: <linux-nfs+bounces-5493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCEF959BCB
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B47E2846C2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD918C91C;
	Wed, 21 Aug 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw/UWv60"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F81531DC;
	Wed, 21 Aug 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243319; cv=none; b=QuNCON3zOq1w0Cb76U+Sxkyf/ft0EW1VOUhp7YrSb6uHq0JPvg8lKVOwQmp44mYCxnlYIKU28wln6V33k5XSFmLKDmHgUEL62H+YHiuLgxCM/DIe8SKJE5SFCIE5L25fBo1CFLisfUWCz0N4csLwxQcQ/KZVJioTL4N9xbkHTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243319; c=relaxed/simple;
	bh=Xen/poYb/0cJ3WNYP/7x7mJQ2ZMvPuvSZU2BYfJTx3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sK3zTr1gjr5VEQvwk4TJU+Ddjnk5vnYwJehgEjQZXDRyH3pj7mbxlxWCp/xWKDlezLiQ9gFzousCnBmF4gthW6ZQ8ZHkCmH766EQSg59/pp4CDsonbJIbDjsLT2v+9Sc/LINdIMTcSEWDAEkgLK/D0AgUPXiL8gpVjcnZaubmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw/UWv60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7772C4AF0C;
	Wed, 21 Aug 2024 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724243318;
	bh=Xen/poYb/0cJ3WNYP/7x7mJQ2ZMvPuvSZU2BYfJTx3E=;
	h=From:Date:Subject:To:Cc:From;
	b=fw/UWv601ztiBFOwyaHHmzs+JRYC5bZCKkCdl8dpWqXm7mAk12b2eZuMeFcuopikV
	 yCpMw8t1KGt+TyuH2IQIX79ZBMcLveQYnsmD5jQnkDaGVqZGeIcCIiYgZ7CmiGprOY
	 1iNLB2fKxS3pt60AhDObpwgSrxfE+gxMVXz0NyZtP5pZIG7kUDGH5fixHW6YzMgbrX
	 I4b4cIeCSUuzwunDXIeXAyuqT+mu14HN6SgmxuXPXRK1fmlwk8Wm9Wkd6qYi5lfWoi
	 fcPy1xtFkdmSw5ZuCu6Bj+sM7CSbURgpzyZz5EXe/iwC89vlyH7t/v3fSgZNTKHZK+
	 DkRbhbjYQz0ZA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 21 Aug 2024 08:28:25 -0400
Subject: [PATCH v2] nfs: fix bitmap decoder to handle a 3rd word
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-nfs-6-11-v2-1-44478efe1650@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGjdxWYC/23MywrCMBCF4Vcps3akE3oJrnyP0oVNJm1QEplIU
 Ere3di1y/9w+HZILJ4TXJodhLNPPoYa6tSA2W5hZfS2NqhWda1WhMElHJAISetl6ZgcWQv1/hR
 2/n1Q01x78+kV5XPImX7rHyRXBw0P5Hpnxl6P1ztL4Mc5ygpzKeULPoyjxqEAAAA=
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Lance Shelton <lance.shelton@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Xen/poYb/0cJ3WNYP/7x7mJQ2ZMvPuvSZU2BYfJTx3E=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmxd1wWIESQM415evux8HpHCn26UYQoq5MeSuu4
 IpVO5LBd+aJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsXdcAAKCRAADmhBGVaC
 FascEAC6wfs7kXmtEuuuDJsKbh9U3Z4Jf/mmxdeiB+BRrS9REgVACnMJxuZ9EHN5QnJiFGlejGi
 w2Rxdjihdx37cZ2UYjHuYuyLYZhRoHCYRNezFeYhbkvlsjgFtn+kOF7YQSC9SU6cGBE/WErj+nZ
 kw7FDkKRAeha8NVfJl7lT6rVxgGsm36N5EuefvJxTdr+oJlye5FGcoK+OrAl9L25sT2EN9w+fHX
 qdgPWya1eEHH4q0F5VwM8Ae9o04TZlujf7Qeg7IIuYCKb5sOayL2l2fKFMJSfhFxAkAvswpJ1dE
 H1FWLr3gRXlm2hn/ECdyDvfaUNpmErrHRBwGne04dX7rgf7f0OdznlFO05UodUBNPl6/sHkhOgn
 Y4cRRCbf1WluDuP7fxoRCplo/vpheEKorHAr2vTK3GEf19+nwuWvEEnbOI1F+90gRtIIrkC7TGP
 A8EOdxldjNPnDWan3w3zLvi1W/ytrrYv2PPFh6cwPkFalfjdGe/IyBsKS5nOAZGf472JTqtGNis
 8CkARfbicTmsX6FxqVNwGt97EgmM2o7cV715x0CAh3q3l/jud+Yy6BAVUzbMPvwtDWuo8RH1YDU
 CoDR0bJWVpS7gsmlzcT2Nuvz+GC7jY8d9GbMH1BxfpisghLIYoZ+q15SbBfrjHbvlg/BqGBr7og
 Gh7Hl8+1X2qJVVw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

It only decodes the first two words at this point. Have it decode the
third word as well. Without this, the client doesn't send delegated
timestamps in the CB_GETATTR response.

With this change we also need to expand the on-stack bitmap in
decode_recallany_args to 3 elements, in case the server sends a larger
bitmap than expected.

Fixes: 43df7110f4a9 ("NFSv4: Add CB_GETATTR support for delegated attributes")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- expand bitmap in decode_recallany_args to avoid buffer overrun
- Link to v1: https://lore.kernel.org/r/20240821-nfs-6-11-v1-1-ce61f5fc7587@kernel.org
---
 fs/nfs/callback_xdr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 29c49a7e5fe1..6df77f008d3f 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -118,7 +118,9 @@ static __be32 decode_bitmap(struct xdr_stream *xdr, uint32_t *bitmap)
 	if (likely(attrlen > 0))
 		bitmap[0] = ntohl(*p++);
 	if (attrlen > 1)
-		bitmap[1] = ntohl(*p);
+		bitmap[1] = ntohl(*p++);
+	if (attrlen > 2)
+		bitmap[2] = ntohl(*p);
 	return 0;
 }
 
@@ -446,7 +448,7 @@ static __be32 decode_recallany_args(struct svc_rqst *rqstp,
 				      void *argp)
 {
 	struct cb_recallanyargs *args = argp;
-	uint32_t bitmap[2];
+	uint32_t bitmap[3];
 	__be32 *p, status;
 
 	p = xdr_inline_decode(xdr, 4);

---
base-commit: b311c1b497e51a628aa89e7cb954481e5f9dced2
change-id: 20240821-nfs-6-11-188bb4e1f1dd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



Return-Path: <linux-nfs+bounces-4840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB092EF57
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 21:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7561F21392
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF616EB4B;
	Thu, 11 Jul 2024 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+slZ+Wj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B4A288B5;
	Thu, 11 Jul 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725092; cv=none; b=sLT7yi59px/SJEpF9u8kNsvpRlCKZzmfo9E+6LRKRrSFEth2lEZf/oyePs9468X7wb8rFSj1aaWY9/EpSjGn/7Y1bNlbPOt58gteuf7zXfbR+z33LuHAhwOdmYTrUy8tJZu0ldF3VhylMo0Lf+rfncyzJQciMSBZFiXAStsAHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725092; c=relaxed/simple;
	bh=fC+K0Jq67ClJ86d/w9LHhdxavRr/5N6FP9gQXxeov60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k1iWSyMSa9DctYHAfdcXOngyGZYfrtSPgnzoqSPG9rzC54iW3Iw5KlCgF0Obz8+JtQ7WpbVZrEo47X2w8dQy94LFQY9f1Vmk+AaaZOczY5vSdulS6b8CRmY2J1cUbBxOAut+n0olO54AIc2ixS/kq2O/2QZx/QUDzrke7fV8knE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+slZ+Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A03DC116B1;
	Thu, 11 Jul 2024 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720725091;
	bh=fC+K0Jq67ClJ86d/w9LHhdxavRr/5N6FP9gQXxeov60=;
	h=From:Date:Subject:To:Cc:From;
	b=D+slZ+Wj2Msp1JulHkHQ78oUMxQSVhlk8Q2Iz1FtSO7hzDFXeDkeGEe4McD1y7i1D
	 V+JSegt/l5SlF31EkzdUQiYSmIW/ruDZqCRyQIoiD/9wY1Ukr0XgeYcs/+8ipecdu2
	 BvSF/sBZzfumQTlemXB0fW/k9630xRB4uNXsBkxQ0aveHFU8mIBszclzn0sEn4T35n
	 X5IeqJG56Az3hbzef0hDV0cjF7+wrKn3wgeLLbr+IHqwx+o/JWB6iynOR+m7N2o0ob
	 tBAEpg9oWygMtcrlo5ALC8wLISUjhw3hCJZ+BaCYs83asoJf6yv51nkEgVcJ3VaPbw
	 cnBdPNwHsSQFQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 15:11:13 -0400
Subject: [PATCH] nfsd: remove unneeded EEXIST error check in
 nfsd_do_file_acquire
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFAukGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0ND3by04hTdvNSKEt1kyxRD8zQzs1SjpBQloPqCotS0zAqwWdGxtbU
 AYE97FVsAAAA=
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Youzhong Yang <youzhong@gmail.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fC+K0Jq67ClJ86d/w9LHhdxavRr/5N6FP9gQXxeov60=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmkC5fL3+S7+8H+AWwFkjGAKKqQKQcf7/3KIE09
 ou1rr/We/iJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZpAuXwAKCRAADmhBGVaC
 FWAgD/4myJRLy6cu9TMrZSN+i98scxYhyYHbBj7Zx6xa+fuT7OMfjL1/vdDBIX1mMW0DyQitQRV
 b1JvtSRwB9nftytYP3hfWinBt9dU0Xxr6hQ54jXp+h3kcOf3E++G/B73BWOhXF2dXRAprs9YpLu
 LNrRAJ5vpEfqCsvLT36PfiYhWs/+uSerDDBRIjqnocmf+LZVyVuVgfKPQNi5PpJOgrWEWGa+WZv
 xSl/2DDa5sceah7vaUgfRAepiTmW4SZr4/uY00mYnsQhXQ1bVnoe+r9wNjvwxif9sqwDzvlc7tU
 /grGADpJ6CzkH0LdODLzPR/Gz10EWYOjslrGm81itl4nTIFSkq4YPkI5jz4H/pl2/4DwDyF4BTL
 Cvl//rorBDlkOoQ+Aa1/+gnFKzsSdwyR63ShQCkcDc73vkFvSwJz3TmBs6wWbIZXojABbluhnpz
 9ZnXhmlaHrKFkYH4XXpDbQ8q7tldysqhy8zScMI/7dvoHTMgLil5Ne6TLRj2DwxzSE8e+q8CDtM
 mn5KwfpzmD7p7sGqPrYLb2WhWFoe38zOy9f/1UFsHKBDvGbuKBi7MIAVl29z4ZvZ0bb90+MKUpk
 bcwGnpLxJ9ESQVMa+Kza48dmI+yT1w7IzWqpvQrBzOjmVxNtJ9XK3B054QPZq0UrX2JD9f8VYhf
 7H2NKTV0Hv12P/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Given that we do the search and insertion while holding the i_lock, I
don't think it's possible for us to get EEXIST here. Remove this case.

Cc: Youzhong Yang <youzhong@gmail.com>
Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break error")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This is replacement for PATCH 1/3 in the series I sent yesterday. I
think it makes sense to just eliminate this case.
---
 fs/nfsd/filecache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f84913691b78..b9dc7c22242c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (likely(ret == 0))
 		goto open_file;
 
-	if (ret == -EEXIST)
-		goto retry;
 	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
 	status = nfserr_jukebox;
 	goto construction_err;

---
base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
change-id: 20240711-nfsd-next-c9d17f66e2bd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>



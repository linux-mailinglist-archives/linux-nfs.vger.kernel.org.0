Return-Path: <linux-nfs+bounces-16773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C90C91062
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 08:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B22214E3F68
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Nov 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECD2D6E60;
	Fri, 28 Nov 2025 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpACocc3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB562D6608
	for <linux-nfs@vger.kernel.org>; Fri, 28 Nov 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314412; cv=none; b=mDUhYLo6W+nyetyiRD11GB6QoU9UM0u7w1v9hyrtnb4UkFpsKoP4QSb7urCBHTKiM2rtAAAcmtA8rkwpmYedakSaNn/fdyf+4KBzBmnk5S9ryPjzcosaBB32p3hcyD0lnRJ8o5K2md/aM9TdrUMdVpg24QgAtT34Fei3RrvPOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314412; c=relaxed/simple;
	bh=GSqGL+2jwOxTnifIayZVPqqUAUSQExhlX0Bt1L0LdMU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pFM3U4EcEumxoiI7vlpWrHrQ/VdAUmAqZp7gvHiETLC3xTtEaS0y/EtbBUFBeZA8RDauDY44vVTWya/ym/vddV4LoxXmToi5wtA6O+i6Q0O9r/nhxQvQUcQQS9f2DXBU+Mxb5ziydRNyjzvT67nfY7JzQKfFY4AuHEIyMbkV+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpACocc3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so1702565f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 27 Nov 2025 23:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764314409; x=1764919209; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLx66B48vruwXq/LvVUt0v7+uKP7BZ7gFpdnpilBlW0=;
        b=dpACocc3maUeW6wNjTFjGesbfreOW2DkL51ii0/hgRj6fcrtmaozInQF1Ft4ehqDPU
         U9eTs4If6xEB+aLRFanAsQSUTwf1v6CoTTGhpUlMX+YBSqGJkbL136KnowOmKwkKpalE
         wy5oc+KsnN8dr/2EJIhRkB/Yeo6EZAmBGghRZKAcbdGxb7BE/rFnXlhN8wxFMpGrbIwr
         sT59eOdiyBw5K1kK++zlLfw+/gwdrzz0fAX+9M8iUhRgl3ODOP+79S7g0o63IIHZJEa0
         W11icxWm75nJxoCRo6SCyq7DUWoOp1T0Wy5aSc9F/InYD6/4wj8F+b0KCjew6jUKn2xA
         x2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764314409; x=1764919209;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLx66B48vruwXq/LvVUt0v7+uKP7BZ7gFpdnpilBlW0=;
        b=QI1L5/5lz7MGo3aUSZisSIrRD0EEjJbrYFT1fpd4Xk68Tv6ea4PxuIgkH6GajzRO5V
         KM2G+HtBlhyk6/QrrkUs7y3ubpJuOQASBxl4zpd4bvLlI9nyvSZ6yxuCtVliIEl5awan
         lCsgCfTH04r+Fm47VvQJvo8I/aJE2sjzkq3OnQRLfTOPO+5CaBNLMkBi/DJGdSNWeWGl
         kecqXaoesmBjR4qHM/SRGbXxsv5uT1edh8hAotuCUd+ofRnbIWhGFjotCtWVStrzTYzi
         knzvfbgqslZ38cWHbulUe+r0ca/TpU2MRntAy2Q6L4UMLaE15RG25QdqXGJPMqgLz3wz
         opnA==
X-Forwarded-Encrypted: i=1; AJvYcCVlPnnpLM3YEEXMoC4wONj+QU2oW9RgQEfaJ2Kvdo+Gs4ziPIEvprTnHiqgySgLVAnQE1K1u4/PHDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwplAVMfNzxaeFsroyasSHrVCWuyp6dShgzHzV4NyKtBD1k1Phs
	F/KqSulDoyeTf/dNZphYtdeLBJbTuSJQ1OIWxjos81aRLtP8WHk6jVpfPMlFu19F0igNorb0sMS
	8rs2m
X-Gm-Gg: ASbGnct4W32L33dKFH7YUM7VSEJjNAekDaaWQj5PMqnU6E2S1DERrrMEnUCa/FBFsgu
	aTxxg0TLKUEpf/GXcHFthLpUkyXzgCtS+g+bGyI78Buu+a855s8ihKchEX2/MkhGUn/88vNXMDo
	OZRnvZMlNuPmLY6soijR5nmwl3y+0fN35UdF9h2W14kciEI6ai2dIlPM794nR+ycWmupxvxteKh
	So14sTIeyxhNlNo1v8jUhbk+2y6d47lAmd5WL8DsukB1bIBVew/WoADMD5Axnye1NmNEEgS7rcx
	y/1OdQZyvCNsEHbSHfWlO9N4gDCQsVnWCxNNy2NmRhutcPa0sHwcjZ6JxHmMqYTPy4QHo+ATRQf
	1PB8ARLVsB0ZafTFe3pzEZlAkTJGMUnDzVahfevjCzhmvGTlyNuRR05SUOLy7Akd091M15UY9X/
	Nkpgj39p+vZpJI/0PS
X-Google-Smtp-Source: AGHT+IESk0sJzgjz3Kc7l7TOO0CeDy5XVUSh/HagNXMNXKBENOnL+tQgU1CJrI65eDMKQmftuWUGIw==
X-Received: by 2002:a05:6000:2689:b0:42b:2eb3:c92a with SMTP id ffacd0b85a97d-42cc13021fbmr32625656f8f.12.1764314408929;
        Thu, 27 Nov 2025 23:20:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1ca9aea3sm7775019f8f.35.2025.11.27.23.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 23:20:06 -0800 (PST)
Date: Fri, 28 Nov 2025 10:20:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nfs/localio: add a tab in nfs_local_call_write()
Message-ID: <aSlNIsLAEsV923i9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There was an issue with the merge and this line wasn't indented far
enough.  Add a tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/nfs/localio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index af3a09eace77..47ec3437fbd3 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -830,7 +830,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 
 	scoped_with_creds(filp->f_cred) {
-	file_start_write(filp);
+		file_start_write(filp);
 		n_iters = atomic_read(&iocb->n_iters);
 		for (int i = 0; i < n_iters ; i++) {
 			if (iocb->iter_is_dio_aligned[i]) {
-- 
2.51.0



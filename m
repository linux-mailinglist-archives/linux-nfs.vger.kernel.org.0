Return-Path: <linux-nfs+bounces-14046-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC0B44601
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECAF7AEFF9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0445526B77A;
	Thu,  4 Sep 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnEc1ysI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853C26B2A5
	for <linux-nfs@vger.kernel.org>; Thu,  4 Sep 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012378; cv=none; b=pyeZHWFRKW3Q8eTL0RU6SvbUyT4l2m2je2jz9GRL+nRCDhccDUC35QKnx8kEL8COJx7P4shiO7k/yPfDH8GBXiF+H54m/xaMjxKSKeQjWs/eEr8PAnlApjdjbA31LEXZf0TaEe0RR1pjUCKdPlYiGy8EGXYt6OZwZiqO3SCIktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012378; c=relaxed/simple;
	bh=hl7UzHlA38V4Bluawkwxwy+Rq2dwVuzKGOkhwZEGe7g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GqMMxCGcr11pqgyIeozMvVRbPBBY6R0D4Cl9FWLNPvaGETR2b9KwjnbPxy6fxrEnlBhDhyLGBVrJ283yVRdLInuhXQAGJpQz8OWhwIqHmCAS1PDEOijyt8uhkOmmT/lW9e7hSyLShhZ5PYLg1YscttFuHBOiaDcZ6vjplSUpuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NnEc1ysI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1221367f8f.1
        for <linux-nfs@vger.kernel.org>; Thu, 04 Sep 2025 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757012374; x=1757617174; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWB4qwgbKVqfMW1WmVN2/rZ5+FIZKuDCGHJqFvd3HhU=;
        b=NnEc1ysIVFU8Vkyh5N+4Y0QCfIFALGQjVEJD3HeIOxLPNnGGtg23H6Ez1mKyrbM5jY
         U9FV8ya6o5MD2QklYYMFVO8LBUC544+VECkAzCvbYjAZxsWTjRamajH1SaYoBd/erAN0
         Hk8eZ2jk6D3vOry9FasFfwfURSI722amFs/EkbtKRYDycrK0E8THfC4pLj6E6jYQQgc9
         bkdOiGcub+tAhVb5px4lEzuFco1mnWjiVn1aeG/YW5c+5Zin8joQNAH1SOvaEkFR6Alj
         p2zj0Msq9rsFvBYnWMxX+g0opHoDxis7xkRS9dPtE1MfaPeMvPn9zQbGkTAzE5GNoFLy
         II2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012374; x=1757617174;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWB4qwgbKVqfMW1WmVN2/rZ5+FIZKuDCGHJqFvd3HhU=;
        b=MtZcgvigKZ9jNcm22bzPBhCZxhig8oP8UzsbQO4lH8B+uYCesIxFyUsCitIKfeK0K5
         FdE7mwSsAE3EB8dIz5QZ8HDIBzGSSIiraKugtWXN87M+rkNBMu0CUrAHm/QKS/oKZk00
         euv62ddV2HzcC7/EUDOCA05SokItrnxUSYK1oyd1q7phnF6uPRjlwAoUhTu0+8uygL3n
         7ELfPqGzjFwb5vtgV62yXWOSTtAl/DLF+Ty/JPePLOKLsGHl5uveXx2BX6fay9Hjtso/
         xRMuuAvrgMb/GiJ5T/aqbdecz+55UXR16wm5D84XsO33pM3Osh/HkYMQvadPlzBr+WbS
         Owiw==
X-Forwarded-Encrypted: i=1; AJvYcCVl3tGcq+xdhCMwu01FUuHrMemOzJGl7H+BoUV8RD102agOOM6sBGwTYI+4ls4C6w0ln7BSStOmQuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDV+fsKiYQcR/PAIq+4uVQfqorasQa1myHpnKfWQSujxVOw1a6
	FUQqTOPg0sa6IQpIRQj9v6Omwra0PpQPfEMNrO3MXNJguGL2qO9xr0UCh1OegzME6+4=
X-Gm-Gg: ASbGncvjCBX0WKc74+H9tl5TvHitkX5mrahOalWIVdO5ktdKxJi2pUCSS8Qa6gHhfMm
	dIW4lHRvpog2qzt8nuHn4TLvBC1OC3733Q4LBFawKpG0o3vBcO66oJXzvSl5TmDPPj3HaAXa7Yj
	vQSiHUZoIYOCeDxdJKjlhL+ukurrZbh5BK+7icM05fv5nIUgHZbVaD2vq6kOodFjsqC0uv7Tc0S
	YUv5js6AdoqifSzHB9daoh7K2x0WpJtyOhUmmlmUL0jIk1/DuacYvQ4Xvko2jiZsYBE2Uo2PEGd
	dDCOWBvAcWeXjjoaudRZAA3FGUhJ4gR27KxTSDUGRcPq/eZGK4CIFh5eWvgwHZ5WRmvgmtgdM0g
	JBvNYCC+yCT1schFYgEN60zreEUw=
X-Google-Smtp-Source: AGHT+IHZZPprzS9mbuO41DYFLAmvIcfpOdVZu+bM1xROID69orUBhGlsV7b4geCS+yXzO5UlL5rZ+Q==
X-Received: by 2002:a05:6000:178b:b0:3da:d8a1:9b6b with SMTP id ffacd0b85a97d-3dad8a1a85emr7222669f8f.3.1757012374584;
        Thu, 04 Sep 2025 11:59:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d1007c0dc8sm27028606f8f.53.2025.09.04.11.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:59:34 -0700 (PDT)
Date: Thu, 4 Sep 2025 21:59:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: delete unnecessary NULL check in __fh_verify()
Message-ID: <aLnhkm7q1Di0IiIu@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In commit 4a0de50a44bb ("nfsd: decouple the xprtsec policy check from
check_nfsd_access()") we added a NULL check on "rqstp" to earlier in
the function.  This check is no longer required so delete it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/nfsd/nfsfh.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 062cfc18d8c6..3edccc38db42 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -403,9 +403,7 @@ __fh_verify(struct svc_rqst *rqstp,
 	if (error)
 		goto out;
 
-	/* During LOCALIO call to fh_verify will be called with a NULL rqstp */
-	if (rqstp)
-		svc_xprt_set_valid(rqstp->rq_xprt);
+	svc_xprt_set_valid(rqstp->rq_xprt);
 
 check_permissions:
 	/* Finally, check access permissions. */
-- 
2.47.2



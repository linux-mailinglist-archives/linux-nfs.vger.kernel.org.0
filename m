Return-Path: <linux-nfs+bounces-6550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B1197C637
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 10:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B436A1F26081
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A719882F;
	Thu, 19 Sep 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQAuY8fW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280C1922D6
	for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735841; cv=none; b=EbCnuUnAMmcphj0DbOHdUAc28FW8mpAu7qkat+coM7xWZOVuDQWxYfM1rYSXce5wmGNOs1pup0mtxCptguWI5pR4toK4LQtSsJE4nxDqjSsXhd0wb00iJD4sv/uHAf2LKkpFEzI7GRoJlr5iSkGlwX/LySCRc64adY5+nF/dItA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735841; c=relaxed/simple;
	bh=LrJw1AhJz7sTYbKD7COLqvtv/WahjF0UZSPF3n8L1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m+XTVfYnvG/eVrHIJ7AW17Cfq1JKrkIDwuk/QJE6bzSTqMU/G98FN505Z0LY0zEkfpV8WOQ2922a+a6YynBjQCNZbsOzQNnf02aS1SsQXsq6TnsWydgzMCDzs+Uipj9e8YQ8aacXgLnr/GU+eTru5612YZz0HciF4I5xIG/uW8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQAuY8fW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so769081e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726735837; x=1727340637; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aXfImNByrHCJYvhykUtqf/Cf9grdz1yZdroYSEnzd0=;
        b=LQAuY8fW4NCyS1obfBddcWXm5q8x9UBkqWcTcNuq39VQ8DvPzDRgXGepireJAxFcZb
         v1HbwpN7ruzLIsRW09u3lo2knxxJ7PRZ5kMdC/FH/GOJMv3MGnBYY+eQ7jf1TpXbBqcJ
         T9AS8XOPIQnk2LVF37fDiEjldh+c/oBO27fvXVynZPIYx8CWceuIFQfHQTuWMyaNTPUB
         UlFQ7y8Z/WD/qtJYvQSV7VeBKUn84c7W6aKdp6hDLi6ig3u+yrMYkq262AfSVj3mrVqn
         NuIiAC5zxUHg3WRXc6nY4kc3gago+0/XPPNZKBWcsnGYFTbHCm0Wlf+eqVN6QSRAnOWW
         oLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735837; x=1727340637;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aXfImNByrHCJYvhykUtqf/Cf9grdz1yZdroYSEnzd0=;
        b=boJRmKlPjUDQzRt3Lg/J+n5KJ7CDLzdb8WQ3Qd8KCVhLaynv/rM2Vp8tm4rkFUAxcn
         E4/LtlkoLxMof4bN6R+Kuy6vGwYDWA27fVYcaORkBVMQ9cby0cR9d6xVBnk6Rn6RjluO
         yxqtvxaSrijDDV3tgcUxIag9To463gOctahS1O10GV7XvYMQcq9I498Bn/w1EvKItFj/
         03Zb9pqHQPm6RG1NQh5hhJ31xGE1NzjZhtroM6IaX7QyV/Ni/NQxYHQmuMqQ+aflCZXK
         6EL6gSp+Yb+jN3Ru7WWx/cYOehZ3nHD+FxyHwp3UyPc7OpnsmgNGmGTuoIeTb2OqkenL
         fUlA==
X-Forwarded-Encrypted: i=1; AJvYcCX84xo4CYE3hLPYFKz6TIXvyd34JEjwi7OPVGT/X6HslUFxSAaEubX796pK4QDyD0555X55a64bzgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbG6MZw9APJkiYqrVr4ejJHd4Gd3IwPQaHKycrZicl8NA9jnzp
	8oKWuA1I0Ry2lnjiL/zf6nMOAJMkVMG14fZ4LEm32/hYvNc9hPjP/LFCkViQE2Q=
X-Google-Smtp-Source: AGHT+IHSchKP46mdULrhq3wm2RZ+wk7t1utwjuIcumCt9aQiICck+yHRyOAOwRnLE0p5ES06sz5eOQ==
X-Received: by 2002:a05:6512:1194:b0:530:dab8:7dd6 with SMTP id 2adb3069b0e04-53678ff48d5mr12195614e87.50.1726735837431;
        Thu, 19 Sep 2024 01:50:37 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb533besm5833278a12.26.2024.09.19.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:50:36 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:50:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, Benny Halevy <bhalevy@panasas.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix integer overflow in decode_rc_list()
Message-ID: <a13af2ba-5f33-4e9c-905c-0e0369daea6c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The math in "rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t)" could have an
integer overflow.  Add bounds checking on rc_list->rcl_nrefcalls to fix
that.

Fixes: 4aece6a19cf7 ("nfs41: cb_sequence xdr implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.

 fs/nfs/callback_xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 6df77f008d3f..fdeb0b34a3d3 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -375,6 +375,8 @@ static __be32 decode_rc_list(struct xdr_stream *xdr,
 
 	rc_list->rcl_nrefcalls = ntohl(*p++);
 	if (rc_list->rcl_nrefcalls) {
+		if (unlikely(rc_list->rcl_nrefcalls > xdr->buf->len))
+			goto out;
 		p = xdr_inline_decode(xdr,
 			     rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t));
 		if (unlikely(p == NULL))
-- 
2.34.1



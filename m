Return-Path: <linux-nfs+bounces-14623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDADB95732
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CF2E45F1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A8249E5;
	Tue, 23 Sep 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLIAe+mH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0A224F6
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623898; cv=none; b=u9YGYG5bkKiWWukcsVViNM9c73LdWRzcR3fWbWmvg5noi1bAL5Q2kDr/sc66TdHFnkUGzotQ1NQrtVEDclJtEzEchfI27v6AHz4jKm6dEfVkzRBrpCemPxP0XqEMaHbdddDFAtvJ1NFZ+G2SbQJW2TSEqBfYpWx6pNKhV/+qZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623898; c=relaxed/simple;
	bh=thysl6WrZTUBUOy7Pu7XgRuHTaY+D6D3qzoLxDI6f5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e3QgjOVsa/rsSrDrCg8lQTMmLUwH/66YOcOIGFouc4LNUaY9mvsPkxFmxMYPcjS/mGLZkUYU4Zx4zZ/ZP+ooiif6JW4UT4nA5FTEL0CEAGYb63cpPY2+SLHgW/JuNp2zL1tSCXnGOdNs83FRtZVuE+/0Lg4hQ9GT63Jdz2cOrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLIAe+mH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so33193435e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758623895; x=1759228695; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdkoM1pggmDv/Fy7wKaUwD2wKuLQ20v7GUqdXLeKYYI=;
        b=YLIAe+mHqmo4m5c+WXG3s9xNt3dCCslrD38eSJyqhewb2UY1oPXggdXozPpHEK0o7d
         Sk05LmQCuXVRiz+OOCK3ifR8NT1GhIDZf1lva2wPBmn2vj/fJXu6FpGKTQOaQq+KKUf0
         E79Ipup965H6VSytgbK+nkdgxgileb7mmqHqPhXxuZU/ib0c0GvuILIPBbm+WqXkjLob
         7RtWouajjLBeeOe/wjPJ8h3blKDEds9H94EdQa96N5HicLJBiAcYQPQkhRYoMB7fl03G
         MOlz+ROhK8bMGiIdf/eaOTEN9UO7GjXn/Bo7WEdzaBd1Be/JLlxRGJiu+HVbwH57hEkf
         gHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623895; x=1759228695;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdkoM1pggmDv/Fy7wKaUwD2wKuLQ20v7GUqdXLeKYYI=;
        b=wNAFtF+yAq30UtlgIc+b8Ij01qV4KV0Pju0tGl+DjJqTwBPNSoxZEJau8Bem84oONm
         ChuQyxlqb4ATLL5X6RLzsMMClpg4hDBkqnoqLXGleP3UZVLB0LkJwvwtdM3bUnvlhsw9
         IDB8Kh5o96/RIXHzIwhtZYTZWvvuuW1C/f2s0ujgzX3MlU0eL+SP/33HYnsACPHSPFJl
         rqUokRV631PR+2UFUFLHhf177fTvfUICiCf+oGlkU0xHPCbkxJ388mbGAShOqV7/vG1b
         XUsGAya7P46eax7qiPuKPQQEUgS7UGi0Ldlf/a9fmx8k3bDnEndKycZc/C5/B93Hw2pO
         XX+g==
X-Gm-Message-State: AOJu0YxI9SWxfzt5FPNLvIraqZMDTeyhXF1Y+RXSTZqgtp06CktVR4bL
	t+mfyImtJGYjWHdpi1NXiNV1j1QOPAZ+a2pDOxagS5XQSNk1kfnrWYztvfFjoKCWGxs=
X-Gm-Gg: ASbGncuRfA3GqzCfq5XOZ6kCwyezAdF4p7diNNZj3ivLsYfrqXqEsAJrqsZ+yKhD71D
	U0c4a4hiSn+0QNhC3SuBaTdDHXvh2L03p81UEKiXqpm/5fM3j76lDrgtEksb5lcA+cpvy8iMjI8
	glC5QPXHUMHpwv0yZau+H4iSTMF1hLIlTEfhfk1uI9G9chUpaKLcL+wok3VY+chTk/69ZmDyusr
	E+5/7LVovGPr29wK4v1wNLG+jWvg2lyc+njummUo3ZG4He97WB6aWnly8MOdocB77Lm3Vwo4si4
	AOrNuG3MtMxMEiXzIODXGdFJPB0myctMZM50+sTcMPgoSWzbbJep/DO9worJaYwdZ6c566dxN4V
	X41+3OGwzBfyo9ppsi01qae/Wr9kO
X-Google-Smtp-Source: AGHT+IEBCpv1V/k+AXYIzvlBfnQiD9Un0WPQ16gb93qDyJTmgAb5qlzVnq8ZglqGv8h6OhjxJhD75w==
X-Received: by 2002:a05:600c:4ca1:b0:46e:1e31:e798 with SMTP id 5b1f17b1804b1-46e1e31e98emr10584495e9.19.1758623895370;
        Tue, 23 Sep 2025 03:38:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e1dc3c53dsm11347565e9.7.2025.09.23.03.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 03:38:14 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:38:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Curley <jcurley@purestorage.com>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] NFSv4/flexfiles: Update low level helper functions to
 be DS stripe aware.
Message-ID: <aNJ4krKOHNu0sOKO@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jonathan Curley,

This is a semi-automatic email about new static checker warnings.

Commit e142d1137b17 ("NFSv4/flexfiles: Update low level helper
functions to be DS stripe aware.") from Aug 25, 2025, leads to the
following Smatch complaint:

    fs/nfs/flexfilelayout/flexfilelayoutdev.c:598 ff_rw_layout_has_available_ds()
    warn: variable dereferenced before check 'mirror' (see line 597)

fs/nfs/flexfilelayout/flexfilelayoutdev.c
   596			mirror = FF_LAYOUT_COMP(lseg, idx);
   597			for (dss_id = 0; dss_id < mirror->dss_count; dss_id++) {
                                                  ^^^^^^^^
Dereference

   598				if (!mirror || IS_ERR(mirror->dss[dss_id].mirror_ds))
                                    ^^^^^^^
NULL check is too late.

   599					return false;
   600				if (!mirror->dss[dss_id].mirror_ds)

regards,
dan carpenter


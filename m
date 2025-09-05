Return-Path: <linux-nfs+bounces-14057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941C5B44BCB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 04:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C66F1C828AF
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2552701B8;
	Fri,  5 Sep 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkXtA3tr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F0230D35;
	Fri,  5 Sep 2025 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040466; cv=none; b=aXwNSV9OVY8Tw+PMONtDXacJDchhy+nJ0mDTXueVhfGOp4w/9GCUPhfhnL/Wxd5bLjmeijkCfvfpfMTY8u5LzC2YwwLlMZxMhdD3xQMFq94K3Arq6ONb4DRxhwU0YdKEfIiTtMP69lSzSEJQq+8tijereZCWc+rZJrsa4l8Pnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040466; c=relaxed/simple;
	bh=J+sdQWSQrZpWZwQ9yjccb0lgc1cwDBZzL9qHXmDzZuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZersRzxDsAOr+he5qkE71vbA56iFCmQYx1pA18VAvRz0gpVOGHvWM2LqjOCUVGb08XJlk9SbS3/t6ewI/4xyPjStlPO4lzwI2SoGuBWb09XDTcssAqCqMjXs9CJDOV7aBEsoEf3dBdiatNI+jjxsVa+IDdlltEQbYN1Hm7kdOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkXtA3tr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7725147ec88so782634b3a.0;
        Thu, 04 Sep 2025 19:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757040464; x=1757645264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCaQeEoiIyJ+X9I+BeUdEKTAO8qJHTIamDyt5AdyHmg=;
        b=MkXtA3trt24gpvkFakM+VKN5l2kB19u53MPLb7nLjUPe3dV7aK1G0EsYroE1KwaN6S
         zJ+h1lzdvhSu4sd4G1vGW5xQHCtm1VTF3K3yn3CyC/CXQvYRG4iYb8wSJPkvwYcPtFUs
         WNB8woqErgZWUZqQZijoGHlcBPgoWZPcG4hGjOvB5LM1M6ivLQ0wn57dtnb990moCRaa
         +XDLjbvUfNDs+uG9ld+jeGs45AayjI//eFXeWpe3/2CFwI7aFW2iPpwNJs8oJQu2dy+e
         iyzacaz3zdS/MyGamMbhzI9BOwHzOFUjIE/OSLuEuLWMluKmrOE2EvgVh5p/tNkrOmCm
         HSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040464; x=1757645264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCaQeEoiIyJ+X9I+BeUdEKTAO8qJHTIamDyt5AdyHmg=;
        b=ZvP48bvO03VB0Vz4mrttTGkwZt4BGQZcvZxVA82rfDRozrUF37z+HFtoWjvmMwb5l4
         aHKynAZQCUalo+RwiEycHI3wZEZWxiR/btfiikF8Jz/YQQP19ZexbK6m6UESXpAi5t63
         nBbMrwwFYgvSxcfp5EIV1ziZXcibDcNtpLmf+46tzchd/8dToKdC6AAyhjSHcDC82mfQ
         MxWtWz/cAhq445VM5Q866FQ0X4KzX9szwEGDnCuUKDpiUj0USzdNDSoEtMxlqRRn/LU4
         VVyD5TDV0eDx+RUk1/o/RJX3EiY7kFtroPf+3iFa2ZcFyB0dsJcJgWlEpE1MwB1w8kek
         ZGYg==
X-Forwarded-Encrypted: i=1; AJvYcCVJAGlQjNKge3TolC09E7P344fz/+k5A6sPkrNt6TyvJ1BjyFj9aPtOD5e5sQlpgRvUyOGnWS27k3jbGg0U@vger.kernel.org, AJvYcCVUjQjzTX17l1gKFFRPnP1HPtkUzY4HgiDCI34GWmWSPWH/tfe5aol7DyQnLAT/HvRmD5VF61XSPPpp@vger.kernel.org, AJvYcCVzH5pUNQb3CLjY0iILN3Ry4+VebnMXLo/OcwN4fuVEN3gIsTA7DbaCSR5+Fw9rR81RxFWmA3Uq@vger.kernel.org, AJvYcCWkCBvyTOPH4NIKJfmBtKdgV98mDZW1BkxToUDnp5/kjUcUMzEkyuMMkZbnHxujoXgSreSwRJX/XS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbpyfzIBQEVY0Tt7glOvtocd9i3TwYshrwJXQZbHWyB7V4Ku0
	z6BHdQjMXjQMmgSFb/uxvm2m8N0yegDmNZsGEBGVKwHWH43oT+evqshP
X-Gm-Gg: ASbGncsbKAfr8TtxP8akjmCBg1159biZU2y5e4tqvbtc9QaviYuGavFQp1oSL/JEv8V
	ENgSFwJHYQH2DgRKccY2eiuBNIMiFLgM+JouG8EM9dAYKa5Y9jgm08EZg4WCclYldMl4bVBHYqT
	nRiMM8JrS1vTVOKEffP/BCrEUd3OiZCBrAV8+PGs6ympESuD7erqnfcDoTJRKHfjiPplCwsA9Jg
	c5pWe8Clk8FPBZdOypa4DvdWW8V0oyjDD+zWCe1Y7x3Ax5KTiBpus19817Xi0TyxwT0HwFeUg0K
	73arATAjPCSevkjMuKXyk0B4nUhk/yuIzDp54JKtJhdw+y9/CAZ1/GYv/m0Eh4yMr3a+A7G0vTr
	oyLmGTWhOeUlMlqcXIggEM+8xoB7TnmIGCTFtqN9zuBiCSR6Ub1OsSZvUa/t9Xz4Vq1MVliSddH
	1km/j8kRvE/fiUFapUxIot8QTPiC/0yQialE9fdA==
X-Google-Smtp-Source: AGHT+IGyxjGucAcq4/CU7sDyIrxh2LLf/2cgmkqvjOqu7ZTDbk8ByUwUxM4eRmIFb4t/3oQsNifJkA==
X-Received: by 2002:a05:6a00:db:b0:772:6bee:9ff4 with SMTP id d2e1a72fcca58-7741bede44cmr1504866b3a.5.1757040464162;
        Thu, 04 Sep 2025 19:47:44 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772590e0519sm12991858b3a.84.2025.09.04.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:47:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 4/7] nvmet: Expose nvmet_stop_keep_alive_timer publically
Date: Fri,  5 Sep 2025 12:46:56 +1000
Message-ID: <20250905024659.811386-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905024659.811386-1-alistair.francis@wdc.com>
References: <20250905024659.811386-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/target/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0dd7bd99afa3..bed1c6ebe83a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -430,6 +430,7 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
+EXPORT_SYMBOL_GPL(nvmet_stop_keep_alive_timer);
 
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
-- 
2.50.1



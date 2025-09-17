Return-Path: <linux-nfs+bounces-14527-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A80B81D43
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F658580E90
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4AB2BEC27;
	Wed, 17 Sep 2025 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BPBXXBrG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065727A92D
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142119; cv=none; b=F4DkoulRxSQLjHeKtMtaukubahPW+6+gdPidbO0h3lrfHQq683ImZxBW8QNnBX+eUe/YpQHjMOs5JG+APJrzkQcFw3W+4MQrsCX9nQsO5YHSKFrUk1M5o+XPqTYvJrPNxpPpo5f2v7Q3M9AV/sgyXr/iC5OuPIRVlZCHHTbPXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142119; c=relaxed/simple;
	bh=C6pIljQUVbXribM74eO/Yi4zDmJMVwzxtOTyMoH2G6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=panwkYojzjCKCKO9URKOtazsi6XdFXTPk4Hc7wdGGkdUVkDannpImUDCCaGMPmuebkXXsewNEw8not1u02HI0tEVnSB/70ULZbkkAzU5TtZ6VL09sOoa2w5tOfonqB6nv77uYkF/QLfyDfbi76AGEcZ59Q5/TBNuHiQmuM/CJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BPBXXBrG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0787fa12e2so39205566b.2
        for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758142116; x=1758746916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=BPBXXBrGz5eboRBhVdVKI3PBifYmbeJ2hcP5LkZQ6Lp02PYMVJxmZ7QFbcb268zk+b
         3vpBccCgsN3NYAtW7dlYBlTSDCPrEWaSCOOyyYHek0TavItj+xUbKZoZw9fen/M6eGIv
         Z5xFwZbbg2DTW7LnkWdk5HDm1MGBLJHk1ZVgdRCceYc2Ywgau2FZ+xKVSpxpHmePHF1W
         zyRotAocVseuJER7K1r4e7U750YPoOg09Wfh5FkfLZ7EKQI4PoaXE7y/rSZUoUUeSGBe
         7GaOoa5VNYCvQZMfBaArpuiX94WhnwbSw6Nt0u6djl1K05RMEhzoXp259CAIpCJuZ4V1
         Og8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142116; x=1758746916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=dEtVoB5/Xvj+NSOo/K29C1kOyzqZlfObJtjbuCDY3B7qVfAMKubn/pGuLtBs+q0jme
         xFA28QqqLf9RvX0Wu2l+9/uMqN9ItZQay3Xc0KAKxdYaP6NO9xaYAlSv/PeJZVbha3Jn
         EV4ovNS2XQiTYtWsLFAB5l5Af4LMJRTEZ5u4Zidd9PBpYxsPvumVAZqvb845lNEvn+EG
         g63NBCd1GeUYwBrLBGPCVG1kV9fdoVnPE4BxYOvXQx/nLbeNTV/itogbn40ATFKkJHn2
         eSx9sVsvtJL5HGmgirw+6aTdzw62aQkcDc8uExVCWoXxzrY79s4A3jxzfds2XfnEQz1b
         ujow==
X-Forwarded-Encrypted: i=1; AJvYcCXjrraCD3qlAjMCOkj0ArLMZWWZRmGr4y8LHgjwlztch/sKx92IDFx0oFK5mV81Uj3mcsdrqXeB+WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrokE0sJ1kHIW+Vk5Su0/aJstNlz+RdGwZ6coAvFhPG8zipl20
	VDchrT8Ntu8PdJC2C6V5tR1Tplwg7Boqx0op81kUm9p3LajQYaopR2FWK/IxB39/4eRX/UrtruO
	D7m8Q
X-Gm-Gg: ASbGncvsBDNdvhe5a57YEKJJTypTUY2/693AelcPQzi4hvjKvS3vz+CYBT0kyZ6nYhj
	kx+t/GKds1eJUQjFdCX9m6B1QHGn5jncKxTwBPlSBMisDP2gfVNhJi8N7japzKlPe/1yDbDyKUb
	yMu4g12QkZCh2l7XVQzU66VwlnHDhcPU15xPn4ISGc99MxxK4ciR4symn2+VuYvkmw6eTqChAIY
	lp4nANGaofoCr3vvVTC3t/Tyu5cXFQgnskcJYk0qYz9+h7UDJx3liEVidkLUYBovHCJc4awigRH
	HXfdybqSSMRM+azlTxFNOuldUqj3UHiMi1feerhsMI8UyV0LpVnDRlZHr1O30DiX8yJGQ8Mw1JT
	MloMWzzIUOzpMmjo04uegb6pGkxLYhU11Jd7/Zz8gSA==
X-Google-Smtp-Source: AGHT+IEluVq/Wjt7pCqe1WXpD9HX+pPiy3HTLaYz1oMHA2x9zglfM6XJw4KI4P91qjd8kJjFkphyOg==
X-Received: by 2002:a17:907:3fa9:b0:b04:8496:64f3 with SMTP id a640c23a62f3a-b1bb9268143mr379475566b.44.1758142115587;
        Wed, 17 Sep 2025 13:48:35 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd2814abdsm42649666b.108.2025.09.17.13.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 13:48:35 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v2 2/9] NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
Date: Wed, 17 Sep 2025 20:48:20 +0000
Message-Id: <20250917204827.495253-3-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917204827.495253-1-jcurley@purestorage.com>
References: <20250917204827.495253-1-jcurley@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct this path to use ds_commit_idx. Another noop preparation
change. In current code commit_idx == mirror_idx but when striping is
enabled that will not be true.

Signed-off-by: Jonathan Curley <jcurley@purestorage.com>
---
 fs/nfs/write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 374fc6b34c79..422bb817cc85 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -977,7 +977,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 			req->wb_nio = 0;
 			memcpy(&req->wb_verf, &hdr->verf.verifier, sizeof(req->wb_verf));
 			nfs_mark_request_commit(req, hdr->lseg, &cinfo,
-				hdr->pgio_mirror_idx);
+				hdr->ds_commit_idx);
 			goto next;
 		}
 remove_req:
-- 
2.34.1



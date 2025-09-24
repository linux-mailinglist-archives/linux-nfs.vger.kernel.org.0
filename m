Return-Path: <linux-nfs+bounces-14647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95951B9ADB2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 18:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509123BF471
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047DF30CDAA;
	Wed, 24 Sep 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TJhjPwwp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CB1EF091
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730863; cv=none; b=R3C+YRetube8LzuhlcqY4NV23eN1J2RV7a3SVvbkyjJBNyFbZcPMxCoqkIjhrvh+DdYFZ8CPcfmGGF0NmAalkb6HiZeNNaed25aIJNUjzW5LyeXP6v5y6r9VBsfLOwRQeOrplTzI9QZGsfydIU5ghBjybDOqdACaRAWwObUOdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730863; c=relaxed/simple;
	bh=C6pIljQUVbXribM74eO/Yi4zDmJMVwzxtOTyMoH2G6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uv0LcGhLvr+6ZGpbU7lAQVdrzHeBuuCtG38NEF1iTafQE7Ap0D+e55DBltP+EmVTAqvV2i3u3q8EVdPDEV754sl/s3e0a4RTOPOsUfXVgTzKP0NXjORLtXJvHaMiWKohQbpAG73hcipxzcqG/P3WHsuFWLKs7GAOkk3bIHwAZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TJhjPwwp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so10850381a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758730860; x=1759335660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=TJhjPwwplvPx+hvAe2ICvpb8PFz/AVhtyxYeOglq/lv2Nnn89LeLeSdD1dT8ApPSF4
         TKscx+HoNcuPdKYieUSkHiU+M3CbJNuJAP6gpX3k3+XL4/fR3D/ZT4puAQx0QjuFaeF4
         fSNLpBG2NaM6bGhjsJXuHhtXCsVvHqwKHUddePHpKltkGePpWStcP4inyGQYwNi+YyrD
         r4Y/d/SW3Xw9F97Ia7TfombpofaV3jV1Nwz5iYwAPmfZ24PY6UycYKqQB7V+nxhGDODA
         TA5/3HYZRd0+Ql9FgSVhfSyiZlZ6ttFxH6aJz6IeRONUsHsB/GUp5bDu+ghVYT7AZh54
         HKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730860; x=1759335660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=PJ+kziUeXeEDvHAgZydnWNPW8+QFmenkjg08a23HTY5kJOr0qWNbkpap/K9qBP9EgT
         54DkoPd8nmzkYoZ/oFZ5hAXEneXaIn9haaSokHtJcORA5/qnvf4nFpA0jua66v2A4M3U
         Xslyigcglmw9Zi00PoQV4XwdyC7LIcMAaBe7jnR+5zXNGvXLr+h/GqedFCdmng54wOW/
         nFECZG8zd1xw8WVgCmstaxeO4G2MLYE38JrbBCd+777A0VLVaFgmZpP8AuGou8WxHnq/
         dZuXkePGMl8NlMvvER5aF1+4iJgyWUcev6lMq9TRIoQTcF7ieAAUSQJxFfwaSQYhSQ2J
         Tz/g==
X-Forwarded-Encrypted: i=1; AJvYcCVTJn/U9RR/sOi0g9TFMFyi4Lnaf8tWWvZB45GYmlsB5sQnRZ+RrSH3ehwvbxyw1faPggBIS2SqiAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3p/LKBPug2SoXqDbDuSuslztoSQBor5mbaVl4lTXsug01TJ4m
	YqItHe8TET53Ni8OpRzTuhYqbsHZ3cmIf8LBwIg+OMHZtSDGZq+HkuHt8mtMwk+QJBM=
X-Gm-Gg: ASbGncv52ztiKZK8v+S0yBFv6234mytOS+LnYxThim+kz0NzNR7sPsdl43NycbxiOHq
	CAEhI9rKrfD2GDLOzW63YFJD/KV+BhElwxfdK9t4xwgbHvZ/IBTq99pJJifw4BZc/Eth7aneeWi
	JdWBzHEEIjuRGoxwao2tlJHsFU4SqOfy1o8G9VfZBL9/AE3jIasO0VpSquCG7YvzDS5BNjmCEX7
	TrLh5NLh8Oqh617v2OACwSCXdpKjhde2egBUnWBBZGDo/nkM0Bs9qC3/LPGha1/m/FyAEd0ZaGW
	Nk1HTuOPhyWb+E/bVRkR5PWmtQTysIHPKmbkKVer1INyBwb/FaLnV8EbQGycT8x+TVAGdZHI3FA
	pGMo2cAtf271ES2Q0kxD1mARkC4dwtBGbmQ==
X-Google-Smtp-Source: AGHT+IGfonTvtJ8mjlwF57YHgRWPMhnaeBU9AyNkv0j8JJ45LU9D9HqjIo23mqJJF0w9wKAdCGTw2Q==
X-Received: by 2002:a17:907:9628:b0:b2f:e1df:1b52 with SMTP id a640c23a62f3a-b34bc67b048mr34428466b.47.1758730860468;
        Wed, 24 Sep 2025 09:21:00 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b29c776391fsm950707766b.81.2025.09.24.09.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:21:00 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v4 2/9] NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
Date: Wed, 24 Sep 2025 16:20:43 +0000
Message-Id: <20250924162050.634451-3-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924162050.634451-1-jcurley@purestorage.com>
References: <20250924162050.634451-1-jcurley@purestorage.com>
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



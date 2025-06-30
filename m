Return-Path: <linux-nfs+bounces-12826-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47110AEE6DE
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 20:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641881BC1FD7
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Jun 2025 18:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC02E92DE;
	Mon, 30 Jun 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi9iqNMT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084D2E8E09;
	Mon, 30 Jun 2025 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308579; cv=none; b=E0imloS+qR+JbkPLSjmat/T/BjwP5Oe563g6llu5iiVHBau0InJa664yupCsiv4Bij26LlD0uXmgxVJEXTZ05UnTTFs1Thvkp0BxcLMNqPRkrI1ifYYWs0iS6mS9ZXjpU6g/WKT9NtvJ2qD8pdso1Htu24ofbS+Px54V9M/gceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308579; c=relaxed/simple;
	bh=U28c1RXkqh10GW9CK4xixFeE0J/V/nDijiPpI5MU/EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkm47+OKSTqhKXyalr0kj3vRV0YPnLxkZdknmoPk6Zho9sYfvHJgOVLqn4qTKIozqZbZ140AJrs62fhG3pzzV4sgm+a/NiuKC/a4USKJEjecAJ+iBKMR3a4ELfG/bf9Ublx0HnANjgCshxnH1T26lAKlklQdnR4vPdHSjnQRhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi9iqNMT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32adebb15c5so17500141fa.3;
        Mon, 30 Jun 2025 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308576; x=1751913376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCL9/dAc5/TdNkuoOspnQXjRpLf/CLT8PSLRWLBfWSc=;
        b=Fi9iqNMTNScJWBvXDwGP6jCx+2+oZKOFbhH8SWQZqO6mIfVIM+UxxGilz1gvWgeKXB
         AQmNL+90eTq/2w7cbPtBzdrfEwzv1oWmYwc6hD3GxuH4lgbU3rK5azo0zDN1LwAxJTkG
         er0XbTxyITxYvMQAH3zo5E1d60CkabzE6rONL2D9GWp+6/tZjMU9igwywkRgT35fq7K7
         MyB+q73eoRXaw8v3ER/ZGuYg1SJGsoalD2ygkdgqm7qw/+bkHJKUQFBhWGxF6OobJosH
         1Hk+lcONatUoDTv6/NA+h7nlsIJUr3rW7jeJ61sNTwKNBodEJFsuXkDhLVzYGemXnOIj
         FoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308576; x=1751913376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCL9/dAc5/TdNkuoOspnQXjRpLf/CLT8PSLRWLBfWSc=;
        b=T2V7HLdjkE0gh5fYxw31w3iztrM01erjZ7H1npJKpeusmTXMrFNFyOlxiiPOsf9+ea
         jTsCauO8fh7kL+fPaHlMHC4h4wrtTuV2V3/o5S3/t3PWMQ6AUEBFw7GhBPF/KXwK7FWn
         5s3qRJo+6DXgWHysDro1Ls5eQ8oeukWhLdE8YqSJNNbfoEBUGR11M7s2TLXYA3PoUAPV
         hdIp4xxDC9Y4/10FbJaaUOOeKusPhp2fIQEqrfP+kQP5CgdahgbicjoxvvC2DAqYPHax
         u4jiyYtP4OvbHgNc2Ow8n3ZW06nEODo4xbG8tv+EwWQ+YUzCefdu5EyEEM2xiDgeH/bc
         Ig7A==
X-Forwarded-Encrypted: i=1; AJvYcCWObMNdDj8/yEN4f+kzlmOzRo9YtEhGe3rynn0TQciLvJ1m1N1lP/kEOsc3WwiTTwvVf40w5TYyq0hcPYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0injdo5MlHRoj+camvCylEH0EtTtYzvmUz/ybea5q5CfqFW9n
	E5/UQFvOiogNDirCXMIBkBoIXIZ5DZ9UmUHP+EgpWJw4bzJ+5EmpJfVGkDN9ouPT
X-Gm-Gg: ASbGncvmOh3cNVTxvuahQJ+g32e4NFJGwy/oxZIewmx4TRKzN5q1+2phVdNzskmo5Kk
	dwfloc3IT/RIkJeHS4aWkBtFimHzxOYHa+Ais7v5UnRbTXvezlGjXp4VAOXIFDqSn/dWFKB5y82
	q7N21VN3lTgr23qjlrNm+Wg1BUrKNQDIbuusN88PC7ymcK+MVUxpLyvbIWTY4k0kBurt8PKJxVP
	a8GXbPUSAQUxYr1uRiJT87AkzG7NuSF8zkSMtJrMQpy2BCYYw6+S/tmHn84YIwGIEyV0tOlAN94
	+/Vm8sOVsGwtMxlKzir98PX8O69iwfT8zzeFzSnBbXWMndJNR1i0b+2KYTuFNte68WbseetXCyL
	yjbQtUxuv1ZU9zg==
X-Google-Smtp-Source: AGHT+IEcOnQNdP8n6PBUMzpigd0z6qZdoKKaEMwGaglK0GRbVqi4/4+cA6g1yChm2wWfR/FCJKgu0w==
X-Received: by 2002:a05:6512:128a:b0:553:2ce7:a201 with SMTP id 2adb3069b0e04-5550b8475edmr4929509e87.19.1751308575475;
        Mon, 30 Jun 2025 11:36:15 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([37.78.230.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b255a51sm1530793e87.88.2025.06.30.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:36:15 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>
Subject: [PATCH 4/4] pNFS: Handle RPC size limit for layoutcommits
Date: Mon, 30 Jun 2025 21:35:29 +0300
Message-ID: <20250630183537.196479-5-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630183537.196479-1-sergeybashirov@gmail.com>
References: <20250630183537.196479-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there are too many block extents for a layoutcommit, they may not
all fit into the maximum-sized RPC. This patch allows the generic pnfs
code to properly handle -ENOSPC returned by the block/scsi layout driver
and trigger additional layoutcommits if necessary.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfs/pnfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 3adb7d0dbec7..48dc22916f06 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -3338,6 +3338,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t end_pos;
 	int status;
+	bool mark_as_dirty = false;
 
 	if (!pnfs_layoutcommit_outstanding(inode))
 		return 0;
@@ -3389,19 +3390,23 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	if (ld->prepare_layoutcommit) {
 		status = ld->prepare_layoutcommit(&data->args);
 		if (status) {
-			put_cred(data->cred);
+			if (status != -ENOSPC)
+				put_cred(data->cred);
 			spin_lock(&inode->i_lock);
 			set_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags);
 			if (end_pos > nfsi->layout->plh_lwb)
 				nfsi->layout->plh_lwb = end_pos;
-			goto out_unlock;
+			if (status != -ENOSPC)
+				goto out_unlock;
+			spin_unlock(&inode->i_lock);
+			mark_as_dirty = true;
 		}
 	}
 
 
 	status = nfs4_proc_layoutcommit(data, sync);
 out:
-	if (status)
+	if (status || mark_as_dirty)
 		mark_inode_dirty_sync(inode);
 	dprintk("<-- %s status %d\n", __func__, status);
 	return status;
-- 
2.43.0



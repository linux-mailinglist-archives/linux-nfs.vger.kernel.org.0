Return-Path: <linux-nfs+bounces-14558-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A620EB84DA8
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 15:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A47C102F
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD742AA5;
	Thu, 18 Sep 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Cihtlmt2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9681B8F58
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202403; cv=none; b=QT14P1KENHmnEAxZt48+GT2eXZZ7uoDsMzZlEVUFiEuLZsXKzrr2DfY1s/RBXOtFxQuQ2ks1DwpT+y6Ez89ZNfY9kx2I0EGnLaH7Y17TJ7A8Pp4i6ZDwtb1xl+k94w+NiPOItsKpx1seC7CGq+oMj+6lX5cA3SbR8ehHBy+qd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202403; c=relaxed/simple;
	bh=C6pIljQUVbXribM74eO/Yi4zDmJMVwzxtOTyMoH2G6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpZbb9kMCkq0ftm/ZZQ7t3USpDaF4rW/STYWSzipB8/NoFi7js+HUlm9rXXyD4FQHrHShyeq9sMsF8zQLBdyPA9xsvIyBJWPQ5q8sTXZBABZJXQdHxIYggYL+o4Qe3rGfxuyo54a1b2973DTd9/ALjMg7YUXF7c+d/Go8JcX6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Cihtlmt2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f4273a404so3993564a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758202400; x=1758807200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=Cihtlmt2O86CzRIWxSR0v6ILRrjb1tehv50wtyeUDiZk75AtRlBQxyJSR4qdUh4pLW
         XFvBd16XmWTb/LZghELME2UQsgP2dIk18IW0FjqwsvVDs3SoJbZ854j3LKicfNDjnkwD
         sFH+Z0o4b8M8WuBjfQ3GzOKbvVq8KCHmqMags8Jk2qjks/fk+avfAGB2N/0sBjwT4mEL
         Z69v0hzp1G5nwUiKoVxJFvfOyNa8pS3e0IAlMm0Xk/2HV8Yg+jNijdzFG3DSWI1EGlf6
         wfSH1/+2ARHhSVDgasWgGDeIsAnsoaBUzGT67PsrEnphIsgcqlXSyAv1ff+Che5NMu7V
         Jt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202400; x=1758807200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+rHpWL/Piu+edXatPGs9bVuXgKSl2HpG+xEZdZh0g8=;
        b=ffjyK4v21vKFXE2hAZgtX2seNzF/SbqWgkTG3sMbObwgS3SwIf0v9MynCE4fDOeJ2W
         aZRAiAOaDSSg+UH+xjg/lHN8b822DH+bW+0uWTPbwFJVi7xYQ/K5qGKEcYEmfSKqBS+B
         6x3ojT1HW1r/kd5C+g278euqCYxB2PJGzXjxAYEa+vrRpkf2wCmxJj1EilSQ07eUEId9
         VnnlUOdF6wA8HMugbqC9arAfsSpaTt7owhyTdWdQo6iWBcrw50auGiwF0gpgQUwm+H03
         8nTjarc4KDUrddbqn3HxrDFQOCIrC3ooOcgE6z+fROgluhzYT6OPtyZuy3jNaB4Dumvv
         THvA==
X-Forwarded-Encrypted: i=1; AJvYcCVQM0S2JxEoa3mhmjZtxqBO97yY3rJ2FFVHqgbGBGgfbToGaeeH3d2FdHWyoJXFqRaMJLxdJ7HVnrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5NLACtUzWin/ctins4QWHIXE4E+QZ3DVZMEN43WKhQBt7iRX
	Q9pEc9QztTE2XKVZ043K7f1uwMcr/BKjke+e3E0nJiUtRfl8/qQNznOEI31UQaWXqaJv9CrE6do
	tiHzB
X-Gm-Gg: ASbGncuTVVp7Y8aIfDB3p9BUyeetu3QAnUlT3sPDZzFpyxEKGFILwt/Xaep/EoueteF
	mYunW/Efn0vigVaJQ4XxRH3WFG5gA8/4ClcDZEuFumxxGsoU9zksxtayEzlh8SjadunTpvhXFJC
	jsXssT8wwk3hiHhWoimb9Nc4q2ktQCsnDYN/iY9eUt2TuTRxOkTpKSKu8MhuIx7KEuOQRx8Gos0
	Lp1ks0IXGs2ppQIV01nNX85Ev1qdCi85PJavI3n4myBfyv6FqUeLFfs+PhPDHEmCeXaZ1ssd9T0
	fw4caYlzR+83Hb81qt7dQ/mxjpRUAjyR4WEgKPs3Tm2R/sVGrE0lxX74ZdSrhikt9ckquZe1BwR
	RKxbd5N38MvC3y0ZnmmbJpcKCqRs9uNX2iepRqdY0IQ==
X-Google-Smtp-Source: AGHT+IEnNptu6uyNbgPE8dj83lLGnHfQILmG7e1c7L6Arx7hs++T42mWEESWVqviIt7Q94SBOumk5g==
X-Received: by 2002:a17:907:3e9e:b0:b04:3cd2:265b with SMTP id a640c23a62f3a-b1fab1cb6c7mr393117366b.5.1758202399729;
        Thu, 18 Sep 2025 06:33:19 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fc5f43879sm201326666b.7.2025.09.18.06.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:33:19 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v3 2/9] NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
Date: Thu, 18 Sep 2025 13:33:03 +0000
Message-Id: <20250918133310.508943-3-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918133310.508943-1-jcurley@purestorage.com>
References: <20250918133310.508943-1-jcurley@purestorage.com>
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



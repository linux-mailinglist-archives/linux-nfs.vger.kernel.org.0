Return-Path: <linux-nfs+bounces-1380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFEA83C51D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 15:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F5B25119
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97EE6E2D3;
	Thu, 25 Jan 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FthYH2kl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC796EB55
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194024; cv=none; b=bmzo8l99GXXTX3NVq/nkp1szvQm1AjA/+hs3Sfbc41ciZErasSDfGcaaLYipPZsctUo9t0ZoVz8Gz+7dmamQHGzpNC2OX+ev/gNZGb+MlI4H0VYucPct4zqzTI+IbDIkf2M3ojswehRrvmfllp/H5IwkqQHIKAkWazYWm0HG3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194024; c=relaxed/simple;
	bh=NgoVsqvh5wOAfs5VHNSgIl9xiBe2RQ4ESQMef9CVfdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8VriTJa3sypuHb8X+hsZmJJh2ITeQ5mwip+Soueuzc7Pp0XWc9Iw6P/2xNnV00dpN11osDywceLRrQkWq5++Rk03SdP+SswnXJfVIPgFTuoaBpCxUvho9RKAIEYNve7e7IVS3RfWFwUJot4D0wzZsY8Nqww64eV3Ua+y6OSLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FthYH2kl; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bdb42d9e62so276981b6e.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 06:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706194021; x=1706798821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IA07v3qnpVVZdidIh0Y8bVCYwFu1QGLayRlYPR/+iXk=;
        b=FthYH2klRs/YxB8mqxcjRAiJ7lIq6S/0UFWq1OfbPer1eZwKdTGDpqamsixj+GlJqJ
         rVyb6XSRt2xd5RuomexgWcFsJW3lUtrJiRxR9JpZCwnBCLAxrjt3AkZh233YsHF96coz
         KKz+J0olIl2hspK+OwAjFpIzJzSDxQY2KsBE9jPK6QGIQncLBSm41Ca+uro1mIvPJYFO
         djRvCsZ9DP6YfsW6Nc/4rih4hSuS2LItGCxdn2YcHPf5qBS8oY4OBGq77hPBXFljtb0H
         ObT4h3kReA0BZbIm6MbKmuPZrT3oqDY/nWtmb9C9kNnnl2ObVDT393sEhwQph5pC/gZ3
         sd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194021; x=1706798821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IA07v3qnpVVZdidIh0Y8bVCYwFu1QGLayRlYPR/+iXk=;
        b=kCIugIWyjawMS+LuXW3a+UK5tx3NTYGqLxRT84zo1Lr5uzqWI3GHBV/IPU68Zyld1j
         4cDtO5mLxf6i3rSrnF53lldTq61aTRJ7I4vRTiv+mvIZKHkb2IBzJMTemkJZmci+WtCQ
         hQbPAYV4i0g7GSEo/AhJYHGl+pfgCRXGIR13a6IqGPIbFnAZ3WoGsCR5WPMDOAiC0J47
         OrGBHoq9VIluWvT0GdWPPLPj0PkoVsxJ5n2smKfbN5UB8yo+EmSUnaZUlik02uVwiAEe
         dFQ0EyQIpB1aGtju24W5ms9TLUPnlCYLP+t0DAGmXufcI2v0IkT4kynP6kfAw/UhOavf
         XQQw==
X-Gm-Message-State: AOJu0YwqrznbmIlyucOyEaKelgtcL+q6qDiEWH4zf0WYIC6m/rkr/vjD
	p5KYRmln8GA1DuJAPkqTAh9vsZaZD/84T4l/eMAbmW31otEFlIgg6oH3Yy99
X-Google-Smtp-Source: AGHT+IEv4kteKIYo4qPEbn977cjcK+BBxoGX7nc1G0q5+MIunAs/ZJqaCZ15TWA9r8OtXSKqzBPUpA==
X-Received: by 2002:a05:6808:1412:b0:3bd:cef0:f43b with SMTP id w18-20020a056808141200b003bdcef0f43bmr460017oiv.29.1706194021681;
        Thu, 25 Jan 2024 06:47:01 -0800 (PST)
Received: from netapp-31.linux.fake (024-028-172-218.inf.spectrum.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id k22-20020a544416000000b003bd9bf3c998sm2992075oiw.38.2024.01.25.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:47:01 -0800 (PST)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: linux-nfs@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org
Subject: [PATCH] NFSD: fix nfsd4_listxattr_validate_cookie
Date: Thu, 25 Jan 2024 07:46:54 -0700
Message-ID: <20240125144654.12794-1-mora@netapp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If LISTXATTRS is sent with a correct cookie but a small maxcount,
this could lead function nfsd4_listxattr_validate_cookie to
return NFS4ERR_BAD_COOKIE. If maxcount = 20, then second check
on function gives RHS = 3 thus any cookie larger than 3 returns
NFS4ERR_BAD_COOKIE.

There is no need to validate the cookie on the return XDR buffer
since attribute referenced by cookie will be the first in the
return buffer.

Fixes: 23e50fe3a5e6 ("nfsd: implement the xattr functions and en/decode logic")
Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 913d566519bf..7f957061c4d5 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5116,16 +5116,11 @@ nfsd4_listxattr_validate_cookie(struct nfsd4_listxattrs *listxattrs,
 
 	/*
 	 * If the cookie is larger than the maximum number we can fit
-	 * in either the buffer we just got back from vfs_listxattr, or,
-	 * XDR-encoded, in the return buffer, it's invalid.
+	 * in the buffer we just got back from vfs_listxattr, it's invalid.
 	 */
 	if (cookie > (listxattrs->lsxa_len) / (XATTR_USER_PREFIX_LEN + 2))
 		return nfserr_badcookie;
 
-	if (cookie > (listxattrs->lsxa_maxcount /
-		      (XDR_QUADLEN(XATTR_USER_PREFIX_LEN + 2) + 4)))
-		return nfserr_badcookie;
-
 	*offsetp = (u32)cookie;
 	return 0;
 }
-- 
2.43.0



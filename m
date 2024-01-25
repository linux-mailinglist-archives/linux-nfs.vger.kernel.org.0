Return-Path: <linux-nfs+bounces-1379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 063F483C517
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 15:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DD1B24DF1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9D6DD1D;
	Thu, 25 Jan 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqzaTFzu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE76E2BF
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193985; cv=none; b=TjEZ2QK8Vs8c1AiljjIiPBGaedzOBRHH57piqfn1mXfdYBJzxYhmZTz3aFQxn0UTlHb2/iXzMqQEPxMPFKQvoqi/fWVw+j6Cgn8HbgXDou//5iYhINV7vewBGzGh/S7CGS/Or+5sYAr7gbGBFtcc2TsxYuZK0wbbW3tzgCYBBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193985; c=relaxed/simple;
	bh=Hr2UhDGW+xKEoxwUZ9ZHuo6YOtSPkW+p7B1/UyTjxNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EWIFa1kkS0rEW60Y8BO+6Zv8qSuSq+ABmmRhhZCMQpRhNXgPAHqEwP7CyFGZLqu9SpB2yp7JYvnOsmyuTvWVVIYlzFIV9WIVMaDrKGnPf7CkrJXIg1Hc67trlx0LHVgkPyGojw653nRT7Mrfj8WD9QiXe2NDqvza51DXduKprVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqzaTFzu; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5989d8decbfso4106120eaf.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 06:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706193982; x=1706798782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6OOUt11m3j4v0qV3pAAzVLIAOWItzVmqaxJPdYw9eg=;
        b=CqzaTFzurw2RA4JA+nl/mnEeccuaCoKKRaJ/H72cTeNrgquydbvRUMQKb3Gmp1gMOy
         5mme+160hQpAB1CaR44+PeHDo2PGXuTaOnB25d+ksAOIjKm/o1WafhWKaefeycGeDNgz
         zoGIgsEdXf0yN10YNBPQUS/7ekxx+VVrOlMklylZFhVLWuB4DAAv9MZkkk8t7wExEino
         yUmnEFs7iPPqv3yTa1AzROQjsL1B6OHGxNUFH6lyoNlSSxcrRT7xS+s7L7JCJkK6V1jJ
         GyJCbJ9nDN+xbAVWXBbEFCd8KsJRsGxO4Yss3HuUbXO41L+6x49WSKZH6rGtbcq5E5pi
         //ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193982; x=1706798782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6OOUt11m3j4v0qV3pAAzVLIAOWItzVmqaxJPdYw9eg=;
        b=ls7Tm2lnxbSnp/y6bZZpdO/bvHmyZemzvjOVt2pme4PTQpFi8jTHubKKuIKjJUxpiA
         sqWuM/WI7YqDiODQBmF0d6sQyH33eNkyTMFn/UCZw4yuVO1q0+6qdTpCd0Ga1eR5Ttfz
         b7YqczvtI7OhUe/37nIqum1Y4mo2uEuD2g/s2ctCc0UfeOjdBzNW/W/6wq09ij5HwiUM
         zNfMmRTW/JHDgAjprFlDX+LrKhHOSGbtIFuh+IE5BrmQA+BYL/Eou5xTc8khZrSe8gs2
         CfRFcQtcHtKF4xrWNr823TxuxV3+bbuWgei43jh0lhty6okAy9oT9yo7AIBO2a5wL4ot
         tfUw==
X-Gm-Message-State: AOJu0Yzg/t8LfHqdSxmiSbV35dvrogevaMisuOt5nYA6f3tVzIwoUAIs
	G6FQVVlhDpju34ySs519HH4tGu3S4qQKUYyyFgGVQLGb1+WMkeITjX9ffMB8
X-Google-Smtp-Source: AGHT+IGXWIZA3umOp0ClBgFnQsIb2WBIKSaySoQ5RJJM9FnHUdqIBgKSVkHfjn1t91UYBBhOQP31ug==
X-Received: by 2002:a4a:dbd5:0:b0:599:da71:eedf with SMTP id t21-20020a4adbd5000000b00599da71eedfmr937567oou.17.1706193982018;
        Thu, 25 Jan 2024 06:46:22 -0800 (PST)
Received: from netapp-31.linux.fake (024-028-172-218.inf.spectrum.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id y8-20020a4ac408000000b00599271f7824sm431690oop.47.2024.01.25.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:46:21 -0800 (PST)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: linux-nfs@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org
Subject: [PATCH] NFSD: change LISTXATTRS cookie encoding to big-endian
Date: Thu, 25 Jan 2024 07:46:12 -0700
Message-ID: <20240125144612.12778-1-mora@netapp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function nfsd4_listxattr_validate_cookie() expects the cookie
as an offset to the list thus it needs to be encoded in big-endian.

Fixes: 23e50fe3a5e6 ("nfsd: implement the xattr functions and en/decode logic")
Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 26993bf368fc..913d566519bf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5142,6 +5142,7 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 	u64 cookie;
 	char *sp;
 	__be32 status, tmp;
+	__be64 wire_cookie;
 	__be32 *p;
 	u32 nuser;
 
@@ -5235,7 +5236,8 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	cookie = offset + count;
 
-	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &cookie, 8);
+	wire_cookie = cpu_to_be64(cookie);
+	write_bytes_to_xdr_buf(xdr->buf, cookie_offset, &wire_cookie, 8);
 	tmp = cpu_to_be32(count);
 	write_bytes_to_xdr_buf(xdr->buf, count_offset, &tmp, 4);
 out:
-- 
2.43.0



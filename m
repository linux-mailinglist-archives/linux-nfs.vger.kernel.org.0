Return-Path: <linux-nfs+bounces-1378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F283C512
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 15:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8F6294540
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018B6EB42;
	Thu, 25 Jan 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMQWhici"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BB6E2CF
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193941; cv=none; b=IFBKfphmQtvpGnOhNHM98n83eFjzg25zIip9FewISncxoHwPlk5eYGgDFaC5MlpUqSVrqSSWpJqv4eJg/+ub5D/9WNpIyoP12eujjExJa54b6mnzCH2Z1s+yaLS4tFSuwDJBpyk4JS+462k7B5iuIc1GBXmCmAVj6T4YJ+NzAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193941; c=relaxed/simple;
	bh=C9W6tnjcvvbszDEAm42Cs9WhZfc5JnPY0qTMbYKaXCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWlxMIXZ48Nh64Y2AqK/uwAO2mL2asMw9Wei3YqOFkG94oaKkp67FNAnKWi4spsYLzNOcTKCJ1xMjCAmfCoqH+VpZ7IKf+k4/sTopm/HRA/qUSYHNWaRHhT2dHgDNRtDbYraMtajbsV6Ak7sqvBYL7fuM0Ml763hh/6VSajfx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMQWhici; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbd6ea06f5so391476b6e.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706193938; x=1706798738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGvgx6wj6XdFTD/RPmgKklWHiUyI1D96usOIFC+b0ZE=;
        b=TMQWhiciJ7srAmiY6bdQW0OF5NAim7dV7rTXFSJ9VYBMWKIvAn+YqmjCTRLHMxogbg
         u+ybfjv5SMgeytyQnZkRtXWNrz6ZBmrQ1K3geFf/+OgUUR5G2IozEKQgUlLRMLnEdLtE
         2o/dGa4Pi/zXyaugLOHBY/8D6PEkOu5pLSMOkBT5KVQZZIhXuDurv28QsjAGVNPixkPe
         jjh8zKnTHPmY0ypmx0zZ3Aq0foNpK5hzz0jP723wmlcotsVh6fFktA6eAtTw/qQDt8VL
         4Vd7Bu8fVKV/DOM/8Gbf3Prbd0Aeffag9xtFG5iEO10aQ1ps1kgkz07322WemGJvDjwN
         NFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193938; x=1706798738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGvgx6wj6XdFTD/RPmgKklWHiUyI1D96usOIFC+b0ZE=;
        b=o/fuQnN7gpPKeJXotMN7CFvc7LXNJSPyQ7cjDOVbSY6TKMnoOuucDSe9HdnxGItfpB
         C0EDqgsrYQagWGyLoEsWrWKHNYztjIwvRsLbP+Y1rp7kYbZWZIjytrHO/1T/QHFKLf05
         XaJQC1r3HkhqgpSbt09Z4c0aQrYcZ0kNvjlZVdxCHmlV/GYezqm+L4KVghrvF/qn18ZQ
         sgbaPAiSvUkQDatUNgsKB4vm8pu+aYGol1we3vbrccMU7uYvvT38OHgkIW1xkR1lM3or
         oY7ykHmMoDIBxqXfKm+BCx/Suwi76M/22yMcNc+m4IfSGrugB8oIQYPKWaKRCUZRDgXo
         Qi9A==
X-Gm-Message-State: AOJu0Yx3g/qX/1Rd8XSgJPcaFtZ8cT3BmE7xog3AuX5S05Y1EvnKHyqu
	kju1/hqOn5bUqcvQojCKvqaRs2vH0H+/66XvMNYMPAcidsu57YoLk0Oj9jJo
X-Google-Smtp-Source: AGHT+IHn/0i8GKQx+I6XP8ng/CLxd7vELe/VtkJ4HGzo5EejczERaqpajEol9bN0kvihf4x7NdLaNQ==
X-Received: by 2002:a05:6808:307:b0:3bd:4c7b:6806 with SMTP id i7-20020a056808030700b003bd4c7b6806mr556079oie.54.1706193937823;
        Thu, 25 Jan 2024 06:45:37 -0800 (PST)
Received: from netapp-31.linux.fake (024-028-172-218.inf.spectrum.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id j9-20020a4ad189000000b00599ac2ca499sm427137oor.19.2024.01.25.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:45:37 -0800 (PST)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: linux-nfs@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org
Subject: [PATCH] NFSD: fix LISTXATTRS returning a short list with eof=TRUE
Date: Thu, 25 Jan 2024 07:45:28 -0700
Message-ID: <20240125144528.12763-1-mora@netapp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the XDR buffer is not large enough to fit all attributes
and the remaining bytes left in the XDR buffer (xdrleft) is
equal to the number of bytes for the current attribute, then
the loop will prematurely exit without setting eof to FALSE.
Also in this case, adding the eof flag to the buffer will
make the reply 4 bytes larger than lsxa_maxcount.

Need to check if there are enough bytes to fit not only the
next attribute name but also the eof as well.

Fixes: 23e50fe3a5e6 ("nfsd: implement the xattr functions and en/decode logic")
Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 17e6404f4296..26993bf368fc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5182,7 +5182,8 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 		slen -= XATTR_USER_PREFIX_LEN;
 		xdrlen = 4 + ((slen + 3) & ~3);
-		if (xdrlen > xdrleft) {
+		/* Check if both entry and eof can fit in the XDR buffer */
+		if (xdrlen + 4 > xdrleft) {
 			if (count == 0) {
 				/*
 				 * Can't even fit the first attribute name.
-- 
2.43.0



Return-Path: <linux-nfs+bounces-1377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60A83C501
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 15:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974F9291822
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5C5DF32;
	Thu, 25 Jan 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR57XIZS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604243A1B6
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193751; cv=none; b=UwU0PVcLwuIpiIimRC4bWquDRLZlecNTn3V6twH8VdMagvo+I7D59oT3EkS+BZS8GPZWKdU/3BJ4IvXYa9iwgCe1B6Js5RrP9FDCmkipuEPDbFxaG/h6TrygmBgT/J5ICtARpa+KAl41eQEzeT/D5V1v7n4BnWI8Tnc8xGjC6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193751; c=relaxed/simple;
	bh=Yyn1upzVl+jCGwtUEeorA2BIiB+2bFz1kA2+yWZgpYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffpMU7UNjtz7nuJmnbkCKhz/9wEvBzNIJ2MaEr8cLOsp+Yf2UUGABsGIVR8ukGPo1R0FKpitARBoyKBKyTKsPuGG9IAwoxYfFx92+yAiJIuiog9MEfArrQnYdGjWJjPuDFyrxy1CDsHOxzNHQQkvIM+X11Wzy/TVS+1ElZnfgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR57XIZS; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd6581bca0so4219634b6e.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 06:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706193749; x=1706798549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qDhs9PwqsYS/M9WcdCMn+Z/OGHF+U4V7Ld9jmis6SJA=;
        b=bR57XIZSmeg7qsmTNvWdOlWsQcJu4k+HxFJJstAeSG1xmCHsgiJwJhfBZome0r0Jkl
         dysMkDFqNK55CLrDQM99xg8EVx8o8LhMpUP5BdRBW1qiF4s2jF6SeYvdAYK7R2MH3m7B
         xJ7dCCD8q02ZMbBXsOfQU8CGaP5qdY4ZNcEHFzgaesKY9UpX7uLnXuHtdQUPBILmB8Om
         TQKq5jgq/iBSf8K0oxSBFy1xvqReQdmZc60IvkDRDhLjlRuqMiw7svaUiJutvtQaDgFH
         9ohVlQ6BjN2qYIV8wvh4/H95UGc9vZs78WGYP2ECG3ViFxSldPSz67CyUwWoB4tVvCpQ
         r5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193749; x=1706798549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDhs9PwqsYS/M9WcdCMn+Z/OGHF+U4V7Ld9jmis6SJA=;
        b=lr/N7jf2XRt2a65P7WbgwahCwdFAmtwFszJJTbAOBWNSrbuzGlDsAUF8wBU7WRPcbg
         6UDdeheBKjbt4Q35SiO6f3PuMCfCZyWnK/vJz49mWCmOIV8wRP21mZ8zFb0CbJM+OihT
         1MTUXdpF5LiUI8KG2/Aj3YbNPoyKa0b5dCQBfMk7jkeJL/It2wkqntCgNd0SOa2uL3m5
         gy0Zaa8SAl/pWeg9Hqm1/kcgMS1bwBwIA6Dmpe7fb9b4A1BNV+3eyqAetMJpOS6uC8ZP
         C7RjM5G03lQwKL90kLYfFlCWh1jKvvhtHZbYQ8sRKHAbQuFfWoE9q10yw/07Otg1sKi/
         m3yg==
X-Gm-Message-State: AOJu0YwxtbF+LNPchiZsF7RZA5Ww0MtFZ5q/Of3z3G3UUJTEFwA11nNG
	N0hHmufOdfxu9aJ//4yquxSxVbHtHSbtfeiMOk6iRC5rtyrNZH6dpcJdXmjq
X-Google-Smtp-Source: AGHT+IF6MhJ/ed5oQoszrtVQacYdl0po/fKwnPRcfgFcjJrNFhQOwB+nQvbRZmo4qyZJIcSHZNZV2Q==
X-Received: by 2002:a54:4493:0:b0:3bd:a5f1:31f6 with SMTP id v19-20020a544493000000b003bda5f131f6mr812462oiv.50.1706193748973;
        Thu, 25 Jan 2024 06:42:28 -0800 (PST)
Received: from netapp-31.linux.fake (024-028-172-218.inf.spectrum.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id fa5-20020a0568082a4500b003bdae50adb5sm2150768oib.52.2024.01.25.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:42:28 -0800 (PST)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: linux-nfs@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org
Subject: [PATCH] NFSD: fix LISTXATTRS returning more bytes than maxcount
Date: Thu, 25 Jan 2024 07:42:23 -0700
Message-ID: <20240125144223.12725-1-mora@netapp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maxcount is the maximum number of bytes for the LISTXATTRS4resok
result. This includes the cookie and the count for the name array,
thus subtract 12 bytes from the maxcount: 8 (cookie) + 4 (array count)
when filling up the name array.

Fixes: 23e50fe3a5e6 ("nfsd: implement the xattr functions and en/decode logic")
Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfsd/nfs4xdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 92c7dde148a4..17e6404f4296 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5168,7 +5168,8 @@ nfsd4_encode_listxattrs(struct nfsd4_compoundres *resp, __be32 nfserr,
 	sp = listxattrs->lsxa_buf;
 	nuser = 0;
 
-	xdrleft = listxattrs->lsxa_maxcount;
+	/* Bytes left is maxcount - 8 (cookie) - 4 (array count) */
+	xdrleft = listxattrs->lsxa_maxcount - 12;
 
 	while (left > 0 && xdrleft > 0) {
 		slen = strlen(sp);
-- 
2.43.0



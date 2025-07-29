Return-Path: <linux-nfs+bounces-13303-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC7B14E15
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22889543F01
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jul 2025 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33314F9FB;
	Tue, 29 Jul 2025 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1WzTPLj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D279E1;
	Tue, 29 Jul 2025 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794468; cv=none; b=QAAv1ImgL4PPaZ142ZzVm6q+MEyLWaCC5oWA2q1gkjyAJzuncPKhV7OALobUbNug80JCRVm0Qq2wOy0aX0ZRO80Ahn0N3KqErTAlRwxTxRJzrOMqlUBCwMT+Uz+1jMIWEDpxKOBdTYcNOCdcbb/kGPfgtnNbalqGL1QmsnnJLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794468; c=relaxed/simple;
	bh=/5lq2THeasyHOCc2K9ZWG3M2zFHYPDXCTF5PbfIXrss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KiIXQs0qsiEJthMlfgP6XTzXyV3FWxB7+TfM6rzYvJQ0PAjScbcUG+7793cfhxD6ttc65XYkOQTm++tRajxdcj/Qo3c0RgJDihMNFT8SqSKJa/vkOsyD3mEg/GQ5xKRHPpwtWa6qJBSLT/ujNkOVfSnG7hQrYaRTf9apQHhvlA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1WzTPLj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b77b8750acso694184f8f.0;
        Tue, 29 Jul 2025 06:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753794465; x=1754399265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EpVLcHS4Nm1t2biTb/caO1IN7OnTFd9yPWWzRn55f78=;
        b=V1WzTPLjJV8bNuVzqywDIYl8y6z6hKYJAJZRA/IfcRPrpn1rU43vhhBaZsJFtSWr0C
         J9noRMxCdyC/1Od+aslLMkrOEYRdqnrb68scm/ekcOUWer1H8LYyKP00u9TDhFEIbhK8
         mtTZjQQ1JB7FGg9oxD3CX5PIfI6aAn/UWNBoMT34ZlRR0gbMcGu9DkrmrCWJpydBEkKJ
         gbwZV2UPEm/+It0qJrpkMWUVjGqGAHPaFFWkTUq++HuEiSUDE/zFjpR+MeYTK4a096OM
         7p4Cpa/iEx7p49CxG7Z99rB09MDdj/Kd5haAaCV7QSG3uu9Pl7OIMrT7Sw37etenKAGv
         ZrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794465; x=1754399265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpVLcHS4Nm1t2biTb/caO1IN7OnTFd9yPWWzRn55f78=;
        b=gjvDjPkSRzzZWJaGEyGhFceoo8UNOVVkFgXmjFN+fB8bnpwuJ4dpEKW9HNfyrrOg/6
         ql39GfLCdxVf2e0tsgAphEb5Qe3n9mH87b15acutlY8D25bUl7FTafsT4uZ/QJ5lJXVr
         SvKYRiyQyq1NCBQ7N3+QFO9ClSg55LsVV5u92MxidlruCnmwnkX1o1mrzkmjFbpFMY9r
         0KqZIVbYz7xOJ7pxkkBZcWrpwRTsotkbDK4GOKjGEXf+dLCQJeRS26hQ5EqAq+WoEM9D
         iQyqKH2MkN2XvkL4+/Xgygm3LBaQDrrNG+MozqCKrA8VBPGZaOD49199owP15jUEbPlB
         D5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWonBOx7DLdljPKL7al9z9/8P3p6mEFUK1bULiuuWeeSh0hhS3h8KB+EckazUk5yGOXHqFlUwRVNsojTp8=@vger.kernel.org, AJvYcCXWR42vCEPP+3hf+pwh1hoNloGr47DKSXhY9JTOIEpttj0oWhqvSaY75H69uGUABZRfYSI4U1L6Q9+t@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNFsicDiKYBlaOqVNHUMXdfHt+t15iaHiMCSX+rKarFrrZttQ
	GYL3fWN7k364ihnS1/5mfyMzjSrhxDTZdPjAA3arwqPandp7Qszpve80
X-Gm-Gg: ASbGncs5HoMrp9bS+pbx/xqRN8E1HArMgyqnfl5ZOSxvBx7MBC788BJB/lcffcqDUb3
	gAH8HOfyqYXDn7rnOAqfivQjtwQWMYZh4/iC3XFhkA5H0guRy+IGpQhrMC7qXGx/49w5h4T9s5j
	SxeiX0BoKdneY2uxOt2yaZjOrdfO4uyRX03ZrzeNFRZXycihgfw+psAZWWHBXYh7sJdD7pYglcN
	w9Sl0BispxwnwxrloVLHpfkOFGX/p+2dKxz9vtPgLCe3cDee7N6A4dd1gLN71+oi7hZAbU/vGhT
	YdXPGlFxlBznpB9z4MIEOZrXq1dYDKfzMcgxPFLdJAB+YP6nHuDIIBg5f0cs61daCsuwysWlyeY
	R7iORvFI3HfRiM6/yEb9J
X-Google-Smtp-Source: AGHT+IHEx5FwO4DXWDanHU3Y2+ONRatacPraDIuksMAXcs5g3kUlBrlE4dZCsrnykJphqMX68VBrmg==
X-Received: by 2002:a05:6000:18ac:b0:3b7:775d:e923 with SMTP id ffacd0b85a97d-3b78e3d5a92mr1883541f8f.4.1753794464660;
        Tue, 29 Jul 2025 06:07:44 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b78ba267e3sm4500678f8f.59.2025.07.29.06.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:07:44 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] lockd: Remove space before newline
Date: Tue, 29 Jul 2025 14:07:09 +0100
Message-ID: <20250729130709.1932507-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a dprintk message.
Remove the space.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/lockd/svclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c1315df4b350..a31dc9588eb8 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -980,7 +980,7 @@ nlmsvc_grant_reply(struct nlm_cookie *cookie, __be32 status)
 	struct file_lock	*fl;
 	int			error;
 
-	dprintk("grant_reply: looking for cookie %x, s=%d \n",
+	dprintk("grant_reply: looking for cookie %x, s=%d\n",
 		*(unsigned int *)(cookie->data), status);
 	if (!(block = nlmsvc_find_block(cookie)))
 		return;
-- 
2.50.0



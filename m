Return-Path: <linux-nfs+bounces-2244-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A90876A7E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67452820CC
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Mar 2024 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3E540861;
	Fri,  8 Mar 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMmblmQM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102BE36D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Mar 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921352; cv=none; b=lC4Leq8JXBREyEX2zGMrKJehbPfUe3GTz/NPejA1fSGEOh8fYEoqmijA4S9RRprfsXpa/mOWb8MLH9jC+Pn8ao2QSLTjwDxweLBDK/BQQ9aHmaMTAQlZIc66eMXXNzyEi6mAmI46/yTlXs+WBNlZqbsmDYfHLJQnNIxYj8KIN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921352; c=relaxed/simple;
	bh=Lv22lk5NMI16wvgEc0t61jOH94iY37eFHtzYOIQhS3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szX0LNYL0H8ulbRr4EYTXyDFi4dj/StEEXMFtFcfEE9DxLGy69EXnof/819cRdBu/smzlgd/TLFfNfm5UpIfHOW7jabU0iil/vgwdSO100AjPzWm9ZykNrjgDhN77vI1URlydDwQz1wo1S1hX71i8GL0tH/QBgT3KkqiKeyw0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMmblmQM; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690b874cacfso4403986d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Mar 2024 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709921350; x=1710526150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/LPeVMAaDTA0hmizWZ8Sbr7Zt2+Vn5WjZ4CrjE5hPE=;
        b=MMmblmQMsaRgb+niSxTKgCaT/XBOsnlP9h02YOH9513EaltqagRv6HT8/xlr8efifP
         rDRwlMVA2sF6nMVsbVqO7O2R7xDUviDINw8jakfQXP87Nuph2jjZiDP05qQ5FNCez8uA
         +s+AElmRq59yR/buBA/6FGT3+dwrxqs9Y/8iv1W+BWM6EVjTzkRsQDwOIqmkMeHcsSek
         9LfrJIxhg8JBLJzlO3aa+j0faYM7NxEE/ZAorVpcr8ueKAf3htP71PXTGN2PtgbmKIqS
         /68yiipqwZa6FloGTCZeR18OI7TsJF9UYb8P0Wfu++jNWzIQowpIsRjVksiXdNefRLkV
         IK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921350; x=1710526150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/LPeVMAaDTA0hmizWZ8Sbr7Zt2+Vn5WjZ4CrjE5hPE=;
        b=KjBplbgPORkH+DEkgdi/aj4QC3zRMi0IDlPtk8+J98le5IKsqQfpIVtz0ErCGlGWAU
         /M1Es+YXZDt1MSaI4bf4W9OemakGwhcdd+dWNYfcC03gGyZIg0H30kK4wv3SvxRBQsa6
         J5oli5zhe7Uj1fL1Ckv45i+q5tggqGc2IhPHU3sVLpFx2O7B4pkKvmKo6nWKfZzDp7z/
         fdX5ZYqN8a7ODInZyEAwwMrZ0yVThNPti7vbFaUXbcEIKTm0BcioR2N08Wr+/7w3hAvj
         EE9pnprWKqinqAOt2BO7ZQINJ1ri1zCT8WZ60RYVYPlKsqiFxOQ7ZrJnWomH+vR/7efl
         oxcg==
X-Gm-Message-State: AOJu0Yy6MTmke6/K1+1OI2REMWsTuJil+LA06/+5dKtWn96CVR7VXbwl
	IjjE0zd1tk5CLZMIYWS98QyGKm3aNb0UZuJVUeh1bQPz+9zTQYQ=
X-Google-Smtp-Source: AGHT+IGovqKUCAgZd/oL8+jUyEglsesEn5QrmmGA/iGUlPMdPisL8yBrlg5taUv6qZRdZmwF1m80gQ==
X-Received: by 2002:a0c:fe07:0:b0:690:b03f:f199 with SMTP id x7-20020a0cfe07000000b00690b03ff199mr4319665qvr.5.1709921349885;
        Fri, 08 Mar 2024 10:09:09 -0800 (PST)
Received: from localhost.localdomain (c-73-145-170-161.hsd1.mi.comcast.net. [73.145.170.161])
        by smtp.gmail.com with ESMTPSA id mg20-20020a056214561400b0068ff8bda6c7sm9925361qvb.92.2024.03.08.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:09:09 -0800 (PST)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: Steve Dickson <SteveD@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: allow more than 64 backlogged connections
Date: Fri,  8 Mar 2024 13:02:23 -0500
Message-ID: <20240308180223.2965601-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When creating a listener socket to be handed to /proc/fs/nfsd/portlist,
we currently limit the number of backlogged connections to 64. Since
that value was chosen in 2006, the scale at which data centres operate
has changed significantly. Given a modern server with many thousands of
clients, a limit of 64 connections can create bottlenecks, particularly
at at boot time.
Let's use the POSIX-sanctioned maximum value of SOMAXCONN.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
v2: Use SOMAXCONN instead of a value of -1.

 utils/nfsd/nfssvc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/utils/nfsd/nfssvc.c b/utils/nfsd/nfssvc.c
index 46452d972407..9650cecee986 100644
--- a/utils/nfsd/nfssvc.c
+++ b/utils/nfsd/nfssvc.c
@@ -205,7 +205,8 @@ nfssvc_setfds(const struct addrinfo *hints, const char *node, const char *port)
 			rc = errno;
 			goto error;
 		}
-		if (addr->ai_protocol == IPPROTO_TCP && listen(sockfd, 64)) {
+		if (addr->ai_protocol == IPPROTO_TCP &&
+		    listen(sockfd, SOMAXCONN)) {
 			xlog(L_ERROR, "unable to create listening socket: "
 				"errno %d (%m)", errno);
 			rc = errno;
-- 
2.44.0



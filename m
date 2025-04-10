Return-Path: <linux-nfs+bounces-11100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C76A84F22
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 23:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554918A838F
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711420AF88;
	Thu, 10 Apr 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b="LC3xHVSA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4A1E5B62
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319976; cv=none; b=S33uACZtyEdV+bbG1FS0pUXT/ohdfMG9tZZrabxeRK5CG+w6cCqKsxkSlBhjjxs8NuxcdPizx+gpM1i7cnYg7YlAlLsk2u03ZODm/6iTnyMTxoCAhDmknI6Vuo9YhPXPE45CxwTieHJf9yp1FQgIibnrc6uJagU9tZ/G/f0ONdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319976; c=relaxed/simple;
	bh=u2EQxnVWWou8aoMOx7nGmjwgug43QuWXObT+xe8f9gY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gT+k6CriOVpJTPToD8hm8O4uSTh/BCHfHAOssALpf6gn4Z7JbT9jir1ygwl3HsLadJeIfuI+npwjh/9VUdS5EMALdF53JM+obN3NxtZWYuFr/qG8alr+j4FUZR6IzpfDMRuTZRbOEhnhodoZ+36SI8fgz7NxN9aqKxOQUOM2DlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org; spf=pass smtp.mailfrom=schmersal.org; dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b=LC3xHVSA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmersal.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240b4de12bso18038075ad.2
        for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmersal.org; s=google; t=1744319974; x=1744924774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ip133qg2nZVGDoPxwem9pucSM0WNCph8qIFk75nAyPo=;
        b=LC3xHVSANWh/pf1ZQCyR1NK2QskbJAdsjAuqFiTgQodupii+8Ekd0B1lX10kJ/DGlk
         7YVtQ3GcdLpTVKq2BcCKp43yfkfieN7xtzzVEptWjRBQHm/pZe69fleVDehpuCssg0Vu
         5PDJmEB4XUz6q0RnJSCwNqa/x5pBnMR3O/6g4TlBXKAJX4/4RLMvgJxn2X0mpzfQIFMt
         y2nfkh7ObQ+aTRMiI4C4inU+5y0uwpGmEixVmkEsxucpZRMH60uu8/Nd1+QSdOMJsXEO
         iXVcscdF/XTBKp4lCEOc/2Qi9ZrhrwzflDOrDvxlU9FP4tDTA6uKsQvPWAgPASxCPJhU
         ONHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744319974; x=1744924774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ip133qg2nZVGDoPxwem9pucSM0WNCph8qIFk75nAyPo=;
        b=dF7c0x4k1iJxInjH/hwIRRLE6wcbOOLmBnhahriRrhZr0u4OHHYUuvWleoQtc8t+DA
         PJJuxKcVw3pxxuTp3FYb+tIb0PpRmi92RUmlka0tn/HY+VVY5z9C9qNgXJ4+8ZG+Z+3N
         ChBp6wZsQz7pqa3UwmuF4M0/jvioihP+34LCwKaZkBSo1p9PSufR/jZMRuTCFNjCWX73
         AGtWrXU8NWgi6d4fZEhDsTj0UP8cEOf9Z2QD2OmZqkebUL61BXRZQVpG8RHCtW7iw87m
         vLB+AwHyW7YZXmfX/1JOlgGmHQQhnbXUhB643kpsqO8Km3sDESW7OFR68fkxkZYaxwqP
         hFyw==
X-Gm-Message-State: AOJu0Yyj6YkvbQxxOXQe/3nwKkb058G4vD6+KAQ4zIOexxJaP8a3eqDw
	4P3wseYe1XYbYqiBcXKv1j9s4v9RfPtj3ERcYwWerwUKaE+c9R5+X/g0fWv9kVV9XW4j2L09uGm
	Gj1Q=
X-Gm-Gg: ASbGncsg3js4CUDyWk1rHDD4U1H1PZ5AMNSkjdhXaWSY1/aIb5fxZ0QSfb3lb4OeUK8
	olvudt2TS6M3tpN9r6Cj+rJFuBb61iz5wLJbc+zQFB4gCiXvvDC8j6DAM/mFrsZjc1WdyDJQMnM
	noduufbJMBI96vXC1pTrZ36UwWn+2BAWPi8MeyHrrTrId4l93MVkyYiFGtNd2J06pczTqJmOGay
	8yaMDuMrc2MQb+rbcX3p1eHzwLIrSB2sKYbChGel/gRDWRaQnoaLHPuF2jm3xfNFbZgHFziau6n
	s4+fKOsM6n9ZhnphfVgJsuHdqaSb5RdkzapOCzklehTlKb1SSjduYr0JOZzBKwJcwYksgnMoC84
	piNLZXl8QqQ4lfnPWCbTzi7CwJz98yBgi6FYjSGLEBlAEZK9Ssw==
X-Google-Smtp-Source: AGHT+IE2mAkWzl4bXz2NoFbYZzSHoJrlKGA/mDnK07cv/od8KEQrwRfKDEndogpgrIXDuy6car3EJA==
X-Received: by 2002:a17:903:228a:b0:224:1781:a947 with SMTP id d9443c01a7336-22bea4b6de2mr4526795ad.21.1744319973700;
        Thu, 10 Apr 2025 14:19:33 -0700 (PDT)
Received: from bryan-ThinkStation-P520.tds.net (h69-129-150-238.mdsnwi.tisp.static.tds.net. [69.129.150.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb82fsm35446705ad.219.2025.04.10.14.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:19:33 -0700 (PDT)
From: bryan@schmersal.org
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Bryan Schmersal <bryan@schmersal.org>
Subject: [PATCH pynfs] Use constants generated from the .x file for NFS_PROGRAM and versions.
Date: Thu, 10 Apr 2025 14:19:08 -0700
Message-Id: <20250410211907.480653-1-bryan@schmersal.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryan Schmersal <bryan@schmersal.org>

Signed-off-by: Bryan Schmersal <bryan@schmersal.org>
---
 nfs4.1/nfs3client.py | 4 ++--
 nfs4.1/nfs4client.py | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/nfs4.1/nfs3client.py b/nfs4.1/nfs3client.py
index f98f691..9dee653 100644
--- a/nfs4.1/nfs3client.py
+++ b/nfs4.1/nfs3client.py
@@ -119,11 +119,11 @@ class Mnt3Client(rpc.Client):
 
 class NFS3Client(rpc.Client):
     def __init__(self, host='localhost', port=None, ctrl_proc=16, summary=None):
-        rpc.Client.__init__(self, 100003, 3)
+        rpc.Client.__init__(self, NFS_PROGRAM, NFS_V3)
         self.portmap = PORTMAPClient(host=host)
         self.mntport = self.portmap.get_port(MOUNT_PROGRAM, MOUNT_V3)
         if not port:
-            self.port = self.portmap.get_port(100003, 3)
+            self.port = self.portmap.get_port(NFS_PROGRAM, NFS_V3)
         else:
             self.port = port
 
diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index ae90cc2..031f89f 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -28,9 +28,9 @@ SHOW_TRAFFIC = 0
 
 class NFS4Client(rpc.Client, rpc.Server):
     def __init__(self, host=b'localhost', port=2049, minorversion=2, ctrl_proc=16, summary=None, secure=False):
-        rpc.Client.__init__(self, 100003, 4)
-        self.prog = 0x40000000
-        self.versions = [1] # List of supported versions of prog
+        rpc.Client.__init__(self, NFS4_PROGRAM, NFS_V4)
+        self.prog = NFS4_CALLBACK
+        self.versions = [NFS_CB] # List of supported versions of prog
 
         self.minorversion = minorversion
         self.minor_versions = [minorversion]
-- 
2.34.1



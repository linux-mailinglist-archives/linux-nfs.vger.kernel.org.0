Return-Path: <linux-nfs+bounces-11101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0048A84F23
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 23:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CA68A8373
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17BF20AF88;
	Thu, 10 Apr 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b="NiHuoOGq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B51E5B62
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744320000; cv=none; b=ZhKY8QoeZWbDXOuvDcuNgSx6Z0tcxvsjdd6phR6v1QxVaYrKlVYg5wbRFFmzpdfJyyzT0Pg38aY+eamxdoNE5TKYGyPOm8Ki+ZuE8UbuN/ID8EZOh59JAZQxr4DlH7dij/joELEixMiiL1R5N/BTjAgG+7Z+fm4PZn3Vz08+TJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744320000; c=relaxed/simple;
	bh=otBOhHKjA5qGMqZq6Vl2lfoDCyFlnP3l5+ucM8ffILw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1K7/URJyKnvlCIblJPyTKYW8xEWXWShpS62dDGkUodFJz1xEJvRRnpL2Ku8r+5/DxGbV9NsHAPSb4/izpEGy7rHNIJ9UNK79mcjuk70Gk7HQPOAs7AgoXPkCIKODT8kUUpYMY26gwAAbxLt1CS496WXIaYNi1r8GBFu+MFG3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org; spf=pass smtp.mailfrom=schmersal.org; dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b=NiHuoOGq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmersal.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso1691392b3a.2
        for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmersal.org; s=google; t=1744319998; x=1744924798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r56voiIhSCL0iECWBPhFOdXhc2OMl+mLz8TQhK7Q9Qc=;
        b=NiHuoOGqva9FRlPhpDiR5OVnsdhRzUjmixUl1FkCXQ9Et1QJ4dtHRT7oEQOxTyjqXh
         gtadxU6FqrY+UbzFqDX8S2v0QC9w+YRF/HexE6g3L99ZNjQoFPZkRZKEWBVvN3Ni9j3n
         1XjydheLN3IaE635/ZmXGpz54IbblgJIw1pygv7JYPrf6Yp/p1d3RF07jHvrPG9ie5Qg
         foEjboG4I5s8UdrLfOB4L1r1kboNXXq6ZYy58tawJbdQ1LxCkNpL1tI1k1kfwIqL0cG5
         PVB7sBwER7xKzzL/5S+/gE2V0dkoopGKnuGdjR/kBBT3gORhPAj+fwDQhozhsLIzmDjR
         NUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744319998; x=1744924798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r56voiIhSCL0iECWBPhFOdXhc2OMl+mLz8TQhK7Q9Qc=;
        b=XULKngw4kp+G7k3abdTakGotWJaPAKJP4RVJXEjjRm+LhU5xFBtkleVjcAnw8B/KZB
         fkuWbmllwRDo41GGuSniS5d8pm1BeHsEEx7LSsKRHWH1J9T4gkqSfQGUoLEEDfy365Iu
         W6+DaYP72tsxip0YCDjvLvD0Od6Nq5oj90V9bKRu+9WxO1MulKRRpj+WGg8RDWKeN8yw
         HuZHzgwzw88ddtLiYxozixtDUCqTJp6mbSdxe++pAgJMI8AqEsmykY7I0f74C6JUZbV8
         Ce0TFI0b3vHxjfKzXXN2aBZdEHCHiDXs22B9+y5bg4CrzS+KrX5edLnMWycECga2ten0
         LoNg==
X-Gm-Message-State: AOJu0YyBdPjMqdt3PpH8ciU7ElIrrLvLS9dZ7rgH2+sfyOBk81xFJuS0
	ruzw6EVSFbHWrXvM6oA2s3F5Of79qtk8xlX7X6XoaUC3dhePLbJ7JPKCfkobrBg=
X-Gm-Gg: ASbGncvLcEEtLoBm2kBp0QCOZrF1AY39T9CS/eVLQp17w2m9evOsW+Up+gisvtZ9OiY
	fajjywIIWcm+UlmA/a2WAbBZdx+d6SQIXuNH99yUwXBWv9Q4Id+/NgGnpxituExq4HmBiunWKGV
	7rPOIrFxrcPtxzMGMfHM/6wAT6TjIVubt8n961LmHrYLYlR0Fhu7qkx5Ay10CskesMD417Ybk+Q
	zK2cVGKXXUNxZg9Pafs8mUTsqsB9svPoAgi/XRlj1mWkItvUOnoUYSqh0OlrL+0Gas9Zob6kHbH
	jLfUyG1uBLcOXfd3Z0IhM4jB/E0zM8TZgjjyfb2Z0+MBPNm4NuTwD1fAzRuXzccpHImm9NDPpQh
	BntDpoD/dbOhhwDNac5+DQm3qCgBTQVlfG45Dbp0=
X-Google-Smtp-Source: AGHT+IGY6pJnJph9JA4+oFNoIbUfjnWGF5LLqjzH0hv0z+MBvvX0ea0mcYX5W30uoBnzWrTMDvPK1A==
X-Received: by 2002:a05:6a00:3924:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-73bd12a2ab7mr442002b3a.21.1744319998386;
        Thu, 10 Apr 2025 14:19:58 -0700 (PDT)
Received: from bryan-ThinkStation-P520.tds.net (h69-129-150-238.mdsnwi.tisp.static.tds.net. [69.129.150.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f8276sm29753b3a.100.2025.04.10.14.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:19:57 -0700 (PDT)
From: bryan@schmersal.org
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Bryan Schmersal <bryan@schmersal.org>
Subject: [PATCH pynfs] Add the ability to have NFS3Client connect using a secure port.
Date: Thu, 10 Apr 2025 14:19:35 -0700
Message-Id: <20250410211934.480672-1-bryan@schmersal.org>
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
 nfs4.1/nfs3client.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/nfs3client.py b/nfs4.1/nfs3client.py
index 9dee653..2993f6e 100644
--- a/nfs4.1/nfs3client.py
+++ b/nfs4.1/nfs3client.py
@@ -118,8 +118,8 @@ class Mnt3Client(rpc.Client):
         return res.mountinfo.fhandle
 
 class NFS3Client(rpc.Client):
-    def __init__(self, host='localhost', port=None, ctrl_proc=16, summary=None):
-        rpc.Client.__init__(self, NFS_PROGRAM, NFS_V3)
+    def __init__(self, host='localhost', port=None, ctrl_proc=16, summary=None, secureport=False):
+        rpc.Client.__init__(self, NFS_PROGRAM, NFS_V3, secureport=secureport)
         self.portmap = PORTMAPClient(host=host)
         self.mntport = self.portmap.get_port(MOUNT_PROGRAM, MOUNT_V3)
         if not port:
@@ -136,7 +136,7 @@ class NFS3Client(rpc.Client):
 
     def get_pipe(self):
         if not self._pipe or not self._pipe.is_active():
-            self._pipe = self.connect(self.server_address)
+            self._pipe = self.connect(self.server_address, secure=self.secureport)
         return self._pipe
 
     def set_cred(self, credinfo):
-- 
2.34.1



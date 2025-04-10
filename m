Return-Path: <linux-nfs+bounces-11102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0EBA84F28
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0387AAD4A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA05F28CF59;
	Thu, 10 Apr 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b="d6BEywer"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479551E5B62
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744320271; cv=none; b=qrSaeyQHNHW+mlRZtFD1OJagfGHsY/Dl4HFP9Piuio0C9auKYra7rl2FLDxG/ZKT8ozw9ufJN+1dIutd/yb4TCaL2BFmcv2WXNA91B1jcnHbRA3FwWCIHID23mXqxMB78lxbJHJR6vU/XOuew0W34QnfHWpc8Jfko12flXi+S5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744320271; c=relaxed/simple;
	bh=IojMl1jdb7uy4WQ76d+F7oIgf89viB2jTEN4w37rMYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvq8+p75tO/audLbdUCY+tbxHutkChtQHm0uKkP2gsHkHNmyFS0S+O+qoCjG15GHpbXCTe4GoXdnyXVqHAxFWZI2KqTVs4olAnbE+/JgsyV9Q+a3yfeRL5kR+mpBaKSa4y2jhKOZRCTJMeQROnGjaDHhJKrC9IVsTSsPkQNDCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org; spf=pass smtp.mailfrom=schmersal.org; dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b=d6BEywer; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmersal.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22a976f3131so14790635ad.3
        for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmersal.org; s=google; t=1744320269; x=1744925069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlVkhn8FZGRuCTeFvLTtspT71x7oUKAB92TzK3Qtfi4=;
        b=d6BEywerOpAAHEG7RaLeqGSWfmdIU3zpaCW/C6QUxilxqsoDstDaFR1wKx1QQ4fTx7
         iVlOHZJiY7L9Cl3xJoPYZEVb7j/ny/N6Rbq2RmOjF/lOW3FGgMEkq8SajpeRhaVIgxn6
         mIihtORHKM2GM/6wcX1V0B8kXXEzGoQaPtqZYnnjCvjfgUoNqw8aRb9ZlD92eEJ5miTS
         31gk7VEqH+Dl5AXgYSN2HwjRPSs2hSWKrNAev/ICR4j3NYvGFsM/fbhdNfW6bmivxQKQ
         qePq24WOrOXFOoEowJz2ZlKSuvBM0LCJuTBjxi4jpSeQbhp8MuKYFTlt0aKM0Xjoj+B9
         FkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744320269; x=1744925069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlVkhn8FZGRuCTeFvLTtspT71x7oUKAB92TzK3Qtfi4=;
        b=ZadcVMPxrDb6krLSDIXwvMG13yh1MRIwFMwdYLbAF6RvvOX2LKc9sO2LVARpuu7yWr
         DfWNo2eOwdYtuBhIwCRVutIB1jxnMes76Ym/pGquLzg2YoNX+2Mnfll5AxiZlT5gtM/+
         Q5UgdBtPfriICZb+lXbiG1BuY0nqCPIsH58IEyp8joRlzcfUvavYHEGa0ab0F5OGgdNh
         MnNUowrB5zmBvsiFKZEcmk54kMAP9B8Xjyb/AvdiOoRCpHgEo+rd1zLVfEmjUsKUQE4m
         R0ihChdZf1ThTa3wjq1X5XNi14ajET5ziPHSbcd0ULI1G50owNH1mZ1avuV4RbvypQVP
         E9Cw==
X-Gm-Message-State: AOJu0YxMlExOIImC4/xC/1SaeWa9FfFzQm2IkZyrNHF2tMOcR3m0iA9c
	AM1D0G257xgDrSvRFSiQOpmCTSq0wog7Ir79IrfbRsO6gSEogjZGjX8yFkwVvIzv/IZq3TZqmq7
	u9Q8=
X-Gm-Gg: ASbGncscigCCPI/4pYotJcR3YQvkFL9nmbsvL26oTgQGHgA3WLGqmfDWprHOY5X1xdH
	YUWlTAG5s6MDV+1bxKYzDMHQGZ/woxzOS4ehTw+igbDcE6px+0Wc3wb9pz0q00FrEccLXm/ZDBf
	cPRNC7//aiBqPiYqKcCVjrRtDdcDzeQsD9mulJHW/lP+E3Msf8lRLJW/2R7f7M7e6PyWohvR7SK
	sJ+I8JS/XEa05ped2fx+IhbKDkRUj0HNlb7MPKGtBq/jrz4q7/xnS/6z+brGZ0EzwnP8x0Ufs0i
	AIUALbdo5Lh8ULisqwtgnzmXi+5aTWO0GoQR+g2m6yxoV56NxJT6SoCRbURg5+NGzfN8H+fg/Ah
	I7S8s7g9pBL96l1krdbcrci/6bQXE9GNZPRfmE+7NTOzpW2jfFQ==
X-Google-Smtp-Source: AGHT+IFdss7hCxKlEKpjyrFivWxni2DNYEW8x/J23HfhpdUqGKHfVi10UAS67AZwSw9W/qQyc0aT/A==
X-Received: by 2002:a17:902:f688:b0:224:c47:b6c3 with SMTP id d9443c01a7336-22bea4a3530mr3475375ad.6.1744320269523;
        Thu, 10 Apr 2025 14:24:29 -0700 (PDT)
Received: from bryan-ThinkStation-P520.tds.net (h69-129-150-238.mdsnwi.tisp.static.tds.net. [69.129.150.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm35489235ad.170.2025.04.10.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:24:28 -0700 (PDT)
From: bryan@schmersal.org
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Bryan Schmersal <bryan@schmersal.org>
Subject: [PATCH pynfs] Allow max_retries and delay_time to be passed as arguments to compound()
Date: Thu, 10 Apr 2025 14:22:57 -0700
Message-Id: <20250410212256.480777-1-bryan@schmersal.org>
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
 nfs4.1/nfs4client.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index a180872..ba1e087 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -534,9 +534,9 @@ class SessionRecord(object):
         res = self.remove_seq_op(res)
         return res
 
-    def compound(self, ops, **kwargs):
-        max_retries = 10
-        delay_time = 1
+    def compound(self, ops, **kwargs):
+        max_retries = kwargs.pop('max_retries', 10)
+        delay_time = kwargs.pop('delay_time', 1)
         handle_state_errors = kwargs.pop("handle_state_errors", True)
         saved_kwargs = kwargs
         do_prepare = True
-- 
2.34.1



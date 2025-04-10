Return-Path: <linux-nfs+bounces-11097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1E3A84F1D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 23:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E26C1B87266
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3393C20AF88;
	Thu, 10 Apr 2025 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b="UmPQgI5P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB41E5B62
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319880; cv=none; b=VPf1VG7BU6azdThaPxL/2pALL54dHI6vGmW12Q1weSLq/LSxry3HGVcSKlPEA3Ql7zNrhiozljZtz5P8rK3ujpaQkPbeYWWZy4n6jKSXOQ4VvptNzBULoMD7QApPed0NoTyFh4tgWx4Q/NCf/n1vb+pwJRY0Bj2bq5zCAgWFNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319880; c=relaxed/simple;
	bh=n7Oew0GeKAtoDcpoozPP6eaN0oXIB8e1lvXSRqzBC3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m066568v1rhJnRg/UzN/o7Iz9EQqcaoQuFuzBRNGpH8bpxUsd8feff/iTGHIY8+3YPNAu0iZhqBtYi3YxJ5ZVaA9SNQgCLGlmlG0pNnrVUl+IfBHkM72GJPFKe/anvjRtEwddvqeIBRqYSXozzTiB6b84l3dQ5y8O6F1rpv1AHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org; spf=pass smtp.mailfrom=schmersal.org; dkim=pass (2048-bit key) header.d=schmersal.org header.i=@schmersal.org header.b=UmPQgI5P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schmersal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmersal.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1306390b3a.2
        for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmersal.org; s=google; t=1744319877; x=1744924677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THYaz7eegQ6awlZdqKKCwYpeX/ChkTjpkGGfHqbiMvI=;
        b=UmPQgI5PgoLJ7vnnR+E58yEQ+p/1igqKTpwkptqD1QZ+eBrwMC9CDAYqFLKQHHWPFq
         +7m1jsogYMsrXJybqlhmbQJjPDm6k1QWBNpX3VsZDQMT4ESed3WtW/72C/V1z1OtC9IL
         IyFc3EjeBSVCmX0hrbpONIYedXarISstTAuFKdOW8NzLNIpr7uTgqg225UDybWwX9Vrj
         Z7BQaL2siscTe9P2giJ8YZchMvbKkHg6HFuOHFWP50PyaZabONvkE8xS5XU+2G5U8Rip
         Ylenr8oR5NdsF5+AVSjiPVusTa5K2pv1lvcklCW/0JnfI4gVVX8pL10Ne+4sfCNd0mXY
         iKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744319877; x=1744924677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THYaz7eegQ6awlZdqKKCwYpeX/ChkTjpkGGfHqbiMvI=;
        b=VOIEabBFAulOLw7ZYN+YW2ezOMBair6SZRieoEULUot7PjMMvsjN0A8JThALJ4voqd
         Do3AXg47Ei4q5RsIzrQRyhOu3AwOqdScOWJZaxGwDWUrll9O86Jc0F3CgJM+9ELk7RxT
         Fk0+5g2A4AKQFpD38ynQqQiAYRni/KCSa1xEZNzeB7xYpM/60j3cFZ1QLsvQVBBWcGeP
         K5FxayeIqqwaZLz/IPYdA3WvLQD1x1OeNz1pSYk1V9Mx0kQ/Fdg1/JO3LfBIRH7pq9z0
         IFqye8VeegKwnoTiNbY7Q+6t1qKCvtMxzQAoogVMGAoZz+ec0bDawY4zSRLBYRK3312X
         bJ5g==
X-Gm-Message-State: AOJu0Yy90TdM/wIiDjdXcM10PsZUAkjmvMLfOmp0TEFB1sgyR1Gw2Ehb
	OQfg7M+Sp9Ly6U/Q7yPUSpx57yRK8VMy9NLviL3hIxVlMNLes4hUGf1FVeeyRlw=
X-Gm-Gg: ASbGncu1uNB8ZSCKBYnwQDYYnCCNqSy5FijwVcHfnvgDeytQiPu3xMfJ4JW4Px7TI0f
	pv78Izl3/Hgb+9Rm4PnsLovo57GvE8qylPDQRCflh3LkXMWHLJztV/Bua+lWDAmWf78G3SngOSU
	WMPzg0DqoJXihqx0u6XdYLbIVOv8Uuco1uuQ3UFuCUJe1v8phYQP/2BMSyPP/foTN1a4WM6tZ9S
	kxZ4HJiegEpw/zTSESii4y1q4rkmukhbS0EyeaujTAArK01ILYZp/+VnsvJ2pVwXBfTsbw7BMkz
	Y7Isa5tnvHt/SKEGVEmZ7itCskK97pbDhqBG+mV3pNjuqjNhLHPRgaBC2TrsdoPArPHDJ7lzWRW
	CM1oahOeDzEWeSIKkod4BPPhyuiKNwoEsOORkHbY=
X-Google-Smtp-Source: AGHT+IHodi61zfzp52J3sxD8dHGk2k3hM7/NlCyvWG/l8ZNkZqM5tPwjl/YMZIpCgoWLwxEZcz55rA==
X-Received: by 2002:a05:6a00:1907:b0:736:a82a:58ad with SMTP id d2e1a72fcca58-73bd126b882mr362099b3a.15.1744319876899;
        Thu, 10 Apr 2025 14:17:56 -0700 (PDT)
Received: from bryan-ThinkStation-P520.tds.net (h69-129-150-238.mdsnwi.tisp.static.tds.net. [69.129.150.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd219d98bsm36793b3a.11.2025.04.10.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 14:17:56 -0700 (PDT)
From: bryan@schmersal.org
To: calum.mackay@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Bryan Schmersal <bryan@schmersal.org>
Subject: [PATCH pynfs] Actually reuse the slot only when the sequence op gets an NFS4ERR_DELAY status.  Before this patch, any NFS4ERR_DELAY would consume a new slot even when the sequence op was not the culprit.
Date: Thu, 10 Apr 2025 14:17:20 -0700
Message-Id: <20250410211720.480587-1-bryan@schmersal.org>
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
 nfs4.1/nfs4client.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/nfs4.1/nfs4client.py b/nfs4.1/nfs4client.py
index f4fabcc..a180872 100644
--- a/nfs4.1/nfs4client.py
+++ b/nfs4.1/nfs4client.py
@@ -539,17 +539,21 @@ class SessionRecord(object):
         delay_time = 1
         handle_state_errors = kwargs.pop("handle_state_errors", True)
         saved_kwargs = kwargs
-        slot, seq_op = self._prepare_compound(kwargs)
+        do_prepare = True
         for item in range(max_retries):
+            if do_prepare:
+                slot, seq_op = self._prepare_compound(saved_kwargs)
             res = self.c.compound([seq_op] + ops, **kwargs)
             res = self.update_seq_state(res, slot)
             if res.status != NFS4ERR_DELAY or not handle_state_errors:
                 break
-            if res.resarray[0].sr_status != NFS4ERR_DELAY:
+            if res.resarray[0].sr_status == NFS4ERR_DELAY:
                 # As per errata ID 2006 for RFC 5661 section 15.1.1.3
                 # don't update the slot and sequence ID if the sequence
                 # operation itself receives NFS4ERR_DELAY
-                slot, seq_op = self._prepare_compound(saved_kwargs)
+                do_prepare = False
+            else:
+                do_prepare = True
             time.sleep(delay_time)
         res = self.remove_seq_op(res)
         return res
-- 
2.34.1



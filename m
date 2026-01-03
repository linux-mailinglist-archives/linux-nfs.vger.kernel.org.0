Return-Path: <linux-nfs+bounces-17425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2553CF0717
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F441300A36F
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACF253958;
	Sat,  3 Jan 2026 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3hpJEmq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4709020322
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483685; cv=none; b=heYIT65QEckWMliTZvNJzTxh83ERGZbCThkpDzxypZSWI6L9naxzazS30mRd7xDSLN8CLzJTvnfUSIH7G/AjewXg2GUCUrkmRotkWOwGGhSemprtxOtJGB0J8K6DoZAQN2OrXOSBiumbIsxELXCKt64oFFCFgSG7oNX0Ko7XXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483685; c=relaxed/simple;
	bh=y8ALTowBKf0ZMLJaLbIPRtyl1blXimb1OA4fsaKyxdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxIDouedylTi3cNYve6mBosc73Yb5lG4pT/eG4bv6rwOkSYXounVDePy0zeS0EAVVexdP93zXxAXDZtQMs+9x/YtK/9s5q7QZEe/I25wPPqLdGaRznv1YnOgk+W7CTxsJxDkrTZVeltp5hfjv1TrHFjEFDtBxSbSUtUWNQjT6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3hpJEmq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso10603192b3a.2
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483683; x=1768088483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9PiQr9M8cw3lwxs/HqhR0ZDFFSPpGVvMCeoIpuC/EU=;
        b=W3hpJEmqkbWewpvW5wyehTspRHGB31AtIMspLWwe2PlRCo4E81aM+NEZU3lQ618Mkq
         HPfvDtYsMXxMI/CuVmU1E/+twxHO1Vi6cBdgccK+QaSEn9kDtoAF4Qg/otQgYsyT3GeB
         hCqudSvPevna9b6ZHUfNxhEhfS8PPF5i6iTHPtcS5iWqd6BQ7cA+lyxxayzjpjCgjhZi
         ttr92esKrCKelf/8CDVRO3cXAcUrpuWPZCnKca2yRzR1P+WsToZWWatALkvSfwKjUNMq
         4q9PLENJzU1MCqx/y1aXmhOQbuThWOvwaXm5dM/v7hIJk/G5ZVVslNB0gwV4wX//7EAA
         fD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483683; x=1768088483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9PiQr9M8cw3lwxs/HqhR0ZDFFSPpGVvMCeoIpuC/EU=;
        b=ezHbEPyLMSsK5vpqxq3wqwBM3HHIJ0JgSagELLi/mbxX5o0s0Pk7ouNTfKvXcd/oXZ
         ySQ+SUlhzbZKLgmveqV9IMW5xbUXwiXso2L/kCfIacofj2rMg87lpS/sq53WX4si7WIe
         MiBOlHtlevbT2AuvIINKEHvyXloJhZT/Y040Q75Cphqgl6SgNKjYow4Jzk7Y9bTiX6IC
         5N83K1ULg8ug77U5Rj8igfnKiYc26KTELPEWI1RUiNSr8M28B+ESLGzImeJWDX/Qd18d
         UklKrjrPC3AjSToubAh1gB0Hy7fQbVV80LooOLyqDnNPUxms+UoyVHRAHXNQCufu5rIH
         vSGw==
X-Gm-Message-State: AOJu0YxWtSJzoDmdLkLQVaZQDxFIP1CJGQljGSUveTkU/Gd4yP/nzSxS
	8V/8AnT6aR7QxXN4+5yXaMfG5iAfk0bqwxrom5rIWQTS3L0wjgY1/4rova0zbR8=
X-Gm-Gg: AY/fxX58TiStmyZ87EwfoIyIkOd9d1fCQ1I77fCCpupGp0+jyBVCYmx4h5ksqKKNUW8
	AvbR+hiU3km4J0uis0FZgblrxP8nEbZKlkZ49sETPVp9HCFRVGDaSS1EtO8LkqMgnIwsYK9ly6e
	ixt3KR+0679eNU4vMGXMWKF9sENRICBqR5lVKEdNDSUT7EbFF/H73kCgvwig0au5cYL3rp/wa5i
	i6RSOJ9uLtbIAMIC65OKlxSvrqrTBOOMcXEnjMd9V7KF8w36JFSRdzXYJUI6BAJL+8Hk/xRtkBN
	zMgsJ+3xoS1+20MVBKsff9ZM/eeHuZUgy9H4lJkjSMFwKi0N7ojSWG/hQ3LziMVw9dPQKJZEekF
	2kFhxYwXPc59dWzJXCcyw5V3s5+Ij13MKwMvB4dFKUMe4VTYjUTrR+7FhSLv/GiEJCu3rABQkgY
	M8nNCYo9uAmfSAyFF3q2HPiubsGq1eI3A8RaL/CPF9fOeVeaaPuqxwBvVC
X-Google-Smtp-Source: AGHT+IG6kwxOLaMbM098Zj8gIKEsN8Mt23X0LpTNcsGYKdg3jV0hyeUw8xW2/MtM5FakbprjVwKhuQ==
X-Received: by 2002:a05:6a20:7489:b0:364:1339:9fdd with SMTP id adf61e73a8af0-376aa1e76fbmr48328232637.59.1767483683448;
        Sat, 03 Jan 2026 15:41:23 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:22 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 2/8] Add entries to the predefined client operations enum
Date: Sat,  3 Jan 2026 15:40:26 -0800
Message-ID: <20260103234033.1256-3-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260103234033.1256-1-rick.macklem@gmail.com>
References: <20260103234033.1256-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Add entries to the predefined Linux client operations
to get/set POSIX draft ACLs.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 include/linux/nfs4.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 9d70a5e6a8d0..25f89d1c8ef2 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -732,6 +732,8 @@ enum {
 	NFSPROC4_CLNT_REMOVEXATTR,
 	NFSPROC4_CLNT_READ_PLUS,
 	NFSPROC4_CLNT_OFFLOAD_STATUS,
+	NFSPROC4_CLNT_GETPOSIXACL,
+	NFSPROC4_CLNT_SETPOSIXACL,
 };
 
 /* nfs41 types */
-- 
2.49.0



Return-Path: <linux-nfs+bounces-15077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 102F1BC6D61
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 01:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE04E38C7
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81B2C031E;
	Wed,  8 Oct 2025 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKAg/AxV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEA277C9B
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759964987; cv=none; b=PwcfJaSZG1whSH9FulfvlJY7tHxea+HwrLSdSr3esHTyG+yHK4rrfjoreRrvlYJlw0h4UKGSP29tV05IeJUhTWvobfJsn3Ect64BtEfLc+XcODx6njRyD2jLpbX/Jbksfx7e4+ybeNVJk2KJZ8Jh7IEAWS3mqcR9ylvFuB6zJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759964987; c=relaxed/simple;
	bh=FhRAN7vu1DLulCz3OzV9i06+tfU1UMryaWd3DwW2cjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aO9jVaZ4YrL1c7QKk0ZeFgdcPslcbKm+u/DSmrc8i42wlVot5E3GDAbp1ZPTxCuogYb0SB/ecv8cwqzGu3SH7eyTTm+BkRdx22wkdf3T7z64SOYUnlrlwaIKrlSe613vv9BdfPXJT25HUW864DJ4GAYxFWxtS7M9uY/I67CvlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKAg/AxV; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7a9a2b27c44so335840a34.0
        for <linux-nfs@vger.kernel.org>; Wed, 08 Oct 2025 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759964985; x=1760569785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T2bFk4SSl7P/0ekUqn9nNLfjSUxmhesNwRFAlv+rls=;
        b=YKAg/AxV2WYAczW/G5JvqtS0MnDUvhMRHqC1QzqpNR0DGzf+Sv7HcgxE/4VMQb+Y6F
         y0W60WGiZ6OD1kcwGW4v2CY2Aa1RQpmeWFgpMvz6uMxc0/T0N4JLGiLmcE4iOr6047T3
         KenOO+jSpCrwpwqOdvJu2mMhLHCMZEL7J7b+qocZUjZY3PupZ2HvfX0/27cZOygZ/2vS
         hyY7qgcbozlKG+KWsNJaTlGRchb6y29HUtg45eSCgwcE/3W0ioKb8CyJyzC/KyUz04EA
         ahm70wLLpwbU80psru7sTzk6ih6WVYz+rPuIBKEVwvacclKk1H4Sbcw5kmjwxmAABUzC
         F8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759964985; x=1760569785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T2bFk4SSl7P/0ekUqn9nNLfjSUxmhesNwRFAlv+rls=;
        b=jdlUrBj+zVIV3M26CnFBtASOattoP49hnGDdYX0izWtdHkbzYZnCM/Jhk9Nc/yXEcA
         hFjE47Z/enT/U5YbdHuWjZVnxWXa79gvaGnW4hLYg5mUYF4YEpkPHZmpItH2XNTcW7qN
         497Ron6iQTVWKy1flvMGCStl/Zg6TOdxnAG6Y5u+V3SgnlY6YpD4Hi+Yx5fdg9ixyPQw
         QU3wTXd/ZqQKm4jT4i/YVEEsY9s7FlnjfTQL1Ax3nJJg9E1/MoSrfz/6dDIanX+Wq54s
         gKpKe1GTu+C8WZNRfniv1EdadQA/0IMq8uoNY5iuj91ksiyWxSAlNh5aOGfSpH9WfL0e
         QFbQ==
X-Gm-Message-State: AOJu0Yz6pyXVtjUJp1ORKnwI8QXngMBKnUDD33AQQjDDEPgRHqZxLRx8
	/+0ZhqVHShJnVqUs30y9aXVfNcPcBbI8074d2a8m2XZ1vCBffDsca9zexrhjWA==
X-Gm-Gg: ASbGncuFA7gPYYVpOGHnprg2at+z3cm9Ln67gxgEWxGEMMFL6+JbPvEeoDH2/+4d+7O
	GhXno5NWpiBvGOVZuRUd6gGDDFNyjjoX+ZeASRTuU087o+MG6ML5NDgBCZJjshA7Ocqb83WuvcV
	EoLHwXvqyXGEXVb+eLC/QOGQ/HkjrKEIm8+wUqF4GjYIzmc6ewnTNaRgAQR5QNyuXVG6/9Qkdy6
	H9kbEEWBpc4NnM+OM3b2Bik2yCf+Tovzo929cyhoo3/6dKQsNBRY/brdVCiwPtNHabSuDuQ5AUC
	LlQNcM8Wx2B2xRsgs/39XNuB4YKsDYBpD7N36zVgaXEzMY83Bq6BBTV5rLH40kTh307waFyHFng
	kw6vnTVVwcaDS4qMwiTWP2svnNLyTH47Fs+hmKV9A8E/oqMfvzKKug1+r5JYR0ig4kg==
X-Google-Smtp-Source: AGHT+IGuTD1Noi9gIw4Wpud6moX/5kvZZcFur+/n3JxzjhZHmEaAEI6X9bG5JPTdzLylCvnEazTFyQ==
X-Received: by 2002:a05:6830:6103:b0:799:bdea:348e with SMTP id 46e09a7af769-7c0dfefa6c4mr2850635a34.16.1759964985123;
        Wed, 08 Oct 2025 16:09:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::5dba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcf8f1sm6141426a34.11.2025.10.08.16.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 16:09:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Watt <jpewhacker@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH] NFS: Fix state renewals missing after boot
Date: Wed,  8 Oct 2025 17:09:22 -0600
Message-ID: <20251008230935.738405-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

Since the last renewal time was initialized to 0 and jiffies start
counting at -5 minutes, any clients connected in the first 5 minutes
after a reboot would have their renewal timer set to a very long
interval. If the connection was idle, this would result in the client
state timing out on the server and the next call to the server would
return NFS4ERR_BADSESSION.

Fix this by initializing the last renewal time to the current jiffies
instead of 0.

Signed-off-by: Joshua Watt <jpewhacker@gmail.com>
---
 fs/nfs/client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4e3dcc157a83..96cdfeb26a90 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -181,6 +181,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_nconnect = cl_init->nconnect;
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net_track(cl_init->net, &clp->cl_ns_tracker, GFP_KERNEL);
+	clp->cl_last_renewal = jiffies;
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	seqlock_init(&clp->cl_boot_lock);
-- 
2.51.0



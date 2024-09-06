Return-Path: <linux-nfs+bounces-6296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D896E833
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 05:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC386B232D8
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2024 03:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA621E521;
	Fri,  6 Sep 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRGtGNWC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002B381B1
	for <linux-nfs@vger.kernel.org>; Fri,  6 Sep 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593216; cv=none; b=nWfCbcehr7zl7NpKYwQmahpm3YncFX6Wou/TxbaBzAmvVBFL7rWCamI95yz7cJAdjlQfQcyefKX1dYSYWeatFsYxaju+q3wcawnY5CLbzTu6Xt+/+j92zkdqB18/Ivnssoxnzs3VAZUo8BPWXGGWoMG7QBCYYL3QV+eWoZfoqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593216; c=relaxed/simple;
	bh=e1aJctxIKGKtQd3vXaa+PDx1/NWlaFWvZglOIlx1Ips=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=spSQCgd8aZe4cAI8EG0U/e3uSisUiI/Hgsz2bZawir0tuv1tQ/FukC0cWAzwswhjXZQXUaFHY4ZvKRihB3xVhX1DSIxROrzigExHt6XWKc+NyC4g1nuqFC4Hoanm4ebL+dxVvMD0+RjMP7nw7OmaW/vxJEfKwf8mOF8K9guZduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRGtGNWC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5dd6d28c2so58172657b3.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Sep 2024 20:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725593213; x=1726198013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WJjdg+pyOSRf+cJpzdpWgscOblysr8CkyzUw7sQ8Bkw=;
        b=mRGtGNWC5edpehaZKlKyk1muU1A4Mc5UuFynvwuRcnLK6z1XaY0IhxKuu2lejitFjl
         Ui9rWVSF33o6ePptLaqIBDHImLUMSjolG7rYWHUR01SRP3ADijyA/sCeWe2c735laRAH
         Eayvi8cm1LGmBoSCzUklSEPMUW9GjOw+6nZml7dbeMDQ3CtKG9u4Gw4vepAsEFWyaQEq
         urNhGOoq8SJS7+TVOmEMPmgzoOzzpqGgb1tNfPu0e/VR/LpMItsnm+N23yagwqYgSQat
         pE7pbe0TiEX/lj6xqttQWyU2TjLFKPrV1bAv46VTNy8hHgFCMq5umCWPodL+AuzEU5PL
         8KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725593213; x=1726198013;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJjdg+pyOSRf+cJpzdpWgscOblysr8CkyzUw7sQ8Bkw=;
        b=a/ekG8zgOLBEKAuAgHEmaCbXHGEqZh0RONhdQVvDmkYZJevZ4SIOiZb6bt3rJZgg8K
         yDlpMxd3ud1xusN9Utk1j1OkcuywwhXDqi50VfpJGP6e2F25Ct5YhP0a3/m/JEJ6pGft
         H4pNmgTKnenHRUZ4ZgvwG1YfE+jgQcElwLn48NasqNZllhLkpBIb0L1OE+mopJn3WxRY
         aN+nHwJGHqaLIINBy4xTh/SwqA6roH9pT/6arpxBpMnmhNqLBs0SpwO+kKm2UrIf73LA
         shIFn1vium5LhTxzL3QsJ3gpzYYMFc+r7l5AvpMrZOj+Lrr1pQSptCV6Dsz+/KfipMuF
         qacg==
X-Gm-Message-State: AOJu0YxkeQ3XikhQgBy31wiuP6LOHTSCuAA4BhrPkqNfodDunW4OG8Sx
	9/8Vc7fkMRKQOjX9N16pUnVX6rqQAE4pb97cUyWesIaVTgfG36x8HnMXkdExKwIqxQ==
X-Google-Smtp-Source: AGHT+IEU9DFh6NFxoy50K1tQGvlzknueV8lu18ifJiHlFFADPfu5hB7sUvLI6yn7RDZDfNyTt6Td9tU=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a05:690c:308:b0:6ad:4eda:ca25 with SMTP id
 00721157ae682-6db44d5d0eamr833287b3.2.1725593213271; Thu, 05 Sep 2024
 20:26:53 -0700 (PDT)
Date: Fri, 06 Sep 2024 03:26:44 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHN22mYC/4WNTQ6CMBBGr0Jm7ZiWHwOuvIdhUdspNEKHtEg0p
 He3cgGX7yXf+3aIFBxFuBY7BNpcdOwzlKcC9Kj8QOhMZihFWYtOXNDbiDO//IqGlJlYP9G6Nza
 NlvWjakm0LeTxEijrI3zvM48urhw+x88mf/ZvcpMokZRUZJuqsp2+DczDRGfNM/QppS88ZyZSv QAAAA==
X-Developer-Key: i=ovt@google.com; a=ed25519; pk=HTpF23xI+jZf9amJE+xfTRAPYN+VnG6QbPd+8nM0Fps=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725593211; l=2227;
 i=ovt@google.com; s=20240521; h=from:subject:message-id; bh=e1aJctxIKGKtQd3vXaa+PDx1/NWlaFWvZglOIlx1Ips=;
 b=a5jVYpQMni+eXPxfWv6Gr5Sv43ncNITdPCdZ4uHU6rIVr4VhvNNXt/JbLcVntdWN1yTvdVhwB wHm1MKT8vYUAfvaO+9KvkaV5TsFQgHqymdkYTvNBSQC/8WJCYmj2O81
X-Mailer: b4 0.13.0
Message-ID: <20240906-nfs-mount-deadlock-fix-v2-1-d3b81d6962f2@google.com>
Subject: [PATCH v2] NFSv4: fix a mount deadlock in NFS v4.1 client
From: Oleksandr Tymoshenko <ovt@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, jbongio@google.com, stable@vger.kernel.org, 
	Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="utf-8"

nfs41_init_clientid does not signal a failure condition from
nfs4_proc_exchange_id and nfs4_proc_create_session to a client which may
lead to mount syscall indefinitely blocked in the following stack trace:
  nfs_wait_client_init_complete
  nfs41_discover_server_trunking
  nfs4_discover_server_trunking
  nfs4_init_client
  nfs4_set_client
  nfs4_create_server
  nfs4_try_get_tree
  vfs_get_tree
  do_new_mount
  __se_sys_mount

and the client stuck in uninitialized state.

In addition to this all subsequent mount calls would also get blocked in
nfs_match_client waiting for the uninitialized client to finish
initialization:
  nfs_wait_client_init_complete
  nfs_match_client
  nfs_get_client
  nfs4_set_client
  nfs4_create_server
  nfs4_try_get_tree
  vfs_get_tree
  do_new_mount
  __se_sys_mount

To avoid this situation propagate error condition to the mount thread
and let mount syscall fail properly.

To: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Cc: jbongio@google.com
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/stable/20240906-nfs-mount-deadlock-fix-v1-1-ea1aef533f9c%40google.com
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
Changes in v2:
- Added correct To/Cc entries to the commit message
- Link to v1: https://lore.kernel.org/r/20240906-nfs-mount-deadlock-fix-v1-1-ea1aef533f9c@google.com
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 877f682b45f2..54ad3440ad2b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -335,8 +335,8 @@ int nfs41_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
 		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
-	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
+	nfs_mark_client_ready(clp, status == 0 ? NFS_CS_READY : status);
 	return status;
 }
 

---
base-commit: ad618736883b8970f66af799e34007475fe33a68
change-id: 20240906-nfs-mount-deadlock-fix-55c14b38e088

Best regards,
-- 
Oleksandr Tymoshenko <ovt@google.com>



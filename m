Return-Path: <linux-nfs+bounces-1382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7F83C5F2
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C474D28805A
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5B6EB61;
	Thu, 25 Jan 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcuHMPJ5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D76E2DD
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194585; cv=none; b=jclhFG/yeabsetoWj/zccVXCVKIbIl5M/cqR6PKpjTZD/MYrHbI/+Y+cdJ6Inj9UKpv3lSPhcfLZihYLV9gQewGtWFWqlwSsy22xk/4SJWLDy41Wfs5Z3slG+3CqLlNCFraq+dQUJKA+bkI01Zaei+NdhVH+2FQ0j+0r/7Yx+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194585; c=relaxed/simple;
	bh=AENq0fPakHDiI8hwjSWAFG7ZMC5X2Z4Q/oGV9qdzrG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iebgxn+AZPgTHfiUi8/4Qz5jNMPZ0ZXTwytXTu/xGSzUgviqjxBEjWPq7dGRmrkKF3fTUYb5IhBQVFWrpFDv5a2SeM9K/GMH0Fu3DpkyroQqQxy9piynUXMCziDJSakYx2EZvH8Zur4D3+LOuSKxMl5qFyG+OWbR+Nr3kTTToBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcuHMPJ5; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e0a64d94d1so4072264a34.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706194582; x=1706799382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iE9DXTHUEz5zuH3dINdN1yjRDPi4aINb/9J5vwW/zK0=;
        b=EcuHMPJ5wgdxUkRGOpyRhdxM9QptB2+BhMvL3XDuj4SeicxyEMoJSq8PgCqmu2D43X
         WBDazHWoCY2P2SCjI4+KzDqHjRKTz8sm7iIKdtaYnNb7HxoereCjWHojYjQSQpqxGYRt
         ndLa8Guz0jZLVdv1+UKuOVimYuPeO4bifUffJqi4iMvjXx3CRLU7hy/2zeHOKrH5CBAz
         mBgs9vkBw3aC9b3O+ncKhnGdz1JRJqW2MyHMMWGzHne2R03oGQP0BJSuXXkYJegBli/g
         w2J5tXXTjccVGZtpfaxFB6haxF0quUGHEOrdJP65ZnwpRUVg8aV19ULd260LuJ0UiNxQ
         iEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194582; x=1706799382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iE9DXTHUEz5zuH3dINdN1yjRDPi4aINb/9J5vwW/zK0=;
        b=XDMW+hG64fWAOu+BSeiYOwVFIoId4q+kdh+3IUvOZWGlwMt+eTxWwDwXco2BIB2Onn
         3Y/KtBWaneRylIza7qVfZ4Stakmobznsx/t9+4RYT2RYSHv2e+tF+RQTSyWQI15ge8C6
         Zowv3x0ynN5HShQRYaP8Qv1KMiLmjsna3khO/FomtUtdcE8jGBUaZIIG1iU3EU+hlvM6
         7tdtcDNXeCws8zpHPRBcGgA8sT6/qe1Nk/YFIaQc6V0pZqbcwjRsex8Zwawv9KndLDjA
         UerU1nB09Wq8RqyTtNR10EYVHTsVkWVLDo0sC6aR0oYl1EBCiXnvjzs/nAJwem5GESAF
         eX6w==
X-Gm-Message-State: AOJu0YxtZhRq4iKGoMULsHeD/uqDNP2d+GZRfQABBfNjOzXU1Y02KN8t
	EerlIWQzZHl1H1CmR8+ttyDwSI80NV0dYMzN1vGJhSF6I6CZyIxsW9zWfT6f
X-Google-Smtp-Source: AGHT+IECYO2+PdA0aEB8SWgFXI1ZpkRTNmz8ZrjSwULwUHl8ILeaVlLt/HTLp8izXWFanIDNEcUWqw==
X-Received: by 2002:a05:6830:1282:b0:6e0:cc47:e695 with SMTP id z2-20020a056830128200b006e0cc47e695mr950666otp.14.1706194582128;
        Thu, 25 Jan 2024 06:56:22 -0800 (PST)
Received: from netapp-31.linux.fake (024-028-172-218.inf.spectrum.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id k12-20020a9d7dcc000000b006dc93918dd9sm3081571otn.26.2024.01.25.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:56:21 -0800 (PST)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: linux-nfs@vger.kernel.org
Cc: trond.myklebust@hammerspace.com,
	anna@kernel.org
Subject: [PATCH] NFSv4.2: fix nfs4_listxattr kernel BUG at mm/usercopy.c:102
Date: Thu, 25 Jan 2024 07:56:12 -0700
Message-ID: <20240125145613.12995-1-mora@netapp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to listxattr() with a buffer size = 0 returns the actual
size of the buffer needed for a subsequent call. When size > 0,
nfs4_listxattr() does not return an error because either
generic_listxattr() or nfs4_listxattr_nfs4_label() consumes
exactly all the bytes then size is 0 when calling
nfs4_listxattr_nfs4_user() which then triggers the following
kernel BUG:

  [   99.403778] kernel BUG at mm/usercopy.c:102!
  [   99.404063] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
  [   99.408463] CPU: 0 PID: 3310 Comm: python3 Not tainted 6.6.0-61.fc40.aarch64 #1
  [   99.415827] Call trace:
  [   99.415985]  usercopy_abort+0x70/0xa0
  [   99.416227]  __check_heap_object+0x134/0x158
  [   99.416505]  check_heap_object+0x150/0x188
  [   99.416696]  __check_object_size.part.0+0x78/0x168
  [   99.416886]  __check_object_size+0x28/0x40
  [   99.417078]  listxattr+0x8c/0x120
  [   99.417252]  path_listxattr+0x78/0xe0
  [   99.417476]  __arm64_sys_listxattr+0x28/0x40
  [   99.417723]  invoke_syscall+0x78/0x100
  [   99.417929]  el0_svc_common.constprop.0+0x48/0xf0
  [   99.418186]  do_el0_svc+0x24/0x38
  [   99.418376]  el0_svc+0x3c/0x110
  [   99.418554]  el0t_64_sync_handler+0x120/0x130
  [   99.418788]  el0t_64_sync+0x194/0x198
  [   99.418994] Code: aa0003e3 d000a3e0 91310000 97f49bdb (d4210000)

Issue is reproduced when generic_listxattr() returns 'system.nfs4_acl',
thus calling lisxattr() with size = 16 will trigger the bug.

Add check on nfs4_listxattr() to return ERANGE error when it is
called with size > 0 and the return value is greater than size.

Fixes: 012a211abd5d ("NFSv4.2: hook in the user extended attribute handlers")
Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfs/nfs4proc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7e3053339d6a..a4704bed5aec 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10615,29 +10615,33 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	ssize_t error, error2, error3;
+	size_t left = size;
 
-	error = generic_listxattr(dentry, list, size);
+	error = generic_listxattr(dentry, list, left);
 	if (error < 0)
 		return error;
 	if (list) {
 		list += error;
-		size -= error;
+		left -= error;
 	}
 
-	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, size);
+	error2 = nfs4_listxattr_nfs4_label(d_inode(dentry), list, left);
 	if (error2 < 0)
 		return error2;
 
 	if (list) {
 		list += error2;
-		size -= error2;
+		left -= error2;
 	}
 
-	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, size);
+	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
 		return error3;
 
-	return error + error2 + error3;
+	error += error2 + error3;
+	if (size && error > size)
+		return -ERANGE;
+	return error;
 }
 
 static void nfs4_enable_swap(struct inode *inode)
-- 
2.43.0



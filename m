Return-Path: <linux-nfs+bounces-3194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0969A8BE72D
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8201C23F0C
	for <lists+linux-nfs@lfdr.de>; Tue,  7 May 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D45161333;
	Tue,  7 May 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbFHK9Qb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE093161914
	for <linux-nfs@vger.kernel.org>; Tue,  7 May 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094949; cv=none; b=hmngXJ31Se+YU3b8kI1aSIDON5X8w1QVtD9pl19RTGljs8+AXubHoUMHWH2SJURy+4z2kdJ7cjvyxOZFuujXnFRfU6DtHZW0inyq2eF5qscdgsmW6tQeFpkv88elWeILXR85mToVVf+lMllyOKx8jn/DZAyQyX2AzcCw031EbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094949; c=relaxed/simple;
	bh=DJrbVhanHF46wmNheuePa63BzVo0wBaKgt7SYG7AoUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LSST4YU12VlxALACwMbaQ066H6ytRE8/mPB6uVDLlWxO15/RSGJSbRwyxNsmPUYE2wNaVxXBNpKmNf9qC8QTtQ5eM3QxC6rFU76e7a0Vt2H4GseTbFSwBAmbdYA5UhqGeDWg6E6aUOexIViP1zbkqY42c8dnHHiTv/54GxDk0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbFHK9Qb; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7dee034225eso25150039f.2
        for <linux-nfs@vger.kernel.org>; Tue, 07 May 2024 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715094947; x=1715699747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fqkFN4zmG3dNFhw0/Fbi7fTwOlgiKVyndNc3kjN6Ql4=;
        b=YbFHK9QbzXGApSi9v02eiR5Y/QAQPgr53yzYFDX9rogSDkg1DZQ4XGfBxWhYV6bsDj
         /HsvPZOoBHtzUwYHeev4jbACbVrW5lxRE6q14aQ0AMzf6UR1GVK4HcC9/pkJYwdHxLb7
         R0nrm2m8PJ9l67u05rva5dxWTOGKJ0lrK+4EDT8hNgcSsm0EkTPRQ0L6mMalljxmb81Z
         L/gtXonjq4T1ywBLnx1s6HdDabn5/7/smJ33yMXQo9IT5gY2G9jDqr0A+Og8dfNwcGiM
         wxsOK8AlF/2b+TlDhLGiOFPv2ZRDg/Jh42LAUb44RkGjZVUOZLmZExQPOKIYi0Z+KP+C
         uV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094947; x=1715699747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqkFN4zmG3dNFhw0/Fbi7fTwOlgiKVyndNc3kjN6Ql4=;
        b=ZE/uxMu9yrcMZ8FrtoFp0B3b9h0p0xHUgn7T8zIovSzbFShod4UfPf8wnaqi+v60jj
         R+ObPZ5pFE6egDWGMTfoo7u2+0t/kMBwIXtyut3Fu86GhsE3qQeBShKEK65ZmLbex6Vg
         R9tyOwYHI2A6yiTXEbAX2uAGNAjywJiJq277ygmByxwrW1UQrLTGgp9n74gybhda0lp3
         5IB0yl1rnhE+msddro82A2l2syE6gEi2s5Fn8S8v5Owd0k6Y0iddcyqevYgVEya26yc3
         Om8Zs1Uv526nB6J3Wa8NG5/e61AOKrczjl7IQL5Y5EzE0rzt656EYltvZBEosax58knY
         Fb0w==
X-Gm-Message-State: AOJu0Yy8gHDTDBAldU2evAvpYj3ainBnC4C2yxu57Rii9BVQZeIA/+MB
	eRWxSxCl3XjgjyaKeJWEcWy3ZTE5K/lt8FADEkPVxRXDWoB7LpxW0Hr2nQ==
X-Google-Smtp-Source: AGHT+IF5XCb5cDaS0d388LFmPsvj/RuDgkUbXqSxZjUMMfNZuiMxuQQwwjkJwgtF3Z1l6UKKg77/Cg==
X-Received: by 2002:a5d:8454:0:b0:7de:e04b:42c3 with SMTP id w20-20020a5d8454000000b007dee04b42c3mr13573030ior.0.1715094946993;
        Tue, 07 May 2024 08:15:46 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:d0a5:c6e3:4e72:2c07])
        by smtp.gmail.com with ESMTPSA id k9-20020a056638140900b00487c16a1ea0sm3005908jad.35.2024.05.07.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:15:46 -0700 (PDT)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] pNFS/filelayout: fixup pNfs allocation modes
Date: Tue,  7 May 2024 11:15:45 -0400
Message-Id: <20240507151545.26888-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Change left over allocation flags.

Fixes: a245832aaa99 ("pNFS/files: Ensure pNFS allocation modes are consistent with nfsiod")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index cc2ed4b5a4fd..85d2dc9bc212 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -875,7 +875,7 @@ filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 						      req->wb_bytes,
 						      IOMODE_READ,
 						      false,
-						      GFP_KERNEL);
+						      nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
@@ -899,7 +899,7 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 						      req->wb_bytes,
 						      IOMODE_RW,
 						      false,
-						      GFP_NOFS);
+						      nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
-- 
2.39.1



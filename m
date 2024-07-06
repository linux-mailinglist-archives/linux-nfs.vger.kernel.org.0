Return-Path: <linux-nfs+bounces-4688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A168F9295AD
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jul 2024 00:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0031F216B3
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2024 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4662557F;
	Sat,  6 Jul 2024 22:42:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E981E
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jul 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305733; cv=none; b=umo/3P7yfPHwLcTlWexpem98FFnB7Fd/asVCR7N7GH5OPZRV7cuwAkzBgroe2kXj5h36G/DYVeJXsLhy9+W/8rmNFJt6DEL4UaURl3/BLnITGNeR58iT63gOhSYu1m64i/zsh6Tayxk/py10v4Y3KRuB4mouLni+BNH+ajUF5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305733; c=relaxed/simple;
	bh=XnpCkdubbnfTWO9sijKIfyng0By3JqGZDFZXJtMGvtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbYO3LeGJ8xqWfeH17q42BzVqipDPGy6MsWgAp3ziGyc3hP57YbfB1/8Tr8M+Nmyhe91DyAzyBu/JugEWpQwYGcxGISK29Kbj+teKzJvd8DL5aOA5uPmtcTht3HdlhZRDM4WWulfY7SVMtv3JLtXBOQSAqsjNl/PYL7Kgnj4lSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42662f7c034so137345e9.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2024 15:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720305730; x=1720910530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWnQ1fwqYrJovR2V1lpljMxCoeWfB80H+RtRH9i/Pc0=;
        b=jtJfTLBk/TJ82avtc46LPdTGEnsJNtVvWkugwGPlqwB493fgty66aZhdjhlPMd1lm6
         NMG4Rc0N8Q1j2Z/wjGVhiXPxGg3usbcSzAoyoQgswtqCQsdnVWZLgqUWgHasyNeriADh
         RtMeFFmJ8mrl+EdPo/Q+QXsF4Xg4k19FxfaJ4jBtHptZ7rMYXutiHAaCYf+ndqLjL4lr
         CVwKoeYMjZkE6B8tOcPLau8x5H/uAUGUVMm2d6jKRdUo2Vt3UsvsZhggKQ2Kfli1y0FY
         4ReNvpvs8KMkFn2krwuWNv2MWZfAHlZjvZDgYLD88IqEXxaMEWLOIwjDeyp28Z5LLijs
         Q2+g==
X-Gm-Message-State: AOJu0Yz9myHuOZgMzDd+RcWkwW4Ny66SuD/wuv5zHqm1p6GrgQIv0SzM
	2uPCXvop9GZBcOPslLwzry/9U4pvITUkymuCdZtrJcs+Ok+0WZqJfHjpwX+W
X-Google-Smtp-Source: AGHT+IGN3IpKWBuWQm/2MONk5DvzKgvJg3hvX0uC6S49yx0v2j3FHw/XSmQ4t8hPfazscech8LlNag==
X-Received: by 2002:a05:600c:1f87:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-4264d4e6cbemr51970065e9.1.1720305730102;
        Sat, 06 Jul 2024 15:42:10 -0700 (PDT)
Received: from vastdata-ubuntu2.vstd.int (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f23c1sm109395185e9.28.2024.07.06.15.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 15:42:09 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
Date: Sun,  7 Jul 2024 01:42:07 +0300
Message-ID: <20240706224207.927978-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many applications open files with O_WRONLY, fully intending to write
into the opened file. There is no reason why these applications should
not enjoy a write delegation handed to them.

Cc: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Note: I couldn't find any reason to why the initial implementation chose
to offer write delegations only to NFS4_SHARE_ACCESS_BOTH, but it seemed
like an oversight to me. So I figured why not just send it out and see who
objects...

 fs/nfsd/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..69d576b19eb6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5784,15 +5784,15 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
 	 *   on its own, all opens."
 	 *
-	 * Furthermore the client can use a write delegation for most READ
-	 * operations as well, so we require a O_RDWR file here.
-	 *
-	 * Offer a write delegation in the case of a BOTH open, and ensure
-	 * we get the O_RDWR descriptor.
+	 * Offer a write delegation in the case of a BOTH open (ensure
+	 * a O_RDWR descriptor) Or WRONLY open (with a O_WRONLY descriptor).
 	 */
 	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
 		nf = find_rw_file(fp);
 		dl_type = NFS4_OPEN_DELEGATE_WRITE;
+	} else if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
+		nf = find_writeable_file(fp);
+		dl_type = NFS4_OPEN_DELEGATE_WRITE;
 	}
 
 	/*
-- 
2.43.0



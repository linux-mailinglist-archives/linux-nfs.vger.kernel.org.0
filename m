Return-Path: <linux-nfs+bounces-11164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA6A92F0B
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 03:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8DD8A60BC
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Apr 2025 01:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BD52868B;
	Fri, 18 Apr 2025 01:10:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508D208A7;
	Fri, 18 Apr 2025 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938643; cv=none; b=gR75qVoeMgFlU8PoOcYJs27AJwD9tHHtekSEaJ2ctSulYbWgUXEOkY1FwLd2yfwRFX3KUFibbvTKtN9+ODuyV7lGq+48abtsUTlOIOcP4xPiM1LhITlARV1tquX12pJEjlouoGJ6vhOCct/weJVWYPRa0eNfte+/moCJS0nXu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938643; c=relaxed/simple;
	bh=Wm3jESX1tSXKrRgd3rN1JaV4baNtzAdeNWIoNwdac84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pac6qGQ+ulg9uSpl6a8CQwR5I5TRYzw7hjLTV9P7lid9NCK6rJYJs0CP48QvhUpUQPWTIvVy9cE83RZuT7V8qm4UNr2zNkPM83Y64+9iIbE+zJ4QfOPbxYSaS47g12/vgpT2cKlLoBKSH6ti/TKbkMNflinSLGY/dDvE8BoiysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so7815525e9.2;
        Thu, 17 Apr 2025 18:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744938639; x=1745543439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mV2eRB/9HhN4nfM5WxV5V6je33xWSYCMep3QIWs+pqQ=;
        b=u4ZweN4gL5s+cliSyQUAKGVbh5lVM1A+IjEZ7AhUxck8m2sEAIT9IFrIikVR2YEAzl
         jMANP/XvM1CyYTp7xfdM5l68c+4o6aKiOqc+SLQHBPydlKy9zdOsKaP3QXTsjMXnFqvn
         s5COV5/pWCRp40Bw2ufVydWVLV5a6vB3dbsk7kCSmd+xqnzD7DPm6D5U9J3uutA4H1IY
         bPnEW4qO4N2C9V0DFgw9yReHd9nOccFIE3cnKrSo3lBmqkmKjnN+1HksdKUgMnOkFmMQ
         Ay9X9RTUL4DOFh7GxUYFBIlsj4Zd7NeYoQLbQXr8gY4MphSvd2mEpkbgAvTskhXaKFtq
         j2mA==
X-Gm-Message-State: AOJu0YzPSE47yrQPXiLL4Esa2RMdso+dHLgX2fSXFbqPCtFP5Suz//K9
	VTQe4HIm/dC5k5rCJCulyLMIpZJiy/w+isz0LBVNDoP+0r74BIqfDIPvXXLw
X-Gm-Gg: ASbGnct3rcsADgBh8eNuhWSKW6k1+M9wj/NPonCi4/v+zU8s0jfN81/d4yJGxN4bJBj
	nW8JxB+tl1F0jFK/jw/1JGaAMz0AV58+v/x1bUZwhinaMdJFZkRRjbfbfad+O4Kys/hdtuyiIhk
	7VHNqLftdYocSQlW56olT8bXNES/XiqM3vJOmrf/eSbIYSRPbuCBpBvByptaiG+SDSf/cB2qB0H
	B9FGlSH5NK6CRtq4fhmcImFxs56Vn2D8zQ6BotocgPMOH5J6ZVF8gtkrdkEm+np6VlRIP7Mt1PL
	yFsvuknXXpWUX86TwxWFkNj1Ud+U0zFGR6ajxc5LmlGklkNKQ92iMQ==
X-Google-Smtp-Source: AGHT+IFz5jZP9x+SOYZ41gAgzoF64w9L9eHlg2qtqBAU9HBKFrkrVkO8g5qpBsCvyciVmej1pU53tQ==
X-Received: by 2002:a05:600c:3c9b:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-4406abfbcd7mr5751055e9.23.1744938639306;
        Thu, 17 Apr 2025 18:10:39 -0700 (PDT)
Received: from iss.intel.com ([82.213.226.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5acccdsm2605615e9.11.2025.04.17.18.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:10:38 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	balrogg@gmail.com
Subject: [RFC][PATCH] nfs: Revert "nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS"
Date: Fri, 18 Apr 2025 03:10:09 +0200
Message-ID: <20250418011009.1135794-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mainly reverts commit cb78f9b7d0c0c9f86d8c0ac9c46b8b684d8785a9
which added the requesting of FATTR4_OPEN_ARGUMENTS through
GETATTR_BITMAP to the get server capabilities sequence whenever protocol
version is 4.1 or higher.  This attribute was apparently defined in
RFC9754 as an extension to v4.2, never valid in v4.1, but it is neither
valid for use in OP_GETATTR.  As far as I understand, the client is
supposed to detect support for FATTR4_OPEN_ARGUMENTS using
FATTR4_SUPPORTED_ATTRS only.

In effect this seemed to break v4.1 client, server would return error to
this request.

While there, remove the unneeded initialization of bitmask[0] which is
soon overwritten.  The initialization was added in commit 707f13b3d081
which cb78f9b7d0c0 purported to fix.

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
---
 fs/nfs/nfs4proc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..3003f78e8764 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3943,9 +3943,7 @@ static bool nfs4_server_delegtime_capable(struct nfs4_server_caps_res *res)
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
 	u32 minorversion = server->nfs_client->cl_minorversion;
-	u32 bitmask[3] = {
-		[0] = FATTR4_WORD0_SUPPORTED_ATTRS,
-	};
+	u32 bitmask[3] = {};
 	struct nfs4_server_caps_arg args = {
 		.fhandle = fhandle,
 		.bitmask = bitmask,
@@ -3967,8 +3965,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		     FATTR4_WORD0_CASE_INSENSITIVE |
 		     FATTR4_WORD0_CASE_PRESERVING;
 	if (minorversion)
-		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT |
-			     FATTR4_WORD2_OPEN_ARGUMENTS;
+		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
 
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
-- 
2.47.1



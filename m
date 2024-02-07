Return-Path: <linux-nfs+bounces-1823-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F6F84D12F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 19:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BD428565F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 18:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A982D83;
	Wed,  7 Feb 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2AjPZkI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204F83CAB
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330556; cv=none; b=XlEit+ZVbMFjYKtqR7EYoi7CQXOFoPXHDoCXH2AIjs1tFfuSmIAgCt9GkjTO1BlnR3m/dWtwm/RjjfdD6n9FftW4Jh1TKpsJBx+bxVyLem9qOvbAwPm+WmI+mWbq1xxyU2ATpORDpgIRK/ATe1VBRvRkEzgtM05UfwmFstkVKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330556; c=relaxed/simple;
	bh=n/eNiJccqR7ZwIQRObUscT+s52TVTS9c9Z0jMgr8h6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SxJhN+BZ6sxupnw4a94fT9E+2pqHvXGlca7M/Ob6z/Ip+tVoz1mRBtrOGuq12rnZfeOIMuLHmGJXoMK9kj4d/w+/Dq3kufUQvoW5w0il8yYelKZOfREjAT4xd/yekH4W8ZCmCSgvGvVYV7JOo7Dxl99K1hWyMQZomaoUlKTvi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2AjPZkI; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c406c0ba77so1584639f.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 Feb 2024 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707330554; x=1707935354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFRq4aMMamtGOcYe/vuh8Q50GBaGwfIDd0LODC2LWO8=;
        b=g2AjPZkIBZTEOb4YcWJR3VA/0xFYauVUpUrBSqQ3UMrzmFHA0ZMfjTFFCsGOkjgUTY
         eBACaCYlP3YR6El+PwYgjshWNeIRCkORpqi96iDe8YD+5sUvDiuxysRBmbB/5rBwlnKb
         Cw4mZyy7JW10amVaE3/EvFLi8w6h9pVB76pflTTy6zAL+pXmJ8/mUMJEo4d8KLAWKSBY
         7Q7L2CsLnerGO9vofuEDqaV4PQMeXmuY6db77by0kr2lSb6aJpS//+lEXoGMmzpDuLWv
         uwXUUa/TsIxGdosFTA9rwBa1K/D0bIipijsRPWHpCzpSNoY6zVm+6JRCmftw7X8fNGR1
         ihVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330554; x=1707935354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFRq4aMMamtGOcYe/vuh8Q50GBaGwfIDd0LODC2LWO8=;
        b=a28ecjgFaJJg/SM/dgzlYLOv+8izGrPUUwmF3DRxRA1tNQEmaqysscALzIhKDbaywA
         fsbGdVIl1B0I2BIXZdvoaWlrCgy0WlUTEUiA+iG8ss4cJcqooVfqAqPGgTgsKuwr2Wai
         JWQXWNaURM+8dc7iCiWF0PcSFsFt5EzDZ0vAzxatZUt3iRm+9ln7Yt8l8+YRTucgc5Ue
         m8oeyXaJVbcgQtwig0Mk1/C+l0UpieFiFGQk+L6Y3tU3h5pV38AgSeDnjrvSHFHRNz6D
         Atg81dj4hxyBQLrwvSPUK7q+iKPO5S11czSumd8EEjr/mGvqoBQ5ir33/6epZbgKXL2N
         MJUw==
X-Gm-Message-State: AOJu0YwvGQvsxRQpstNEhWk5rcBcIYcGkpifC1neojIU8hBfYikIVHEs
	aD2mPTcTgkwEjjILNtSZJJfEAtkONIXVASFnFtOCh6O4ZsS5yaYJ
X-Google-Smtp-Source: AGHT+IFnBxwCK2NVt0mlJi4AtXAwwhsRPnp9V992JEOkCNy6q7tfapASMOjiBs+fGW3Bm4qkNcn1Pg==
X-Received: by 2002:a92:c266:0:b0:35f:bc09:c56b with SMTP id h6-20020a92c266000000b0035fbc09c56bmr8114738ild.2.1707330554424;
        Wed, 07 Feb 2024 10:29:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX220OCjfTmmPFpQkxFiwaBhw3NG7srAdC8jLSIMVHdO5wD2BWWH3RdZesCrss/s/vMAGo4WlrT6WOcFfL2/81vpXMjDAZjbubZ
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:ced:a98f:278d:91e9])
        by smtp.gmail.com with ESMTPSA id bt10-20020a056e02248a00b003639d72eedfsm534158ilb.5.2024.02.07.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 10:29:13 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs layout
Date: Wed,  7 Feb 2024 13:29:12 -0500
Message-Id: <20240207182912.30981-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Currently, if the server returns a partial layout, the client gets
stuck asking for a layout indefinitely. Until we add support for
partial layouts, treat partial layout as layout unavailable error.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index dae4c1b6cc1c..108bc7f3e8c2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9790,6 +9790,12 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp,
 	if (status != 0)
 		goto out;
 
+	/* Since client does not support partial pnfs layout, then treat
+	 * getting a partial layout as LAYOUTUNAVAILABLE error
+	 */
+	if (lgp->args.range.length != lgp->res.range.length)
+		task->tk_status = -NFS4ERR_LAYOUTUNAVAILABLE;
+
 	if (task->tk_status < 0) {
 		exception->retry = 1;
 		status = nfs4_layoutget_handle_exception(task, lgp, exception);
-- 
2.39.1



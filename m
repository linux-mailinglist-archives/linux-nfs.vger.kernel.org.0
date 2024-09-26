Return-Path: <linux-nfs+bounces-6665-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C09879E3
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 21:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC171F280A1
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFF17C987;
	Thu, 26 Sep 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1JSDDF2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373C170A3E
	for <linux-nfs@vger.kernel.org>; Thu, 26 Sep 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380674; cv=none; b=OJKb9iS94lL/x0HF/BCMoL/DCFVJacrd/LRp8c2r0LYT5Ih/h67vHpXzuyk+5mVBQa4ECz6lANrhs0AOxuvImINg6jDT1S1DIaeHln0tOUdsoZrxV+lkcfr/pMJoexD/L6/VeqC4F5SeU5tguLBF8xcFJgqv9wQVJjjpdBnXFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380674; c=relaxed/simple;
	bh=F+EmlPk/Paq3vwXpBLzTJSeSEfcznO1Im6jSFmg7SjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Krm0yB6CZ0daY7P5p+2UzAr3UEKlKSkPBOWN4UxihpcFuoSppMyjM1Wn1DMzYCQo1h11h/8kNoAHEQ0GXMb3MJeWEk/QciHcn5+qNg/U4ki07Z6JDN5EvzR3SPXHJOf3YvbXAm/w2GKrUUalbDwBd674/w/OtM4EML6pY7z5Q3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1JSDDF2; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cf3286261so61310739f.0
        for <linux-nfs@vger.kernel.org>; Thu, 26 Sep 2024 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727380672; x=1727985472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXyOGpmlpzQQORZBc2iZD8+meuBM7ykVM8SzLjd0JTQ=;
        b=E1JSDDF2wJoTlFBYMHdlNAnyQnzbC4Wq8FOyMSon7DtJU2jKWFlCCeNNf01WAhaTxx
         I8/w4PSm8iCT3NYa+bxTkLTe0PDWTDvvV6ZsDJiBJCVhrJt7r4JuXRqp2vCODzNS469l
         4A41/Hcj8RuPPPTrOTbYuJElRGyZP1qjFSMEVr5DVSU6iSIUNAk4wl/B1NCIpi9GYd/Y
         MpSfnHPsEc5Vxas2SmCGaYmZ/WUrv0b9CIs/hTcvnC4n/Khn9IG2UwmW/+3ZpF7hI2dX
         B/TbcLElCLtBw8rvvASI5eR41qYVDBt8dIbdRaAo84tcoABOSdy7CZogkv4yEy2RWUoA
         Hwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727380672; x=1727985472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXyOGpmlpzQQORZBc2iZD8+meuBM7ykVM8SzLjd0JTQ=;
        b=gAj/2a8R9XuZW5ROvkSw7TQEaWUd9tADWanSzj1udx9yOaHkrkNP2PfjxIgojTFwE2
         12fuzY9vp48ipjrTSi6hyd0+kSa2/fHOkbepPFNckovG1gD3bGzmaA9HHESrdCfgpRAj
         sFyHpH2BSizoEcG/mBCqVZFtiynLwG7cPbfbnarjdf50/HHwkuD/1bGG/6Zyrzex/XWv
         a7oHPzeiFriBm/jC7SCV5OqtMB+p/8UiSWbhN8Wv54OuUOS8Wk2mvDmIN6DIXi8N4Q1W
         Iw9QCqKS8tJ6zbcvtDj+FT26ZJx8AYle1CNkxqPC3fJQwqXXFx9v7HeaBmBEsANu4L9a
         HH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtFj4qQsK9XufUutBCZkLbADw5aX//+B6vgb2fHMucZHKmj3z6E0gvq+R1/bmSk2lmiMYhy13GUCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgHknJ84c27Ncy59mgFSnGPCPl69eZYPGt08GbN9dc3ShM3TJ
	p27pCdX8nedtVX4xou6jcTPgphTBI9ecpe2lazk2mp+jvuD/RMyzQBR8
X-Google-Smtp-Source: AGHT+IGVla9MAXjt9vGvad2f7eti2QAmF4uOkjLa9Lz3h8LKQEYgwVVIGsCsIK3myfTuHEym+W2Yjw==
X-Received: by 2002:a05:6e02:1a82:b0:3a0:a3f0:ff57 with SMTP id e9e14a558f8ab-3a34517c867mr6685985ab.15.1727380671826;
        Thu, 26 Sep 2024 12:57:51 -0700 (PDT)
Received: from leira.trondhjem.org.localdomain (104-63-89-173.lightspeed.livnmi.sbcglobal.net. [104.63.89.173])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835151sm107200173.34.2024.09.26.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 12:57:51 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: Anna Schumaker <Anna.Schumaker@oracle.com>
Cc: Oleksandr Tymoshenko <ovt@google.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fail mounts if the lease setup times out
Date: Thu, 26 Sep 2024 15:55:39 -0400
Message-ID: <eb402b489bb0d0ada1a3dd9101d4d7e193402e46.1725904471.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server is down when the client is trying to mount, so that the
calls to exchange_id or create_session fail, then we should allow the
mount system call to fail rather than hang and block other mount/umount
calls.

Reported-by: Oleksandr Tymoshenko <ovt@google.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 30aba1dedaba..59dcdf9bc7b4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2024,6 +2024,12 @@ static int nfs4_handle_reclaim_lease_error(struct nfs_client *clp, int status)
 		nfs_mark_client_ready(clp, -EPERM);
 		clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
 		return -EPERM;
+	case -ETIMEDOUT:
+		if (clp->cl_cons_state == NFS_CS_SESSION_INITING) {
+			nfs_mark_client_ready(clp, -EIO);
+			return -EIO;
+		}
+		fallthrough;
 	case -EACCES:
 	case -NFS4ERR_DELAY:
 	case -EAGAIN:
-- 
2.46.0



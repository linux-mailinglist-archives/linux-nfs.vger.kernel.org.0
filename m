Return-Path: <linux-nfs+bounces-6492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D36D979653
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D1B1C20E30
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Sep 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062481741;
	Sun, 15 Sep 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="fNhWU65O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A94F9FE
	for <linux-nfs@vger.kernel.org>; Sun, 15 Sep 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726396061; cv=none; b=G9+BWRV2NXcWjl2VcHGciGW/CYBid8RPLicGVfwLOVxxk6yJYcBvqybLpVR1CMK4cEJgMAczjUMESTvbhwGbzPJEV/Y8Zvx9SZ6WlxEDrsx6t8dc8oLH3TJdBNLB1+J6YkufehR+CDXoPBhJRSnoLJsQZ42RsWSu9sr8FRcYcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726396061; c=relaxed/simple;
	bh=g5ZBg3oSFtztLbE4Ynrwlxv4Zqs3snojsIf+YeMw5tU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qB6EfElp/A/CFe1ngW256nI4oAIZBKJgVacWPAnxIQIM171/YcEMMUsT7G7zvp5GwKixYTIbcMd/Unm+zdfLoYJYbdl9AvSiG9ppO8p+KKqRibpQBgJIkJj+JAtvCfBMQYC0GTKYbwy4RP0Ve+DWKSia1q5LBrg959C8DpiwxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=fNhWU65O; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbe0so749117a12.2
        for <linux-nfs@vger.kernel.org>; Sun, 15 Sep 2024 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1726396057; x=1727000857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8s/rrAX5PVs+F8ZbrPFITMF6v469MPCPPWzQXWsqxM=;
        b=fNhWU65ONK02zr5coLvXUx2sj0Wg5eKy4WhS1wivRCd4ABP9BqFsrkoIYrUhyP+xTm
         syeu/HFKgFnjQGevfGJ+1x34Xt8S1RzkTKxdEg0RTkvpwe6lmj7EKUEI3ZywbpuDKP1X
         cIfddSst3LV/AKR8PoS6jCaAmWLkYi4saD3SOGXwLsrzDWwv2rSdzeuB/gKAqE4IdPT9
         AGV6kZut8caDbDI9+0lMRW4PoM7WlWR7yKjccnCvlZKhtf0lSNS0g/KN+VHbl9FXxMnC
         QtphadpMw1r7IccHkPMT2ulxASU+pkX4No/wl55EZZMNoHYNqmOM2nYL/Uyb7v0Jg3KR
         GZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726396057; x=1727000857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8s/rrAX5PVs+F8ZbrPFITMF6v469MPCPPWzQXWsqxM=;
        b=TpBv5d/4gWAeoZArY89BzX3sqmXuXqCPJfbs3Y0+LcVjKFpovzegxnng7DlsvyXuBB
         rtj+fLhqsBQSdmJc95V2sqIOHCA/fDICUtkq+kb/gmrMj3dk7Z8ep6dJgsyS6+yLNiLY
         I0H7IQcbqNniJoEUS/6LbsUx649XjL40AspT2hrvPU0NEu2CvTq2BYml0HTHwvAwjg+f
         JOLHyQicPQS2wgi0T2mUtgEwYKt+NlZyhzq4ochOggmoqvUPea5U5TcHUxmC1wa6kdJg
         EXvi/jNF//CSTKzV5iStJ0KloyzoLMVPNu+Iar6rdDdcqilVXTAr0TEWjHTWLlNL9ZSJ
         01PA==
X-Gm-Message-State: AOJu0Yyj5B9gZDOyb24lEF3477qAMOwyM/2Xfn8A0oKADnaitMaur7O0
	Hlk6Ky16g3In0bVCIH2OMtWIPTMFkK0MJkT5gcIV1lefE3R4y+PnJCNjGivBZriHv7d9wyfXJGb
	IuEA=
X-Google-Smtp-Source: AGHT+IFqIOrd+KNu8k4h74EwKJB6aSyHOSRI/WftkSCvLwP9BDVr7tU2wT7rwl4Hj5HChRrpWs52nQ==
X-Received: by 2002:a05:6402:26cd:b0:5c0:9fca:3ab4 with SMTP id 4fb4d7f45d1cf-5c413cbda4dmr9687487a12.0.1726396056176;
        Sun, 15 Sep 2024 03:27:36 -0700 (PDT)
Received: from personal-devvm-roi-azarzar.eu-west-1.compute.internal (ec2-34-241-100-26.eu-west-1.compute.amazonaws.com. [34.241.100.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb533besm1557065a12.26.2024.09.15.03.27.35
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2024 03:27:35 -0700 (PDT)
From: Roi Azarzar <roi.azarzar@vastdata.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv4.2: Fix detection of "Proxying of Times" server support
Date: Sun, 15 Sep 2024 10:27:35 +0000
Message-ID: <20240915102735.3152-1-roi.azarzar@vastdata.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to draft-ietf-nfsv4-delstid-07:
   If a server informs the client via the fattr4_open_arguments
   attribute that it supports
   OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS and it returns a valid
   delegation stateid for an OPEN operation which sets the
   OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS flag, then it MUST query the
   client via a CB_GETATTR for the fattr4_time_deleg_access (see
   Section 5.2) attribute and fattr4_time_deleg_modify attribute (see
   Section 5.2).

Thus, we should look that the server supports proxying of times via
OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS.

We want to be extra pedantic and continue to check that FATTR4_TIME_DELEG_ACCESS
and FATTR4_TIME_DELEG_MODIFY are set. The server needs to expose both for the
client to correctly detect "Proxying of Times" support.

Signed-off-by: Roi Azarzar <roi.azarzar@vastdata.com>
---
Changes from v1:
- Moved delegtime feature detection to a helper
- Small change log fixes

 fs/nfs/nfs4proc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b8ffbe52ba15..cd2fbde2e6d7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3904,6 +3904,18 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
 #define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_OPEN_ARGUMENTS - 1UL)
 
+#define FATTR4_WORD2_NFS42_TIME_DELEG_MASK \
+	(FATTR4_WORD2_TIME_DELEG_MODIFY|FATTR4_WORD2_TIME_DELEG_ACCESS)
+static bool nfs4_server_delegtime_capable(struct nfs4_server_caps_res *res)
+{
+	u32 share_access_want = res->open_caps.oa_share_access_want[0];
+	u32 attr_bitmask = res->attr_bitmask[2];
+
+	return (share_access_want & NFS4_SHARE_WANT_DELEG_TIMESTAMPS) &&
+	       ((attr_bitmask & FATTR4_WORD2_NFS42_TIME_DELEG_MASK) ==
+					FATTR4_WORD2_NFS42_TIME_DELEG_MASK);
+}
+
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
 	u32 minorversion = server->nfs_client->cl_minorversion;
@@ -3982,8 +3994,6 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 #endif
 		if (res.attr_bitmask[0] & FATTR4_WORD0_FS_LOCATIONS)
 			server->caps |= NFS_CAP_FS_LOCATIONS;
-		if (res.attr_bitmask[2] & FATTR4_WORD2_TIME_DELEG_MODIFY)
-			server->caps |= NFS_CAP_DELEGTIME;
 		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
@@ -4011,6 +4021,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		if (res.open_caps.oa_share_access_want[0] &
 		    NFS4_SHARE_WANT_OPEN_XOR_DELEGATION)
 			server->caps |= NFS_CAP_OPEN_XOR;
+		if (nfs4_server_delegtime_capable(&res))
+			server->caps |= NFS_CAP_DELEGTIME;
 
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
-- 
2.43.0



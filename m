Return-Path: <linux-nfs+bounces-6396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A7976321
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EDC1C223EF
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3919047C;
	Thu, 12 Sep 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="Qv4ncJEf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E51A28D
	for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2024 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126897; cv=none; b=HduajeeaH/5CP3i374OUPR0sT0tZFR3rOiqtFHXmnAHhyOyl3OHSXdu5WkWynv2LddJ8m/eqzfSF9epxBNK+H3FcWzFxgcUzNov2w+BSEnMnXNd1IBHL4ArVq4GjPunnt+xZk5g1OSg+Y+7ObIqqgMfgj4stZ9whmvUY4eJE+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126897; c=relaxed/simple;
	bh=KwNsiCAhCKpfon8nCNu0SYOvSYXAbxOO1YqE56a4OxM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T+LFR2otSqUvSROdM4ThFx9yFRwxQD2bfzHTVfIhNRD9oiW4+JqXJ5MgCRHzeKz70oe1MzpCh+oW1hQ3+gRdPPAemmyOgkZkSoTHppo+fogtx8XSjr29Go0TQrshA3/iuKRHt4sWUgS0c7R3NHWoH7vfHjlFHFSnWA9jpL1obp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=Qv4ncJEf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a706236bfso49246766b.0
        for <linux-nfs@vger.kernel.org>; Thu, 12 Sep 2024 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1726126892; x=1726731692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7KiH9tLh4bQ3thWe3cD4vroUiqa0yOQ80sYt9vcasE=;
        b=Qv4ncJEfeKgiXxWtevsU09+hDg886CFdV+MrkEvn2NYQTxysBsO8DIN/hP+zcm94Vt
         wo4pflzMD/uVU5LDekUDGt25BVikkFBwaBUVnbmKE2sk68TF59/VFHHm6c4F8bS9h1RO
         OlzSwGDFtRNyEzwQy2IOzdEODiaQ2ELb509WMD8gHyU7rMGEy3gghm9KHb3vFWudCa2Q
         ULOWw/sCkASbBA6OmZz4g1AkkaPO5sbDESaTs9GvymPiy888P7IitVPwesXQ9lNVFqyH
         QEFguYS9J2ig4OflwsAv1GXHiiDeltTblx+doQvvC69rOsy8WvLIdlwi5yKpeKbn+qKc
         wFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126892; x=1726731692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7KiH9tLh4bQ3thWe3cD4vroUiqa0yOQ80sYt9vcasE=;
        b=jUwoKs8HJKj6hU2nDaYzwSfvfSE63b0RPRdLtv2AFNv8tFubI5ok/BoUlhZ//++Y/D
         S3Z2+nj30vmc5x9tEcDFSyW5Xz7it+W6LEiTMgS1T6JHvHBY2C95y+L/lXQcAYXJNohU
         yO6IWyyko2cNMbc3taBKbfvFBJKSDm7Z0OwWrGdClbdJEvw+mW1PxH0u4iPpkZRKhedJ
         smvQERTeo1wzVGQccsiA9RnLH1EU5GihhnzKmoQx/2nYoJuKJeyzo9xy7Hz6XoP/DckR
         9a8bt4tMsjwmR2vsh2G530xBeBx5Zi1bBKFI8Y1Ygq/KQqvVbyW5xEHel2Zuo9o8Q7rf
         Ei3Q==
X-Gm-Message-State: AOJu0YyDwErKuSD74ekICu8Kq820EZzviK3M/r+nVeJDYOj1LQlb85ZW
	2wY4lyImWcdegIBbqycrjrQmlNJRPw/s2PTgjk+81c705VZWKPS1hy9v7llCpFxJoqc5JUDSFdQ
	7q4rjmg==
X-Google-Smtp-Source: AGHT+IH8+VDtlqHlLMbpLOouAvdu2MTNDmtvjd/3LV2szu4E7jRcpSTUJAAnDvrDxrctqyxD6mbRfA==
X-Received: by 2002:a05:6402:13c5:b0:5c4:ae3:83bd with SMTP id 4fb4d7f45d1cf-5c413e1ebc6mr2388408a12.21.1726126891444;
        Thu, 12 Sep 2024 00:41:31 -0700 (PDT)
Received: from personal-devvm-roi-azarzar.eu-west-1.compute.internal (ec2-34-241-100-26.eu-west-1.compute.amazonaws.com. [34.241.100.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd52135sm6238162a12.49.2024.09.12.00.41.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2024 00:41:31 -0700 (PDT)
From: Roi Azarzar <roi.azarzar@vastdata.com>
To: linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4.2: Fix detection of "Proxying of Times" server support
Date: Thu, 12 Sep 2024 07:41:30 +0000
Message-ID: <20240912074130.4861-1-roi.azarzar@vastdata.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set time delegation capability according to relevant supported attrs

According to draft-ietf-nfsv4-delstid-07:
   If a server informs the client via the fattr4_open_arguments
   attribute that it supports
   OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS and it returns a valid
   delegation stateid for an OPEN operation which sets the
   OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS flag, then it MUST query the
   client via a CB_GETATTR for the fattr4_time_deleg_access (see
   Section 5.2) attribute and fattr4_time_deleg_modify attribute (see
   Section 5.2).

We want to be extra pedantic and continue to check that FATTR4_TIME_DELEG_ACCESS
and FATTR4_TIME_DELEG_MODIFY are set

the server should inform the client that it supports
OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS via FATTR4_OPEN_ARGUMENTS attribute
using GETATTR call, which the client should determine the server capability accordingly.
In addition, the server should support TIME_DELEG_MODIFY and TIME_DELEG_ACCESS as well.

Signed-off-by: Roi Azarzar <roi.azarzar@vastdata.com>
---
 fs/nfs/nfs4proc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b8ffbe52ba15..ba20197d0226 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3982,8 +3982,6 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 #endif
 		if (res.attr_bitmask[0] & FATTR4_WORD0_FS_LOCATIONS)
 			server->caps |= NFS_CAP_FS_LOCATIONS;
-		if (res.attr_bitmask[2] & FATTR4_WORD2_TIME_DELEG_MODIFY)
-			server->caps |= NFS_CAP_DELEGTIME;
 		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
@@ -4011,6 +4009,11 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		if (res.open_caps.oa_share_access_want[0] &
 		    NFS4_SHARE_WANT_OPEN_XOR_DELEGATION)
 			server->caps |= NFS_CAP_OPEN_XOR;
+		if ((res.open_caps.oa_share_access_want[0] &
+		     NFS4_SHARE_WANT_DELEG_TIMESTAMPS) &&
+		    (res.attr_bitmask[2] & FATTR4_WORD2_TIME_DELEG_MODIFY) &&
+		    (res.attr_bitmask[2] & FATTR4_WORD2_TIME_DELEG_ACCESS))
+			server->caps |= NFS_CAP_DELEGTIME;
 
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
-- 
2.43.0



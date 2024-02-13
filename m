Return-Path: <linux-nfs+bounces-1909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F2853550
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 16:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D152871CC
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B384F5F476;
	Tue, 13 Feb 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLxpT3TS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF515F47E
	for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839645; cv=none; b=K13Wy4Vde2z7yfqcaYp1oyawDjRBVqW3+Qltoke6/A6hmilSDYuxl3pNE6J1onhGvwyEIkjwEYx47Ge3lYn6OC8EEVcItTzby5e1ueZiwnZd3/9A/Ta5jneYP0ywI0sY+EZOS/MXXrtEEJhMAJ7xTl/hOADkUBwz1MOoe8uGCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839645; c=relaxed/simple;
	bh=zHWTerVtXU1xxlBt4RjXa5Z6O/KgDFZ7zU8ynNJSA/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SqDhjPsqx7ihjhikwF71XrobjQjqSCH281MyHi6MOmAj++kImS1eP7LJSpdeXuqzx8oQoGOfqdZ7TqNvy8qPfxJVABpeLljAYKlKeIMIWshulsXBgcqKYvxEx44iKv2jTBJrvFOkq/RYf7vdehOTDS14SGIiwGXEUCWq06Cd8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLxpT3TS; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso86333039f.1
        for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707839643; x=1708444443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWI6CKyMf9El/Hc045l4dVuESq8EIu5ROi2zq9euO4I=;
        b=bLxpT3TSJwExvvEPKmigB8U9gmIQ5FvQF0oVExhPSRdT4QrJLLpqmA/33/PKBlWYCf
         OfF37kBcSfS+el2e1aH+26xyVrIlRJ1cMuDLqn56D91l8db074BeqBKg2Chv5gxg+SiO
         v3R/nUpIalwKEWOpdJEypXTcCCU396ZSAyGeU61vOS7e0XaPABAuylcm1zZB//UQ1PKA
         uTFqwDCypfeDyPOBSmiywQHkKgQ3w/wzAZDDJA2szq/408kB94xxCRfG/L1hC6jkUPXU
         K/CYk/+/4ITrAP/pn5yhxpdd8ZGFcn3fnOHaXDqPFV3eB0aDBuW2J0EYUo7EdvUrLYaU
         aaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839643; x=1708444443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWI6CKyMf9El/Hc045l4dVuESq8EIu5ROi2zq9euO4I=;
        b=gYt7QjoPYPiDdW4axifMfX14Gu1Ed4It6lYR7yNLt6YvbhF5sZPoGC6qpTQqMrkd5E
         RG/3hRAnBhRkPwca/cFUqmQBUVAGgN1jtMQI5D4Jj+2QEj4lvt1FF/fZmi+7/9p5erh/
         EeHtRSARYzgV0lMt28qsYSTbeYTx9+Cd0CA5j+SSalQDxXtYmCgg/M8PLEA2xTln46Y6
         0mcl7nHcjywCp2mdFW2WfCR7ROdsvlKMhd5IqREq3eZNur82ZYAAAwL7h14faubN16uS
         hW6jurUrRT1+czAJrdKDWXs9/0K0cYWHjrG3JXvWo1qbepTioR+PSAsvmr1htDR0CK5E
         HAVA==
X-Gm-Message-State: AOJu0YwYRoLHzVhdNdlRf2eGk9uk3RMpcPOfloaD7IZ1fRR6AWQZUKAc
	me57FCWsc0PN5dZ1MBvSqKIrpPqmmm2KeUU3GYmLQ5kKvNINQgLd
X-Google-Smtp-Source: AGHT+IHmQrm9FZ2N6K2YE8MqoSKONQILs6kQlgkM9ce/W0vPCahgexCNtCJLKG9gmJmcn+tqO1Jvlg==
X-Received: by 2002:a05:6e02:1c0d:b0:363:b624:6304 with SMTP id l13-20020a056e021c0d00b00363b6246304mr85066ilh.0.1707839643459;
        Tue, 13 Feb 2024 07:54:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjKsRKpONUFAL1VYtHX4wIKQuIaUfDa0StDprxbZ6TVZj6q1ipZb0QJg726NA0sOr5KN13P3Jl++zokFgcttwWRnrN0wMZa/l0
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:89b4:c4e3:15d1:bb91])
        by smtp.gmail.com with ESMTPSA id h8-20020a0566380f0800b004712f04ce5asm1935438jas.100.2024.02.13.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:54:02 -0800 (PST)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1/pnfs: fix NFS with TLS in pnfs
Date: Tue, 13 Feb 2024 10:54:01 -0500
Message-Id: <20240213155401.47400-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Currently, even though xprtsec=tls is specified and used for operations
to MDS, any operations that go to DS travel over unencrypted connection.

IN GETDEVINCEINFO, we get an entry for the DS which carries a protocol
type (which is TCP), then nfs4_set_ds_client() gets called with TCP
instead of TCP with TLS.

Fixes: c8407f2e560c ("NFS: Add an "xprtsec=" NFS mount option")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/pnfs_nfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index afd23910f3bf..7989f7a0f5d5 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -938,7 +938,8 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 				.data = &xprtdata,
 			};
 
-			if (da->da_transport != clp->cl_proto)
+			if (da->da_transport != clp->cl_proto &&
+					clp->cl_proto != XPRT_TRANSPORT_TCP_TLS)
 				continue;
 			if (da->da_addr.ss_family != clp->cl_addr.ss_family)
 				continue;
@@ -953,6 +954,10 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 			if (xprtdata.cred)
 				put_cred(xprtdata.cred);
 		} else {
+			if (da->da_transport == XPRT_TRANSPORT_TCP &&
+				mds_srv->nfs_client->cl_proto ==
+					XPRT_TRANSPORT_TCP_TLS)
+				da->da_transport = XPRT_TRANSPORT_TCP_TLS;
 			clp = nfs4_set_ds_client(mds_srv,
 						&da->da_addr,
 						da->da_addrlen,
-- 
2.39.1



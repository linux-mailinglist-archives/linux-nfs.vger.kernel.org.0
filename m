Return-Path: <linux-nfs+bounces-3731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4439906342
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 07:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3FC283216
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 05:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBED134410;
	Thu, 13 Jun 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVmTMOWg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6E131BDF
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718255227; cv=none; b=o+lfMN80dS3ccm90/aqx+Eh+9GMaj/4l2Q34Lv205qLPIYnAZapEnqLdckI19RCp+j0MrQJVtkaoiNIPvkwjqWtIUxr+dbGGHaVT5xyV45xetRuLzUC8IkZg9RxmJyf1vLZ5nPMmRNYu9Y0xyUdkVo1VSy5u5EhyeEaCZvS19es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718255227; c=relaxed/simple;
	bh=CUek43QMrepAFh0fuXJPwtkz5MUUdrtLkRUjfji+lyE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PphlvxhPObL0yMaxr/4auaiVmnxPrFLROinsIHeoe4cLpbrwl27DFHloXlSG4FIRYioYn/vd92OnRKShIgtNiPMSFfG6qq1MCTAFXQty246WVVKF0IohqycAAe4yZe/rDwt7c2iy3gjApYZaLai3WCHZhBbfSWhcObO85LovW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVmTMOWg; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-797a8cfc4ecso34744785a.3
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 22:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718255225; x=1718860025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXVYNIM3ySb8hyMlrwzCwsvmVbam1K3t/jNlIKoSsrI=;
        b=bVmTMOWgGYrsfiu+P9PHLc6hhe8iM/vVdipYnlc9GUsAApJmVytwLP5FWyANwubg7C
         b8vCX13eAMhgJw53di5oZTzAkrf5X3DwcIP9/qaG0khM2QgNoTrAZKQeiIvJiaFQjLr4
         OzYwXgy/CVqI6w9CKjSTvrp7m/VhL4OnJKa1KOanpncwtp8NGJLfgGU99+GRxSgWtYOX
         oev8dMMml8E07WTE8DpdIqcAjlbSQs/7+LWHGNvO7sDXu4ycCh0DydYo3Sv4fQ3a6adG
         6LfQkD9ysfpb1YLA/k2rq2VbVqfHxjlBAkUI54Qerj7SXYkD8jn6K1UuE2T4xgiDdCy2
         sDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718255225; x=1718860025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXVYNIM3ySb8hyMlrwzCwsvmVbam1K3t/jNlIKoSsrI=;
        b=OfDNiCIzBp9d0+Ssr90oLxWbdYEKgAaKXJcmbdWQKFuaGTEmq3XSUypphlxi+9046b
         h2r6Ss5z0mSJRn4HAtxUeNvxMlOL0naKvHgoYNPgB9bgfMhFv1/FIubaIquY+8FXXEsa
         +C8L5ly0JgEhGYV37kUsukRQW5QBTdok4XgY0BelP2AKUoVPAQqsCVdRXvGBrfS0MYWM
         Fin6rScNdWIyf5bR+U19ZdVXb7apWy/5LChWYpdtoEeOdmDGAPWChlcoinQnrKI1t81d
         1IUzUWEGC6BtyNnODXOz9jbMIsxX7XDtUnKshJpgJeHbXLR7qmkNQ40flQKZtTWq2+mA
         83+g==
X-Gm-Message-State: AOJu0YxlP8qwY0vXSSJ15hktTH3vnct4L2nUZC2Jfcqp2C3EJhnCuKMv
	RBe9znLOeBhw3KrGo59T2Xgmj0Kiv9iXbwGI+AnCKHeuQwR3NXrSLPZc
X-Google-Smtp-Source: AGHT+IGRRFqW1ZEMXFmqXRhb1U12FebxPrimCb8ni+vz8O0c9KyX6jVTjJDGcHPeTEdusmxxOIdtLw==
X-Received: by 2002:a05:6214:5b83:b0:6b0:71c0:cbaa with SMTP id 6a1803df08f44-6b191e3bfa4mr49168096d6.33.1718255224643;
        Wed, 12 Jun 2024 22:07:04 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ed4527sm3079036d6.101.2024.06.12.22.07.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:07:04 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 02/11] NFSv4.1: constify the stateid argument in nfs41_test_stateid()
Date: Thu, 13 Jun 2024 01:00:46 -0400
Message-ID: <20240613050055.854323-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613050055.854323-2-trond.myklebust@hammerspace.com>
References: <20240613050055.854323-1-trond.myklebust@hammerspace.com>
 <20240613050055.854323-2-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4_fs.h        |  3 ++-
 fs/nfs/nfs4proc.c       | 24 ++++++++++++------------
 fs/nfs/nfs4xdr.c        |  2 +-
 include/linux/nfs_xdr.h |  2 +-
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 7024230f0d1d..c2045a2a9d0f 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -67,7 +67,8 @@ struct nfs4_minor_version_ops {
 	void	(*free_lock_state)(struct nfs_server *,
 			struct nfs4_lock_state *);
 	int	(*test_and_free_expired)(struct nfs_server *,
-			nfs4_stateid *, const struct cred *);
+					 const nfs4_stateid *,
+					 const struct cred *);
 	struct nfs_seqid *
 		(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	void	(*session_trunk)(struct rpc_clnt *clnt,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a4f85af880c2..ae835d14ac75 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -103,10 +103,10 @@ static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 		const struct cred *cred,
 		struct nfs4_slot *slot,
 		bool is_privileged);
-static int nfs41_test_stateid(struct nfs_server *, nfs4_stateid *,
-		const struct cred *);
+static int nfs41_test_stateid(struct nfs_server *, const nfs4_stateid *,
+			      const struct cred *);
 static int nfs41_free_stateid(struct nfs_server *, const nfs4_stateid *,
-		const struct cred *, bool);
+			      const struct cred *, bool);
 #endif
 
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
@@ -2867,16 +2867,16 @@ static int nfs40_open_expired(struct nfs4_state_owner *sp, struct nfs4_state *st
 }
 
 static int nfs40_test_and_free_expired_stateid(struct nfs_server *server,
-		nfs4_stateid *stateid,
-		const struct cred *cred)
+					       const nfs4_stateid *stateid,
+					       const struct cred *cred)
 {
 	return -NFS4ERR_BAD_STATEID;
 }
 
 #if defined(CONFIG_NFS_V4_1)
 static int nfs41_test_and_free_expired_stateid(struct nfs_server *server,
-		nfs4_stateid *stateid,
-		const struct cred *cred)
+					       const nfs4_stateid *stateid,
+					       const struct cred *cred)
 {
 	int status;
 
@@ -10357,12 +10357,12 @@ nfs41_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
 }
 
 static int _nfs41_test_stateid(struct nfs_server *server,
-		nfs4_stateid *stateid,
-		const struct cred *cred)
+			       const nfs4_stateid *stateid,
+			       const struct cred *cred)
 {
 	int status;
 	struct nfs41_test_stateid_args args = {
-		.stateid = stateid,
+		.stateid = *stateid,
 	};
 	struct nfs41_test_stateid_res res;
 	struct rpc_message msg = {
@@ -10418,8 +10418,8 @@ static void nfs4_handle_delay_or_session_error(struct nfs_server *server,
  * failed or the state ID is not currently valid.
  */
 static int nfs41_test_stateid(struct nfs_server *server,
-		nfs4_stateid *stateid,
-		const struct cred *cred)
+			      const nfs4_stateid *stateid,
+			      const struct cred *cred)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 98aab2c324c9..4bf7d5c09282 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -2137,7 +2137,7 @@ static void encode_test_stateid(struct xdr_stream *xdr,
 {
 	encode_op_hdr(xdr, OP_TEST_STATEID, decode_test_stateid_maxsz, hdr);
 	encode_uint32(xdr, 1);
-	encode_nfs4_stateid(xdr, args->stateid);
+	encode_nfs4_stateid(xdr, &args->stateid);
 }
 
 static void encode_free_stateid(struct xdr_stream *xdr,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 01efacae4634..45623af3e7b8 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1438,7 +1438,7 @@ struct nfs41_secinfo_no_name_args {
 
 struct nfs41_test_stateid_args {
 	struct nfs4_sequence_args	seq_args;
-	nfs4_stateid			*stateid;
+	nfs4_stateid			stateid;
 };
 
 struct nfs41_test_stateid_res {
-- 
2.45.2



Return-Path: <linux-nfs+bounces-5035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC31E93B580
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 19:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D391F23DEA
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jul 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053AB15E5BB;
	Wed, 24 Jul 2024 17:01:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575EB15B118
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840503; cv=none; b=mcAKSYi6K95IZ6wSG6dSq4rPcYqr2YmCofEosbQf3d/UbgO6LlLA5qbbshXd8lb/8woO3iiJ5z6v7+4fQURgp2vPLbVRdo6/capt3ltQRb0PiR4fYROT8NzOGw2E8n/1hiuMncB9G7lJGrYpO/qTx2QtUyCQWCOhO2iCEFvpWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840503; c=relaxed/simple;
	bh=A6mnSytyRRhS/M5RACCrhsE3DHJmBeKbu17U1c5fhNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXpwjONrY+QfXobN5uOFHFcpn6i1WzsQg58+lMVPz186AYvqQTNhGc6xRQ2aWvS/NYSdBCD5dE0gd9A//vYlrB2GTb2IJqjjd9rP9Ok7Z29DkN8F1zLX+4CZP7MNFtvAP56GunTxSyD03oukYUQUllaGGxKRt7rB2wm1+pTMpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7044c737d7cso632753a34.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jul 2024 10:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840501; x=1722445301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoQojwDQKITkZnXvmzmdlnhdbbSQV5a5SekgF3mUFtA=;
        b=CyEwQgYILYmUS6tH1iRJNPKx1WJwxNHKh+LIgVISWwb0ieoUWXxeQy+eMM+r8OWl+v
         8jXXYvsdMJMzevPmbI84BiCRupApJibVEsMr88+PO1SmuXRGmBh1c6YYzDLz6+0Q+kIE
         MYwkA6fqfUt1CM5lsykYUiNg/lAFn/Cxkd6G73tMrdJ5xhDTXCFopst9TP+XzEgdxw/N
         BDamBhXRGURgBtv6fqcI68lFmNiFkgtkGI7LN+luikXx1COfySO+/kiRAGfFxelK9GE8
         AKCoviAZnLoDeWkWPhlAaKoJvGiZIBM4gFxoZNI4ifBAEX0tSQNV7xoGdPAq2gI7EHLS
         Xzyw==
X-Forwarded-Encrypted: i=1; AJvYcCWRUx6rz+MxXtFQz2EREpLRaAFgKKD0Nls7ZsU1Gwg8r3K9YcuaMWDstFra71YQdI+d6Xt/Cn14n6XdLRMdXtHdr7lbsIKul6uT
X-Gm-Message-State: AOJu0YwlS+P2EdPEXGC9HPOMG0Z33Z6QGy80iBLZxwTmT9I0ajb/naSD
	qEysUWGDGqfK2t72ZrhSnm/NxRVI5vXJEcFfm4e+cIze8ZHGXDiH
X-Google-Smtp-Source: AGHT+IHmMnhmHbIWpvWXYglhpYtHvw4L42HPnIiW1qYpDVv3cUq3EI7NZRq+lStmf1oUBWEFb0fEvQ==
X-Received: by 2002:a05:6820:2d4b:b0:5cd:13e0:b0d3 with SMTP id 006d021491bc7-5d5adefc90emr265308eaf.2.1721840500973;
        Wed, 24 Jul 2024 10:01:40 -0700 (PDT)
Received: from vastdata-ubuntu2.. ([12.220.158.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d59ee65be5sm368297eaf.24.2024.07.24.10.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:01:40 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH rfc 1/2] nfsd: don't assume copy notify when preprocessing the stateid
Date: Wed, 24 Jul 2024 10:01:37 -0700
Message-ID: <20240724170138.1942307-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the stateid handling to nfsd4_copy_notify, if nfs4_preprocess_stateid_op
did not produce an output stateid, error out.

Copy notify specifically does not permit the use of special stateids,
so enforce that outside generic stateid pre-processing.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fs/nfsd/nfs4proc.c  | 4 +++-
 fs/nfsd/nfs4state.c | 6 +-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 46bd20fe5c0f..7b70309ad8fb 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_copy_notify *cn = &u->copy_notify;
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	struct nfs4_stid *stid;
+	struct nfs4_stid *stid = NULL;
 	struct nfs4_cpntf_state *cps;
 	struct nfs4_client *clp = cstate->clp;
 
@@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 					&stid);
 	if (status)
 		return status;
+	if (!stid)
+		return nfserr_bad_stateid;
 
 	cn->cpn_lease_time.tv_sec = nn->nfsd4_lease;
 	cn->cpn_lease_time.tv_nsec = 0;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 69d576b19eb6..dc61a8adfcd4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		*nfp = NULL;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
-		if (cstid)
-			status = nfserr_bad_stateid;
-		else
-			status = check_special_stateids(net, fhp, stateid,
-									flags);
+		status = check_special_stateids(net, fhp, stateid, flags);
 		goto done;
 	}
 
-- 
2.43.0



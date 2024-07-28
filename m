Return-Path: <linux-nfs+bounces-5115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA993E96F
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 22:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D26281A00
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Jul 2024 20:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36054BD4;
	Sun, 28 Jul 2024 20:41:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AF6F2F7
	for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722199271; cv=none; b=FAnrkrO/zlb2nZWiFKie3Ptzx8vjZyw8vCnFIVqDB95CFvTvagOebxLMNr3N+DfgbmpmYpUMza/a/4Qke9hWEwy2nQ5MmYB+ATgHrBtaeozoWRSxGR16xqsw7EysU+Wun6/dlfP0ZMyOREQbUBaVq5SLGAtakICg2uXqhj5zfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722199271; c=relaxed/simple;
	bh=ocqK3z/f6MNQDNLCqjo7bXyvhtaJTkL6pU0v6mSAWg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPz2V5Vf067IlvuaDHLb4k+7iL72wbV+ye36bHzjZa6jaeuhA5kol2JA8hCg6/oAMjTSMQQIaSdlhLfCmX5ZhS8DGEgsTJlCc9n0zRc3t9fWlLWNNjBnfmWFbk8tEQJcIG6Yx6n2/uaXZuf1saaVHc/DpIggIkwNUPzykUAR6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3687f91b7cfso200289f8f.3
        for <linux-nfs@vger.kernel.org>; Sun, 28 Jul 2024 13:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722199267; x=1722804067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYgPvrWXbDAQW9DAmmQH0KAjZnfqpsEo9wSfM277ZNw=;
        b=Rt6l+VomLlDyhfFrurDgI/igKKpAUYcpkt0daOwNJynmY5CUJRTLBlfRn99JXMyBFm
         R4nhh9FS8+/BMVMB6Efwo7fjRY4CrQOZOpuYxMNoiMnyEMBFS4g6jDSuzCUVrN1Qs+VI
         SKKEkKrfW6vBNKlAH/VOU7sR3/OF/pqpFb1j4WFS14PMsEuqsJlLncQcs8LN7a4Gjik1
         +ynI/ClHcNykHhg++J//KL/IPMYmdy72UV3eJJEOMEvZMn53+BMB8OtYhrkfcaMmRCUa
         cnQZOE7da2hb2l0RMZWEkEhzdCyvNcyzvCJNp2L6S11qI+RVSeFq57TErS9n+FwNMk12
         mqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+2S2nGOu2gg6cTCWEMHegquHR+6GlH563aayHn5aww4TlLoIuDDfw1QxISXEUWygBw3XbO4925+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIPfed+q4dJgnxZ/nnQ+2g4W+Uonl2E2ObYxlg2FqsTgmKEq7
	kQE7llgl6asvvx7GO1Vt2kc+XoX4lLCtclvOC2GFihtWMUXQWTXf
X-Google-Smtp-Source: AGHT+IE03eIpbcIQNo8OmGVbVVORQG03gAMi88QEJBFbhuspHpurXSMB5tlhUDXcAoQc3njoyTcGAw==
X-Received: by 2002:a05:600c:5126:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-4280550fedfmr54128225e9.4.1722199267433;
        Sun, 28 Jul 2024 13:41:07 -0700 (PDT)
Received: from localhost.localdomain (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d13570bsm98701395e9.7.2024.07.28.13.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:41:07 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <aglo@umich.edu>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] nfsd: don't assume copy notify when preprocessing the stateid
Date: Sun, 28 Jul 2024 23:41:02 +0300
Message-ID: <20240728204104.519041-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728204104.519041-1-sagi@grimberg.me>
References: <20240728204104.519041-1-sagi@grimberg.me>
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

Reviewed-by: Olga Kornievskaia <aglo@umich.edu>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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
index a20c2c9d7d45..0645fccbf122 100644
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



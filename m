Return-Path: <linux-nfs+bounces-14038-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFCB440FF
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D9117555E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Sep 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813C23A98E;
	Thu,  4 Sep 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btuAo3nA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2B21ADCB;
	Thu,  4 Sep 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000976; cv=none; b=doRT2UCnyg0gUQBGmcQbFpWtVmYQ/W2vlzIXmwQs6en0W9camj9zP0nXaPo8zA5JNzNec+ee/CtPf2IsrfYW3lsEUQoNGbBrVMDUjwCRVaEs5Z4dTzTEm6vISujcrN8OAPy6qx6KWghyKOXGoHL7bFw0Ff22mQ+MUS7O/Yr7StY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000976; c=relaxed/simple;
	bh=MytMC1CKRzPQkIlpFn+db2F8wIniGQDwwNJdrVc5ieI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLFByheagOZ59UzWnJkfGoDAsnjUS0jHfcUKh0XhrER2ky4r6PxPQuDBjCvD2z1E8wkdkPonzU+roPESkHN1M7+jghYP3dsS0Ynx99F+ef8oLU2djY0ADGt1zlaBgbXjTFyYoQw8O9uFewSKVleD0cRZH8gAPl5AVoCIom3gGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btuAo3nA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5608bfae95eso1233224e87.1;
        Thu, 04 Sep 2025 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757000972; x=1757605772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hl32CMOyalPP84O10i7P9BktOBLROK3GUuKYU9rJEoY=;
        b=btuAo3nAjDGtswbiVQUWc5SfjnW2FxFK5Ls7iuMwmxci7BXBSp9lBSiQbcktC8rBh9
         rQb/HAPKI2O52O8OArIj/Tt9pIP5/oOEbGGHHi5AxjGauV8kxrAjOPLUUaVnCLNTCSTg
         jSYs5GZ7OQqlDVjCZI4Z0z6rVx5mbf+ekwE9n7xnfN5BVk0OZNjhWGUnkzVFv9mVBP6l
         axtMm4QFKPdhN4pUX8VSc3YtfybbWNLQ5JgVGxyMVd7ZcX9BS15HBOOurdv85jAKtE7z
         bNE44qSdqA1JVWLGf6SCZIbrvtfyp7A0IpAKG4lTDk3YTuo+rih0dvDj18IU1y7J682H
         /BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757000972; x=1757605772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hl32CMOyalPP84O10i7P9BktOBLROK3GUuKYU9rJEoY=;
        b=RHKMpi0AFGjKkmL0CCLak2T2m21E76pPXXf3IwmPDosbXthoD5470Q3LJJhw5affZ6
         36jhFEyXqPo2vhvz8VECeDmEd3blDUmf7/MnxJ+Sw56XR/dh82VWULVWyfs482CUxlBx
         j+r5aT4ydaQa4xdBZFNzi0wzPefd8pGEKcCo/A1XutijL05+0Zkm9fsuD144bBjeuL61
         +wvGD5CBuat30n8hqvXYicHEeN8z4rZszZM5ZnEY7caSjj7pVEkKYxFPO8pWdLTx3Grm
         nnqRrqVOqMo1sndAOt9ElrRMZwnKcjXQ3bC8Sijm+XudJLWrPU+MtxI//9rU/DpgpiQ/
         GhBg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0SKosgQpIpMlzJGK5KImByLBE9c2shX8lPwD65edsQUkaKFJwI/0RUjcXEr5P6p3cjxrqmJnrxXt1BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8vpgvCKcUXc2c82Ppo2cdmvZQyY3S+sEGCetwONuWSpL6gplb
	e7/9jH93320FEoOAbUBp6KWBiTZo8O8prgcYFRamfzTu37xlMoVWUfLT
X-Gm-Gg: ASbGnctNyPpFARkCJKw5NI3e+4Ese1+rdQi6FK1MdgBzC4ePyePUqZmFSzPG2PVe4cK
	ycS01Cksw8mjS7DVZFadBJAuMqwkPmOuIm5YhciSB3uZo/NFVjFrhneSd7RUeoqonualW3PfJ16
	NkOJInjyEjaXDYBTvyUfzLwYGhL7ZpIMixP/XUQ6jUFFn2bdmebeSgpZHU4jNSJc6nLwUFsznwi
	5b57kft4oswbAgmkArgjuiJwTNmkOatcqNGMNTAY5nSsP3YCcXjO6nr2MgSG8Tf/PEEkcM85y0H
	qn7zJFzmwtRzp7S+uH+60qbYqn5wndC/U7Vao1MBD8QWSqJVOoERfzIR5/uViqIuVrZpXAsnwAB
	VNZkETBs4FWlFRvciJLiMQbQWKGIuaS05jPn7DwIp99Td+xGNRbgfUT9E/jdYTg==
X-Google-Smtp-Source: AGHT+IGwio7Qszgytr0z4tQ3qThIPgSJ7fl8kclW4JdrMbPzL5/4GJjPdTI36rNUHrCwqKb6AC5aPw==
X-Received: by 2002:a05:6512:6410:b0:55f:6d38:cc9f with SMTP id 2adb3069b0e04-55f708b6b7cmr6449495e87.17.1757000971832;
        Thu, 04 Sep 2025 08:49:31 -0700 (PDT)
Received: from SC-WS-02452.corp.sbercloud.ru ([88.218.65.129])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9fa6sm1248765e87.70.2025.09.04.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 08:49:31 -0700 (PDT)
From: Sergey Bashirov <sergeybashirov@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: [PATCH] NFSD: Allow layoutcommit during grace period
Date: Thu,  4 Sep 2025 18:48:44 +0300
Message-ID: <20250904154927.3278-1-sergeybashirov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the loca_reclaim field is set to TRUE, this indicates that the client
is attempting to commit changes to a layout after the restart of the
metadata server during the metadata server's recovery grace period. This
type of request may be necessary when the client has uncommitted writes
to provisionally allocated byte-ranges of a file that were sent to the
storage devices before the restart of the metadata server. See RFC 8881,
section 18.42.3.

Without this, the client is not able to increase the file size and commit
preallocated extents when the block/scsi layout server is restarted
during a write and is in a grace period. And when the grace period ends,
the client also cannot perform layoutcommit because the old layout state
becomes invalid, resulting in file corruption.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
---
 fs/nfsd/nfs4proc.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d7c58aa64f06..f9d1548db000 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2521,6 +2521,7 @@ static __be32
 nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
 {
+	struct net *net = SVC_NET(rqstp);
 	struct nfsd4_layoutcommit *lcp = &u->layoutcommit;
 	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
 	struct svc_fh *current_fh = &cstate->current_fh;
@@ -2556,23 +2557,34 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
 		}
 	}
 
-	nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate, &lcp->lc_sid,
-						false, lcp->lc_layout_type,
-						&ls);
-	if (nfserr) {
-		trace_nfsd_layout_commit_lookup_fail(&lcp->lc_sid);
-		/* fixup error code as per RFC5661 */
-		if (nfserr == nfserr_bad_stateid)
-			nfserr = nfserr_badlayout;
+	nfserr = nfserr_grace;
+	if (locks_in_grace(net) && !lcp->lc_reclaim)
+		goto out;
+	nfserr = nfserr_no_grace;
+	if (!locks_in_grace(net) && lcp->lc_reclaim)
 		goto out;
-	}
 
-	/* LAYOUTCOMMIT does not require any serialization */
-	mutex_unlock(&ls->ls_mutex);
+	if (!lcp->lc_reclaim) {
+		nfserr = nfsd4_preprocess_layout_stateid(rqstp, cstate,
+				&lcp->lc_sid, false, lcp->lc_layout_type, &ls);
+		if (nfserr) {
+			trace_nfsd_layout_commit_lookup_fail(&lcp->lc_sid);
+			/* fixup error code as per RFC5661 */
+			if (nfserr == nfserr_bad_stateid)
+				nfserr = nfserr_badlayout;
+			goto out;
+		}
+
+		/* LAYOUTCOMMIT does not require any serialization */
+		mutex_unlock(&ls->ls_mutex);
+	}
 
 	nfserr = ops->proc_layoutcommit(inode, rqstp, lcp);
-	nfsd4_file_mark_deleg_written(ls->ls_stid.sc_file);
-	nfs4_put_stid(&ls->ls_stid);
+
+	if (!lcp->lc_reclaim) {
+		nfsd4_file_mark_deleg_written(ls->ls_stid.sc_file);
+		nfs4_put_stid(&ls->ls_stid);
+	}
 out:
 	return nfserr;
 }
-- 
2.43.0



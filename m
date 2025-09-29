Return-Path: <linux-nfs+bounces-14783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629BCBAA305
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2308F3C1992
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC70621257F;
	Mon, 29 Sep 2025 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="EESAdVIs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505D1F1538;
	Mon, 29 Sep 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167366; cv=none; b=ti0w3GH/MIkyqCA+3nQ3t+TEtEaWIk+rQY3wM+MXeLvTFALacJ+haGk+y8dOLlua9iAax50NLZdyRD8ruwspw1jLG6fSITh6Jh9Tz8GWwwodFtKFaWugxI1hAwNomTE+EzEGpm1s+RkLkEBhh/hdK1qP0AORBxzVzAZH1y+Napo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167366; c=relaxed/simple;
	bh=Pm1a2seXkwxTGCna9n1tinZLtyvkNstoAoQWdxwmx1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4OHBGIwRA9rvSdbiSJ6W4A+5POhwdqvVcbu3lfTv8KM19tLCUiXYrS+8VzW02t0FdnOxZpfRVixFzzuRTf+y0evjdD8RXoYQ5qpdkVmULUi3KrhPzk1WfeYVted3D9NeCVcmBdTHoE4sId12lzNBHfbJ05LsRYxspnpNAlR6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=EESAdVIs; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [95.53.218.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id C563940643C7;
	Mon, 29 Sep 2025 17:35:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C563940643C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1759167357;
	bh=GVZcB8dx3E5VhDaGE+aEXR/ox8lMIhL41EQg4m2QIjs=;
	h=From:To:Cc:Subject:Date:From;
	b=EESAdVIsmpp4XbxjT1DeL2gnCMDzJhVN6wcBj+p1gnq3ynwB/3rncd3/ciHo1SYCk
	 5ISfNbAhtSioqWWyzjfZpD+apRUcNIcGeOmgboBE80Q5o1a++kTS4zdHgkib6rr1O/
	 1TujdhKrL45Icj//k4U7J4LnnDuivnU23I77MKDg=
From: Matvey Kovalev <matvey.kovalev@ispras.ru>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Matvey Kovalev <matvey.kovalev@ispras.ru>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] nfsd: delete unreachable confusing code in nfs4_open_delegation()
Date: Mon, 29 Sep 2025 20:35:20 +0300
Message-ID: <20250929173522.935-1-matvey.kovalev@ispras.ru>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

op_delegate_type is assigned OPEN_DELEGATE_NONE just before the if-block
where condition specifies it not be equal to OPEN_DELEGATE_NONE. Compiler
treats the block as unreachable and optimizes it out from the resulting
executable.

In that aspect commit d08d32e6e5c0 ("nfsd4: return delegation immediately
if lease fails") notably makes no difference.

Seems it's better to just drop this code instead of fiddling with memory
barriers or atomics.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
---
 fs/nfsd/nfs4state.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 88c347957da5b..debc6c8fef956 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6284,11 +6284,6 @@ nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
 	return;
 out_no_deleg:
 	open->op_delegate_type = OPEN_DELEGATE_NONE;
-	if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
-	    open->op_delegate_type != OPEN_DELEGATE_NONE) {
-		dprintk("NFSD: WARNING: refusing delegation reclaim\n");
-		open->op_recall = true;
-	}
 
 	/* 4.1 client asking for a delegation? */
 	if (open->op_deleg_want)
-- 
2.43.0.windows.1



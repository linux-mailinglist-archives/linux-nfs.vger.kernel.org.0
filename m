Return-Path: <linux-nfs+bounces-7640-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5784C9BADEA
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 09:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A22828E8
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02619DF8B;
	Mon,  4 Nov 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CGXv0AkY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A518FC7C;
	Mon,  4 Nov 2024 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708481; cv=none; b=ICmVq8zJ+BsezONiEiW4hSuwkPjxSv/wazctN52PjDwP0anUe3dhiVvla/iZ7VHvqA2GZLvXGnaHahhI9FNLRcmKrdfEkhHJ7JVcXHNSGk6SwuhgSSxah8dllEDnSarQ+wmoMBWBnr31FKKkjW1qCfQGJp5x9mRyn0lXJ/jw3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708481; c=relaxed/simple;
	bh=/NHMSmiKagh8k4QI2PD8QCbsekeNsMzZplddfeOLh/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ANGxhwjwryD3YBTFQj2OwRSsCskF/c2SmZL3WipiApUKWYWcPB+Z01NY0j2D6RXwMWjzGUrEJLIJFQI7Tynso4iXrHvbSiGVmjKi6rx2jnmQ65eTv0k+RFVRCJ+8F5A+dJRtylkxV2RJv3sDu0kpc+hqmznBHmq1LapwHPED9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CGXv0AkY; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730708475; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=OevIAV73VFpELMkDuAHgCh1n+i8KBe/1HDt6dlqIi5g=;
	b=CGXv0AkYBXQ5LpeGx52UMX4/M5m+gdiYcY+IKy7aONUYuv4wNevREHCSns4Y2fuol2sTbX10/9+Syk6zg0neBZRuhHHsTxhGyK5fpGyfkyyF3OxYiyqqnaWe7WlcbEqH4gQtvtCbfi6LoLRE7Mo/EvKiKkXcslaByFZl8vaf8D0=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WIdgWGI_1730708470 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:21:15 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chuck.lever@oracle.com
Cc: jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs/nfsd: Remove the unused variable sb
Date: Mon,  4 Nov 2024 16:21:09 +0800
Message-Id: <20241104082109.49986-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Variable sb is not effectively used, so delete it.

fs/nfsd/nfs4state.c:7988:22: warning: variable ‘sb’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11648
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/nfsd/nfs4state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5d47a28ef62d..45e487bf0582 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7986,7 +7986,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
-	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -8006,7 +8005,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0);
 	if (status != nfs_ok)
 		return status;
-	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
-- 
2.32.0.3.g01195cf9f



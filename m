Return-Path: <linux-nfs+bounces-5353-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44A9519F7
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DDF28134A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA641AED53;
	Wed, 14 Aug 2024 11:33:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F51AED2F;
	Wed, 14 Aug 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635207; cv=none; b=eCMD1++5/DFqbsAvUvooLrlr1NJ2ljjS//LFF76YkH9HxhD1DiZuT2uEtwfb3ndeNpwiPN0HeBQ1zy2HRyxxwpB4DQORSPqXuRrU1VJ6RzWN1kUWFA02C0blSbnMpcX6hMw6ge0rkPUbaa1NIiKIYFqH2i5XMUHF0uRaJIWHQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635207; c=relaxed/simple;
	bh=DMomTvwQxLY5tBqwf1GAIJ2j7UEKVaj+p1Vp8ym+RJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5FlFeYypm6wwdXgRcxO7q7b3F6ovx2c68oaDLxJJ/nsB7vKkqD9vGTxpONrC4cVQkxIGFuaIsRqCdLpsdxbIWXDKoJK9kwjvK+qSF5waU3t9q0kzOfRvrOBN60MhO+ekV0F4k+1GdsDbnNJrw/xemLBARGuczXDqdqFLJxCfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WkR2b07s6z4f3kKn;
	Wed, 14 Aug 2024 19:33:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5B6121A12CC;
	Wed, 14 Aug 2024 19:33:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIL_lbxmhuyrBg--.22017S4;
	Wed, 14 Aug 2024 19:33:20 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] NFSD: remove redundant assignment operation
Date: Wed, 14 Aug 2024 19:29:07 +0800
Message-Id: <20240814112907.904426-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIL_lbxmhuyrBg--.22017S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWkCr43CFWftr18CrWUtwb_yoWDZrb_X3
	W8Gw18GF45Ww47Was3Ar10yrWrCrZ7Jr18W39IqFZFka93tF95uws7Xw4Yka45GFsIqF45
	J3WrWr1ak3W5tjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

Commit 5826e09bf3dd ("NFSD: OP_CB_RECALL_ANY should recall both read and
write delegations") added a new assignment statement to add
RCA4_TYPE_MASK_WDATA_DLG to ra_bmval bitmask of OP_CB_RECALL_ANY. So the
old one should be removed.

Fixes: 5826e09bf3dd ("NFSD: OP_CB_RECALL_ANY should recall both read and write delegations")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/nfs4state.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..693f7813a49c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6644,7 +6644,6 @@ deleg_reaper(struct nfsd_net *nn)
 					cl_ra_cblist);
 		list_del_init(&clp->cl_ra_cblist);
 		clp->cl_ra->ra_keep = 0;
-		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG);
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-- 
2.31.1



Return-Path: <linux-nfs+bounces-16972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D560DCAA282
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 08:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B05B7300E451
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE72DECC2;
	Sat,  6 Dec 2025 07:39:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF00258CD0;
	Sat,  6 Dec 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765006742; cv=none; b=F1rbdoRMVXm270AbvCY1MBCStfhLgqJP3xd8vv2yizOISB1cfsVnly3RnDRUCe6xwdkGAmHSGwk6h+wedAtpCMIyiLFprbH2Y8w/UykyV17ClLzN7QJs7ducy59ZRru+qF4BF67pL7YerhAbhJmmvoi0bjWPvHOWKqm1x4DAvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765006742; c=relaxed/simple;
	bh=HPCQnytAiDrGeOpmwYKbb6Y4zpzPGCtCXRIjvBT++Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8Tjx6gn7WuG/Drb15lwLEUU1Ig0HctM+TXtXmHoUg0gy2lqCMWOxCwkZ03FwdkbIMqdW6NwDaesGt4KehslaKgSyaRRwLwmIBILf2LH8RtbLXhyRTijW/tkaUTy1Ewh5CBAH35L1yU4mjHogcsP6rjnOPy8XdQ/pECmq87NNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowACHGMiE3TNpW5hBAw--.11676S2;
	Sat, 06 Dec 2025 15:38:44 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	bfields@fieldses.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nfsd: Drop the client reference in client_states_open()
Date: Sat,  6 Dec 2025 15:38:42 +0800
Message-Id: <20251206073842.196835-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHGMiE3TNpW5hBAw--.11676S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UuFy5ur1rAr4kuFWrAFb_yoW3WFX_Wa
	129FykXrWUWFW8Cryak34YvayxArn3Jryru3ya9r9FkFW5JryqkrZ2qrsxCryUWrW3tr95
	Kw1kurn8Ka4fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBg0IE2kzj39+RwAAsD

In error path, call drop_client() to drop the reference
obtained by get_nfsdfs_clp().

Fixes: a204f25e372d ("nfsd: create get_nfsdfs_clp helper")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 fs/nfsd/nfs4state.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8a6960500217..caa0756b6914 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3097,8 +3097,10 @@ static int client_states_open(struct inode *inode, struct file *file)
 		return -ENXIO;
 
 	ret = seq_open(file, &states_seq_ops);
-	if (ret)
+	if (ret) {
+		drop_client(clp);
 		return ret;
+	}
 	s = file->private_data;
 	s->private = clp;
 	return 0;
-- 
2.25.1



Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2320F1B86B1
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2020 15:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDYNFP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Apr 2020 09:05:15 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:49637 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbgDYNFP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 25 Apr 2020 09:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=b3kabGWnfNFyI0kGh5Ho2f4n4DJ0P9WeOICVw1fEAa0=; b=z
        mV6amTcpJ8dIb1HSrsbWCS54si9wt2COGtn1r+qAHd+knrdkeAvl6CzTIO7EVAJ6
        8q2V1CvJJTCQoTQWu13UhBt4B3I5ARQvWKPZPrqB/ZapVgVoghTzdlH6ceNWIU+l
        KCiDM6MD2LzxXmRsN6rn7cW7IIfPPHLEfsu8FIJrRU=
Received: from localhost.localdomain (unknown [120.229.255.80])
        by app2 (Coremail) with SMTP id XQUFCgD3_+N_NaReRXapAA--.3366S3;
        Sat, 25 Apr 2020 21:05:06 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] NFSv4: Remove unreachable error condition due to rpc_run_task()
Date:   Sat, 25 Apr 2020 21:04:40 +0800
Message-Id: <1587819881-39973-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgD3_+N_NaReRXapAA--.3366S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF13tryDJrW8KryDuFy5twb_yoWfCwc_uF
        yfXr97Z39rAF1DXr17Ka90ya4UW398tr10yan8G3W2y348Kay5AFWkZFn8JFW8urZ0vr4r
        Cws5CFySv3yfujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
        YxC7MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUndgAUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs4_proc_layoutget() invokes rpc_run_task(), which return the value to
"task". Since rpc_run_task() is impossible to return an ERR pointer,
there is no need to add the IS_ERR() condition on "task" here. So we
need to remove it.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 fs/nfs/nfs4proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 512afb1c7867..1c710a7834c2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9191,8 +9191,7 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 	nfs4_init_sequence(&lgp->args.seq_args, &lgp->res.seq_res, 0, 0);
 
 	task = rpc_run_task(&task_setup_data);
-	if (IS_ERR(task))
-		return ERR_CAST(task);
+
 	status = rpc_wait_for_completion_task(task);
 	if (status != 0)
 		goto out;
-- 
2.7.4


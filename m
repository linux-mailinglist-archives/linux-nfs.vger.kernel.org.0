Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074DB24010F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 04:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHJCzU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Aug 2020 22:55:20 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:47722 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgHJCzU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 9 Aug 2020 22:55:20 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Aug 2020 22:55:19 EDT
Received: from localhost (unknown [159.226.5.99])
        by APP-03 (Coremail) with SMTP id rQCowACXnxvrtDBfxwVpAQ--.23036S2;
        Mon, 10 Aug 2020 10:46:03 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        vulab@iscas.ac.cn, linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rpc_pipefs: convert comma to semicolon
Date:   Mon, 10 Aug 2020 02:46:01 +0000
Message-Id: <20200810024601.9344-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowACXnxvrtDBfxwVpAQ--.23036S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47Jry8Cr17Jrb_yoW3Gwc_Gw
        47JFZ7uF1fZr42kF1UKryFvr4jv3ykZF1kJrs3GFn3Gay7J3W7CrsrAr13Aws8Wa15Wr15
        XrZ7WryYgrW3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYb18DU
        UUU
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiAwQEA13qZSbxqgAAsv
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 fs/nfs/blocklayout/rpc_pipefs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipefs.c
index 9fb067a6f7e0..ef9db135c649 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -79,7 +79,7 @@ bl_resolve_deviceid(struct nfs_server *server, struct pnfs_block_volume *b,
 		goto out_free_data;
 
 	bl_msg = msg->data;
-	bl_msg->type = BL_DEVICE_MOUNT,
+	bl_msg->type = BL_DEVICE_MOUNT;
 	bl_msg->totallen = b->simple.len;
 	nfs4_encode_simple(msg->data + sizeof(*bl_msg), b);
 
-- 
2.17.1


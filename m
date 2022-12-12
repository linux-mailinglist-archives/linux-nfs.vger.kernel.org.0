Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE94649D4E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 12:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiLLLRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 06:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiLLLQj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 06:16:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039941FB
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 03:11:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o15so4961370wmr.4
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 03:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqskvl17vvu2XfbsvcHv/TsCaOQbTMCpXCIk1dWD0Z8=;
        b=BhlV40pSQRpChkq3wguWD18XaMOcHus8eMDjGyuvOiUfFUG5orjKIRq9x22UHynQXE
         UeYY8cVIHaeY1kV1O5MHvzRBwQFjiofx2z8oDb7NGXxyUw/RGvjM2Inf9XxFYTx2heJT
         QhWbovzWy15d7LowReYIRchbh5PYG7q/8NIHKmgaasujx7Rnh1VKlJXm+kSFIhaAsxnl
         BLCx7OXhbd1hax3p4ZeSkaft+/1YpcbrncjGY2g1PD7jXAqHO4MTollK3unBz4QK6UgF
         U3gwTd65sg2RDy+/cA8SjIJWHp8qZsjIaTurGKz7hGiaEhmGofiviJv3MLURo97KWEu5
         Q49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqskvl17vvu2XfbsvcHv/TsCaOQbTMCpXCIk1dWD0Z8=;
        b=MuNVwQdkDubgAvfhxU1yhH6u3WRyInzdqTAXHubvsTeg613vaH9AOwDfcPJ+b3y6fN
         oJw1XJ4OHMXEJ2gmwoIqEJ8NZ+FWBEffuQnuiKFsxLbOMdQSeRNJM9uNkoeSxfMcID79
         P5yoWlcmVSBt24TW/UjBv3QZUfnPjfLozD4j/MwnGQs30jTBctoBcgW/SZfkQMeDiFVH
         wxY/pl3vHGDeWiSK43Jx0JbT8H3o84cavnzjTBvSL32JTgYJRQFo67CbnYyD6f3c7BkK
         gLcUzizNUWQxA2ekgjD2wPnuY5NW9lc0mScF+iYz9Hr7j7U93T9ZgeWeOKS9pic11YoI
         6p7A==
X-Gm-Message-State: ANoB5pm19kR84xkeeqmcSfKAMYLa4HJMPrH04Z8XE0/4IDFVukr4IpT8
        699psnv7zpSWmhhW+bnPQqTbcQ==
X-Google-Smtp-Source: AA0mqf6tfnHNfscK69p9owUCP7aXiqd6BFauf3oYI2BCZ8KuGPJqbNXQIJZG9/W2WWQbZjuC0tsmtA==
X-Received: by 2002:a05:600c:3496:b0:3d0:878b:d005 with SMTP id a22-20020a05600c349600b003d0878bd005mr12005429wmq.41.1670843468521;
        Mon, 12 Dec 2022 03:11:08 -0800 (PST)
Received: from jupiter.vstd.int ([2a0d:6fc2:6ab0:d100:2250:f444:10cb:55cb])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003b4868eb71bsm9479222wmq.25.2022.12.12.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:11:08 -0800 (PST)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        "J . Bruce Fields" <bfields@redhat.com>
Subject: [PATCH] nfsd: under NFSv4.1, fix double svc_xprt_put on rpc_create failure
Date:   Mon, 12 Dec 2022 13:11:06 +0200
Message-Id: <20221212111106.131472-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On error situation `clp->cl_cb_conn.cb_xprt` should not be given
a reference to the xprt otherwise both client cleanup and the
error handling path of the caller call to put it. Better to
delay handing over the reference to a later branch.

[   72.530665] refcount_t: underflow; use-after-free.
[   72.531933] WARNING: CPU: 0 PID: 173 at lib/refcount.c:28 refcount_warn_saturate+0xcf/0x120
[   72.533075] Modules linked in: nfsd(OE) nfsv4(OE) nfsv3(OE) nfs(OE) lockd(OE) compat_nfs_ssc(OE) nfs_acl(OE) rpcsec_gss_krb5(OE) auth_rpcgss(OE) rpcrdma(OE) dns_resolver fscache netfs grace rdma_cm iw_cm ib_cm sunrpc(OE) mlx5_ib mlx5_core mlxfw pci_hyperv_intf ib_uverbs ib_core xt_MASQUERADE nf_conntrack_netlink nft_counter xt_addrtype nft_compat br_netfilter bridge stp llc nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set overlay nf_tables nfnetlink crct10dif_pclmul crc32_pclmul ghash_clmulni_intel xfs serio_raw virtio_net virtio_blk net_failover failover fuse [last unloaded: sunrpc]
[   72.540389] CPU: 0 PID: 173 Comm: kworker/u16:5 Tainted: G           OE     5.15.82-dan #1
[   72.541511] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.16.0-3.module+el8.7.0+1084+97b81f61 04/01/2014
[   72.542717] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
[   72.543575] RIP: 0010:refcount_warn_saturate+0xcf/0x120
[   72.544299] Code: 55 00 0f 0b 5d e9 01 50 98 00 80 3d 75 9e 39 08 00 0f 85 74 ff ff ff 48 c7 c7 e8 d1 60 8e c6 05 61 9e 39 08 01 e8 f6 51 55 00 <0f> 0b 5d e9 d9 4f 98 00 80 3d 4b 9e 39 08 00 0f 85 4c ff ff ff 48
[   72.546666] RSP: 0018:ffffb3f841157cf0 EFLAGS: 00010286
[   72.547393] RAX: 0000000000000026 RBX: ffff89ac6231d478 RCX: 0000000000000000
[   72.548324] RDX: ffff89adb7c2c2c0 RSI: ffff89adb7c205c0 RDI: ffff89adb7c205c0
[   72.549271] RBP: ffffb3f841157cf0 R08: 0000000000000000 R09: c0000000ffefffff
[   72.550209] R10: 0000000000000001 R11: ffffb3f841157ad0 R12: ffff89ac6231d180
[   72.551142] R13: ffff89ac6231d478 R14: ffff89ac40c06180 R15: ffff89ac6231d4b0
[   72.552089] FS:  0000000000000000(0000) GS:ffff89adb7c00000(0000) knlGS:0000000000000000
[   72.553175] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   72.553934] CR2: 0000563a310506a8 CR3: 0000000109a66000 CR4: 0000000000350ef0
[   72.554874] Call Trace:
[   72.555278]  <TASK>
[   72.555614]  svc_xprt_put+0xaf/0xe0 [sunrpc]
[   72.556276]  nfsd4_process_cb_update.isra.11+0xb7/0x410 [nfsd]
[   72.557087]  ? update_load_avg+0x82/0x610
[   72.557652]  ? cpuacct_charge+0x60/0x70
[   72.558212]  ? dequeue_entity+0xdb/0x3e0
[   72.558765]  ? queued_spin_unlock+0x9/0x20
[   72.559358]  nfsd4_run_cb_work+0xfc/0x270 [nfsd]
[   72.560031]  process_one_work+0x1df/0x390
[   72.560600]  worker_thread+0x37/0x3b0
[   72.561644]  ? process_one_work+0x390/0x390
[   72.562247]  kthread+0x12f/0x150
[   72.562710]  ? set_kthread_struct+0x50/0x50
[   72.563309]  ret_from_fork+0x22/0x30
[   72.563818]  </TASK>
[   72.564189] ---[ end trace 031117b1c72ec616 ]---
[   72.566019] list_add corruption. next->prev should be prev (ffff89ac4977e538), but was ffff89ac4763e018. (next=ffff89ac4763e018).
[   72.567647] ------------[ cut here ]------------

Fixes: a4abc6b12eb1 ('nfsd: Fix svc_xprt refcnt leak when setup callback client failed')
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 fs/nfsd/nfs4callback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index f0e69edf5f0f..6253cbe5f81b 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -916,7 +916,6 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	} else {
 		if (!conn->cb_xprt)
 			return -EINVAL;
-		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
 		clp->cl_cb_session = ses;
 		args.bc_xprt = conn->cb_xprt;
 		args.prognumber = clp->cl_cb_session->se_cb_prog;
@@ -936,6 +935,9 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		rpc_shutdown_client(client);
 		return -ENOMEM;
 	}
+
+	if (clp->cl_minorversion != 0)
+		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
 	rcu_read_lock();
-- 
2.23.0


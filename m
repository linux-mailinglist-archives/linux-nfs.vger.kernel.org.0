Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1934C4BA557
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 17:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiBQQFe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 11:05:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiBQQFe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 11:05:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE629C123
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 08:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 239BB60BB8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 16:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56754C340E9;
        Thu, 17 Feb 2022 16:05:18 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Subject: [PATCH v2 0/8] Clean up struct svc_serv_ops
Date:   Thu, 17 Feb 2022 11:05:17 -0500
Message-Id:  <164511349417.1361.12607852846407534019.stgit@klimt.1015granger.net>
X-Mailer: git-send-email 2.35.0
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; h=from:subject:message-id; bh=jxsGghYLWniPxSqhtAeuK0QcrMANzHGYgbpiCvsuOZA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBiDnIkdqUSMsNG0GV9rdIbzDUlHjV3f9CoPoqLCG41 y8ovJ+eJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYg5yJAAKCRAzarMzb2Z/l1f5D/ wMo7qDUih89gOeTIfpssiII+hMWHgxLfbZQ8ax8qW1RF2FNE54gzW4uohlNZ6uQn+Uk9ZmV/f8Tg7Z q6sjjL5SpkQWnZxDuEBpTxblztkMwsrWwRvX0T07fI7wiNqadXJrdsOXA+DQiwblpb3UdGU6IaERpv 8L8/lXMvWilrTMj6mpEFUCHy7iirbKBnbe9+Nh7dVWTChzW24sBf1iU7NKUdZIsUMSpo3vlikirHrv 7mm5KX/sZjbnRLyGcdF0jdhrR6RJHtOGs6jSlGgdupqHhxgMjTzaHxvlPGlX8iaKjnRYhm3YiV+T2N s6Y+HicWGdZHMlA+fucw0otNi4l1T1T5HHLffwR4nwS5tyvn1VsWXtipTEYYyNVCdhCa1DbBA2eybd 7Ex3Q7MnXz8lTU0J6v/Jj7ZNlsZYV9xLGNwYP18X/HUSEHt3LM04M9u3zeHoTz6g0pGWboNd/6psRf NImpKEtAj7SvCDvFnPNmHt7vDEnI5nuFm2C5BgnPHG89Z0RdN7rEMUam3PlYAflKwuJ3F5qbwd26HT /zIfFj4+zTLTrGOHzwBgYLZlqOhV20KRTjHrpzhpXV2eTjJRQYAXZ5Jolo3WP1P4rHUy69bw9SGoZ2 9mnEF+Wocm/FHkPBW1e/cPsfsKM975uyFg2vDnni0a6VB/I15i/bNvc3PQ8g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here is the completed series of patches to remove struct
svc_serv_ops, as suggested by Neil Brown. The original material was
introduced several years ago when we planned to convert the RPC
server to use work queues. That work was never completed.

Removal now is to eliminate some unnecessary virtual functions
and to pave the way for the possibility of dynamic nfsd thread
management.

The full set of patches has been provisionally applied to my
for-next branch to enable broad testing. Comments welcome.

---

Chuck Lever (8):
      SUNRPC: Remove the .svo_enqueue_xprt method
      SUNRPC: Merge svc_do_enqueue_xprt() into svc_enqueue_xprt()
      SUNRPC: Remove svo_shutdown method
      SUNRPC: Rename svc_create_xprt()
      SUNRPC: Rename svc_close_xprt()
      SUNRPC: Remove svc_shutdown_net()
      NFSD: Remove svc_serv_ops::svo_module
      NFSD: Move svc_serv_ops::svo_function into struct svc_serv


 fs/lockd/svc.c                             | 24 +++-----
 fs/nfs/callback.c                          | 66 +++++++--------------
 fs/nfs/nfs4state.c                         |  1 -
 fs/nfsd/nfsctl.c                           | 10 ++--
 fs/nfsd/nfssvc.c                           | 23 +++-----
 include/linux/sunrpc/svc.h                 | 26 ++-------
 include/linux/sunrpc/svc_xprt.h            | 11 ++--
 kernel/module.c                            |  2 +-
 net/sunrpc/svc.c                           | 50 ++++++++--------
 net/sunrpc/svc_xprt.c                      | 68 ++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  2 +-
 11 files changed, 122 insertions(+), 161 deletions(-)

--
Chuck Lever

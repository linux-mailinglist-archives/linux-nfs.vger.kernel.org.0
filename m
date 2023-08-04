Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA67706EF
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjHDRTc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjHDRTb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 13:19:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819A198B
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 10:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363E1620B6
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 17:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BC8C433C8;
        Fri,  4 Aug 2023 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691169569;
        bh=uCRVJNXdPAeKC/KWoGiB2HuixJQhm1bCbFFndW+3U0I=;
        h=From:To:Cc:Subject:Date:From;
        b=Z0NyHRyLPmLOMB1eLoyhyUcSnFNfgQpW2X+4nqTb9Nj/akLY3gptfc8D9xuXAYH/c
         sA3S9dfR0lJiKZLzNJAzknHkUgrrgGvjfs/Okg8/3OkfAh1Giky3E5JNwzB0X3NfyY
         wa29QpjmS+d7z4qrkwiAbRWlNOkbNVn7vTwYQKmKFIGUbyQc/ZBVvk/aRsRzzjV5D/
         TlflJLUoGud4iPkGqwVZVb47sIXC3sqAOwf2pMuOOiOpGR4Rh6WeU3mNrcpP6aL43/
         GPBnjeeX2XF8VeApLEb/oqReD+utxpYiT97sYtqqCS3/hq8mtQ0LsSeinR5ddD2vO1
         r3ljQ46X0FI8Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v5 0/2] add rpc_status handler in nfsd debug filesystem
Date:   Fri,  4 Aug 2023 19:16:06 +0200
Message-ID: <cover.1691169103.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce rpc_status entry in nfsd debug filesystem in order to dump
pending RPC requests debugging information.

Changes since v4:
- rely on acquire/release APIs and get rid of atomic operation
- fix kdoc for nfsd_rpc_status_open
- get rid of ',' as field delimiter in nfsd_rpc_status hanlder
- move nfsd_rpc_status before nfsd_v4 enum entries
- fix compilantion error if nfsdv4 is not enabled

Changes since v3:
- introduce rq_status_counter in order to detect if the RPC request is
  pending and RPC info are stable
- rely on __svc_print_addr to dump IP info

Changes since v2:
- minor changes in nfsd_rpc_status_show output

Changes since v1:
- rework nfsd_rpc_status_show output

Changes since RFCv1:
- riduce time holding nfsd_mutex bumping svc_serv refcoung in
  nfsd_rpc_status_open()
- dump rqstp->rq_stime
- add missing kdoc for nfsd_rpc_status_open()

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D366

Lorenzo Bianconi (2):
  SUNRPC: add verbose parameter to __svc_print_addr()
  NFSD: add rpc_status entry in nfsd debug filesystem

 fs/nfsd/nfs4proc.c              |   4 +-
 fs/nfsd/nfsctl.c                |   9 ++
 fs/nfsd/nfsd.h                  |   7 ++
 fs/nfsd/nfssvc.c                | 140 ++++++++++++++++++++++++++++++++
 include/linux/sunrpc/svc.h      |   1 +
 include/linux/sunrpc/svc_xprt.h |  12 +--
 net/sunrpc/svc.c                |   2 +-
 net/sunrpc/svc_xprt.c           |   2 +-
 8 files changed, 166 insertions(+), 11 deletions(-)

-- 
2.41.0


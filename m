Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6078D831
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjH3S3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbjH3NGC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 09:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE39E185
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 06:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F5960EEA
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 13:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A616C433C7;
        Wed, 30 Aug 2023 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693400758;
        bh=SajL3ykSEyeKs7KkCsd2SeLPFcq6xM+CIa47dZ5dyWY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZnesuVrPvSumu6/WzKQtZOB9o0FS094VBOfbLybklsjfk1oJ1hheIh31waQDHkrtC
         NuxjbEBvwx6B+nDQ2stLg8dNfRaQ05wFR9leNEEtjyvfyyjxbZtfLggq4YA4UFHsPg
         xXFswmpxjXmS31vNPR6nvSFv4tBJoUuRAtKJprQkkm4W3pa0potKniL2XVs8eStJei
         /9EqI9UOA6igJU9oXJn+tXCkSzbuVlWMnOoC0lCuYt+sKATWM7+2zmNGZ69KgMH+l2
         K8bmFvkcMvJwVT+aIyi/oh4jXPAJm6VPCI1hdIQykeak4eRN7KJPUs8U6SHwiuiH5R
         64zTr5rD+W3dA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v7 0/3] add rpc_status netlink support for NFSD
Date:   Wed, 30 Aug 2023 15:05:43 +0200
Message-ID: <cover.1693400242.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce rpc_status netlink support for NFSD in order to dump pending
RPC requests debugging information from userspace.
The new code can be tested with the user-space tool reported below:
https://github.com/LorenzoBianconi/nfsd-rpc-netlink-monitor/tree/main

Changes since v6:
- report info to user-space through netlink and get rid of the related
  entry in the procfs

Changes since v5:
- add missing delimiters for nfs4 compound ops
- add a header line for rpc_status handler
- do not dump rq_prog
- do not dump rq_flags in hex

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

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D3D366

Lorenzo Bianconi (3):
  SUNRPC: export nfsd4_op_name utility routine
  SUNRPC: export svc_proc_name utility routine
  NFSD: add rpc_status netlink support

 fs/nfsd/nfs4proc.c         |   4 +-
 fs/nfsd/nfsctl.c           | 275 +++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h             |  25 ++++
 fs/nfsd/nfssvc.c           |  15 ++
 fs/nfsd/state.h            |   2 -
 include/linux/sunrpc/svc.h |   1 +
 include/uapi/linux/nfs.h   |  54 ++++++++
 net/sunrpc/svc.c           |   2 +-
 8 files changed, 372 insertions(+), 6 deletions(-)

-- 
2.41.0


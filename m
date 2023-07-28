Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250587675BF
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjG1Soa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 14:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjG1SoV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 14:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FDD2D64
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 11:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0997C621B1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 18:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C33FC433C8;
        Fri, 28 Jul 2023 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569856;
        bh=N4+FJjuOs4sBkISC3TEqM1/GGMmlFe7qHTaiaDIxWso=;
        h=From:To:Cc:Subject:Date:From;
        b=JAdlW4rDehKHCoPX/CVUuyuq27+uTdHWupGZu7lF1HnOmw2x52nMKijYcJEp2cgQU
         WzAZ7fpaSQkUUT3SAshmAxZgQhq9pW5orTi+3jXJeMGOZcQZbJFp8Hoievi2Qi+PfS
         4ibE8/9qBJiNqZOpVW1R17re+lLvVGKA22mnWKNTjpkJ5AqNYL+wkYHd7pbrt6JBVY
         cYroJWnS9cDX9tMMjOsobPPS52d//J0iPsn4jXokKKzp5LCfrWf1zqmiBAkVEEEc+j
         KvFCcYLnt50tMQKNuqr7kAOu8MFlIBVKM4YWWbe8J3TiannO7KPcnhYnjJks2MLbRm
         MHIWNpk6E8d5g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v4 0/2] add rpc_status handler in nfsd debug filesystem
Date:   Fri, 28 Jul 2023 20:44:02 +0200
Message-ID: <cover.1690569488.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce rpc_status entry in nfsd debug filesystem in order to dump
pending RPC requests debugging information.

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

Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=366

Lorenzo Bianconi (2):
  SUNRPC: add verbose parameter to __svc_print_addr()
  NFSD: add rpc_status entry in nfsd debug filesystem

 fs/nfsd/nfs4proc.c              |   4 +-
 fs/nfsd/nfsctl.c                |  10 +++
 fs/nfsd/nfsd.h                  |   2 +
 fs/nfsd/nfssvc.c                | 122 ++++++++++++++++++++++++++++++++
 include/linux/sunrpc/svc.h      |   1 +
 include/linux/sunrpc/svc_xprt.h |  12 ++--
 net/sunrpc/svc.c                |   2 +-
 net/sunrpc/svc_xprt.c           |   2 +-
 8 files changed, 144 insertions(+), 11 deletions(-)

-- 
2.41.0


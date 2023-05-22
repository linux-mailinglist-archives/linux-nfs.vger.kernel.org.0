Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1731C70C576
	for <lists+linux-nfs@lfdr.de>; Mon, 22 May 2023 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjEVSnk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 14:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjEVSnk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 14:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBAEE9
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 11:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA7861E8B
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468EEC433D2;
        Mon, 22 May 2023 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684781016;
        bh=ffD1oPNtPKx2EjJTBeiM20SG/DNXg1FAbkPtnDaC55A=;
        h=From:To:Cc:Subject:Date:From;
        b=opayJztZPl+aK0BpZQYRjEQDrGu/yGoP/HHD+tbHWPWi5/WB4PqDJxuMT4vJbgEf3
         z98IVua/DYWdYsBjh0nqaA2MCesg2kPvTMdJiv3wp0xXFnK1899naWEKLunqS49dCd
         pdpdG3dhK+Zd6qYz4d/e6frSRui3aDVDry/xh7/2vIVZrIMYlkUR/YkXx2FFhQa+7U
         zfqU6Yaz4RwJj3FTLJssN+KW0BZIZ83BvferlkXYLTJ33apY7udCyMOrES3P0Eo/Bv
         lM+NpB6Mh6luidSu2s4mUR3PsWMpv7XvqzjIEgHxDYCaa/ABHaFsQXkrvbWM3XX3dU
         v0XufuDd7zvZg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please pull NFS Client bugfixes for 6.4-rc
Date:   Mon, 22 May 2023 14:43:29 -0400
Message-Id: <20230522184329.5173-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.4-2

for you to fetch changes up to 43439d858bbae244a510de47f9a55f667ca4ed52:

  NFSv4.2: Fix a potential double free with READ_PLUS (2023-05-19 17:11:59 -0400)

----------------------------------------------------------------
NFS Client Bugfixes for Linux 6.4-rc

Stable Fix:
  * Don't change task->tk_status after the call to rpc_exit_task

Other Bugfixes:
  * Convert kmap_atomic() to kmap_local_folio()
  * Fix a potential double free with READ_PLUS

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (1):
      NFSv4.2: Fix a potential double free with READ_PLUS

Fabio M. De Francesco (1):
      NFS: Convert kmap_atomic() to kmap_local_folio()

Trond Myklebust (1):
      SUNRPC: Don't change task->tk_status after the call to rpc_exit_task

 fs/nfs/dir.c       |  4 ++--
 fs/nfs/nfs4proc.c  | 12 ++++++++++--
 net/sunrpc/sched.c |  5 ++---
 3 files changed, 14 insertions(+), 7 deletions(-)

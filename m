Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13A65EA7C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 13:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjAEMPU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 07:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjAEMPQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 07:15:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840544C7B
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 04:15:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556FE619FF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 12:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62282C433EF;
        Thu,  5 Jan 2023 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672920914;
        bh=AeSBPfzUznmRcyjfRTSU4vuHp39eKO5tCl0LCVap0zI=;
        h=From:To:Cc:Subject:Date:From;
        b=AiviA3FQe//RAgeqx5oKfQBNwAj3gyKAlO+/PGapcQ2GjPhgTWXBQWgtPLRK/8w+Q
         j/wgO1jeDz1IWSMLe3EmPeLTGtgnpAmnTcKledJdL7ItJ8EJEwIZ51jUjymIs5FUZW
         aEr55e2Hd+rGh8d1jVlbloY7Dk3rvNgr6MkgYGWs1FziLyX5p5lsQh3KUBV4yF4JHo
         gjAXZOsGzREo05yxpdfo2bxhpZRk6sfXxufNyvb6VSu8kZ1+/toz4EYNmDRCaEMXvQ
         tBL0or7yPf7xka/9szaVVMf7cnbZurJXqfSoR5P2Le8yxndjr+t//E3NXa7lVzCO89
         6y348FCsoyH3A==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] nfsd: filecache cleanups and optimizations
Date:   Thu,  5 Jan 2023 07:15:08 -0500
Message-Id: <20230105121512.21484-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is just a small set of filecache fixes and cleanups that I put
together while going over this code. None of these fix critical
problems, so these are probably v6.3 material.

Jeff Layton (4):
  nfsd: don't open-code clear_and_wake_up_bit
  nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
  nfsd: don't kill nfsd_files because of lease break error
  nfsd: add some comments to nfsd_file_do_acquire

 fs/nfsd/filecache.c | 52 ++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

-- 
2.39.0


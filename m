Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D152924D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbiEPVB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348926AbiEPVA7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:00:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D71F3B
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35C01B8165B
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2E0C385AA;
        Mon, 16 May 2022 20:35:50 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 0/6] NFSD: Improvements for the NFSv4.2 READ_PLUS operation
Date:   Mon, 16 May 2022 16:35:43 -0400
Message-Id: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The main motivation for this patchset is fixing generic/091 and
generic/263 with READ_PLUS. These tests appear to be failing due to
files getting modified in the middle of reply encoding. Attempts to lock
the file for the entire encode result in a deadlock, since llseek() and
read() both need the file lock.

The solution is to read everything from disk at once, and then check if
each buffer page is all zeroes or not. As a bonus, this lets us support
READ_PLUS hole segments on filesystems that don't track sparse files.
Additionally, this also solves the performance issues I hit when testing
using btrfs on a virtual machine.

I created a wiki page with the results of my performance testing here:
    https://wiki.linux-nfs.org/wiki/index.php/Read_Plus_May_2022

These should probably have some soak time in linux-next, so let's target
them for the Linux 5.20 (6.0?) merge window rather than rushing to get
them into 5.19. As far as ordering goes, these patches should probably
go in before the related client changes as the client will also be
changed to make use of the xdr_stream_move_segment() function.

Thoughts?
Anna


Anna Schumaker (6):
  SUNRPC: Introduce xdr_stream_move_segment()
  SUNRPC: Introduce xdr_encode_double()
  SUNRPC: Introduce xdr_buf_trim_head()
  SUNRPC: Introduce xdr_buf_nth_page_address()
  SUNRPC: Export xdr_buf_pagecount()
  NFSD: Repeal and replace the READ_PLUS implementation

 fs/nfsd/nfs4xdr.c          | 202 +++++++++++++++++++------------------
 include/linux/sunrpc/xdr.h |   6 ++
 net/sunrpc/xdr.c           | 102 +++++++++++++++++++
 3 files changed, 210 insertions(+), 100 deletions(-)

-- 
2.36.1


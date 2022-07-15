Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582255766DF
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 20:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiGOSoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOSoj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 14:44:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02C15717
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 11:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78EB8B82DE5
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 18:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D629EC34115;
        Fri, 15 Jul 2022 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657910675;
        bh=U9zvHvoyQSt2ioCyqpfSexkTyKGm/Adnh4GNtaB7Nww=;
        h=From:To:Cc:Subject:Date:From;
        b=IYpaOO422bRSs/o4/RLZQoRR5MY9yytNFBb826P42eZuqlhpLtqqo4F9C4j3imF+v
         6A/LC+volyV9rE/0lsagpco3P+cukq0Nc3MNsfKHZkBfVb/Y6jtZHtxu/RuKTM2+z1
         7Wkx/9nwV5tLKap4MVm86vgoN6r+JB+ZLvRCSrJIShgsV6mBZ4YDyOcHEO2Y29G4Ol
         PA7oe91btg9xXTlAp/zwQd5KatEYhEINOQ5dwZhH5vvv9oeKYpWScWwqJ1eQv9YlS6
         mEtYMCvgmL4Vu+726JveuueXy/IJtXWSosiQbHoz1WY3vbpPctNTFj07+n/e7GRir0
         ToPFDr78yWWuw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v3 0/6] NFSD: Improvements for the NFSv4.2 READ_PLUS operation
Date:   Fri, 15 Jul 2022 14:44:27 -0400
Message-Id: <20220715184433.838521-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

These patches should probably go in before the related client changes
as the client will also be changed to make use of the
xdr_stream_move_subsegment() function.

Changed in v3:
  - Respond to as many of Chuck's comments as possible

Changed in v2:
  - Update to v5.19-rc6
  - Rename xdr_stream_move_segment() -> xdr_stream_move_subsegment()

Thoughts?
Anna


Anna Schumaker (6):
  SUNRPC: Introduce xdr_stream_move_subsegment()
  SUNRPC: Introduce xdr_encode_double()
  SUNRPC: Introduce xdr_buf_trim_head()
  SUNRPC: Introduce xdr_buf_nth_page_address()
  SUNRPC: Export xdr_buf_pagecount()
  NFSD: Repeal and replace the READ_PLUS implementation

 fs/nfsd/nfs4xdr.c          | 219 ++++++++++++++++++++-----------------
 include/linux/sunrpc/xdr.h |   6 +
 net/sunrpc/xdr.c           | 102 +++++++++++++++++
 3 files changed, 227 insertions(+), 100 deletions(-)

-- 
2.37.1


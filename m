Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7B6573CF5
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiGMTI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbiGMTIz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A81DA40
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EFBCB82117
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8905C3411E;
        Wed, 13 Jul 2022 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739331;
        bh=TuGn77ELLGTD65Jp5pIS5saK//qMJxFLstg1BHzD9Wc=;
        h=From:To:Cc:Subject:Date:From;
        b=rwScPAuMX1NsQAw2Q/b9YBGkEqQgzQicMdgNKYzssQJ+ZwG2wd54MGxFa8XLVNcZS
         iwI7QUxBA3ZT9DHk51qLXJ+DMHyIaqIoFb6EpSCXljirT659dahfMQRM/B8exzOLzs
         +B2Pa5MZTPb7iC9KGmnk4G8lj2Wc0b2zbDbxRS8ejkzLyOHZKASzbiv1FojPgVwYf4
         bfyAgTKrh2ZLXwcrGr5MR3dEUCRKfLF2i+rSl55dzyBoTw561LeDomlFoz5+lYvmmV
         oFutCa/04s10FnR1+RuwEf3YeE105eBgPpPfcDyJTdtE6SpvILJ34uWxNTh/pTCnbu
         vM1jyROccGpew==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v2 0/5] NFS: Improvements for the NFSv4.2 READ_PLUS operation
Date:   Wed, 13 Jul 2022 15:08:44 -0400
Message-Id: <20220713190849.615778-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Previously, decoding was a one step process that expanded holes as they
were seen in the buffer. This had a few undesireable side effects:

1) An extra READ_PLUS call was often needed to fetch any data shifted
   off the end of the buffer when the last two segments are a HOLE
   followed by DATA
2) We shifted the entire remaining buffer for each hole, meaning some
   segments would get moved multiple times during one decode pass.

These patches attempt to address this by turning READ_PLUS decoding into
a two-step process. First, we build up a list of each segment returned
by the server, then we walk the list in reverse and move each segment
directly to their target offset. This cuts out all the extra copying,
and means we won't lose any data off of the end of the reply.

The results of my performance testing can be found here:
    https://wiki.linux-nfs.org/wiki/index.php/Read_Plus_May_2022

Between these patches and the corresponding server patches, I'm seeing a
several second decrease in the amount of time that a READ_PLUS call
takes to complete even on the worst case test where pages alternate
between hole and data segments.

I also optimistically remove the CONFIG_NFS_V4_2_READ_PLUS Kconfig
option now that the known performance and correctness issues have been
resolved, but I would also be fine with changing it to default to 'y' if
there are objections to entirely dropping the option.

Please note that these patches rely on the xdr_stream_move_subsegment()
function added as the first patch of the corresponding server patches.

Changes in V2:
  - Rebase on v5.19-rc6
  - Update for renaming xdr_buf_move_segment() -> xdr_buf_move_subsegment()

Thoughts?
Anna


Anna Schumaker (5):
  SUNRPC: Add a function for directly setting the xdr page len
  SUNRPC: Add a function for zeroing out a portion of an xdr_stream
  NFS: Replace the READ_PLUS decoding code
  SUNRPC: Remove xdr_align_data() and xdr_expand_hole()
  NFS: Remove the CONFIG_NFS_V4_2_READ_PLUS Kconfig option

 fs/nfs/Kconfig             |   9 --
 fs/nfs/nfs42xdr.c          | 168 +++++++++++++++++++------------------
 fs/nfs/nfs4proc.c          |   2 +-
 include/linux/sunrpc/xdr.h |   5 +-
 net/sunrpc/xdr.c           | 111 +++++++++++-------------
 5 files changed, 140 insertions(+), 155 deletions(-)

-- 
2.37.0


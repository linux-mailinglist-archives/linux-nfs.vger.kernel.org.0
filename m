Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98533529259
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiEPVBo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349213AbiEPVBI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3068AB859
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9144B815F3
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F190C385AA;
        Mon, 16 May 2022 20:36:23 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 0/5] NFS: Improvements for the NFSv4.2 READ_PLUS
Date:   Mon, 16 May 2022 16:36:17 -0400
Message-Id: <20220516203622.2605713-1-Anna.Schumaker@Netapp.com>
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

Please note that these patches rely on the xdr_stream_move_segment()
function added as the first patch of the corresponding server patches.

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
2.36.1


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175D57D333
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGUSVj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 14:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiGUSVi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 14:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B718E0A
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 11:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0099461FC8
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 18:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3584C3411E;
        Thu, 21 Jul 2022 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658427697;
        bh=+qj5QPfcjYuIzi9dZPA/RKRcJf05OxdoHANRyel2Fog=;
        h=From:To:Cc:Subject:Date:From;
        b=FXDfM/UI7p1kcYCC7ORtgz4rpOxC94efNA1R09Hf39QAT4x95MqoS45/NDoNcdVUW
         w+3Dk1R4YLUJZWL+9645A3rTJYZn5erYBwKmKP4XhTvBZ80YL0uTX5uRDJuKCmsfIp
         Q7Fr4jPWdln1lH4+NR1rVAOU1BoKEKOts5AMKoQ2GYf9IRR8xnP1N2pNnFP/vLc5jV
         rBiPikGi+Z3opPxqXtSWxKWLErhGj7joFjz9C5tmvK/UNJLZyWWpwnhe+Y1My074+R
         8GK7sxG/pjk2rx6VrEZl+plKFPuVVO2nGpSQ/GQkjMTvbYSfD6VMhCLWXV6SpERAMl
         +G+2WHlEgGN9w==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v3 0/5] NFS: Improvements for the NFSv4.2 READ_PLUS operation
Date:   Thu, 21 Jul 2022 14:21:30 -0400
Message-Id: <20220721182135.1885071-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in V3:
  - Move the "Introduce xdr_stream_move_subsegment()" patch into this
    series so it can be applied now while work on the server side
    continues.
  - Drop the patch removing the Kconfig option at Trond's suggestion.

Thoughts?
Anna


Anna Schumaker (5):
  SUNRPC: Introduce xdr_stream_move_subsegment()
  SUNRPC: Add a function for directly setting the xdr page len
  SUNRPC: Add a function for zeroing out a portion of an xdr_stream
  NFS: Replace the READ_PLUS decoding code
  SUNRPC: Remove xdr_align_data() and xdr_expand_hole()

 fs/nfs/nfs42xdr.c          | 168 ++++++++++++++++++------------------
 include/linux/sunrpc/xdr.h |   7 +-
 net/sunrpc/xdr.c           | 170 +++++++++++++++++++++++--------------
 3 files changed, 200 insertions(+), 145 deletions(-)

-- 
2.37.1


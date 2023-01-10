Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718566644E6
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 16:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjAJPcj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 10:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239084AbjAJPbz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 10:31:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E527350E48
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 07:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93BC4B81731
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A07C433D2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673364709;
        bh=cYcuyO9ZicVC/ir/LRwQcyGSX49cgMzWp5EIoelOECM=;
        h=Subject:From:To:Date:From;
        b=r4Lb5/IduuEmWDVC/eU1DW48sFoBoAg/RDGvTCbFeTmy6wWPGQTZkHaqFRPOqyt+l
         NLqLXVDEghZQbw4rreC0OIRgixMRSMSpdgmJjbReJ/M8Kwp6oktmmdePN+i0GGkIlt
         W/d/XsrXRTXsajPVsk8fsCmRBfO3KmgqeXTMPn/updf8f3ygebyklpY8EfU8PqF32y
         59H49Z1qbsve2I4iy5DybqU/aCRRWRPXHh929/U7QMrPY0IJhCz77K2h04e7WDJKBv
         OvQ+XqMbUR+IN1aKDycfg9hgwVKp1vhvKpOpuB9g4+QnVJwCIcCAsUCck8E7lZs2oR
         72kl5P34v3BeQ==
Subject: [PATCH v1 0/2] Switch SUNRPC server to per-CPU counters
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Jan 2023 10:31:47 -0500
Message-ID: <167336437322.15674.16325059932149395877.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm trying to enable the use of KCSAN on NFSD. There are some false
positives that make the signal-to-noise ratio unfavorable.

The noisiest data races we (NFSD chickens) have direct control over
are the per-RPC and per-pool statistics. These two patches try to
address those.

There might be some additional desirable changes. For example, we
could make the RPC counters per-net. I'm saving up those pennies
for another rainy day.

---

Chuck Lever (2):
      SUNRPC: Use per-CPU counters to tally server RPC counts
      SUNRPC: Replace pool stats with per-CPU variables


 fs/lockd/svc.c              | 15 ++++++++++-----
 fs/nfs/callback_xdr.c       |  6 ++++--
 fs/nfsd/nfs2acl.c           |  5 +++--
 fs/nfsd/nfs3acl.c           |  5 +++--
 fs/nfsd/nfs3proc.c          |  5 +++--
 fs/nfsd/nfs4proc.c          |  7 ++++---
 fs/nfsd/nfsproc.c           |  6 +++---
 include/linux/lockd/lockd.h |  4 ++--
 include/linux/sunrpc/svc.h  | 17 +++++++----------
 net/sunrpc/stats.c          | 11 ++++++++---
 net/sunrpc/svc.c            | 14 +++++++++++++-
 net/sunrpc/svc_xprt.c       | 18 ++++++++----------
 12 files changed, 68 insertions(+), 45 deletions(-)

--
Chuck Lever


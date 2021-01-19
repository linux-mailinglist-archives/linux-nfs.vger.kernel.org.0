Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC52FC39E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbhASWg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 17:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbhASWgR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 17:36:17 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F8C061757
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jan 2021 14:35:35 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2189428E5; Tue, 19 Jan 2021 17:35:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2189428E5
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 0/8] miscellaneous nfsd4 state cleanup
Date:   Tue, 19 Jan 2021 17:35:21 -0500
Message-Id: <1611095729-31104-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This is some miscellaneous cleanup of NFSv4 state code that I ran into
while working on another project.

I think it's all pretty routine.  The only behavior difference should be
changing the error returned in some situations where there are multiple
reasons an operation could fail; none look like a problem to me.

--b.

J. Bruce Fields (8):
  nfsd4: simplify process_lookup1
  nfsd: simplify process_lock
  nfsd: simplify nfsd_renew
  nfsd: refactor lookup_clientid
  nfsd: find_cpntf_state cleanup
  nfsd: remove unused set_clientid argument
  nfsd: simplify nfsd4_check_open_reclaim
  nfsd: cstate->session->se_client -> cstate->clp

 fs/nfsd/nfs4proc.c  |   8 ++-
 fs/nfsd/nfs4state.c | 125 ++++++++++++++++++--------------------------
 fs/nfsd/state.h     |   3 +-
 3 files changed, 56 insertions(+), 80 deletions(-)

-- 
2.29.2


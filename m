Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE1A3EABF9
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Aug 2021 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhHLUmL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbhHLUmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 16:42:10 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097EC0617A8
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 13:41:45 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7E79C4F7C; Thu, 12 Aug 2021 16:41:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7E79C4F7C
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 0/2] minor nfsd fixes
Date:   Thu, 12 Aug 2021 16:41:41 -0400
Message-Id: <1628800903-10760-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

These are two minor fixes I stumbled across while investigating other
problems.

--b.

J. Bruce Fields (2):
  rpc: fix gss_svc_init cleanup on failure
  nfsd4: Fix forced-expiry locking

 fs/nfsd/nfs4state.c               | 4 ++--
 net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.31.1


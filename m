Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB5B4AE367
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387309AbiBHWWl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387064AbiBHVwh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 16:52:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC0EC0612B8;
        Tue,  8 Feb 2022 13:52:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED677614EB;
        Tue,  8 Feb 2022 21:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F7C004E1;
        Tue,  8 Feb 2022 21:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644357155;
        bh=VXbZjYDEqN9ULt87WdyZtFJceSjSJJOJcbbd/1DikoY=;
        h=From:To:Cc:Subject:Date:From;
        b=PZWWhvYtkX7mqgpYW5mL5AeabHp9IOzwS6j25RVdLemuGD97QQPh1O3JQn+4ziOtL
         wWmLueo1y6jVNP6FTVt16Mm2bmIVs95fpXH4Wm6/kyeB8gUpSQyTTYBUDpq2Cg3kMx
         rVWJiJaiCXRgnpQKS4CQRMHRDRi8V6KRLLcfaA8rq3eUJIIBhQO9ATv3npK8hkpZKz
         ilNJUw2ydCDPlt4NFlDqA61SbgQYknRjb2MihERuCkJVf2zWsrAQFCZJg0SswlbZ1m
         sITkLiPDBAQ2g9ie9OkJufSygJTeSQBB8G6qHSIAmi/kVHjiBAE+Gv9rW4rUgYAlpQ
         INxNYSb2lKCsw==
From:   Anna Schumaker <anna@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] Improvements for NFS
Date:   Tue,  8 Feb 2022 16:52:28 -0500
Message-Id: <20220208215232.491780-1-anna@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

This is a collection of fixes that I've had in my private xfstests
instance on my NFS client VM for testing.

 I've been using the "-R xunit" option lately, so the first patch fixes up 
the PLATFORM and CHECK_OPTIONS output in the resulting xunit file. I
wouldn't be surprised if there is a better way to do this, so please let
me know!

The second patch moves a very long running test (generic/531) out of the
quick group because I'm tired of killing it after a half hour. Maybe
it's quick on non networked filesystems, though? I had some other ideas
on how to fix my issue that I included in the patch description.

The last two patches add some extra checks for functionality that NFS
doesn't support, otherwise the tests are getting marked as "failed" with
"whatever isn't supposted" in the test output log. After these patches
the tests are simply skipped.

Thoughts?

Anna


Anna Schumaker (4):
  check: Export CHECK_OPTIONS and PLATFORM for Xunit Reporting
  generic/531: Move test from 'quick' group to 'stress'
  generic/578: Test that filefrag is supported before running
  generic/633: Check if idmapped mounts are supported before running

 check             |  2 ++
 common/rc         | 14 ++++++++++++++
 tests/generic/531 |  2 +-
 tests/generic/578 |  2 +-
 tests/generic/633 |  1 +
 5 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.35.1


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB60413C8F3
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2020 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgAOQPY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jan 2020 11:15:24 -0500
Received: from smtpcmd03116.aruba.it ([62.149.158.116]:44973 "EHLO
        smtpcmd03116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOQPY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jan 2020 11:15:24 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 11:15:23 EST
Received: from ubuntu.localdomain ([212.103.203.10])
        by smtpcmd03.ad.aruba.it with bizsmtp
        id qg872100b0DySFo01g88go; Wed, 15 Jan 2020 17:08:08 +0100
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [nfs-utils PATCH] locktest: Makefile.am: remove host compiler costraint
Date:   Wed, 15 Jan 2020 17:08:06 +0100
Message-Id: <20200115160806.99991-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579104488; bh=iAzp4QmcT/ZpmpX8U0+GyLtP6UBJOxtzoI3C5tgYU4E=;
        h=From:To:Subject:Date:MIME-Version;
        b=WhLecIkEoNH3k3j4EtEYJI3JwODq9RRYLWVjMgUYINZQxncALuMG9BrY6spg6BqgK
         vCm23x00NQsVHZpsByk+TfsFFNFb0xW+I7Fd1KEy+Z5LyN+ijKq6SZH81I9QaPOnmZ
         +aaSmaWDPATgftMBTH3y74lAJSUD0ghsHN6d7qJ6jZw7ND6oTVV0eD41/co7bdL66u
         ApSTBvocuvfMzZA8Mcajzo9PjgnnirzBK2Dmdkxby0HwnRPp1Wf702WM84OvwNzutL
         defMMqvjrrnyOmkVj9wnTieLpRqGQ3mvDPBs3svlFzPLEE18GhSvklZ5j27yX3qEZp
         Qsc4BkKS+2Yug==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently locktest can be built only for host because CC_FOR_BUILD is
specified as CC, but this leads to build failure when passing CFLAGS not
available on host gcc(i.e. -mlongcalls) and most of all locktest would
be available on target systems the same way as rpcgen etc. So remove CC
and LIBTOOL assignments.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 tools/locktest/Makefile.am | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/locktest/Makefile.am b/tools/locktest/Makefile.am
index 3156815d..e8914655 100644
--- a/tools/locktest/Makefile.am
+++ b/tools/locktest/Makefile.am
@@ -1,8 +1,5 @@
 ## Process this file with automake to produce Makefile.in
 
-CC=$(CC_FOR_BUILD)
-LIBTOOL = @LIBTOOL@ --tag=CC
-
 noinst_PROGRAMS = testlk
 testlk_SOURCES = testlk.c
 testlk_CFLAGS=$(CFLAGS_FOR_BUILD)
-- 
2.20.1


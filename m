Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D87B48DA
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Oct 2023 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjJARZH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 1 Oct 2023 13:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjJARZH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 1 Oct 2023 13:25:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347C83
        for <linux-nfs@vger.kernel.org>; Sun,  1 Oct 2023 10:25:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5085CC433C8;
        Sun,  1 Oct 2023 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696181104;
        bh=/swOQu4WrM9h5V3ayN0ly8e8OAOfQ7xAbP4nmr9SmVk=;
        h=Subject:From:To:Cc:Date:From;
        b=OuyZ0Y4GvN5NbUziEleJQZViWeeD3JR07haB7CU5+EdT+kZDqhOYO0p74dhn726Wr
         ImknwXLrbQf6olKjR8BelIkk12IYFqAG7gmp2GM6kMEOe5mU582r26XMXfMtFIQSar
         RuluB/c4iIa8Tu2yV7568kcGjHivt1Dfej9KO+8/jxMCa8cfjo0X2xYIGDS0ixE1fs
         JUkuR5Wyc5/ovbl/0jfmHqfZwwsGsOsFnt9SCb89jhzQzfsnF/jBcHg0zdhxcREkK7
         iAm0auFH6QXmOh17cv23GaftAXytNs9ExweX2eg2IKUXZmsRXPp1k6iOMEvnQHu6j2
         uhN/uNEYtjh3Q==
Subject: [PATCH RFC 0/2] Reduce size of stack frame in svc_export_parse()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        kernel test robot <lkp@intel.com>,
        Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 01 Oct 2023 13:25:03 -0400
Message-ID: <169618103606.65416.14867860807492030083.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here's a possible way to address a recent 0-day report.
Compile-tested only.

---

Chuck Lever (2):
      NFSD: Rewrite synopsis of nfsd_percpu_counters_init()
      NFSD: Fix frame size warning in svc_export_parse()


 fs/nfsd/export.c | 30 +++++++++++++++++++++---------
 fs/nfsd/export.h |  4 ++--
 fs/nfsd/stats.c  |  2 +-
 fs/nfsd/stats.h  | 18 +++++++++---------
 4 files changed, 33 insertions(+), 21 deletions(-)

--
Chuck Lever


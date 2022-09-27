Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6608D5ECAAF
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Sep 2022 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiI0RW2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Sep 2022 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI0RW1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Sep 2022 13:22:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FDF1C6A4E
        for <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 10:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 84E23CE1B05
        for <linux-nfs@vger.kernel.org>; Tue, 27 Sep 2022 17:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4526DC433C1;
        Tue, 27 Sep 2022 17:22:22 +0000 (UTC)
Subject: [PATCH RFC 0/2] Replace file_hashtbl with an rhashtable
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     jlayton@redhat.com, bfields@fieldses.org
Date:   Tue, 27 Sep 2022 13:22:21 -0400
Message-ID: <166429914973.4564.115423416224540586.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, while testing I noticed that sometimes thousands of items are
inserted into file_hashtbl, but it's a small fixed-size hash. That
makes the buckets in file_hashtbl larger than two or three items.
The comparison function (fh_match) used while walking through the
buckets is expensive and cache-unfriendly.

The following patches seem to help alleviate that overhead.

---

Chuck Lever (2):
      NFSD: Use const pointers as parameters to fh_ helpers.
      NFSD: Use rhashtable for managing nfs4_file objects


 fs/nfsd/nfs4state.c | 227 ++++++++++++++++++++++++++++++--------------
 fs/nfsd/nfsfh.h     |  10 +-
 fs/nfsd/state.h     |   5 +-
 3 files changed, 162 insertions(+), 80 deletions(-)

--
Chuck Lever


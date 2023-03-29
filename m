Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973C46CDB98
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Mar 2023 16:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjC2OJb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Mar 2023 10:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2OJb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Mar 2023 10:09:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF5D5592
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 07:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2BD0B821FB
        for <linux-nfs@vger.kernel.org>; Wed, 29 Mar 2023 14:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7A9C433EF;
        Wed, 29 Mar 2023 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680098887;
        bh=kp6eaE3pdeoIahRjqsKfnYHBptIDTTqgIa9AWrx2mUI=;
        h=Subject:From:To:Cc:Date:From;
        b=JVsMc2kgxPHW1DXrtbChdKWOmYobQ7Gcp0raXeS9tdYiS8rYeC4xLR9fq7P10yRK1
         h3MzBmudyflrSBQgnYtk+aUmq7hGefUlqiu0oqH7GyMCyDFRFd4b6y6qQJYRruBE5d
         pACjBD80XX4szfjiEOaRmPtgKvi7LKiipJ1uBNKxNRjT0SGkGs0PyLbl81/dWZKRnw
         YoEEawemoae7rHyBhhJGdWKrlFbrnoC7esW0PLldEaaBkQMWPW143hEM4QuF/B8vM7
         aNzya38/r1Xxk6QpJH1/8QzfJ7ymR93cwtFRpLX3BVi8UzIPGKzC2V8+2x/ZAsGh3D
         +Y8m1NXMW2VUg==
Subject: [PATCH v2 0/4] nfs-utils changes for RPC-with-TLS
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org, rick.macklem@gmail.com,
        kernel-tls-handshake@lists.linux.dev
Date:   Wed, 29 Mar 2023 10:08:05 -0400
Message-ID: <168009806320.2522.10415374334827613451.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve-

This is client- and server-side nfs-utils support for RPC-with-TLS.
The client side support at this point is only a man page update
since the kernel handles mount option processing itself.

The server implementation can support both the opportunistic use of
transport layer security (it will be used if the client cares to),
and the required use of transport layer security (the server
requires the client to use it to access a particular export).

Without any other user space componentry, this implementation is
able to handle clients that request the use of RPC-with-TLS. To
support security policies that restrict access to exports based on
the client's use of TLS, modifications to exportfs and mountd are
needed. These are contained in this post, and can also be found
here:

git://git.linux-nfs.org/projects/cel/nfs-utils.git

The kernel patches, along with the handshake upcall, are carried in
the topic-rpc-with-tls-upcall branch available from:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Soon I hope to compose a new man page in Section 7 that will provide
an overview and quick set-up guidance for NFS's use of RPC-with-TLS.


Changes since v1:
- Addressed Jeff's review comments
- Updated nfs.man as well

---

Chuck Lever (4):
      libexports: Fix whitespace damage in support/nfs/exports.c
      exports: Add an xprtsec= export option
      exports(5): Describe the xprtsec= export option
      nfs(5): Document the new "xprtsec=" mount option


 support/export/cache.c       |  15 ++++++
 support/include/nfs/export.h |  14 +++++
 support/include/nfslib.h     |  14 +++++
 support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
 utils/exportfs/exportfs.c    |   1 +
 utils/exportfs/exports.man   |  51 +++++++++++++++++-
 utils/mount/nfs.man          |  34 +++++++++++-
 7 files changed, 219 insertions(+), 10 deletions(-)

--
Chuck Lever


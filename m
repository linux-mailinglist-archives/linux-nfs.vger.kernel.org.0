Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE9702E9F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEONr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEONr0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B881BC
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA01A617E0
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC77C433D2;
        Mon, 15 May 2023 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684158444;
        bh=VBjhLKMd4K71uDGytkLeDVRTWw7aVn4vPtDaE6QY/hs=;
        h=Subject:From:To:Cc:Date:From;
        b=a+Dt4SdBqnGS4QZadmp0hAbshnIolnRy1lP/tfuEjqCEAtWhVQfooxZD0dq+Jli9m
         VGuKJwJBqFQSx2j7G3A0Tn4DKB+nq5w+vPWAEMGmzUSThYGiggjlZ69g1S9D7/RVuR
         3oAmEKJpCj5k3bkeiadjiuOS8sz4QLG/nZqygIAWB8G5QgLFVWeJpXAKZ4voUWCSUx
         1xyo14+xy7roipGODACKFYfhG9e2hYt4JPr+Mtx+rmKyVLcpnAKcX1nF/o4eMnEfRV
         SOD8pW/HJ7yKngybmVzZaZ/IBp5YQ/c5KqPyYOZP1jCjcGSlN8rmzJ5cBVO41Z2Ehf
         b1IFAqgAoWBwQ==
Subject: [PATCH 0/2] SUNRPC page allocator improvements
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, david@fromorbit.com
Date:   Mon, 15 May 2023 09:47:23 -0400
Message-ID: <168415819504.42590.1664088679943725261.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here are a couple of page allocation optimizations I found while
working on other things. Copying Dave for review, as NUMA-enabled
page allocation was originally his idea.

---

Chuck Lever (2):
      SUNRPC: Resupply rq_pages from node-local memory
      SUNRPC: Use __alloc_bulk_pages() in svc_init_buffer()


 net/sunrpc/svc.c      | 23 +++++++----------------
 net/sunrpc/svc_xprt.c |  5 +++--
 2 files changed, 10 insertions(+), 18 deletions(-)

--
Chuck Lever


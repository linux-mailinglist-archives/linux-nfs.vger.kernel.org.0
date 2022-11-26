Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68E639836
	for <lists+linux-nfs@lfdr.de>; Sat, 26 Nov 2022 21:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKZUzU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 26 Nov 2022 15:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZUzT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 26 Nov 2022 15:55:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFCC17AA6
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 12:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 391C2CE0A28
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6D8C433C1
        for <linux-nfs@vger.kernel.org>; Sat, 26 Nov 2022 20:55:12 +0000 (UTC)
Subject: [PATCH 0/4] quick NFSD-related clean-ups for 6.2
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 26 Nov 2022 15:55:11 -0500
Message-ID: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
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

Four unrelated fixes/clean-ups that I'd like to apply to v6.2
Comments welcome.

---

Chuck Lever (4):
      SUNRPC: Don't leak netobj memory when gss_read_proxy_verf() fails
      SUNRPC: Clean up xdr_write_pages()
      NFSD: Use only RQ_DROPME to signal the need to drop a reply
      SUNRPC: Make the svc_authenticate tracepoint conditional


 fs/nfsd/nfsproc.c                 |  4 ++--
 fs/nfsd/nfssvc.c                  |  2 +-
 include/trace/events/sunrpc.h     |  4 +++-
 net/sunrpc/auth_gss/svcauth_gss.c |  9 +++++++--
 net/sunrpc/svc.c                  |  3 +--
 net/sunrpc/xdr.c                  | 22 +++++++++++++---------
 6 files changed, 27 insertions(+), 17 deletions(-)

--
Chuck Lever


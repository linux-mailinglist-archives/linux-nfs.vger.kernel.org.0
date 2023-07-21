Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74075D5D2
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 22:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGUUj5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUUj4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 16:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77F1701
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 13:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CDC861D9C
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 20:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3769EC433C7;
        Fri, 21 Jul 2023 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689971994;
        bh=vGO8pHSnYZQZtVOOigZCdpisRD36Lub+zYIxbPPmDHU=;
        h=From:To:Cc:Subject:Date:From;
        b=FwaOOWEjfakYd1/xsiWwYrrUrMUBy4o6Xj/VNrtNuTfiVq8gcyxeX9mh0oMlJ3Zza
         /jpL4WAujxFBZwCmetBNtxjXwzzdLMLV5ZJwJagD4ifJeWTnESiUdnZ6ueXvoGLEni
         VTbqGrgDYv7+LY8cPNxsumQYSwtCFy6fJOfIVRId6sxqoB/0B4rZhaFgV6E8BqPhOI
         Avvd6VuqXn5Cwvi6x7pGsoO3UP/OGXU2EQKKkJSCEXqv38LAuo1hl4No3SfHE/C3CM
         X73VMEu6wgFIq0R1fYffsOfoqvf4DKbhfo7iIyd1yp79q6RpIWQrtMleBprk3p9slA
         U3Mn7+W7LA7vg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v6 0/5] NFSv4.2: Various READ_PLUS fixes
Date:   Fri, 21 Jul 2023 16:39:48 -0400
Message-ID: <20230721203953.315706-1-anna@kernel.org>
X-Mailer: git-send-email 2.41.0
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

These patches are a handul of fixes I've done recently to the READ_PLUS
code. This includes fixing some smatch warnings, fixing the XDR reply
length calculation, improving scratch buffer handling, and having
xdr_inline_decode() kmap pages if we detect that they're HIGHMEM so we
don't oops during READ_PLUS xdr decoding.

I also (optimistically) have a patch at the end to enable
CONFIG_READ_PLUS by default. My hope right now is that we can enable
READ_PLUS for Linux 6.6, and remove it entirely in 6.7 if all goes well.

Thoughts? Patch #4 probably needs the most review, and I'm open to other
approaches if something else makes more sense!

Thanks,
Anna

Anna Schumaker (5):
  NFSv4.2: Fix READ_PLUS smatch warnings
  NFSv4.2: Fix READ_PLUS size calculations
  NFSv4.2: Rework scratch handling for READ_PLUS (again)
  SUNRPC: kmap() the xdr pages during decode
  NFS: Enable the READ_PLUS operation by default

 fs/nfs/Kconfig             |  6 ++----
 fs/nfs/internal.h          |  1 +
 fs/nfs/nfs42.h             |  1 +
 fs/nfs/nfs42xdr.c          | 17 +++++++++++------
 fs/nfs/nfs4proc.c          | 13 +------------
 fs/nfs/read.c              | 10 ++++++++++
 include/linux/sunrpc/xdr.h |  3 +++
 net/sunrpc/clnt.c          |  1 +
 net/sunrpc/svc.c           |  2 ++
 net/sunrpc/xdr.c           | 27 ++++++++++++++++++++++++++-
 10 files changed, 58 insertions(+), 23 deletions(-)

-- 
2.41.0


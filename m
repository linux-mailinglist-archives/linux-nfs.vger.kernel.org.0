Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC87B702E28
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbjEONci (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjEONch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201AAE69
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A975E62471
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3747C433EF;
        Mon, 15 May 2023 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157556;
        bh=3QRWBdHGoTgubTd219S/cX9j98l6PzVeTzpE53lScX8=;
        h=Subject:From:To:Cc:Date:From;
        b=U76osPHk+EcF8xTpJ5SBfa5Uk6SKm5dCj4LSFSzagv/h1HNOMgpAl/m2DBytIXVMT
         BNYmKY/jVuVP5Fm1Is/ATl2kW/SRR8iCEGYj7EYFxxEvRfBfz1oCRLKRlzJBh0nUJS
         bRtKtHW2MTs8Fl5ekWEDAlroua5Jm/Bjv7uZftTpmuW138sYSMO5oy3Y6Y55QoDXze
         geLPhG+0LMTKLB+Kw4ZM7e8chMIHycC1iu9fSn1jpS6RJQb8qm0odgwFsBBub/i+Vq
         0qK+l8DMelY2kKGGfGvxBV1PIW+GTJWYjktiHsRxhMU+q6j6owuVOaJTdD4xJbIQ19
         mTgzVNo2K6COQ==
Subject: [PATCH 0/4] Socket creation observability
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:32:34 -0400
Message-ID: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series updates observability around socket creation and
destruction to help troubleshoot issues such as:

https://lore.kernel.org/linux-nfs/65AFD2EF-E5D3-4461-B23A-D294486D5F65@oracle.com/T/#t

I plan to apply these to nfsd-next.

---

Chuck Lever (4):
      SUNRPC: Fix an incorrect comment
      SUNRPC: Remove dprintk() in svc_handle_xprt()
      SUNRPC: Improve observability in svc_tcp_accept()
      SUNRPC: Trace struct svc_sock lifetime events


 include/trace/events/sunrpc.h | 39 ++++++++++++++++++++++++-----------
 net/sunrpc/svc_xprt.c         |  3 ---
 net/sunrpc/svcsock.c          | 15 ++++++--------
 3 files changed, 33 insertions(+), 24 deletions(-)

--
Chuck Lever


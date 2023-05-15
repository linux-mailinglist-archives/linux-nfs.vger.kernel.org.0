Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB1E702E35
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjEONfh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbjEONfe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94771700
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0BE61E7D
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A055CC4339B;
        Mon, 15 May 2023 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157732;
        bh=CB3zciNxnz5pYf+GtX0cw6nE0VXVbZ64w8BG2a5Tc88=;
        h=Subject:From:To:Cc:Date:From;
        b=NWND5OPVx2wUAFIKjC387kCkoYQNPsHz8MwkDbxUDDZSSlcqzbsGI5qpxlJBmFmSo
         n+A3tH0fnXKRc8tTpS+ehj7iEsSu6TZTywlelOrQ08vRDkN02yNt6Egv9BGbPhuHKI
         2BguqBN6gr1Q4tAC1RhXzQF5SsB0cRuaOCMAIjrZUSW+v/asVdg43IqzS5UBGYA3JG
         265HOu7FC6PqFnJal29bXSxFnJi9VBlrPi35tEoudMjJREVD6OwptJzb0fqGlJHsx7
         +O2YbGLRDwGaDBwYboLMM+CECJSkK5KekTww8gfvxViiKdWedaSoknUBQIcwEfggSz
         d4yNfG6ioNLIQ==
Subject: [PATCH 0/3] NFSD admin interface observability
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:35:31 -0400
Message-ID: <168415762168.9589.16821927887100606727.stgit@manet.1015granger.net>
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

I added new tracepoints while looking into the
svc_tcp_listen_data_ready() bug and proposed fix. I thought these
might be generally helpful. I'd like to apply these to nfsd-next.

---

Chuck Lever (3):
      NFSD: Clean up nfsctl white-space damage
      NFSD: Clean up nfsctl_transaction_write()
      NFSD: trace nfsctl operations


 fs/nfsd/nfsctl.c |  83 +++++++++------
 fs/nfsd/trace.h  | 259 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 309 insertions(+), 33 deletions(-)

--
Chuck Lever


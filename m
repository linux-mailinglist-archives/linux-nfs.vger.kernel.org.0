Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547895520B6
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbiFTPZy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244572AbiFTPZT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:25:19 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68279C42
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:31 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cu16so15742944qvb.7
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9z+0e7yosXzWMC+4/4RMnDuuYwdZfKSVj1pN/L3s6OM=;
        b=D97xbiqEIOII6XDRj5bUwamGkcQ29KohjWa7AiApAmoGP7fVr6cPFTq5w8k2+qiDfC
         iKmXS1+ogKcAIciTsl4xCtk1IkcamPhObXQcRzEFUL/fz9eukqFl0lzoJRMPm9nIOJ9S
         9Un+kXbfKVMY+rIUTen3nIH1rntxgeVtEqYH5rWtlvom1H7IPr6JMdM+u6/ihQVMt6FS
         Vh114QcWMSTdHFzJh84noPxznBdch07wtuuROZEU8bv7s7N6qaaqbXaWcvngLNtFQ0RZ
         S1RXIYT2ysteTwazjowfiFvtAmEa00XJNNxZjc3DAyxNMmFVJU91uupvCn6PfHlN6AXT
         Xw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9z+0e7yosXzWMC+4/4RMnDuuYwdZfKSVj1pN/L3s6OM=;
        b=Cm2969NDOYwva5Vf+5lyh2BkseN11wMJJH0d2BHVJ96K5/MdYrTsdws69w1ZtyyyLP
         u0+YnJHY+an5iD6ADu6Rq9xQomthT7EUBELo+OFtE3Y9c3jlPI9XpmRYa6KyN+K1FosV
         RQ1Lgu2qd0WL+IabfQK/qanrafVuWhQ0woqH+tAeJbhDG65N0JH8WsLmCkGnhwNPg6EV
         Bd3/ycUpY4WETWJ+7WXyjWsdc13bivl2ibnjTguCm4M/wbgJDsNW3AOHjg2HGmud9aXO
         E3OgSkQ3X8EQw3c4RxJSlAy05kZsxayhnGmZqVvXt3jxNQrcY7hO/WFgKiPzeQ+Z8zDU
         mv+w==
X-Gm-Message-State: AJIora8Z66ihD+f/57+S9GtzcieM/+wNyHcQ3CVTQ2zy9KPbjJk4IBoY
        wO1Ma9N8oWXu3MFXg9aiQ96yIvThA9tnBw==
X-Google-Smtp-Source: AGRyM1vultktw+jYsnfUFErmz1GleECQCDw+xAlz8bq+9ByJCBSB5smQvU8xZhzOCzc6hBbzkuI7Dw==
X-Received: by 2002:ac8:570c:0:b0:304:e52c:3c2f with SMTP id 12-20020ac8570c000000b00304e52c3c2fmr20316798qtw.8.1655738670525;
        Mon, 20 Jun 2022 08:24:30 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:48cb:6eb8:1da1:a5c0])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006a791a42693sm12517862qko.133.2022.06.20.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 08:24:29 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 00/12] Handling session trunking group membership
Date:   Mon, 20 Jun 2022 11:23:55 -0400
Message-Id: <20220620152407.63127-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Client needs to handle session trunking group membership changes that
occur when a particular server leaves an established trunked group.
This results in a server sending a NFS4ERR_BAD_SESSION because that
server no longer has session's state.

This series proposes to deal with that situation in two fold. First
on DESTROY_SESSION, the client will offline all trunked connections
it has established to the server. Then on CREATE_SESSION it will
iterate thru offlined connections only and probe them again for
session trunking. If session trunking conditions still hold then
such transport would be made active again otherwise it will be
deleted from the trunked group.

Olga Kornievskaia (12):
  SUNRPC expose functions for offline remote xprt functionality
  SUNRPC add function to offline remove trunkable transports
  NFSv4.1 offline trunkable transports on DESTROY_SESSION
  SUNRPC create an iterator to list only OFFLINE xprts
  SUNRPC parameterize rpc_clnt_iterate_for_each_xprt with iterator init
    function
  SUNRPC enable back offline transports in trunking discovery
  SUNRPC create an rpc function that allows xprt removal from rpc_clnt
  NFSv4.1 remove xprt from xprt_switch if session trunking test fails
  SUNRPC restructure rpc_clnt_setup_test_and_add_xprt
  SUNRPC export xprt_iter_rewind function
  SUNRPC create a function that probes only offline transports
  NFSv4.1 probe offline transports for trunking on session creation

 fs/nfs/nfs4proc.c                    |  18 ++-
 include/linux/sunrpc/clnt.h          |   7 +-
 include/linux/sunrpc/xprt.h          |   3 +
 include/linux/sunrpc/xprtmultipath.h |   7 +-
 net/sunrpc/clnt.c                    | 204 ++++++++++++++++++++++-----
 net/sunrpc/debugfs.c                 |   3 +-
 net/sunrpc/stats.c                   |   2 +-
 net/sunrpc/sysfs.c                   |  28 +---
 net/sunrpc/xprt.c                    |  35 +++++
 net/sunrpc/xprtmultipath.c           | 109 +++++++++++---
 10 files changed, 338 insertions(+), 78 deletions(-)

-- 
2.27.0


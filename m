Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88A4C7AA5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 21:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiB1Uis (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 15:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiB1Uir (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 15:38:47 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E517A84
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:07 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f21so11325247qke.13
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCszeyv17dJ/EpsSfRvPtfdmY96e0YP41TqWWJ1QsTM=;
        b=ZvE9wpIX3+CFfDrq+xlMEPhuZrQQidFjvVfMidJ8s4gIva1OGcfbyYQP9Skey46lPs
         EgwmhevSC8khuOSgx0wTGVDpBmx9xztrTAnqgsfLa/qRyjp44GjWUW10kf0PBTINU4Oi
         XN1e6adlf2Oick+yrey7FVyvPLRZDHCNIoaiOT66FK0HaTHNBCCeTcAHItBOCz2+XnIr
         A9mChicfdwZ4dRUYjG16dvMOzeUr3WCuyMwBH5p3Y19KwoOFY9XztCeFLWyEttEFfneL
         jrVyHqc8TFs2tV2Td/eYZMsMwPFMmLmYNg8Wedp2IxsF3NPKWV3734nqCCAIzQTMLEEY
         CONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mCszeyv17dJ/EpsSfRvPtfdmY96e0YP41TqWWJ1QsTM=;
        b=a+OlhKKpQWCLx/H1K7vxR34FE9J9gB18Gxp0onp5wKtjcwLr0eTV8MgmvH28Pdx/8k
         dGf7XVb+TztFnW69zl09KQFlJJ1uZCQg5nRYEJgTW7UmtU8Dr6eZDqRxvZ39+YKtTJuv
         5AbBjmowNGu0LlSM9IeCmnJGWdMv5hq/xOrDb9B9izNvr6qHiKDtyFkkjeFeZehVFln6
         ATtVUNCnCXWK+mmF4JMuJCVUZ7/xtd2k1Rdi+rYbCBda8ZM0CTkdtfF06ryb0kQeIeTe
         XQirDJHWzsDJhLoKs73uPsPMXlnzVt5WyL0HFqfSIDYQwtMyvNpa4w3mT83LfYphKXYN
         MWHg==
X-Gm-Message-State: AOAM5305zh/y5aQYmCGK4nm2SJya47pbdSUNxANxkPNFGgBjleN0+zK7
        64CZFYbH3HLQO4H2h+1tcfaq2S+2n4Y=
X-Google-Smtp-Source: ABdhPJwF5hrSvpUQnJeyhu9g0gTFoBKoAtDQEojsW8j13/sCdbIvivpHAcbLnF14+DRR6YU6Y5VhTg==
X-Received: by 2002:a37:9744:0:b0:508:48cd:5f91 with SMTP id z65-20020a379744000000b0050848cd5f91mr12007933qkd.127.1646080686897;
        Mon, 28 Feb 2022 12:38:06 -0800 (PST)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:4cc0:8dcd:bb8c:75c2])
        by smtp.gmail.com with ESMTPSA id p20-20020a05620a22b400b00648ca1458b4sm5457606qkh.5.2022.02.28.12.38.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:38:06 -0800 (PST)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 0/3] approach to deal with changes in trunking membership
Date:   Mon, 28 Feb 2022 15:38:01 -0500
Message-Id: <20220228203804.61803-1-olga.kornievskaia@gmail.com>
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

A client needs to deal with changes to trunking group membership,
specially when a particular connection (endpoint) is no longer a part
of the trunking group membership. On such occasion, the attempts of
using such transports result in BAD_SESSION error as the endpoint no
longer shares session state with the others.

To deal with such situation, this series proposes to destroy trunking
connections when the client destroys the session.

Olga Kornievskaia (3):
  SUNRPC provide accessible functions for offline remote xprt
    functionality
  SUNRPC add function to offline remote trunkable transports
  NFSv4.1 destroy trunkable transport when destroying the session

 fs/nfs/nfs4proc.c           |  1 +
 include/linux/sunrpc/clnt.h |  1 +
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/clnt.c           | 39 +++++++++++++++++++++++++++++++++++++
 net/sunrpc/sysfs.c          | 23 +++++-----------------
 net/sunrpc/xprt.c           | 25 ++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 18 deletions(-)

-- 
2.27.0


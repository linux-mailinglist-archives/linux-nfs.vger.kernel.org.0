Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEBE6295DE
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Nov 2022 11:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiKOKbb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Nov 2022 05:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbiKOKbZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Nov 2022 05:31:25 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48BB233B6
        for <linux-nfs@vger.kernel.org>; Tue, 15 Nov 2022 02:31:22 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id k2so34958368ejr.2
        for <linux-nfs@vger.kernel.org>; Tue, 15 Nov 2022 02:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W14cJqSVed+BhafA8YxYgcYi7I+ScyB6E4XD42gRZUQ=;
        b=at/GoDivkS6+X7tAWhiK1eQXQykYXK9Z9/AHg6P55DUWFBvGJD29o1nzvW7kgGN0KH
         fTcyj/wFL34fxCnwPVaBqfIs5UXQeRS0W6IfEyjL2/zUdZT4+0PZ+uzGnW7RQ70Cd/R6
         jSHRvQenVM0rcUCtHU/K5Mtg0j52m8Pu1MHZsMvidHtHjOrpRw9xoPJ5yXMXYxlpFolV
         CJj3P0OT+Nu7+mLWZRgX8sb7ctXB+poLPzhSlhFev794emdTzq+Q1viy79I5AnZZNGW7
         5uzpd1hrbS5tpTGr8p3yVKT0b0qUkVr7k3lu/LXkV0K/B6OP2YgsMKnJIWtk21de098f
         hP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W14cJqSVed+BhafA8YxYgcYi7I+ScyB6E4XD42gRZUQ=;
        b=O4A1jjh1bupwLzft9TEUxqMaQ1tSyPR0CpNoLDB6VIjeGuK+xaQyIGkl6T8kSp9BAi
         ulXAvu0ZbfaIHeY+mnl12KmiYbUIgg9h34zZ4hC0nY2x4ucFw1mgB6XiDYuu3Elp7pbZ
         BiKDs6H4CIwW0h2ggKrVmvFCcgvjrHmTCf2RABYpQpv31P0KHgvxs1LBnq/+dcPnx7zI
         NRTYKmsAGNObrxO7XbxLJyQNXWwcBMXgj1NLs3gUj4V2OInzXPFcf74NmTzFMlRlqHNT
         UJ7BarxfeTyVsgJEx5YhIYAGo6Hu/mtpxSCxBw2Npq6UFcazg8CZNVZ2zlsPbTvbMtna
         +c1w==
X-Gm-Message-State: ANoB5plDV+MnFzRbFoqczXu9FjOuouoZJnzrOZQsiESf5ffFKNoopR7R
        isLRWLZpTioyidvSjKkcWARt8UB6kJA=
X-Google-Smtp-Source: AA0mqf4pL9k0A7pTGsqUcTGi6dJW5LKMPQDeBVpe+ediLaUantuJRHyWRxMBWPjXjqEaVrv3yMFtIw==
X-Received: by 2002:a17:906:1e96:b0:782:fd8e:9298 with SMTP id e22-20020a1709061e9600b00782fd8e9298mr13578325ejj.640.1668508281018;
        Tue, 15 Nov 2022 02:31:21 -0800 (PST)
Received: from development1.visionsystems.de (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id sz15-20020a1709078b0f00b0073cf6ec3276sm5273264ejc.207.2022.11.15.02.31.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Nov 2022 02:31:20 -0800 (PST)
From:   yegorslists@googlemail.com
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] README: fix typos and grammar
Date:   Tue, 15 Nov 2022 11:31:16 +0100
Message-Id: <20221115103116.11038-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.17.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Yegor Yefremov <yegorslists@googlemail.com>

Also remove unneeded spaces.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 README | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 5e982409..0b62a4f1 100644
--- a/README
+++ b/README
@@ -25,7 +25,7 @@ Unpack the sources and run these commands:
     # ./configure
     # make
 
-To install binaries and documenation, run this command:
+To install binaries and documentation, run this command:
 
     # make install
 
@@ -40,7 +40,7 @@ Updating to the latest head after you've already got it.
 
 	git pull
 
-Building requires that autotools be installed.  To invoke them
+Building requires that autotools be installed. To invoke them
 simply
 
 	sh autogen.sh
@@ -95,27 +95,27 @@ scripts can be written to work correctly.
 
    D/ rpc.statd --no-notify
        It is best if statd is started before nfsd though this isn't
-       critical.  Certainly it should be at most a few seconds after
+       critical. Certainly, it should be at most a few seconds after
        nfsd.
        When nfsd starts it will start lockd. If lockd then receives a
-       lock request it will communicate with statd.  If statd is not
+       lock request, it will communicate with statd. If statd is not
        running lockd will retry, but it won't wait forever for a
        reply.
        Note that if statd is started before nfsd, the --no-notify
-       option must be used.  If notify requests are sent out before
+       option must be used. If notify requests are sent out before
        nfsd start, clients may try to reclaim locks and, on finding
        that lockd isn't running, they will give up and never reclaim
        the lock.
        rpc.statd is only needed for NFSv2 and NFSv3 support.
 
    E/ rpc.nfsd
-       Starting nfsd will automatically start lockd.  The nfs server
+       Starting nfsd will automatically start lockd. The nfs server
        will now be fully active and respond to any requests from
        clients.
        
    F/ sm-notify
        This will notify any client which might have locks from before
-       a reboot to try to reclaim their locks.  This should start
+       a reboot to try to reclaim their locks. This should start
        immediately after rpc.nfsd is started so that clients have a
        chance to reclaim locks within the 90 second grace period.
        sm-notify is only needed for NFSv2 and NFSv3 support.
-- 
2.17.0


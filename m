Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C52E941C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbhADLdU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 06:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADLdU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 06:33:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DFBC061574
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 03:32:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s26so63458080lfc.8
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 03:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4JGDO75wlPzVWQ4/6z+7zK3d8LwxS4HQGSz5dzpd6hA=;
        b=o8CCVpoj4yv3c/xfozvyFvq76OcZ+3/G7m0N3KyFFbDnM7v/QJAciSYQaef9hl2SP+
         VC/3NvBavMXdI2vAz4kj2lEt1+tYXOtFqa0AYPKGGafboc9oZrT5EqGuIWv6yrE1WuZa
         0ohcWCBCsITDUHJD6njhJ75YKd3Ar294nkGh1Us+5o733E3yz9lCC2Ia3oMfNthOqj18
         eiPTA1XdagN28DkyZL2qqb1+pcowUGHiaAO9FnLhcPKu0Q8X5rs/Yyq+8NV3M5Pe6NTv
         PX00O1rRED9qsDJhWEvoegvx/TowMYNvWj+5vftnPZBrDM2VecHgbvoI9KWdvE234GaS
         8MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4JGDO75wlPzVWQ4/6z+7zK3d8LwxS4HQGSz5dzpd6hA=;
        b=TW7A6gaWgNso0mMd85Yk9YY25R1PdD5G8Ya1ubpsVzHk/IXndlid5rkfQM/RFhjcAh
         q7d2oQfGEBHdT6psz27TjkJS5g3+HgQryGfpCQTEL0ohn8IRkt5EiS3qHelmvPFyPEoF
         5J3knwkCyA8Y9b6THqKWmIkgMnoNGFCNMLPFyVWGeWcWzOCRIEKgt84dQYBaiggnDG/8
         k2WD4eHz6QBCnqfA9kZFfDFY93FWwL+kOMQjEJ6lIM/6aBMdBfVuAgoPx53Mw0p8tDRP
         v7rj6n3ZfnoZUG/KaO050MvRxDww3DElX7JuLCpmGWohGEVyRQGa+RrRSzi46I26k/PM
         Ok/Q==
X-Gm-Message-State: AOAM533kTEeA3gz4x3Fj0fj0zeZQR1Angkccs/QDycc3UsYXSJvua84/
        +6giiese+ZWzkxZgPu8dmh0O2fEOiIXPezkFWiducAKNSi8=
X-Google-Smtp-Source: ABdhPJzAof27V+I0t81S+LbQ5qLDAGC0IxKVptLz4LiO7mtULY5sN0V2FtVyFv4D8lLp6Fl/3EVis996St8g1+BGW5s=
X-Received: by 2002:a19:e20a:: with SMTP id z10mr27173364lfg.295.1609759958477;
 Mon, 04 Jan 2021 03:32:38 -0800 (PST)
MIME-Version: 1.0
From:   Hackintosh Five <hackintoshfive@gmail.com>
Date:   Mon, 4 Jan 2021 11:32:27 +0000
Message-ID: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
Subject: Boot time improvement with systemd and nfs-utils
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpc-statd-notify is causing a 10 second hang on my system during boot
due to an unwanted dependency on network-online.target. This
dependency isn't needed anyway, because rpc-statd-notify (sm-notify)
will wait for the network to come online if it isn't already (up to 15
minutes, so no risk of timeout that would be avoided by systemd)
=============================================
From c90bd7e701c2558606907f08bf27ae9be3f8e0bf Mon Sep 17 00:00:00 2001
From: Hackintosh 5 <git@hack5.dev>
Date: Sat, 2 Jan 2021 14:28:30 +0000
Subject: [PATCH] systemd: network-online.target is not needed for
 rpc-statd-notify.service

Commit 09e5c6c2 changed the After line for rpc-statd-notify to change
network.target to network-online.target, which is incorrect, because
sm-notify has a default timeout of 15 minutes, which is longer than
the timeout for network-online.target. In other words, the dependency
on network-online.target is useless and delays system boot by ~10
seconds.
---
 systemd/rpc-statd-notify.service | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/systemd/rpc-statd-notify.service
b/systemd/rpc-statd-notify.service
index aad4c0d2..8a40e862 100644
--- a/systemd/rpc-statd-notify.service
+++ b/systemd/rpc-statd-notify.service
@@ -1,8 +1,8 @@
 [Unit]
 Description=Notify NFS peers of a restart
 DefaultDependencies=no
-Wants=network-online.target
-After=local-fs.target network-online.target nss-lookup.target
+Wants=network.target
+After=local-fs.target network.target nss-lookup.target

 # if we run an nfs server, it needs to be running before we
 # tell clients that it has restarted.
-- 
2.29.2

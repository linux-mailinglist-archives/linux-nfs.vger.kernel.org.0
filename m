Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52378D341
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 08:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjH3GSB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 02:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjH3GR4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 02:17:56 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C1E9
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 23:17:54 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7a0254de2fdso1938039241.1
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693376273; x=1693981073; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bf9C7WofIPLAIqUHKR8HLpDdpIK4sTc8g8feDGjF8c0=;
        b=RPcKurMW94EpRTbLsTvw0XWZGi7lOxk2P6zQiV6NTIhtX7B25IbG8nAsO8n+saxoez
         snfxVp1AuCXFpV/xApGcYAxFdATiFHyGDsXkRWvZY83RMnnfoHg0u2UZoo9KzaGL5+M7
         o9C15OurFd95g5JKVsxOg5/Vi8UU7BtPlEEkty/Sg4Np/ruPkVPglXST7Lj0aPK0RXf3
         Tf6TXPlPCroVyT91hW/3D1WmJF2XViDKekhHBy47D58b7cRpKLhKQBdof/xzyP77ANLH
         YOnDi7Qc/O/+J45NrkZ3uRkoaZXNowARha+833PA9NIl940u3ueHGAPFObT6TlFqj+k8
         3WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693376273; x=1693981073;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf9C7WofIPLAIqUHKR8HLpDdpIK4sTc8g8feDGjF8c0=;
        b=JJi5Mv3k0zfSQN1hgD47r5ZG8Z2Nht4jtK+6XiIDxsKVBPLlygzruvPwf26fXw632A
         yuqieEnj6aezSPVcsUriTPTZBJDEYjer/wX6LJMQ6BpcruDxC76EqkH2KOWyfvrERfc2
         vpx7fNBsmtmUnDmEzbz4psPYLyGlp889RAzcmCLIeVzE+yMtigdVYK36Mgr+pno8wwer
         Zghi8SJLcE77GQ8ikMgD6Q83th5Sdrm4gN3iF1Jf6YbIfXU+uCI5Hx0vwTlDCyAkInhW
         GRK2WshvhFCV27VHHrXiERCjj8cMwA0o3RL8SdS6UPtJodHq0skJJcaUHjyhkIKMurgl
         CXyg==
X-Gm-Message-State: AOJu0YyAImu3u97L5trC1SUPVuYcD0/dTqvCfa0o6POQOEVbP4pk6Dd2
        ojVNP0pq9u/FKeWNwUOQooxNeVNgDZFXKshjebTtkWZt5VIgnw==
X-Google-Smtp-Source: AGHT+IEPz5iXynOgBqkGM3VKMPKMwFz582D26Ml8t0pQ3ayC0KvbRtif+tOikyIBomYrkkvQ2lRfmU2SYttYhCSi/g8=
X-Received: by 2002:a05:6102:301c:b0:44e:9ee6:b002 with SMTP id
 s28-20020a056102301c00b0044e9ee6b002mr1278915vsa.34.1693376272792; Tue, 29
 Aug 2023 23:17:52 -0700 (PDT)
MIME-Version: 1.0
From:   J David <j.david.lists@gmail.com>
Date:   Wed, 30 Aug 2023 02:17:41 -0400
Message-ID: <CABXB=RSMkjoyshFZy5eGbuvAQfoHhFyQvReYNtO_+5f+OM66cA@mail.gmail.com>
Subject: Question about different gid management between versions
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We have existing NFS servers based on Debian Bookworm that run
nfs-kernel-server 1.3.4.  We have recently stood up some Debian
Bullseye fileservers, which come with 2.6.2.

Apparently, there are some big differences in how users' group
memberships are handled between the two.

For example, on the client machine, my UID is 1000. I am in groups 0,
106, 181, and 1000.

On the server, my UID is 1000, and I am in groups 0, 27, 106, and 1000.

With the 1.3.4 server, the client's set of groups is used. I can
"chgrp 181 x" but not "chgrp 27 x."

$ touch x
$ ls -ln x
-rw-rw-r--  1 1000  1000  0 Aug 30 05:47 x
$ chgrp 181 x
$ ls -ln x
-rw-rw-r--  1 1000  181  0 Aug 30 05:47 x
$ chgrp 27 x
chgrp: you are not a member of group 27
$ ls -ln x
-rw-rw-r--  1 1000  181  0 Aug 30 05:47 x
$ rm x

From the same client, with the 2.6.2 server, the server's groups are
used. I can "chgrp 27 x" but not "chgrp 181 x."

$ touch x
$ ls -ln x
-rw-rw-r--  1 1000  1000  0 Aug 30 05:50 x
$ chgrp 181 x
chgrp: x: Operation not permitted
$ ls -ln x
-rw-rw-r--  1 1000  1000  0 Aug 30 05:50 x
$ chgrp 27 x
$ ls -ln x
-rw-rw-r--  1 1000  27  0 Aug 30 05:50 x
$ rm x

This change in behavior was quite startling!

We are using sec=sys, and this change in behavior happens with both
NFSv3 and NFSv4.2 clients, so it doesn't seem to be related to ID
mapping.

In this case, it's not possible to synchronize users and groups
between the clients and servers, because Docker is involved and the
stuff that happens with uids and gids inside docker is chaos.  I can
control the NFS server configuration.  I have minimal control over
what happens inside those containers on the client machines.

Is there any way for me to get the old behavior from the new server
short of downgrading?  My attempts to Google for more information
about this have been utterly fruitless.

Thanks for any advice!

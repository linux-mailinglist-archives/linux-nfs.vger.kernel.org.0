Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4169ADC0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Feb 2023 15:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBQORo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 17 Feb 2023 09:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBQORm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 09:17:42 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2801B32A;
        Fri, 17 Feb 2023 06:17:21 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id t16so2681845qto.3;
        Fri, 17 Feb 2023 06:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oZkZj1RohbGyyor+ZOiSbobin9NoRD+JVFlCY1ilCM=;
        b=pEoiCJOCRsTzaQl74Nhxhye64Ubo8YbXdAzoSkj5cKYFoSFEpNK3TaeFf28ISm6V12
         pSC4XT448v3vC4fxplOB12j5+l7s+tu6/3d9S5grG32EWAufAg9H1RisYdYwxsNm/UPj
         aMVsJlLqKVZfKynEo+5GOqUqmpfwi+gvUozj3/UlgcaOxhEEGotFAtCeWmJdvNJGHxgu
         9TR7/f7da/J68AOtBSBAstE/oqmLC9gU+UQwgXuLoJX7asEP2E+T5eCGNagBJmobPge/
         lgR2Kp0PQhEF84gKvJMyQ87LN6u8r9lo+7OFa2lUoG6vxN6Kn/ANen/v+8j1QnkgM5HG
         gaaw==
X-Gm-Message-State: AO0yUKXKJriT7/inHotgvDsjriOTntqNjuZCHJZRsqKXzSYMrbkh/uM3
        y3+4+XKzqv/EPgWioRLKuc+weeanMg==
X-Google-Smtp-Source: AK7set/3FtP2+wVzlGYUz562CSqsUXiHxki5IZImB1/G9ks3NgsDIn+wBPzr8YQgLidI+OiVZywQYg==
X-Received: by 2002:a05:622a:1818:b0:3bb:7c6b:9cb6 with SMTP id t24-20020a05622a181800b003bb7c6b9cb6mr9482870qtc.17.1676643391629;
        Fri, 17 Feb 2023 06:16:31 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id d4-20020ac86144000000b003b2ea9b76d0sm3266054qtm.34.2023.02.17.06.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:16:31 -0800 (PST)
Message-ID: <c2181ba919c59ffde5c9b9fc615608f92a146413.camel@kernel.org>
Subject: [GIT PULL] Please pull another NFS client change for 6.2
From:   Trond Myklebust <trondmy@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Feb 2023 09:16:29 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit ec35307e18ba8174e2a3f701956059f6a36f22fb:

  Merge tag 'drm-fixes-2023-02-17' of git://anongit.freedesktop.org/drm/drm (2023-02-16 20:23:32 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-6.2-3

for you to fetch changes up to 896e090eefedeb8a715ea19938a2791c32679cc9:

  Revert "NFSv4.2: Change the default KConfig value for READ_PLUS" (2023-02-17 09:07:19 -0500)

Unfortunately, we found another bug in the NFSv4.2 READ_PLUS code.
Since it has not been possible to fix the bug in time for the 6.2
release, let's just revert the Kconfig change that enables it.

Thanks,
  Trond

----------------------------------------------------------------
NFS client fixes for Linux 6.2

Bugfix:
- Revert "NFSv4.2: Change the default KConfig value for READ_PLUS"

----------------------------------------------------------------
Anna Schumaker (1):
      Revert "NFSv4.2: Change the default KConfig value for READ_PLUS"

 fs/nfs/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com



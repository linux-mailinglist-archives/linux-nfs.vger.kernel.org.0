Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B33881D2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352351AbhERVHa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352347AbhERVHa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 May 2021 17:07:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E8C061573
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 14:06:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so592388plf.7
        for <linux-nfs@vger.kernel.org>; Tue, 18 May 2021 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=WiExRtYr8Kdt4XqfC45ncFMA8TZhnd/7g66Z/hQ/oNA=;
        b=zkq1/OqGMcIFT6IlJ1p8OhC87uJ+wacaCnUGOxnB8rzZHJDuYtnUhGnpuKy/+0LR3u
         8CcPwmJJTspul5HuwLkEo8QpNZ0pN5RR+5FrfTLdk5/MGSjrGo5B1LdCT6t3qLoArk5l
         +VxmufEWwRr1ccoCUs1Ask25Y9pHn+U7X3USaX39sLLGk+bz8x12LiQCzbEF8YKSOMul
         W/gSreSJNYMZuW9xLWVn+JFDub0041vZ3RD8YlSSGHRUaEhHli+yrhoMHi+aGgl2eHbC
         ML5o9+8EGbz4G5x5w20DKLbCuSWeSbocm5iobkfBwkUsqoDyUiP6/X4J9+Zu0dNnL3St
         utfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=WiExRtYr8Kdt4XqfC45ncFMA8TZhnd/7g66Z/hQ/oNA=;
        b=KOzHKi2fILRBlrOyoDxiE3sywQ5EKBZd+KyC8zflV73EJ7VrJlLPxPo7BYul+v3GRG
         kfIT6iaIArglRh5rFo5D6SzXvC5hkZscGlXXexhl+MjFvIGZWG9iswzOkvP2S8a0i6ly
         oK9gzHybhU4Shz05EpyKM1v+t7IXepaD+Wk0jdzqtCNbNpzcNe9Bl2ezXdXx3NOQbD+n
         VF1Ric0N4J6rpGx3HVcST7utnWlxuQuzwiogny2rHL6V+PLCyrBgedlVh82WJiaSCrro
         iOBrRppc2gPR+K07xAFL+J/uXprN1Jsb8J2UQPfAz/FRUddeXxvUkT1PWsDPrB4VCtCg
         Gn/A==
X-Gm-Message-State: AOAM532qZf/6BujLcSCeaIwZoPR/yK1g/mEHqB5h17voz+NQLu+S3krt
        pkHRLaD+u4xugF6Nne9bYij8gEry7ssSCw==
X-Google-Smtp-Source: ABdhPJyE7J3jLKBf3RTXFG3bzIqA9+eZIIWjUp+lSwlzB/97x9ceHNlf3vK5cFPUT/jIYTFt15r3YA==
X-Received: by 2002:a17:902:fe0b:b029:f0:c15b:d1b8 with SMTP id g11-20020a170902fe0bb02900f0c15bd1b8mr6666512plj.74.1621371970673;
        Tue, 18 May 2021 14:06:10 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id s65sm13855482pjd.15.2021.05.18.14.06.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:06:10 -0700 (PDT)
Date:   Tue, 18 May 2021 14:06:02 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     linux-nfs@vger.kernel.org
Subject: Fw: [Bug 213135] New: NFS service not working with linux 5.4
Message-ID: <20210518140602.018d3908@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Begin forwarded message:

Date: Tue, 18 May 2021 19:30:28 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 213135] New: NFS service not working with linux 5.4


https://bugzilla.kernel.org/show_bug.cgi?id=213135

            Bug ID: 213135
           Summary: NFS service not working with linux 5.4
           Product: Networking
           Version: 2.5
    Kernel Version: linux 5.4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: hbhuwania93@gmail.com
        Regression: No

I am running a linux 5.4 kernel image. 

I am seeing an issue with NFS service crashing randomly. NFS version I am using
is 2.3.4 

Apparently the rpc.mountd crashes randomly and dont have a clear picture on
what is happening. I tried manually launching this daemon and I see below error
traceback:

root@HostName-637562903921812352:/etc# /usr/sbin/rpc.mountd -p 9000 -F -d all

rpc.mountd: Version 2.3.4 starting

rpc.mountd: nfsd_fh: inbuf '* 6 \x8fd3a09e776c46d09e8b8ca1b0e895ec'

rpc.mountd: v4root_create: path '/' flags 0x12407

rpc.mountd: v4root_create: path '/usr' flags 0x10407

rpc.mountd: v4root_create: path '/usr/srvroot' flags 0x10407

*** stack smashing detected ***: <unknown> terminated

Aborted

Any suggestions why NFS is behaving this way?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93C81B8196
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDXVTW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDXVTW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Apr 2020 17:19:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83DEC09B048;
        Fri, 24 Apr 2020 14:19:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id i68so9193258qtb.5;
        Fri, 24 Apr 2020 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=fXa5ZQfBwOl7sxD1r5EZkygeH/aqjfJgOvY7hYBHa9w=;
        b=pTsALS5ldCOL8b8K4RRVPC2hHJb1+FgzXfI931FbjXV0hDLETRK4iwFhke7W2/10oV
         6SCuFCn98Dg5fXPUd2230yxerekJI7foUrUzA+Sy4VuvH6e+Qg9PnfpJ0CM5/FriH/NQ
         HTfaJ1ubiYvheHvQ/o0QLOEOwm0Hc8KJI5w7220lJ1D52jhE/qs7d33ajnWXRAxxG65Q
         PC7/FpOMFOVkLLU93JRpsZl5XH6TBBWFWqbHOQNkPP4z77mUQ0F8BN61hsqV1SsmNXxC
         anD1wx3PIntX4jCNLTI+p7KTx1vwZtA+ysWucseZLmeKnVhax1eAdBNxIXg6dNNbEJFL
         elgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=fXa5ZQfBwOl7sxD1r5EZkygeH/aqjfJgOvY7hYBHa9w=;
        b=GZooiuMQV3hMvh2J0V7HkqsRwY2uxWTT8kP4wwOYtyELXHZao837WsmoVczklSdoiP
         vjOfl/lcCYYmc6ckJ/qem9Ayskvfewk1TSKeCvIrMdijurpLqcFmYZMaS7877LgpqiaB
         8yO723heUrQOv9YHNj8JicNAa0E+FVoZemGUez8LzoFrbXjTDEYFVF2cz0cgZEpFCaSZ
         tmW2mecdyGdYzSHB9OR6ndTrKzFkFDZPLCM+Zo1u2AlCAQ06jL4CuwGAeFwERstBVRuL
         qImPBzEKqne7QF5xHALOLB7/iwvRE0REJ46eAAzhX+I4l6mHJO0EyJb88BIAT8kGLkEJ
         kMVQ==
X-Gm-Message-State: AGi0Pub/dn1P+uWZrgK05swy1hrc2ei/IgvFrKwAJ8LL5m+1hxGYIJiG
        oGpCgLrZHccRV0JeJRHXHC6a9l9kpqk=
X-Google-Smtp-Source: APiQypJywaIdnm4aLifH77u50linEM5gKc2ZL+3ntkv/UawL0RBccSXYT8nu25D4do6ICxkpGv6vRA==
X-Received: by 2002:ac8:32a4:: with SMTP id z33mr12022128qta.363.1587763160564;
        Fri, 24 Apr 2020 14:19:20 -0700 (PDT)
Received: from [192.168.1.43] (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id p22sm2166422qtb.91.2020.04.24.14.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 14:19:20 -0700 (PDT)
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
From:   Anna Schumaker <anna.schumaker@netapp.com>
Subject: [GIT PULL] Please pull NFSoRDMA Client Bugfixes for Linux 5.7
Message-ID: <b380cea4-b711-fd33-8a79-434657168950@gmail.com>
Date:   Fri, 24 Apr 2020 17:19:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)


are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-rdma-for-5.7-2

for you to fetch changes up to 48a124e383508d3d73453d540a825c0745454af9:

  xprtrdma: Fix use of xdr_stream_encode_item_{present, absent} (2020-04-20 10:45:01 -0400)

----------------------------------------------------------------

These patches fix two bugs that Chuck found that were introduced in the original 5.7 pull request, and also a use-after-free race in the tracepoints code.

Thanks,

Anna

----------------------------------------------------------------

Chuck Lever (3):
      xprtrdma: Restore wake-up-all to rpcrdma_cm_event_handler()
      xprtrdma: Fix trace point use-after-free race
      xprtrdma: Fix use of xdr_stream_encode_item_{present, absent}

 include/trace/events/rpcrdma.h | 12 ++++--------
 net/sunrpc/xprtrdma/rpc_rdma.c | 15 +++++++++++----
 net/sunrpc/xprtrdma/verbs.c    |  3 ++-
 3 files changed, 17 insertions(+), 13 deletions(-)


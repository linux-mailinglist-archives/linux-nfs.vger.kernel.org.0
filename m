Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09423266864
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Sep 2020 20:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgIKSrv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Sep 2020 14:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKSrt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Sep 2020 14:47:49 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889A9C061573
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:47:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o5so10848490qke.12
        for <linux-nfs@vger.kernel.org>; Fri, 11 Sep 2020 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=70MiMVltxNyxkABCOwKDTP+EQ1ZPOHXxwXBcX43cI3w=;
        b=ofH4aF1ByERsuoBs0rxS5m59LFXtDmsXLuLZaJB9mzmRE+COOQDrZT1O7nGoAO1PTY
         LGLDLzRReck+JzmpoC53BPAC17GYo4FalCESoPpBZnG7XVzdJm5BX4HGaW1QuL/BwU77
         /Qr7oQu7F3M8jpnM0RlLcPxhwBoR2AMk8ZFLp/ApJwK9vaI+j663emw27q8220zu+4BP
         lbe/leWV8VDNYxmMFdEJRlChDW/2VNuXS7pGZ4LeBarREqA0NH54dvpRwKFWHUxY9vHQ
         ix6Z5kkXEkfB0XCfe21tFy1HXz9h6nn8ykxNpMA6dpn+8mt9bDJFBWHu9/Z6hf5xH8kA
         V/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=70MiMVltxNyxkABCOwKDTP+EQ1ZPOHXxwXBcX43cI3w=;
        b=AoXb+mtPiZ3m0RQ/Xf5WyQ/k77bxjG/BOhZ8TCKDyxwW4L5l537MCKWP6jihMixQH6
         0YikTcKKM1WDCUf8SjU30yL0q6TJ4Rbb9QN9mt5DOTBbmroTm86GmwK93D4EvLw9lDUG
         JkzD2bi7D00iUfAsio9MLJvXBkiXslKdvrfusD0LW2GQP2g54Ve4el491W+HKLhk8JJZ
         L7CVNKINvbfI+MzK8ic/wA3RqtQc4gQNIgB6+Dr8IZx2/dSvMVSEaMKpiI8ECPUbx3ym
         OmNz/QKm09BZIGdi8byEw3kW6F6Jyq1pLJqmetdhFz97yVu46hR8HvGYsGiuUoE77OYI
         SG6A==
X-Gm-Message-State: AOAM530BvU7pEM9D+lvhIELj2F8RQxEAJEUg6R2QilSJYNh3YTLvftEO
        WplqEo9Nruh9CcFPU+4gnL1JdLd3REg=
X-Google-Smtp-Source: ABdhPJwmPZL5dd2MUP0Hxna+lNU5DbNWxp5v9pOtdyZkKnc58SwzdE/lKqYczfq9CYw3aSmX86pJsQ==
X-Received: by 2002:a05:620a:9c1:: with SMTP id y1mr2665472qky.241.1599850067276;
        Fri, 11 Sep 2020 11:47:47 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y30sm3883564qth.7.2020.09.11.11.47.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:47:45 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08BIlhNx000606;
        Fri, 11 Sep 2020 18:47:43 GMT
Subject: [PATCH 0/3] Address sparse warnings
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 11 Sep 2020 14:47:43 -0400
Message-ID: <159985000766.2942.3348280669087987448.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

I was going to send a v5.9-rc PR for these, but they are not urgent.
Would you take them for v5.10 ?

---

Chuck Lever (3):
      NFSD: Correct type annotations in user xattr helpers
      NFSD: Correct type annotations in user xattr XDR functions
      NFSD: Correct type annotations in COPY XDR functions


 fs/nfsd/nfs4xdr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--
Chuck Lever


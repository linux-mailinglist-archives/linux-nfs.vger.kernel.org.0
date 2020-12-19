Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3F92DF10A
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Dec 2020 19:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgLSSa6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Dec 2020 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLSSa5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Dec 2020 13:30:57 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FDC0613CF
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n7so3477297pgg.2
        for <linux-nfs@vger.kernel.org>; Sat, 19 Dec 2020 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLkUbAW5Ky9u2Q7hcwX+yAdv7hDsVChwtLFef0dGCjA=;
        b=Rkc3eaXPaAfqJ7Wwin9q/LFkZaMJPgviebIdhnXy+/TFb54/JZ5BF/rsN4SgCh+u4u
         WRo8szfHir2/0IQ9SiC/Uk6o8xW4HHXAJIUVprs5sr3G3mKdqcjY4hRBakhwGzc2s0un
         VZncQ/MdWRvf65nnTGnyCUrBOvEbnKnw4OQektL63K9Zd7rOESQypeLL+yApqPwglO9r
         O1XZZZrYutIhWPnQWHbR9lJLzHxea5UtZU2ftUwYTMv35fFIm6Ppeo88JoB9PTAiC429
         J7GrI1qqiFQTw+lG/p07QJLLcZTh19e6gwZTKHsxPykUbACSjCSEgcmD2nvn0whk7cH3
         bLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gLkUbAW5Ky9u2Q7hcwX+yAdv7hDsVChwtLFef0dGCjA=;
        b=FV84Ut4N6jEt+YQj2B7A3ZUuksXSGLotXz2JQjZxWAWfg7vLwY7prHTKNgsctXjdrN
         TnfspajgEqXlkP5XfXDril9x1K7Ep8RWh4t+rP8hKtNFzVOdLNoEC7hVT98ww8+lcQXQ
         2TIl2oidXrykdX/4EqHzmInU/69/9NA32pfgLbSgkfKcqLRnWggpIt0oVhVAE9p1Fv2H
         by9VQ665kapGklQItUEz91vU/HGQ4V6XanXdgenX1381GKgisUPEatelCH+Nz0pz10AW
         UjeYKTRC8mWf1kaUVsD9ZAlRGf0oDe/QgH+hHxQKLpvrLCNwpTdO8odoLuQRLsXjb4b1
         rLHA==
X-Gm-Message-State: AOAM5337Gbz/NW+7U/1Tgv82/kbYNEP1PW/qYUcJGRk7xS4ko8exZmnJ
        5P6cxo+GIhh4YH5Mr2PH4ZLaWLTM6gR4QA==
X-Google-Smtp-Source: ABdhPJy7ZIybOcRKcZTTgqV/Cov0rKJR2xjxrTMkjjmemM98mmlJy2p4i9rs57AKxzamHMdbbLawmg==
X-Received: by 2002:a63:6442:: with SMTP id y63mr9242730pgb.35.1608402615632;
        Sat, 19 Dec 2020 10:30:15 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id l197sm12318471pfd.97.2020.12.19.10.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 10:30:14 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs python3 0/7] Python3 patches for st_flex.py
Date:   Sat, 19 Dec 2020 10:29:41 -0800
Message-Id: <20201219182948.83000-1-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Tom Haynes <loghyr@excfb.com>

Hey Bruce,

This applies on top of the previous patch set.

This passes on my RHEL 8.2 client running python3 against a Hammerspace
server.

Thanks,
Tom

fwiw - In some of the error paths, the system would complain that the
exception StandardError was not defined.

I found this:
https://portingguide.readthedocs.io/en/latest/exceptions.html#the-removed-standarderror

Tom Haynes (7):
  CB_LAYOUTRECALL: Make string a byte array
  st_flex: Use NFS4_MAXFILELEN in layout calls
  st_flex: Provide an empty ff_layoutreturn4 by default for LAYOUTRETURN
  st_flex: Use range instead of xrange for python3
  st_flex: Test is now redundant
  st_flex: Return the layout before closing the file
  st_flex: testFlexLayoutStatsSmall needed loving to pass python3

 nfs4.1/nfs4client.py            |   2 +-
 nfs4.1/server41tests/st_flex.py | 124 +++++++++++++++++---------------
 2 files changed, 68 insertions(+), 58 deletions(-)

-- 
2.26.2


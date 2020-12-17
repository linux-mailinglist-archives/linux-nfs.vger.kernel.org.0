Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546B72DC9F8
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Dec 2020 01:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLQAgY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Dec 2020 19:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQAgX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 19:36:23 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F92C061794
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w6so17829778pfu.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ne/FV94nFn7K1eUDTZO9YUmprzpMByv14LQMNYH+slI=;
        b=m596LBxFuzpIurcbVYaIJMgpFkkvE4QkpGbF6mZQYKkMnTT/3QaLCFlFqKaCEqHYI4
         8i+hCx7tLJiyfL5IhaiolUa1wOblQgvgfjEoW3+BhEZJrrz78U5Vn+16glCRqxjjD5oB
         tppZE8awP8qnvjE2K9qLDaEBLNUxP4IghbzdHrxz4X//g6jI1fwpUkOimm+tHCsp9Dtc
         SheF+6iKBEori59Ljhm5PW5BCaxnVKudEaJPbrm+3FED+3CBPkSzda8GFh6MKxBJlRTk
         6SMburNShfbqnnJz2U3iGvi8KZtxL5jMI0xl/nhbIZp9/Mhja+dc4eFcmOWfkYECN2+5
         yECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ne/FV94nFn7K1eUDTZO9YUmprzpMByv14LQMNYH+slI=;
        b=haufK2uNPix2ZVFTPYUOTF3ogcP4OehDOh7bmo4ZfeigmMav+q2Hchwj6gLaNB5IfQ
         4/JXxGbxOjejH31FxGuHsGaIGRK44Kj9dl8pJr9BNE+i2uYMHwW3i+s812ZKm0JvIHR4
         /uMV8f6oduqbmzm6ytS7Ed7S22kHzK3C8EgWWeTocSf17RlYi21mPTV/acLhWnW1IL3v
         HA5T539H0Kuq8iBcrsH3juRf3+mj94zQCr2YVZ/H+FIP17HmLo2v5zc9ZwCseg/GM24U
         aOOOxLRbrShWXwU6ZQAI82iixN0yQ4hU5V132noMSyOwIikjpTClSbBeCkZNVmYaacKk
         DeNA==
X-Gm-Message-State: AOAM532eqkphsuc29MVZsjeIOqdYGTlPcUDzMvlBML8MjvntZm4CnNP1
        gZSePgLUDfdx5v3tszCpMLCIbQPmFPwkYw==
X-Google-Smtp-Source: ABdhPJxkV5IVuCy5895yyXVk24meBEl14S5bTRQGylnySO5fnQU50ZMcfChckcB5hhgelRzcBR9Qxw==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr19910331pgb.332.1608165343375;
        Wed, 16 Dec 2020 16:35:43 -0800 (PST)
Received: from garbo.localdomain (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id v24sm4011243pgi.61.2020.12.16.16.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:35:42 -0800 (PST)
From:   Tom Haynes <loghyr@gmail.com>
X-Google-Original-From: Tom Haynes <loghyr@hammerspace.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [pynfs 00/10] Misc Fixes, primarily LAYOUTRETURN
Date:   Wed, 16 Dec 2020 16:35:06 -0800
Message-Id: <20201217003516.75438-1-loghyr@hammerspace.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

Here are a series of patches that Hamerspace has applied to the
flex files testing.

Thanks,
Tom

Jean Spector (2):
  st_flex.py - Added tests for LAYOUTRETURN with errors
  st_flex.py - Fixed flag names

Tom Haynes (7):
  Close the file for SEQ10b
  flexfiles: Fix up the layout error handling to reflect the previous
    error
  st_flex: Reduce the layoutstats period to make tests finish in a sane
    time
  st_flex: Fix up test names
  st_flex: Only do 100 layoutget/return in loop
  st_flex: We can't return the layout without a layout stateid
  st_flex: Fixup check for error in layoutget_return()

Trond Myklebust (1):
  Fix testFlexLayoutOldSeqid

 nfs4.1/server41tests/st_flex.py     | 651 +++++++++++++++++++++++++---
 nfs4.1/server41tests/st_sequence.py |   5 +
 2 files changed, 588 insertions(+), 68 deletions(-)

-- 
2.26.2


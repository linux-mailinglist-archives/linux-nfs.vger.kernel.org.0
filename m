Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC92374C168
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Jul 2023 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjGIHVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 9 Jul 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGIHVI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 9 Jul 2023 03:21:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127CE46
        for <linux-nfs@vger.kernel.org>; Sun,  9 Jul 2023 00:21:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9922d6f003cso459942966b.0
        for <linux-nfs@vger.kernel.org>; Sun, 09 Jul 2023 00:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688887264; x=1691479264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ksBwnjakyxuN7NY3sHZXBQiJpynl6iu9Tix/mw/4iM4=;
        b=i+XmaNFhcfow1A5y8+B+NEVLkK/4nlqiGVyVgP2SgFvTBC3yWT1P4zu7mYCLtim5P5
         yVnOrbs5uz0nWbprJndbrpHs8aQAxjD2l4F7FwXfXYRsa2TAx1z1DbGSDqMyX0nutNMP
         4UxrOE+Qzl0NcisC/FcddowV5RrxebSkmiSzDU2VKfO+EzFgflJUwqUURYIPHTnVruOf
         QvwJr2kgm8zroDAisAYdf4vMYmRZxCMcbdbmE6NMPVFYOSTtNxJ0jsVQavFhPX/0r3V7
         CmVOJ3Uqkbv+TcXdSHFYcBW+i3uTjLRGUFr8WDFshiz7HsiDqQpkEcmBlOIpI6sJuydT
         +uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688887264; x=1691479264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksBwnjakyxuN7NY3sHZXBQiJpynl6iu9Tix/mw/4iM4=;
        b=ZQsDepCnBf3JR7sZ/fX8eiJYh5WIU6gM59cPD9DHEUDJ43NGCgN12p7X2Jjl9Wiiq8
         3kVJ7m3WtSWYgH99CzIQvK9r+CaqheMEV1BhLY4o9XOHJbbXgVzeiTFLiDokl+x79zXD
         MK2c15/Ahz4RtTrBCKvFsZNxHwNVvPDmmvcyqZNeLhQNE/io7UzVwsvBN+qdYxYOnsoJ
         eJTlaz7hosAFp9KJlcjSrsAd3BoZugqv4TTAc2UB84kAAUq3L6IxOeL0hxH+XWWVYQNU
         IsIHLDjQFfA35v0gwsl+GwcD8PbAi0BSpZZs+DFIbh6zpqc/rd4UbZAbRxK0PadrDkBq
         V9ig==
X-Gm-Message-State: ABy/qLYXtvjMLBmSTFqNnvyEXH+8xvlREatVuGaloSQtI1djwJzk4L2x
        Nu+EFSlp7/lIOCTjYRmaqNg=
X-Google-Smtp-Source: APBJJlH5gKFTQQi0CCUsejUS2x5RNVwyZi8R6rkP5TNRbGOgqyG1unkdAPpaqWF9krEmqHUNCzfZhw==
X-Received: by 2002:a17:906:10dd:b0:993:e752:1a6a with SMTP id v29-20020a17090610dd00b00993e7521a6amr4218853ejv.21.1688887264140;
        Sun, 09 Jul 2023 00:21:04 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b009737b8d47b6sm4390259ejb.203.2023.07.09.00.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 00:21:03 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id C4917BE2DE0; Sun,  9 Jul 2023 09:21:02 +0200 (CEST)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     NeilBrown <neilb@suse.de>, Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, Ben Hutchings <benh@debian.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH nfs-utils] start-statd: Fix shellcheck warnings
Date:   Sun,  9 Jul 2023 09:20:29 +0200
Message-Id: <20230709072028.829990-1-carnil@debian.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

shellcheck currently complains:

In utils/statd/start-statd line 14:
       [ 1`cat /run/rpc.statd.pid` -gt 1 ] &&
          ^----------------------^ SC2046 (warning): Quote this to prevent word splitting.
          ^----------------------^ SC2006 (style): Use $(...) notation instead of legacy backticks `...`.

Did you mean:
       [ 1$(cat /run/rpc.statd.pid) -gt 1 ] &&

In utils/statd/start-statd line 15:
       kill -0 `cat /run/rpc.statd.pid` > /dev/null 2>&1
               ^----------------------^ SC2046 (warning): Quote this to prevent word splitting.
               ^----------------------^ SC2006 (style): Use $(...) notation instead of legacy backticks `...`.

Did you mean:
       kill -0 $(cat /run/rpc.statd.pid) > /dev/null 2>&1

Use quotes and $() as recommended.

Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 utils/statd/start-statd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/utils/statd/start-statd b/utils/statd/start-statd
index 2baf73c385cf..b11a7d91a7f6 100755
--- a/utils/statd/start-statd
+++ b/utils/statd/start-statd
@@ -11,8 +11,8 @@ exec 9> /run/rpc.statd.lock
 flock -e 9
 
 if [ -s /run/rpc.statd.pid ] &&
-       [ 1`cat /run/rpc.statd.pid` -gt 1 ] &&
-       kill -0 `cat /run/rpc.statd.pid` > /dev/null 2>&1
+       [ "1$(cat /run/rpc.statd.pid)" -gt 1 ] &&
+       kill -0 "$(cat /run/rpc.statd.pid)" > /dev/null 2>&1
 then
     # statd already running - must have been slow to respond.
     exit 0
-- 
2.40.1


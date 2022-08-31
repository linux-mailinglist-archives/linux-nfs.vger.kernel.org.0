Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7A5A7E1D
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiHaM6A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiHaM57 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 08:57:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B29B69E8
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 05:57:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y127so14338424pfy.5
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=UjX9RpzNcMdO3PaAYHh1O169Hpy8ePU2w6yD42ZlV/c=;
        b=f06QULJx6gSkux/M5D4YcEWCDN1v1CH1bm9hmwqQuTzSKWd+HgYgqCTvtfD/3RMAvI
         Q3AL+cFZfQJ4zeQRUL66Qm3wzcOBFcpMNZ60A5cpL5M3D4L9z/4WPG36Q1nENbjcc52J
         dCv/T7iuiX8bN3sWlTdloQfVjQMGQz/CQHYZJCiM0ZGmxRatBL5h+qFOkXIARjpdsdMV
         5dYlMHyV9NHHUwlTeFxNb7ega8tgl0SZBpeP5Tm8MaUHQdN3HSg+7RVssFNkF101poRH
         MHW7YOhOsX72ObL/RVEy6pkDHTTNcgAOeZN8Gz95P2hc4iMTXrWY+hBRdRpO3hPkEAZq
         Gw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=UjX9RpzNcMdO3PaAYHh1O169Hpy8ePU2w6yD42ZlV/c=;
        b=pAeTye6krQKBGv11krhJszvW/72AlmQA0cW2tZ9cMfLulnNpKK1vmzi4+Q1BXwE7mP
         YXr1neeK/hysBGvWVIOfAu9XvYBoYhftu7xLmywYBFFwhVOI6JlxigYUnkM9njaZ+LZm
         ZJ/2mH9jbl12LlIeMThpt3/PxLEWhAtx9R09DY2WU0xgNpW5FsvUlQF9Ga4+aVfptt8H
         sXEWsqkg4KTmL0c6981Oue8FNc/ErRiVqpWBIdq0l6f/B2CNup5UyEhieG0XDMRTaHa9
         WLAS0jH2rnvCl4ojQ0pACDV6ZLIk1l3giI4gQkPRbFlU21WDEmBNVqaNAfIcWLISWux0
         2qHQ==
X-Gm-Message-State: ACgBeo0EtSKAI2Yb4o6s48iLiAtOhroO0VuDcq/o7dI+I/TP3iNvgx5U
        R/NWCodGJZIZstrC4aTdoqmB7poJxOlmfudIBzpHcnJjGhs=
X-Google-Smtp-Source: AA6agR4xnj7wR6kYN1vE+RcPh3+ebjBYNw1GXDoZLPjraqWVcfOfgkBv42IHnXXUJN8yjAQlL8ts5FmZsCAE2k+K4Xo=
X-Received: by 2002:a63:914a:0:b0:42b:4eaf:7c75 with SMTP id
 l71-20020a63914a000000b0042b4eaf7c75mr21883185pge.306.1661950674690; Wed, 31
 Aug 2022 05:57:54 -0700 (PDT)
MIME-Version: 1.0
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Wed, 31 Aug 2022 20:57:43 +0800
Message-ID: <CADJHv_tkpQi4F930dS6qadHHR+d5JenfeDzbvAW0okKCMndKkQ@mail.gmail.com>
Subject: mainline kernel fails fstests generic/130 over nfsv4.2
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

It's pretty reproducible for me.

Could anyone look into it? Thanks!

FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 ibm-x3250m2-4 6.0.0-rc1 #1 SMP
PREEMPT_DYNAMIC Sat Aug 20 19:03:47 UTC 2022
MKFS_OPTIONS  -- localhost:/export/scratch
MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:nfs_t:s0
localhost:/export/scratch /mnt/xfstests/mnt2

generic/130       - output mismatch (see
/var/lib/xfstests/results//generic/130.out.bad)
    --- tests/generic/130.out 2022-08-23 07:38:25.769217560 -0400
    +++ /var/lib/xfstests/results//generic/130.out.bad 2022-08-23
08:09:10.121494654 -0400
    @@ -7,6 +7,520 @@
     00000000:  63 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c...............
     00000010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
................
     *
    +0000a000:  1c 1d 1e 1f 20 21 22 23 24 25 26 27 28 29 2a 2b
................
    +0000a010:  2c 2d 2e 2f 30 31 32 33 34 35 36 37 38 39 3a 3b
....0123456789..
    +0000a020:  3c 3d 3e 3f 40 41 42 43 44 45 46 47 48 49 4a 4b
.....ABCDEFGHIJK
    +0000a030:  4c 4d 4e 4f 50 51 52 53 54 55 56 57 58 59 5a 5b
LMNOPQRSTUVWXYZ.
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/130.out
/var/lib/xfstests/results//generic/130.out.bad'  to see the entire
diff)

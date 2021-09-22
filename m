Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78166414D4A
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Sep 2021 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhIVPpq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Sep 2021 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVPpn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Sep 2021 11:45:43 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5CDC061574
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 08:44:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id r1so3033512qta.12
        for <linux-nfs@vger.kernel.org>; Wed, 22 Sep 2021 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ku9FYUG1wNsgKewsZr7yGLbf0XhR2V+eAhlabZddw94=;
        b=AKVhvtvCydFIRgT/tmWkaVYJBKu81XtqHL2No1lxkfBbE4hlx5S46kBpKSEEDAf8xQ
         Ps+vJFgGyrIsisvDoLs8Mydpi/a/GCmhCvyiLeqm4z6hpjFaZZeEYnyNPlZ+aNvR5Dk2
         AIsGHzLTe1CjBo+QQUaIN3tMU7m+yb90m1wl2luxZR1TP/90w1fxBl7Eiq/2FFkUO90p
         K2RnPV64mTShQaUpxrjkvc5U6alSDThgRrXyeD9erioXeZjnY2/S1iyItyaIggB2dOuO
         PAlFj779h50g99nRU3XLrwJXbYJ4I7jaZ7eYvevAS55nI2BlGGyg0s3zmiiEDiHn6Yjt
         JCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ku9FYUG1wNsgKewsZr7yGLbf0XhR2V+eAhlabZddw94=;
        b=Um4OQ32EHesk5m8runPWb1sFUQot/v9LL9PM5crMP8MI+7xkRqISRP2YENhu0mlUfR
         KyL/z9ASfzMKfw33URNO1zEQb7Sy1wTxwuFVO94XA9UpKb4b0CLpsrd9NxVYJzDnLl5r
         UPJWR05K25W+85iBSFeIpIKakvlaavE1oLKu3fVWMLSVgYb/RO1t8g4Kivb41vNHBK75
         n98xFAK46W9KnSieVe6jzhm8aOKGiom2IhMbInNx5UxARtmfEdtUpI5/ribj9WzMpmj/
         +bXqPaXmX9LjC09JdsM8YntVh3LHYKs6QbhJ/KXpJMnLDjItytJv3iO5/iYML1SICKCM
         SCSQ==
X-Gm-Message-State: AOAM532F64vCH1jGGN4Ks0IL39z7YY6KtOHhVQ4n5n8rZEGsQp6aoThP
        aAF4W/Z/+nsGW+fmnit1Dl/prDc/7efcZvXk7EROWbG5xlA=
X-Google-Smtp-Source: ABdhPJwN3YSax72i4QmK36a+I4weG5BVJaCkkUCP+cA/rNTpJovJ+DoRgiibbZXEDI2t/Deg4pkwRrc2ufuVogJ1yhk=
X-Received: by 2002:ac8:410e:: with SMTP id q14mr115335qtl.377.1632325451744;
 Wed, 22 Sep 2021 08:44:11 -0700 (PDT)
MIME-Version: 1.0
From:   Stig <thatsafunnyname@gmail.com>
Date:   Wed, 22 Sep 2021 16:44:00 +0100
Message-ID: <CAD9POpJSfbBYVgupAFxie_N6g2BQAUZ-qWV=tZFMHMJMmdqoYw@mail.gmail.com>
Subject: [PATCH 1/1] mountstats: division by zero error on new mount when 0==rpcsends
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For https://bugzilla.linux-nfs.org/show_bug.cgi?id=367

When rpcsends is 0 this is the error seen when mounstats is run on a
NFSv4.2 mount:

> sudo umount /fsx ; sudo mount /fsx ; mountstats /fsx
...
RPC statistics:
  0 RPC requests sent, 0 RPC replies received (0 XIDs not found)

SERVER_CAPS:
Traceback (most recent call last):
  File "mountstats.py.orig", line 1134, in <module>
    res = main()
  File "mountstats.py.orig", line 1123, in main
    return args.func(args)
  File "mountstats.py.orig", line 863, in mountstats_command
    print_mountstats(stats, args.nfs_only, args.rpc_only, args.raw,
args.xprt_only)
  File "mountstats.py.orig", line 825, in print_mountstats
    stats.display_rpc_op_stats()
  File "mountstats.py.orig", line 486, in display_rpc_op_stats
    (count, ((count * 100) / sends)), end=' ')
ZeroDivisionError: division by zero

Fixed with:

diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
index 23876fc..8e129c8 100755
--- a/tools/mountstats/mountstats.py
+++ b/tools/mountstats/mountstats.py
@@ -482,8 +482,11 @@ class DeviceData:
             count = stats[1]
             if count != 0:
                 print('%s:' % stats[0])
+                ops_pcnt = 0
+                if sends != 0:
+                    ops_pcnt = (count * 100) / sends
                 print('\t%d ops (%d%%)' % \
-                    (count, ((count * 100) / sends)), end=' ')
+                    (count, ops_pcnt), end=' ')
                 retrans = stats[2] - count
                 if retrans != 0:
                     print('\t%d retrans (%d%%)' % (retrans, ((retrans
* 100) / count)), end=' ')

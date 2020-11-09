Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834AA2AB238
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 09:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgKIIMp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 03:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIIMo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 03:12:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D44C0613CF;
        Mon,  9 Nov 2020 00:12:43 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so7366300pfb.10;
        Mon, 09 Nov 2020 00:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date;
        bh=ofdLMk/uvLcTlbAnhbZ/80cGJDHKXudLI4N85AsUW5Q=;
        b=J76FBokT120N6cTACmltyLW6nv7f4of1UpYdicCGgOdt3P+KcX2gid7lUXE7eb92jm
         TmM81eH2WddQ9tk4wqeAEYiFFrcniOBrrGLZmm/XvjX6lDtIr86uyzfYSyWh9ssIi5FT
         5qAYixqRxa6mZooXikP6Vd6X0jfbWH/kPR6cxMwBeoBS6YcG9WxyKsy2O9GJ4T54ehzC
         NAAwNs6n2j8xdzxKmXsL6qfRTAWMkPgGVVh0gUS2aVw+IUf5XpNyWtt0aEuNxu0CY0LN
         aL1FoYnz4EpEHKaxScHiuYWZrxi/ZqPyNkWtzZduh8dlyId+LO2eHKRkMyp+T3jNKQob
         Lqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date;
        bh=ofdLMk/uvLcTlbAnhbZ/80cGJDHKXudLI4N85AsUW5Q=;
        b=SArppXiCPc2SNxo9S7QUVxiUQV1po45uWQ1PNsGXZaCzY+U5E4Eqm14o6cJFHzbLl+
         OgdiO1BBPNk/3ZIvi9xA2C006WOsYOD5J1uwJNJigRU2g9HPYU1T8lCo+eh8FBIxra8L
         k5VJebiKlpIgO7AAzO/YInF/VUzhAY22hJH46s0O2INMG92OreyWdxSGdjunH/ZmXxmJ
         5vQhIlemklIc4WcIq2HZzclXzxzUTFwfc+rPYRYIvvMvWZb2HXG0BZnBR1yB0lTDr8N7
         8tYsX92le9TlZ3REgS0v5auyMD7L7oM0RA2yi6g0eE3+5YBvLgf3u8oc6PdNqXMixBZm
         PQAw==
X-Gm-Message-State: AOAM530p043iPy7EJXol8XuneWOWvMaNklGc7YGdMeHDeKBpGlYsfKgz
        yHpWtH77BQgsQ5ee/qVlpM6/8MwaUGWZ2Q==
X-Google-Smtp-Source: ABdhPJxlJsmpEf4XCVdTXh42kpxlhDpSa8p+njPdI2R2RdL3UzDT+im3e5Z86nM/OXXOjQt1MupHRg==
X-Received: by 2002:a63:2265:: with SMTP id t37mr11659219pgm.387.1604909563183;
        Mon, 09 Nov 2020 00:12:43 -0800 (PST)
Received: from localhost.localdomain ([154.93.3.113])
        by smtp.gmail.com with ESMTPSA id l190sm10001757pfl.205.2020.11.09.00.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 00:12:42 -0800 (PST)
Message-ID: <5fa8f9fa.1c69fb81.5ed63.5617@mx.google.com>
X-Google-Original-Message-ID: <1604909523-59106-1-git-send-email---global>
From:   menglong8.dong@gmail.com
X-Google-Original-From: --global
To:     trond.myklebust@hammerspace.com
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH] fs/nfs: remove duplicate include
Date:   Mon,  9 Nov 2020 03:12:03 -0500
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

'nfs42.h' is already included above and can be removed here.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 fs/nfs/nfs4proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..807fdaeed357 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -71,10 +71,6 @@
 
 #include "nfs4trace.h"
 
-#ifdef CONFIG_NFS_V4_2
-#include "nfs42.h"
-#endif /* CONFIG_NFS_V4_2 */
-
 #define NFSDBG_FACILITY		NFSDBG_PROC
 
 #define NFS4_BITMASK_SZ		3
-- 
2.25.1



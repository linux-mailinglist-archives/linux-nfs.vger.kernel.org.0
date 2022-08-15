Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53B1594E76
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Aug 2022 04:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiHPCF5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Aug 2022 22:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiHPCFh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Aug 2022 22:05:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835C225EC1
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 14:55:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f30so7711611pfq.4
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3u3E1fdxieX84nX6VYAybLmdinIENAWjmqSWIvKaw/s=;
        b=g9u76op5rwpkyjF6FDCo/qjjDiAtYTfQ9DPBmZmr12O8HZKutq768sw//DCKW6pFTW
         wDOv5Knz7sERy8zSe/o9nuyEhwrtnlyWHLlBoHb2kyQdEMEneMOupbob5kVBUC1CSryi
         4QnIDZh4aQs27VzfSnc5SuBO5iaXW/jzsNYh0BqE1+Sm0moCo0hJ5SkbJvN2ST1fh4q8
         zw9oNEvD3zYGHbkaRLpcfIVpNagRy0edf9Q5VmrjaCgXkh0ZTiWCSVAZK8CbWH+0Ii5V
         p4Rq1cWJfzfli66VH6/U003JYWtgJSjEcMhpI2r4TUtz1NlVX39zzYcwRtSAibgMMobA
         4LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3u3E1fdxieX84nX6VYAybLmdinIENAWjmqSWIvKaw/s=;
        b=g8d0aVE5LvJp3io8DGMIK+SnGGrff30NmwzUAOmaM6I2QprupP2vm03qAWC6mPaxhA
         YqB3VXc9YKh2v6ZG2IZU9UrMEe7TAJne8b4DhiPu7dYpglHJz4pdR92NF8GX9Q0Dc57n
         IF6/3ShoMbe6WX6dU1BNowO2q2kei4ilBD/3NadXcMRpCHY7tZQAtN9+w8vtcny02Y9Y
         jTtj9P+/+1e4ok+Wp6Ew4uVVTB4FcTzBNzqSZOpvvHlpoBwpTHAOsKrzEaOn8FM5bfRF
         iyvHHVh5THMHMsAw7DDIl3EtMZtVet+J1GIPLbI+Gl/4EIht4cL5HhFgZ4iND9u5Ay8e
         m+yw==
X-Gm-Message-State: ACgBeo1xuQqk8TyHiJmfZkrzxyBqCO5rw5YLmOzewfq+Fuy3Haze4v7F
        ke75UT7nmRqv/q2EWqFbJvkl7uxjxz+SbA==
X-Google-Smtp-Source: AA6agR48YALf7SCnEY2IWkims/ljTu4Szg6zoqpxT4NyzcA+Xcad1CaY2o7O0JVAi+uDl9SjcJa50w==
X-Received: by 2002:a63:17:0:b0:41d:7ab5:c9e6 with SMTP id 23-20020a630017000000b0041d7ab5c9e6mr15526516pga.493.1660600514351;
        Mon, 15 Aug 2022 14:55:14 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::bb7a])
        by smtp.gmail.com with ESMTPSA id l65-20020a622544000000b005323a1ba20fsm7010198pfl.42.2022.08.15.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:55:13 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH 1/2] Detect warning options during configure
Date:   Mon, 15 Aug 2022 14:55:10 -0700
Message-Id: <20220815215511.2595236-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Certain options maybe compiler specific therefore its better
to detect them before use.

nfs_error copies the format string and appends newline to it
but compiler can forget that it was format string since its not
same fmt string that was passed. Ignore the warning

Wdiscarded-qualifiers is gcc specific and this is no longer needed

Upstream-Status: Pending
Signed-off-by: Khem Raj <raj.khem@gmail.com>

%% original patch: clang-warnings.patch

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 support/nfs/xcommon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/support/nfs/xcommon.c b/support/nfs/xcommon.c
index 3989f0bc..e080423f 100644
--- a/support/nfs/xcommon.c
+++ b/support/nfs/xcommon.c
@@ -98,7 +98,10 @@ nfs_error (const char *fmt, ...) {
 
      fmt2 = xstrconcat2 (fmt, "\n");
      va_start (args, fmt);
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wformat-nonliteral"
      vfprintf (stderr, fmt2, args);
+#pragma GCC diagnostic pop
      va_end (args);
      free (fmt2);
 }
-- 
2.37.2


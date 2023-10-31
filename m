Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB47DCD9C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbjJaNNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbjJaNNr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 09:13:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A1DA
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 06:13:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso4943244b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698758024; x=1699362824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=STEHsHIqCUS5Ww93H+YyBG0a4C6l1Az+Q+2cl36FOyY=;
        b=Vi4nQr79x21H+NOrEEDXR+A3zKL+7q1+spUG3gE4tXzaoRSkuxa94wAqGYAQt+4zTV
         aM0OB+EcJAvUPAHREvg2lp9lYF4s6cxaQJKfr6ODqRm4TCnwWt/6XGcXJ9nTBOqWcEHs
         2K7lPjtWIB6ZXj2r6hz8FyuvgbFOUFwDq0dZ5YMUENafsdxHzfrIiJbfpgHoWuSy1Nme
         LnXXXyUa/UizmuNNe6uVd17A9vD5KyVJbsCMcG+/NXv5u/dlyZ/5YwsFFFitM8wZ6LsM
         3HRy5sQc6HteBOXywQICbdgm5MUXLIHgU/fA0cEkWlSRK7TILGhGgZZQ9ltkGqEoTwe6
         3qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758024; x=1699362824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STEHsHIqCUS5Ww93H+YyBG0a4C6l1Az+Q+2cl36FOyY=;
        b=t9ei8m33ekDni9AYYDIQi07i8yyNq44+uqPnDVp7ihTJrsbRr/tFmqhJUq8NXT97ny
         6Uaio6P3T4QPjWg+UaREqwq4rp4SuqomfP8T/wRs7N2f9nWnjnsOy6p4RKf8bHbqo/MY
         mUMa3v1UdSgK5N3fHRJtmlUZFWP4R60vNsh37i7Nm00g3uHjHHrJfI9dSswbXspEGgtz
         gZN4sDPg1UW9WC5Cp3dmn6bBa4GKbxNyYTdvN7iObwYWLhGfbPyBEBvvPFWTSYBh2Cv/
         QMNFRgDi7KJkUhWcmGsuThTC30ZOimxcmjHaiJoeElvBKqJDr9snsPGjETce5sVTYNQK
         DNCA==
X-Gm-Message-State: AOJu0YywuzNkS1S1QY5LAXq3gdLanM1qbvyUnml8XydbsU2yM1AwMNm3
        He0STmqFPQQ5mG9lwwXaaOQ=
X-Google-Smtp-Source: AGHT+IGkKzzygpVefR//IpiRX1xjnE0bcmpoZs4MqpcjUnHIDfoR/EawR/F0AGpHxM9XIbMV5T4Brg==
X-Received: by 2002:a05:6a21:a106:b0:181:1d71:7e27 with SMTP id aq6-20020a056a21a10600b001811d717e27mr668298pzc.43.1698758024119;
        Tue, 31 Oct 2023 06:13:44 -0700 (PDT)
Received: from localhost.localdomain ([36.142.182.171])
        by smtp.gmail.com with ESMTPSA id h18-20020aa786d2000000b006c031c6c200sm1223746pfo.88.2023.10.31.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:13:43 -0700 (PDT)
From:   Zhuohao Bai <wcwfta@gmail.com>
X-Google-Original-From: Zhuohao Bai <zhuohao_bai@foxmail.com>
To:     steved@redhat.com
Cc:     libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        tanyuan@tinylab.org, forrestniu@foxmail.com, falcon@tinylab.org,
        zhuohao_bai@foxmail.com
Subject: [PATCH v1 0/2]  _rpc_dtablesize: decrease to fix excessive memory usage
Date:   Tue, 31 Oct 2023 21:13:08 +0800
Message-Id: <cover.1698751763.git.zhuohao_bai@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In the client code, the function _rpc_dtablesize() is used to determine the
memory allocation for the __svc_xports array.

However, some operating systems (including the recent Manjaro OS) can have
_SC_OPEN_MAX values as high as 1073741816, which can cause the __svc_xports
array to become too large. This results in the process being killed.

There is a limit to the maximum number of files. To avoid this problem, a
possible solution is to set the size to the lesser of 1024 and this value to
ensure that the array space for open files is not too large, thus preventing
the process from terminating.

Also discovered that some users have taken action on the issue. It is necessary
to address this for all users. Ultimately, we determined that adjusting the
size value of _rpc_dtablesize() and streamlining the existing user code would
be the most effective solution.


---
Changes in v1:
Clean up the existing code in user

---
Links: 
RFC:https://lore.kernel.org/linux-nfs/tencent_E6816C9AF53E61BA5E0A313BBE5E1D19B00A@qq.com/T/#u


Zhuohao Bai (2):
  _rpc_dtablesize: Decrease the value of size.
  _rpc_dtablesize: Cleaning up the existing code

 src/rpc_dtablesize.c | 2 ++
 src/svc.c            | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1


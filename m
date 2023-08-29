Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4575378BC65
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Aug 2023 03:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjH2Bkm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Aug 2023 21:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjH2Bkk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Aug 2023 21:40:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BFB184
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 18:40:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27183f4ccc1so874423a91.2
        for <linux-nfs@vger.kernel.org>; Mon, 28 Aug 2023 18:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693273237; x=1693878037;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GnFUel+kvd/4R4YZk9qE5FTkZ/UipQUz0fqkdEB46XM=;
        b=SM4G6KfKrg0+TY2YgkgOk7NaEZzkvZKIsgewtvGBCD8qFQySPjMiXmLOhAsI7XzGVn
         hDaVKg1w3uhu8CZia2E7vSRO7vcGscXQv4JlP2BIXY3PEPVO9UUVoFR+4lI7Sg3mGBxe
         4sM0KPSZBUmqciEkVuy7LkHNATYlDXb+Dm1O+6Q+LMzZhrtCc03t1G9EYYNq1URJIKnU
         lOpuOaApyPDuKisAK4hs1dbvcwB1wCwXBfYfXBLPJLmiHEu6RPNTpL9Tzv7kYj5fGTiv
         Be67wjhOLGhEP4vQDXnJfL3UGNEzXgveBs1u8b0tMEzlD/oWsRRTfAPo3AXcLjAhHNtw
         a/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693273237; x=1693878037;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnFUel+kvd/4R4YZk9qE5FTkZ/UipQUz0fqkdEB46XM=;
        b=VwY/p/GOLrYBTEsZ2TnS0UoEiXyXVhFC0cWvafIgZwvGxwv7oEuBnEIIo3pYwpBu3e
         VkSFZmHSZ2ng9KkYjt16ec97pxvk/tboICitue0UevXRrWl+Kmf+DmrlYRVdGpxO2GnO
         Cw/2QyM/PYmpOkm5R3HaE3Ns/pN/gXtlFmciIaYZhMQtk1Ifrh9xnMMYRQMoWAo1vAxY
         X2HIzYUE7trbdnw4YuQ7sptYPklr0Gi0U4lmEwWmB4RqeqVIZVI5FyCwvfrnP/N3GA1x
         Ay11nwrop2Y5M9wjIbbgBSdfjINNXsFKZ8ztsQBnjWt6z9BqeKlYlC9hnxZCjVVxHJiu
         JwcA==
X-Gm-Message-State: AOJu0YxyTGhKGh0kAufNSri2Z2R9BRtyU9OXzeoRe806f9T+gif5mNZ3
        gEE8Ig2FfOjXi3M3hNF5h4lJyxHM/fQFmZFZvQ==
X-Google-Smtp-Source: AGHT+IGSEOsIE8/TVhGAkjOdykn59dwTsKl4o47VtRYuHzrJbt7qIJII4WHqFnd6wHQNUy/ZWmWcKKsgJNbjUowVyY4=
X-Received: by 2002:a17:90a:17af:b0:269:c7d:aac5 with SMTP id
 q44-20020a17090a17af00b002690c7daac5mr19839220pja.3.1693273236988; Mon, 28
 Aug 2023 18:40:36 -0700 (PDT)
MIME-Version: 1.0
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Mon, 28 Aug 2023 18:40:27 -0700
Message-ID: <CAM5tNy7Q63k+9+f9zrctZrm-NzCbYn8OjYSirQ8g+g7yLaK9jQ@mail.gmail.com>
Subject: pNFS/Flexfiles testing at Oct. Bakeathon
To:     NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

Tom has a few IETF drafts describing changes that I believe are
aimed at improving pNFS Flex Files layout.

I was wondering if implementations of any of these will be
available at the Oct. Bakeathon?

I have not implemented any of them as yet, but I might have
time to do an experimental implementation of some of them
for the Oct. Bakeathon, if there will be implementations to test
against.

Thanks for any info, rick

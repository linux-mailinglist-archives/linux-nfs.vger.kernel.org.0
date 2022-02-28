Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82084C78C5
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 20:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiB1TZI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 14:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiB1TZG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 14:25:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9ECFEB14
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 11:24:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j15so23086087lfe.11
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 11:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=prmKSGhcv4qkXSHWbirqB8YaQWTkj4DrLEbjqtVeJGA=;
        b=VRUlTi1DP+lNeQPFIJCp9VW8FT3gymY4d/T7w6WwcLl1nuxRrF7n1xOZPJq6vwBWMr
         rufVLWX657GWaH6z5e2snOn2eaArWN5owzyXNpyPGNZVTzqiLMzqIiggK/jNvgXuYMoh
         q4uhaaxvC0u1b7DExtkZdKVbdhooIMi3fvYtXnB7w9xofEMhEpBiHwjkoS+JBPwTDeHx
         OeNmEmpsRLQfNpZ2bd6Z7r3tkoG6VGpDQq7XWI7lN+yrIaqe6fXLhYoJZW2ze9sbkagI
         uj+6NocJKfME9UU6PYxrmYDm81q+PepmNAVPfEmY24V0/shWOMK3yqBBsV+hlhf2e9j7
         MNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=prmKSGhcv4qkXSHWbirqB8YaQWTkj4DrLEbjqtVeJGA=;
        b=jhdeQ4UqjIPDL430RpVft3nnaohVsa1pKBRS+nfzY1KyZ/Amq7H412XievP4reNr8T
         AWKyQZzfijSxM7woCWjmfuxyOk0GHJ4He95/wjSIhU5zel219ge7XIPxX/ECBABCdLUy
         bZTyxkmKzsgs+zgizLKfmPyuMpZeL7+9x382wQ6xSKRcW/RQxqbRK0r4VclbVmoEAI+z
         o+N2C7bg5Qo7OAGpATLJPhD0CJPWCFtpZz3t8+XHtONgdRg8KTK70hJMJEntWPeI6/vS
         Im6G0EXJrBx2+dUJe1do855PzUDgXEZSuZXhfJYlZclI/2fUXdecGsUvWc5kxHg355SY
         hygA==
X-Gm-Message-State: AOAM5339Eg/FvoN70HWzQR4oLP87JucrtSGpSH1KFcLObE331ydz/Df1
        K+uMlRr+8QbL494Kbo0AJk/Ob8f+XTnwWA+xlsTINR133wxtvg==
X-Google-Smtp-Source: ABdhPJx3Wt6GWFijLcknnoqnaLSx+8f1G6Mbc/G+bDrRmUZOZqefCoHY3JltoFIKbreztjb5as9ZMDx6SvXr/YUDXeo=
X-Received: by 2002:a05:6512:2387:b0:43d:165:b5d1 with SMTP id
 c7-20020a056512238700b0043d0165b5d1mr13450596lfv.510.1646076258200; Mon, 28
 Feb 2022 11:24:18 -0800 (PST)
MIME-Version: 1.0
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Mon, 28 Feb 2022 19:24:07 +0000
Message-ID: <CAAmbk-f=Y_k1h-5b3yrGUj36LtL+ZU=J-sC01mrDj83wyKBMkg@mail.gmail.com>
Subject: [BUG] FS-Cache write but no read when using sync
To:     linux-nfs@vger.kernel.org
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

While trying the new FS-Cache implementation using the 5.17-rc5 kernel on
Ubuntu 21.10 I ran into an issue where it appears that FS-Cache was not being
used when the sync mount option is enabled.

While monitoring /proc/fs/fscache/stats it was observed there were high writes
to the cache volume, but no reads:

    IO     : rd=0 wr=344713665

Further tracing of /sys/kernel/debug/tracing/events/fscache/fscache_access shows
a large number of io_write operations, but no io_read operations.

The volume did fill up and perform culling as expected.

When the mount option was changed from sync to async the cache performed as
expected and a mixture of io_write and io_read was observed.

-- Chris

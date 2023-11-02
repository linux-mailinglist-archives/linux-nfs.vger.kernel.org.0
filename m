Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD097DEF38
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Nov 2023 10:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbjKBJwb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Nov 2023 05:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbjKBJwa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Nov 2023 05:52:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23884F7
        for <linux-nfs@vger.kernel.org>; Thu,  2 Nov 2023 02:52:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so1223435a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Nov 2023 02:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698918746; x=1699523546; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xFYaL9TO1Q/V3qSIoxlqaFJhGjawJMl80rZJX7vvyXs=;
        b=KidX53qg8yJ7RkGtUWottQpgllW2CZz8oi3c9hfo4pQw4vYjPvY8VFo3BPgiVUSpyj
         dpSRH7BaMkG/ILSv+HPdn3IqL0zFazeuMUX9lgR4Iic1Ap493hMeavJ+HvsP7q1hN60J
         7su2bb6L/9SRZHhrFozlpLhH2EiHn0QbnzH3mo3aqgsstbqZI2kkXG4d905td1AU5rCX
         uY41hCpJGqUy1AdFokShCd55iBcpAigNW6W2PlYhDx3HgQjniyKqMHgp+a1GpX5osy7e
         a5K0Kgwofij6BBd32x8wFTLPReeira+eQK5DAFXDkfSrVTVbAjlr5NQSzaqWyYv+mMnJ
         lKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698918746; x=1699523546;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFYaL9TO1Q/V3qSIoxlqaFJhGjawJMl80rZJX7vvyXs=;
        b=Wo94nTt/qGk4HFM7vpgq2n/RLnKcL5HK5PXhBTImLuNLMy7Vfsfx0GJ/VACt7Gn3Og
         OnMjErr0o85dnPgKa8Vk4hlnZqUXc7csE2F1UdVBmxkTV3YjsDD5OncJnZneU2aKKvwM
         xrgF9fql0lZy52ub215+sAT57lmk7HD//yGffIWMQlZeRKy4RaK1TRQG4Jp6djZpmMHS
         ARtBN/KiMn3VCPfEvy4AMKgkMvW2Xr8cH0NVp/izeUhsTr+Pwr/+1AuJ1tsgPUMQxUaR
         6zfzgskjkS6vgUgvTrHHQA+FJPxWRPh+4RLKDO1IzvqcfeMaogjSTAoMwmahgYEOpaPy
         UUBg==
X-Gm-Message-State: AOJu0Yw0W6hqlUjRtytUGlSOzXfjkJBdSIqPKVKUMl5MJP8NYzY3RGUs
        DPs7vZxPKiuFBdw5l5LxdDx6xugv/OtjXZPuK7hWyoZMl4o=
X-Google-Smtp-Source: AGHT+IFLdymJwBUxMYpiYRoCsoUH6odcm7zcT8fJckV4PQGOcxQonG2oyLH9Yg7QaGhYny5d83x+Rr/GbIa9l1ld/yQ=
X-Received: by 2002:a50:9f82:0:b0:53d:e139:64a5 with SMTP id
 c2-20020a509f82000000b0053de13964a5mr17308138edf.27.1698918746218; Thu, 02
 Nov 2023 02:52:26 -0700 (PDT)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Thu, 2 Nov 2023 10:51:50 +0100
Message-ID: <CALXu0UeGr80OzF7abqxwR5KFJFhpCuomy2_tdFESAKSiW70jfA@mail.gmail.com>
Subject: Examples for refer= in /etc/exports?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

Does anyone have examples of how to use the refer= option in /etc/exports?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

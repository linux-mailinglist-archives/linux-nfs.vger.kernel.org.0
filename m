Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC770C8A5
	for <lists+linux-nfs@lfdr.de>; Mon, 22 May 2023 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjEVTkH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 May 2023 15:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjEVTjx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 May 2023 15:39:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D3E185
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3169780b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 22 May 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vka/2o5l1FsmD6QMn6ltPo0a4RlZx5eEDRHPQd36/bQ=;
        b=TZp4t9tIX3ZBCHasUB11xMlXPoFE/YMM4EbJwJwSRemcCRTBNDBK8h6PW/aT1uSF3x
         P+4mj1FFzmo6520S/+GPzodFdMfNd2T1lARvMWG3rVxJpBVA8pjhE4IW/oIMjEeuogzj
         TP/9Oi6ni+hbu47KCCC5Wde3MnDVXCijEMJeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784388; x=1687376388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vka/2o5l1FsmD6QMn6ltPo0a4RlZx5eEDRHPQd36/bQ=;
        b=MgnynyYsCN/awQXh38BThyVJEgV1fTJBmdBs6/b2Hk7ixJvNGL5WMuhVxsWi4D/5xj
         ZGhp0A2cM64+gG6tsDhtL8glg4AZBKkALJvPftMX+MeEv4s/1tzu1m3wkICcUH7AUx9p
         +JlcxQynrycY+5u2Fe6uLPcdoaVnucPfYeKLQHyuM9SdaO+tY/L1UYZuusLGfHcoByWt
         vdVHa1JqXwrJu9O4RryOAaJqMS2X/H4F1if2UfWjt90u8ATqlTRwcchct1olAEbc2eEk
         xLl+BX5f+mRgO1jIBU2RfH8YeKY/Xkfb9hilkQR1J5mU3UhW3sO1e0AXuzgnn6ae9RTo
         8d9Q==
X-Gm-Message-State: AC+VfDzs/E9q+X/V5sr9gvwG6S+q+Vb/iV0UNpjR9YdsVIJf+A/hwWDW
        zoRRM/RnTxJDQ96a52aQf7FiDjqC+7/sQ2PbSs8=
X-Google-Smtp-Source: ACHHUZ6SbNlGLkUA6HPZC11hSL0Hrdf6KCW7w4l7XaDQgUFWkyMLraB82uNVGBe8si4gmo0FNKbc3Q==
X-Received: by 2002:a05:6a20:9384:b0:101:5171:c880 with SMTP id x4-20020a056a20938400b001015171c880mr13180755pzh.62.1684784388330;
        Mon, 22 May 2023 12:39:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v5-20020a654605000000b0050f7208b4bcsm256080pgq.89.2023.05.22.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     azeemshaikh38@gmail.com, anna@kernel.org,
        trond.myklebust@hammerspace.com
Cc:     Kees Cook <keescook@chromium.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] NFS: Prefer strscpy over strlcpy calls
Date:   Mon, 22 May 2023 12:39:36 -0700
Message-Id: <168478437620.244538.12858579380072843624.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
References: <20230512155749.1356958-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 12 May 2023 15:57:49 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> Check for strscpy()'s return value of -E2BIG on truncate for safe
> replacement with strlcpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] NFS: Prefer strscpy over strlcpy calls
      https://git.kernel.org/kees/c/8ca25e00cf81

-- 
Kees Cook


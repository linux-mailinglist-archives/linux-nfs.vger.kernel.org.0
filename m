Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5357E7FCD
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 18:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjKJR6s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 12:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjKJRzi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 12:55:38 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F92659E3
        for <linux-nfs@vger.kernel.org>; Thu,  9 Nov 2023 23:44:00 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1e9c42fc0c9so850221fac.1
        for <linux-nfs@vger.kernel.org>; Thu, 09 Nov 2023 23:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699602238; x=1700207038; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVx6XZHt5smtzocTTRvDCY+WME9yo9xYZa4h8WqubJg=;
        b=BTo6OHoUhMapE5iilNNHDSYt3+qvigxh3dhpVTaWJeGVJAcQRVKj4ohpq8Kyfj0snx
         KwJCYpYKAQks5utx15k38gHy4N2T+rOjKTO8KVHGU7qxArG96EHKzk1zlpG2kCmWam5s
         ySxtG1Kb4vujZtGY+JZVx/PLuK6Yo29UgnHt9u9zq8F11V9VR+i+D3Cu5rk5jjV/nDJL
         sBm8Vwkj2+TxLupbPcSM8yFQPVd7EiRoGXBsDoivQKJCg2GegwB0RiyAcQBYHt0Z2GY8
         RsSreM6Eh/iI2yJk28el5Wok6e0sguoqf7s02mDx8apw789zWwBW7sFSyi/mR+7P2+H9
         FSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699602238; x=1700207038;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVx6XZHt5smtzocTTRvDCY+WME9yo9xYZa4h8WqubJg=;
        b=cJxx+eME+bfQg8MNx5BXqUo8qDYBGuoTfZ+xZE8KuOXR1iUB2xPZsSWefjRL2Mypj8
         tXkKVLLP0ZJe1WSCTTlQnEdLMq6p5iSvUZoe7zu0ePyVjpwKmfifeFo6QN2Pu1d8rfsc
         lRaxmPzIR6py5IGvg+K0iSuGJhSnvtNB6yvJGJr3CZQWC5gfN2z/ydxAhj8IHwtg2/eZ
         4fwYR5OQzejnHXLTcKJ+dlZtgoMnpf5C0RcqVRnYhF2QVwgm565EjERbQfaWf2s+Gr9X
         ZPSj5EmX9Jl9JWd6nHhyu5G8sokvnNuDWl/gRSUWZs5IZ0TwPFv1Tm/wXLUnjj07sOFg
         YTWw==
X-Gm-Message-State: AOJu0Yy9B/aFbDrNoLw2uAZJHGhCBRxF33jbT/lGtM+rBkFmAOZvTI/3
        NnlCxjmWmLR5JcM5NUjh4/VCk4pwyJKDF6FWLYz78p8O
X-Google-Smtp-Source: AGHT+IGrDj3tU7ASJA8766YHhFvFjeqQurQqtPM3VR0NhM86kuwi8gZpA7mi8X6AGGyqslasZ+jSPbDVIplpPdP40I8=
X-Received: by 2002:a05:6871:6b9c:b0:1e9:8885:b537 with SMTP id
 zh28-20020a0568716b9c00b001e98885b537mr6530683oab.41.1699602238558; Thu, 09
 Nov 2023 23:43:58 -0800 (PST)
MIME-Version: 1.0
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Fri, 10 Nov 2023 08:42:00 +0100
Message-ID: <CANH4o6MqecahkZj3i4YwS1UQjQimFrDcbM8abCbrGiLyk9ZTkg@mail.gmail.com>
Subject: Filesystem test suite for NFSv4?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

Is there a filesystem test suite for NFSv4, which can be used by a
non-root user for testing?

Thanks,
Martin

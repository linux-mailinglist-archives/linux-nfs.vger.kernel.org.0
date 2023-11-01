Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBC47DDE29
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 10:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjKAJI6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 05:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjKAJI5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 05:08:57 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802CCB9
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 02:08:55 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dceb2b8823so346981fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 01 Nov 2023 02:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698829734; x=1699434534; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UNUIBClrAKcRYro4PH0vXCj2G1DvHhZIqV9/mvOOKAQ=;
        b=es7o3Ku3noA20UlcadUebuQx1yaRJtnejNV2V16Ng6I958ZgJAFB5mXJri7vBJKwrr
         MIn1wICLRd+ta77RkxyEpEyNvxjWaa1JYoclpnIjvX77mC2CjAyrEn0AInvdhq+CsX5O
         oKrCJgXk5gv0OVJPE5q8etSycha5QkHtGUZsKDy++jp9hhFaArQvVmH6pEZNarZZ7zff
         QZi37ul5BfhzJhibtlbeZWGx2evYeQmgliR6HSpbLp4HDIx4Z5Ttr+twI0X5gUL8E2Lm
         SyJhDa8T9g9nkJFy8749WTUngHGkkvXF1mNx4LzyOZxfCL9YoOkt7g8HE+hec5eQ/WsM
         llwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829734; x=1699434534;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UNUIBClrAKcRYro4PH0vXCj2G1DvHhZIqV9/mvOOKAQ=;
        b=FFC5IRy95D+hIBhbq90RxeioIUu2NSW2S6tXFFZTvOB9ZiuTq7SdjM6Rg7y1LxxaKG
         dV624bHp0ZY8c8SDItJWkxRXFzEO1eAQ9zDe8/e1s2Lx+oVhER3p/mrvxMqSXgG5a+6t
         4EEPXRZ6ghbqJoYFaWPKQZFxiQkyd3ZYHy2pW071WNdcuCtmfEbtDkMwVDEShH2M6+P6
         YMrYjKPNsveZHOa1mmShF7NqyKGkc7bn2Ne+SixHSWZNO0VeCgI86+K2kQj2Up0DEY/7
         jUO4Qd5A4NwM07BCrsCYFdTvRTLb65xO9D2DxYGPetPfQjJ1E3VdsxgivsZMORjABWvm
         kwvw==
X-Gm-Message-State: AOJu0YwBqaQqK8kmgL/4o4K2WMGct9PpgXirKyxOh73UtHJJ0DTAYJUW
        vWhDY0rd3YrPw9WWryDS9LbENP0Mjup9UPBpRUGBw49F
X-Google-Smtp-Source: AGHT+IETK3JacYqeVdqZqYgLlkkK/oYOmq/HRoiJoNkdfF3eNaUjlifS8vQ7pCofnCcaELd0haltsWRTzPybZhjOj5M=
X-Received: by 2002:a05:6871:50a:b0:1e9:cc21:295f with SMTP id
 s10-20020a056871050a00b001e9cc21295fmr3205718oal.16.1698829734621; Wed, 01
 Nov 2023 02:08:54 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Wed, 1 Nov 2023 10:08:43 +0100
Message-ID: <CANH4o6POxEyCYW0dY1FAEk518b3aGwVp5qogMMHqHR1Ukfg8yw@mail.gmail.com>
Subject: Status of READPLUS support in Linux 6.5 kernel?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

Is NFSv4 READPLUS usable in a Linux 6.5 kernel, for a NFSv4 client and
NFSv4 sever?

Thanks,
Martin

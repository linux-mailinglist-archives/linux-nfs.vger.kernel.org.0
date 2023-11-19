Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63C7F07CB
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjKSQ6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 11:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjKSQ6e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 11:58:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DAE10DC
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 08:58:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548a2c20f50so693328a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700413099; x=1701017899; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEcbxEQEfBpl3+bHkXssJgEzvMmhKKWZFxHarqxi6xw=;
        b=iHS53xU3H1SYoOjkAscbLKrS70NqtmRMWnp/eDiMQ8Xyij5mKwkkNTYJTN+RM5Yadx
         GddNj2wPIekT+4qyucuFTlu98isD5YSBk3qnrGfoliHb6C7A9JHzgFVw8XO8JNdd/Xtg
         TJ/u5OZMZUMux9fWuMWmBwBjqDy/Vf9Dmi/msqd+H/+wjvqcQ4yAOjcsIeNpd4riQY2L
         Ldbqrn3hvkDBWp39Y9/GulEwqEUYX3Yh/NOiHyuSEDJoChEZA9NDD4t++Z0f59F6a84J
         aKsvqNLnwx90jzKvju66rc6FxUOPl4ote+wu8m18VKfcfntkUG9dSSzREr0KXO9vV/9c
         ezMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700413099; x=1701017899;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEcbxEQEfBpl3+bHkXssJgEzvMmhKKWZFxHarqxi6xw=;
        b=ZjpULeZQUjharBuyAPyqi1cqlZB9yj921UdauRzQ+16CzvFogjWobo3fDtdx7mE+fL
         vNn0Ir+19spQ84nvah+iVKuIE6Vjzg4lHtAHngSfKzmXv51HaQUnWfFNVHkOZv3bh4Mu
         IumferQ8RyOv2eNp50beiwquZOREjEbL8YSDh32uzfA3pof6bT1PVFGuZbWiKpT+TSNb
         ha1j8HZITBz14rpYupVvj4quadjzKwLPX8p6tf4iB0DRZCGizbE+Fdlm+hkwjOfFTpvY
         HODyJuT3bXTelueqjrOqSQf9qQlOpAxNSBXqcz1I9Hhs4GShLnRvoMMoDK/MT/Gl5u24
         n+Lg==
X-Gm-Message-State: AOJu0YzYxl4OkRCm30yKY5dGcZDQ31ifDPW/W1kfEpb6AkYy+Qs2mR8s
        nWc9rGTy8di/kTfuS/wIMeyoSn20X4Q4OgZXNcMFYxNV
X-Google-Smtp-Source: AGHT+IE55TLyhA7GKoXitxFvbAZtBB1GW9ki9lLkYjkULGYXR3jXMnPH355W/nN7oKgWrGZHXygLD0cfj3iblhn07jk=
X-Received: by 2002:aa7:c308:0:b0:542:e844:5c9b with SMTP id
 l8-20020aa7c308000000b00542e8445c9bmr4164739edq.13.1700413099299; Sun, 19 Nov
 2023 08:58:19 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UcwVRxbG9HD_0U2oK5Le53F3NKQz_H4P4nEesnoWM=BRw@mail.gmail.com>
 <d6c218f85f314f28ba94726038782ffada3a2e01.camel@kernel.org>
In-Reply-To: <d6c218f85f314f28ba94726038782ffada3a2e01.camel@kernel.org>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sun, 19 Nov 2023 17:58:00 +0100
Message-ID: <CALXu0Ud2-nrnTLazGXhkvQW+PPuo1xePxG0D51aQDv5BXFaUfQ@mail.gmail.com>
Subject: Re: NFSv4.1 --> NFSv4.2 client implementation?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Sat, 18 Nov 2023 at 13:01, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sat, 2023-11-18 at 08:53 +0100, Cedric Blancher wrote:
> > Good morning!
> >
> > What are the differences between NFSv4.1 and NFSv4.2 for a NFSv4
> > client, if we ignore server-side copy and READ_PLUS support?
> > Can a NFSv4.1 client then identify itself als NFSv4.2 client?
> >
>
> Yes. I believe that NFSv4.2 consists entirely of optional features over
> NFSv4.1, so it's legitimate for a client or server to advertise itself
> as a v4.2 capable, but support none of the features.

Can anyone confirm this? So NFSv4.2 does not require protocol minor
version negotiation, or how does it work?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

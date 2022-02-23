Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C74C1A53
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 18:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiBWR4u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 12:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiBWR4u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 12:56:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B322736
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 09:56:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cm8so35882294edb.3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ByiuCoSwOL6j4AWnP3EMGrBR1eaIQtH2W05Dis2JlgI=;
        b=njnwhagoDH7CrZKHv1cweb/woGXsKeGjC9pc0Bn12THwtGuAZfycZXgQb3mkPy8Hw4
         0Z0iUa5b/jwxQKxxvLS7bRvML3pwg8q5xq82DvM2XiQl4j71KRXdfxIv7erDFS3TaeH8
         zm0NMyywvtKBLgA8ZBUMna9CsErqAknubuQqnV068XOlenYb8be0zTZyyvCZvHepuNKJ
         87g8PTGCTjh8NWvv9MDzTwgk/kFFOi47qP7nStOWKci5Mb8uXLRSk/pS4p+AbNlB3O7b
         KPMuJtDzxSDMYEgvBWwar/2pSmDyxVzlK2gcEs0TkKRW8GujGz1kXU2GS6v4ktiAEWFQ
         v6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByiuCoSwOL6j4AWnP3EMGrBR1eaIQtH2W05Dis2JlgI=;
        b=HLkpl2YrHiQ6YmbOr/bF4UjZH5AysK47OuwGwvgTlM4ThbJ2ZVe1a/mJprv96gDwXF
         /duhbjvo5QmESnjwtkxBnRm4vM2BtHvhhl5vOHpv0pl0goKunEH58TM3DRqWcEAXhz2O
         fA9HdS2OzEtrVLu0jswocI3Csj0EXOMJwbLUI/SlY8M57da3vk25y3F/czPZ/ir9CMbE
         f1ncdPnO2AguzUnfnWXmU/nYsirZowoeQvz2OhEOGZ5RPc5fVf3qsO6cV0BgcQ1Doj2U
         B0gwKeGJfYuxQbaOaHm4k2IbnmOdXqsFI4WO58uKBBPi/Lo/LQudooASvcoqcIHhfG/9
         a2xg==
X-Gm-Message-State: AOAM531FU149/QvA7d7xbF+N3EbpJ97dThh9vLgHcQDUz3e/JwQJvWk+
        IwPT0qRONtlor8s+KjO5oaDdx1ZVwuJ25eHaWENuiQkU
X-Google-Smtp-Source: ABdhPJzI7MRLcVgKNSQhD4L4V+p4d5kSTC8RwvazhCTcrvKlY8zkxOvvitytOMWLrMkOJ73phJNoNXa54e3nbrmFKs0=
X-Received: by 2002:a05:6402:22ec:b0:410:9214:6dae with SMTP id
 dn12-20020a05640222ec00b0041092146daemr582996edb.372.1645638980691; Wed, 23
 Feb 2022 09:56:20 -0800 (PST)
MIME-Version: 1.0
References: <50bd4b4d-3730-4048-fcce-6c79dfe70acf@garloff.de>
 <8957291b-ecd1-931e-5d0c-7ef20c401e5d@garloff.de> <F693AC98-DCB4-4086-AC19-EE1B71DB2551@netapp.com>
 <be851303-b1bb-7d8d-832e-a1a3db529662@garloff.de> <10d55787-7b97-8636-9426-73fdeda0a122@garloff.de>
 <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
In-Reply-To: <6401c5e1-8f05-5644-9bea-207640a21b77@garloff.de>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 23 Feb 2022 12:56:09 -0500
Message-ID: <CAN-5tyG+CiPVi=wQDvMp0rWyt9TgCYnb_1_g_TYQSrxEFz7sAw@mail.gmail.com>
Subject: Re: 6f283634 / 1976b2b3 breaks NFS (QNAP/Linux kNFSD)
To:     Kurt Garloff <kurt@garloff.de>
Cc:     "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Schumaker, Anna" <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
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

On Wed, Feb 23, 2022 at 8:20 AM Kurt Garloff <kurt@garloff.de> wrote:
>
> Hi Olga,
>
> any updates? Were you able to investigate the traces?
>
> Breaking NFS mounts from Qnap (knfsd with 3.4.6 kernel here,
> though Qnap might have patched it),is not something that
> should happen with a -stable kernel update, even if the problem
> would be on the Qnap side, which would not be completely
> surprising.
>
> So I think we should revert this patch at least for -stable,
> unless we understand what's going on and have a better fix
> than a plain revert.

I haven't commented on your ask of requesting a revert in the stable
version. I'm not sure what the philosophy there. I don't see why we
can't ask for this feature to only be available from the kernel
version it has been accepted into and not before. If you think the
kernel version that you want to use will always be before this feature
was accepted, then asking folks responsible for "stable" kernels seems
like a good idea. At the time of inclusion to stable, I wasn't aware
of the broken legacy server implementations out there.

>
> Best,
> --
>
> Kurt Garloff <kurt@garloff.de>
>

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D46D4E7D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Apr 2023 18:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjDCQ5c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Apr 2023 12:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjDCQ53 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Apr 2023 12:57:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D9EC
        for <linux-nfs@vger.kernel.org>; Mon,  3 Apr 2023 09:57:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id cu12so19620852pfb.13
        for <linux-nfs@vger.kernel.org>; Mon, 03 Apr 2023 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1680541045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBz1pk/5SBE58dXFmTYNeO1tLW+cVeVrWxWstO6am4o=;
        b=hzyxekJeWG0rYzELrVRQsBnVjdFUsqeqzXk8AlsDVntI0N894CbRQ1RPJAEBGr9trv
         3itG4yCEtmfDi5e+p3U2nosi9EFfMgkxkMr3BVt0WJ2wYCA3OPCtB4EsR4EGgaayUpuh
         JJLp3CmoM67LaTTckeRv0P0pWAWKBL18p8E+bHHvEEh8JgGXLS7WmlZqiqpXkF/nPp5O
         Sk9y8GS/aN8GDbUdIaYuC/qKER6a21//pqlsvFdc/yHiqjXjuCdXJ9v56T4fvFvgEORh
         FHCV7HdAqf4uWMeIVOHwMvbGpjp4Qo12DHEvUWYEUFT3/ALkP9tuAlpldSykhgxy7Xm2
         4fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBz1pk/5SBE58dXFmTYNeO1tLW+cVeVrWxWstO6am4o=;
        b=kCTGIuA7xZTodHXt/jt37FdGuBdtGbEWHu1mgh4AI2J3PlSN5NYC/M/oaIai4gf62w
         K+MIyk0YTjGqpx6w6oW982MgXta64WFKltLfDpdkdxDdMW1A/mZbHokfeH9MNzop8kmH
         ufb9CtIGx14X1eetpLXxc6aH0E621tq/nfHPg7+HMbO7J2cYhuOjUSmvxC5LbE8Y1FW6
         F+wmG4xrnqt7UgGX20lfpMud3hrd0hGToHXJIcY1pA9WOUF2/1i/oTxE+ypQN9K7hAts
         5hHhvzNsX6Io7nAJAzz2P2yeEF0Nphknk0o8qXZF9lCpVk2Ac0sOukjIqfCPeY0Ldx9d
         o6jw==
X-Gm-Message-State: AAQBX9eq7aDunBllGGm6Oy/jRjo53cW5tLHf4XMUvJK2VW7Z0u4yPWUY
        btkHx/Pmpu6grP9lUVukx4076FYmxu2G/aUJwMrxF5cF
X-Google-Smtp-Source: AKy350bKU/ZEMd1Spw3gf0FP4oyJ7kpzzKJWmBKOGHn5Iu1hWyViufFcNo9fl3+dUTLVYe7Y57y5fASOpeh4vxZmrTo=
X-Received: by 2002:a65:5ac7:0:b0:50c:bde:50c7 with SMTP id
 d7-20020a655ac7000000b0050c0bde50c7mr9791248pgt.12.1680541044832; Mon, 03 Apr
 2023 09:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5tNy5T1-K3oH7TLeUG=F3V8u_aRhcvMEJkkaV7wj+5vqqq_w@mail.gmail.com>
In-Reply-To: <CAM5tNy5T1-K3oH7TLeUG=F3V8u_aRhcvMEJkkaV7wj+5vqqq_w@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 3 Apr 2023 12:57:09 -0400
Message-ID: <CAN-5tyHt6dxBAO==RgDB6fBOBimE5jP6ZbY-AFDwBCbfOREUeA@mail.gmail.com>
Subject: Re: sec=krb5 feature or bug??
To:     Rick Macklem <rick.macklem@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Rick,

That's by design (rather that's what spec says? It may be rfc 8881
2.4.3 and probably somewhere else that ops that are done with machine
creds must use the same gss flavor? ). All state operations are done
with sec=3Dkrb5i (if kerberos is configured on the machine) and then
other operations are done with whatever flavor was specified on the
mount command.


On Sun, Apr 2, 2023 at 7:24=E2=80=AFPM Rick Macklem <rick.macklem@gmail.com=
> wrote:
>
> Hi,
>
> I've been testing a Linxu 5.15 NFSv4.2 client against a
> FreeBSD server to test recently added SP4_MACH_CRED
> support in the FreeBSD server.
>
> I noticed the following oddity, which I thought I'd report
> in case it is considered a bug and not a feature.
> I do a mount like:
> # mount -t nfs -o nfsvers=3D4,sec=3Dkrb5 nfsv4-server:/ /mnt
> #
> - When looking at the packet capture during the mount,
>   the ExchangeID, CreateSession and ReclaimComplete
>   are done with integrity (ie. krb5i) and ExchangeID uses
>   SP4_MACH_CRED.
> - Then, subsequent RPCs do not use integrity, as I would
>   have assumed, given the "sec=3Dkrb5" argument.
> However, some subsequent RPCs in the must_allow ops
> list for SP4_MACH_CRED choose to use the "machine
> principal" and do krb5i.
>
> It just seems weird that it mixes krb5 and krb5i. I had
> not expected it to use SP4_MACH_CRED when
> "sec=3Dkrb5" was specified.
>
> However, it seems to work fine this way, so I can see
> the argument that this is a "feature" and not a bug.
>
> Just fyi, rick

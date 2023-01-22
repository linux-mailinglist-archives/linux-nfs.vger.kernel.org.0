Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D66772FE
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Jan 2023 23:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjAVWZu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Jan 2023 17:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAVWZt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Jan 2023 17:25:49 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E1C161;
        Sun, 22 Jan 2023 14:25:45 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id u7so5496774qkk.10;
        Sun, 22 Jan 2023 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WygAl33w+iMK15USTl298iK4yDMv4KXexC7/yW/BX0=;
        b=HPZtFhTkRjlLezqYHPPZiIgC3hgRHL398qc6v0uJrtqC1O8WPNPER2Zq8WEgaZC3y6
         LNRWKhKse8nupbvht4lZMz1C76WC5zr0erfe0AQQ9sS6zkT1v+hL95i4LX8NVEkkOO6Z
         5C16n8YbC4Rmo6m3pS1vC4LF3JSLzxwd/d0XPUnegrSjFLriT/Uc356iKox4KTuo6RWp
         hdNy/fJz7ZbHxUcjUZQSSJj2grDLCua8g5097iJKAnSK6NB0iPBowjv3Ih7dcaYHONWV
         8IvZ6lboQRsj6GWS6V3B92LJX6YcXgt2z46lJYATg7sXYd8gsdqw6duIR7fF0vXNxe+i
         mvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WygAl33w+iMK15USTl298iK4yDMv4KXexC7/yW/BX0=;
        b=TLXWimgpSB9DSub/0gzPpXlOTeHPjTIuIIDceX0Jypq5MDsRQOX9ak9aI/6u538qkv
         1jp+rnJewVySJdhtPM/YbjOxoDpiklwYT1HMOERMpnvw4by9/vTwTWzZ0s3OpxC3r6xD
         X9mwfQyDkHD5o9Ya72YYWCFVP8bgXhXO36PEebCcV/RpigBERsyTXa+vYYq6HM1c7d8D
         6TsK9naSWercT6EHo34Cgq4BdL/6WhGarsinnLpHRgyZcHwBQSmvycfROuT8MtCYtg0X
         EOS4mH4FFi4C9D5ihLi6h/XjnLXs4ggr9QmcHMW76iMUCxC59nEMpDGJQ3JqqUGviRC/
         Hk1Q==
X-Gm-Message-State: AFqh2krz/tGTPgN+LDyMMLvBe9qNITbAOBBwMK8RsRcseeqJUbvVmW64
        wiiJgLHR+RJA+NtHAt2b13kQlp341SdG8iYMi5c=
X-Google-Smtp-Source: AMrXdXvGKkVnTOlZdplVUdQiF2PQzHoyQ3QmYU9bQPG+XHHF8NCH6BCEXb4yG2ukWa51OgRBPQCHU7TpvxfVA/jzoNA=
X-Received: by 2002:a05:620a:95b:b0:702:1507:2106 with SMTP id
 w27-20020a05620a095b00b0070215072106mr1212544qkw.21.1674426344807; Sun, 22
 Jan 2023 14:25:44 -0800 (PST)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
In-Reply-To: <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sun, 22 Jan 2023 17:25:28 -0500
Message-ID: <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Krzysztof,

On Mon, Jan 9, 2023 at 3:46 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
> > On 08/01/2023 18:09, Trond Myklebust wrote:
> >> Hi Krzysztof,
> >>
> >>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@li=
naro.org> wrote:
> >>>
> >>> [You don't often get email from krzysztof.kozlowski@linaro.org. Learn=
 why this is important at https://aka.ms/LearnAboutSenderIdentification]
> >>>
> >>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
> >>>> Hi,
> >>>>
> >>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the default
> >>>> KConfig value for READ_PLUS") as one leading to NULL pointer excepti=
on
> >>>> when mounting NFS root on NFSv4 client:
> >>>>
> >>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
> >>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: Inv=
alid
> >>>> argument
> >>>> [   26.199478] 8<--- cut here ---
> >>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
> >>>> virtual address 00000004
> >>>> ...
> >>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
> >>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x178/=
0x358
> >>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
> >>>>
> >>>> Full OOPS attached. Full log available here:
> >>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
> >>>>
> >>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the commi=
t is
> >>>> not the cause, but rather making it default caused the regression.
> >>>>
> >>>> I did not make the bisect yet which commit introduced it, if every
> >>>> config includes NFS_V4_2_READ_PLUS.
> >>>
> >>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed to=
:
> >>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
> >>>
> >>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
> >>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>> Date:   Thu Jul 21 14:21:34 2022 -0400
> >>>
> >>>    NFS: Replace the READ_PLUS decoding code
> >>>
> >>>    We now take a 2-step process that allows us to place data and hole
> >>>    segments directly at their final position in the xdr_stream withou=
t
> >>>    needing to do a bunch of redundant copies to expand holes. Due to =
the
> >>>    variable lengths of each segment, the xdr metadata might cross pag=
e
> >>>    boundaries which I account for by setting a small scratch buffer s=
o
> >>>    xdr_inline_decode() won't fail.
> >>>
> >>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>
> >>> With a trace:
> >>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
> >>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: Inva=
lid
> >>> argument
> >>> [   25.986237] random: crng init done
> >>> [   26.264564] 8<--- cut here ---
> >>> [   26.266823] Unable to handle kernel NULL pointer dereference at
> >>> virtual address 00000fe8
> >>> ...
> >>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
> >>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
> >>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
> >>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x790
> >>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
> >>> [   26.625570]  worker_thread from kthread+0xf4/0x128
> >>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
> >>>
> >>
> >> Is this test being run against a 6.2-rc2 server, or is it an older ser=
ver platform? We know there were bugs in older server implementations, so t=
he question is whether this might be a problem with handling a bad/corrupt =
RPC reply from the server, or whether it is happening against code that is =
supposed to have been fixed?
> >
> > I would say that buggy server should not cause NULL pointer dereference=
s
> > on the client. Otherwise this is a perfect recipe for a rogue server in
> > the network to start crashing clients and running exploits... Imagine a
> > compromised machine (through some other means) in a local company
> > network running now a server with NFS share "HR salary data" or "HR
> > planned layoffs", where unsuspected people in that network access it
> > leading to exploit of NFS code on their side...
> >
> > Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
> >
> > Which points that it is not latest stable, so anyway I need to update.
>
> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
> latest stable and I can reproduce the issue. Therefore:
> 1. It is visible on two stable (one new, one old) kernels on the server,
> 2. Buggy or rogue server should not cause NULL pointer on remote devices.=
..

I'm still working on this issue, but I haven't been able to reproduce
it with my setup at all yet. I was hoping I could ask you a couple of
questions?

- Are both client and server run on a Raspberry Pi 3?
- Is there a specific workload that triggers the bug, or is it just
during boot when using nfsroot?
- Would it be possible to get a Wireshark network trace of the crash
(you'll have to run this on the server due to nfsroot).
- Can you share your export options from /etc/exports and the mount
options that the client uses?

Thanks,
Anna

>
> Best regards,
> Krzysztof
>

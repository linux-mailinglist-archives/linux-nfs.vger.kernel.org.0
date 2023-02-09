Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4369103D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Feb 2023 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBISWn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Feb 2023 13:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBISWm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Feb 2023 13:22:42 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245086031F;
        Thu,  9 Feb 2023 10:22:38 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id cr22so2958831qtb.10;
        Thu, 09 Feb 2023 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/1gTmVnySca8jPan+vw+HB1wn9UVQIEd+iLChgEFuM=;
        b=HSpP2//Xd6RTJQFb4fyXH7eYu+tbzxXV4ccX5E75RJiLGZEVvFw4b6g6w/fhlS7D+T
         JJS2DBYg/x8vbWzMcUDyj1rzXvrG8ha/9eCPq7GsYt/7r8vr9iD9DAf0z3EFORUzI4k/
         UrkfeOLF5Ypxf3bx7/iJ+qpdqcODQ0wxXTedHSfH3Gnjg4yDeLEvLMIfXPj9mhIbEJmV
         p2Zm55OTki21fn2eodcvgURT5ZjXqQBC5sjWmfWJKxTewQtC2XDuKW+v3X5UVOy7YH59
         jLM3u5Fn4pyrZiswtzx5/s9Q63TPLVpDcF0FYEU6Meb4bizZHHmgJxLaMRu6Nx7n64N8
         w/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/1gTmVnySca8jPan+vw+HB1wn9UVQIEd+iLChgEFuM=;
        b=Fc9Zq3/S8WTUKCyNA4VeHUSUIg1frGdtWCGQa0wdsjStA6gNCHUMZ50Khr6zwl9KGq
         SVOdk/R92lVvPPUwn+ufPvKLOamTDyFD2Dk/hw4kyQM0RC6iiv+l9fdrF6gdp3zs7uB4
         7o8LKObbpnliB8iG1wl64Qd6OBYfdAayYURTRMQr9SzJBSFVKc9ALpGlEI9W0hfezNFc
         Km+7rFOI5YDu/aqfprKehDbzgW1t5za1drxqlm6mufc+G7i9gFVjVbdUTKEdEXDEeyh3
         0gyaBVMcROTjd+8iqGR5ni6KfAbShT6LcU0YIQalpbo/uYJqc6FDvNHG2tT2gdT1F5+Q
         Gmow==
X-Gm-Message-State: AO0yUKVadmHOS8Hlcmb7uwVompcKef05OAQRvRBlkeiG5YZ6wPlWC9N0
        yMaMwSS9HNirY1g7ATWC0JBqIVcPqHByybMA/2I=
X-Google-Smtp-Source: AK7set/J4dF2RFxj4FVay1hvmCp/e6kKQ5Md7umeDye5D5FVkwQg0r1w8z5RxTfk99ESqGjGKzn7pzXar80TSis0cLM=
X-Received: by 2002:a05:622a:4cd:b0:3b9:b260:1e95 with SMTP id
 q13-20020a05622a04cd00b003b9b2601e95mr1918775qtx.378.1675966957090; Thu, 09
 Feb 2023 10:22:37 -0800 (PST)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com> <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org>
In-Reply-To: <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 9 Feb 2023 13:22:21 -0500
Message-ID: <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Krzysztof,

On Mon, Jan 23, 2023 at 2:58 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/01/2023 23:25, Anna Schumaker wrote:
> > Hi Krzysztof,
> >
> > On Mon, Jan 9, 2023 at 3:46 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 09/01/2023 09:14, Krzysztof Kozlowski wrote:
> >>> On 08/01/2023 18:09, Trond Myklebust wrote:
> >>>> Hi Krzysztof,
> >>>>
> >>>>> On Jan 8, 2023, at 08:25, Krzysztof Kozlowski <krzysztof.kozlowski@=
linaro.org> wrote:
> >>>>>
> >>>>> [You don't often get email from krzysztof.kozlowski@linaro.org. Lea=
rn why this is important at https://aka.ms/LearnAboutSenderIdentification]
> >>>>>
> >>>>> On 07/01/2023 16:44, Krzysztof Kozlowski wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> Bisect identified commit 7fd461c47c6c ("NFSv4.2: Change the defaul=
t
> >>>>>> KConfig value for READ_PLUS") as one leading to NULL pointer excep=
tion
> >>>>>> when mounting NFS root on NFSv4 client:
> >>>>>>
> >>>>>> [   25.739003] systemd[1]: Set hostname to <odroidhc1>.
> >>>>>> [   25.771714] systemd[1]: Failed to bump fs.file-max, ignoring: I=
nvalid
> >>>>>> argument
> >>>>>> [   26.199478] 8<--- cut here ---
> >>>>>> [   26.201366] Unable to handle kernel NULL pointer dereference at
> >>>>>> virtual address 00000004
> >>>>>> ...
> >>>>>> [   26.555522]  mmiocpy from xdr_inline_decode+0xec/0x16c
> >>>>>> [   26.560628]  xdr_inline_decode from nfs4_xdr_dec_read_plus+0x17=
8/0x358
> >>>>>> [   26.567130]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x30=
4
> >>>>>>
> >>>>>> Full OOPS attached. Full log available here:
> >>>>>> https://krzk.eu/#/builders/21/builds/3901/steps/15/logs/serial0
> >>>>>>
> >>>>>> Disabling NFS_V4_2_READ_PLUS fixes the issue, so obviously the com=
mit is
> >>>>>> not the cause, but rather making it default caused the regression.
> >>>>>>
> >>>>>> I did not make the bisect yet which commit introduced it, if every
> >>>>>> config includes NFS_V4_2_READ_PLUS.
> >>>>>
> >>>>> When every kernel is built with NFS_V4_2_READ_PLUS, bisect pointed =
to:
> >>>>> d3b00a802c84 ("NFS: Replace the READ_PLUS decoding code")
> >>>>>
> >>>>> commit d3b00a802c845a6021148ce2e669b5a0b5729959
> >>>>> Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>> Date:   Thu Jul 21 14:21:34 2022 -0400
> >>>>>
> >>>>>    NFS: Replace the READ_PLUS decoding code
> >>>>>
> >>>>>    We now take a 2-step process that allows us to place data and ho=
le
> >>>>>    segments directly at their final position in the xdr_stream with=
out
> >>>>>    needing to do a bunch of redundant copies to expand holes. Due t=
o the
> >>>>>    variable lengths of each segment, the xdr metadata might cross p=
age
> >>>>>    boundaries which I account for by setting a small scratch buffer=
 so
> >>>>>    xdr_inline_decode() won't fail.
> >>>>>
> >>>>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> >>>>>
> >>>>> With a trace:
> >>>>> [   25.898462] systemd[1]: Set hostname to <odroidhc1>.
> >>>>> [   25.933746] systemd[1]: Failed to bump fs.file-max, ignoring: In=
valid
> >>>>> argument
> >>>>> [   25.986237] random: crng init done
> >>>>> [   26.264564] 8<--- cut here ---
> >>>>> [   26.266823] Unable to handle kernel NULL pointer dereference at
> >>>>> virtual address 00000fe8
> >>>>> ...
> >>>>> [   26.597263]  nfs4_xdr_dec_read_plus from call_decode+0x204/0x304
> >>>>> [   26.603222]  call_decode from __rpc_execute+0xd0/0x890
> >>>>> [   26.608328]  __rpc_execute from rpc_async_schedule+0x1c/0x34
> >>>>> [   26.613960]  rpc_async_schedule from process_one_work+0x294/0x79=
0
> >>>>> [   26.620030]  process_one_work from worker_thread+0x54/0x518
> >>>>> [   26.625570]  worker_thread from kthread+0xf4/0x128
> >>>>> [   26.630336]  kthread from ret_from_fork+0x14/0x2c
> >>>>>
> >>>>
> >>>> Is this test being run against a 6.2-rc2 server, or is it an older s=
erver platform? We know there were bugs in older server implementations, so=
 the question is whether this might be a problem with handling a bad/corrup=
t RPC reply from the server, or whether it is happening against code that i=
s supposed to have been fixed?
> >>>
> >>> I would say that buggy server should not cause NULL pointer dereferen=
ces
> >>> on the client. Otherwise this is a perfect recipe for a rogue server =
in
> >>> the network to start crashing clients and running exploits... Imagine=
 a
> >>> compromised machine (through some other means) in a local company
> >>> network running now a server with NFS share "HR salary data" or "HR
> >>> planned layoffs", where unsuspected people in that network access it
> >>> leading to exploit of NFS code on their side...
> >>>
> >>> Server is Raspberry Pi 3 kernel: 5.10.92-2-rpi-legacy-ARCH
> >>>
> >>> Which points that it is not latest stable, so anyway I need to update=
.
> >>
> >> I updated the kernel to 5.15.84-3-rpi-ARCH which is pretty close to
> >> latest stable and I can reproduce the issue. Therefore:
> >> 1. It is visible on two stable (one new, one old) kernels on the serve=
r,
> >> 2. Buggy or rogue server should not cause NULL pointer on remote devic=
es...
> >
> > I'm still working on this issue, but I haven't been able to reproduce
> > it with my setup at all yet. I was hoping I could ask you a couple of
> > questions?
> >
> > - Are both client and server run on a Raspberry Pi 3?
>
> No, server is Rpi3, client is Odroid HC1.
>
> > - Is there a specific workload that triggers the bug, or is it just
> > during boot when using nfsroot?
>
> No specific workload - mounting system with nfsroot. You have there full
> logs as it is reproducible every time.
>
> > - Would it be possible to get a Wireshark network trace of the crash
> > (you'll have to run this on the server due to nfsroot).
>
> I'll check.

Any luck getting the wireshark trace? I don't have access to the
Odroid HC1 board, so all my attempts at reproducing the problem have
been with qemu & libvirt, which doesn't seem to be hitting this issue.

I was also wondering if it would be possible to turn on KASAN in your
kernel, which should give us a little more info?

Thanks,
Anna

>
> > - Can you share your export options from /etc/exports and the mount
> > options that the client uses?
>
> exports are the same since like 5 years or more:
>
> /srv/nfs/odroidhc1      192.168.1.0/24(rw,async,no_root_squash,no_subtree=
_check)
> /srv/nfs/odroidhc1-home
> 192.168.1.0/24(rw,async,no_root_squash,no_subtree_check)
>
>
> >
> > Thanks,
> > Anna
> >
> >>
> >> Best regards,
> >> Krzysztof
> >>
>
> Best regards,
> Krzysztof
>

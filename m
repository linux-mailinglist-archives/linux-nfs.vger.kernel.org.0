Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ECC6629D8
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Jan 2023 16:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjAIP0v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Jan 2023 10:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjAIP0r (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Jan 2023 10:26:47 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A1D1AD;
        Mon,  9 Jan 2023 07:26:43 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id pe2so4323460qkn.1;
        Mon, 09 Jan 2023 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqDQAkyb0cfxsVxbxG+ssknXnsv+HNvNoddjNPP1GZM=;
        b=iB0na+NOKHUYQly/Ihu3hUZx0d9YaC/1aM7gYmSatbaEvcwMVimqNtM3/+vqT5OcPc
         VLYfk9i+O/0q1LPvMOfIX2wwrsyEJTwp0E0g2tGMm4fdJI/FpoKpus/9t6rL1uJoDq9V
         RZlthEuxzoKb6x7iWO4Gn++6qcxYg1xiWs6K51g6Z4S5pEl+5uzS8kS9QWiN+Fj5ji5E
         X8Vfww1QUrxh5H8eLte9XymlZJJcfXS6Tm3HruohDrP1GWFFyVdS2/5w30qqWPaaI2+j
         /JSIAdkDQxvsoEfz/kgM7cuZ+ao+sK0edpC3koL3ud6Ac2i42ylK/ko4Em4Bm+du3ZIG
         KAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqDQAkyb0cfxsVxbxG+ssknXnsv+HNvNoddjNPP1GZM=;
        b=p4Io9XdQ4HfmgtwXlVf5SmRi221ZhfAFdXqyqC/vj2YPSEUmHBnC9JdLOpCP5RQyaP
         Qle8xtYQ6B13KN8a8A+zW9ULZ4vzsttL85pNR6D1OYO00Cre6imfkBaU92mDMYnhF82U
         PllVP1UxmtGojqVgiorAuh+QnGdo1uGxV4kdjikSjgHxe/P+DwIe6pTavnpqz/ilb6eU
         4qHOs70k8bZ14tsmXKdDZp7yIljL6LsXvok+yVtX2uSlSuIOLwDKZCbrnHvSlVDqt1Qq
         LtVCAxdDm6m4uLN5/A29iz86ZCAEGl41koEJzASof/9R0MSh+jIScPgqbXm6EME5DSDr
         tJgQ==
X-Gm-Message-State: AFqh2koBPvbppB6/bmJaq7cOM3tuYBfqpRIAIP7UdALrQZ4xv03MdxzG
        YuIHgnzNdXbl2m36bYoz0ps/A8lGzHI41WYQF8I=
X-Google-Smtp-Source: AMrXdXu4KqvTRMzOELPslzjhyieOypL4oWEo1BZZ3SWNRLJT3xpr6t7+77xygaB9DnUv9O+3iioWaDNJJq61hDoord8=
X-Received: by 2002:ae9:dc45:0:b0:6fe:c3d4:d9f4 with SMTP id
 q66-20020ae9dc45000000b006fec3d4d9f4mr3593809qkf.646.1673278002663; Mon, 09
 Jan 2023 07:26:42 -0800 (PST)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <6F61B478-A0FF-4E28-A7DE-8DAA6E11B128@hammerspace.com> <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
In-Reply-To: <DB31E56A-42D7-4B62-83CD-3D96AC4A4C20@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 9 Jan 2023 10:26:26 -0500
Message-ID: <CAFX2Jf=Q-vuFGAeGKQT7mxhvZTGSZBjDs6YWvWE6cwTFenW8Ow@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
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

On Mon, Jan 9, 2023 at 10:12 AM Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>
>
>
> > On Jan 9, 2023, at 9:44 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
> >
> >
> >
> >> On Jan 9, 2023, at 03:42, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:
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
> >>>>>  NFS: Replace the READ_PLUS decoding code
> >>>>>
> >>>>>  We now take a 2-step process that allows us to place data and hole
> >>>>>  segments directly at their final position in the xdr_stream withou=
t
> >>>>>  needing to do a bunch of redundant copies to expand holes. Due to =
the
> >>>>>  variable lengths of each segment, the xdr metadata might cross pag=
e
> >>>>>  boundaries which I account for by setting a small scratch buffer s=
o
> >>>>>  xdr_inline_decode() won't fail.
> >>>>>
> >>>>>  Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>>  Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
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
> >>
> >
> > The nfsd READ_PLUS code is borked up and until 6.2-rc1. I thought we ha=
d a server option to disable that code, but it seems as if that is not the =
case.
> > Chuck + Anna, can we please send a stable patch to rip out that code al=
together from all the older versions? If we want to enable READ_PLUS by def=
ault on the client, then we cannot do so if the majority of NFSv4.2 servers=
 out there are running a borked implementation.
> >
> > I do agree that we cannot allow buggy
>
> or malicious, or non-Linux,
>
>
> > servers to cause memory corruption in the client code, so I propose tha=
t we revert the Kconfig default setting change again until both the client =
code and the legacy servers have been fixed.
>
> I stand ready to receive and apply server-side fixes, as you suggested.
>
> However IMO it would be most responsible to go straight for a client code=
 fix. The Kconfig setting is a red herring (as delicious as that might soun=
d). Any thoughts about how difficult that fix might be?

I'm wondering about how hard the fix might be as well, since it could
be a legitimate bug or some error checking that I've overlooked. I've
gotten as far as installing a 5.15 server in my testing setup, so
we'll see if I'm able to reproduce the crash this morning.

Anna

>
>
> --
> Chuck Lever
>
>
>

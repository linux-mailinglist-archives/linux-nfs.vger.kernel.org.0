Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE31581A70
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Jul 2022 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiGZTpv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Jul 2022 15:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiGZTpu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Jul 2022 15:45:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB2240A1
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 12:45:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id os14so28032371ejb.4
        for <linux-nfs@vger.kernel.org>; Tue, 26 Jul 2022 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zOQcTFv0JN+aQspluzLAp3MLMWUoWl0CqXL+WNxrT4M=;
        b=aHBFf18bJnmQitbJyOcJxu4VMovM/nk5vKgkEnJ+oabUwD/kBWiuVgW2BS1ZISlo3Q
         34cqH3CuEZ8OID1QRbAtSRJ96aZebGkszpv/vmTebWN1/8TQygjvX+01DL3wlYaBpOHG
         Adtgy7CHfjtzqTjQqp39lz1/KX7KYcGHJueojxdP1LHaoFkMZESnVDuUf1ozhM43I9tZ
         plvpPW5Q5vJw8YE2aI1CXVBHUyR6eXBZVnT/FTPiwLiMaIQa/eZM0KV48uCW/Ep3U89F
         voTQxPYM/TjSnGmM3Yy68g0dg/QHMg1vVFP9sj6UGV5ddAOUKObfSnHIkvb2n6whYQCw
         7NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zOQcTFv0JN+aQspluzLAp3MLMWUoWl0CqXL+WNxrT4M=;
        b=GYFs5A0MfgFrsZCIuXLLDCAA4Og8PtpIXD8i4jzuMDigXsYmvAOqnIizRZb+wMUaot
         FPQfixvMXbaVNw+cM0iyzcgvTKLNuL4X60KnmX8B/cTuV6fSSG6T7q0BJPbB4o2abICy
         tmxP0mJ7PyDgzRMnBmfdfEXIGpA1yWeViliAPQayBJUUmo9zQnqFMITDjXz7phHnxdk9
         7fVvrLzMMfGtX0p2HTU6tLtG7D8anLEGG2CuMvZp6N0VMGkBRQtCzey5sExobD1wCoXb
         7BMiaObUGRGu7mwk01eb05+gNlo2low7ydwt4esQaiEQKn7+axCvLx7vs9l3pgpOeT00
         zY2g==
X-Gm-Message-State: AJIora/YpNhK3OU5/qBvhkd8kH7Agg8eUpzpHtszQ2yoBQzTNWxUPm7V
        kmElAfOb4YT7hCzpLnch9JYNH5W6WSHHJmswGp8=
X-Google-Smtp-Source: AGRyM1tnFaNROhjB6V2TdeL1XynfKmblZYPlyiGu9K9FQZ0k6fkFooAJiJd/yWC7N+bYOjE8Ys+f1MJugJ/Il4wOZ/E=
X-Received: by 2002:a17:907:a0c6:b0:72e:ea7d:6a98 with SMTP id
 hw6-20020a170907a0c600b0072eea7d6a98mr14726066ejc.140.1658864747980; Tue, 26
 Jul 2022 12:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
In-Reply-To: <165852076926.11403.44005570813790008.stgit@manet.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 26 Jul 2022 15:45:36 -0400
Message-ID: <CAN-5tyEgRvvFq51kdT-ROo-ew71JE610Da=Cqf_Ya4dgYxEmKg@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Put struct nfsd4_copy on a diet
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck,

Are there pre-reqs for this series? I had tried to apply the patches
on top of 5-19-rc6 but I get the following compile error:

fs/nfsd/nfs4proc.c: In function =E2=80=98nfsd4_setup_inter_ssc=E2=80=99:
fs/nfsd/nfs4proc.c:1539:34: error: passing argument 1 of
=E2=80=98nfsd4_interssc_connect=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  status =3D nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
                                  ^~~~~~~~~~~~~
fs/nfsd/nfs4proc.c:1414:43: note: expected =E2=80=98struct nl4_server *=E2=
=80=99 but
argument is of type =E2=80=98struct nl4_server **=E2=80=99
 nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
                        ~~~~~~~~~~~~~~~~~~~^~~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:249: fs/nfsd/nfs4proc.o] Error 1
make[1]: *** [scripts/Makefile.build:466: fs/nfsd] Error 2
make: *** [Makefile:1843: fs] Error 2

On Fri, Jul 22, 2022 at 4:36 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> While testing NFSD for-next, I noticed svc_generic_init_request()
> was an unexpected hot spot on NFSv4 workloads. Drilling into the
> perf report, it shows that the hot path in there is:
>
> 1208         memset(rqstp->rq_argp, 0, procp->pc_argsize);
> 1209         memset(rqstp->rq_resp, 0, procp->pc_ressize);
>
> For an NFSv4 COMPOUND,
>
>         procp->pc_argsize =3D sizeof(nfsd4_compoundargs),
>
> struct nfsd4_compoundargs on my system is more than 17KB! This is
> due to the size of the iops field:
>
>         struct nfsd4_op                 iops[8];
>
> Each struct nfsd4_op contains a union of the arguments for each
> NFSv4 operation. Each argument is typically less than 128 bytes
> except that struct nfsd4_copy and struct nfsd4_copy_notify are both
> larger than 2KB each.
>
> I'm not yet totally convinced this series never orphans memory, but
> it does reduce the size of nfsd4_compoundargs to just over 4KB. This
> is still due to struct nfsd4_copy being almost 500 bytes. I don't
> see more low-hanging fruit there, though.
>
> ---
>
> Chuck Lever (11):
>       NFSD: Shrink size of struct nfsd4_copy_notify
>       NFSD: Shrink size of struct nfsd4_copy
>       NFSD: Reorder the fields in struct nfsd4_op
>       NFSD: Make nfs4_put_copy() static
>       NFSD: Make boolean fields in struct nfsd4_copy into atomic bit flag=
s
>       NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
>       NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
>       NFSD: Refactor nfsd4_do_copy()
>       NFSD: Remove kmalloc from nfsd4_do_async_copy()
>       NFSD: Add nfsd4_send_cb_offload()
>       NFSD: Move copy offload callback arguments into a separate structur=
e
>
>
>  fs/nfsd/nfs4callback.c |  37 +++++----
>  fs/nfsd/nfs4proc.c     | 165 +++++++++++++++++++++--------------------
>  fs/nfsd/nfs4xdr.c      |  30 +++++---
>  fs/nfsd/state.h        |   1 -
>  fs/nfsd/xdr4.h         |  54 ++++++++++----
>  5 files changed, 163 insertions(+), 124 deletions(-)
>
> --
> Chuck Lever
>

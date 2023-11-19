Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A87F0812
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 18:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjKSRU6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 12:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKSRU5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 12:20:57 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D6D5
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:20:53 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f0f94943d9so1621557fac.2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700414453; x=1701019253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGLdhcmNEkULFYpTC0aWTT9CY57AvGntZNte0SgWBzc=;
        b=SDVTRpoirh6XNMzWpHnxJOEJcCF8DAD+SRDei68zTcIsq1p2vc9JTJRhoL49fQkCVr
         x/2FHRKg4U9622ilNBq0t2z+qZsA0i81qf3YBt8KneLAxXUGJq5f75VYqF75Ah2RuuhZ
         24Kr8PA6ZS3QMSCW8QlRRSahdcB38UAg3iURXm4OziqqrPHJBklgGAzm/DutRRuB2aNu
         zrR079i8bjWsMdWS/QsDvkKSWuX3Pg9wBcNovUkPo/AfBb2rWvTaMNmghAd5Hu1ELqxy
         UEtECIK3r5Yd+V+MEhC02mmioQwJ5aJ7f301/k63OLCPDDBxV6nTL1E0NUhQwhlesFXC
         q+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700414453; x=1701019253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGLdhcmNEkULFYpTC0aWTT9CY57AvGntZNte0SgWBzc=;
        b=SDAmXc/F9yx9zkubVdcCNuKDtdxMmD2bYWR6tf1Fa3/f0Ej4GzsUFUsAyBJjRxTjA9
         LHG5Beq3nfNTDj3Thn2GXmzsIaLK/tEIiHtiH7JCS1QUqLlGBe/w/NMxuUf2fHPUmPDV
         i5IDsGJ+BURMa00S84OH3YzaAYKEo2rCyaAwYvfxGD991pi0PcpFoYLQBKvJrts/R91B
         A7xvic681sZrE3XbxwIBxAIOOLtT8aQjk+Tl06dhkfoR0FGl2uVFgdga17u1zl7IgCPY
         JiftQKxEzc5pEO0HnLk6RIeToV6BLendPsBRq48ZrJy0PH/UnM222o/SjaxolH40mmwZ
         FLNg==
X-Gm-Message-State: AOJu0Yw3ykD185wf9X/iKafBJK2Iqn9zia5k2/j10bLtk3/6CT/1xDVY
        RA/SMp+Cczm4AoQjxipa0FV0Ft6h/ax+risbU7YHwUtUUk4=
X-Google-Smtp-Source: AGHT+IGQNkL2M91iFVOEzsP69KdQyhmpsUOKAIVqHJ4OriBvErwJpcYFpk6IK6RR/G6NT1TtJYNIvgBY+Sd3BnzgsWc=
X-Received: by 2002:a05:6871:2b16:b0:1e9:b4d1:9bed with SMTP id
 dr22-20020a0568712b1600b001e9b4d19bedmr4449562oac.40.1700414452964; Sun, 19
 Nov 2023 09:20:52 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UcwVRxbG9HD_0U2oK5Le53F3NKQz_H4P4nEesnoWM=BRw@mail.gmail.com>
 <d6c218f85f314f28ba94726038782ffada3a2e01.camel@kernel.org> <CALXu0Ud2-nrnTLazGXhkvQW+PPuo1xePxG0D51aQDv5BXFaUfQ@mail.gmail.com>
In-Reply-To: <CALXu0Ud2-nrnTLazGXhkvQW+PPuo1xePxG0D51aQDv5BXFaUfQ@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sun, 19 Nov 2023 12:20:36 -0500
Message-ID: <CAFX2JfmUAfDGfYKa5AcNdmp8AsU0tKF=xrj10eormK9RXghkcA@mail.gmail.com>
Subject: Re: NFSv4.1 --> NFSv4.2 client implementation?
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ced,

On Sun, Nov 19, 2023 at 11:58=E2=80=AFAM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Sat, 18 Nov 2023 at 13:01, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Sat, 2023-11-18 at 08:53 +0100, Cedric Blancher wrote:
> > > Good morning!
> > >
> > > What are the differences between NFSv4.1 and NFSv4.2 for a NFSv4
> > > client, if we ignore server-side copy and READ_PLUS support?
> > > Can a NFSv4.1 client then identify itself als NFSv4.2 client?
> > >
> >
> > Yes. I believe that NFSv4.2 consists entirely of optional features over
> > NFSv4.1, so it's legitimate for a client or server to advertise itself
> > as a v4.2 capable, but support none of the features.
>
> Can anyone confirm this? So NFSv4.2 does not require protocol minor
> version negotiation, or how does it work?

I can confirm this. When mounting with NFS v4.2, the client will
detect if the server doesn't support one of the new operations (by the
server returning NFS4ERR_NOTSUPP) and will remember not to try it
again.

Anna

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur

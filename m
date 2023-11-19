Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9AA7F083D
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjKSSCk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 13:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSCk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 13:02:40 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766E7F9
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 10:02:36 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41b7fd8f458so22736501cf.0
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 10:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700416955; x=1701021755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9fzXmBPPiyGXN1evAm5jcYAm7lRxwLWrQ5noQ6b9ss=;
        b=LL0EHwn9QrTR/UUz+rKdG3vAxtlrxHIKNvEysNkWTANozVc7voVw8EuCTPc9cVm8UJ
         O3i3rir2I5U4qrnoiKGZgSp8DzUKjak966WhnQAcFjU2PlykoJKD0E3okIbmFVlGxQH/
         C1M+DinGrJQMDIOnUMWVBI9e8mZfGnxrEaMvwXMQwfnMwg6pl72yICSEH1qmwGtOE+9s
         ursCtlOWFEp5TRueDjdC5qyrgBGVs3Lz7fS0TqBh5fJk5zimE2bmGYUecvmbpgN+TlIi
         oCgZ6t6n7J7yFH6fP1MEQrVnW040JFNtLGXCVS5IKNjvISOb9VOtGc5ddGcQyrKBa7gL
         fGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700416955; x=1701021755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9fzXmBPPiyGXN1evAm5jcYAm7lRxwLWrQ5noQ6b9ss=;
        b=PhrTlSoX2PhEdNXYI/4jlHaelr7mx7bF00fHuKgKkiVnwEiguKIrriZ4qLnS4+QWjp
         3dGZUnqiyeDA+4Of1zN/oy9fB4pXa71kcafmrOy9yki+63kD97xUaxCfwC2ckYzH4qNV
         0xp8Yu0uCklFGj+S+gulTBxiM+mH15vMWsLKeJaQZm4aeeKi957n1K0MHZxtABSmCxWA
         l+pPwEi2UmvtehxoEmjr6fkjHLHYw7dElhHO9ANokKi7lEhCunvYzXOPlshkP0SlU0/j
         Krrc31lJsAIdXf/7p3oo9vsH4kxKoVreFu/Py79rgjLuJd6WC+vpP+EQocu/XP8LeYFm
         /9Hg==
X-Gm-Message-State: AOJu0YzsI3AC6Hi27dvQ+Pp2k6Xf0cQU1FGa78pUIp+hlU1TQJLewPLu
        JVVqLzviMeuSXnqETqo2ZbguzUC24ndzCwNtYxo=
X-Google-Smtp-Source: AGHT+IF+S/hhWWzU4g4ASDN/cmr8GutAWnYiDtpfz9y4boVdtg3FdA1T8Ji3V3wALntCegyHry8K7NtOXCAuhrkZmwo=
X-Received: by 2002:a05:622a:2cf:b0:421:c58e:f9a2 with SMTP id
 a15-20020a05622a02cf00b00421c58ef9a2mr8581250qtx.32.1700416955527; Sun, 19
 Nov 2023 10:02:35 -0800 (PST)
MIME-Version: 1.0
References: <CALXu0UeGnSvBbrfgnRNqdNGjDTag5Lz8uWOvuy_n57RHO3CRqw@mail.gmail.com>
 <CAFX2JfnzDczbegELv3GMCYb3CEKZ+5WfgVotdoA3CyjUprGpTQ@mail.gmail.com> <CALXu0UebE2oGgWLMn-NkfGq5n+2dEFnqrOy617SRMmKF-dGOXg@mail.gmail.com>
In-Reply-To: <CALXu0UebE2oGgWLMn-NkfGq5n+2dEFnqrOy617SRMmKF-dGOXg@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sun, 19 Nov 2023 13:02:19 -0500
Message-ID: <CAFX2JfnDC1xZvuuUiHe8_RpBehwCZriZ13yYPk6pQSPSV4V-qQ@mail.gmail.com>
Subject: Re: How does READ_PLUS differ from READ?
To:     Cedric Blancher <cedric.blancher@gmail.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Nov 19, 2023 at 12:59=E2=80=AFPM Cedric Blancher
<cedric.blancher@gmail.com> wrote:
>
> On Sun, 19 Nov 2023 at 18:48, Anna Schumaker <schumaker.anna@gmail.com> w=
rote:
> >
> > Hi,
> >
> > On Sun, Nov 19, 2023 at 12:38=E2=80=AFPM Cedric Blancher
> > <cedric.blancher@gmail.com> wrote:
> > >
> > > Good evening!
> > >
> > > How does READ_PLUS differ from READ? Has anyone made a simpler
> > > presentation (PowerPoint slides) than the RFCs?
> >
> > No slides, but at a high level READ_PLUS can compress out long ranges
> > of zeroes in a read reply by returning a HOLE segment instead of the
> > actual zeroes. It's perfectly valid for the server to skip the zero
> > detection and return everything as a data segment, however.
>
> So how do you differ between
> 1. a hole, aka no filesystem blocks allocated
> 2. a long sequence of valid data with all zero bytes in them

That's up to the server! It could use something like fiemap or lseek
with SEEK_HOLE or SEEK_DATA. It could also scan the data to see if
there are any zeroes that could be compressed out.

Anna

>
> Ced
> --
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA937F06F1
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjKSOs7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 09:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSOs6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 09:48:58 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A66A4
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 06:48:55 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77ba6d5123fso401176785a.0
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 06:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700405334; x=1701010134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6iTVrj8wsbTvLJhAgCKG2+9Qt52zaT0EaOdajgKQVE=;
        b=hUazCELhoppDvjE+5nSV09q2A1Z5pSZcfWOAjxa4+Ga2DlEBg3MLy07H4KpSckqdYz
         5vV9I7x8Iram+WAdMQvHTcELdpQNHJUaDBn3YG4MZ5JgTnqiVx6Uwso1k5LYK4BTnOVx
         2Lr74VSRZTQ47GbeAt9Gp/eo5bvW2bNfXZKPLVVdwjd6p/7rZqMbf8kXrPLvOE2FQ/iR
         tA8glo+AnD5hhgRBEgxMexRcX+Bt8vNn24R+j7VKx82KsKvls8iVdi0KrYLOiIt+ZmBR
         dZa/tUmW7RXY8wade5rayy2CsnrXCtd+VniHRFtJlbTnyo2OIHySCmkea52GVM9dN45G
         Qmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700405334; x=1701010134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6iTVrj8wsbTvLJhAgCKG2+9Qt52zaT0EaOdajgKQVE=;
        b=oO/qMHuPnbTblFzNuZMDQTUKXe1WhSnqs28BuDe+LdWcNiDV1ACKsav2hYPYk+pDoO
         ymTmchlUAy3U4N+swQ3Iybh9w5pLPAcLgFKJ7Jd5kmwgPHGFSMF+S8UtB0+tBrLO+2nH
         ProZ9iq6B28qUWoREzn/u9PuVIYuk2gM5Waz0lcYG4EmNuMcu//NVtDnUm/MOXT+uyYK
         r9N7xm5WqPjYsGDULDUnjKXg6/ZR8gULGQ0fajFrueQ0kTtXmsaU0IWKAQFeCuA5vAKG
         pe9LvgZuA6pH7lvIcPFR8PVaaNgTL74l8p/Yxt9BwMMeuwpybbOAw+0eEAQ+Xpt1u4lc
         HCZg==
X-Gm-Message-State: AOJu0YwWCvRYPX3p/Tr1yKbZmKrVvh7r1qZO9mDguxFfb0vNpmCWsLtl
        XQhTWyROda5p5P4xhTHTMaF7MGoZye8BZPXYeeo=
X-Google-Smtp-Source: AGHT+IEx/N8VtYLxYMHp/qdaI1h1985411zroLF3R3Ar6Womb6e5UZZMPlY53/PPcenqQ7W4ZSMQxlg3cahOKm1hkgQ=
X-Received: by 2002:a05:622a:1746:b0:421:f6ef:36a1 with SMTP id
 l6-20020a05622a174600b00421f6ef36a1mr14087550qtk.8.1700405333980; Sun, 19 Nov
 2023 06:48:53 -0800 (PST)
MIME-Version: 1.0
References: <bug-218138-226593@https.bugzilla.kernel.org/> <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com> <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com> <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
In-Reply-To: <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sun, 19 Nov 2023 09:48:37 -0500
Message-ID: <CAFX2JfmrWONe9UO2_qpbgdJRWuG+BXa3-ivcr4wTuWwBg4Oe+w@mail.gmail.com>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
To:     Steve Dickson <steved@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Sat, Nov 18, 2023 at 3:46=E2=80=AFPM Steve Dickson <steved@redhat.com> w=
rote:
>
>
>
> On 11/18/23 12:03 PM, Chuck Lever III wrote:
> >
> >> On Nov 18, 2023, at 11:49=E2=80=AFAM, Trond Myklebust <trondmy@hammers=
pace.com> wrote:
> >>
> >> On Sat, 2023-11-18 at 16:41 +0000, Chuck Lever III wrote:
> >>>
> >>>> On Nov 18, 2023, at 1:42=E2=80=AFAM, Cedric Blancher
> >>>> <cedric.blancher@gmail.com> wrote:
> >>>>
> >>>> On Fri, 17 Nov 2023 at 08:42, Cedric Blancher
> >>>> <cedric.blancher@gmail.com> wrote:
> >>>>>
> >>>>> How owns bugzilla.linux-nfs.org?
> >>>>
> >>>> Apologies for the type, it should be "who", not "how".
> >>>>
> >>>> But the problem remains, I still did not get an account creation
> >>>> token
> >>>> via email for *ANY* of my email addresses. It appears account
> >>>> creation
> >>>> is broken.
> >>>
> >>> Trond owns it. But he's already showed me the SMTP log from
> >>> Sunday night: a token was sent out. Have you checked your
> >>> spam folders?
> >>
> >> I'm closing it down. It has been run and paid for by me, but I don't
> >> have time or resources to keep doing so.
> >
> > Understood about lack of resources, but is there no-one who can
> > take over for you, at least in the short term? Yanking it out
> > without warning is not cool.
> >
> > Does this announcement include git.linux-nfs.org <http://git.linux-nfs.=
org/> and
> > wiki.linux-nfs.org <http://wiki.linux-nfs.org/> as well?
> >
> > As this site is a long-time community-used resource, it would
> > be fair if we could come up with a transition plan if it truly
> > needs to go away.
>
> If you need resources and time... Please reach out...
>
> This is a community... I'm sure we can figure something out.
> But please turn it back on.

I wonder if something like a gitlab / gitea instance would suit our
needs? That would get us a combined git hosting, wiki, and issue
tracker in one web application which might make overall maintenance
easier (once we get through what I assume would be a tedious initial
migration).

Anna

>
> steved.
>

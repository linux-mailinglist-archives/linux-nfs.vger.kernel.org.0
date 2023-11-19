Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F15C7F0815
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 18:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjKSR2H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 12:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKSR2G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 12:28:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F76D5
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:28:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so5190777a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 09:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700414880; x=1701019680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJclnnvO364Ul/z3XiHp93+uNxkJ9WWs1ZTGdIp2q44=;
        b=U/FOZyvKD6Wx/AyIk3N79KzZJCeK8yew3tlTTp2BIl0b3f7rbDaWWFN9Hwo8vc6J8o
         /tQIfsnUaFjQ0C3HQGPfbBStvrh9i9HVNssX0pLUTCLmGPpr6ZaLK3NXbYNSmy/Jo0c7
         rDiCyHpqzn5Q60OaDAy6P59+2b9crkEnyXi8QH9+ROTwss9AG8wDDUPFgOWyFkhpl41n
         mxS2/i6eaJjf1rk8fEbLqqq/l4OjeB+Yj06Kcpw9DeJYtYa7qtt2fFmtf9tH6LNYT2CF
         X57AEuYJvCxj9OUEniO2xZSK9KxNGeV8yK1r8twdmVeuiR1rJWuHAHaOwh4Z/tXYVG+c
         TUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700414880; x=1701019680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJclnnvO364Ul/z3XiHp93+uNxkJ9WWs1ZTGdIp2q44=;
        b=eau8LjWAsRIAP811c1cWh7vB/9CW82+dedfZ3FA7o/Lopkl1tHuNMFRKkrZSzdY7Za
         Nue+ShIQyr+aBDP7ZJpW47AUyfFwFEEiWl2Fkpy0/wsHXIL+KM5Ba0SUigvZp9qH8b7T
         b5i86wLAvGjq/qZ0a+WudUM8S0RVvb2WIT769GKC3XmrPExUfszHO+3PoA2U27r8n0gD
         7uadzR0IsrmWXpkwOcOFFFiNE1bDJ/4ZGnvEwSWVRUgrk/dm1YMX2wLhpwNvW4EopxLw
         FE9dY59DJwCsNhCE5SsrRWan/NlacxJhnWBUB0c4Yjh7fL2UKaCT0zF6JSWOh+UNjhlg
         t1eA==
X-Gm-Message-State: AOJu0Yz7wk4fNTgQBViBJMSMdFXHhcex0Z6fKZxdCMWlnrkxHYn+RVoW
        jQyWCshP25sUUrqsFbbECsmHy3Yjj6V0okMRXH0=
X-Google-Smtp-Source: AGHT+IGoHh5C+6RFr8g7OnPTee+DKAycq8q+d8S/tYVy9CfQWYbQg/QW9F09EHvdFXHmYe2OD/rAZnrjJ/RQA1j7F0g=
X-Received: by 2002:a50:ec82:0:b0:543:8498:fda5 with SMTP id
 e2-20020a50ec82000000b005438498fda5mr3359046edr.14.1700414879686; Sun, 19 Nov
 2023 09:27:59 -0800 (PST)
MIME-Version: 1.0
References: <bug-218138-226593@https.bugzilla.kernel.org/> <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com> <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com> <9bb44f33-9900-44e1-813d-df1c60d8307c@redhat.com>
 <CAFX2JfmrWONe9UO2_qpbgdJRWuG+BXa3-ivcr4wTuWwBg4Oe+w@mail.gmail.com>
In-Reply-To: <CAFX2JfmrWONe9UO2_qpbgdJRWuG+BXa3-ivcr4wTuWwBg4Oe+w@mail.gmail.com>
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Sun, 19 Nov 2023 18:27:23 +0100
Message-ID: <CALXu0Uene5F9A1Cn7suksxEpH_O9zTEs86KOYe2iVM_mieTWTg@mail.gmail.com>
Subject: Re: Who owns bugzilla.linux-nfs.org - account creation broken? Re:
 How owns bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way
 to define custom (non-2049) port numbers for referrals
To:     Anna Schumaker <schumaker.anna@gmail.com>
Cc:     Steve Dickson <steved@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
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

On Sun, 19 Nov 2023 at 15:49, Anna Schumaker <schumaker.anna@gmail.com> wro=
te:
>
> On Sat, Nov 18, 2023 at 3:46=E2=80=AFPM Steve Dickson <steved@redhat.com>=
 wrote:
> >
> >
> >
> > On 11/18/23 12:03 PM, Chuck Lever III wrote:
> > >
> > >> On Nov 18, 2023, at 11:49=E2=80=AFAM, Trond Myklebust <trondmy@hamme=
rspace.com> wrote:
> > >>
> > >> On Sat, 2023-11-18 at 16:41 +0000, Chuck Lever III wrote:
> > >>>
> > >>>> On Nov 18, 2023, at 1:42=E2=80=AFAM, Cedric Blancher
> > >>>> <cedric.blancher@gmail.com> wrote:
> > >>>>
> > >>>> On Fri, 17 Nov 2023 at 08:42, Cedric Blancher
> > >>>> <cedric.blancher@gmail.com> wrote:
> > >>>>>
> > >>>>> How owns bugzilla.linux-nfs.org?
> > >>>>
> > >>>> Apologies for the type, it should be "who", not "how".
> > >>>>
> > >>>> But the problem remains, I still did not get an account creation
> > >>>> token
> > >>>> via email for *ANY* of my email addresses. It appears account
> > >>>> creation
> > >>>> is broken.
> > >>>
> > >>> Trond owns it. But he's already showed me the SMTP log from
> > >>> Sunday night: a token was sent out. Have you checked your
> > >>> spam folders?
> > >>
> > >> I'm closing it down. It has been run and paid for by me, but I don't
> > >> have time or resources to keep doing so.
> > >
> > > Understood about lack of resources, but is there no-one who can
> > > take over for you, at least in the short term? Yanking it out
> > > without warning is not cool.
> > >
> > > Does this announcement include git.linux-nfs.org <http://git.linux-nf=
s.org/> and
> > > wiki.linux-nfs.org <http://wiki.linux-nfs.org/> as well?
> > >
> > > As this site is a long-time community-used resource, it would
> > > be fair if we could come up with a transition plan if it truly
> > > needs to go away.
> >
> > If you need resources and time... Please reach out...
> >
> > This is a community... I'm sure we can figure something out.
> > But please turn it back on.
>
> I wonder if something like a gitlab / gitea instance would suit our
> needs? That would get us a combined git hosting, wiki, and issue
> tracker in one web application which might make overall maintenance
> easier (once we get through what I assume would be a tedious initial
> migration).

I would prefer to chew off my leg (yeah, insert picture of some gore
horror movie!) before I have to touch gitlab/github agan. The *ONLY*
reason why I touch github at all is because the kofemann/Roland's
Windows NFSv4 client sources are hosted there.

Beyond that I STRONGLY prefer BUGZILLA.

Maybe we create www.nfs.org or www.nfsv4.org, and host a bugzilla for
Linux NFSv4, Windows NFSv4 etc?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

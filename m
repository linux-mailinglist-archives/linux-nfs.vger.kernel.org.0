Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC27F0605
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 12:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKSLmT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 06:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSLmS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 06:42:18 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE06E6
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 03:42:15 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f5d7db4dcbso606854fac.2
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 03:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700394134; x=1700998934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryNutOCX1OctxKUKliDaUfWc9/15Q32npSjbbIb3M9I=;
        b=PsaQi1n24fWvqQe6NQSrNW2YCRWkySTmDYhSY86JU1BBsWT8QF6ovUUbZt+NMluOif
         UlPB/tZ+IaC57euFJ1juXUrDOIwORqQqkBPk/osi+8ECqlhNB110eCEthnDgPFl4SC9V
         aTSAeqQNkNocGovwHK1W3LFZB/FvM5l8wFGV4xZScA9UyFZw6PLWDORE5wHvMJNmy8Q0
         MTDOTc2wlyKoHk9NLOsL+4ztIh4aDUpevSgbL5QShChdUKtcTHUL5SNmbeggnu8CcXP/
         felNnZvlGYCm+p+zU7RN/sIOou8OfcBX05/g2WXSs9S4oF0psMI6GZMBgkUwSURq/rEN
         Tqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700394134; x=1700998934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryNutOCX1OctxKUKliDaUfWc9/15Q32npSjbbIb3M9I=;
        b=BOxcUPrT7wJdzrc8Cp9J4QGYx9DxGZckayQ8fGzA3waTJSVxGOoDvIRDkpbkFBxVfY
         1oyJghOZ3OQ8cxSHEMs0GzeQAewqYUsMNvvv/t5HlUI1Da3Vv56yo1URgiJvP7qYcNDK
         GYwA/thke+QnRBptq2973iGrB30qj35Ei7OG8TwiMI+OpMY4qNfdqortpHG01+OGFS5r
         wXaOyiRM4mwjMePProVNpZzkUFqRmafuWB4LJU+76pJP/4R756L4VgnW7Ew6rhDa6AA+
         oiV9xsNA+USroL/g9M9f7XXHbArcHqyDIG4gm7CDgXy+DvM3CTiEq0HOsiBw+Xl5/+nN
         XMSQ==
X-Gm-Message-State: AOJu0Yw0AT21pz6E78GfwoUN7Wp+EvGAu04NLXOpQ/8jmLaUVE1U+E1K
        MgNTyHwDwLVIOV0xU1HURGYVXEwIHT0iNm+0ruLKTSuQ
X-Google-Smtp-Source: AGHT+IHKs5ExKys3aqCCxfH6QyGtV76qYT6vwNbf42jJEJtjzIfNBoXi1LEjJ3Kj1opRKwwHJSLXSTx0Ru+G2X4GBFQ=
X-Received: by 2002:a05:6870:af92:b0:1dc:9714:e2b3 with SMTP id
 uz18-20020a056870af9200b001dc9714e2b3mr4849790oab.7.1700394133970; Sun, 19
 Nov 2023 03:42:13 -0800 (PST)
MIME-Version: 1.0
References: <bug-218138-226593@https.bugzilla.kernel.org/> <bug-218138-226593-fRCLxzGk3u@https.bugzilla.kernel.org/>
 <CALXu0Ucz2MGCYdMw74ZKGUj_hpGcLP-pxC=MSgpUFGU58=jc=g@mail.gmail.com>
 <CALXu0UdY=ZgcAqvC6Y-X6htxPQ9=XWemt8V4dxTA99wQmHKz=w@mail.gmail.com>
 <959BB15F-5B91-4413-BCFC-EDAC78EE32F6@oracle.com> <d8bb0bf43c8fe38ef83248fb55a9549919530cf2.camel@hammerspace.com>
 <095736A1-C749-4B8C-900C-C0471D8F8422@oracle.com> <c762fb4fd6e3c529e75541d6944a187a357578c9.camel@hammerspace.com>
 <3D231C38-BA1A-4549-8788-D049CF3467A4@oracle.com>
In-Reply-To: <3D231C38-BA1A-4549-8788-D049CF3467A4@oracle.com>
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Sun, 19 Nov 2023 12:42:02 +0100
Message-ID: <CANH4o6O-02vK1or+njpz2t8m7wDkpszhUqD5EP-yOe4XYyCbQw@mail.gmail.com>
Subject: altruistic company who can save linux-nfs.org? Re: Who owns
 bugzilla.linux-nfs.org - account creation broken? Re: How owns
 bugzilla.linux-nfs.org? Fwd: [Bug 218138] NFSv4 referrals - no way to define
 custom (non-2049) port numbers for referrals
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Sat, Nov 18, 2023 at 7:36=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Nov 18, 2023, at 1:03=E2=80=AFPM, Trond Myklebust <trondmy@hammerspa=
ce.com> wrote:
> >
> > On Sat, 2023-11-18 at 17:03 +0000, Chuck Lever III wrote:
> >>
> >>> On Nov 18, 2023, at 11:49=E2=80=AFAM, Trond Myklebust
> >>> <trondmy@hammerspace.com> wrote:
> >>>
> >>> On Sat, 2023-11-18 at 16:41 +0000, Chuck Lever III wrote:
> >>>>
> >>>>> On Nov 18, 2023, at 1:42=E2=80=AFAM, Cedric Blancher
> >>>>> <cedric.blancher@gmail.com> wrote:
> >>>>>
> >>>>> On Fri, 17 Nov 2023 at 08:42, Cedric Blancher
> >>>>> <cedric.blancher@gmail.com> wrote:
> >>>>>>
> >>>>>> How owns bugzilla.linux-nfs.org?
> >>>>>
> >>>>> Apologies for the type, it should be "who", not "how".
> >>>>>
> >>>>> But the problem remains, I still did not get an account
> >>>>> creation
> >>>>> token
> >>>>> via email for *ANY* of my email addresses. It appears account
> >>>>> creation
> >>>>> is broken.
> >>>>
> >>>> Trond owns it. But he's already showed me the SMTP log from
> >>>> Sunday night: a token was sent out. Have you checked your
> >>>> spam folders?
> >>>
> >>> I'm closing it down. It has been run and paid for by me, but I
> >>> don't
> >>> have time or resources to keep doing so.
> >>
> >> Understood about lack of resources, but is there no-one who can
> >> take over for you, at least in the short term? Yanking it out
> >> without warning is not cool.
> >>
> >> Does this announcement include git.linux-nfs.org
> >> <http://git.linux-nfs.org/> and
> >> wiki.linux-nfs.org <http://wiki.linux-nfs.org/> as well?
> >>
> >> As this site is a long-time community-used resource, it would
> >> be fair if we could come up with a transition plan if it truly
> >> needs to go away.
> >>
> >
> > Ever since the NFSv4 code went into the kernel, I've been telling you
> > that bugzilla.linux-nfs.org is deprecated.
>
> I don't recall that, and the usual courteous thing to do is
> put a banner on the log in page for a time, or at least
> warn folks that the site going away imminently.
>
>
> > We don't need 2 bug tracking
> > resources, and bugzilla.kernel.org is the more general option that
> > tracks all Linux kernel related issues.
>
> bugzilla.linux-nfs.org <http://bugzilla.linux-nfs.org/> is for upstream n=
fs-utils bugs too,
> and I think there were even one or two TI-RPC related bugs
> there as well. So, not redundant in the least.
>
> But I see you've already taken the whole thing down, so I
> guess that's moot.
>
> I can only regard the tone and suddenness of this removal
> as a personal jab, since you know very well that Jeff and
> I were still using the site and that we had bugs and to-dos
> in flight.

Could you please tone it down? I don't think it was intended as a
"personal jab". Sounds more like Trond is in pain.

But I'm also sour about this, but for different reasons: There is no
single altruistic company who easily can help out quickly since Sun
Microsystems went down.
I bitterly remember the LinuxTag/LinuxWorld conferences here in
Germany where they were singing mocking songs about SUN&Solaris,
"Linux WON, we'll take over the world' blabla. They forgot who helped
them, and were always nice to the Opensource world.

Who is left now?

SUN is gone, HP&IBM mostly look at money (that includes Redhat, who
now gets ruined by IBM's bean counters), and who is left and will
altruistically help out in such a situation?

Thanks,
Martin

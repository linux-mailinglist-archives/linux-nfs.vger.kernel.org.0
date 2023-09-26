Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5DF7AEED0
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjIZOb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjIZObZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 10:31:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B97E11F
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 07:31:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bffc03c588so26404311fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1695738676; x=1696343476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8zJ2VmxxAlr5aGsCnipQOqUlfIXcMoInhIqP19kXsQ=;
        b=W3iEcTT8QbF4QV5e6EU30Ja4wYJJESUz4AgKSSgnsBknp7W52AomtkMrqhhtoeYC/8
         WOdu0aM116s5vrN92AvdPV6zwLfPJDF32YCz3sNYCbNmVXwtMd73dqV4qOOB5YvH4hnY
         QyQYr8C5mUS9qkPcLV+WbGEorOJ20OW2AyTyCQ2/yBYdpSN4nPAHukBxdLtvxQANiFg4
         NxEjTvwNFYvI77GUuq+OO0gYwIm/bnBzXikHEskuBV66R0oC2KcCuXUxN0Wnc5QCq/Ar
         0SVVMUJ25yv/L6nQ91lErLdgcSfeHvu66atFCFDNfenQqfXBTVxQyVYelipwpamKgvN3
         xyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695738676; x=1696343476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8zJ2VmxxAlr5aGsCnipQOqUlfIXcMoInhIqP19kXsQ=;
        b=tY4qM5FwXq4uIQfskUYDmccjG58EoUqT1h08MY27nEcF/G84pEVGKfVw1ny0eQJ/sO
         9raoVlE2ciITAQaE8FXrQDoszX/ZcVGS17Zdx98cfqzWNhhnSWLnRt/qjWGzbq1aLZSM
         f6r1O7Q8urCy2QqF+IOXFuyuY7MCM6FqCO0co2n+IUE3t4OdnOYmShMYvxFywvZw5ua+
         Xa9EQBOFd9MSnFRq490Aj/PSdgjdwjHEwZaBCNa5SjXzC5jMhN0YtQNYMm3c1kwIyKx5
         03gyKlAckHN8pOuZZmKlvKURjB2tv+IhU7zh+U/8+3ZubUUblmwNwicYY6OP1mdRUI2M
         ms3g==
X-Gm-Message-State: AOJu0YywkYUzFmskpKBmOEmv9eEJrg12hxvcoVitAFOVEyU9fUSFaJ3t
        1ST+n6PDu5AyO7ozlfylk3xEOal/qYnyEiq2hCzrQyrK
X-Google-Smtp-Source: AGHT+IGfEWAvvpemhSfr6E57gjwBp6cZsUiRXZFnQ6EWrN+MASo2Q7aT2cIKVmK3imACAZKBzA5ftLxD3JgjHHmWYvw=
X-Received: by 2002:a2e:a36d:0:b0:2bf:ed94:3693 with SMTP id
 i13-20020a2ea36d000000b002bfed943693mr6676610ljn.0.1695738676080; Tue, 26 Sep
 2023 07:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230917230551.30483-1-trondmy@kernel.org> <20230917230551.30483-2-trondmy@kernel.org>
 <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>
 <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
 <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>
 <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
 <CAN-5tyE8u1HCrS9KWQywc3BDvPG2ceZG4kn_vDkJjS-W2mL1KQ@mail.gmail.com> <c1c6106c3b4a6106ff706130fe551b424512dd34.camel@hammerspace.com>
In-Reply-To: <c1c6106c3b4a6106ff706130fe551b424512dd34.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 26 Sep 2023 10:31:04 -0400
Message-ID: <CAN-5tyGA46W+UTbVNn5xnzqTgdgTvT7=nwx9yo3zez4mTEo5Rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
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

On Fri, Sep 22, 2023 at 5:07=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Fri, 2023-09-22 at 17:00 -0400, Olga Kornievskaia wrote:
> > On Fri, Sep 22, 2023 at 3:05=E2=80=AFPM Trond Myklebust
> > >
> > > Oh crap... Yes, that is a bug. Can you please apply the attached
> > > patch
> > > on top of the original, and see if that fixes the problem?
> >
> > I can't consistently reproduce the problem. Out of several xfstests
> > runs a couple got stuck in that state. So when I apply that patch and
> > run, I can't tell if i'm no longer hitting or if I'm just not hitting
> > the right condition.
> >
> > Given I don't exactly know what's caused it I'm trying to find
> > something I can hit consistently. Any ideas? I mean this stack trace
> > seems to imply a recovery open but I'm not doing any server reboots
> > or
> > connection drops.
> >
> > >
>
> If I'm right about the root cause, then just turning off delegations on
> the server, setting up a NFS swap partition and then running some
> ordinary file open/close workload against the exact same server would
> probably suffice to trigger your stack trace 100% reliably.

Getting back to this now. Thanks for v2 and I'll test. But I'm still
unclear, is there a requirement that delegations have to be off for
when the client has NFS over swap enabled? I always run with
delegations on in ONTAP and run xfstests. I don't usually run with NFS
over swap enabled but sometimes I do. So what should be the
expectations? If I choose this kernel configuration, then deadlock is
possible?
>
> I'll see if I can find time to test it over the weekend.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

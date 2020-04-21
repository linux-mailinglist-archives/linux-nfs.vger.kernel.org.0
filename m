Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449A61B30A0
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2020 21:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDUTr2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Apr 2020 15:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUTr1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Apr 2020 15:47:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E9C0610D5
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2020 12:47:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id pg17so11953047ejb.9
        for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2020 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJu2FREuvO0p+l3XldrbvpZrZesI/6Np6TJa52ATg1A=;
        b=Lm0lwfxWJOrBtTJtgf4FWCNQPnrW8936tlTHEaSpVRhKRqVlznM1A0FfdC8KdgKVMI
         LnYeTY7YLzKeqlQ4wx6gPOT4Uabs2FMytTyyDAN7W0lSfwk5QAIXHk40RK1Wa9f0PMxK
         MoOrzifGJiOLAuggQOfJrfz5kghFIh4WBe+okSpfWiTt/81VCOClZjPe+kgJmO4JhSKB
         MaIQsJp1rjuamrnzG86rdBjtVujpxfCBShvVJWY0Dd2GteWcdKrs4346vAy4xfLRYuJ9
         H+zeerfGDPro179uIxoz9KevFbgiYfKypyruAOXxyRXkprjKZI7M/Gwve2s7+mn5wwNR
         YX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJu2FREuvO0p+l3XldrbvpZrZesI/6Np6TJa52ATg1A=;
        b=LH5XxFIRrN+zow7N+6v0lm1CShovKgPPLIBe9ESaXm8j5uGYnpWltq+CFoeCgVQZZO
         3ksYhTqbk8Xgcw8Xz6lO6PMU4aNQLixe14trhPvy1oV5aFGNNaNH4kDfMNHvieNe9rQI
         jAgTtpgvbCXQRwSxKPl5xoYCUESN9doabKsNpOEeAyD0AAjYPHGUhijRffOrXpWNjrEG
         53sq8ChUcD2UdwwpUktweY7ZQ4XKE1DIUpMF3q1GHOi18IA05Ulgnc50OpdTf/Gqz+Zw
         0kW9aeOXnhIqjSRgSTwdVfOpUrWaw0VpPqoBzeZ0v5gCJllDM/7ZePHlOrCXO+NFtj1O
         4jGw==
X-Gm-Message-State: AGi0PuY/bzqFbqSb08nBkjq5CXahQ5yeGunPim7NjLSGs2Ge58WGlZm4
        12CBZYvZul9EAd95CVHT2f76VBCY1wuRSffdo58=
X-Google-Smtp-Source: APiQypJzYSndTjk4vuAA3f+ZNwWYs/Yzcv8kzniWWXHdlvh3bRgTml9TlFjD0zsoW3gXY8oFdNw1Nkngr5EZXTdvu2M=
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr17743483ejc.215.1587498445638;
 Tue, 21 Apr 2020 12:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
 <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
 <CAN-5tyHQ_Gs-HmWLdbQYz1o8UyB2jv_oD2EtJP94qgtrfeK52Q@mail.gmail.com>
 <7dd1b9300d2a0ec1a31fb3879c62a94f535ccad5.camel@hammerspace.com>
 <CAN-5tyEbi8Z8bxU1enkkhjAyJj-nb9=j33xcLi7FE2+A79-qng@mail.gmail.com>
 <52b65780986192bb635638d4615176bbc1ad579c.camel@hammerspace.com>
 <CAN-5tyFjohv0YQOgtsoxcqL+eUxNXGRZOfd5zOvm_8nCOnJhJg@mail.gmail.com>
 <402396992273d33f880af913134b063819ab1d22.camel@hammerspace.com>
 <CAN-5tyFJQiG6osJ-gW-XHpQZm9SE0oJumRRfTTYkk-dEqDrYcg@mail.gmail.com>
 <CAN-5tyFLusaQbzw2uN9DUtytrWsuQrrYGz44X=Cvj1WS=gD=Hg@mail.gmail.com>
 <2e691fb93a4b6d362cdfd85feaaa9cfbfc68709c.camel@hammerspace.com>
 <CAN-5tyE2ix4urwhFN_ctcPoTwDrWu5jM2gEbuD4cvc-_k6NVvg@mail.gmail.com> <fbd6f65b176449e7a1abd5731361ad4e6fa15900.camel@hammerspace.com>
In-Reply-To: <fbd6f65b176449e7a1abd5731361ad4e6fa15900.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 21 Apr 2020 15:47:14 -0400
Message-ID: <CAN-5tyFtUgiDe=5q0p61Cdpb8Z6QcWkMtxSFj3bs=ra-LiNWUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 20, 2020 at 5:20 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2020-04-20 at 15:35 -0400, Olga Kornievskaia wrote:
> > On Mon, Apr 20, 2020 at 3:02 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Mon, 2020-04-20 at 10:59 -0400, Olga Kornievskaia wrote:
> > > >
> > > > On Mon, Apr 20, 2020 at 10:53 AM Olga Kornievskaia <
> > > > olga.kornievskaia@gmail.com> wrote:
> > > > > Yes we are consistent in requesting to same connection to with
> > > > > the
> > > > > same channel binding, but we don't send BIND_CONN_TO_SESSION as
> > > > > the
> > > > > first thing on the "main" connection (ie connection that cared
> > > > > the
> > > > > CREATE_SESSION and was bound to fore and back channel by
> > > > > default).
> > > > > When that connection is reset, the first thing that happens is
> > > > > the
> > > > > client re-sends the operation that was not replied to. That has
> > > > > a
> > > > > SEQUENCE and by the rule the server binds that connection to
> > > > > the
> > > > > fore channel only (and sets the callback being down). We then
> > > > > send
> > > > > BIND_CONN_TO_SESSION and request FORE_OR_BOTH where this has
> > > > > already been bound to FORE only.
> > > > >
> > > >
> > > > How about this: before we send BIND_CONN_TO_SESSION with
> > > > fore_or_both, we somehow always reset the connection (maybe you
> > > > were
> > > > suggestion that already and i wasn't following).
> > >
> > > No. I didn't realise that we were being automatically set to just
> > > the
> > > fore channel. However as I said earlier, the spec says that the
> > > server
> > > MUST reply with NFS4ERR_INVAL in this case. It is not allowed to
> > > just
> > > return NFS4_OK and silently set the wrong channel binding.
> >
> > How's this:
> > client sends BIND_CONN_TO_SESSION with FORE_OR_BOTH, server select
> > FORE channel. connection breaks before the reply gets to the client.
> > Client resends. Is the server suppose to now fail with ERR_INVAL?
> >
> > There actually is such a thing between demand and request. FORE and
> > BACK are demands and FORE_OR_BOTH and BACK_OR_BOTH are requests. The
> > spec writes only about demands and not the requests. I believe that's
> > intentional because BIND_CONN_TO_SESSIOn doesn't have a sequence and
> > not protected by reply session semantics.
>
> OK. However if we take that interpretation, then the question is why
> would the server downgrade our FORE_OR_BOTH to FORE and what is the
> point of the client even retrying at all in that case?

As far as I can tell, the client behaves improperly. It shouldn't have
sent an operation on a new connection before sending
BIND_CONN_TO_SESSION.

> The server can always reject the client's back channel creation
> attempt, but doing so has consequences: it means there is no way to
> hand out delegations or layouts. So I'm confused by the concept of a
> server that sets SEQ4_STATUS_CB_PATH_DOWN or
> SEQ4_STATUS_CB_PATH_DOWN_SESSION, but then doesn't allow the client to
> set a back channel.

Because we can't guarantee that BIND_CONN_TO_SESSION happens as the
first operation, I think the solution is for the transport that will
do FORE_OR_BOTH request, the client must reset the connection first?
Would that be acceptable?


>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

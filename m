Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3488C1B662C
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDWVeD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVeD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Apr 2020 17:34:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC00C09B042
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 14:34:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so5557265edv.8
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2020 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JetrndrjXm4FltrmWDY/38dXvb5H7C3bsdUWEcC0AEk=;
        b=EgPJbCBPUUNlkPyWnf6jmjVEaCvAdIha1IPl5I49Y5EjQbdWa9DpU8kc3+we9A1KvO
         0objzHLkvzEacbk9QvJE1Y6zbr1OLb0lluNg/RW8nIXBu8PTonswrgGn83ScBz7woRus
         apdNg4bc3TszvX/cgzmzYrWtqwMcT0FfFnOtVOMraZ34bxHFueSbhAQfFg0RZCozYkiJ
         XHl3a72/SLMk+OcXu3qQUWzmXOiZ/qinPOawvc32cSGzArb41F2UO15BACBBpmfrLjpv
         1Prb6YgSszzLiG3FxkJVnRT3u/3PDHgopkkvSOSeRC5SRyq8Lw6R9+FdkGS7J7mN4Gm7
         dEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JetrndrjXm4FltrmWDY/38dXvb5H7C3bsdUWEcC0AEk=;
        b=CycsvXDLLh+rLbOoIue8KvH0FaEF1yYB/iSlfG3Hpmr9/qfTswRLyeolq1NfYHz0Lv
         SVuKWiZ8GuxsKXVCea0SAaYn7OlS7W01kwF3nLHkqzuD4Djyxlo6UiUh0Set+ezLnliU
         soTOSOccjer43pRbpNJTZn0+fuoMLkaIOWvLwc3+KLZ+rWmM3RYRkXW3L6wHhQGvrAJ2
         krED3BAX0m3sY0iw6ErTVxCXxf0++aJzS06UxLqm/Zdq98AHTD2OnJ0magrxtK1zV/Td
         HjKHfLs9YJYfXA41D9TRGgJILLZYuzFiI2zUCDrErkcft08qZAEY9y/SP4S8yJb35cTN
         CIYg==
X-Gm-Message-State: AGi0PuY26Rg1LjPPd3jnt3sdkXYCLMDm8QxQi8Uz5aU996J4VIfGulli
        RTebJ0jGwb62Vyoqw7/YALjYuubPepG4IK4ruqg=
X-Google-Smtp-Source: APiQypJGW8bq+7wfdBFQFp42+2Z6GdcOf1xofnJeGKipw+6IbvvlFh4akT97ij0WblUqMKCEbMCsUIAKmGgQq6Iiu58=
X-Received: by 2002:aa7:cd06:: with SMTP id b6mr4440210edw.67.1587677641721;
 Thu, 23 Apr 2020 14:34:01 -0700 (PDT)
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
 <CAN-5tyE2ix4urwhFN_ctcPoTwDrWu5jM2gEbuD4cvc-_k6NVvg@mail.gmail.com>
 <fbd6f65b176449e7a1abd5731361ad4e6fa15900.camel@hammerspace.com>
 <CAN-5tyFtUgiDe=5q0p61Cdpb8Z6QcWkMtxSFj3bs=ra-LiNWUw@mail.gmail.com> <f428e641a062c18c2fcf87a662791cc1711d93c3.camel@hammerspace.com>
In-Reply-To: <f428e641a062c18c2fcf87a662791cc1711d93c3.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 23 Apr 2020 17:33:50 -0400
Message-ID: <CAN-5tyFazxkCTbj9MspP18ACuZzPfP8q-Kr0PLdQEaQXQy0Hkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 21, 2020 at 5:20 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-04-21 at 15:47 -0400, Olga Kornievskaia wrote:
> > On Mon, Apr 20, 2020 at 5:20 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Mon, 2020-04-20 at 15:35 -0400, Olga Kornievskaia wrote:
> > > > On Mon, Apr 20, 2020 at 3:02 PM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > > On Mon, 2020-04-20 at 10:59 -0400, Olga Kornievskaia wrote:
> > > > > > On Mon, Apr 20, 2020 at 10:53 AM Olga Kornievskaia <
> > > > > > olga.kornievskaia@gmail.com> wrote:
> > > > > > > Yes we are consistent in requesting to same connection to
> > > > > > > with
> > > > > > > the
> > > > > > > same channel binding, but we don't send
> > > > > > > BIND_CONN_TO_SESSION as
> > > > > > > the
> > > > > > > first thing on the "main" connection (ie connection that
> > > > > > > cared
> > > > > > > the
> > > > > > > CREATE_SESSION and was bound to fore and back channel by
> > > > > > > default).
> > > > > > > When that connection is reset, the first thing that happens
> > > > > > > is
> > > > > > > the
> > > > > > > client re-sends the operation that was not replied to. That
> > > > > > > has
> > > > > > > a
> > > > > > > SEQUENCE and by the rule the server binds that connection
> > > > > > > to
> > > > > > > the
> > > > > > > fore channel only (and sets the callback being down). We
> > > > > > > then
> > > > > > > send
> > > > > > > BIND_CONN_TO_SESSION and request FORE_OR_BOTH where this
> > > > > > > has
> > > > > > > already been bound to FORE only.
> > > > > > >
> > > > > >
> > > > > > How about this: before we send BIND_CONN_TO_SESSION with
> > > > > > fore_or_both, we somehow always reset the connection (maybe
> > > > > > you
> > > > > > were
> > > > > > suggestion that already and i wasn't following).
> > > > >
> > > > > No. I didn't realise that we were being automatically set to
> > > > > just
> > > > > the
> > > > > fore channel. However as I said earlier, the spec says that the
> > > > > server
> > > > > MUST reply with NFS4ERR_INVAL in this case. It is not allowed
> > > > > to
> > > > > just
> > > > > return NFS4_OK and silently set the wrong channel binding.
> > > >
> > > > How's this:
> > > > client sends BIND_CONN_TO_SESSION with FORE_OR_BOTH, server
> > > > select
> > > > FORE channel. connection breaks before the reply gets to the
> > > > client.
> > > > Client resends. Is the server suppose to now fail with ERR_INVAL?
> > > >
> > > > There actually is such a thing between demand and request. FORE
> > > > and
> > > > BACK are demands and FORE_OR_BOTH and BACK_OR_BOTH are requests.
> > > > The
> > > > spec writes only about demands and not the requests. I believe
> > > > that's
> > > > intentional because BIND_CONN_TO_SESSIOn doesn't have a sequence
> > > > and
> > > > not protected by reply session semantics.
> > >
> > > OK. However if we take that interpretation, then the question is
> > > why
> > > would the server downgrade our FORE_OR_BOTH to FORE and what is the
> > > point of the client even retrying at all in that case?
> >
> > As far as I can tell, the client behaves improperly. It shouldn't
> > have
> > sent an operation on a new connection before sending
> > BIND_CONN_TO_SESSION.
> >
> > > The server can always reject the client's back channel creation
> > > attempt, but doing so has consequences: it means there is no way to
> > > hand out delegations or layouts. So I'm confused by the concept of
> > > a
> > > server that sets SEQ4_STATUS_CB_PATH_DOWN or
> > > SEQ4_STATUS_CB_PATH_DOWN_SESSION, but then doesn't allow the client
> > > to
> > > set a back channel.
> >
> > Because we can't guarantee that BIND_CONN_TO_SESSION happens as the
> > first operation, I think the solution is for the transport that will
> > do FORE_OR_BOTH request, the client must reset the connection first?
> > Would that be acceptable?
> >
>
> It sounds like we have no choice. However in that case, we should not
> try to recover in the case where the attempt to bind the backchannel
> fails.

I can't get the client to reset the connection. Is calling
xprt_force_disconnect() suppose to do that? If so, then that doesn't
happen. I have tried calling into xprt->ops->close(xprt) but that
leads to badness as well... Any suggestions of how to get connection
reset? Is xs_reset_transport() it? It's hard to figure out how all
these functions are different when their names imply connection
resetting...

Thank you


>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

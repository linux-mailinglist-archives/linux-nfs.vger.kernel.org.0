Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30F1B15FD
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 21:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTTf7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgDTTf7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Apr 2020 15:35:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9D8C061A0C
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 12:35:58 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n4so8920737ejs.11
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 12:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIXT/nen65mTLodO9B/B9/+qbC33sEhKE4+BiIiYU8Y=;
        b=asPkGDADSFCfHK2y8qlrjFLRSroUX4k5qpEkFFHn0D3ihnAkJNXlGB2ajSS3AWjoV5
         srSM1BCx+wDW6bdeJ5mpiSXsDwm7GcZ+Lg79Igr50P9UuCNkwGyTh5NYsR0jj1M0Fs2P
         P5ka3uDC0ZeWpRzXqyXm7cYo/0CX86yggdAEbHz+jYIcwk6iZeyxtrxx+tnqH/cp8oAf
         Nujp+5j42SqWf/DP+IQe/tfCzcg2Ti3XCchdmg15PZZ8aOaRejWzu2/uMjrKY3BbfYvZ
         zMOzCxjzUNvGSNP3nGe3Q1XRxDrkT5/lI6RX2bivsaa/i67/j9VURQBE8MSv6tkw6pyY
         HbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIXT/nen65mTLodO9B/B9/+qbC33sEhKE4+BiIiYU8Y=;
        b=hmALSaubDnxqoDi6Nt/0igwA8IOVmw/oRnIkHJlLnyU+/Ar0tEJN8d9SyTa6nRRD4B
         6GDV+VyePQb99h0p0bMy3Qh1hFU+J0Q/VcrE0BspQXibMRwUBsBeAu8kokLEsh9DA9k3
         mnEoE/NFkm+j8emOoklmWPFReWEeL/Hja91ptnDYWZnmISSHHgtn8HXJJK77FqXOTl7u
         XcuGzqDiNLuUT3a+ivUSDVo2dA7YBKd5RE/QkIHZaupKZ9czGTmAY5VZiEOHKePERa9C
         h0UPpkm7pJkv+9jYgx5pq+Tm2oef7h4Ga+J5xsi9dAWBMvdE8hApk4qMrlnMA0jUngTi
         kcYA==
X-Gm-Message-State: AGi0PuYr46hsT9hX39K/vRLz+0T3VuExTHTcxHDjkhpapEWA8G0qAJtT
        a67xHn8+8fS3xXhETy33GzGo9aUinHqi5rDZBE7hIQ==
X-Google-Smtp-Source: APiQypJ5wL2MFLOzoGqtHHAEH/vxKgjZpUA7i3xanX235JRCCjDFKOjkrEyjDDsCSFX4nUH7Pz5pKVChWy2dcxfw4Jg=
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr18170655ejo.244.1587411357533;
 Mon, 20 Apr 2020 12:35:57 -0700 (PDT)
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
 <CAN-5tyFLusaQbzw2uN9DUtytrWsuQrrYGz44X=Cvj1WS=gD=Hg@mail.gmail.com> <2e691fb93a4b6d362cdfd85feaaa9cfbfc68709c.camel@hammerspace.com>
In-Reply-To: <2e691fb93a4b6d362cdfd85feaaa9cfbfc68709c.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 20 Apr 2020 15:35:46 -0400
Message-ID: <CAN-5tyE2ix4urwhFN_ctcPoTwDrWu5jM2gEbuD4cvc-_k6NVvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Apr 20, 2020 at 3:02 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2020-04-20 at 10:59 -0400, Olga Kornievskaia wrote:
> >
> >
> > On Mon, Apr 20, 2020 at 10:53 AM Olga Kornievskaia <
> > olga.kornievskaia@gmail.com> wrote:
> > >
> > > Yes we are consistent in requesting to same connection to with the
> > > same channel binding, but we don't send BIND_CONN_TO_SESSION as the
> > > first thing on the "main" connection (ie connection that cared the
> > > CREATE_SESSION and was bound to fore and back channel by default).
> > > When that connection is reset, the first thing that happens is the
> > > client re-sends the operation that was not replied to. That has a
> > > SEQUENCE and by the rule the server binds that connection to the
> > > fore channel only (and sets the callback being down). We then send
> > > BIND_CONN_TO_SESSION and request FORE_OR_BOTH where this has
> > > already been bound to FORE only.
> > >
> >
> >
> > How about this: before we send BIND_CONN_TO_SESSION with
> > fore_or_both, we somehow always reset the connection (maybe you were
> > suggestion that already and i wasn't following).
>
> No. I didn't realise that we were being automatically set to just the
> fore channel. However as I said earlier, the spec says that the server
> MUST reply with NFS4ERR_INVAL in this case. It is not allowed to just
> return NFS4_OK and silently set the wrong channel binding.

How's this:
client sends BIND_CONN_TO_SESSION with FORE_OR_BOTH, server select
FORE channel. connection breaks before the reply gets to the client.
Client resends. Is the server suppose to now fail with ERR_INVAL?

There actually is such a thing between demand and request. FORE and
BACK are demands and FORE_OR_BOTH and BACK_OR_BOTH are requests. The
spec writes only about demands and not the requests. I believe that's
intentional because BIND_CONN_TO_SESSIOn doesn't have a sequence and
not protected by reply session semantics.

> On the client we should probably do something to track whether or not
> the backchannel has been lost due to connection breakage. We probably
> need to allow the client to check the xprt->connect_cookie to find out
> if the connection broke.
>
> > i don't think this is going to the list as i'm getting auto
> > rejections emails but i don't know how to fix it.
>
> You need to turn off HTML mail.

hm.. google tells me it's plain text mode for the message... so i'm not sure.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

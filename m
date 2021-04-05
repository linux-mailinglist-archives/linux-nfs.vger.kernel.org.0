Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE5E354387
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 17:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhDEPnL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbhDEPnL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Apr 2021 11:43:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DE4C061756
        for <linux-nfs@vger.kernel.org>; Mon,  5 Apr 2021 08:43:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id n2so11145765ejy.7
        for <linux-nfs@vger.kernel.org>; Mon, 05 Apr 2021 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLHYEu1LBmgkJ918IQzQHg8JqWYDdPLs8g2w07Z+ohU=;
        b=Vp5LBeCYsXoK+fSCXzoQTbKkhfH6Eu8UuDhwNqjoZ8S6Dl+Jy/6hEz8k/0dZ6wXY36
         8XRRbMidq4gOvO/bON9RXlYk34A0AF29AKsnP76mxwoWCwLUewkmDkkP/WTAPtVgBE3d
         9TKhY5dfRV1iWpm1yUoNkSSq+tFKoB9dRmZsH/F5pFKiR59O9ToMp/xBXeS548r72z7I
         9q6ApEvRyKpmx8KynUTgzn121Hu6mewgw9u0gKJ4wm1afmoTipjEshvsPtC00JSmYq1m
         CTHAZRewNMqgGf1mtMNA6UkIV/IW2ZnZEoFt8RuMCuKzJozA7nV3nDlxoIV2/h1GxPVg
         nJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLHYEu1LBmgkJ918IQzQHg8JqWYDdPLs8g2w07Z+ohU=;
        b=qkFvJpmTR6bP6RWSa6IycZ2kjNoCjg4r/dg2FvDYDD+gRsNsiElnydDl6SK0uI1577
         XZn756nX8nYpQkP02yqCQYuS29YTpdpi4Ch/d+O5t5WIVVNRSfKBH9gukOsTp0FMYEz6
         2OLM/Re3O9vdSiW6TTGeXfL5xi8LBnoJROficLpiS4hemLM4fPXmzkRU9W6/VQqHaJ//
         CDkA7tIHTUWT1YW+eTdO19NzIks/N+C9HxRnl0rlMWELOM3US1eltS/7dO4en48f36MN
         wPu2vKOQz8+3LHAuQ7jIb2FZyr7vMflPiE09q8EriRRK2jWdnvohfaU1huA7yaJC05Za
         Lclw==
X-Gm-Message-State: AOAM531bLkFf4/wpZSmjv2lpcWJvid+FHIB3wF3vgLwcSJHih3FDixfq
        gF1B+SEVYHyv0Ndo1CZ1XdGu9zVogm44wurXlHc=
X-Google-Smtp-Source: ABdhPJzMNcoa/aIpNjhHl5T/D7IO3Lxr48qMcum8gIHQHQqjaUXEPrBG8TXDrLXd2NeSb0lMzA64m/hbpoCKH1RBzhc=
X-Received: by 2002:a17:906:b20b:: with SMTP id p11mr29474767ejz.0.1617637383441;
 Mon, 05 Apr 2021 08:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <YQXPR0101MB0968DDE7E5E916B2397FBFCBDD789@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YQXPR0101MB0968DDE7E5E916B2397FBFCBDD789@YQXPR0101MB0968.CANPRD01.PROD.OUTLOOK.COM>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 5 Apr 2021 11:42:52 -0400
Message-ID: <CAN-5tyGLt9G-Pyy9odRnukVQ4rtKLKikpDmknfy2=_GF=cjtuw@mail.gmail.com>
Subject: Re: [nfsv4] what defines a TCP connection as new, requiring BindConnectionToSession?
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "nfsv4@ietf.org" <nfsv4@ietf.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Apr 3, 2021 at 11:21 PM Rick Macklem <rmacklem@uoguelph.ca> wrote:
>
> Hi,
>
> I have been doing testing of network partitioning between a
> Linux client (5.2.10) and a FreeBSD server and have observed
> the following:
> - If I unplug a net cable for a few minutes and the plug it
>    back in, the Linux client does a TCP "SYN", expects "SYN, ACK"
>    and then continues on, using the same port# as before the
>    network partitioning.
> --> I had assumed the above created a "new connection" that
>        will only be bound to the backchannel if a
>        BindConnectionToSession is done on it.
> Now I am not sure if this is considered a "new connection" or
> the same connection (same port#) still bound to the back channel?

My understanding is that the client has created a new connection
regardless if it reused the source port. At this point this connection
is not bound to anything until either the client sends something with
a SEQUENCE in it which will make it bound to the forechannel or the
client must send as the first operation BIND_CONN_TO_SESSION asking
for both and/or backchannel binding if the client wants to have this
connection bound to the callback channel.

> I am also wondering about this para. in RFC5661 pg. 493:
>    Invoking BIND_CONN_TO_SESSION on a connection already associated with
>    the specified session has no effect, and the server MUST respond with
>    NFS4_OK, unless the client is demanding changes to the set of
>    channels the connection is associated with.  If so, the server MUST
>    return NFS4ERR_INVAL.
> Since a "new connection" is bound to a session's fore channel by
> sending an RPC with Sequence in it, does this imply that a
> BindConnectionToSession done on a connection to bind a back channel
> after an RPC with Sequence in it has been done on the connection,
> must fail with NFS4ERR_INVAL?

That's correct as per my understanding. If a client established a
connection, then say it sent something already with a SEQUENCE and
then tried to send BIND_CONN_TO_SESSION asking for the backchannel to
be bound to this existingconnection, the server must error with
ERR_INVAL. I had to fix the linux client for this as the client was
trying to change the backchannel binding after the channel was already
bound to just the forechannel.

> As you can see, knowing what constitutes a new TCP connection matters.
>
> Thanks in advance for any help with this, rick
>
> _______________________________________________
> nfsv4 mailing list
> nfsv4@ietf.org
> https://www.ietf.org/mailman/listinfo/nfsv4

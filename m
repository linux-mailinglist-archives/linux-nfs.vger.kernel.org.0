Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308393B737A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhF2Nu4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhF2Nux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 09:50:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EFDC061760
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 06:48:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i24so31378846edx.4
        for <linux-nfs@vger.kernel.org>; Tue, 29 Jun 2021 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPY8XUsbQs34luJ1j/FZlv4+IRmgrVaRyluyReYT/HM=;
        b=LFw6vVp38NRTCIYJ5kqYbg3XAONp4B4GDnpy0cJRDoxIt04CYJJ7rov59Y+AP8XEUT
         q8kaZ/mM4WWqlBfOr053LA+/5NmNqsltmZDisg0qReEPTMXWMU+F6PMatNpqnU5iuyHk
         1px2irNW0fERM0kFX3MAGiXX6E2eQusNk8InhefGUTXqPQZTkzCNHkcYI4Xw9q4XCNEZ
         ccLZYruYzja+RlPFuI9CG7B7duscEBptla1Zj7U/gybexMp6msZ2iKecHutoG9rVf8jp
         MHw3dMX2SajG0XcnHU/eyPKT+0/sf1YBouMD1RZLWKjuzRsrj1w6wZPyjY2ny8bFLUy6
         Qi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPY8XUsbQs34luJ1j/FZlv4+IRmgrVaRyluyReYT/HM=;
        b=khVFlEj5w5rdRwPiniZWsbL2q+8yLBQRPWYk9D3cYPX7zTufFhaFJsOt0t5XQF/tgH
         W+y/d7bmIorK/D/3BtlKXeFhijQ2SC1DOaX2jSGSeQKa3wg9vinK1qnlFA4z2DEcdUPX
         9y4zjR8qreZ5zCDK36Z0zsbJLsE5cfmm6Nn0LLvDl5xTQbzyXe1WF7zll0vGJxAd6qe6
         06UtE00P+Nwtt/sRMM0IPqFiMfaz1RKN/yc287eCMLVqpi4zFcw9wMqXcXYmmpP9wLJr
         gEbS5xD7ljRZC8KGet94M3lQ0frq0k9XonTxIWkuW3qKdAbaq1ox1ivGce+SovXEGTw5
         CxSw==
X-Gm-Message-State: AOAM533JXzuHmL9+WJQBQAxqGthtOcB6LtkJjEdukNwri82+KjgJkirm
        H5mCFYPhhvHdwYGszFQElHBwfnijcCOE6bW3URQ=
X-Google-Smtp-Source: ABdhPJx1woJjWHEPZylgUdHHTA9Xt11I+KXJjOzKNc76KJBukFTlhfaLIM8xbeCaYqO3aXQHipVbfLDvT02giggAaR4=
X-Received: by 2002:a05:6402:148d:: with SMTP id e13mr1496420edv.28.1624974502555;
 Tue, 29 Jun 2021 06:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
 <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com> <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com>
In-Reply-To: <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 29 Jun 2021 09:48:11 -0400
Message-ID: <CAN-5tyE5Y3+ZPrfAR8=UVdNnWxyzO6a_NTeTsMFH_TyyMqK-bQ@mail.gmail.com>
Subject: Re: client's caching of server-side capabilities
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 29, 2021 at 8:58 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 28, 2021, at 6:06 PM, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Mon, 2021-06-28 at 16:23 -0400, Olga Kornievskaia wrote:
> >> Hi folks,
> >>
> >> I have a general question of why the client doesn't throw away the
> >> cached server's capabilities on server reboot. Say a client mounted a
> >> server when the server didn't support security_labels, then the
> >> server
> >> was rebooted and support was enabled. Client re-establishes its
> >> clientid/session, recovers state, but assumes all the old
> >> capabilities
> >> apply. A remount is required to clear old/find new capabilities. The
> >> opposite is true that a capability could be removed (but I'm assuming
> >> that's a less practical example).
> >>
> >> I'm curious what are the problems of clearing server capabilities and
> >> rediscovering them on reboot? Is it because a local filesystem could
> >> never have its attributes changed and thus a network file system
> >> can't
> >> either?
> >>
> >> Thank you.
> >
> > In my opinion, the client should aim for the absolute minimum overhead
> > on a server reboot. The goal should be to recover state and get I/O
> > started again as quickly as possible.
>
> I 100% agree with the above. However...
>
>
> > Detection of new features, etc
> > can wait until the client needs to restart.
>
> A server reboot can be part of a failover to a different server. I
> think capability discovery needs to happen as part of server reboot
> recovery, it can't be optimized away.

Can you clarify what you mean by a "failover to a different server"?
To do reboot recovery it has to be the "same" server (by the
definitions of the RFC). My use case I was thinking of was a reboot of
the "same" server (major, minor, scope same) but with new features but
of course one could argue if it has new features it's no longer the
"same" server. I think you are probably thinking about migration or
are you thinking of telling a difference between session trunkable
servers which are considered to be the same but since it's a different
IP it might have different capabilities?

Thank you for the feedback!

>
>
> --
> Chuck Lever
>
>
>

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23A3435053
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTQjo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJTQjn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 12:39:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCAC06161C
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 09:37:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g10so27606648edj.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ9AaBcF3Owlwwsa14pA64T4lvNly106zJ1l9eYbveM=;
        b=N1cb7MJ28VsYbBO6bEBPOu2UjditeIzwreOE3qlk2B1cVHNLgwPDVObmjaPjGPg5z/
         xf9pqiRklPUptpIfuYcpP+IB9WMbLX0uGOi3ojLIOZXtlTpfIbw7SnVdWFOygQZ1WiiC
         iyMifpwhNT0mWqg+ROgA7hABTup179o7LKRXHp+CtOe6milXzvGpp6oeB1+ifHEZ/yhx
         yZoCy8sDAEcbgKoZDdhKQgBLSjuLQJcNpbEj/GNgi0GtLppgOvd93FzZZ/t3Qc/90I2h
         3m9Qj7bzNBHeenyBuE8jra0/hGlnaCcnbUXh7xo+gnmaqCFwpSHVLlriWPGCFNB4IDFy
         yDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ9AaBcF3Owlwwsa14pA64T4lvNly106zJ1l9eYbveM=;
        b=XumstNIcq6tIToJNzz6ZavmbhoE9Hg6VxSfe7Y1axDi1WvEdvDT2bEuLrYwULDNtuO
         2ezNsDDwpC3iooyRkhNFDShHRRvzfDYeerUzcsiByPeEfXcmuYiN5VwSdyhKYxH+voWB
         4girsp4VmnU6rs5tqY4Tkf6Vgt+f7EHpshowVlqpuO+7EAevgnXaInazGa4K0+G/6kXk
         B0teXQlfBOC5oMR24WAfzXfNUKU+gL9QhCtWEO+3+D8Qbyg+ezarJxF09jAd5ai1AT4O
         760l6JDe/VqnQTKsDI4uTBBBjVpzj7J/Dg3qu8rr5BNLPtEsnrjs0A9m/XIzD/J5F/gf
         CAYw==
X-Gm-Message-State: AOAM531dUQijuuf3X2CpN3WVp6EsTIvBKqds1KnxwNhsSIik7iGyhPaP
        QJyu0RzziTpiy5kkf2oXV2nkGYMJmqVzsPHkjwI=
X-Google-Smtp-Source: ABdhPJy5Qic9NkknVytuwXIDAvm/BtKSN0PwD4xpMtoDrckHvlIT329rZuXrWK3Jw4Hbi+5HpIHi0FlKDNPwvq2iLU0=
X-Received: by 2002:a05:6402:510c:: with SMTP id m12mr5893edd.33.1634747839956;
 Wed, 20 Oct 2021 09:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211020155421.GC597@fieldses.org>
In-Reply-To: <20211020155421.GC597@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 20 Oct 2021 12:37:08 -0400
Message-ID: <CAN-5tyHuq3wmU1EThrfqv7Mq+F5o0BXXdkAnGXch_sYakv=eqA@mail.gmail.com>
Subject: Re: server-to-server copy by default
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Dai Ngo <dai.ngo@oracle.com>,
        Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 11:54 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> knfsd has supported server-to-server copy for a couple years (since
> 5.5).  You have set a module parameter to enable it.  I'm getting asked
> when we could turn that parameter on by default.
>
> I've got a couple vague criteria: one just general maturity, the other a
> security question:
>
> 1. General maturity: the only reports I recall seeing are from testers.
> Is anyone using this?  Does it work for them?  Do they find a benefit?
> Maybe we could turn it on by default in one distro (Fedora?) and promote
> it a little and see what that turns up?
>
> 2. Security question: with server-to-server copy enabled, you can send
> the server a COPY call with any random address, and the server will
> mount that address, open a file, and read from it.  Is that safe?

How about adding a piece then on the server (a policy) that would only
control that? The concept behind the server-to-server was that servers
might have a private/fast network between them that they would want to
utilize. A more restrictive policy could be to only allow predefined
network space to do the COPY? I know that more work. But sound like
perhaps it might be something that provides more control to the
server.

But as Chuck pointed out perhaps the kerberos piece would make this
concern irrelevant.

> Normally we only mount servers that were chosen by root.  Here we'll
> mount any random server that some client told us to.  What's the worst
> that random server can do?  Do we trust our xdr decoding?  Can it DOS us
> by throwing the client's state recovery code into some loop with weird
> error returns?  Etc.

Client code has been modified to know about special copy stateids that
if the client gets BAD_STATEID it knows not to try to do recovery and
instead it errors back to the "application", it being nfsd.

> Maybe it's fine.  I'm OK with some level of risk.  I just want to make
> sure somebody's thought this through.
>
> There's also interest in allowing unprivileged NFS mounts, but I don't
> think we've turned that on yet, partly for similar reasons.  This is a
> subset of that problem.
>
> --b.

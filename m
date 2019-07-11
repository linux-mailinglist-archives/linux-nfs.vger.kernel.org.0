Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39983660B5
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 22:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfGKUeJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jul 2019 16:34:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42221 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbfGKUeJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Jul 2019 16:34:09 -0400
Received: by mail-vs1-f67.google.com with SMTP id 190so5188180vsf.9
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2019 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UmpUdFDSyfV0VdNmHpQne3VVYifLrc/YIDRgRrTt6I=;
        b=i7z3yzmbmFBafFaX08caQ4SROrIFiQTrDnItLBqvnZGZOjMpqz5Q4LhQHF3SmsLuTz
         8+6Tq9VAAOrtYaXd5vyEfXKd7IH6wslms6s2cZd/tfdljmL4z+ib4iDbfafhbR0yhcpl
         a+6n6YyEkIulyW8pqhuGdllKwE+ZNzi8OFYBkPFZlK+Fd0CfvR0K0tFVEkX7a04inJlL
         mUIXShduX0sCxatEa8yMyUAW2RA9CWxmShglEgcr83baKrYZZKajoWJZuSGbiVHfe2en
         iI0n++3fKbMvKjZD1F3z75DGTXdelF8zE7tUDILIIo77h/JrS7uufFvOBkza3D32VyW8
         WDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UmpUdFDSyfV0VdNmHpQne3VVYifLrc/YIDRgRrTt6I=;
        b=WmciY2i3kzwlqTx6aBQrrLTrKbOKbUZqSzXOykURDxnvYjkjml7i0Qz3U0VPsCZGM0
         QyTQp7JGKWy4Tuzb0vdQe1qre/3e6zlhr8SuQpNZtU0O65aap2Zz3x2/mA2qPmISfO1n
         Mpq8RurbgW2/McH+IHvw1tjdmJfjNkPPdF6JMRBLzEp7QNB/vPKzxM4gPoQ5GNsZtz3P
         AiI8+2fCbP/4jOW0ot6UXkoLX6fE8O5ZIVWg0akB9F3b5dExoibF46700CZizf5ETD1z
         4VRw6g4eLHbs7reRa3RDR5UMIW7CMHXv1oWheZg51zn72QXNantlVNoRY9YSCMHT6J3e
         l6iw==
X-Gm-Message-State: APjAAAUmUmJRS4oOKbBQr/0+IlnFKdAkEqwrg6bhEZV6CL3ZhaLEPb/A
        G663h9kWURdDV/ymJ5zMfhRnl47tGa95qaFe/iGF4HR7
X-Google-Smtp-Source: APXvYqxY1P9cgKGG01XzumzBFPbtI6BgV57qqT4R/Ngy8Yq6JnSIWUGjev4qVpAweOqboJwSxGBVk8TdRCa5hw4XzrQ=
X-Received: by 2002:a67:79d4:: with SMTP id u203mr6286329vsc.85.1562877248465;
 Thu, 11 Jul 2019 13:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
 <1d019c416f69aa7f3ba7fed3bcfd4c08088fba57.camel@hammerspace.com>
In-Reply-To: <1d019c416f69aa7f3ba7fed3bcfd4c08088fba57.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 11 Jul 2019 16:33:57 -0400
Message-ID: <CAN-5tyG0jdyn8C11v6b8=v3d1p=WoMAhXrAw8mWGEUn-TVXJ=g@mail.gmail.com>
Subject: Re: multipath patches
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "neilb@suse.com" <neilb@suse.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 11, 2019 at 3:29 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2019-07-11 at 15:06 -0400, Olga Kornievskaia wrote:
> > Hi Trond,
> >
> > I see that you have nconnect patches in your testing branch (as well
> > as your linux-next and I assume they are the same).  There is
> > something wrong with that version. A mount hangs the machine.
> >
> > [  132.143379] watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
> > [mount.nfs:2624]
> >
> > I don't have such problems with the patch series that Neil has
> > posted.
> >
> > Thank you.
>
> How are the patchsets different? As far as I know, all I did was apply
> the 3 patches that Neil added to my existing branch.

I'm not sure. I had a problem with your "multipath" branch before and
I recall what I did is went back and redownloaded your posted patches.
That was when I was testing performance. So if you haven't touched
that branch and just used it I think it's the same problem.

In the current testing branch I don't see several patches that Neil
has added (posted) to the mailing list. So I'm not sure what you mean
you added 3 of his patches on top of yours. At most I can say maybe
you added 2 of his (one that allows for v2 and v3 and another that
does state operations on a single connection. There are no patches for
sunrpc stats that were posted).

What I know is that if I revert your branch to
bf11fbdb20b385157b046ea7781f04d0c62554a3 before patches and apply
Neils patches. All is fine. I really don't want to debug a non-working
version when there is one that works.



>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

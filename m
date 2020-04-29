Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49C1BD219
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 04:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD2CMn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 22:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2CMn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Apr 2020 22:12:43 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABCAC03C1AC
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 19:12:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so302283ejx.5
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8VNVhrdGPuxCV0F2/QOjSKfMyzp+lZcEy/ZU+MtTnk=;
        b=VLmzff7EDQTQveYC+QfUZmy4pCEfZ+F+463kkmOjpZngO1i+BS8lCxrdMEHDiW0fWq
         XshCSgK9fEXxGZK0/DQbqjQl0uGg2FpSStEU3W5+xTOBCpk9kWdeLiE/Ge0lBTq6ef6I
         K9KYt4eR/qQXgBT/qugaWruGM1j359D5CsBKgke7ii7PrIjhFdsGSzmNKAzkbi6L9oGp
         8Y/33TNys3za05jZkSi8G3D+Aanm4DT8BXgVOUMf0mvHZGmEUUpjOSlQUCERnoA20XfF
         D/oBb/dLGlewVIr1p/fjyOgctTIktwj3HwoIQJ4l1pgBWVMceMZFES256ECeQEBI1wLO
         CqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8VNVhrdGPuxCV0F2/QOjSKfMyzp+lZcEy/ZU+MtTnk=;
        b=oqQN+Jb0jkK5/DpKTgedQUpXRRqcR/+5OtfO/r0uXndjne2ELR3Vb7eJDyhlGwZRE/
         4FqFK4m40p86cwDcOTOkC9agGx3E2xBVdDIv9tmj6OZRJfpfZLA02ZlppEBjsb8Qt6Ea
         l8HUOI/31T6hjOwIGAZgg0h096k4Bxpwek0ge/3ZWrvGWRuAvYL6xPNAQO/17B/f4Mj1
         J7Ufa3a9eK4Da+QOu+cbHs50W/pMkFkvLY/KsUkKpcGgNLnEPwx+QLYHnCPTqw5S4k8W
         /gnb52uEFsxuOJZAUKSBsqG4bCl4pDZGshnoyqwQO41WnLwNCpPLxNdj+sQxDjJSVn0l
         0Qhg==
X-Gm-Message-State: AGi0PuZ4V8LABoVJ5tiqcEDmgvivkC4CUEiUR3UapYkL2IP5ALNRWakx
        kzWFHbuI6a8k5/J5iskw978OXd0dIUxWaRjaC5I=
X-Google-Smtp-Source: APiQypK9m989cTh43FwwoMGWX6AZ5EUdGmNFe6JO2GABoAqIswHW4Fn7NqtcWAMr/YYj7fH4OUoNauHeclRXo4S08qU=
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr581559ejc.215.1588126360048;
 Tue, 28 Apr 2020 19:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
 <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
 <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
 <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com> <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
In-Reply-To: <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 28 Apr 2020 22:12:29 -0400
Message-ID: <CAN-5tyFRDg7W9pt57jTzoRgL8L=0_d7gCoRiAqWQR36iny33NQ@mail.gmail.com>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 28, 2020 at 7:56 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-04-28 at 19:41 -0400, Trond Myklebust wrote:
> > On Tue, 2020-04-28 at 19:02 -0400, Olga Kornievskaia wrote:
> > > On Tue, Apr 28, 2020 at 5:32 PM Trond Myklebust <
> > > trondmy@hammerspace.com> wrote:
> > > > On Tue, 2020-04-28 at 16:40 -0400, Olga Kornievskaia wrote:
> > > > > On Tue, Apr 28, 2020 at 2:47 PM Trond Myklebust <
> > > > > trondmy@hammerspace.com> wrote:
> > > > > > Hi Olga,
> > > > > >
> > > > > > On Tue, 2020-04-28 at 14:14 -0400, Olga Kornievskaia wrote:
> > > > > > > Hi folk,
> > > > > > >
> > > > > > > Looking for guidance on what folks think. A client is
> > > > > > > sending
> > > > > > > a
> > > > > > > LINK
> > > > > > > operation to the server. This compound after the LINK has
> > > > > > > RESTOREFH
> > > > > > > and GETATTR. Server returns SERVER_FAULT to on RESTOREFH.
> > > > > > > But
> > > > > > > LINK is
> > > > > > > done successfully. Client still fails the system call with
> > > > > > > EIO.
> > > > > > > We
> > > > > > > have a hardline and "ln" saying hardlink failed.
> > > > > > >
> > > > > > > Should the client not fail the system call in this case?
> > > > > > > The
> > > > > > > fact
> > > > > > > that
> > > > > > > we couldn't get up-to-date attributes don't seem like the
> > > > > > > reason
> > > > > > > to
> > > > > > > fail the system call?
> > > > > > >
> > > > > > > Thank you.
> > > > > >
> > > > > > I don't really see this as worth fixing on the client. It is
> > > > > > very
> > > > > > clearly a server bug.
> > > > >
> > > > > Why is that a server bug? A server can legitimately have an
> > > > > issue
> > > > > trying to execute an operation (RESTOREFH) and legitimately
> > > > > returning
> > > > > an error.
> > > >
> > > > If it is happening consistently on the server, then it is a bug,
> > > > and it
> > > > gets reported by the client in the same way we always report
> > > > NFS4ERR_SERVERFAULT, by converting to an EREMOTEIO.
> > >
> > > Yes but the client doesn't retry so it can't assess if it's
> > > consistently happening or not. It can be a transient error (or
> > > ENOMEM)
> > > that's later resolved.
> >
> > If the server wants to signal a transient error, it should send
> > NFS4ERR_DELAY.
> >
> > > > > NFS client also ignores errors of the returning GETATTR after
> > > > > the
> > > > > RESTOREFH. So I'm not sure why we are then not ignoring errors
> > > > > (or
> > > > > some errors) of the RESTOREFH.
> > > >
> > > > We do need to check the value of RESTOREFH in order to figure out
> > > > if we
> > > > can continue reading the XDR buffer to decode the file
> > > > attributes.
> > > > We
> > > > want to read those file attributes because we do expect the
> > > > change
> > > > attribute, the ctime and the nlinks values to all change as a
> > > > result of
> > > > the operation.
> > >
> > > I have nothing against decoding the error and using it in a
> > > decision
> > > to keep decoding. But the client doesn't have to propagate the
> > > RESTOREFH error to the application?
> > >
> > > In all other non-idempotent operations that have other operations
> > > (ie
> > > GETATTR) following them, the client ignores the errors. Btw I just
> > > noticed that on OPEN compound, since we ignore decode error from
> > > the
> > > GETATTR, it would continue decoding LAYOUTGET...
> > >
> > > CREATE has problem if the following GETFH will return EDELAY.
> > > Client
> > > doesn't deal with retrying a part of the compound. It retries the
> > > whole compound. It leads to an error (since non-idempotent
> > > operation
> > > is retried). But I guess that's a 2nd issue (or a 3rd if we could
> > > the
> > > decoding layoutget)....
> > >
> > > All this is under the umbrella of how to handle errors on
> > > non-idempotent operations in a compound....
> >
> > There is no point in trying to handle errors that make no sense. If
> > the
> > server has a bug, then let's expose it instead of trying to hide it
> > in
> > the sofa cushions.
>
> It basically boils down to this:
>  * I do not want to have to maintain a list of server bugs in the
>    client.

I also believe that client shouldn't be coded to a broken server. But
in some of those cases, the client is not spec compliant, how is that
a server bug? The case of SERVERFAULT of RESTOREFH I'm not sure what
to make of it. I think it's more of a spec failure to address. It
seems that server isn't allowed to fail after executing a
non-idempotent operation but that's a hard requirement. I still think
that client's best set of action is to ignore errors on RESTOREFH.

>  * If I make a client change, I don't want to have to consider whether
>    or not it causes a regression against some server that only 10
>    people are still using, and that never got a fix for a bug because
>    "the clients handle it".
>
> We should fix client bugs when it is clear that they are client bugs.
> We should push back hard on server bugs because the client is already a
> complex enough beast.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

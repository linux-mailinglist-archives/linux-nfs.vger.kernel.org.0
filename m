Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795EF7DD85
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Aug 2019 16:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfHAOMY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Aug 2019 10:12:24 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38279 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHAOMY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Aug 2019 10:12:24 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so48936410vso.5
        for <linux-nfs@vger.kernel.org>; Thu, 01 Aug 2019 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S7qpbFl4yBtopJaOaatFH506QberXO5oeFctRULGXE=;
        b=KtN/g7Dns4wV3rSS4imnZHHIVkIl3KTYi/zbghtxU7GnOOSXRajrt1BizT98ySv2Uv
         WgEa1FNY+0xoM8e6R93zOIZC8U+Ifb6Qs8Ud/dJUzuoQaio8q6MqlPrBBVCWRCKJHhq9
         vwmnafA2m6v0lqyrxb2NcXNt2qB5xI7vAH/asK12lhuiSI253avcqW2qmk1nvKGpXIAc
         m9G31TlTLgPtqP3Ya91PcJk1JVQ/qOY7WlQaoDe7pGAyPspSCr6Ch5NpKrdkyHN58JB/
         J+MKoVHfVR1I1IheXjFTfwWh1XqndhBl1zAMojJ2OnoohfReJBLTGgoi69RBBwQqjn9W
         3M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S7qpbFl4yBtopJaOaatFH506QberXO5oeFctRULGXE=;
        b=tsXDiq6QPzAP6tMb061YQPAk6Y4umNIOCpoHn85vwJFrsTanO76aU5Vdw7BWsZxU3K
         UaybEtVqeTsBjOqE+QycoTYdAXFfasYgt8Vjs9XB0vAHoMJ/Ud4egCGRMvHNn6/AK/7k
         9ihXUkPR3AYGO9DMeJG1VsDH2Ow1fr3p7huP635kFIuvSlb+n6lkASCx3JOHKCDiptnn
         6gyStcIp8doXk6mJoZpbWLRSDTUXcmxa1YfKn6XuTh/ItfdAREu/4WLQgb8u+0OIYKUe
         cL+ld9X7eSrRI0zBPxZ5+Gn3ukpfTVJNn8ehEFWGz08EA0ZYcIdMMLiCtgvw2vXFs+7Y
         xpMw==
X-Gm-Message-State: APjAAAW89+pMugYBDz7F61+q0tebgl13aZxucOBc/fLe5dZzHpXpdMr8
        nMUcS1qZC9oOyCyLLq7v+3q3Jw82J/dSO7Y5t+Q=
X-Google-Smtp-Source: APXvYqzOS9+EsmDtHOXgai33EIk9TpEphYofRbaQKH5Lt7N+dtScZo/6dz67jsIJvEs7rgcFh2Gd0zRUfJr71wqLNRk=
X-Received: by 2002:a67:8907:: with SMTP id l7mr82856951vsd.194.1564668742897;
 Thu, 01 Aug 2019 07:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190708192352.12614-1-olga.kornievskaia@gmail.com>
 <20190708192352.12614-6-olga.kornievskaia@gmail.com> <20190719220116.GA24373@fieldses.org>
 <CAN-5tyHdxBcEH0xPV2814nUMEHPCsQ9iD_A7K=W3ZeE6b4OJxg@mail.gmail.com>
 <20190723205846.GB19559@fieldses.org> <CAN-5tyFTRr9KPYAzq-EaOMqDeJU31-qHGsLyCmEtd18OMxCFNQ@mail.gmail.com>
 <CAN-5tyEbwjPNbXKWXv+3=geisjH-i=xKWRqgyXa3v9Xk=OvdEw@mail.gmail.com> <20190731215118.GA13311@parsley.fieldses.org>
In-Reply-To: <20190731215118.GA13311@parsley.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 1 Aug 2019 10:12:11 -0400
Message-ID: <CAN-5tyGz5M1eMFC=CJUEdTB7cAq-PRis8SJMEnrcr4Svmmy03w@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] NFSD check stateids against copy stateids
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jul 31, 2019 at 5:51 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Wed, Jul 31, 2019 at 05:10:01PM -0400, Olga Kornievskaia wrote:
> > I'm having difficulty with this patch because there is no good way to
> > know when the copy_notify stateid can be freed. What I can propose is
> > to have the linux client send a FREE_STATEID with the copy_notify
> > stateid and use that as the trigger to free the state. In that case,
> > I'll keep a reference on the parent until the FREE_STATEID is
> > received.
> >
> > This is not in the spec (though seems like a good idea to tell the
> > source server it's ok to clean up) so other implementations might not
> > choose this approach so we'll have problems with stateids sticking
> > around.
>
> https://tools.ietf.org/html/rfc7862#page-71
>
>         "If the cnr_lease_time expires while the destination server is
>         still reading the source file, the destination server is allowed
>         to finish reading the file.  If the cnr_lease_time expires
>         before the destination server uses READ or READ_PLUS to begin
>         the transfer, the source server can use NFS4ERR_PARTNER_NO_AUTH
>         to inform the destination server that the cnr_lease_time has
>         expired."
>
> The spec doesn't really define what "is allowed to finish reading the
> file" means, but I think the source server should decide somehow whether
> the target's done.  And "hasn't sent a read in cnr_lease_time" seems
> like a pretty good conservative definition that would be easy to
> enforce.

"hasn't send a read in cnr_lease_time" is already enforced.

The problem is when the copy did start in normal time, it might take
unknown time to complete. If we limit copies to all be done with in a
cnr_lease_time or even some number of that, we'll get into problems
when files are large enough or network is slow enough that it will
make this method unusable.

> Worst case, if the network goes down for a couple minutes and
> the target tries to pick up a copy where it left off, it'll get
> PARTNER_NO_AUTH.  I assume that results in the same error being returned
> the client, at which point the client knows that the copy_notify stateid
> may have installed and can do what it chooses to recover (like send a
> new copy_notify).

Yes the client recovers but the cost of setting up the source server
to destination is huge so any retries would kill the performance.

>
> The FREE_STATEID might also be a good idea, but I guess we can't count
> on it.
>
> Maybe the spec could use some errata to clarify that FREE_STATEID is
> allowed on copy_notify stateids, that clients should send it when
> they're done, and that servers are allowed to expire copy_notify
> stateid's even after their first use.

FREE_STATEID is for a stateid which a copy_notify (or copy) stateid is
so I don't see anything that really needs any extra stating. I think
what's needed is specifying that for COPY_NOTIFY a client must do a
FREE_STATEID when its done with a stateid.

>
> --b.

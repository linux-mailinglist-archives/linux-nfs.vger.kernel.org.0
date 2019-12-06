Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541C511589D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFV1g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 16:27:36 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38786 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLFV1g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Dec 2019 16:27:36 -0500
Received: by mail-ua1-f68.google.com with SMTP id z17so3459033uac.5
        for <linux-nfs@vger.kernel.org>; Fri, 06 Dec 2019 13:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cs7g9VJVPwmEyuFJS1ZM7Ruc9x7OMrsvL7hfbuQqpys=;
        b=XAChXNBb4DN47H5DUBusaZdMbeGRGlrTdYQ+MuHM9pkx18Y/NbmXGcw5and3nCE4Pp
         h63Ud8fBztwAav2JppmcSwSnjV0CF/faUiFpTgTF5DeTAgvlP05hsm23Yie+X8n7YOrW
         2jkfnb+lUCiqJ/T5sO4G5BM2kz+XAe732UkUZLa+mNANsT0gHalA88LeViwmdW4pBRJy
         TKq9WYF24D/Wnq5W52yGvTESqNUwS7iB2DUVg1M2e2kDQXwSMEGnX28upnIbtBbuW1yl
         DlbL5leWAmuv0ZJHXBwT6DeV6pqrnaiEPZ9AMFQLW0QFOgsfuO7myiarpiRNwmNT4CNP
         XWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cs7g9VJVPwmEyuFJS1ZM7Ruc9x7OMrsvL7hfbuQqpys=;
        b=RrHrdBLjruoS6J7TfnRvJoAKYDZ8bwrbOY5GcnLg0xhE5ZLYi+jlbE8Vu/ArWZtbg9
         w2AlyAWVSsWpNJDCqgYA6eBG1yVknxNGPQIfI/NNkqzlwbT1wVdXDr+vFKY9GLBtgkjr
         WFdCth4V+D7QK2XRt8hyicg6abAUca+CJFvdsC3XBdfcG0qe8UYkALYrGsa94M2/pZRU
         EjZFwj5onkUoUWMKzj/1drbZF0PfnJtHwhcyM0XZyQM2+Q3iVz3A9gt+/Qdv7C6NlZ7h
         A4yVaQygam1zCtWabEwYHihi3hasco+6RAMvO1E6wirdX5L3hfwq4RINOGh/NGwII7AM
         3mQw==
X-Gm-Message-State: APjAAAWol3OaOAzDSOBJ6lY5bZ5Apa55eVhyByuQImphG/qCIMaH7DHJ
        qKLnALIovjspMKwuHRO8hWgTeh5tFYfCfrXldU8=
X-Google-Smtp-Source: APXvYqzpVoOetx+6QCueBXM8EVlD/fe3Pm2ZlXivJwvI/00KI2wj86hHDltjdv2GE1SvfuXD0isyYL1HMa+hES7RWI0=
X-Received: by 2002:ab0:6418:: with SMTP id x24mr14943439uao.40.1575667655065;
 Fri, 06 Dec 2019 13:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
 <CAN-5tyEG3C_Ebdr6dpMJ+gQ1pEAMNqbTv76dKu=KK9rspREr1A@mail.gmail.com>
 <20191204220435.GG40361@pick.fieldses.org> <20191205023826.GA43279@pick.fieldses.org>
 <20191206211442.GB17524@fieldses.org> <20191206211538.GC17524@fieldses.org>
In-Reply-To: <20191206211538.GC17524@fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 6 Dec 2019 16:27:24 -0500
Message-ID: <CAN-5tyFO0jXdxpRJewe83kSGWytWfODO20-a7rEd6rS5oP4fmw@mail.gmail.com>
Subject: Re: [bug report] NFSD: allow inter server COPY to have a STALE source
 server fh
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 6, 2019 at 4:15 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Dec 06, 2019 at 04:14:42PM -0500, bfields wrote:
> > On Wed, Dec 04, 2019 at 09:38:26PM -0500, J. Bruce Fields wrote:
> > > So, stuff we could do:
> > >
> > >     - add an extra check of fh_export or something here.
> >
> > So, I'm applying the following for now.
> > +                     if (current->fh->fh_export &&
>                                    ^^^
>
> Um, maybe with a typo or two fixed.
>
>
> > +                                     need_wrongsec_check(rqstp))
> >                               op->status = check_nfsd_access(current_fh->fh_export, rqstp);
> >               }
> >  encode_op:

Sure thing. But I just finished up and have hacked up the client to
send a GETATTR after the 1st PUTFH in the COPY compound of the inter
copy. The server doesn't croak but returns an ERR_STALE on the 1st
PUTFH (I believe this is due to the logic that it's not a valid inter
COPY compound.. so logic works).

but I have nothing against adding the check.

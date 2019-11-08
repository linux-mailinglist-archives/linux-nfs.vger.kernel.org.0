Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856A7F5230
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 18:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKHRGO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 12:06:14 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:40592 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKHRGN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Nov 2019 12:06:13 -0500
Received: by mail-vs1-f50.google.com with SMTP id m9so4260756vsq.7
        for <linux-nfs@vger.kernel.org>; Fri, 08 Nov 2019 09:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7OfQkMw0/JpsTuFF6IzG3uuz24MiN1/VXRSiwXnChw=;
        b=p7oxt+wDx/sR8HuoFGYu/tpLBq0iYJhIYgVbXLSs+p8Gp+wBWjQRsubaYkA840aXqM
         fNnDUrsjF0NLLINYG5OHSdCeLRboIQxjAQYv7sJ+5HRH0RE0v+QvYMrf3Q1DgGmz5fUV
         kPUnLbtyBGGSjonOqZB7vlgz/LNdKv3jzLcztOthQkaj/6b6KRxnStF4olC+uJM9rpiy
         W+qgOK4dcQ4iq6MSd8+HYN+xxzHH/USmGIPIeak2+HaRYKUS/tBqECLPATW7ZFvXci2+
         hk2bfP8cVVk36ep4jIDceOFdtGC4TJX3bQVQR4y3Euht3ltpjgONdk0CWN33vjiZ944l
         Jx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7OfQkMw0/JpsTuFF6IzG3uuz24MiN1/VXRSiwXnChw=;
        b=eoUGMjkkgEUDpNg/YtC1VBOwOMxWqf/lHewNO8ppqwDrqiVVFmRxjsOA4KYHS+D3JI
         2OJZ/Ds6qv67kihOEJa4FHEmZyVGs09975Xy/lruLUYWtW7BiQhgQnVSTLuQyG7hbhre
         FuuXcgAP42Q5ucKWiCKZxji6kuWXb6STlcOWgFpjvks9gAuTUrQ6+wfF1zpYdHTfDd0E
         4x5JSE7RpQj8d7jiLwvyszeUkokBUCup077sY8umjNt58lMiRgMI7f4+JqfK2QZrPxuU
         KZFIkPAEqA47Md1H+s00oTfvoNWZnEJ9LIK3ayk6xX2XW3GRCVOQJQ/m3dt6sMEVdvWb
         SMDw==
X-Gm-Message-State: APjAAAXrb9spZpXshSQkyQwY3cjzRz4G6OO3T6cdEM3lqfh2mzzFaMGH
        7sotCsjiMB3RVE6Sq7bR3hOY5bwvED7BIQ6R9tRg1Q==
X-Google-Smtp-Source: APXvYqwTsq2oO4WVDWw4EJnp4wiGewqwZpX8kfmnPGOBmIUJRJJiWFnozDvF8NJnJyb7mOHyceo9YmBd4HslADevN9U=
X-Received: by 2002:a67:d31b:: with SMTP id a27mr8818472vsj.215.1573232771033;
 Fri, 08 Nov 2019 09:06:11 -0800 (PST)
MIME-Version: 1.0
References: <5DBD272A-0D55-4D74-B201-431D04878B43@ascha.org>
 <CAN-5tyF7F4Mc8Z-bwg+Rq-ok50mchyF+X24oE8_MZzVy8LRCmw@mail.gmail.com> <20191108162927.GA31528@fieldses.org>
In-Reply-To: <20191108162927.GA31528@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 8 Nov 2019 12:06:00 -0500
Message-ID: <CAN-5tyGvLHJ2SJ2M56Ob3WRbbiG2-T1QYabgYY0EzbNB4h5DBg@mail.gmail.com>
Subject: Re: Specific IP per mounted share from same server
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Samy Ascha <samy@ascha.org>, linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 8, 2019 at 11:29 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Nov 08, 2019 at 11:09:10AM -0500, Olga Kornievskaia wrote:
> > Are you going against a linux server? I don't think linux server has
> > the functionality you are looking for. What you are really looking for
> > I believe is session trunking and neither the linux client nor server
> > fully support that (though we plan to add that functionality in the
> > near future).  Bruce, correct me if I'm wrong but linux server doesn't
> > support multi-home (multi-node?)
>
>
> The server should have complete support for session and clientid
> trunking and multi-homing.  But I think we're just using those words in
> slightly different ways:

By the full support, I mean neither client not server support trunking
discovery unless that sneaked in when I wasn't looking. That was the
piece that I knew needed to be done for sure.

When you say it fully support trunking do you mean it when each nfsd
node runs in its own container, right? Otherwise, I thought more code
would be needed to support the case presented here. nfsd would need to
have a notion of running something like a cluster node on a particular
interface and distinguish between requests coming from different
interface and act accordingly?

>
> > therefore, it has no ability to distinguish
> > requests coming from different network interfaces and then present
> > different server major/minor/scope values and also return different
> > clientids in that case as well. So what happens now even though the
> > client is establishing a new TCP connection via the 2nd network, the
> > server returns back to the client same clientid and server identity as
> > the 1st mount thus client will use an existing connection it already
> > has.
>
> So, this part is correct, it treats requests coming from different
> addresses the same way.
>
> Although you *can* actually make the server behave this way with
> containers if you run nfsd in two different containers each using one of
> the two network namespaces.
>
> There are also things the client could do to distribute traffic across
> the two IP addresses.  There's been some work on implementing that, but
> I've lost track of where it stands at this point....

Client can and will do trunking in case of pNFS to the data servers if
the server presents multiple IPs. Otherwise, we just have nconnect
feature but that doesn't split traffic between different network
paths.

>
> --b.

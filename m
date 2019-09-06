Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE29DABAC7
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Sep 2019 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbfIFOXb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 10:23:31 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35634 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbfIFOXb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 10:23:31 -0400
Received: by mail-vs1-f67.google.com with SMTP id b11so4188477vsq.2
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19cdpPYsfQdXA5Ow6pdT8r/K1RBQHUgZwH+prJzz9Q4=;
        b=KVlvDywVowi5lz6k0dlvO8vDrwn+NhpZcUHxyVqP7FA7QdmS9ku7dc4gAj5Uxfx+4m
         Qh7pVSwbaI8ariXrNkA0tflnEWxn6gdufYdzeew2+8o/378Yc26zFliyWmZxAHBBMFpV
         fz1qPH8OV827o/E0jehs3zR3Up6ymCBAyGW6mosRfkFZwWE6ytmEkTetU2IykNTnJOJc
         yLZqaX9aithJJBO8Lr1hHrKpmA772KxpqpOM51EnExbr7lsF88vrodgmxt+Fq1Rqh3hL
         RjaBqqqK5dOBbTynkwrwl3Z+A8Dk/9mBZ6Z9HFEqdOZjLyLNC45wLEfNDpDkmeknrIQV
         DpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19cdpPYsfQdXA5Ow6pdT8r/K1RBQHUgZwH+prJzz9Q4=;
        b=mMIEcFWPctsHvbJvi9JyJBOVGL1IGo3Ox6ADtNokmeXHSuNOJqZMDRwbtRzNhIb4Wh
         xN553nMzIn7MOeZ6hNiNDcJqbAwEihWxCHTMMPVEugQsOr93XXDj/EFvIzr/dnpRD8D2
         tXBmxr7oBWv2JptzISuSWa7xyCIGepb/eApmfvNk8/JFIp1O7+hfxr9N09r/iXqaTAkY
         5O34ujxng+Gbeni6tfEnBA98bB9wJW2n170AR5JmGkIJtckUnI9OXznGBfno2fi9dV/w
         bHL0YAd2w4nXQdDrNBQGogpvQSvZlq4eXXjxde/Rplv+FfWuYmYmub2bW4Fuu+RncYGx
         vJqA==
X-Gm-Message-State: APjAAAV0jzaaF+yIc9uXxXQ/puewug7Z3SflkA8sf1QM3hYXKs2PK2mx
        nK+ZG2TAYhUXjLuMmsFi4UZajSdiZko3V7H++a8=
X-Google-Smtp-Source: APXvYqwM+y6iHgREOvky4eFIwKJrMOio1jJFIfKjdJpQ4MObOGs/or/8ve1P4TOIE+qQx2QhBLw4LIyZRtl+FaRGmsc=
X-Received: by 2002:a67:2241:: with SMTP id i62mr4972328vsi.85.1567779809917;
 Fri, 06 Sep 2019 07:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190904205015.GD14319@fieldses.org> <CAN-5tyGcT6rCpzOB3coj4H19-BuDsBRheD=rsRHZthn7STNq0Q@mail.gmail.com>
 <YT1PR01MB29074F44ABABECF04D4A18E0DDBB0@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT1PR01MB29074F44ABABECF04D4A18E0DDBB0@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 6 Sep 2019 10:23:19 -0400
Message-ID: <CAN-5tyEqPsybNe_e4XLqxRNygo1ci446Wq0jvVEFEBhip-eXdg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] server-side support for "inter" SSC copy
To:     Rick Macklem <rmacklem@uoguelph.ca>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 4, 2019 at 8:13 PM Rick Macklem <rmacklem@uoguelph.ca> wrote:
>
> >Olga Kornievskaia wrote:
> >On Wed, Sep 4, 2019 at 4:50 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >>
> >> What do we know about the status of NFSv4.2 and COPY support on Netapp
> >> or other servers?  In either the single-server or inter-server cases?
> >
> >I'm unaware of any other (current/on-going) implementations. Netapp is
> >interested in having (implementing) this 4.2 feature though (single
> >server case for sure not sure about the inter-server).
>
> Just fyi, I have implemented the single-server case for FreeBSD. (The code is
> currently in a projects area of the FreeBSD subversion repository, which makes
> it a little awkward to set up for testing at this point, but if anyone is interested,
> just email me.)

That's great Rick. Have you done any interoperability with the linux
implementation? Will the code go into the main freeBSD release (or is
already there)?

> I haven't yet implemented the async case, but plan on doing so soon, rick

Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227033A3229
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFJRgg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 13:36:36 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41653 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRgg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Jun 2021 13:36:36 -0400
Received: by mail-ed1-f51.google.com with SMTP id g18so31995374edq.8
        for <linux-nfs@vger.kernel.org>; Thu, 10 Jun 2021 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4KwPKQ1x3RIhzCcY8FOdoEuPUcYhRkeqNqylNAAmvE=;
        b=iFie6m9q4rxxOCH/w4gIvnTvYH7Dpo+mGihBUF84Scuy0UtbmFqo8MFNOCqJZpqdxQ
         XdtdcC5kLiewi5YvcNbi2QrfCOIZ2aAajqh2Orinplqo3hXQzuAiR0n52N4EgdkpQOP+
         whjxe+oeKvK8dKQLa6RMYvKHKsESxI85xU7BNmY3Ug5uJ+TqhUCySJ6QczmiFVNCnPtG
         /9PNuIqyN80Dp5a3zEwlQcKXAmVCNJp5XzsIJ6hbC1Q07waROawA5nYYvvU+NwMpo+wY
         NT1dJN2OcVX+vF9gBqpym3DTR9b1O2ILdRQljyqnMlNoFkt9D0kJITUiWv2TY0SSldOs
         f7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4KwPKQ1x3RIhzCcY8FOdoEuPUcYhRkeqNqylNAAmvE=;
        b=K6xC1//F2ne4PG93DKbcXwrimmyNSiG+AOnqfHK8kysh0rXp8ZucAmzF6n4GmSvQYj
         b9rd23F4+eAAaU99KeqBSGL4+fPruDzziX5IibcusmmuiLddud/iWy1hNei1HDiWq9bq
         XgcSJWrHUD6FEYFQtvM22cOBI9lqzoPC8ZZ7blSpxyQXkuH9Ez4e5DliqoQV+CXm7KFl
         6RUiWhTFW9l137rY1CzVr9hhjtf+TwYVFjf0ejabbSemwjueLDC1elUG+Bgfxh5Nycku
         TPY8fJVpfr7YfEs0bLUI6diqFXRyIyXs816G79BB72rRK2xu0G2x1COFxDNV4Mhd55se
         nZYQ==
X-Gm-Message-State: AOAM5331m+IRp6lTl/LHdjadJrMW1WLsFFZfa8QTez5LyWLI30cy06O+
        ihrSU7h/WmVqmIy8uV1sd8fIbefINI0PxbIf0Vc=
X-Google-Smtp-Source: ABdhPJybSks5OKFxb43ZzhA3ws0RuYsjKvzVBWmY/aLo2QKhCbFQK/kPiBABzeXj/NQ5OWGr7CBrFVLQN5O1GmRRkl0=
X-Received: by 2002:a05:6402:158e:: with SMTP id c14mr626718edv.128.1623346405759;
 Thu, 10 Jun 2021 10:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com> <9657859a-7e65-0b38-a4c5-3f74d0bdc5e8@redhat.com>
In-Reply-To: <9657859a-7e65-0b38-a4c5-3f74d0bdc5e8@redhat.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 10 Jun 2021 13:33:14 -0400
Message-ID: <CAN-5tyG6Hs3yt4+GPBA6_x-vCC5aj-WPk6+HtLsQS-d+NY2a_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] don't collapse transports for the trunkable
To:     Steve Dickson <steved@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 10, 2021 at 9:29 AM Steve Dickson <steved@redhat.com> wrote:
>
> Hey!
>
> On 6/9/21 5:53 PM, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > This patch series attempts to allow for new mounts that are to the
> > same server (ie nfsv4.1+ session trunkable servers) but different
> > network addresses to use connections associated with those mounts
> > but still use the same client structure.
> >
> > A new mount options, "max_connect", controls how many extra transports
> > can be added to an existing client, with maximum of 128 transports in
> > total for either nconnect transports (which are multiple connections
> > but to the same IP) or transports that are going to different network
> > addresses.
> I'm trying to figure out why this new mount option is needed...
> What is it protecting? What am I missing?

Hopefully comments on patch3 of this series can help you answer that.

> Plus it needs to be documented....

Indeed a man page patch is needed but I was waiting to get a more
commonly accepted version of the code before adding the man page
patch.

> steved.
> >
> > Olga Kornievskaia (3):
> >    SUNRPC query xprt switch for number of active transports
> >    NFSv4 introduce max_connect mount options
> >    NFSv4.1+ add trunking when server trunking detected
> >
> >   fs/nfs/client.c             |  1 +
> >   fs/nfs/fs_context.c         |  8 +++++++
> >   fs/nfs/internal.h           |  2 ++
> >   fs/nfs/nfs4client.c         | 43 +++++++++++++++++++++++++++++++++++--
> >   fs/nfs/super.c              |  2 ++
> >   include/linux/nfs_fs_sb.h   |  1 +
> >   include/linux/sunrpc/clnt.h |  2 ++
> >   net/sunrpc/clnt.c           | 13 +++++++++++
> >   8 files changed, 70 insertions(+), 2 deletions(-)
> >
>

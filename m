Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3C12347C
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 19:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfLQSM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 13:12:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34230 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQSM2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Dec 2019 13:12:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so8086008qkk.1;
        Tue, 17 Dec 2019 10:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94WcDwyswmJ+xZ6oQZ+EBBfqZNKwF38tRDgKQsxSOP8=;
        b=KwFnS9QSEv9LyokZomttACcmx6y4KqxsdPNANWGey9uKIUNfsof9hFIGFTRC9Gfy+Y
         cnd8Dm5yrC1ntADbk8l8Z+LcB91W41sUUYz3r53dm4k/6xhpA66WJCQkkeygyqvnD4q1
         4n81ah1szCmtBZTRCLlwoBa1IkQzwX2yUNG3kbpA1/XxBcbKcM+xNYtnLYrzg3rkIscT
         PpZEEun1Fh4hk/EBlJ0FlN+Uch/oW6M72jt+S+ChnUkk0HEiKgDDTY29cDaZX/T8gE/g
         JW2TF8xQwUEW5KUV6knwLB1W7PhY/vSllRQa5FVMEQ0yjvXqWoMfefhB7D3S9DTPD5Ba
         NLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94WcDwyswmJ+xZ6oQZ+EBBfqZNKwF38tRDgKQsxSOP8=;
        b=ALg86n9as8j0r+xAgJ0KBCjNJ6Vijpw1adjVJbpT1OWXKynjImkWZuyG7CsGWn7+D6
         NvUDYGp21jAYe7YQAsRS0cl4i/8XfmGvWhDHH4Aqt9fLmEZrbTMVZdAqm02YyfmC3cxQ
         fPUoC2wddAmck4y2zv0vPcxT7qEtCsio1eyI3uyIYIqEvqE5JV2o8YF9UTIf2sMgt7z8
         5e+58AqceIdlOm0aixLDIoncymDG5mQixRsDoGoEpz2fR2tsNz4e0xuTSvIutGoMFYb5
         KBidYpIfkUZhokTjhrlwTajwXaZhpr/qI6miaDbE6MF6JKVjuVt0FLkJ7GzM16b60MYK
         a8bQ==
X-Gm-Message-State: APjAAAUuay48qvJTL1GLmOKiglKFR7Pi1YHimARb0hzusM/A8pJXcj+K
        Ga0Q6ifG+W2syIKyVw+sHEnHQKZxy8yJqSSWx4A=
X-Google-Smtp-Source: APXvYqxokIyQB2bMqD8wFppcI0RegO2Y2reD8DeoM3KJDcVm8CV1EP6T+DJcgKPlB40YGBxIkiBPJwxdgxPR5QmEflQ=
X-Received: by 2002:a05:620a:1401:: with SMTP id d1mr5798512qkj.79.1576606347113;
 Tue, 17 Dec 2019 10:12:27 -0800 (PST)
MIME-Version: 1.0
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com> <dea30ea3f0fc31e40b311c4d110c26cf40658dca.camel@hammerspace.com>
 <05ea01d5b440$bd9d58d0$38d80a70$@gmail.com> <2d94fa3e9632c638f9e47999fd8e26cb3b34b4dc.camel@hammerspace.com>
In-Reply-To: <2d94fa3e9632c638f9e47999fd8e26cb3b34b4dc.camel@hammerspace.com>
From:   Robert Milkowski <rmilkowski@gmail.com>
Date:   Tue, 17 Dec 2019 18:12:16 +0000
Message-ID: <CALbTx=H_49MroKwuwyThirwtiJE5686cyCZwKth-yVSRx0srug@mail.gmail.com>
Subject: Re: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease renewals
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 16 Dec 2019 at 18:58, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> -On Mon, 2019-12-16 at 18:43 +0000, Robert Milkowski wrote:
> > > From: Trond Myklebust <trondmy@hammerspace.com>
> > ...
> > > NACK. The above argument only applies to legacy minor version 0
> > > setups, and does not apply to NFSv4.1 or newer.
> >
> > Correct. However many sites still use v4.0.
> >
>
> That's not a good reason to break code that works just fine for
> NFSv4.1.
>

Of course not, that's not what I meant and I misunderstood your nack too.

> It would be better to move the initialisation of clp->cl_last_renewal
> into nfs4_init_clientid() and nfs41_init_clientid() (after the calls to
> nfs4_proc_setclientid_confirm() and nfs4_proc_create_session()
> respectively).
>

This could be done but this is potentially a separate change, as in
nfs4_do_fsinfo() we still need to
make sure we do not implicitly renew lease for v4.0, so I think the
patch needs to be modified as:

...
+                       /* no implicit lease renewal allowed here for v4.0 */
+                       if (server->nfs_client->cl_minorversion == 0
&& server->nfs_client->cl_last_renewal != 0)
+                               last_renewal =
server->nfs_client->cl_last_renewal;
                        nfs4_set_lease_period(server->nfs_client,
                                        fsinfo->lease_time * HZ,
-                                       now);
+                                       last_renewal);
...

This way it won't affect newer nfs versions (I don't think it affected
them in any bad way, still it was unintended and not correct).
Agree with the above change?

btw: Chuck, thanks for the hint regarding the SEQUENCE op on v4.1+

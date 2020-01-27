Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B014A8E2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 18:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgA0R03 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 12:26:29 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:41138 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0R03 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 12:26:29 -0500
Received: by mail-qk1-f177.google.com with SMTP id s187so10396159qke.8;
        Mon, 27 Jan 2020 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kf2FDJGFABsa8dMfNJh+lTWVV7yYf0R3wgfeAqnShMc=;
        b=K5cRyYfAGJg49+k4NPcUlUtuPQo2ckeAhTzgYeX+0cOluS/SHNz7C++gaNn06jOaC7
         dh2q8dcz16E2AB7zc+/cntD0ETNl8qxZZWF4YZqnlgUU+VySOZ6R5yp6lXLQmOoMWM5L
         /n4cNa4DQAMcqbFzjtr1EigbhqHtWUwI34hLInhTIu3v1zjVFvQKIisS8B22c8Lxd5A8
         ubgzLIl1HLm6alyMWpdqJKTK40k5ZxUvFJfdGVhKHNeLdZYSRt1UbnLjzGYXsYFEDe19
         H80gYbhCRYdhD+KEwEUVdb0Qu84sV6GXmnl0hGg6vQ9CAN2piOebNgSGRgsvs50mAksU
         QITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kf2FDJGFABsa8dMfNJh+lTWVV7yYf0R3wgfeAqnShMc=;
        b=DYVtDXPTg29QEW1gFwTCoBRw/AxeiP4aAR94Sf7bbOBf9eMVlWXCiWQ126TRtNLy5K
         2d7wIWCjfSmI2RQzBWRDP0OUUtXw2nJVZxNaiiQ1CHKSfL5FMgT7iBZnOeUMczrLQ5op
         pVN4XGywpjpGCIxPzW/E2xtmYwI7e8jY9v862bKdVhCLuta1ysuzojFYNTAd3qRs+C2u
         8c+4vVf3xGPAUFXjY4WLGHEU8BkVrzPifD+Drpk8EfObg8Fw2u75EhksYlORP0WyppmF
         MdM1r6ignayWZ72/ziCx34AJMaF8Itut0Gdi7a9kfii0Zjy05hAgGnMPPIu3t8yRmC1s
         DhYQ==
X-Gm-Message-State: APjAAAUg0CO5mZg74UovlEOSaW1fZ43SGW1vqZX0ORH9ayg9Z35V6M+u
        1kvQqGujyBBxzkqLN5ci3iGgt/DNZcdINjxw1+Y=
X-Google-Smtp-Source: APXvYqy0XhigD/SKPQ3G9sFERZqGihKttc4IFVvnazIK9f9RlMbKcNwXPBZgTwa7qrr1/4wXy5hX5IaYFYwU7foDN/M=
X-Received: by 2002:a37:4047:: with SMTP id n68mr17831482qka.258.1580145988471;
 Mon, 27 Jan 2020 09:26:28 -0800 (PST)
MIME-Version: 1.0
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com> <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
 <084f01d5cfba$bc5c4d10$3514e730$@gmail.com> <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
 <a62e45ba968fe845fa757174efc0cab93c490d54.camel@hammerspace.com>
 <CALbTx=GxuUmWu9Og_pv8TPbB0ZnOCA3vMqtyG4e18-4+zkY8=A@mail.gmail.com> <197269d91db31284dce51b831bfbe2231ac870d4.camel@hammerspace.com>
In-Reply-To: <197269d91db31284dce51b831bfbe2231ac870d4.camel@hammerspace.com>
From:   Robert Milkowski <rmilkowski@gmail.com>
Date:   Mon, 27 Jan 2020 17:26:16 +0000
Message-ID: <CALbTx=E7Hk4bVtSehjo4TPykTZsP+fSR0zeHFWyqd4XtHDyL4g@mail.gmail.com>
Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> >
> > > All that needs to be done here is to move the setting of clp-
> > > > cl_last_renewal _out_ of nfs4_set_lease_period(), and just have
> > > nfs4_proc_setclientid_confirm() and nfs4_update_session() call
> > > do_renew_lease().
> > >
> >
> > This would also require nfs4_setup_state_renewal() to call
> > do_renew_lease() I think - at least it currently calls
> > nfs4_set_lease_period().
>
> This is the mechanism we're replacing. There is no need for a call to
> do_renew_lease() in nfs4_setup_state_renewal().

ok

>
> > Also, iirc fsinfo() not setting cl_last_renewal leads to
> > cl_last_renewal initialization issues under some circumstances.
> >
> > Then the RFC 7530 in section 16.34.5 states:
> > "SETCLIENTID_CONFIRM does not establish or renew a lease.", so
> > calling
> > do_renew_lease() from nfs4_setclientid_confirm() doesn't seem to be
> > ok.
>
> So just move the do_renew_lease() to nfs4_proc_setclientid(). The
> successful combination SETCLIENTID+SETCLIENTID_CONFIRM definitely
> _does_ establish a lease.
>

ok

> > I'm not sure if is is valid to do implicit lease renewal in
> > nfs4_update_session() either...
>
> Ditto. Move to the exchange_id call.
>

ok

> >
> > Anyway, the patch would be something like (haven't tested it yet):
> >
...
> > @@ -6146,6 +6143,10 @@ int nfs4_proc_setclientid_confirm(struct
> > nfs_client *clp,
> >                 clp->cl_clientid);
> >         status = rpc_call_sync(clp->cl_rpcclient, &msg,
> >                                RPC_TASK_TIMEOUT |
> > RPC_TASK_NO_ROUND_ROBIN);
> > +       if(status == 0) {
> > +               unsigned long now = jiffies;
>
> The variable 'now' needs to be set before the RPC call in order to
> avoid overestimating the remaining lease period.
>

yes, thx.

I will get a new patch tested and submitted here this week.

-- 
Robert Milkowski

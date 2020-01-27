Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0F14A73F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2020 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgA0Pen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jan 2020 10:34:43 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39345 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgA0Pem (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jan 2020 10:34:42 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so4649762qvk.6;
        Mon, 27 Jan 2020 07:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVUnJMfjmuGw+lU9thhl2oSy8uhsumVUEINYmzwWOXs=;
        b=dhW2ulZ3P+R6T8JKYFAot0I7g6GZMnILoApLkWciTMODTNGvU4ZP3Z8ZyZK0jrGcJ1
         Z49HE8HhMLUBfclgQpkI7XxfdaOKAF/Pm7CDmY/JEKCe5m0x9GDP8EKUBI61qzBV8KlV
         /vBBgyNk51PMMVjRHsqiLg4uV9tILW3R81Y46qqUHrfX+f449TuDoyxUWSfgahwyzGYo
         idGlVOi8JhjcgTCCIkMXDoWZivykddRJ3C/pJaTwcHG/ezptCPi6WaNB+LXtQgNXDFOS
         9/8HIFL1tPZ+9qDt7eXC16fCpXin1aItCZsG4zpjP9nhQQWJYfGvrzok5sudEY8mZGJ+
         4jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVUnJMfjmuGw+lU9thhl2oSy8uhsumVUEINYmzwWOXs=;
        b=RHo3YP6ayOw1EwdMhas6x/K3SGsgngS+PRISsGfSnYNXXENm2maqI1Ogc+VbSDiza+
         7qBlqgrNWOB6z6nobtq+RIO6/dzxhgSmT1owG9MVqCWYNJnhBapgIQbUT3bH8aKrbQu2
         AxHW3pm2l68wxSM54Ds+8n4CJdR370PC7Qal1NQ8F+lUAWIxd48tAG/yBzjM4YxidE31
         csazbLesoZ8nJmuQzSnuie/ENZlvWIyxoSbXyE1bcKR5BD/bNV2zpFk+iMcKoFNTwCJY
         A0nR6Z1/PKJyS2YpTcaJlLshufzZjjo1oPnh1yDmSmJKmOMgxihltrHfvkbmlIkjOkIJ
         J+Jw==
X-Gm-Message-State: APjAAAV9zwgvIys3tSsoQ4Ok/aLGB09KYIEhIDct3T3fYYK/qHrDIW9c
        jhPfSZAE9MteWYzOnsWlwRefnYeqXFhcT7F3jSI=
X-Google-Smtp-Source: APXvYqxCM3fA+7JszJLqjAKCNtex3kozoTfy7cySq/OKOMR+6QXu0LT4v60q7/cLiNaxG6ETDWDHwbgsUlLvAzOTTC0=
X-Received: by 2002:a05:6214:b23:: with SMTP id w3mr17432626qvj.181.1580139281556;
 Mon, 27 Jan 2020 07:34:41 -0800 (PST)
MIME-Version: 1.0
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com> <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
 <084f01d5cfba$bc5c4d10$3514e730$@gmail.com> <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
 <a62e45ba968fe845fa757174efc0cab93c490d54.camel@hammerspace.com>
 <CALbTx=GxuUmWu9Og_pv8TPbB0ZnOCA3vMqtyG4e18-4+zkY8=A@mail.gmail.com> <6B5432AC-73BA-465E-98FC-82BFD0E817FD@oracle.com>
In-Reply-To: <6B5432AC-73BA-465E-98FC-82BFD0E817FD@oracle.com>
From:   Robert Milkowski <rmilkowski@gmail.com>
Date:   Mon, 27 Jan 2020 15:34:30 +0000
Message-ID: <CALbTx=E9PD3QomfEqCLSVEVk0cjXW=0+7-UgUkqwEEf=reRpXg@mail.gmail.com>
Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 27 Jan 2020 at 15:05, Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 27, 2020, at 9:45 AM, Robert Milkowski <rmilkowski@gmail.com> wrote:
> >
> > On Thu, 23 Jan 2020 at 19:08, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >>
> >> On Wed, 2020-01-22 at 19:10 +0000, Schumaker, Anna wrote:
> >>> Hi Robert,
> >>>
> >>> On Mon, 2020-01-20 at 17:55 +0000, Robert Milkowski wrote:
> >>>>> -----Original Message-----
> >>>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>>> Sent: 30 December 2019 15:37
> >>>>> To: Robert Milkowski <rmilkowski@gmail.com>
> >>>>> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; Trond
> >>>>> Myklebust
> >>>>> <trond.myklebust@hammerspace.com>; Anna Schumaker
> >>>>> <anna.schumaker@netapp.com>; linux-kernel@vger.kernel.org
> >>>>> Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do
> >>>>> implicit
> >>>>> lease renewals
> >>>>>
> >>>>>
> >>>>>
> >>>>>> On Dec 30, 2019, at 10:20 AM, Robert Milkowski <
> >>>>>> rmilkowski@gmail.com>
> >>>>> wrote:
> >>>>>> From: Robert Milkowski <rmilkowski@gmail.com>
> >>>>>>
> >>>>>> Currently, each time nfs4_do_fsinfo() is called it will do an
> >>>>>> implicit
> >>>>>> NFS4 lease renewal, which is not compliant with the NFS4
> >>>>> specification.
> >>>>>> This can result in a lease being expired by an NFS server.
> >>>>>>
> >>>>>> Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing
> >>>>>> leases")
> >>>>>> introduced implicit client lease renewal in nfs4_do_fsinfo(),
> >>>>>> which
> >>>>>> can result in the NFSv4.0 lease to expire on a server side, and
> >>>>>> servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
> >>>>>>
> >>>>>> This can easily be reproduced by frequently unmounting a sub-
> >>>>>> mount,
> >>>>>> then stat'ing it to get it mounted again, which will delay or
> >>>>>> even
> >>>>>> completely prevent client from sending RENEW operations if no
> >>>>>> other
> >>>>>> NFS operations are issued. Eventually nfs server will expire
> >>>>>> client's
> >>>>>> lease and return an error on file access or next RENEW.
> >>>>>>
> >>>>>> This can also happen when a sub-mount is automatically
> >>>>>> unmounted due
> >>>>>> to inactivity (after nfs_mountpoint_expiry_timeout), then it is
> >>>>>> mounted again via stat(). This can result in a short window
> >>>>>> during
> >>>>>> which client's lease will expire on a server but not on a
> >>>>>> client.
> >>>>>> This specific case was observed on production systems.
> >>>>>>
> >>>>>> This patch makes an explicit lease renewal instead of an
> >>>>>> implicit one,
> >>>>>> by adding RENEW to a compound operation issued by
> >>>>>> nfs4_do_fsinfo(),
> >>>>>> similarly to NFSv4.1 which adds SEQUENCE operation.
> >>>>>>
> >>>>>> Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing
> >>>>>> leases")
> >>>>>> Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> >>>>>
> >>>>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> >>>>>
> >>>>>
> >>>>
> >>>> How do we progress it further?
> >>>
> >>> Thanks for following up! I have the patch included in my linux-next
> >>> branch for
> >>> the next merge window.
> >>
> >> NACK. This is the wrong way to solve the problem. Lease renewal in
> >> NFSv4 does not need to be tied to fsinfo. It creates an unnecessary
> >> extra error condition that has absolutely nothing to do with the
> >> functionality of retrieving per-filesystem attributes.
> >
> > Well, we also do it for NFSv4.1+ with the SEQUENCE operation being
> > send by fsinfo, and as Chuck pointed out
> > it makes sense to do similarly for 4.0, which is what this patch does.
>
> I did say that.
>
> However, I can see that for NFSv4.1+, the client code handling the
> SEQUENCE response will update cl_last_renewal. It does not need to
> be done in the fsinfo code.

I think it is the case, yes.

>
> The NFSv4.0 behavior should be correct if cl_last_renewal is not
> updated. That should force the client to send a separate RENEW
> operation so that both the client and server agree that the lease
> is active.
>

I was thinking about removing the call to update the last renewal
entirely in do_fsinfo(),
however as briefly discussed back in Dec there is an issue with
cl_last_renewal initialization on initial mount in 4.0
I observed it to be 0, as nfs4_setup_state_renewal() calls
nfs4_proc_get_lease_time() on initial mount and if no error it calls
nfs4_set_lease_period().
However with sec=krb the call to nfs4_proc_get_lease_time() returns
NFS4ERR_WRONGSEC) during initial mount (which seems to be ok), which
results in not setting cl_last_renewal,
which iirc prevented scheduling RENEW operations altogether. As
discussed then, this is really a separate issue which should be fixed
separately.
Once fixed then fsinfo() shouldn't need to set cl_last_renewal at all,
still sending RENEW in fsinfo() seems like a good idea to make it more
inline with what we do for 4.1.

> If I understand Trond correctly?
>

The problem with what Trond proposed is that it seems to go against
the rfc, although it should fix the initialization issue.

-- 
Robert Milkowski

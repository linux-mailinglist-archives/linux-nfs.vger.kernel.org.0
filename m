Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5180D124A17
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLROst (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 09:48:49 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41145 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLROst (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 09:48:49 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so829972qvr.8;
        Wed, 18 Dec 2019 06:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03LZZ1Q88h/Vi7kuW4/G+tMxZypv0uuxA868U5NI5Kg=;
        b=rCSqdHkHdw7MyQM6V2wX4E41GW4G2/vwDR0auAmquMnDYrF6mEkBvcgOCXd6CzirIS
         nevXw2d3ZwNWgS/vRbR65z56h7yfn6oqBPnz2Q9+qeS05WA8y6nNnnSc+CT1klQNHRp7
         3u8v6YHI03PicsQ3UgXl6DHgn8VOldhF8JVNLDXHwQ4Z0Lj8W5hKj/w60g/jBA+Thgwj
         0+dVqmYcBodrOPSc2Way2rzaDjH7P8VG6udeYL01JNOC1wxCjtcUHwfCDBRZk1Bzi2gG
         SZHrg8FmdrWwaug1s28phPtgapdy3eSLtOMgGTCr7SeUrtwgRroMWSXg0HPgjXi356S/
         cI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03LZZ1Q88h/Vi7kuW4/G+tMxZypv0uuxA868U5NI5Kg=;
        b=FRwCZMW9J1mtB89PzntwwCbGVeCYn4K0Pq6G3e9C4GtRaVTENlaUzwQcFK37Qg4xxI
         Pia+SHxuApCz2cQn/ja3kTjQ5eDOYt4Dn2CeHyCQ9N34sSLsTX0v4rhM7PzggdxujLAw
         qiVuuog/hA1QoZkUIsuh+F+eMLok8PiKRLWWo4jvb3UzsVqptKQ8ueZzTQMT0VFeAqNg
         XMLmaGm1Dc0zoAG/dQQ/rkqLUvug2SQTsQDnlNIyj5rijvWdTgt6bt5VeYA/p/1+KjgL
         zkWNpG5fGtJ7WZfSo/w+C5DMbveX84UWN1zcDE+7Xh/d1BuQUwhbvTv4OV+8QHvJYxrs
         03yQ==
X-Gm-Message-State: APjAAAVtkFMMq79KEVvfF9t0hQunAGd3BukJOQe2bYRwn9lzflazdJOF
        6YG/3wITXvVxqrOo7X6lzCCsKu60OCtoMrkFGIwTUw7YFEg=
X-Google-Smtp-Source: APXvYqyedeACk3XMykTt78aYIgOyHUys2yyKMAdabZPSCX7yCyBFKjkFUrlGmDMEkRU5DIovnwOh4ZgaqOg9FwEf3jI=
X-Received: by 2002:ad4:46e4:: with SMTP id h4mr2690617qvw.181.1576680528099;
 Wed, 18 Dec 2019 06:48:48 -0800 (PST)
MIME-Version: 1.0
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com> <dea30ea3f0fc31e40b311c4d110c26cf40658dca.camel@hammerspace.com>
 <05ea01d5b440$bd9d58d0$38d80a70$@gmail.com> <2d94fa3e9632c638f9e47999fd8e26cb3b34b4dc.camel@hammerspace.com>
 <CALbTx=H_49MroKwuwyThirwtiJE5686cyCZwKth-yVSRx0srug@mail.gmail.com>
In-Reply-To: <CALbTx=H_49MroKwuwyThirwtiJE5686cyCZwKth-yVSRx0srug@mail.gmail.com>
From:   Robert Milkowski <rmilkowski@gmail.com>
Date:   Wed, 18 Dec 2019 14:48:37 +0000
Message-ID: <CALbTx=HUA6PdBufwmyYaN3J1pETUzRk=5HM7BKCDv8+PM2Qm9Q@mail.gmail.com>
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

On Tue, 17 Dec 2019 at 18:12, Robert Milkowski <rmilkowski@gmail.com> wrote:
>
> On Mon, 16 Dec 2019 at 18:58, Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > It would be better to move the initialisation of clp->cl_last_renewal
> > into nfs4_init_clientid() and nfs41_init_clientid() (after the calls to
> > nfs4_proc_setclientid_confirm() and nfs4_proc_create_session()
> > respectively).
> >
>
> This could be done but this is potentially a separate change, as in
> nfs4_do_fsinfo() we still need to
> make sure we do not implicitly renew lease for v4.0, so I think the
> patch needs to be modified as:

I took a look at the client initialization and the
nfs4_init_clientid() already calls nfs4_setup_state_renewal(),
which in turn calls nfs4_proc_get_lease_time(), however that might
return with an error in which case it won't set the cl_last_renewal,
the code is:

static int nfs4_setup_state_renewal(struct nfs_client *clp)
...
        status = nfs4_proc_get_lease_time(clp, &fsinfo);
        if (status == 0) {
                nfs4_set_lease_period(clp, fsinfo.lease_time * HZ, now);
...

In my environment with nfsv4+krb the nfs4_proc_get_lease_time()
returns with -10016 (NFS4ERR_WRONGSEC) during initial mount (which
after a quick scan of the rfc seems that might be ok initially).
Also for v4.1 do_renew_lease() is called by nfs41_sequence_process()
multiple times during mount before we even reach nfs4_do_fsinfo() so
for 4.1+ it never gets cl_last_renewal==0, at least not under this
circumstances.

There might be other cases where nfs4_do_fsinfo() will get
clp->cl_last_renewal=0 for nfsv4.0, and since the nfs4_do_fsinfo()
already initializes the cl_last_renewal record, plus as Chuck pointed
out in case of v4.1+
it is expected to implicitly renew the lease anyway, I would rather
focus on fixing only the reported issue here for now, which is the
incorrect implicit renewal in fsinfo for v4.0, and leave improvements
to client initialization for another day.

I will send an updated patch shortly which doesn't impact v4.1+.

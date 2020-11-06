Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BDE2A8B62
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Nov 2020 01:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgKFAYE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 19:24:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:52880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732817AbgKFAYE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Nov 2020 19:24:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C374AC19;
        Fri,  6 Nov 2020 00:24:02 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Fri, 06 Nov 2020 11:23:56 +1100
Subject: Re: [PATCH/RFC] Does nfsiod need WQ_CPU_INTENSIVE?
In-Reply-To: <37ec02047951a5d61cf9f9f5b4dc7151cd877772.camel@hammerspace.com>
References: <87sg9or794.fsf@notabene.neil.brown.name>
 <37ec02047951a5d61cf9f9f5b4dc7151cd877772.camel@hammerspace.com>
Message-ID: <87k0uzqqn7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05 2020, Trond Myklebust wrote:

> On Thu, 2020-11-05 at 11:12 +1100, NeilBrown wrote:
>>=20
>> Hi,
>> =C2=A0I have a customer report of NFS getting stuck due to a workqueue
>> =C2=A0lockup.
>>=20
>> =C2=A0This appears to be triggered by calling 'close' on a 5TB file.
>> =C2=A0The rpc_release set up by nfs4_do_close() calls a final iput()
>> =C2=A0on the inode which leads to nfs4_evict_inode() which calls
>> =C2=A0truncate_inode_pages_final().=C2=A0 On a 5TB file, this can take a=
 little
>> =C2=A0while.
>>=20
>> =C2=A0Documentation for workqueue says
>> =C2=A0=C2=A0 Generally, work items are not expected to hog a CPU and con=
sume
>> many
>> =C2=A0=C2=A0 cycles.
>>=20
>> =C2=A0so maybe that isn't a good idea.
>> =C2=A0truncate_inode_pages_final() does call cond_resched(), but workque=
ue
>> =C2=A0doesn't take notice of that.=C2=A0 By default it only runs more th=
reads
>> on
>> =C2=A0the same CPU if the first thread actually sleeps.=C2=A0 So the net=
 result
>> is
>> =C2=A0that there are lots of rpc_async_schedule tasks queued up behind t=
he
>> =C2=A0iput, waiting for it to finish rather than running concurrently.
>>=20
>> =C2=A0I believe this can be fixed by setting WQ_CPU_INTENSIVE on the
>> nfsiod
>> =C2=A0workqueue.=C2=A0 This flag causes the workqueue core to schedule m=
ore
>> =C2=A0threads as needed even if the existing threads never sleep.
>> =C2=A0I don't know if this is a good idea as it might spans lots of
>> threads
>> =C2=A0needlessly when rpc_release functions don't have lots of work to d=
o.
>>=20
>> =C2=A0Another option might be to create a separate
>> nfsiod_intensive_workqueue
>> =C2=A0with this flag set, and hand all iput requests over to this
>> workqueue.
>>=20
>> =C2=A0I've asked for the customer to test with this simple patch.
>>=20
>> =C2=A0Any thoughts or suggestions most welcome,
>>=20
>
> Isn't this a general problem (i.e. one that is not specific to NFS)
> when you have multi-terabyte caches? Why wouldn't io_uring be
> vulnerable to the same issue, for instance?

Maybe it is.  I haven't followed io_uring in any detail, but if it calls
iput() from a workqueue which isn't marked WQ_CPU_INTENSIVE, then it
will suffer the same problem.

And maybe that means we should look for a more general solution and I'm
not against that (though my customer needs a fix *now*).

>
> The thing is that truncate_inode_pages() has plenty of latency reducing
> cond_sched() calls that should ensure that other threads get scheduled,
> so this problem doesn't strictly meet the 'CPU intensive' criterion
> that I understand WQ_CPU_INTENSIVE to be designed for.
>
It is relevant to observe the end of should_reclaim_retry() in mm/page_allo=
c.c.
	/*
	 * Memory allocation/reclaim might be called from a WQ context and the
	 * current implementation of the WQ concurrency control doesn't
	 * recognize that a particular WQ is congested if the worker thread is
	 * looping without ever sleeping. Therefore we have to do a short sleep
	 * here rather than calling cond_resched().
	 */
	if (current->flags & PF_WQ_WORKER)
		schedule_timeout_uninterruptible(1);
	else
		cond_resched();

This suggests that cond_resched() isn't sufficient in the content of a
workqueue worker.  If cond_resched() were changed to include that test,
or if the cond_reshed() in truncate_inode_pages_range() were changed to
use the above code fragment, they would equally solve my current
problem.  So if you, as NFS maintainer, were happy to second one of those,
I'm happy to accept your support and carry the mission further into the
core.

w.r.t WQ_CPU_INTENSIVE in general: the goal as I understand it is to
have multiple runnable workers on the same CPU, leaving it to the
scheduler to balance them.  Unless kernel preempt is enabled, that means
that each thread *must* call cond_resched() periodically, otherwise
there is nothing the scheduler can do, and some lockup-detector would fire.

Probably the best "fix" would be to make WQ_CPU_INTENSIVE irrelevant by
getting the workqueue core to notice when a worker calls cond_resched(),
but I don't know how to do that.

NeilBrown


> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+kl50OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbl3IxAAjh9a7ruP4p4HsyriHBTbyVuZpiFGsx+jubzN
JrLGNaw/YgBmlCOVwu+bQG7otR76yMHx2La6XhX0b/Od2hWBXd9mr4b33vW2xzlw
302jVAK5xxUz6XU5Dj1iu0o/SJw+NSb7VHgISnSDGFM5/KKIej8AnhnpEydOY80S
NQ7AVH6oTvb8croYrdipje4URu4VS7Nmygj0koL1UcQKQgiUbGUGuVd4qkIqHkKY
suV4FnL+Zn0XWyaMDgoYbsFFeAyT6sMN2A6L/7pqqmDnx86F1BIVtZncgW0y2xFz
u1CI02NZkTUEg24Az4nzT7MerkaBr8GEHthuZsTm9Ijt3XhlbvRULpUosGWQV/lu
zK1cNMJSnrIQr+xOIoaCDZG/FgxMYrAoIqbx0yRvZnYfJu2EINiX8UcUK3FVeE0e
GZUQ5NZ+xPXpSQGrYtuklu3FUEpCmiGFeo70NxVJ5KTAN8XHqD7KhORwSWyNILsa
7+W76hhwYGdCQnxgJddJNuQcZuo0J3in80jMwJnSQ3Gnt3RDAzvKNH44Ma246bD1
ZXFBJ+fu0AaqeHw6UYxcKrKYxWk0tTJM4eK6RTCQDx63StT2LWM6m36N9eZil2mp
pJIhZsn5GZ8ZWW+sae2qT3Jd0YR3+o02WTG5PucsQJ4l6/SsGRVJXG4d3KGb+9eD
Svo2ijE=
=8s5h
-----END PGP SIGNATURE-----
--=-=-=--

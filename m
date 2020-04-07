Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D261A10FE
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Apr 2020 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDGQK2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Apr 2020 12:10:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33771 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQK2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Apr 2020 12:10:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id v7so2229913qkc.0;
        Tue, 07 Apr 2020 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eGGIgflAi1Rx0i4YeHsNyF8TLfihdhH0A3UApBunxKw=;
        b=UeBZMjeW9QpwMHslw0LpYRKrDNCSvjnIC9bh5oVODZ5jJ3LTgq6BFfgytYojTMnPGd
         KQVJjqErBLJCf3nhQ86gI2Ap1nmn2l7BLEKeqmQ3W1jM6otliGzNRM6fy5RjeGnxk/NA
         xu1MLaODBh9OFcGf6XNtO09Kdz/MQjR9btu2HeBD5XC6xTxNWuAqKFiKpj5dzSFxjfI0
         GSTLLFjlhJvUGhEKkkFQbJIirDbSQ4Zom2uGZsYQRp10h9ltZLekP6dIktHlWXAvHWOi
         y6h4tO4VMO7DKoCNRd3XVnNsWSDIaHBPjQgM2XOUWl9j4poY0lTF/C+0o8sW6vNAz3Re
         q6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eGGIgflAi1Rx0i4YeHsNyF8TLfihdhH0A3UApBunxKw=;
        b=Lklop59Y1U5VSo7tMpwVnlPdyafJ+f/1QWs960N+cWOlg8SjkVN6JVS5TU8fRFbBUp
         EsIN4CJworBI8qfK2LjdsW2Z3I9qAELPLZ1UrLYjSqTj/mf8Re2VhTeH022hlLTx6cVU
         G/pcGogvBht9NhfGqyk8vvbpWIVb4qc06SiXlxh81oIrF7BTTrHspHenFYRehQj0dAwH
         m111eSgar7st37D/dRtXrHBAbzfKsaxwsM0WlihE1sj0bg+qVrnkgiK1q2ZDeiJ54yGQ
         PPXZ9zBUjKnhC5/CuRyJIEr7uNtz4SDSXygYVLFxeUTulykaznzOpQwr1wfvKKK2O9xB
         O3cQ==
X-Gm-Message-State: AGi0PuYrtjjG+fezBCXcqWI/a8bVejj3Z46nSN/xJPc/T7rWfRUorF1A
        ulA5IraJFJrdFjOSQTU9PIB6H4fh
X-Google-Smtp-Source: APiQypJZL7GLHt87xs3j9h68rnO/+XxztCrY/kDsO8GwYUMHXYCJaFcrnwTSf08FTLjSqqFsIVNkqQ==
X-Received: by 2002:a37:6585:: with SMTP id z127mr3009066qkb.463.1586275826317;
        Tue, 07 Apr 2020 09:10:26 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g63sm13032233qkb.89.2020.04.07.09.10.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 09:10:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <87blo4w57m.fsf@notabene.neil.brown.name>
Date:   Tue, 7 Apr 2020 12:10:23 -0400
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5049620F-4C6B-4704-A074-6C0C5629CCE4@gmail.com>
References: <87tv2b7q72.fsf@notabene.neil.brown.name>
 <87v9miydai.fsf@notabene.neil.brown.name>
 <87ftdgw58w.fsf@notabene.neil.brown.name>
 <87blo4w57m.fsf@notabene.neil.brown.name>
To:     Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 6, 2020, at 7:43 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in the
> loop block driver, where a daemon needs to write to one bdi (the final
> bdi) in order to free up writes queued to another bdi (the client =
bdi).
>=20
> The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
> pages, so that it can still dirty pages after other processses have =
been
> throttled.
>=20
> This approach was designed when all threads were blocked equally,
> independently on which device they were writing to, or how fast it =
was.
> Since that time the writeback algorithm has changed substantially with
> different threads getting different allowances based on non-trivial
> heuristics.  This means the simple "add 25%" heuristic is no longer
> reliable.
>=20
> The important issue is not that the daemon needs a *larger* dirty page
> allowance, but that it needs a *private* dirty page allowance, so that
> dirty pages for the "client" bdi that it is helping to clear (the bdi =
for
> an NFS filesystem or loop block device etc) do not affect the =
throttling
> of the deamon writing to the "final" bdi.
>=20
> This patch changes the heuristic to ignore the global limits and
> consider only the limit relevant to the bdi being written to.  This
> approach is already available for BDI_CAP_STRICTLIMIT users (fuse) and
> should not introduce surprises.  This has the desired result of
> protecting the task from the consequences of large amounts of dirty =
data
> queued for other devices.
>=20
> This approach of "only consider the target bdi" is consistent with the
> other use of PF_LESS_THROTTLE in current_may_throttle(), were it =
causes
> attention to be focussed only on the target bdi.
>=20
> So this patch
> - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
> - removes the 25% bonus that that flag gives, and
> - imposes 'strictlimit' handling for any process with =
PF_LOCAL_THROTTLE
>   set.
>=20
> Note that previously realtime threads were treated the same as
> PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour =
for
> real-time threads, so it is now different from the behaviour of nfsd =
and
> loop tasks.  I don't know what is wanted for realtime.
>=20
> Note that the worst-case situation with this patch is that the =
threshold
> might be calculated as zero.  In that case the daemon may block when
> there are any dirty pages for the final bdi.  These will eventually
> clear and the daemon will be able to proceed.  The writing of those
> dirty pages will increase the apparent throughput of the final bdi and
> thus increase its threshold for future calculations.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> drivers/block/loop.c  |  2 +-
> fs/nfsd/vfs.c         |  9 +++++----
> include/linux/sched.h |  3 ++-
> kernel/sys.c          |  2 +-
> mm/page-writeback.c   | 10 ++++++----
> mm/vmscan.c           |  4 ++--
> 6 files changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a42c49e04954..0e13b9fc8dfa 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -899,7 +899,7 @@ static void loop_unprepare_queue(struct =
loop_device *lo)
>=20
> static int loop_kthread_worker_fn(void *worker_ptr)
> {
> -	current->flags |=3D PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
> +	current->flags |=3D PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
> 	return kthread_worker_fn(worker_ptr);
> }
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 0aa02eb18bd3..c3fbab1753ec 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -979,12 +979,13 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct =
svc_fh *fhp, struct nfsd_file *nf,

Assuming these patches are not going through the NFSD tree, so this hunk =
is

Acked-by: Chuck Lever <chuck.lever@oracle.com>

If this isn't necessary or appropriate, then ignore me :-)


> 	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
> 		/*
> -		 * We want less throttling in balance_dirty_pages()
> -		 * and shrink_inactive_list() so that nfs to
> +		 * We want throttling in balance_dirty_pages()
> +		 * and shrink_inactive_list() to only consider
> +		 * the backingdev we are writing to, so that nfs to
> 		 * localhost doesn't cause nfsd to lock up due to all
> 		 * the client's dirty pages or its congested queue.
> 		 */
> -		current->flags |=3D PF_LESS_THROTTLE;
> +		current->flags |=3D PF_LOCAL_THROTTLE;
>=20
> 	exp =3D fhp->fh_export;
> 	use_wgather =3D (rqstp->rq_vers =3D=3D 2) && EX_WGATHER(exp);
> @@ -1037,7 +1038,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct =
svc_fh *fhp, struct nfsd_file *nf,
> 		nfserr =3D nfserrno(host_err);
> 	}
> 	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
> -		current_restore_flags(pflags, PF_LESS_THROTTLE);
> +		current_restore_flags(pflags, PF_LOCAL_THROTTLE);
> 	return nfserr;
> }
>=20
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4418f5cb8324..5955a089df32 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1481,7 +1481,8 @@ extern struct pid *cad_pid;
> #define PF_KSWAPD		0x00020000	/* I am kswapd */
> #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation =
requests will inherit GFP_NOFS */
> #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation =
requests will inherit GFP_NOIO */
> -#define PF_LESS_THROTTLE	0x00100000	/* Throttle me less: I =
clean memory */
> +#define PF_LOCAL_THROTTLE	0x00100000	/* Throttle writes only =
agasint the bdi I write to,
> +						 * I am cleaning dirty =
pages from some other bdi. */
> #define PF_KTHREAD		0x00200000	/* I am a kernel thread =
*/
> #define PF_RANDOMIZE		0x00400000	/* Randomize virtual =
address space */
> #define PF_SWAPWRITE		0x00800000	/* Allowed to write to =
swap */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index d325f3ab624a..180a2fa33f7f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2262,7 +2262,7 @@ int __weak arch_prctl_spec_ctrl_set(struct =
task_struct *t, unsigned long which,
> 	return -EINVAL;
> }
>=20
> -#define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE)
> +#define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>=20
> SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned =
long, arg3,
> 		unsigned long, arg4, unsigned long, arg5)
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 7326b54ab728..4c9875971de5 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -387,8 +387,7 @@ static unsigned long global_dirtyable_memory(void)
>  * Calculate @dtc->thresh and ->bg_thresh considering
>  * vm_dirty_{bytes|ratio} and dirty_background_{bytes|ratio}.  The =
caller
>  * must ensure that @dtc->avail is set before calling this function.  =
The
> - * dirty limits will be lifted by 1/4 for PF_LESS_THROTTLE (ie. nfsd) =
and
> - * real-time tasks.
> + * dirty limits will be lifted by 1/4 for real-time tasks.
>  */
> static void domain_dirty_limits(struct dirty_throttle_control *dtc)
> {
> @@ -436,7 +435,7 @@ static void domain_dirty_limits(struct =
dirty_throttle_control *dtc)
> 	if (bg_thresh >=3D thresh)
> 		bg_thresh =3D thresh / 2;
> 	tsk =3D current;
> -	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
> +	if (rt_task(tsk)) {
> 		bg_thresh +=3D bg_thresh / 4 + =
global_wb_domain.dirty_limit / 32;
> 		thresh +=3D thresh / 4 + global_wb_domain.dirty_limit / =
32;
> 	}
> @@ -486,7 +485,7 @@ static unsigned long node_dirty_limit(struct =
pglist_data *pgdat)
> 	else
> 		dirty =3D vm_dirty_ratio * node_memory / 100;
>=20
> -	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk))
> +	if (rt_task(tsk))
> 		dirty +=3D dirty / 4;
>=20
> 	return dirty;
> @@ -1580,6 +1579,9 @@ static void balance_dirty_pages(struct =
bdi_writeback *wb,
> 	bool strictlimit =3D bdi->capabilities & BDI_CAP_STRICTLIMIT;
> 	unsigned long start_time =3D jiffies;
>=20
> +	if (current->flags & PF_LOCAL_THROTTLE)
> +		/* This task must only be throttled by its own writeback =
*/
> +		strictlimit =3D true;
> 	for (;;) {
> 		unsigned long now =3D jiffies;
> 		unsigned long dirty, thresh, bg_thresh;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2e8e690d2813..b776da4bb8c8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1879,13 +1879,13 @@ static unsigned noinline_for_stack =
move_pages_to_lru(struct lruvec *lruvec,
>=20
> /*
>  * If a kernel thread (such as nfsd for loop-back mounts) services
> - * a backing device by writing to the page cache it sets =
PF_LESS_THROTTLE.
> + * a backing device by writing to the page cache it sets =
PF_LOCAL_THROTTLE.
>  * In that case we should only throttle if the backing device it is
>  * writing to is congested.  In other cases it is safe to throttle.
>  */
> static int current_may_throttle(void)
> {
> -	return !(current->flags & PF_LESS_THROTTLE) ||
> +	return !(current->flags & PF_LOCAL_THROTTLE) ||
> 		current->backing_dev_info =3D=3D NULL ||
> 		bdi_write_congested(current->backing_dev_info);
> }
> --=20
> 2.26.0
>=20

--
Chuck Lever
chucklever@gmail.com




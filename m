Return-Path: <linux-nfs+bounces-13138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61648B098D9
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 02:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C67B44DD
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F11286A9;
	Fri, 18 Jul 2025 00:18:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6E28382
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797912; cv=none; b=utZJ0PtPYZOaDoxYQI39cUnPKh3bcUsnBFF0sVELQZQPqXPd45xdwhZMgrVr26ofhmH3Z0zYTIS11Z5NxKZVkS0JaHIdW1Wi2y6fZ7HNd9Ydqy3f8rAuyRIyjyTMZYv+YMR/lOrLB+c2Qs2nvjM75Fy9eXGyxlB1DRwF0/e45Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797912; c=relaxed/simple;
	bh=0ZrPWHI0AWvmoeMXGtO3piJc71f0isqaKk6qKuYKF0g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tDT2hxXpIjFlJli+6MtFQ7IXtSrEVG8eAS3UORfOAH4ib2KcMlOtfExK5nM0UKWF16m1X6Mga8LNsTmDNj8XhBlm48iF6EyKmGqx8mLU3mYvUJKrqieDlkJ9j+whZ5OM5GYW7+Zlx3SbpH6iC4Q9IL4SJP13UWJZ0wKUqdBPsm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ucYns-002PsH-It;
	Fri, 18 Jul 2025 00:18:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix localio hangs
In-reply-to: <aHg1RLw-5Csbiber@kernel.org>
References: <>, <aHg1RLw-5Csbiber@kernel.org>
Date: Fri, 18 Jul 2025 10:18:22 +1000
Message-id: <175279790201.2234665.6868024697891438867@noble.neil.brown.name>

On Thu, 17 Jul 2025, Mike Snitzer wrote:
> On Thu, Jul 17, 2025 at 08:09:11AM +1000, NeilBrown wrote:
> > On Thu, 17 Jul 2025, Trond Myklebust wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >=20
> > > The following patch series fixes a series of issues with the current
> > > localio code, as reported in the link
> > > https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/
> > >=20
> > >=20
> > > Trond Myklebust (3):
> > >   NFS/localio: nfs_close_local_fh() fix check for file closed
> > >   NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
> > >   NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file
> >=20
> > That all looks good to me - thanks a lot for finding and fixing my bugs.
> >=20
> > Reviewed-by: NeilBrown <neil@brown.name>
> >=20
> > I'd still like to fix the nfsd_file_cache_purge() issue but that is
> > quite separate especially now that you've prevented it causing problems
> > for nfs_uuid_put().
> >=20
> > thanks,
> > NeilBrown
>=20
> Unfortunately even with these 3 v2 fixes I was just able to hit the
> same hang on NFSD shutdown.  It took 5 iterations of the fio test,
> reported here:
> https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/
> So it is harder to hit with these v2 fixes, nevertheless:
>=20
> [  369.528839] task:rpc.nfsd        state:D stack:0     pid:10569 tgid:1056=
9 ppid:1      flags:0x00004006

Are there any other tasks which are in "state:D", or any nfsd or nfs
processes that are waiting in any state?

I'll see if I can work out any way that an nfsd_net_ref reference might leak.

Thanks,
NeilBrown

> [  369.528985] Call Trace:
> [  369.529127]  <TASK>
> [  369.529295]  __schedule+0x26d/0x530
> [  369.529435]  schedule+0x27/0xa0
> [  369.529566]  schedule_timeout+0x14e/0x160
> [  369.529700]  ? svc_destroy+0xce/0x160 [sunrpc]
> [  369.529882]  ? lockd_put+0x5f/0x90 [lockd]
> [  369.530022]  __wait_for_common+0x8f/0x1d0
> [  369.530154]  ? __pfx_schedule_timeout+0x10/0x10
> [  369.530329]  nfsd_destroy_serv+0x13f/0x1a0 [nfsd]
> [  369.530516]  nfsd_svc+0xe0/0x170 [nfsd]
> [  369.530684]  write_threads+0xc3/0x190 [nfsd]
> [  369.530845]  ? simple_transaction_get+0xc2/0xe0
> [  369.530973]  ? __pfx_write_threads+0x10/0x10 [nfsd]
> [  369.531133]  nfsctl_transaction_write+0x47/0x80 [nfsd]
> [  369.531324]  vfs_write+0xfa/0x420
> [  369.531448]  ? do_filp_open+0xae/0x150
> [  369.531574]  ksys_write+0x63/0xe0
> [  369.531693]  do_syscall_64+0x7d/0x160
> [  369.531816]  ? do_sys_openat2+0x81/0xd0
> [  369.531937]  ? syscall_exit_work+0xf3/0x120
> [  369.532058]  ? syscall_exit_to_user_mode+0x32/0x1b0
> [  369.532178]  ? do_syscall_64+0x89/0x160
> [  369.532344]  ? __mod_memcg_lruvec_state+0x95/0x150
> [  369.532465]  ? __lruvec_stat_mod_folio+0x84/0xd0
> [  369.532584]  ? syscall_exit_work+0xf3/0x120
> [  369.532705]  ? syscall_exit_to_user_mode+0x32/0x1b0
> [  369.532827]  ? do_syscall_64+0x89/0x160
> [  369.532947]  ? __handle_mm_fault+0x326/0x730
> [  369.533066]  ? __mod_memcg_lruvec_state+0x95/0x150
> [  369.533187]  ? __count_memcg_events+0x53/0xf0
> [  369.533306]  ? handle_mm_fault+0x245/0x340
> [  369.533427]  ? do_user_addr_fault+0x341/0x6b0
> [  369.533547]  ? exc_page_fault+0x70/0x160
> [  369.533666]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  369.533787] RIP: 0033:0x7f1db10fd617
>=20
> crash> dis -l nfsd_destroy_serv+0x13f
> /root/snitm/git/linux-HS/fs/nfsd/nfssvc.c: 468
> 0xffffffffc172e36f <nfsd_destroy_serv+319>:     mov    %r12,%rdi
>=20
> which is the percpu_ref_exit() in nfsd_shutdown_net():
>=20
> static void nfsd_shutdown_net(struct net *net)
> {
>         struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>=20
>         if (!nn->nfsd_net_up)
>                 return;
>=20
>         percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
>         wait_for_completion(&nn->nfsd_net_confirm_done);
>=20
>         nfsd_export_flush(net);
>         nfs4_state_shutdown_net(net);
>         nfsd_reply_cache_shutdown(nn);
>         nfsd_file_cache_shutdown_net(net);
>         if (nn->lockd_up) {
>                 lockd_down(net);
>                 nn->lockd_up =3D false;
>         }
>=20
>         wait_for_completion(&nn->nfsd_net_free_done);
>    ---> percpu_ref_exit(&nn->nfsd_net_ref);
>=20
>         nn->nfsd_net_up =3D false;
>         nfsd_shutdown_generic();
> }
>=20



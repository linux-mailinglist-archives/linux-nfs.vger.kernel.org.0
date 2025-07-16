Return-Path: <linux-nfs+bounces-13121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF4B08104
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 01:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC1580CE7
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Jul 2025 23:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09B2EF640;
	Wed, 16 Jul 2025 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMyYpB5r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767902EF2BD
	for <linux-nfs@vger.kernel.org>; Wed, 16 Jul 2025 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752708421; cv=none; b=CbeyPl6o1Ra0g8CeXmxkFHJcywXwutwtOkcXzj3laZQDxhCcZxCz/0U+XZx+GXxNAuU8PMxihfiLxqCqDLf9+6FWHRm0hg/spW+2BHClp9igZc6ybuWJ3cf8s23S2RgtwU7iCZYyuDtogFaXpssyuPI+cMSLFH8NT87/N9FR1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752708421; c=relaxed/simple;
	bh=1wgKW+X5lNcUr3Hu4MocCJNiAUFiv5viU6zmcpeVWd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9ElJK4PqnV2l0y4jVJ3aPMZh1IRe6UP4+sLWYp3sz9scWmZmRBqdIyDn6pdAuXlt2u7LWTTqAW/nQnDaS+bsuKvMQn4ELORRPz+/6prLThvJwiYKuwZx959w7Bdao1FECIIo9AdXjMNHvwi7nWo2ay4gG04yco//hIApycnALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMyYpB5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18852C4CEE7;
	Wed, 16 Jul 2025 23:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752708421;
	bh=1wgKW+X5lNcUr3Hu4MocCJNiAUFiv5viU6zmcpeVWd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMyYpB5rFuObgarOZeIFJ6CDjG454m/IaNb7xRuz6FdnswfwLJv3HU6pKZGEM7aYk
	 5TjtYJO/Z2jVS2yGP5co3DVM6HxBMOrgw9fzUIM6kmI5bFD5W0LyJ1H7jTYF0KS57Q
	 QIwgZHip6mE0wsWJ2O6TinSz3rHvRqhjYfQl/hrL09tlB26KR4FdU2NYKEHl9H4nYI
	 B7mgG1SUx8mlg9g8W6PxEQbrYfX/4R4oKDQe+62+VBDH66ybWBNLbTDCBNP22ya0IA
	 LiWYGz9X6aJRkyY/Wx288YDBpt2P88Zy6oW8krJSQUwO+erqRokTLXFWgoBLWjZhFe
	 m2ANoLSElxLQg==
Date: Wed, 16 Jul 2025 19:27:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix localio hangs
Message-ID: <aHg1RLw-5Csbiber@kernel.org>
References: <cover.1752618161.git.trond.myklebust@hammerspace.com>
 <cover.1752671200.git.trond.myklebust@hammerspace.com>
 <175270375199.2234665.7748991440226043304@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175270375199.2234665.7748991440226043304@noble.neil.brown.name>

On Thu, Jul 17, 2025 at 08:09:11AM +1000, NeilBrown wrote:
> On Thu, 17 Jul 2025, Trond Myklebust wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > The following patch series fixes a series of issues with the current
> > localio code, as reported in the link
> > https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/
> > 
> > 
> > Trond Myklebust (3):
> >   NFS/localio: nfs_close_local_fh() fix check for file closed
> >   NFS/localio: nfs_uuid_put() fix races with nfs_open/close_local_fh()
> >   NFS/localio: nfs_uuid_put() fix the wake up after unlinking the file
> 
> That all looks good to me - thanks a lot for finding and fixing my bugs.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> 
> I'd still like to fix the nfsd_file_cache_purge() issue but that is
> quite separate especially now that you've prevented it causing problems
> for nfs_uuid_put().
> 
> thanks,
> NeilBrown

Unfortunately even with these 3 v2 fixes I was just able to hit the
same hang on NFSD shutdown.  It took 5 iterations of the fio test,
reported here:
https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/
So it is harder to hit with these v2 fixes, nevertheless:

[  369.528839] task:rpc.nfsd        state:D stack:0     pid:10569 tgid:10569 ppid:1      flags:0x00004006
[  369.528985] Call Trace:
[  369.529127]  <TASK>
[  369.529295]  __schedule+0x26d/0x530
[  369.529435]  schedule+0x27/0xa0
[  369.529566]  schedule_timeout+0x14e/0x160
[  369.529700]  ? svc_destroy+0xce/0x160 [sunrpc]
[  369.529882]  ? lockd_put+0x5f/0x90 [lockd]
[  369.530022]  __wait_for_common+0x8f/0x1d0
[  369.530154]  ? __pfx_schedule_timeout+0x10/0x10
[  369.530329]  nfsd_destroy_serv+0x13f/0x1a0 [nfsd]
[  369.530516]  nfsd_svc+0xe0/0x170 [nfsd]
[  369.530684]  write_threads+0xc3/0x190 [nfsd]
[  369.530845]  ? simple_transaction_get+0xc2/0xe0
[  369.530973]  ? __pfx_write_threads+0x10/0x10 [nfsd]
[  369.531133]  nfsctl_transaction_write+0x47/0x80 [nfsd]
[  369.531324]  vfs_write+0xfa/0x420
[  369.531448]  ? do_filp_open+0xae/0x150
[  369.531574]  ksys_write+0x63/0xe0
[  369.531693]  do_syscall_64+0x7d/0x160
[  369.531816]  ? do_sys_openat2+0x81/0xd0
[  369.531937]  ? syscall_exit_work+0xf3/0x120
[  369.532058]  ? syscall_exit_to_user_mode+0x32/0x1b0
[  369.532178]  ? do_syscall_64+0x89/0x160
[  369.532344]  ? __mod_memcg_lruvec_state+0x95/0x150
[  369.532465]  ? __lruvec_stat_mod_folio+0x84/0xd0
[  369.532584]  ? syscall_exit_work+0xf3/0x120
[  369.532705]  ? syscall_exit_to_user_mode+0x32/0x1b0
[  369.532827]  ? do_syscall_64+0x89/0x160
[  369.532947]  ? __handle_mm_fault+0x326/0x730
[  369.533066]  ? __mod_memcg_lruvec_state+0x95/0x150
[  369.533187]  ? __count_memcg_events+0x53/0xf0
[  369.533306]  ? handle_mm_fault+0x245/0x340
[  369.533427]  ? do_user_addr_fault+0x341/0x6b0
[  369.533547]  ? exc_page_fault+0x70/0x160
[  369.533666]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  369.533787] RIP: 0033:0x7f1db10fd617

crash> dis -l nfsd_destroy_serv+0x13f
/root/snitm/git/linux-HS/fs/nfsd/nfssvc.c: 468
0xffffffffc172e36f <nfsd_destroy_serv+319>:     mov    %r12,%rdi

which is the percpu_ref_exit() in nfsd_shutdown_net():

static void nfsd_shutdown_net(struct net *net)
{
        struct nfsd_net *nn = net_generic(net, nfsd_net_id);

        if (!nn->nfsd_net_up)
                return;

        percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
        wait_for_completion(&nn->nfsd_net_confirm_done);

        nfsd_export_flush(net);
        nfs4_state_shutdown_net(net);
        nfsd_reply_cache_shutdown(nn);
        nfsd_file_cache_shutdown_net(net);
        if (nn->lockd_up) {
                lockd_down(net);
                nn->lockd_up = false;
        }

        wait_for_completion(&nn->nfsd_net_free_done);
   ---> percpu_ref_exit(&nn->nfsd_net_ref);

        nn->nfsd_net_up = false;
        nfsd_shutdown_generic();
}


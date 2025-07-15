Return-Path: <linux-nfs+bounces-13087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9314FB0644C
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 18:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D3C3A744D
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jul 2025 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0238F26738D;
	Tue, 15 Jul 2025 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjvRQL3k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01FE266B41
	for <linux-nfs@vger.kernel.org>; Tue, 15 Jul 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596703; cv=none; b=IJssCCrdZhWxQEngPL56ML1ZJNaBOiyYqi3ycOqnUQgJ1MBvrivMq1eTdi3WPdVI5564e8ebIrpIZh63uS0WhxqjZ3XpX/2ktILh35VG1vi5yJuwy/EW1kKlsTdrV/8OfWKOPE0p+oSemgPHZKXhttslfpNYvzzD/P+Bxior0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596703; c=relaxed/simple;
	bh=xU/I9vNBz/zshTA/ix9M2tvfnvlLaIrS1FcyIX2EzrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw8tesh09OqGPP0eLgeCJLCQqI/HctAnoqqZB4no8fguLfJvUD3P6K8FfyN0pvqyAGBtgRI2/RVqfDkxULbGokQC8s926Rcl6RaAcCk7D8VtwOfWLoG5HLfy22u2jDkbJIiOBqE7CxQIfiypX1h85znIXxt//71dZ/0aTrRhutA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjvRQL3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3466BC4CEE3;
	Tue, 15 Jul 2025 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752596703;
	bh=xU/I9vNBz/zshTA/ix9M2tvfnvlLaIrS1FcyIX2EzrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjvRQL3kB1oHRUIunzr2NB4xw9Hrdwg9qv12hr/WXlJ9/1R7g8LxRStqXsunoQkP5
	 LLtYGIlA8niYAsw/qRbMFAC4dHQLyNEVI65SVVsLl9GBQrka6bqEMy7ZqLSE1PsABQ
	 5rqqzmnk4xTsnbVcf2yCoH7fjN6AxgxKp1MZW28n7mpHYf/CHsgB/4SnEHPSKCIsax
	 H6OeqrJxCE0mByocif01C6otah8NqXxT+2Yz710+kefCdSuECikIRPfBrA2mwYYzrO
	 DrkIz293DSzmOZ7rH1KERFXbm1p/6gCh/DSZTKKZ0XBNnBJJkI+P0JpmGz8q3gtYCM
	 ESJ5hoIoeim/g==
Date: Tue, 15 Jul 2025 12:25:01 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: nfslocalio: use correct wait address in nfs_uuid_put()
Message-ID: <aHaA3W9Es2P90Kgk@kernel.org>
References: <175246537302.2234665.6977010546892567896@noble.neil.brown.name>
 <aHUUzYFfNa2ecJGU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUUzYFfNa2ecJGU@kernel.org>

On Mon, Jul 14, 2025 at 10:31:43AM -0400, Mike Snitzer wrote:
> On Mon, Jul 14, 2025 at 01:56:13PM +1000, NeilBrown wrote:
> > 
> > This wait_var_event_spinlock() in nfs_uuid_put() is waiting for the
> > wakeup signalled at the end of nfs_close_local_fh().  That
> > wake_up_var_locked() uses &nfl->nfs_uuid, so the waiter must use the
> > same address, else nfs_uuid_put() could wait indefinitely causing
> > various problems.
> > 
> > Fixes: 21fb44034695 ("nfs_localio: protect race between nfs_uuid_put() and nfs_close_local_fh()")
> > Reported-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfs_common/nfslocalio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > index 05c7c16e37ab..bc8dcfb256a3 100644
> > --- a/fs/nfs_common/nfslocalio.c
> > +++ b/fs/nfs_common/nfslocalio.c
> > @@ -177,7 +177,7 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
> >  			/* nfs_close_local_fh() is doing the
> >  			 * close and we must wait. until it unlinks
> >  			 */
> > -			wait_var_event_spinlock(nfl,
> > +			wait_var_event_spinlock(&nfl->nfs_uuid,
> >  						list_first_entry_or_null(
> >  							&nfs_uuid->files,
> >  							struct nfs_file_localio,
> > -- 
> > 2.49.0
> > 
> > 
> 
> Makes sense:
> 
> Acked-by: Mike Snitzer <snitzer@kernel.org>
> 
> And I _will_ try to get this tested at the scale I was able to test
> late last week.  Will let you and others know (hopefully within the
> next 24h).

Unfortunately this fix doesn't resolve the hang I easily experience
simply by running fio like I reported here (followed by attempted NFSD
shutdown):
https://lore.kernel.org/linux-nfs/aG0pJXVtApZ9C5vy@kernel.org/

After fio runs, 'systemctl stop proc-fs-nfsd.mount' hangs:

[  737.997724] INFO: task rpc.nfsd:9947 blocked for more than 122 seconds.
[  737.997984]       Not tainted 6.12.24.9.hs.snitm+ #16
[  737.998155] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  737.998304] task:rpc.nfsd        state:D stack:0     pid:9947  tgid:9947  ppid:1      flags:0x00004006
[  737.998453] Call Trace:
[  737.998597]  <TASK>
[  737.998781]  __schedule+0x26d/0x530
[  737.998925]  schedule+0x27/0xa0
[  737.999057]  schedule_timeout+0x14e/0x160
[  737.999193]  ? svc_destroy+0xce/0x160 [sunrpc]
[  737.999378]  ? lockd_put+0x5f/0x90 [lockd]
[  737.999518]  __wait_for_common+0x8f/0x1d0
[  737.999667]  ? __pfx_schedule_timeout+0x10/0x10
[  737.999801]  nfsd_destroy_serv+0x13f/0x1a0 [nfsd]
[  737.999976]  nfsd_svc+0xe0/0x170 [nfsd]
[  738.000136]  write_threads+0xc3/0x190 [nfsd]
[  738.000293]  ? simple_transaction_get+0xc2/0xe0
[  738.000421]  ? __pfx_write_threads+0x10/0x10 [nfsd]
[  738.000578]  nfsctl_transaction_write+0x47/0x80 [nfsd]
[  738.000780]  vfs_write+0xfa/0x420
[  738.000906]  ksys_write+0x63/0xe0
[  738.001030]  do_syscall_64+0x7d/0x160
[  738.001152]  ? do_user_addr_fault+0x341/0x6b0
[  738.001278]  ? exc_page_fault+0x70/0x160
[  738.001400]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  738.001526] RIP: 0033:0x7fd836efd617
[  738.001661] RSP: 002b:00007ffee6d1ff18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  738.001788] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd836efd617
[  738.001914] RDX: 0000000000000002 RSI: 0000558592fc1c20 RDI: 0000000000000003
[  738.002041] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007ffee6d1fdb0
[  738.002169] R10: 0000000000000000 R11: 0000000000000246 R12: 0000558592fc1c20
[  738.002298] R13: 00007fd83711a6c8 R14: 00007ffee6d1ffe0 R15: 00000000ffffffff
[  738.002429]  </TASK>

So I stand by my _strong_ suggestion to revert your LOCALIO changes
in time for 6.16-rc7 (changes that were merged for 6.16), series here:
https://lore.kernel.org/linux-nfs/20250714031359.10192-1-snitzer@kernel.org/

At this point they'd even be difficult to justify landing during the
6.17 merge window let alone 6.16 final.

Just the messenger here.. sorry.

Mike


Return-Path: <linux-nfs+bounces-1632-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC92E8444AC
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 17:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D30D1F2133D
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E2C79DB4;
	Wed, 31 Jan 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfTgM5GT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805378B7F
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719090; cv=none; b=e0qPtXs7q58AeCawht3beVLRcEg3u0CJKFxAxIEQ/Bi9+J0ljoU080n5cLsmsX4cof/EWF/ob7PibwdMf6VZAEwaZpRV/V1zCxAL3lLN9yqaFKiD9YWoPkGkwhEm0qmWDmdkavhC1WH6Rm+9dXNPe15nY9YhU6wDn0ikQvlWTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719090; c=relaxed/simple;
	bh=6F4Mf/f9tvGP/L3Z20gcZ9Ik6cCfJ7pm7fXs4ZMyfT0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gn31tL8XfGpVG53V1EyBg5H3I8irovAAQlZdfCDN/wUZKBXZPejq+l9BqNIaQ8n20oEvjUS8BTC5JCAKtUxdf0O1D67EJdWuLBQL4+R1adRr2ABocymBNFvOGIpQmDUqA2/JTdsPFpg9hYqr8dOr3+kFvnv/MVbIUimTBGjelmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfTgM5GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BADC433F1;
	Wed, 31 Jan 2024 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706719088;
	bh=6F4Mf/f9tvGP/L3Z20gcZ9Ik6cCfJ7pm7fXs4ZMyfT0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TfTgM5GTsOFWw53I4C4091eV9ADParYG2iXHv+thcfI6oGNl5T0gh3wbgnSZg2qOh
	 RgpWFP2VuNqKvCEGdCKMIJkzgn3YNvMaczdO5S9nZWelkgP4whKcF5zUk57EdgZxDe
	 U1Voyj1h4YqLc7CtWBPcz4yQdNVpS+YHAgqp755+ocVIV8K0R8g1qfyHKPXhkG7H6c
	 dla6Db5oVDAyZQAaxjTHFO4humJZgRmcscVtHhcf/h5UMOH1sULA68/pBjmDBHJjIp
	 R+ch2n2dIz8voxHf45y8EpyBuihcdpdDhc4U6BBpZZmoONZIC0YYDkVkvFqzDmlEz+
	 fNlz1SyqeWurg==
Message-ID: <7cf2c981845d7680d86d9cf8da62d2267a65f8cd.camel@kernel.org>
Subject: Re: [PATCH v2] NFS: Fix nfs_netfs_issue_read() xarray locking for
 writeback interrupt
From: Jeff Layton <jlayton@kernel.org>
To: Dave Wysochanski <dwysocha@redhat.com>, Anna Schumaker
 <anna.schumaker@netapp.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>
Cc: David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-cachefs@redhat.com
Date: Wed, 31 Jan 2024 11:38:06 -0500
In-Reply-To: <20240131161006.1475094-1-dwysocha@redhat.com>
References: <20240131161006.1475094-1-dwysocha@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 11:10 -0500, Dave Wysochanski wrote:
> The loop inside nfs_netfs_issue_read() currently does not disable
> interrupts while iterating through pages in the xarray to submit
> for NFS read.  This is not safe though since after taking xa_lock,
> another page in the mapping could be processed for writeback inside
> an interrupt, and deadlock can occur.  The fix is simple and clean
> if we use xa_for_each_range(), which handles the iteration with RCU
> while reducing code complexity.
>=20
> The problem is easily reproduced with the following test:
>  mount -o vers=3D3,fsc 127.0.0.1:/export /mnt/nfs
>  dd if=3D/dev/zero of=3D/mnt/nfs/file1.bin bs=3D4096 count=3D1
>  echo 3 > /proc/sys/vm/drop_caches
>  dd if=3D/mnt/nfs/file1.bin of=3D/dev/null
>  umount /mnt/nfs
>=20
> On the console with a lockdep-enabled kernel a message similar to
> the following will be seen:
>=20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: inconsistent lock state
>  6.7.0-lockdbg+ #10 Not tainted
>  --------------------------------
>  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>  test5/1708 [HC0[0]:SC0[0]:HE1:SE1] takes:
>  ffff888127baa598 (&xa->xa_lock#4){+.?.}-{3:3}, at:
> nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
>  {IN-SOFTIRQ-W} state was registered at:
>    lock_acquire+0x144/0x380
>    _raw_spin_lock_irqsave+0x4e/0xa0
>    __folio_end_writeback+0x17e/0x5c0
>    folio_end_writeback+0x93/0x1b0
>    iomap_finish_ioend+0xeb/0x6a0
>    blk_update_request+0x204/0x7f0
>    blk_mq_end_request+0x30/0x1c0
>    blk_complete_reqs+0x7e/0xa0
>    __do_softirq+0x113/0x544
>    __irq_exit_rcu+0xfe/0x120
>    irq_exit_rcu+0xe/0x20
>    sysvec_call_function_single+0x6f/0x90
>    asm_sysvec_call_function_single+0x1a/0x20
>    pv_native_safe_halt+0xf/0x20
>    default_idle+0x9/0x20
>    default_idle_call+0x67/0xa0
>    do_idle+0x2b5/0x300
>    cpu_startup_entry+0x34/0x40
>    start_secondary+0x19d/0x1c0
>    secondary_startup_64_no_verify+0x18f/0x19b
>  irq event stamp: 176891
>  hardirqs last  enabled at (176891): [<ffffffffa67a0be4>]
> _raw_spin_unlock_irqrestore+0x44/0x60
>  hardirqs last disabled at (176890): [<ffffffffa67a0899>]
> _raw_spin_lock_irqsave+0x79/0xa0
>  softirqs last  enabled at (176646): [<ffffffffa515d91e>]
> __irq_exit_rcu+0xfe/0x120
>  softirqs last disabled at (176633): [<ffffffffa515d91e>]
> __irq_exit_rcu+0xfe/0x120
>=20
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>=20
>         CPU0
>         ----
>    lock(&xa->xa_lock#4);
>    <Interrupt>
>      lock(&xa->xa_lock#4);
>=20
>   *** DEADLOCK ***
>=20
>  2 locks held by test5/1708:
>   #0: ffff888127baa498 (&sb->s_type->i_mutex_key#22){++++}-{4:4}, at:
>       nfs_start_io_read+0x28/0x90 [nfs]
>   #1: ffff888127baa650 (mapping.invalidate_lock#3){.+.+}-{4:4}, at:
>       page_cache_ra_unbounded+0xa4/0x280
>=20
>  stack backtrace:
>  CPU: 6 PID: 1708 Comm: test5 Kdump: loaded Not tainted 6.7.0-lockdbg+
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
> 04/01/2014
>  Call Trace:
>   dump_stack_lvl+0x5b/0x90
>   mark_lock+0xb3f/0xd20
>   __lock_acquire+0x77b/0x3360
>   _raw_spin_lock+0x34/0x80
>   nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
>   netfs_begin_read+0x77f/0x980 [netfs]
>   nfs_netfs_readahead+0x45/0x60 [nfs]
>   nfs_readahead+0x323/0x5a0 [nfs]
>   read_pages+0xf3/0x5c0
>   page_cache_ra_unbounded+0x1c8/0x280
>   filemap_get_pages+0x38c/0xae0
>   filemap_read+0x206/0x5e0
>   nfs_file_read+0xb7/0x140 [nfs]
>   vfs_read+0x2a9/0x460
>   ksys_read+0xb7/0x140
>=20
> Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when
> fscache is enabled")
> Suggested-by: Jeff Layton <jlayton@redhat.com>
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfs/fscache.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> index b05717fe0d4e..60a3c28784e0 100644
> --- a/fs/nfs/fscache.c
> +++ b/fs/nfs/fscache.c
> @@ -307,11 +307,11 @@ static void nfs_netfs_issue_read(struct netfs_io_su=
brequest *sreq)
>  	struct inode *inode =3D sreq->rreq->inode;
>  	struct nfs_open_context *ctx =3D sreq->rreq->netfs_priv;
>  	struct page *page;
> +	unsigned long idx;
>  	int err;
>  	pgoff_t start =3D (sreq->start + sreq->transferred) >> PAGE_SHIFT;
>  	pgoff_t last =3D ((sreq->start + sreq->len -
>  			 sreq->transferred - 1) >> PAGE_SHIFT);
> -	XA_STATE(xas, &sreq->rreq->mapping->i_pages, start);
> =20
>  	nfs_pageio_init_read(&pgio, inode, false,
>  			     &nfs_async_read_completion_ops);
> @@ -322,19 +322,14 @@ static void nfs_netfs_issue_read(struct netfs_io_su=
brequest *sreq)
> =20
>  	pgio.pg_netfs =3D netfs; /* used in completion */
> =20
> -	xas_lock(&xas);
> -	xas_for_each(&xas, page, last) {
> +	xa_for_each_range(&sreq->rreq->mapping->i_pages, idx, page, start, last=
) {
>  		/* nfs_read_add_folio() may schedule() due to pNFS layout and other RP=
Cs  */
> -		xas_pause(&xas);
> -		xas_unlock(&xas);
>  		err =3D nfs_read_add_folio(&pgio, ctx, page_folio(page));
>  		if (err < 0) {
>  			netfs->error =3D err;
>  			goto out;
>  		}
> -		xas_lock(&xas);
>  	}
> -	xas_unlock(&xas);
>  out:
>  	nfs_pageio_complete_read(&pgio);
>  	nfs_netfs_put(netfs);

Reviewed-by: Jeff Layton <jlayton@kernel.org>


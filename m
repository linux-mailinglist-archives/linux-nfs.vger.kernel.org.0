Return-Path: <linux-nfs+bounces-16147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886BC3CD3F
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 18:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 207284FC096
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A34634F46A;
	Thu,  6 Nov 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="celARsZo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9A34F462
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449795; cv=none; b=J6YSy/7akOAIouGez0Fji2bKVzHmSbSDdPhhvkynW5o51yjQ6CtaNsAvhAERj6rCqimdrZLSwRD+sWBd8uC2YBT5VsA3i9ldE7QIPA10e0pzZ0/CM2mnz5xD9yHFiddQ5LnfNkzEnwRrCh6DQNFRzG+3NPzZ8FbTNitAUa53mtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449795; c=relaxed/simple;
	bh=P7Nyaol4+rcqIgnbjlRVSn4hbazWwuOiSSy1v2LkPkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5Qhe0Qcm945tr2bqgpRhQHQdEyIVifUULw8qT2gu7WCiG8FwewOlkSVvkOIw+laZ29Up2i5gbcPz3Ehr9/cuyl4i4Pn/0j5M4vG2DVu5STF4NtDjNIJqyvg6W9mwyJMdfTwnoDmBUVbF3QL3Qkw9W8UJyCSo59PHapXxXVnZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=celARsZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86951C116C6;
	Thu,  6 Nov 2025 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762449795;
	bh=P7Nyaol4+rcqIgnbjlRVSn4hbazWwuOiSSy1v2LkPkM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=celARsZoUJl4S5f57iR/i0a9r5hGWFLh7oda/gL485YV+Qsf8BI3wpDE/YHbgu9iu
	 /QhTmkIfCto/z/VSb7K/apwdDnY3VpdxyyS/72TAS4rxfBXxFBy9EBAs0GHI6r6300
	 0+ntjB3QPhRxi65tAwB7iee9HR+qd0xIUKCnPAPxjFHfgmNiwl44OCwQwQh/btAzU4
	 J2tE1kS7CHW5lr4xwggMfbnYiVoydqeLPnzOHj1elITGJ2uFi46Q5AyB0DiuaNh9Iw
	 KUW/fL5xZAgaAg216+HPAA9SnImbnP2q6gZacyZQ1rrMwjPkeEXw2lvbeyLdYaABCm
	 eOXqkwEbGEypQ==
Message-ID: <8f4ce8f03919de7e29e2fc601ed9e25f392aa2c3.camel@kernel.org>
Subject: Re: [PATCH 1/2] locks: Introduce lm_breaker_timedout op to
 lease_manager_operations
From: Jeff Layton <jlayton@kernel.org>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com, neilb@ownmail.net,
 	okorniev@redhat.com, tom@talpey.com, hch@lst.de
Cc: linux-nfs@vger.kernel.org
Date: Thu, 06 Nov 2025 12:23:13 -0500
In-Reply-To: <20251106164821.300872-2-dai.ngo@oracle.com>
References: <20251106164821.300872-1-dai.ngo@oracle.com>
	 <20251106164821.300872-2-dai.ngo@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 08:47 -0800, Dai Ngo wrote:
> Some consumers of the lease_manager_operations need to perform additional
> actions when a lease break, triggered by a conflict, times out.
>=20
> The NFS server is the first consumer of this operation.
>=20
> When a pNFS layout conflict occurs, and the lease break times out -
> resulting in the layout being revoked and its file_lease beeing removed
> from the flc_lease list, the NFS server must issue a fence operation.
> This ensures that the client is prevented from accessing the data
> server after the layout is revoked.
>=20
> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |  2 ++
>  fs/locks.c                            | 14 +++++++++++---
>  include/linux/filelock.h              |  2 ++
>  3 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesy=
stems/locking.rst
> index 77704fde9845..cd600db6c4b9 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,7 @@ prototypes::
>  	bool (*lm_breaker_owns_lease)(struct file_lock *);
>          bool (*lm_lock_expirable)(struct file_lock *);
>          void (*lm_expire_lock)(void);
> +        void (*lm_breaker_timedout)(struct file_lease *);
> =20
>  locking rules:
> =20
> @@ -416,6 +417,7 @@ lm_change		yes		no			no
>  lm_breaker_owns_lease:	yes     	no			no
>  lm_lock_expirable	yes		no			no
>  lm_expire_lock		no		no			yes
> +lm_breaker_timedout     no              no                      yes
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e20724..1f254e0cd398 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
>  	while (!list_empty(dispose)) {
>  		flc =3D list_first_entry(dispose, struct file_lock_core, flc_list);
>  		list_del_init(&flc->flc_list);
> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
> +		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {
> +			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
> +				struct file_lease *fl =3D file_lease(flc);
> +
> +				if (fl->fl_lmops->lm_breaker_timedout)
> +					fl->fl_lmops->lm_breaker_timedout(fl);
> +			}
>  			locks_free_lease(file_lease(flc));
> -		else
> +		} else
>  			locks_free_lock(file_lock(flc));
>  	}
>  }

I think this would be fine in the case initial task that calls
__break_lease(), since that task will also be the one to call
locks_dispose_list() for the lease (and hence will fence the client). I
think though that if you have multiple tasks that end up blocked in
__break_lease(), that the later tasks could end up proceeding before
the client is properly fenced.

We'll need to ensure that any other breaking tasks block until the
fence operations are complete.

=20
> @@ -1482,8 +1488,10 @@ static void time_out_leases(struct inode *inode, s=
truct list_head *dispose)
>  		trace_time_out_leases(inode, fl);
>  		if (past_time(fl->fl_downgrade_time))
>  			lease_modify(fl, F_RDLCK, dispose);
> -		if (past_time(fl->fl_break_time))
> +		if (past_time(fl->fl_break_time)) {
>  			lease_modify(fl, F_UNLCK, dispose);
> +			fl->c.flc_flags |=3D FL_BREAKER_TIMEDOUT;
> +		}
>  	}
>  }
> =20
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index c2ce8ba05d06..06ccd6b66012 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -17,6 +17,7 @@
>  #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>  #define FL_LAYOUT	2048	/* outstanding pNFS layout */
>  #define FL_RECLAIM	4096	/* reclaiming from a reboot server */
> +#define	FL_BREAKER_TIMEDOUT	8192	/* lease breaker timed out */
> =20
>  #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
> =20
> @@ -49,6 +50,7 @@ struct lease_manager_operations {
>  	int (*lm_change)(struct file_lease *, int, struct list_head *);
>  	void (*lm_setup)(struct file_lease *, void **);
>  	bool (*lm_breaker_owns_lease)(struct file_lease *);
> +	void (*lm_breaker_timedout)(struct file_lease *fl);
>  };
> =20
>  struct lock_manager {

--=20
Jeff Layton <jlayton@kernel.org>


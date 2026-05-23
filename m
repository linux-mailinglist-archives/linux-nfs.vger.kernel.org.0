Return-Path: <linux-nfs+bounces-21856-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFJtHgmKEWoJnQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21856-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:05:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92315BEA23
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BD030131D0
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC334E75D;
	Sat, 23 May 2026 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj04OXDR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA42F1FDE;
	Sat, 23 May 2026 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534342; cv=none; b=j9CXL7qbRB6vB+DlVCxbz7ALs7e6OJV4BsnKOE9chZnOGGgj01CF1+YD9ZoGaqEGnFN9kHF0iwVzLGkRyzIOAUEnrL0qPETkyOrucrg6UE8sdvvVOpVYB8ul9hOJi8xC851QNYuZQOKnUPW2scSe0LoJ90Wnhm/06sL/JUv3vfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534342; c=relaxed/simple;
	bh=5hIbtimAoeueDk68q+7boRHwpe0V0Mhhcqs71r4MUlI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mt9gReerD4PdxIYJAsHHdVEsBb3zHMfjdmflBm/KV9Fc1GvCCRkqvmmwnwg3mnVGuSv1MrIjfi4D3X6QCUeHSQP3sLh8fe26Lz0VCQk3ncKwgAvbSPJgC98TzZ0nk5GBdixSGkgucShswEfGfbNhAWcduDrbu63Vl1LKpOrKkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj04OXDR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68381F000E9;
	Sat, 23 May 2026 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779534340;
	bh=DHcPsLxl4tklqx/HrPQUMI4h8lhyyZSQ2vjQ3j8IezA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yj04OXDRzVCOCz/aioL8499w0FQ0hhzf3uDwT/9SlQM10chPGw7u68ODmbbzLO7Tu
	 soVDLtP3wzzExdNDNwNJ8F27LnKMf3cJzv2OoleMKQwuMZeZZ9r/ljgc3Ic06ZUQlf
	 sFQTCvNtAd8Mqix7UQjBwQvN2zA+QrS5gQHAwdYJzpAvDYvdREURk45pNTsVDck+Si
	 d89j5AipRYVtCzTVNVfq7UJYTfa9Zy6z3nWLuOU1CsQ4CxBFv8xULPMFI/i4z20uQH
	 ff+FBBBXcTxGqiSJsHSlBd2kMTUwAXfnGgnyCUDv9HKASKpYAGJWn9Rw9h08nkvcdM
	 XRbcxVtW5NwDw==
Message-ID: <bdf9ef246acd34862588e525c0e9a5fe47f37955.camel@kernel.org>
Subject: Re: [PATCH] lockd: pin next file across nlm_inspect_file lock-drop
From: Jeff Layton <jlayton@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>, Trond Myklebust
	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
	 <chuck.lever@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Sat, 23 May 2026 07:05:37 -0400
In-Reply-To: <20260523014203.2462827-1-michael.bommarito@gmail.com>
References: <20260523014203.2462827-1-michael.bommarito@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21856-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: C92315BEA23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-22 at 21:42 -0400, Michael Bommarito wrote:
> nlm_traverse_files() walks each nlm_files[] hash bucket with
> hlist_for_each_entry_safe(file, next, ...). For each matching file
> it bumps f_count, drops nlm_file_mutex to run nlm_inspect_file()
> (which may sleep walking blocks, shares, and the inode lock list),
> then reacquires the mutex and decrements f_count before continuing
> to the saved next.
>=20
> The f_count bump pins the current file across the lock-drop, but
> nothing pins next. Any nlmsvc thread that holds the last reference
> on the file at next will, during that window, call
> nlm_release_file() -> nlm_delete_file() under nlm_file_mutex,
> hlist_del() it from the bucket, and kfree() it. When
> nlm_traverse_files() reacquires the mutex and the macro reads the
> next entry's f_list.next on the following iteration, the read lands
> in the freed slab.
>=20
> A naive restart-on-action variant would deadlock-spin against an
> nlm_release_file holder: nlm_inspect_file() does not always drain
> the file (it can return 1 with an RPC still holding f_count above
> the cleanup threshold), and the outer predicate is_failover_file()
> matches static attributes of the file, so a restart can keep
> re-finding the same un-cleanable file until the external RPC ref
> drops.
>=20
> Pin the neighbour explicitly instead. Walk the bucket with two
> locally-pinned cursors at a time: file (current, pinned by the
> prior iteration's next bump) and next (one ahead). Drop file's pin
> at the end of each iteration, then advance to next, which is still
> alive because we hold its f_count above zero across the unlock.
> This bounds the walk at O(N) per bucket and never observes a freed
> neighbour. Factor the f_count/list/share/lock cleanup into a
> helper so the no-match path also drops a stale empty file rather
> than leaving it in the table.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 01df9c5e918a ("LOCKD: Fix a deadlock in nlm_traverse_files()")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/lockd/svcsubs.c | 61 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 19 deletions(-)
>=20
> Reproduced under UML + KASAN with a loopback NFSv3 mount, 768
> concurrent POSIX fcntl(F_SETLKW) holders, and parallel writes to
> /proc/fs/nfsd/unlock_filesystem forcing nlmsvc_unlock_all_by_sb()
> to walk the table while clients churn locks.
>=20
> Stock kernel:
>=20
>   BUG: KASAN: slab-use-after-free in nlm_traverse_files+0x71d/0x9d0
>   Read of size 8 at addr 0000000070314800 by task nlm-init-...
>=20
>   Allocated by: nlm_lookup_file via nlm4svc_proc_lock
>   Freed by:     another nlm_traverse_files instance freeing a
>                 file whose f_count dropped to zero during the
>                 nlm_inspect_file() unlock window
>=20
> Patched UML kernel ran the same harness silently.
>=20
> Pin-next was chosen over restart-on-action because the latter can
> livelock when nlm_inspect_file() returns 1 with an RPC reference
> still holding the file above the cleanup threshold and the outer
> is_failover_file() predicate matching static attributes.
>=20
>=20
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index dd0214dcb6950..2bfa32207f10c 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -295,36 +295,59 @@ static void nlm_close_files(struct nlm_file *file)
>  /*
>   * Loop over all files in the file table.
>   */
> +static void nlm_file_release(struct nlm_file *file)
> +{
> +	if (list_empty(&file->f_blocks) && !file->f_locks
> +	    && !file->f_shares && !file->f_count) {
> +		hlist_del(&file->f_list);
> +		nlm_close_files(file);
> +		kfree(file);
> +	}
> +}
> +
>  static int
>  nlm_traverse_files(void *data, nlm_host_match_fn_t match,
>  		int (*is_failover_file)(void *data, struct nlm_file *file))
>  {
> -	struct hlist_node *next;
> -	struct nlm_file	*file;
> +	struct nlm_file *file, *next;
>  	int i, ret =3D 0;
> =20
>  	mutex_lock(&nlm_file_mutex);
>  	for (i =3D 0; i < FILE_NRHASH; i++) {
> -		hlist_for_each_entry_safe(file, next, &nlm_files[i], f_list) {
> -			if (is_failover_file && !is_failover_file(data, file))
> -				continue;
> +		file =3D hlist_entry_safe(nlm_files[i].first,
> +					struct nlm_file, f_list);
> +		if (file)
>  			file->f_count++;
> -			mutex_unlock(&nlm_file_mutex);
> -
> -			/* Traverse locks, blocks and shares of this file
> -			 * and update file->f_locks count */
> -			if (nlm_inspect_file(data, file, match))
> -				ret =3D 1;
> +		while (file) {
> +			/*
> +			 * Pin the next neighbour before we drop the mutex
> +			 * for nlm_inspect_file(); a concurrent
> +			 * nlm_release_file() under the same mutex would
> +			 * otherwise be free to unlink and kfree it during
> +			 * the unlock window, leaving us to dereference a
> +			 * freed slab when we walked to next afterwards.
> +			 */
> +			next =3D hlist_entry_safe(file->f_list.next,
> +						struct nlm_file, f_list);
> +			if (next)
> +				next->f_count++;
> +
> +			if (!is_failover_file || is_failover_file(data, file)) {
> +				mutex_unlock(&nlm_file_mutex);
> +
> +				/*
> +				 * Traverse locks, blocks and shares of this
> +				 * file and update file->f_locks count.
> +				 */
> +				if (nlm_inspect_file(data, file, match))
> +					ret =3D 1;
> +
> +				mutex_lock(&nlm_file_mutex);
> +			}
> =20
> -			mutex_lock(&nlm_file_mutex);
>  			file->f_count--;
> -			/* No more references to this file. Let go of it. */
> -			if (list_empty(&file->f_blocks) && !file->f_locks
> -			 && !file->f_shares && !file->f_count) {
> -				hlist_del(&file->f_list);
> -				nlm_close_files(file);
> -				kfree(file);
> -			}
> +			nlm_file_release(file);
> +			file =3D next;
>  		}
>  	}
>  	mutex_unlock(&nlm_file_mutex);

Sashiko seems to think there is a regression here. See:

https://sashiko.dev/#/patchset/20260523014203.2462827-1-michael.bommarito@g=
mail.com?part=3D1
--=20
Jeff Layton <jlayton@kernel.org>


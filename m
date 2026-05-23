Return-Path: <linux-nfs+bounces-21866-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKZDHszJEWqEpwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21866-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:37:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2105BFB0E
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57EA43005598
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BDD2F12AB;
	Sat, 23 May 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADnozeJ0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D2223DCE
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550666; cv=none; b=G/u2I6/fNYVewOAjBgqD6XiGDHiXbmUAIUNwd7qYoDY61lGELUdrEeiJV1VWgAuHhzafv+CFkvxhhmFLe8WiCdfQlzMn+23SXeM4CLg3MRAnGb0fXWDQthC/QAU144dkucHGlrZDjLifpLRUa7UOpXLd8QNoLcXH5mH1PsZAl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550666; c=relaxed/simple;
	bh=nuMhY67j2kXpkCL6F1g8rN7Lw63fswI+AVXZSRraKXw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p7MLdsrVwtJTFk6QiPJZy3jWLaQmz5gj+FzjzypGbZ3IqMB/my6zNQy4qU2aydqUumZ4Bt9y8t9GXINtLo4TicsXJ4D+gGt0LU6jp9RTnhRtDDyyLhWdrI0G3Qv2CaMECpbaiirErX2hpeGwFoQfIMZKxxZpuXhH5Q6cZV+IQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADnozeJ0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECCD1F00A3C;
	Sat, 23 May 2026 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779550664;
	bh=b59jaKuT2GEGtCUAJvouyB/kv9iV89Owv4NA+3ki6tI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ADnozeJ0cpvfkZuUx3kYhoPovs41zzcBK1mPuxV+AWPvvxWssmMQyrdI5oNPcSbrC
	 fBPdnxtHQjis0oi8RnwI3kCCJGmehjNzsgyDTGVOwyzZ2zNXBKyVoJ4XlOb+xz6dr4
	 yRwndDP69d25jBm9VXqPqqBjp9Q5LtFk/N/HJo9BBmYSbdOT/d85NQESYMtCDQ11RS
	 8f5oQljuZPXjoTToPnkLz3l2w5vA0Eru2UQvysaiYn6Ltw+FowP3re9PSLyQG/g5kO
	 PFxbqp6h6k23kQpy/YaCvL4PDCn1X9nxxTlg3NsdqMocTqOpaaZceUz0MwXOVB5vEb
	 vT1HWziXX+7bw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8B8CCF40068;
	Sat, 23 May 2026 11:37:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 23 May 2026 11:37:43 -0400
X-ME-Sender: <xms:x8kRau0weq4OmJ1dz0OL_XvZ7DWKFIxWvBXNkan83Sr4XltOh_2TDQ>
    <xme:x8kRar6WBo73PSGa3ZaDOvbKJcUw1M2gc_u_uvT0DiGgEPmY_0PTUGrQILCKdfsHY
    xFpiROOfdjNcjSoMTXZ7QOjWF7cIhV2Elz4c8Mn7JQ4CJcWN46d18g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpedtleejheethfelgefhjefgteeiteehudfgieevffegkeejkeevvdelieegvdeujeen
    ucffohhmrghinhepshgrshhhihhkohdruggvvhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvg
    hlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthht
    ohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghilhessghrohifnh
    drnhgrmhgvpdhrtghpthhtohepmhhitghhrggvlhdrsghomhhmrghrihhtohesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhies
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghp
    thhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmse
    htrghlphgvhidrtghomh
X-ME-Proxy: <xmx:x8kRamyssrTWUF2EfeABmNiMiYB2RhKjPZRSwBuk0xsWpBaohtHehg>
    <xmx:x8kRaorw9mTvljt4paLlplObD2sDda5a4QJE63ojoSGd9Sc3kXbPdQ>
    <xmx:x8kRakmIaMFtZty_LZ2vv4Z4y1bbafnMDT6dOQ-_3hTap374XbZ7DA>
    <xmx:x8kRaqU8rZrbvxaP78Ys8zKxDjs4Tr5IKWIN4bmeKJ-0CR8Y3YPiNQ>
    <xmx:x8kRagobRRdNemRCljJ4W_7rB9rD79-NkGarJOfbkiWIUXZymefipBcF>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6251C780070; Sat, 23 May 2026 11:37:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtPzEyN-PPL-
Date: Sat, 23 May 2026 11:37:22 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Michael Bommarito" <michael.bommarito@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <b30903a7-6edc-457b-8099-5242f26d9e42@app.fastmail.com>
In-Reply-To: <20260523123053.3480369-1-michael.bommarito@gmail.com>
References: <20260523123053.3480369-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH v2] lockd: pin next file across nlm_inspect_file lock-drop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21866-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1A2105BFB0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, May 23, 2026, at 8:30 AM, Michael Bommarito wrote:
> nlm_traverse_files() pins the current file with f_count++ across
> a mutex_unlock for nlm_inspect_file(), but nothing pins the saved
> next pointer.  A concurrent nlm_release_file() can kfree the next
> file during the unlock window, and the iterator dereferences freed
> memory on the next loop step.
>
> Pin both current and next before the lock-drop.  Advance by
> swapping the pinned cursors at the end of each iteration so next
> is always held alive across the unlock.
>
> Only call nlm_file_release() for files that matched the predicate
> and were inspected.  Skipped files just get f_count-- to undo the
> iteration pin; their f_locks is stale and must not drive cleanup.
>
> Cc: stable@vger.kernel.org
> Fixes: 01df9c5e918a ("LOCKD: Fix a deadlock in nlm_traverse_files()")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/lockd/svcsubs.c | 64 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 20 deletions(-)
>
>
> Changes since v1:
>  - Fixed premature kfree of non-matching files: nlm_file_release()
>    is now called only for files that matched the predicate and were
>    inspected.  Non-matching files just get f_count-- to undo the
>    iteration pin.  (Spotted by sashiko.dev automated review.)
>
> Reproduced under UML + KASAN with 768 concurrent POSIX holders and
> parallel /proc/fs/nfsd/unlock_filesystem writes.
>
> Stock kernel:
>
>   BUG: KASAN: slab-use-after-free in nlm_traverse_files+0x71d/0x9d0
>
>   Allocated by: nlm_lookup_file via nlm4svc_proc_lock
>   Freed by:     another nlm_traverse_files instance
>
> Patched v2 UML kernel ran the same harness silently.
>
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index dd0214dcb6950..0b38125cf86ab 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -295,36 +295,60 @@ static void nlm_close_files(struct nlm_file *file)
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
>  	int i, ret = 0;
> 
>  	mutex_lock(&nlm_file_mutex);
>  	for (i = 0; i < FILE_NRHASH; i++) {
> -		hlist_for_each_entry_safe(file, next, &nlm_files[i], f_list) {
> -			if (is_failover_file && !is_failover_file(data, file))
> -				continue;
> +		file = hlist_entry_safe(nlm_files[i].first,
> +					struct nlm_file, f_list);
> +		if (file)
>  			file->f_count++;
> -			mutex_unlock(&nlm_file_mutex);
> -
> -			/* Traverse locks, blocks and shares of this file
> -			 * and update file->f_locks count */
> -			if (nlm_inspect_file(data, file, match))
> -				ret = 1;
> -
> -			mutex_lock(&nlm_file_mutex);
> -			file->f_count--;
> -			/* No more references to this file. Let go of it. */
> -			if (list_empty(&file->f_blocks) && !file->f_locks
> -			 && !file->f_shares && !file->f_count) {
> -				hlist_del(&file->f_list);
> -				nlm_close_files(file);
> -				kfree(file);
> +		while (file) {
> +			/*
> +			 * Pin the next neighbour before we drop the mutex
> +			 * for nlm_inspect_file(); a concurrent
> +			 * nlm_release_file() under the same mutex would
> +			 * otherwise be free to unlink and kfree it during
> +			 * the unlock window, leaving us to dereference a
> +			 * freed slab when we walked to next afterwards.
> +			 */
> +			next = hlist_entry_safe(file->f_list.next,
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
> +					ret = 1;
> +
> +				mutex_lock(&nlm_file_mutex);
> +				file->f_count--;
> +				nlm_file_release(file);
> +			} else {
> +				file->f_count--;
>  			}
> +			file = next;
>  		}
>  	}
>  	mutex_unlock(&nlm_file_mutex);
> -- 
> 2.53.0

Codex (gpt-5.5 xhigh) review reports:

> When nlmsvc_unlock_all_by_sb() skips a file from another superblock,
> this branch can be handling an entry that was already pinned as the
> previous file's saved next. If that entry's last real nlm_release_file()
> ran while the traversal pin was held, it saw f_count > 0 and skipped
> nlm_file_inuse()/deletion; this decrement then takes f_count to zero
> without any cleanup, leaving the nlm_file and its open f_file
> references hashed indefinitely.

It appears that sashiko identified the same issue:

https://sashiko.dev/#/patchset/20260523123053.3480369-1-michael.bommarito@gmail.com?part=1


-- 
Chuck Lever


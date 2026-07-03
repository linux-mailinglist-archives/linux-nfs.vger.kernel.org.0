Return-Path: <linux-nfs+bounces-22981-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jk65DfkiSGrlmgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22981-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 23:00:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE6705AA9
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 23:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbaby.net header.s=bambino header.b=eYtum7Wo;
	dkim=fail ("headers rsa verify failed") header.d=agatha.dev header.s=default header.b=tBEcSi6K;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=agatha.dev (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22981-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22981-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E83FC301F489
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 21:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E81F94F;
	Fri,  3 Jul 2026 21:00:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from relay0-c.mailbaby.net (relay0-c.mailbaby.net [199.231.189.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF257136351
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 21:00:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112437; cv=none; b=MTvha692E/x024Ealn0JkqOcwJheICRG/+5y2Mk2WNdhMsAMsRNuecGyQwDZFCnnG+3w8UiMg32FXu1KfgbwtQkheS6Iaww4ioKSUOrnZjyeRZQHig4N+d6dmQoyJnx3hYpE4UjpycVQGThkoUhMAVdjnJ392N0QWOQwnpEQoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112437; c=relaxed/simple;
	bh=Wo9eoldFjSmHdMl34TTSExXO0oK1YnKR5ukz4TBlTKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF0XktrxYuR2PnqYe7Ujv277z74yQ4ict29MJaI+st+5PKSrUGiEMYrmTaPPIL6u9h1nUeuUTrAR+RTddZSc5N1uB8lpv1Ji9cyZAtVRT9KVtNG6Mi4lAyA6biKIh9sv78JiiwjVxJNppVdqsZ3Vd8SEjYUpb46a8KrYGTbm2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agatha.dev; spf=pass smtp.mailfrom=agatha.dev; dkim=pass (1024-bit key) header.d=mailbaby.net header.i=@mailbaby.net header.b=eYtum7Wo; dkim=pass (2048-bit key) header.d=agatha.dev header.i=@agatha.dev header.b=tBEcSi6K; arc=none smtp.client-ip=199.231.189.156
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=G3g7VFTFc4zYTYcTX3LWfOVJJ55vnW5uexiPp0WEUUc=;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references:feedback-id;
 b=eYtum7Wo5A3aer9mGmVTxlOpIufctCXQLUalovTMK0MtpKuamY6jeXafq43YK+liqv8WCD1nm
 s/Tp+x9LUeaQI+LC3MNHaXnKWALlYXUImcufou9PiQBCvBVO7FNxdHH9T2b5apXCXMYX+VIBJhK
 aCfm0DmkgiJ/6sySNxapzPw=
Received: from mb-nj-kvm1.internal (mb-nj-kvm1.internal [10.10.2.10])
  (Authenticated sender: mb6724)
 by relay0-c.mailbaby.net (MailBabyMTA) with ESMTPSA id 19f29c3964d000116c.001
 for <linux-nfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 03 Jul 2026 20:55:11 +0000
X-Zone-Loop: 225f9075e476ad72a7379b6112416df915b48b14fbf6
X-MB-ID: mb6724|me@agatha.dev
X-SPF: pass
Feedback-ID: mb6724:19f29c:507c5a5c5e5d585f7d5a5951:mbaby
X-MAILBABY-ORIGIN: PASS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=agatha.dev;
	s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=G3g7VFTFc4zYTYcTX3LWfOVJJ55vnW5uexiPp0WEUUc=; b=tBEcSi6KPX6CbWAwCf/KquSRiw
	s9sx5wzlJz6UfkdyncSYne7SA61SNhpH8mky+JWLoytIKcmG5PxybdB9VCqd4IdwQOngdhf8VIqKu
	3OOWhKN9XAeitrWYSQu2j11VI7oiG8xW+/deyOLGN+0MyFG9kA2tkBjtCK+qRHldv7EgbCBlnFnwZ
	azGGn81gNXKeW9SfEgAZFW4/xNpzIxDlB9v3H0maabXNS0cew9xp1q9EUHCSqSNhGYsodXn37Qva/
	CmW7QABuHYOnspQj+kApyHkBdf97G/rA5k6PtftNBfOZ/cLYBwY0HK82iV0D3hkjLKp2LLh0veCJB
	KUTSczKw==;
Received: from [170.254.153.137] (port=17061 helo=guidai)
	by nyc3000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <code@agatha.dev>)
	id 1wfkul-00000002b1i-27AZ;
	Fri, 03 Jul 2026 16:55:11 -0400
Date: Fri, 3 Jul 2026 17:55:04 -0300
From: Agatha Isabelle Moreira <code@agatha.dev>
To: Arnaud Bonnet <abo@medichon.fr>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com, 
	jkoolstra@xs4all.nl
Subject: Re: [PATCH 2/2] nfs: refactor pNFS functions using
 clear_and_wake_up_bit
Message-ID: <guidai72It.44047.2026203akgZf5M7751Q5ElH_20715_LINUXKERNEL_AGATHA_@links.agatha.dev>
References: <cover.1782148639.git.abo@medichon.fr>
 <929ff54c0c212b22620d10e6d8bef2a01bc6fa30.1782148639.git.abo@medichon.fr>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929ff54c0c212b22620d10e6d8bef2a01bc6fa30.1782148639.git.abo@medichon.fr>
X-AuthUser: me@agatha.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbaby.net:s=bambino];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[agatha.dev : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-22981-lists,linux-nfs=lfdr.de];
	R_DKIM_REJECT(0.00)[agatha.dev:s=default];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:abo@medichon.fr,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skhan@linuxfoundation.org,m:me@brighamcampbell.com,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[code@agatha.dev,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,brighamcampbell.com,xs4all.nl];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbaby.net:+,agatha.dev:-];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[code@agatha.dev,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailbaby.net:dkim,kernelnewbies.org:url,medichon.fr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78EE6705AA9

On Mon, Jun 22, 2026 at 07:55:11PM +0200, Arnaud Bonnet wrote:
> Commit 8236b0ae31c83 ("bdi: wake up concurrent wb_shutdown() callers.")
> introduces the clear_and_wake_up_bit() helper as a wrapper for the
> common clear -> barrier -> wake up bitops sequence.
> 
> The file pnfs.c has several helpers with identical contents. Thus they
> are replaced with the more recent clean_and_wake_up_bit() global helper
> which describes accurately its effects at the call and still specifies
> the cleared bit. This also homogenizes the code with other subsystems.
> 
> Since the helpers are no longer used after this, they can be safely
> removed.


Hi Arnaud!

> 
> Suggested-by: Agatha Isabelle Moreira <code@agatha.dev>
> Link: https://kernelnewbies.org/Beginner%20Cleanup%20and%20Refactor%20Tasks%20by%20Agatha%20Isabelle%20Moreira#task_007
> Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
> ---
>  fs/nfs/pnfs.c | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index 743467e9ba20..96ee18af1ebf 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -2100,15 +2100,6 @@ static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
>  	return test_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
>  }
>  
> -static void pnfs_clear_first_layoutget(struct pnfs_layout_hdr *lo)
> -{
> -	unsigned long *bitlock = &lo->plh_flags;
> -
> -	clear_bit_unlock(NFS_LAYOUT_FIRST_LAYOUTGET, bitlock);
> -	smp_mb__after_atomic();
> -	wake_up_bit(bitlock, NFS_LAYOUT_FIRST_LAYOUTGET);
> -}

I noticed that you found a subsystem function doing something quite
similar to what the `clear_and_wake_up_bit()` function.

From the cleanup point of view it seems good to me, but I think some
input from someone in the nfs subsystem would be highly appreciated to
confirm the correctness of this refactor.

IDK if you considered or if this makes total sense, but my only concern
here is that the maintainer *could* find the replaced function
`pnfs_clear_first_layoutget()` preferable to be kept, since it carries
some subsystem semantics (the `struct pnfs_layout_hdr *lo` argument and
the NFS_LAYOUT_FIRST_LAYOUTGET bit). But I could also be completely
wrong.

In the event that `NFS_LAYOUT_FIRST_LAYOUTGET` gets replaced by another
constant in the future (IDK if this is a plausible possibility), by
keeping the original function there would be only a single place to
touch.

Let's hope this message attracts more comments from someone with the
subsystem's expertise, which would be highly appreciated.

> -
>  static void _add_to_server_list(struct pnfs_layout_hdr *lo,
>  				struct nfs_server *server)
>  {
> @@ -2284,7 +2275,8 @@ pnfs_update_layout(struct inode *ino,
>  					iomode, lo, lseg,
>  					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
>  			nfs4_schedule_stateid_recovery(server, ctx->state);
> -			pnfs_clear_first_layoutget(lo);
> +			clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
> +				&lo->plh_flags);
>  			pnfs_put_layout_hdr(lo);
>  			goto lookup_again;
>  		}
> @@ -2353,7 +2345,8 @@ pnfs_update_layout(struct inode *ino,
>  			if (!exception.retry)
>  				goto out_put_layout_hdr;
>  			if (first)
> -				pnfs_clear_first_layoutget(lo);
> +				clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
> +					&lo->plh_flags);
>  			trace_pnfs_update_layout(ino, pos, count,
>  				iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY);
>  			pnfs_put_layout_hdr(lo);
> @@ -2365,7 +2358,7 @@ pnfs_update_layout(struct inode *ino,
>  
>  out_put_layout_hdr:
>  	if (first)
> -		pnfs_clear_first_layoutget(lo);
> +		clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
>  	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
>  				 PNFS_UPDATE_LAYOUT_EXIT);
>  	pnfs_put_layout_hdr(lo);
> @@ -2457,7 +2450,7 @@ static void _lgopen_prepare_attached(struct nfs4_opendata *data,
>  	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid, &rng,
>  					     nfs_io_gfp_mask());
>  	if (!lgp) {
> -		pnfs_clear_first_layoutget(lo);
> +		clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET, &lo->plh_flags);
>  		nfs_layoutget_end(lo);
>  		pnfs_put_layout_hdr(lo);
>  		return;
> @@ -2561,7 +2554,8 @@ void nfs4_lgopen_release(struct nfs4_layoutget *lgp)
>  {
>  	if (lgp != NULL) {
>  		if (lgp->lo) {
> -			pnfs_clear_first_layoutget(lgp->lo);
> +			clear_and_wake_up_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
> +				&lgp->lo->plh_flags);
>  			nfs_layoutget_end(lgp->lo);
>  		}
>  		pnfs_layoutget_free(lgp);
> @@ -3273,15 +3267,6 @@ pnfs_generic_pg_readpages(struct nfs_pageio_descriptor *desc)
>  }
>  EXPORT_SYMBOL_GPL(pnfs_generic_pg_readpages);
>  
> -static void pnfs_clear_layoutcommitting(struct inode *inode)
> -{
> -	unsigned long *bitlock = &NFS_I(inode)->flags;
> -
> -	clear_bit_unlock(NFS_INO_LAYOUTCOMMITTING, bitlock);
> -	smp_mb__after_atomic();
> -	wake_up_bit(bitlock, NFS_INO_LAYOUTCOMMITTING);
> -}
> -
>  /*
>   * There can be multiple RW segments.
>   */
> @@ -3306,7 +3291,7 @@ static void pnfs_list_write_lseg_done(struct inode *inode, struct list_head *lis
>  		pnfs_put_lseg(lseg);
>  	}
>  
> -	pnfs_clear_layoutcommitting(inode);
> +	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, &NFS_I(inode)->flags);
>  }
>  
>  void pnfs_set_lo_fail(struct pnfs_layout_segment *lseg)
> @@ -3446,7 +3431,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
>  	spin_unlock(&inode->i_lock);
>  	kfree(data);
>  clear_layoutcommitting:
> -	pnfs_clear_layoutcommitting(inode);
> +	clear_and_wake_up_bit(NFS_INO_LAYOUTCOMMITTING, &NFS_I(inode)->flags);
>  	goto out;
>  }
>  EXPORT_SYMBOL_GPL(pnfs_layoutcommit_inode);
> -- 
> 2.53.0
> 

Other than that, both patches appear to successfuly apply and compile
just fine.

-- 
Agatha Isabelle Moreira
Systems Engineer | C


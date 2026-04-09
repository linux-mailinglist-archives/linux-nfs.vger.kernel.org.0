Return-Path: <linux-nfs+bounces-20785-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLP+Eq0Q12kSKwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20785-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 04:36:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3F3C5902
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 04:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4035300E2B1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 02:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF135B631;
	Thu,  9 Apr 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjHZ26V0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893B3148DA
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 02:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702184; cv=none; b=TDNWdVxnenPX9GObuFhFZgaqXJhgug7br/UAeB3T6JzG3JmJ1Shrl33XeAWcmF5X+KqEAWNkqgwuwjmYVc+Rh/lRXzRMrzFzuHaDomL6GZllj8cvjAqmNXAkwxfAq0ibgH8/cpxH4Ft4UWVQT0GQnCTndL1MR92jTXjI1doBB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702184; c=relaxed/simple;
	bh=mUgJ9gNC6/kJyF4YcWw2rC9fYFif+peaopsPceIy5Rs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=V34nZ50KlX5pgz0n77dU+LrwGuNWnmn7ojPZP7QCAX8YDcLsDEqThAf3dRQbsJ5nl7nvniqjzGh+hFN19pQCRRus2abFQpQwFfsul3U9Dgsc6rgKd3dbDXyggj9r8R5ihfxnwD+YcNQqq88EMAG5nAlLhr8NXdnt4NVgbyMneeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjHZ26V0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9f316d68so2055105ad.2
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2026 19:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775702182; x=1776306982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lw0Tv+5NbELb9GtHhwh2AbG2K6I+ORA+QMsewcCrAeQ=;
        b=LjHZ26V0Z9gwhWZ+npXQIXVU2vn95J6nMqUzeZXTEfJW3bb8ae2i5aKEXXagoADy/p
         21s7LChSsYZ7pDlELzCtWoXeDf36VzSv6rsFx2vbewCg2t0z4KRWvA9u2sjVwGlnAv2M
         t8RVdviR26ly/adBMUkJ3h0W4xpqgBH5OcUPvOSrgT0whCqgPZ1BnDvnTO3lqqaecD/Q
         bt3y2oxWPB7zI2d+R3S8OWD0gt+U1Bd/Ks0E0CRHdpIukwsEs6xzrEuNAFxCLnojRLQV
         N+Xbkd7oW7L8RKambGDq6gEZzIJ2L8sOjfxCXf5RRSk8edhkFvnRPAk7oukVhmes7uLk
         JPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775702182; x=1776306982;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lw0Tv+5NbELb9GtHhwh2AbG2K6I+ORA+QMsewcCrAeQ=;
        b=LFP8DNwl5xcEMr5amsIlLnezvkdWc/Vna+COvEccdr93rhyrzMk95qrWw7SvJoy3Ek
         tqk6dAnOcJagvtX/360jc+/Tu/7pIAIKad/QL5SIJLJ27HH9Qg9tbMM04cKkAT0kszsT
         Tjh9G/66dsWNrNG+AGi1p4ecV/sTOVeRZH4iSEsIJbtDFrL2jERx2diOhRuyd81qupjs
         aZDI4Aq9342TPyRmMLwwiauv2ECpQO/BI/vzB1llLj3Yhguqez1tl4+cZEt+f88bb9k/
         CR2xFuhGL8D+WH6n391eQ1GNozXTON17uYXffvhhVhXmAdDmWe4ptMl048riww/3YlNI
         4dqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWimWQoaPN+hoo9ohxL5660vP7RcBrmAkQCA4MtiXdcpQlbRoFwpA8TpYp2ayaauSK1sF761GHAjNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWT9drxaMX9+9QbfwEWBu1EETsX4kWeuhiwyedNvindI1vGHro
	S0PL76Z2Wo/szEjPWR7y1px1SLCWCYD+HIs8cO4OU/OtoBvoLPA1nJwo
X-Gm-Gg: AeBDievjPefpWqcj8PfG7EiR02lQMumtFaiKryeGEwP9iVPn1Ani7FT5pehjBcUbeMY
	Iucc/JcaaTSYoBVNlCp5B77wVf2Vxt7ogoWSeIJlEGIJvr7gtQpyI161eWfJZrkki5jVI4xU8b2
	XzMFCI2QHXe+FWhFNBxeJfXQGmLgLN0YVAjuNR6SbUb7sgFxrpp2u8GJUH3oCMNq1LDAD8p3r1B
	1g6fej4J4TGzptll5GZDw10MZ5I1cIlC1FxwdNkBZWGdV2FYk9G58juYlO3k4CRxuvUILCtNOHV
	XPyICFOL0izonq2FAYDIbQ0CttdhEMmrv5idaYhTfSSmRKj5dMGnFrBR2uy2Nk1WqoiAtvxeshG
	Y3kytCuWOoGp5wsNPCiIN3K98NQG2MDAN6IFgHwYKCAdIgsyNVPr2fJNQQYSm8Uk2wMXrFqxAKN
	AGUEu+W3eDnOpzu9ZWNhng//4JHlHmV926
X-Received: by 2002:a17:903:238b:b0:2ad:d0ff:2ed4 with SMTP id d9443c01a7336-2b28164c3d7mr267295685ad.6.1775702182377;
        Wed, 08 Apr 2026 19:36:22 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ce29esm233858135ad.81.2026.04.08.19.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 19:36:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 1/3] mm: kick writeback flusher instead of inline flush for IOCB_DONTCACHE
In-Reply-To: <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
Date: Thu, 09 Apr 2026 07:10:32 +0530
Message-ID: <tstklxm7.ritesh.list@gmail.com>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org> <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20785-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0D3F3C5902
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jeff Layton <jlayton@kernel.org> writes:

> The IOCB_DONTCACHE writeback path in generic_write_sync() calls
> filemap_flush_range() on every write, submitting writeback inline in
> the writer's context.  Perf lock contention profiling shows the
> performance problem is not lock contention but the writeback submission
> work itself — walking the page tree and submitting I/O blocks the
> writer for milliseconds, inflating p99.9 latency from 23ms (buffered)
> to 93ms (dontcache).
>
> Replace the inline filemap_flush_range() call with a
> wakeup_flusher_threads_bdi() call that kicks the BDI's flusher thread
> to drain dirty pages in the background.  This moves writeback
> submission completely off the writer's hot path.  The flusher thread
> handles writeback asynchronously, naturally coalescing and rate-limiting
> I/O without any explicit skip-if-busy or dirty pressure checks.
>

Thanks Jeff for explaining this. It make sense now.


> Add WB_REASON_DONTCACHE as a new writeback reason for tracing
> visibility.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fs-writeback.c                | 14 ++++++++++++++
>  include/linux/backing-dev-defs.h |  1 +
>  include/linux/fs.h               |  6 ++----
>  include/trace/events/writeback.h |  3 ++-
>  4 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 3c75ee025bda..88dc31388a31 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2466,6 +2466,20 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>  	rcu_read_unlock();
>  }
>  
> +/**
> + * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
> + * @mapping:	address_space that was just written to
> + *
> + * Wake the BDI flusher thread to start writeback of dirty pages in the
> + * background.
> + */
> +void filemap_dontcache_kick_writeback(struct address_space *mapping)

This api gives a wrong sense that we are kicking writeback to write
dirty pages which belongs to only this inode's address space mapping.
But instead we are starting wb for everything on the respective bdi.

So instead why not just export symbol for wakeup_flusher_threads_bdi()
and use it instead?

If not, then IMO at least making it... 
   filemap_kick_writeback_all(mapping, enum wb_reason)

... might be better.

> +{
> +	wakeup_flusher_threads_bdi(inode_to_bdi(mapping->host),
> +				   WB_REASON_DONTCACHE);
> +}
> +EXPORT_SYMBOL(filemap_dontcache_kick_writeback);
> +
>  /*
>   * Wakeup the flusher threads to start writeback of all currently dirty pages
>   */
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index c88fd4d37d1f..4a81c90a8928 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -55,6 +55,7 @@ enum wb_reason {
>  	 */
>  	WB_REASON_FORKER_THREAD,
>  	WB_REASON_FOREIGN_FLUSH,
> +	WB_REASON_DONTCACHE,
>  
>  	WB_REASON_MAX,
>  };
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8b3dd145b25e..2fd36608ac73 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2610,6 +2610,7 @@ extern int __must_check file_write_and_wait_range(struct file *file,
>  						loff_t start, loff_t end);
>  int filemap_flush_range(struct address_space *mapping, loff_t start,
>  		loff_t end);
> +void filemap_dontcache_kick_writeback(struct address_space *mapping);
>  
>  static inline int file_write_and_wait(struct file *file)
>  {
> @@ -2643,10 +2644,7 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>  		if (ret)
>  			return ret;
>  	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
> -		struct address_space *mapping = iocb->ki_filp->f_mapping;
> -
> -		filemap_flush_range(mapping, iocb->ki_pos - count,
> -				iocb->ki_pos - 1);
> +		filemap_dontcache_kick_writeback(iocb->ki_filp->f_mapping);
>  	}
>  
>  	return count;
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 4d3d8c8f3a1b..9727af542699 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -44,7 +44,8 @@
>  	EM( WB_REASON_PERIODIC,			"periodic")		\
>  	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
>  	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
> -	EMe(WB_REASON_FOREIGN_FLUSH,		"foreign_flush")
> +	EM( WB_REASON_FOREIGN_FLUSH,		"foreign_flush")	\
> +	EMe(WB_REASON_DONTCACHE,		"dontcache")
>  
>  WB_WORK_REASON
>  
>
> -- 
> 2.53.0


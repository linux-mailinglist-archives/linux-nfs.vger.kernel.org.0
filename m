Return-Path: <linux-nfs+bounces-9042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9555BA083AC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2025 00:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CA4166D44
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 23:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33031A2C0B;
	Thu,  9 Jan 2025 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NbzRwjJI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0QGr0jjm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zJ9WllMw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ahQr6HYN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31718132A
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736466607; cv=none; b=cNDeaycoGCkwakGAUSNUgVxXscKIL385iez4Zw5mMSA4JxLFBvOtzdfdjKgvtrMlLXBYo/cjAz4pN9cYhE/I/zcUMadFRLvFV8nVh3vo5mOoTfG7f7p64Mx9+gizfhQ818GT05gxtfHLErDPjwBb+GxMqU21s3ERCQjSctJZz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736466607; c=relaxed/simple;
	bh=woimwLyeZYg5yDbbxlecfaRWeMdF5pPiFhA2dyD5S3o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gfmWIYi1yNEnHNjCVWjoyzRQ2L3vMD+tU0W+ibiSme1NVniJ/0TZI9o/yTeWsoDgJpjH+akgkJaeoQVwj0Rc2MXSoMHzUQW0D3vEKV2lx3ia+CBncMGy5DTMF5pAP9KCgJC5H5R0rjs1rCDfRKt/nZW7GCJMxF21U8gp/zmkkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NbzRwjJI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0QGr0jjm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zJ9WllMw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ahQr6HYN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 896582116D;
	Thu,  9 Jan 2025 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736466603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zpvzAOishLi9lLAMy23GTa63e97IbeiWA7XTQjmovg=;
	b=NbzRwjJI6bD3oQRhloLDluagEuuInMH0ows3+XPOH/4OnTHGfDT9Psv8fdIcK+ASdO5blt
	Tu1X7eL2ZcHHT3PoED7qY2JjzJOdcavYR9dmfOCk0INonjds6Qt0T9Oli3AfhiUliweGst
	2uZRY5T8vQbj9ldDhfugOkaRo67IhNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736466603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zpvzAOishLi9lLAMy23GTa63e97IbeiWA7XTQjmovg=;
	b=0QGr0jjmtx/TMBBN4e8Y51zI5iavQVi67Smkq3cLuPDapfTeOPKDC0br2k5oorcLFPTCWt
	jJqjgJSlMJ6J1mCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zJ9WllMw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ahQr6HYN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736466602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zpvzAOishLi9lLAMy23GTa63e97IbeiWA7XTQjmovg=;
	b=zJ9WllMwLGrUHYsFnLODdFZBqIYv7GLpgqY5DMrN6Ah8FnP1d4Y4E125xqPcnJBT7bE4rF
	6axt/sW5ms+LuHUltTIQ8ZYBetu89Phf+d3SXa7rvZx4I2Xx5d6r51zop1yAD3y0jM3RLZ
	TMOmB2yFCq/ZYhOxxZKka31JIB8TVP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736466602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zpvzAOishLi9lLAMy23GTa63e97IbeiWA7XTQjmovg=;
	b=ahQr6HYNT5umhPMgBPMm4YxD4aZs0saJ4fkYy1K84suQ5+yOY5MjfZgP6PQFzYvnHs4wRU
	nx5U8ESsSWF2jrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A69813876;
	Thu,  9 Jan 2025 23:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yNnTB6hggGdXfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 09 Jan 2025 23:50:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1] nfsd: drop the lock during filecache LRU scans
In-reply-to: <20250109142438.18689-2-cel@kernel.org>
References: <20250109142438.18689-1-cel@kernel.org>,
 <20250109142438.18689-2-cel@kernel.org>
Date: Fri, 10 Jan 2025 10:49:48 +1100
Message-id: <173646658816.22054.11289202472152079862@noble.neil.brown.name>
X-Rspamd-Queue-Id: 896582116D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Fri, 10 Jan 2025, cel@kernel.org wrote:
> From: NeilBrown <neilb@suse.de>
>=20
> Under a high NFSv3 load with lots of different file being accessed,
> the LRU list of garbage-collectable files can become quite long.
>=20
> Asking list_lru_scan() to scan the whole list can result in a long
> period during which a spinlock is held, blocking the addition and
> removal of LRU items.
>=20
> So ask list_lru_scan() to scan only a few entries at a time, and
> repeat until the scan is complete.
>=20
> Fixes: edead3a55804 ("NFSD: Fix the filecache LRU shrinker")
> Signed-off-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 14 ++++++++++----
>  fs/nfsd/filecache.h |  6 ++++++
>  2 files changed, 16 insertions(+), 4 deletions(-)
>=20
> Updated version of Neil's patch to break up filecache LRU scans.
> This can be backported to LTS kernels -- a Fixes tag has been
> proposed.
>=20
> Subsequent work can replace the list_lru mechanism. That would
> be more substantial and thus more challenging to backport.
>=20
> There are two concerns here:
>=20
>  - The number of items in the LRU can now change while this loop is
>    operating. We might need a "if (!ret) break;" or some other exit
>    condition to prevent an infinite loop.

Not infinite - it is still bounded by the original list size.
You would expect the list walk to see all the "REFERENCED" files first.
These return LRU_ROTATE so the return value (which is count of
"isolated") will not increase, but nr_to_skip will decrease.  So you
would expect the first few results to be zero until all the REFERENCED
bits are cleared and those are rotated to the end.  Aborting then would
not be good.

>=20
>  - The list_lru_walk() always starts at the tail of the LRU, rather
>    than picking up where it left off. So it might only visit the
>    same handful of items on the list repeatedly, reintroducing the
>    bug fixed by edead3a55804.

If you change the remaining LRU_SKIP to LRU_ROTATE then it will always
remove the first few entries, either freeing them or rotating them to
the head of the list.  So it won't repeat unless items have been
removed.  In that case things might be freed more quickly than we would
like.  Maybe it would help to only process 80% of the list size, as it
is better to leave a few for the next time around, rather than close too
early.

NeilBrown


>=20
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a1cdba42c4fa..fcd751cb7c76 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -541,13 +541,19 @@ nfsd_file_lru_cb(struct list_head *item, struct list_=
lru_one *lru,
>  static void
>  nfsd_file_gc(void)
>  {
> +	unsigned long remaining =3D list_lru_count(&nfsd_file_lru);
>  	LIST_HEAD(dispose);
>  	unsigned long ret;
> =20
> -	ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> -			    &dispose, list_lru_count(&nfsd_file_lru));
> -	trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> -	nfsd_file_dispose_list_delayed(&dispose);
> +	while (remaining > 0) {
> +		unsigned long num_to_scan =3D min(remaining, NFSD_FILE_GC_BATCH);
> +
> +		ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> +				    &dispose, num_to_scan);
> +		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> +		nfsd_file_dispose_list_delayed(&dispose);
> +		remaining -=3D num_to_scan;
> +	}
>  }
> =20
>  static void
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index d5db6b34ba30..463bd60b98b4 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -3,6 +3,12 @@
> =20
>  #include <linux/fsnotify_backend.h>
> =20
> +/*
> + * Limit the time that the list_lru_one lock is held during
> + * an LRU scan.
> + */
> +#define NFSD_FILE_GC_BATCH	(32UL)
> +
>  /*
>   * This is the fsnotify_mark container that nfsd attaches to the files tha=
t it
>   * is holding open. Note that we have a separate refcount here aside from =
the
> --=20
> 2.47.0
>=20
>=20
>=20



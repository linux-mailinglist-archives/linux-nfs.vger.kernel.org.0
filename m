Return-Path: <linux-nfs+bounces-21928-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNR2Il93FGokNgcAu9opvQ
	(envelope-from <linux-nfs+bounces-21928-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:22:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD31E5CCC9F
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E8B3014118
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75673ECBFE;
	Mon, 25 May 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hk83kw2e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kr7oZb07";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hk83kw2e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kr7oZb07"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7F385D76
	for <linux-nfs@vger.kernel.org>; Mon, 25 May 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726153; cv=none; b=O551BodBDUkBtumPcJQkquwZihBMM36r/lEC16ADXNVV/qEPo80ntm75QaS3cnRU5WM3gYEnOsXnj6mEh9XkY46eU/A+XA25IkjVyz7kYXcUUvDGRIRxeeiTmXxiEhC8S8wqf1JciiafIptIheVsADShv/CLU99GiQDutfKx0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726153; c=relaxed/simple;
	bh=P2OgtNeh0Oj3YjnqfEjVOvYpTZ2t+RWx46Aydvo2nq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDIc1svPMmCPdKZcGNgmdQ1UhcPCDE/CMtIFvAvptABTgqfUv/iJ7ac/rszj0ZkP4XqL1CNR5M5AUa+tc3oE+IyN7qEbYIda+G/yNHggflF8ARFstUMDbgaHa/T2O3u65UHyUk5PwQSxbs28iyITBllYMmhdE4UhH/AOGp3LA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hk83kw2e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kr7oZb07; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hk83kw2e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kr7oZb07; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5B0B759A9;
	Mon, 25 May 2026 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779726149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yg5/0e5Hd71L3mzyiZoWVcp0/KiS6m5Nnzvnp69+OA=;
	b=Hk83kw2eQLXQmB/fIyNkVHEC6jmAc6A2TziZ0xAxKNcYZIt6RajeKE0epZDIbUbsdwKFHG
	eDJO7fxaoMgkPgJcBVTAN0sBMESBwhqScCcBtspmbLfyFAQL3AnDgzut2Rtyns6wklqJAK
	4ZQw/wdQ8GKiMoin+WYDu8BDtemOA3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779726149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yg5/0e5Hd71L3mzyiZoWVcp0/KiS6m5Nnzvnp69+OA=;
	b=Kr7oZb07JJQUrH+Yt9lfHmhb6X8E/wL9gjZLLAuvszjj9n0ZcvEy6Y4M/1i6qEqq28bYmR
	E/0ObMr1XkOX+TDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Hk83kw2e;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Kr7oZb07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779726149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yg5/0e5Hd71L3mzyiZoWVcp0/KiS6m5Nnzvnp69+OA=;
	b=Hk83kw2eQLXQmB/fIyNkVHEC6jmAc6A2TziZ0xAxKNcYZIt6RajeKE0epZDIbUbsdwKFHG
	eDJO7fxaoMgkPgJcBVTAN0sBMESBwhqScCcBtspmbLfyFAQL3AnDgzut2Rtyns6wklqJAK
	4ZQw/wdQ8GKiMoin+WYDu8BDtemOA3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779726149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5yg5/0e5Hd71L3mzyiZoWVcp0/KiS6m5Nnzvnp69+OA=;
	b=Kr7oZb07JJQUrH+Yt9lfHmhb6X8E/wL9gjZLLAuvszjj9n0ZcvEy6Y4M/1i6qEqq28bYmR
	E/0ObMr1XkOX+TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9E9259D29;
	Mon, 25 May 2026 16:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eft4KUV3FGrEIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 16:22:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AB0BEA08D7; Mon, 25 May 2026 18:22:13 +0200 (CEST)
Date: Mon, 25 May 2026 18:22:13 +0200
From: Jan Kara <jack@suse.cz>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Miklos Szeredi <miklos@szeredi.hu>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/17] fs/namespace: use __getname() to allocate mntpath
 buffer
Message-ID: <lwnrjpmzbv6swapmnmb5jki3xxxzqsxuks5vykniwhakvhqh7i@rhff3qrwfnoj>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-14-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-b4-fs-v1-14-275e36a83f0e@kernel.org>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21928-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org,vger.kernel.org,lists.linux.dev,lists.sourceforge.net,kvack.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DD31E5CCC9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat 23-05-26 20:54:26, Mike Rapoport (Microsoft) wrote:
> mnt_warn_timestamp_expiry() allocates memory for a path with
> __get_free_page() although there is a dedicated helper for allocation of
> file paths: __getname().
> 
> Replace __get_free_page() for allocation of a path buffer with __getname().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  fs/namespace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..2ed9cd846a81 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3303,7 +3303,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
>  	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
>  		char *buf, *mntpath;
>  
> -		buf = (char *)__get_free_page(GFP_KERNEL);
> +		buf = __getname();

Fair but d_path() below should then get PATH_MAX and not PAGE_SIZE.

>  		if (buf)
>  			mntpath = d_path(mountpoint, buf, PAGE_SIZE);
>  		else
> @@ -3319,7 +3319,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
>  
>  		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
>  		if (buf)
> -			free_page((unsigned long)buf);
> +			__putname(buf);

And __putname() is fine with NULL so no need for the if (buf) check here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


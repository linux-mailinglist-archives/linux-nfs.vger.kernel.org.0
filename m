Return-Path: <linux-nfs+bounces-4137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C291024D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 13:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EE51C20F23
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6A41AB34A;
	Thu, 20 Jun 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nyCGimhF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGQOel6s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nyCGimhF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qGQOel6s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD991AB537
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882033; cv=none; b=EoDVoWe3thYlpFjYY6YKb50ednFWOBCctDJx9CC/wJ3+u55m8I8RaqCOyayBXTVUV3h7eI5DpRpPdyh66ZrnpQ64ECKedctvgifMFH5Z2sRMMmyuMl3l/d58zR+7Pw/Nrq+Gjlk00fsUo9OezkflUS2Vyzf2BAYbZF3VbDYKff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882033; c=relaxed/simple;
	bh=wntIK7riNLOD/2GR3TW4X3Z3WN9qXQp51mipRLiT8qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYszUs4QwcE7aSb57ke7kxVG3AuYsy0FjXFKEx982cQoiocA/8GM2FNa4DOmbzsBldjsyjm43OlzXO/0WEuoss8GsmJV/OCiXHUsxnZOge31j6jePzie7/CD8Q521W/J5cNHYs+Kj2naV99RxLED6chTd1gfQNqir5FUd9UpPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nyCGimhF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGQOel6s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nyCGimhF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qGQOel6s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 762F421A95;
	Thu, 20 Jun 2024 11:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718882029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4cBjrK4rPU2JOmVseM04sDp1eBhsGmI44YkYOclEd8E=;
	b=nyCGimhFNR5HhapCpEkChILtbreCHWFiJf1e2i++Ru0C1TY4qj8uIHC1UAqfejjP5laR18
	NWEP4tI7svjOE0i5NSwLpzpjKMs7HWBiltfXfdoNt6tUMB2fr5a5GpauA4L8/aWrUe6ACd
	k4Hzqv3k15sxXm5RsOjrVg6nl+v+Mso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718882029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4cBjrK4rPU2JOmVseM04sDp1eBhsGmI44YkYOclEd8E=;
	b=qGQOel6sd7y0Hekekhhx4S7AcpT5fFxki/r8++6s0Rt/JNXJlOHK2T1OEVjjeg4CTWwAxb
	A6f8EMDoGcKQ1eDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nyCGimhF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qGQOel6s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718882029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4cBjrK4rPU2JOmVseM04sDp1eBhsGmI44YkYOclEd8E=;
	b=nyCGimhFNR5HhapCpEkChILtbreCHWFiJf1e2i++Ru0C1TY4qj8uIHC1UAqfejjP5laR18
	NWEP4tI7svjOE0i5NSwLpzpjKMs7HWBiltfXfdoNt6tUMB2fr5a5GpauA4L8/aWrUe6ACd
	k4Hzqv3k15sxXm5RsOjrVg6nl+v+Mso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718882029;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4cBjrK4rPU2JOmVseM04sDp1eBhsGmI44YkYOclEd8E=;
	b=qGQOel6sd7y0Hekekhhx4S7AcpT5fFxki/r8++6s0Rt/JNXJlOHK2T1OEVjjeg4CTWwAxb
	A6f8EMDoGcKQ1eDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 410DF1369F;
	Thu, 20 Jun 2024 11:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iiwyDu0OdGYjHAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 11:13:49 +0000
Date: Thu, 20 Jun 2024 13:13:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Josef Bacik <josef@toxicpanda.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Avinesh Kumar <akumar@suse.de>, NeilBrown <neilb@suse.de>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Message-ID: <20240620111347.GA594613@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240620111129.594449-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620111129.594449-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 762F421A95
X-Spam-Flag: NO
X-Spam-Score: -3.71
X-Spam-Level: 

Hi all,

> 6.9 moved client RPC calls to namespace (likely 1548036ef1204 ("nfs:
> make the rpc_stat per net namespace") [1]), thus update test.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1548036ef1204df65ca5a16e8b199c858cb80075

Actually d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d47151b79e3220e72ae323b8b8e9d6da20dc884e
but the previous one is obviously related.

Kind regards,
Petr


> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfsstat01/nfsstat01.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> index c2856eff1..a12b80fad 100755
> --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> @@ -15,7 +15,12 @@ get_calls()
>  	local calls opt

>  	[ "$name" = "rpc" ] && opt="r" || opt="n"
> -	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> +
> +	if tst_net_use_netns; then
> +		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"
> +	else
> +		[ "$nfs_f" != "nfs" ] && type="rhost"
> +	fi

>  	if [ "$type" = "lhost" ]; then
>  		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"


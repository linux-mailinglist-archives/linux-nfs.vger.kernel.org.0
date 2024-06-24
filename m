Return-Path: <linux-nfs+bounces-4248-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A79140C2
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 05:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5031E281598
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 03:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5E525E;
	Mon, 24 Jun 2024 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MCxluoEi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MW80LOAS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HYjSw+8O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P3R3uk6X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98547FC08;
	Mon, 24 Jun 2024 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198462; cv=none; b=ZDXPc6b0DFePb/q06IWOvNkkSRG8llpeDEEWSLYjhdzo6W4oW8jOxcOJH5xIpIeN8RYrrd7PBG2ra4qQEFnLoIC+5SMCNzGTYUn7PQzTZJiRtYcJqgUINAu9cGbyz1jfKaEXeqBjWtsHNiN/rNGz/cy0/qWQnNdWQh6UoE+PafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198462; c=relaxed/simple;
	bh=iDeTlKAMZTGI/rcvTWmvET1oitZnGzPi11/Cywy/X7E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Bbosd9/+9OKLU5TjS6vj8k/S60GG8U53HxOZY4YOQ+clGIUlCyrjGbGNWlMSeyrDvjkDgB/EHDfSLSx/ig8TX6KmzOt7bgtcuTe/hoM0MJD5szqCKyECBMfXGa5jFYu2kj0Jbc+xCl0YRPkNhSsx1GnOZ/WuFygKApBhpWT6kAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MCxluoEi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MW80LOAS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HYjSw+8O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P3R3uk6X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1E10219E1;
	Mon, 24 Jun 2024 03:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719198453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zhy82VCQc8NYnvf05ol+V2ksrLtovCjP3VgqR99bqBo=;
	b=MCxluoEiDo3kRMcLY5wd0J+vjZBK9gL6AlCSKth6rLrNzydRNylmop/nq6VZHGGVHT+Ed5
	2eRBGlasPPPXCt6TW/8Wtj7juEkzAH9ZP+4edWGqYYF7GQABkTc9eiczCDuU63KzQ9SWkQ
	f+A4BTgOzLg82/8gvTlCVh6hF0WUfCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719198453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zhy82VCQc8NYnvf05ol+V2ksrLtovCjP3VgqR99bqBo=;
	b=MW80LOASf/G8s/D9ifiBmsuTjC3QLa8pCAIhSE6Zs714oZ55eh+cCYDlEJY+7xr/xRWliq
	5AltQiJmR8tkDgCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719198452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zhy82VCQc8NYnvf05ol+V2ksrLtovCjP3VgqR99bqBo=;
	b=HYjSw+8Ogh0laWZGrCR4xzYY045DpfD6AYoVaHYXOjGPcuRYcF0l5yuNn5iX1pHsoCqlAI
	MesFQuusZxQ2iXha/qeb3pg6o/JztClmBMOQl+/DHehlrTOtKkEGQWWZRJYqbpSMOLkzoV
	r5Z5RVEOOT2s04/zl+i7b9V7KIwbvh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719198452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zhy82VCQc8NYnvf05ol+V2ksrLtovCjP3VgqR99bqBo=;
	b=P3R3uk6X0WrlWbNlf5OI9HQ1WTJ3FNLIcNwLbMxsaEEba64nZt8a/I386pVBDt3nIP0L2F
	Wim5x9SW2g0yWcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A290C13ACD;
	Mon, 24 Jun 2024 03:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xxJPEe7ieGbILwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 24 Jun 2024 03:07:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Ma Ke" <make24@iscas.ac.cn>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Ma Ke" <make24@iscas.ac.cn>
Subject: Re: [PATCH] SUNRPC: check mlen in ip_map_parse()
In-reply-to: <20240624023118.2268917-1-make24@iscas.ac.cn>
References: <20240624023118.2268917-1-make24@iscas.ac.cn>
Date: Mon, 24 Jun 2024 13:07:17 +1000
Message-id: <171919843728.14261.13994470964681717916@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-2.96)[99.81%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.26
X-Spam-Level: 

On Mon, 24 Jun 2024, Ma Ke wrote:
> We should check the parameter mlen before using 'mlen - 1'
> expression for the 'mesg' array index.

There is no need.  This function is only called from cache_do_downcall()
and that function already checks for zero.

That function is only called from cache_downcall() which checks the
size_t count is not >= 32768 so the fact that it is cast to an int for
the ->cache_parse function cannot cause and overflow.

I wouldn't object to ->cache_parse() and qword_get() and maybe others
having their len parameter changed from int to size_t.  
But adding this extra test on mlen add no value.

Thanks,
NeilBrown


> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/sunrpc/svcauth_unix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> index 04b45588ae6f..816bf56597dd 100644
> --- a/net/sunrpc/svcauth_unix.c
> +++ b/net/sunrpc/svcauth_unix.c
> @@ -196,7 +196,7 @@ static int ip_map_parse(struct cache_detail *cd,
>  	struct auth_domain *dom;
>  	time64_t expiry;
>  
> -	if (mesg[mlen-1] != '\n')
> +	if (mlen && mesg[mlen - 1] != '\n')
>  		return -EINVAL;
>  	mesg[mlen-1] = 0;
>  
> -- 
> 2.25.1
> 
> 



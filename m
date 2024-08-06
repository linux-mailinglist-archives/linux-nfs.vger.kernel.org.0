Return-Path: <linux-nfs+bounces-5249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3509949C81
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2024 01:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E59282A2F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2024 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF316A94B;
	Tue,  6 Aug 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQRLrez3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FTwCnFW/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CQRLrez3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FTwCnFW/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C8166F14
	for <linux-nfs@vger.kernel.org>; Tue,  6 Aug 2024 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722988723; cv=none; b=NU5vMv5N2BSHb5YHo7t9AnqVryklQhylhalYuAOc84d7OrKVbUFJp1C4tSPCwt426HoWKS8hGJbAYw4zxcyFLvMccqRAL8TQQXS+RmE5AA1FPVtWY+A9mPAIQXC15stQo9UG4VwpQkUUPjqiU2fb/LWjXccbI90YMvXpGjknIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722988723; c=relaxed/simple;
	bh=Il550vVIKbpSZhcx9ATJLfGSPW2tWQxcZJATz+y4CRI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=DRcnsYkzb8rJDr/x5h+aeMaTc/BzZpLiQ6oAnA20tdki6/rBa3aigtQKiOG50A55j8lsTXRfIUUJrzDiJv16uK2yZ1HVQSNanBNxUpqkUg2qf1AkmhQVoaY09pWo1hqhZfQia0XhvjNseUDOyQwXim21YHRAljX0avuXWEp5okM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQRLrez3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FTwCnFW/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CQRLrez3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FTwCnFW/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0371721C1D;
	Tue,  6 Aug 2024 23:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722988720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyGmfJ4twubWZi/YkFhzFT8bNfFtN453CAZ3vNrnONE=;
	b=CQRLrez3cI+uYqrOSDyk5NR6Zgj38CtfQI5+DYlmgRdF9VYJfG5Hw5SM57dHF07OJ12Bxg
	dQxB/lKQlLRIeT7ksiQ/Yfj1QaVq+fIRF1ttxUsJbWkiHy35Zavp5AynDk3CK6erk4Nxri
	+qVyYtY4tjJHKJLktDqMY+lQgYttx1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722988720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyGmfJ4twubWZi/YkFhzFT8bNfFtN453CAZ3vNrnONE=;
	b=FTwCnFW/LEB2otBSIbgaf7yjkhJZ9eTXXmHtnOKF44kz0UvoJ/8KkXVO91+1j/yiweFFys
	R+hHaLwG20/ZxODw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CQRLrez3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="FTwCnFW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722988720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyGmfJ4twubWZi/YkFhzFT8bNfFtN453CAZ3vNrnONE=;
	b=CQRLrez3cI+uYqrOSDyk5NR6Zgj38CtfQI5+DYlmgRdF9VYJfG5Hw5SM57dHF07OJ12Bxg
	dQxB/lKQlLRIeT7ksiQ/Yfj1QaVq+fIRF1ttxUsJbWkiHy35Zavp5AynDk3CK6erk4Nxri
	+qVyYtY4tjJHKJLktDqMY+lQgYttx1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722988720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyGmfJ4twubWZi/YkFhzFT8bNfFtN453CAZ3vNrnONE=;
	b=FTwCnFW/LEB2otBSIbgaf7yjkhJZ9eTXXmHtnOKF44kz0UvoJ/8KkXVO91+1j/yiweFFys
	R+hHaLwG20/ZxODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 988711340C;
	Tue,  6 Aug 2024 23:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NiKXE624smZgcwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 06 Aug 2024 23:58:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Guoqing Jiang" <guoqing.jiang@linux.dev>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: remove unnecessary cache_put from idmap_lookup
In-reply-to: <20240805105715.11660-1-guoqing.jiang@linux.dev>
References: <20240805105715.11660-1-guoqing.jiang@linux.dev>
Date: Wed, 07 Aug 2024 09:58:34 +1000
Message-id: <172298871466.6062.17538058852164217892@noble.neil.brown.name>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0371721C1D
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, 05 Aug 2024, Guoqing Jiang wrote:
> It is not needed given cache_check already calls cache_put on failure,
> otherwise we call cache_put twice in case of -ETIMEDOUT.   

cache_check() was called on a different *item.

This cache_put() puts the *item returned by lookup_fn() two lines
earlier.

The current code is correct.

NeilBrown

> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  fs/nfsd/nfs4idmap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
> index 7a806ac13e31..08a354783d57 100644
> --- a/fs/nfsd/nfs4idmap.c
> +++ b/fs/nfsd/nfs4idmap.c
> @@ -521,7 +521,6 @@ idmap_lookup(struct svc_rqst *rqstp,
>  		*item = lookup_fn(detail, key);
>  		if (*item != prev_item)
>  			goto retry;
> -		cache_put(&(*item)->h, detail);
>  	}
>  	return ret;
>  }
> -- 
> 2.35.3
> 
> 



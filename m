Return-Path: <linux-nfs+bounces-2177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DFB8709F9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 19:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7CF1F210B3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E705D78697;
	Mon,  4 Mar 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z+5q9KV+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cRGslrQE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RAq36iO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Ne6u/dl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615261683
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578685; cv=none; b=G5b7T+qYkxbuWyIGRjmebG2MdkjWKN2La700nPCg+MiVqNNw1cnYYRLghhCNknr3exGQNhnVaxgUMgOLcYr7nZyfdrn21H+aCa4ByXzSHXFIlnV/+nkhUOrKfgw5XjlR+9YeAJyQ2n/gzCLnrUBZO6jSiiA3VsZ3wELHATBCd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578685; c=relaxed/simple;
	bh=DXAL3XdBHnDJr84qC7VAQYHpvSegw9jOkcf6XKDRF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO3x7MSDlDDn3L907aFaZnHKfCSxnjKFE5qxbRqneN8BKVnDpzhoSY87Z7MXu5MrE7rFIQ9iuCHcabL6sAt68WfSIjFrNqTNyAkZVrq1nRYlcY6tlCsMFFP7VtJNbTZmxwG0F8jQXGodaXUkN6OwI2zU3+qZQ7cRc0uD5rybnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z+5q9KV+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cRGslrQE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RAq36iO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Ne6u/dl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9A0620212;
	Mon,  4 Mar 2024 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709578682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rxvvgvR5f8wzIGKVuJp37mK7vMjOgqGtz2jmy75+PY=;
	b=Z+5q9KV+YtzMODzLBfJN/XreVymWVQx0MDxFN5fz0/AN831YhhU8XsyxRrJkudVAeHT3ub
	Jgm76xkNQUui6KnxywiY2vFDCq1FuWdz9ElHVifewraQK5TMsiiZrOcm+qoXWtitpA6yy3
	32YEsguDYTsSkU6AJiREo1AxCDd0tJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709578682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rxvvgvR5f8wzIGKVuJp37mK7vMjOgqGtz2jmy75+PY=;
	b=cRGslrQENEue/S7BwuKwi2X4tzlTo2ABuUas0N2AZckGoJDexf1zuIKFLtRKKw6Hba5H+F
	cgHAYg0FmiM2SLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709578681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rxvvgvR5f8wzIGKVuJp37mK7vMjOgqGtz2jmy75+PY=;
	b=RAq36iO37oWRvcN76Sdj9vfl3xlblw3jd3ouMcFn/1cA4l0pVAlTY3QuBeXcmPYVaJ9Dpw
	z2952/T1VLsv0ATU4apcgglKyklatIjK+ucXbOg/1SB/yfadnd6dZ3jmQHA1HiyYZHrjgp
	8SIn5Vw3dlVH2+UyRKBU35oI+27GjXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709578681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rxvvgvR5f8wzIGKVuJp37mK7vMjOgqGtz2jmy75+PY=;
	b=5Ne6u/dlM61MgzSpXo8617x5rYtGwTm5qCboEVR7eeNFj4GhHy6n5AWm8JzSoPQAsr8MTL
	M4/Sgog6rOXKVCBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B255513419;
	Mon,  4 Mar 2024 18:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HrLlKbkZ5mWQIwAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 18:58:01 +0000
Date: Mon, 4 Mar 2024 19:58:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] rpcinfo: try connecting using abstract address.
Message-ID: <20240304185800.GD3408054@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240225235628.12473-1-neilb@suse.de>
 <20240225235628.12473-5-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225235628.12473-5-neilb@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.26 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.44)[78.75%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.26

Hi Neil, Steve,

...
>    sun.sun_family = AF_LOCAL;
> +
> +#ifdef _PATH_RPCBINDSOCK_ABSTRACT
> +  memcpy(sun.sun_path, _PATH_RPCBINDSOCK_ABSTRACT,
> +         sizeof(_PATH_RPCBINDSOCK_ABSTRACT));
> +  nbuf.len = SUN_LEN_A (&sun);
> +  nbuf.maxlen = sizeof (struct sockaddr_un);
> +  nbuf.buf = &sun;
> +
> +  clnt = clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
> +  if (clnt)
> +    return clnt;
> +#endif
> +
>    strcpy (sun.sun_path, _PATH_RPCBINDSOCK);
>    nbuf.len = SUN_LEN (&sun);
>    nbuf.maxlen = sizeof (struct sockaddr_un);
>    nbuf.buf = &sun;

> -  return clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
> +  clnt = clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);
> +  return clnt;
nit: maybe keeping the original:
	 return clnt_vc_create (sock, &nbuf, prog, vers, 0, 0);

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Also it might be worth to remove '#if 0' part.

Kind regards,
Petr


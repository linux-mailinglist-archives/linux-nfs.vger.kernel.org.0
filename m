Return-Path: <linux-nfs+bounces-5251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880C949DCE
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2024 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4624CB231FA
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Aug 2024 02:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045B915C125;
	Wed,  7 Aug 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qQbDMoSR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k7kmkVC6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qQbDMoSR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k7kmkVC6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57927448;
	Wed,  7 Aug 2024 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998195; cv=none; b=cJd0WWbkf960HgqLQo/m0SK6PkmJMy89uWi983ijNxtKfRks7i0HzLYqGxC6+T82lNzg9mjBfxppqc4oZ10e09Ufa7XHzPeYmVRaWSEATt5ScBWjnOgBGFDdCs2iwpXissjUSfPgooohKhycPin0lrZ86/HtLYWiZ8XghOZbTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998195; c=relaxed/simple;
	bh=3zkE2aQ84FOdj99kuvMqnv3a8PFT3iuwSPl/0NQavIc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Ju7gqXZ+BwjP/rmwPgr4Xl3lT3dB40VHX9ELBGAJJI5STnp10UoDZlLefKvyKRRcHhM9TGaJWAXTXjXf0u5eTM77yzO7fyNCwa9A9vs6SGure8jGMcA1499I8zzJsQMOycMwpHgHgtUQku1ahV8P+itNQ3w+fqtQ26v7Y1jcVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qQbDMoSR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k7kmkVC6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qQbDMoSR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k7kmkVC6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B019F21C63;
	Wed,  7 Aug 2024 02:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722998191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evSZJWKiFHKspX0ZnwM7WTwRVQ/hfVcYOCcLm08v6cw=;
	b=qQbDMoSRwvaosyg0QNu6gaDQ7VytrpyhlqoBhv+Fus/rfNQtCAOOj6Aa9kRi0MKuMe3pAj
	gbty4tYJtHXdv19hgq6Awi0omw0hpA1k7D9IA7JpQJoPrERZut5K7jWD32x4kam6GIBuRq
	Ov2DWD2K4WHwG3xgqF+kNHErzUYzt64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722998191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evSZJWKiFHKspX0ZnwM7WTwRVQ/hfVcYOCcLm08v6cw=;
	b=k7kmkVC6Ndd1Q8Cmm+wWHXZcuFfqEVgBfM5tgozzTq1Xq2oLAp7Pv9t8tqfl3ZvFsyLhsN
	v+hlej2g/k6lkFDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722998191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evSZJWKiFHKspX0ZnwM7WTwRVQ/hfVcYOCcLm08v6cw=;
	b=qQbDMoSRwvaosyg0QNu6gaDQ7VytrpyhlqoBhv+Fus/rfNQtCAOOj6Aa9kRi0MKuMe3pAj
	gbty4tYJtHXdv19hgq6Awi0omw0hpA1k7D9IA7JpQJoPrERZut5K7jWD32x4kam6GIBuRq
	Ov2DWD2K4WHwG3xgqF+kNHErzUYzt64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722998191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evSZJWKiFHKspX0ZnwM7WTwRVQ/hfVcYOCcLm08v6cw=;
	b=k7kmkVC6Ndd1Q8Cmm+wWHXZcuFfqEVgBfM5tgozzTq1Xq2oLAp7Pv9t8tqfl3ZvFsyLhsN
	v+hlej2g/k6lkFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 041E513297;
	Wed,  7 Aug 2024 02:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8yKwKqzdsmaEHAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 07 Aug 2024 02:36:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mark Grimes" <mark.grimes@ixsystems.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Mark Grimes" <mark.grimes@ixsystems.com>
Subject: Re: [PATCH] nfsd: Add quotes to client info 'callback address'
In-reply-to: <20240807015834.44960-1-mark.grimes@ixsystems.com>
References: <20240807015834.44960-1-mark.grimes@ixsystems.com>
Date: Wed, 07 Aug 2024 12:36:25 +1000
Message-id: <172299818573.6062.18188541572825124295@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, 07 Aug 2024, Mark Grimes wrote:
> The 'callback address' in client_info_show is output without quotes
> causing yaml parsers to fail on processing IPv6 addresses.
> Adding quotes to 'callback address' also matches that used by
> the 'address' field.

Reviewed-by: NeilBrown <neilb@suse.de>

It is conceivable that existing code already handles the existing format
and could break, but it seems unlikely.  nfs-utils has code to parse
this file but it ignores "callback address" and doesn't care about the
content of "address" just including it in logs.

Consistency with "address" is a strong argument - strong enough to risk
the unlikely breakage.

Thanks,
NeilBrown


>=20
> Signed-off-by: Mark Grimes <mark.grimes@ixsystems.com>
> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..0061ae253f4d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2692,7 +2692,7 @@ static int client_info_show(struct seq_file *m, void =
*v)
>  			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
>  	}
>  	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
> -	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> +	seq_printf(m, "callback address: \"%pISpc\"\n", &clp->cl_cb_conn.cb_addr);
>  	seq_printf(m, "admin-revoked states: %d\n",
>  		   atomic_read(&clp->cl_admin_revoked));
>  	drop_client(clp);
> --=20
> 2.39.2
>=20
>=20



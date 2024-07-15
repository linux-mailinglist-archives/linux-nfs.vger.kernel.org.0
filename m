Return-Path: <linux-nfs+bounces-4887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3306930C3D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 02:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DD1F2115F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172423A9;
	Mon, 15 Jul 2024 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u37ekm3R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jtg749yf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ssyfMKFq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uw2BI65J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD5211C;
	Mon, 15 Jul 2024 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721003255; cv=none; b=G/3fDe3AHWC2vhzMC1IpSJpHGGjgIDxEk/KierhzKGquAZysGq07pfFeoUGunF+imyEAxXdNKiynkTFx/ydzkPNDrqi0iwFSujvlXdklXmEedjoZOrkwHsHiWh1e1+jG2AwY+7r10Caa4i5vhkOQPpKyHgDcDGWqUiZ87oESm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721003255; c=relaxed/simple;
	bh=hDxkUYlvveRbi5YVIOSJ7UJN0KLX/xPc0IaxCabb+vk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ClgroCfxTo42upUlu9X1bvZ3BwREgebjQObtoUxqgaT0kTDC3OJe55TF6aM9m6bfTVOrqKcB9d1VvAyKrkEL7PTGypA9XL0TEfgFyCwjB3BK0vj9kTnEgNPr3tuMj+aCqPxq3Y+y91iiFJW7E6L5Qea6OMEbJCd/AyUMbbTSv5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u37ekm3R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jtg749yf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ssyfMKFq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uw2BI65J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B4DE1F7A4;
	Mon, 15 Jul 2024 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721003251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD3/R8GkALo1cvj4LgJipvLG5eZR+DBwU59jWxqlGLE=;
	b=u37ekm3RREsBquPOv6yOsK62MDpNSuZN8SQR7OGTsRrSo8j60mE8YR6pUJc0wm6mMc24pw
	l2RtNOFywJ4nQAP2YMDLKBq45DvASG9rU8NdolkSqqh5HslRFgbC2s/C659YSZ5KEOfU4C
	LlAGKyHW8j4N3UkQ+KQKgFbUId0VZSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721003251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD3/R8GkALo1cvj4LgJipvLG5eZR+DBwU59jWxqlGLE=;
	b=Jtg749yfwJ3JZd+EHNgns+IxvGqnCFYeuMpLYNzxwzXIoEAWXrZtPsNfWmhTwNc46hbGpu
	UaImUnS0ST4YnkBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ssyfMKFq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Uw2BI65J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721003250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD3/R8GkALo1cvj4LgJipvLG5eZR+DBwU59jWxqlGLE=;
	b=ssyfMKFqMWOz1Vm9RzcgpP+XcSEgSjUYPADyi/w3p2rd7QYu/qNh57PPL3jw6Kr1YqDXQn
	or7RT8AqENcgAV11x/T0wzRYKU96qden2iRo51dgv/FuXnNcHxZWj9MVs4rcB58O6I6IjW
	Jl4cpjG20Sz2xZAJuYNcO8ghbO2ae2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721003250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD3/R8GkALo1cvj4LgJipvLG5eZR+DBwU59jWxqlGLE=;
	b=Uw2BI65JOi1YLgokSlnybK/GwKRgEfM+jsm5hJru5s1RWw6lkBh6jYbGvauSoWvrv5cIp8
	xYKl0sGq8SAR4RCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 886C2137EB;
	Mon, 15 Jul 2024 00:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rTrjDu9slGbRAgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 00:27:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Youzhong Yang" <youzhong@gmail.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH] nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
In-reply-to: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
References: <20240711-nfsd-next-v1-1-f9f944500503@kernel.org>
Date: Mon, 15 Jul 2024 10:27:20 +1000
Message-id: <172100324023.15471.746980048334211968@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,netapp.com,talpey.com,vger.kernel.org,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 4B4DE1F7A4

On Fri, 12 Jul 2024, Jeff Layton wrote:
> Given that we do the search and insertion while holding the i_lock, I
> don't think it's possible for us to get EEXIST here. Remove this case.

I was going to comment that as rhltable_insert() cannot return -EEXIST
that is an extra reason to discard the check.  But then I looked at the
code an I cannot convince myself that it cannot.
If __rhashtable_insert_fast() finds that tbl->future_tbl is not NULL it
calls rhashtable_insert_slow(), and that seems to fail if the key
already exists.  But it shouldn't for an rhltable, it should just add
the new item to the linked list for that key.

It looks like this has always been broken: adding to an rhltable during
a resize event can cause EEXIST....

Would anyone like to check my work?  I'm surprise that hasn't been
noticed if it is really the case.

NeilBrown


>=20
> Cc: Youzhong Yang <youzhong@gmail.com>
> Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of lease break er=
ror")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is replacement for PATCH 1/3 in the series I sent yesterday. I
> think it makes sense to just eliminate this case.
> ---
>  fs/nfsd/filecache.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index f84913691b78..b9dc7c22242c 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1038,8 +1038,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	if (likely(ret =3D=3D 0))
>  		goto open_file;
> =20
> -	if (ret =3D=3D -EEXIST)
> -		goto retry;
>  	trace_nfsd_file_insert_err(rqstp, inode, may_flags, ret);
>  	status =3D nfserr_jukebox;
>  	goto construction_err;
>=20
> ---
> base-commit: ec1772c39fa8dd85340b1a02040806377ffbff27
> change-id: 20240711-nfsd-next-c9d17f66e2bd
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20



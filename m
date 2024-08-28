Return-Path: <linux-nfs+bounces-5893-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942B96349A
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 00:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2101F25451
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EC41AD40D;
	Wed, 28 Aug 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G4RT/IXG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+JCpk0d8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G4RT/IXG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+JCpk0d8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B7167D97;
	Wed, 28 Aug 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883668; cv=none; b=K/JON+NmW2MLe1Dd9xOoEW22fn9+oYBlXCOUriiVg17Y2cTQCRO+eDnYMFqDUfO02NfqdvDB7BCtAiD6tR58MrgTW+QmeOdNa1NHJE0xykZMzkr7E6THBkX1SonHbC9JP+erR+mcbLPBfOvHczCr6Y/j650/CRkLgFavpZEodgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883668; c=relaxed/simple;
	bh=m4ARNFxQSN/1e9G0iC3AkVHXLvE3+Ti2uCNcKQIpLhY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jMYLQAHI/m+3xEt1Il7sRfe9/s8lszMLq/xRjBh8HnEHqXYCHCAo4aZZzPyccKZXE3cuIGOflr7z/J7cdxrTfsGwiy48pTVJp0LLj2YYoiZLXnw3Re+xjgjUw63I5CJCPREq1ZakOqdYRz+G/LysFk5/xxmFpfD1jzitqJmua3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G4RT/IXG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+JCpk0d8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G4RT/IXG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+JCpk0d8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C070F1FC30;
	Wed, 28 Aug 2024 22:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724883663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhenqZ39wz2bkxdtEJRdVMUpo6TweEtURQV6wq0UsjU=;
	b=G4RT/IXGvGmESGNWpxgBVf+vEO3EYPbWY17crlNoEgv6GCt4SSM5GkPYIDdwI0tDDu0unJ
	hBj1qLnSQC1cGcsDF8p6BoRt4X/O70Ki9pMIMzh7wwmjzntYgh8jYTnELsBP0ZJp32o5sq
	WUhu3aVXj5gt54va8WMeyck8z7R4MHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724883663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhenqZ39wz2bkxdtEJRdVMUpo6TweEtURQV6wq0UsjU=;
	b=+JCpk0d8km19o3+Ws0rxA/1AzlZWqwNSA3gpjzW8ssbJaEZZVlo2nqMzBo6xQ3x0ofZ7fs
	4Ah2SC2zridoOUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724883663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhenqZ39wz2bkxdtEJRdVMUpo6TweEtURQV6wq0UsjU=;
	b=G4RT/IXGvGmESGNWpxgBVf+vEO3EYPbWY17crlNoEgv6GCt4SSM5GkPYIDdwI0tDDu0unJ
	hBj1qLnSQC1cGcsDF8p6BoRt4X/O70Ki9pMIMzh7wwmjzntYgh8jYTnELsBP0ZJp32o5sq
	WUhu3aVXj5gt54va8WMeyck8z7R4MHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724883663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JhenqZ39wz2bkxdtEJRdVMUpo6TweEtURQV6wq0UsjU=;
	b=+JCpk0d8km19o3+Ws0rxA/1AzlZWqwNSA3gpjzW8ssbJaEZZVlo2nqMzBo6xQ3x0ofZ7fs
	4Ah2SC2zridoOUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B24851398F;
	Wed, 28 Aug 2024 22:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WlDxGcqiz2ayRAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Aug 2024 22:20:58 +0000
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
Cc: "Yan Zhen" <yanzhen@vivo.com>, davem@davemloft.net, chuck.lever@oracle.com,
 trondmy@kernel.org, anna@kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3] sunrpc: Fix error checking for d_hash_and_lookup()
In-reply-to: <4392ddb203b2ad27096ab6d9b3bf114fecf4e88c.camel@kernel.org>
References: <20240828044355.590260-1-yanzhen@vivo.com>,
 <4392ddb203b2ad27096ab6d9b3bf114fecf4e88c.camel@kernel.org>
Date: Thu, 29 Aug 2024 08:20:55 +1000
Message-id: <172488365549.4433.203600496331198489@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 28 Aug 2024, Jeff Layton wrote:
> On Wed, 2024-08-28 at 12:43 +0800, Yan Zhen wrote:
> > The d_hash_and_lookup() function returns either an error pointer or NULL.
> >=20
> > It might be more appropriate to check error using IS_ERR_OR_NULL().
> >=20
> > Fixes: 4b9a445e3eeb ("sunrpc: create a new dummy pipe for gssd to hold op=
en")
> > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > ---
> >=20
> > Changes in v3:
> > - Rewrite the "fixes".
> > - Using ERR_CAST(gssd_dentry) instead of ERR_PTR(-ENOENT).
> >=20
> >  net/sunrpc/rpc_pipe.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> > index 910a5d850d04..13e905f34359 100644
> > --- a/net/sunrpc/rpc_pipe.c
> > +++ b/net/sunrpc/rpc_pipe.c
> > @@ -1306,8 +1306,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct=
 rpc_pipe *pipe_data)
> > =20
> >  	/* We should never get this far if "gssd" doesn't exist */
> >  	gssd_dentry =3D d_hash_and_lookup(root, &q);
> > -	if (!gssd_dentry)
> > -		return ERR_PTR(-ENOENT);
> > +	if (IS_ERR_OR_NULL(gssd_dentry))
> > +		return ERR_CAST(gssd_dentry);
>=20
> If you get back a NULL, then ERR_CAST will just make this return a NULL
> pointer.
>=20
> > =20
> >  	ret =3D rpc_populate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1, NULL);
> >  	if (ret) {
> > @@ -1318,7 +1318,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct=
 rpc_pipe *pipe_data)
> >  	q.name =3D gssd_dummy_clnt_dir[0].name;
> >  	q.len =3D strlen(gssd_dummy_clnt_dir[0].name);
> >  	clnt_dentry =3D d_hash_and_lookup(gssd_dentry, &q);
> > -	if (!clnt_dentry) {
> > +	if (IS_ERR_OR_NULL(clnt_dentry)) {
> >  		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
> >  		pipe_dentry =3D ERR_PTR(-ENOENT);
> >  		goto out;
>=20
> ...you probably also want to make this return the error from
> d_hash_and_lookup as well when there is one.

I'd like to just throw in here that in this circumstance,
d_hash_and_lookup() will never return an error.
It only ever returns an error that it gets from ->d_hash, and ->d_hash is
specific to the filesystem, and the filesystem here is the rpc_pipe
virtual filesystem which doesn't define a ->d_hash.

So errors are impossible.

While I'm generally in favour of making code more robust and don't
object to the IS_ERR_OR_NULL conversion, I think we should be *very*
cautious not to introduce a bug where no bug currently exists.

I would rather the return values were no changed.

NeilBrown


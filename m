Return-Path: <linux-nfs+bounces-7657-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66369BBEAD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 21:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1EE282B5C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCCD70837;
	Mon,  4 Nov 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FmgPzHDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Crqd71Pl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FmgPzHDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Crqd71Pl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3001DDA0C
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751499; cv=none; b=LhOW3Rwew/HURAsVwnp0BYjZEuTXzBcu8kpBTbygqgHIKeSJjndDrhAeE8XXn0A6j8bGh0SG+/YrxYtsQpvf9jVhzSxqFO5vm68brtQCJuXv9FU5QvvZrWFRQwaC91hVxD+SE1lPpvR1pskOZD80SsSeuyUzudolOD790FO05sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751499; c=relaxed/simple;
	bh=7OMDwPeE9o7bztAvscaCki6jdyuURgI4prrl3GVJAXQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=X9nPqAXiTBNG2YV5LCIH9s6kAznmXuY3jsuFkUjrwpNUKheFMUgl1zVia48H0ombyZqgiF5Y37EFTIAOSDmq1UrZmkGBXVOMSm4efSK3fQqWt+3ZihmNy0154C8eJG6ShpbV1YXukjA9wd46apaCjY84k+ShR0Q5rnEOGWDHuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FmgPzHDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Crqd71Pl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FmgPzHDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Crqd71Pl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C10511FDEE;
	Mon,  4 Nov 2024 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730751494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr7N6CFjiBv+/gpi6b+20X6MHFxIihPVGgkw0Yw1aMU=;
	b=FmgPzHDWmhrppU4EGFOGORCmTO0/DFswumH2OgMtpH16NIqHORpSY6IWVSGPwWqinV5pNY
	h05qcowzxEVM2ae4Y26AY/2gl7V6NuMjXdJcKUZiUx5y08t3f/ciNsSwL77gU9ezwe5xaS
	sIGZtsJxH25A22OidOwE42Z/vuSydRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730751494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr7N6CFjiBv+/gpi6b+20X6MHFxIihPVGgkw0Yw1aMU=;
	b=Crqd71PlepLFNGyoV2IkniHup9AISdEX3kpX6Y8nkkbA9sGdiaMVPxRqi5JfWRHk9pE6EZ
	SXdlPaqO+xpXraDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730751494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr7N6CFjiBv+/gpi6b+20X6MHFxIihPVGgkw0Yw1aMU=;
	b=FmgPzHDWmhrppU4EGFOGORCmTO0/DFswumH2OgMtpH16NIqHORpSY6IWVSGPwWqinV5pNY
	h05qcowzxEVM2ae4Y26AY/2gl7V6NuMjXdJcKUZiUx5y08t3f/ciNsSwL77gU9ezwe5xaS
	sIGZtsJxH25A22OidOwE42Z/vuSydRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730751494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr7N6CFjiBv+/gpi6b+20X6MHFxIihPVGgkw0Yw1aMU=;
	b=Crqd71PlepLFNGyoV2IkniHup9AISdEX3kpX6Y8nkkbA9sGdiaMVPxRqi5JfWRHk9pE6EZ
	SXdlPaqO+xpXraDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A63C313503;
	Mon,  4 Nov 2024 20:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mb2aFgQsKWfxbAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Nov 2024 20:18:12 +0000
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
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
In-reply-to: <f4d2c708aafac0174f6f7da22ceccac72bf93119.camel@kernel.org>
References: <173069566284.81717.2360317209010090007@noble.neil.brown.name>,
 <f4d2c708aafac0174f6f7da22ceccac72bf93119.camel@kernel.org>
Date: Tue, 05 Nov 2024 07:18:03 +1100
Message-id: <173075148390.81717.11139163135573283140@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 05 Nov 2024, Jeff Layton wrote:
> On Mon, 2024-11-04 at 15:47 +1100, NeilBrown wrote:
> > An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
> > that is not requested then the server is free to perform the copy
> > synchronously or asynchronously.
> >=20
> > In the Linux implementation an async copy requires more resources than a
> > sync copy.  If nfsd cannot allocate these resources, the best response
> > is to simply perform the copy (or the first 4MB of it) synchronously.
> >=20
>=20
> Where does the copy get clamped at 4MB?
>=20
> > This choice may be debatable if the unavailable resource was due to
> > memory allocation failure - when memalloc fails it might be best to
> > simply give up as the server is clearly under load.  However in the case
> > that policy prevents another kthread being created there is no benefit
> > and much cost is failing with NFS4ERR_DELAY.  In that case it seems
> > reasonable to avoid that error in all circumstances.
> >=20
> > So change the out_err case to retry as a sync copy.
> >=20
> > Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY ope=
rations")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4proc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index fea171ffed62..06e0d9153ca9 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  		wake_up_process(async_copy->copy_task);
> >  		status =3D nfs_ok;
> >  	} else {
> > +	retry_sync:
> >  		status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
> >  				       copy->nf_dst->nf_file, true);
> >  	}
> > @@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  	}
> >  	if (async_copy)
> >  		cleanup_async_copy(async_copy);
> > -	status =3D nfserr_jukebox;
> > -	goto out;
> > +	goto retry_sync;
> >  }
> > =20
> >  static struct nfsd4_copy *
> >=20
> > base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
>=20
>=20
> You're probably right that attempting to do this synchronously is
> probably best. That should avoid another RPC, though at the cost of
> having to shovel the data into the pagecache.

COPY always shovels data into the pagecache.  The difference between
sync and async is:
 - sync runs in nfsd thread, async run in a workqueue
 - sync stops after 4MB, async loops around after each 4MB until it
 finishes
(plus the obvious protocol differences).

>=20
> If memory is very tight, I suppose the synchronous copy might also fail
> with NFS4ERR_DELAY, in which case we're no worse off.

Memory being tight isn't the interesting case.  More COPYs than nfsd
threads is the interesting case.

>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks,
NeilBrown

>=20



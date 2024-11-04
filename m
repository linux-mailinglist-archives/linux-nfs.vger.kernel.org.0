Return-Path: <linux-nfs+bounces-7659-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D19BBECD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64ED8280D4C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 20:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E01E7669;
	Mon,  4 Nov 2024 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0XeyZpKS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rHnR88N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0XeyZpKS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rHnR88N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2DF1E6306
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752213; cv=none; b=K+v/NTatCTpMOuXhzdYiBGdzvlaHFfDk8YVS5Et8sHhdjNkrYEppQFe29diAiOOfkUjtv6kaYy9ESDfk2YudZCvZD76/LEROiMsywW4YcWlmplWez1M+zGip1e2q5B5zA6+YA9w6J2Oqz8Z0J0knHYyxcZ4JUrY4BDJgdKRy/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752213; c=relaxed/simple;
	bh=z5jxFYFtiWgLp63g4nmW1DdVQvTXN1NuAWHjdNEGf4Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uiHJNKfj9TvqTXX/xzbqOAOeii7fwsGOQHrK7XKy13+QqGDdU/rtHLbT44LJM8noyCjuslFTiAIGgITWHO/EVFrNae+xh3l1xqSfYpFlb2FF5UmY+Auj6A+SmaGKnR47z4O4ZQtD8BseuVAuDsIUN0ldoK70KixQQSND1nB5KuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0XeyZpKS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rHnR88N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0XeyZpKS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rHnR88N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2476321F21;
	Mon,  4 Nov 2024 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730752209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfAoqlV9bfR7qCtrnWZjsdQ4J6/Uv6fsZVl99iiJzZM=;
	b=0XeyZpKSVppctaPQjUyuh7quw2xMKy/VxN8SGTJtlblwlWOYYaO3jLkPXqyHDaw4Yx+bgB
	nqPPhgzbHHTgqN4c6ZJpouqrRRLUapVl9wkQ8PAc0mt0yn6p2DyCerxuf9nyomV5uC4Gsv
	xHuc62BZcBRjeOv9KczYP5RKrrgfnN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730752209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfAoqlV9bfR7qCtrnWZjsdQ4J6/Uv6fsZVl99iiJzZM=;
	b=+rHnR88NNLVePyj5Ubzk1kj0jgIQiYd5fAjRKJh5t0NpfgKBH6Qj5FlgfKqfFv1lj6A3VB
	2rsyMM22xEAMNaBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730752209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfAoqlV9bfR7qCtrnWZjsdQ4J6/Uv6fsZVl99iiJzZM=;
	b=0XeyZpKSVppctaPQjUyuh7quw2xMKy/VxN8SGTJtlblwlWOYYaO3jLkPXqyHDaw4Yx+bgB
	nqPPhgzbHHTgqN4c6ZJpouqrRRLUapVl9wkQ8PAc0mt0yn6p2DyCerxuf9nyomV5uC4Gsv
	xHuc62BZcBRjeOv9KczYP5RKrrgfnN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730752209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfAoqlV9bfR7qCtrnWZjsdQ4J6/Uv6fsZVl99iiJzZM=;
	b=+rHnR88NNLVePyj5Ubzk1kj0jgIQiYd5fAjRKJh5t0NpfgKBH6Qj5FlgfKqfFv1lj6A3VB
	2rsyMM22xEAMNaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06AA013736;
	Mon,  4 Nov 2024 20:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id toxeK84uKWckcAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Nov 2024 20:30:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fallback to sync COPY if async not possible
In-reply-to: <ZykBKNcLudUySOXZ@tissot.1015granger.net>
References: <173069566284.81717.2360317209010090007@noble.neil.brown.name>,
 <ZykBKNcLudUySOXZ@tissot.1015granger.net>
Date: Tue, 05 Nov 2024 07:30:03 +1100
Message-id: <173075220377.81717.4924074245134896523@noble.neil.brown.name>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 05 Nov 2024, Chuck Lever wrote:
> On Mon, Nov 04, 2024 at 03:47:42PM +1100, NeilBrown wrote:
> >=20
> > An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
> > that is not requested then the server is free to perform the copy
> > synchronously or asynchronously.
> >=20
> > In the Linux implementation an async copy requires more resources than a
> > sync copy.  If nfsd cannot allocate these resources, the best response
> > is to simply perform the copy (or the first 4MB of it) synchronously.
> >=20
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
>=20
> Hi Neil,
>=20
> Why is a Fixes: tag necessary?
>=20
> And why that commit? async copies can fail due to lack of resources
> on kernels that don't have aadc3bbea163, AFAICT.

I had hoped my commit message would have explained that, though I accept
it was not as explicit as it could be.

kmalloc(GFP_KERNEL) allocation failures aren't interesting.  They never
happen for smallish sizes, and if they do then the server is so borked
that it hardly matter what we do.

The fixed commit introduces a new failure mode that COULD easily be hit
in practice.  It causes the N+1st COPY to wait indefinitely until at
least one other copy completes which, as you observed in that commit,
could "run for a long time".  I don't think that behaviour is necessary
or appropriate.

Changing the handling for kmalloc failure was just an irrelevant
side-effect for changing the behaviour when then number of COPY requests
exceeded the number of configured threads.

This came up because CVE-2024-49974 was created so I had to do something
about the theoretical DoS vector in SLE kernels.  I didn't like the
patch so I backported

Commit 8d915bbf3926 ("NFSD: Force all NFSv4.2 COPY requests to be synchronous=
")

instead (and wondered why it hadn't gone to stable).

Thanks,
NeilBrown


>=20
>=20
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
> > --=20
> > 2.47.0
> >=20
>=20
> --=20
> Chuck Lever
>=20



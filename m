Return-Path: <linux-nfs+bounces-5401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB943952DA7
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 13:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376791F22D01
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2024 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1231714C6;
	Thu, 15 Aug 2024 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nd0h1rxi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h+NSoNfS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nd0h1rxi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h+NSoNfS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B47DA9E;
	Thu, 15 Aug 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721960; cv=none; b=E98CgI6TrA1Fq72bvMEjr+FpelO2DmOgur4OB9me2xm+EYCj8+0Xspmytb3UJO/bf9T/RDYpSIl6pCWvZfd8R/WL/CJB1G8JrEdCwY90vAd3H9fCJrclUVfCDGowySsbgiYoTT4fWYoxmLfGJT8zUj8uQlHeN2MVRL2GyO3/Iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721960; c=relaxed/simple;
	bh=l6rcWtVPc1rg8CGlJhZWcF1c3U+WD5PE2ri2IiuBJ4g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ukpdMAxhgE5bM7DL7V5h3xVjcTdKseFvNo35CK27IsL6bHz4WBxhx80ySVo+j7yUNW/XARADr5WYdcsj4pQuwAyYuJQA72CsHazvwfrgLaTGA+oOn3mYmxSNA7kkSE1X80vo5KBd0soNsXAVI3TPGgeq344pWLXC1fTDa439U+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nd0h1rxi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h+NSoNfS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nd0h1rxi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h+NSoNfS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6238A1FFF8;
	Thu, 15 Aug 2024 11:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723721955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkDQhnOA0LzdK2HzsAZj+T0x6/mTNFsFWfXDFNt2kvU=;
	b=nd0h1rxiIfUn7ca5dbmdkVbg8eiE8yAKVMfi4NbYyxSG9MtlCzl98WhhUT6LkhVyFD9fxu
	RlqQmNOielc0wD/pFx65cpsHZJJIO9hcVOvKUIfaFsPsA/rYaQXFPApw7yT66Qxu2LDyba
	SZ4lK0pV83G+GrsBWCQJb0rrHVevps8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723721955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkDQhnOA0LzdK2HzsAZj+T0x6/mTNFsFWfXDFNt2kvU=;
	b=h+NSoNfSb+/b6aUitZ+o0G4B3ziGTqg3Mp9IEHPYFtKpkq3I1BWBdnR8exWvL0qydABUH4
	c9G14u36Lxa6xQCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723721955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkDQhnOA0LzdK2HzsAZj+T0x6/mTNFsFWfXDFNt2kvU=;
	b=nd0h1rxiIfUn7ca5dbmdkVbg8eiE8yAKVMfi4NbYyxSG9MtlCzl98WhhUT6LkhVyFD9fxu
	RlqQmNOielc0wD/pFx65cpsHZJJIO9hcVOvKUIfaFsPsA/rYaQXFPApw7yT66Qxu2LDyba
	SZ4lK0pV83G+GrsBWCQJb0rrHVevps8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723721955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkDQhnOA0LzdK2HzsAZj+T0x6/mTNFsFWfXDFNt2kvU=;
	b=h+NSoNfSb+/b6aUitZ+o0G4B3ziGTqg3Mp9IEHPYFtKpkq3I1BWBdnR8exWvL0qydABUH4
	c9G14u36Lxa6xQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 486C813B0C;
	Thu, 15 Aug 2024 11:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B7XfOt3ovWaEPgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 15 Aug 2024 11:39:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kunwu Chan" <kunwu.chan@linux.dev>
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Kunwu Chan" <chentao@kylinos.cn>
Subject: Re: [PATCH] SUNRPC: Fix -Wformat-truncation warning
In-reply-to: <0282be6f-e8ac-4428-a2ac-1ea6b7c25f4a@linux.dev>
References: <>, <0282be6f-e8ac-4428-a2ac-1ea6b7c25f4a@linux.dev>
Date: Thu, 15 Aug 2024 21:39:06 +1000
Message-id: <172372194692.6062.4519803974558688969@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
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

On Thu, 15 Aug 2024, Kunwu Chan wrote:
> Thanks for your reply.
>=20
> On 2024/8/14 18:28, NeilBrown wrote:
> > On Wed, 14 Aug 2024, kunwu.chan@linux.dev wrote:
> >> From: Kunwu Chan <chentao@kylinos.cn>
> >>
> >> Increase size of the servername array to avoid truncated output warning.
> >>
> >> net/sunrpc/clnt.c:582:75: error=EF=BC=9A=E2=80=98%s=E2=80=99 directive o=
utput may be truncated
> >> writing up to 107 bytes into a region of size 48
> >> [-Werror=3Dformat-truncation=3D]
> >>    582 |                   snprintf(servername, sizeof(servername), "%s",
> >>        |                                                             ^~
> >>
> >> net/sunrpc/clnt.c:582:33: note:=E2=80=98snprintf=E2=80=99 output
> >> between 1 and 108 bytes into a destination of size 48
> >>    582 |                     snprintf(servername, sizeof(servername), "%=
s",
> >>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> >>    583 |                                          sun->sun_path);
> >>
> >> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> >> ---
> >>   net/sunrpc/clnt.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> >> index 09f29a95f2bc..874085f3ed50 100644
> >> --- a/net/sunrpc/clnt.c
> >> +++ b/net/sunrpc/clnt.c
> >> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *=
args)
> >>   		.connect_timeout =3D args->connect_timeout,
> >>   		.reconnect_timeout =3D args->reconnect_timeout,
> >>   	};
> >> -	char servername[48];
> >> +	char servername[108];
> > If we choose this approach to removing the warning, then we should use
> > UNIX_PATH_MAX rather than 108.
> My negligence.
> >
> > However the longest server name copied in here will in practice be
> >     /var/run/rpcbind.sock
> >
> > so the extra 60 bytes on the stack is wasted ...  maybe that doesn't
> > matter.
> I'm thinking=C2=A0 about use a dynamic space alloc method like kasprintf to=
=20
> avoid space waste.
> > The string is only used by xprt_create_transport() which requires it to
> > be less than RPC_MAXNETNAMELEN - which is 256.
> > So maybe that would be a better value to use for the array size ....  if
> > we assume that stack space isn't a problem.
>=20
> Thank you for the detailed explanation. I read the=20
> xprt_create_transport,=C2=A0 the RPC_MAXNETNAMELEN
>=20
> is only use to xprt_create_transport .
>=20
> > What ever number we use, I'd rather it was a defined constant, and not
> > an apparently arbitrary number.
>=20
> Whether we could check the sun->sun_path length before using snprintf?=C2=
=A0=20
> The array size should smaller
>=20
> than=C2=A0 the minimum of sun->sun_path and RPC_MAXNETNAMELEN.
>=20
> Or use the dynamic space allocate method to save space.

I think that dynamically allocating space is not a good idea.  It means
you have to handle failure which is just a waste of code.

I'd suggest simply changing the array to RPC_MAXNETNAMELEN.

NeilBrown



>=20
> >
> > Thanks,
> > NeilBrown
> >
> >
> >>   	struct rpc_clnt *clnt;
> >>   	int i;
> >>  =20
> >> --=20
> >> 2.40.1
> >>
> >>
> --=20
> Thanks,
>    Kunwu.Chan
>=20
>=20



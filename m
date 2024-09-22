Return-Path: <linux-nfs+bounces-6592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EA497E43C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 01:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2BE1C20FC9
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Sep 2024 23:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117380BFF;
	Sun, 22 Sep 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tTBUR+jp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2HAZzdJg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tTBUR+jp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2HAZzdJg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173C7711B;
	Sun, 22 Sep 2024 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727047741; cv=none; b=mnM4LFRuopQey7OdPEIho3rjTRtrBNuiYB+hcm1p23PWbeJdE7RdfpG+3wDKvVHdVL6YnfN+XRUF9h0nlFdcTDxeLwEj1C1IuETZ8pe6UIA/bQY61a9qXv5kJZKLI7o2HF0MuEk6ecDg8q2EwpVApTUfpu/WEYr5EQHbdNfKX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727047741; c=relaxed/simple;
	bh=GF5eLYGFjyUOpQl8QBS0lL0fk6dY8ffWnxdEpgDJHC8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iFk2O3OCtoySL9jN+NTi3Lu/R3+FLGVVbckSpookV+tV7mkv4BDi5m53lBxUVGMJFwVTDIfrqh7XMlX1bog6cHIqt5X3hLnydxSmAkRNiuokutjEVR7kTqS6yohhvRWVsIneLBtb+ia9jTbQzX29AYCA2h/7DwuIYC5YGTgS9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tTBUR+jp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2HAZzdJg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tTBUR+jp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2HAZzdJg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B30CD220F4;
	Sun, 22 Sep 2024 23:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727047311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IahTZskccNbrqwZ3A3SuzfGNu73YumuHiMKMAo2pyEA=;
	b=tTBUR+jpyn3xyPfqF4aDFD9aOMtEqGOP6IOu1051o++aCDESVtiysFo8fJngsOA0fE1h0C
	q6MjIW0+ZpYlfhijkRT6e9ZW9X3///awwk1fhD0K70/vabeZLtelbqG+ej8RxvSBPlP24H
	KJGgtuN6dVeqBW0tD6jxiuMIluZXxvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727047311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IahTZskccNbrqwZ3A3SuzfGNu73YumuHiMKMAo2pyEA=;
	b=2HAZzdJgt8+r5fyvrw6PdHdrV5rMAZUNIX7pm6sVp5SAD6OA8fvzXt/xwd3NXab3EGGefe
	GZ2uB4lMMtSaaqAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727047311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IahTZskccNbrqwZ3A3SuzfGNu73YumuHiMKMAo2pyEA=;
	b=tTBUR+jpyn3xyPfqF4aDFD9aOMtEqGOP6IOu1051o++aCDESVtiysFo8fJngsOA0fE1h0C
	q6MjIW0+ZpYlfhijkRT6e9ZW9X3///awwk1fhD0K70/vabeZLtelbqG+ej8RxvSBPlP24H
	KJGgtuN6dVeqBW0tD6jxiuMIluZXxvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727047311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IahTZskccNbrqwZ3A3SuzfGNu73YumuHiMKMAo2pyEA=;
	b=2HAZzdJgt8+r5fyvrw6PdHdrV5rMAZUNIX7pm6sVp5SAD6OA8fvzXt/xwd3NXab3EGGefe
	GZ2uB4lMMtSaaqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96EEB1328C;
	Sun, 22 Sep 2024 23:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7MisEo2m8Gb7YgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 22 Sep 2024 23:21:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jon Hunter" <jonathanh@nvidia.com>
Cc: "Steven Price" <steven.price@arm.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
In-reply-to: <9d670899-18f8-4367-b8a8-6ad84a1224df@nvidia.com>
References: <>, <9d670899-18f8-4367-b8a8-6ad84a1224df@nvidia.com>
Date: Mon, 23 Sep 2024 09:21:45 +1000
Message-id: <172704730586.17050.17105080551297605806@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 22 Sep 2024, Jon Hunter wrote:
> Hi Neil,
>=20
> On 20/09/2024 04:02, NeilBrown wrote:
> > On Thu, 19 Sep 2024, Steven Price wrote:
> >> On 19/09/2024 02:29, NeilBrown wrote:
> >>> On Wed, 18 Sep 2024, Steven Price wrote:
> >>>> Hi Neil,
> >>>>
> >>>> (Dropping the list/others due to the attachment)
> >>>
> >>> (re-adding others now - thanks for the attachment).
> >>>
> >>>>
> >>>> Attached, this is booting a kernel compiled from 00fd839ca761 ("nfs:
> >>>> simplify and guarantee owner uniqueness.") which uses an NFS root with=
 a
> >>>> Debian bullseye userspace.
> >>>
> >>> This shows that the owner_id was always different - or almost always.
> >>> Once it repeated we got an error because the seqid kept increasing.
> >>> This is because the xdr encoding is broken.
> >>>
> >>> Please apply this incremental patch and confirm that it works now.
> >>
> >> Thanks, I've tested the below and I don't see NFS errors any more.
> >>
> >> Tested-by: Steven Price <steven.price@arm.com>
> >=20
> > Thanks Steve.
> >=20
> > Anna: could you please squash this fix in to the commit?
> > Jon: could you please confirm that this fixes your problem too.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > index 1aaf908acc5d..88bcbcba1381 100644
> > --- a/fs/nfs/nfs4xdr.c
> > +++ b/fs/nfs/nfs4xdr.c
> > @@ -1429,7 +1429,7 @@ static inline void encode_openhdr(struct xdr_stream=
 *xdr, const struct nfs_opena
> >   	*p++ =3D cpu_to_be32(28);
> >   	p =3D xdr_encode_opaque_fixed(p, "open id:", 8);
> >   	*p++ =3D cpu_to_be32(arg->server->s_dev);
> > -	xdr_encode_hyper(p, arg->id.uniquifier);
> > +	p =3D xdr_encode_hyper(p, arg->id.uniquifier);
> >   	xdr_encode_hyper(p, arg->id.create_time);
> >   }
>=20
>=20
> Works for me!

Thanks Jon.
Anna has updated the patch so the fixed version is what will land
upstream.

NeilBrown


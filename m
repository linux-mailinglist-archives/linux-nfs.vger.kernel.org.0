Return-Path: <linux-nfs+bounces-7543-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D609B3C30
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 21:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6441F2247D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B018D649;
	Mon, 28 Oct 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HoiAP37o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FV+apTOE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HoiAP37o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FV+apTOE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0E18E74D
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148480; cv=none; b=pmZXlCpjBmRi+dOy1xt+NQGGNIN8WMFSFZt/h9Et9c+ASBPkKy3p/fKje/msgZGTcBy6wQAiatKMSBQOnSY8ockZPk12lZfxw/xrrv5QRN695F00TQP6Rad6/0Rp7NB0jqOVQQsdvn95wClQCWieu3dQ/Qv6Bv0TWOLqSFJYa18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148480; c=relaxed/simple;
	bh=NkSqrkrKi6T8gYv0/5ax+3OIMKieP8voWQI3mqRHJzI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RE5TxlnnyXI8SI0R493TUYbTJsQzukGFV3OvEIDBlBqu7nYa/QoA4pYroOWDJFL2Db5StrKtxjS3Eed7opD8uYC7F3ev79M1flDQTLRbOOx/zTpDkYTfc/VWRScGjRSiUrdhQd7UEOdKtT7NfSK3jkDdbqiUZ0EQ2zjPJ0ksIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HoiAP37o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FV+apTOE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HoiAP37o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FV+apTOE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EC6121EC1;
	Mon, 28 Oct 2024 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730148470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9ynLr8F3YHMP+34u2CLinleFFzsTezYNPkz8Zgoq9U=;
	b=HoiAP37oxpdnEUQJQ1mo9X2tdBYUB7JBNOFBrxLB5SzjOOxcIfc3tbBP+TsDspEMecvXvq
	yLHprmpMRSYF43qwpFyxqC2Ni0x7ChCMLUM8/ZRYXnNxkkGIQTFluVwEZwRyAUHg5P/yek
	c4unvZ8bSgWpIzfsksKXYTMdXRI6hFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730148470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9ynLr8F3YHMP+34u2CLinleFFzsTezYNPkz8Zgoq9U=;
	b=FV+apTOE+OWsJqtIUQo6KgvxUnr7nlqvGt6jmdaxPmanINdzWY9OCYRwBE10bJRbhaxXrV
	6mXIG+3DPn3/QsDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HoiAP37o;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FV+apTOE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730148470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9ynLr8F3YHMP+34u2CLinleFFzsTezYNPkz8Zgoq9U=;
	b=HoiAP37oxpdnEUQJQ1mo9X2tdBYUB7JBNOFBrxLB5SzjOOxcIfc3tbBP+TsDspEMecvXvq
	yLHprmpMRSYF43qwpFyxqC2Ni0x7ChCMLUM8/ZRYXnNxkkGIQTFluVwEZwRyAUHg5P/yek
	c4unvZ8bSgWpIzfsksKXYTMdXRI6hFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730148470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9ynLr8F3YHMP+34u2CLinleFFzsTezYNPkz8Zgoq9U=;
	b=FV+apTOE+OWsJqtIUQo6KgvxUnr7nlqvGt6jmdaxPmanINdzWY9OCYRwBE10bJRbhaxXrV
	6mXIG+3DPn3/QsDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A913E137D4;
	Mon, 28 Oct 2024 20:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qWwuF3P4H2dPZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 28 Oct 2024 20:47:47 +0000
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
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH] nfsd: make use of warning provided by refcount_t
In-reply-to: <844c0483ad7c1266d6e744b48846d619a4efe828.camel@kernel.org>
References: <173006668387.81717.13494809143579612819@noble.neil.brown.name>,
 <844c0483ad7c1266d6e744b48846d619a4efe828.camel@kernel.org>
Date: Tue, 29 Oct 2024 07:47:29 +1100
Message-id: <173014844936.81717.17897683464355424644@noble.neil.brown.name>
X-Rspamd-Queue-Id: 1EC6121EC1
X-Spam-Score: -4.49
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.18)[-0.907];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 29 Oct 2024, Jeff Layton wrote:
> On Mon, 2024-10-28 at 09:04 +1100, NeilBrown wrote:
> > refcount_t, by design, checks for unwanted situations and provides
> > warnings.  It is rarely useful to have explicit warnings with refcount
> > usage.
> >=20
> > In this case we have an explicit warning if a refcount_t reaches zero
> > when decremented.  Simply using refcount_dec() will provide a similar
> > warning and also mark the refcount_t as saturated to avoid any possible
> > use-after-free.
> >=20
> > This patch drops the warning and uses refcount_dec() instead of
> > refcount_dec_and_test().
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/filecache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 1408166222c5..c16671135d17 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -1050,7 +1050,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct=
 net *net,
> >  		 * the last one however, since we should hold another.
> >  		 */
> >  		if (nfsd_file_lru_remove(nf))
> > -			WARN_ON_ONCE(refcount_dec_and_test(&nf->nf_ref));
> > +			refcount_dec(&nf->nf_ref);
>=20
> The existing code threw a warning when the counter reached 0. Your
> change will make the potential warning fire later, after we try to put
> the last reference and the counter goes to -1. That's probably fine as
> it should happen later in this function either way.

The code in refcount_dec() contains:

	if (unlikely(old <=3D 1))
		refcount_warn_saturate(r, REFCOUNT_DEC_LEAK);

NeilBrown

>=20
> >  		goto wait_for_construction;
> >  	}
> > =20
> >=20
> > base-commit: 7fa861d5df402b2327f45e0240c1b842f71fec11
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20



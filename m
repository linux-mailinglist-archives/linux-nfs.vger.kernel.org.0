Return-Path: <linux-nfs+bounces-4881-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868F93087A
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 06:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF13E1C20B09
	for <lists+linux-nfs@lfdr.de>; Sun, 14 Jul 2024 04:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454DD53E;
	Sun, 14 Jul 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HggCK/Cq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VdVqeC+W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HggCK/Cq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VdVqeC+W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E334DDAD;
	Sun, 14 Jul 2024 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720931519; cv=none; b=H8/5MCMeFhtYJq8VCkLCBQLrUQbr+NFAaL70O7uRC5WiRF9n3Rgw5HOtZV90jyvPz5DKmmUwn8z2o6sfl9q17ljbeW1dwSyt4xmUVGZCvzxGnrx6+lGZt81oeKp4ox7tjJXrW2xB4pZyyB16s4y48Xh7AYQkUI4G/7t+rzEYMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720931519; c=relaxed/simple;
	bh=Tai56idA7i3ldOTVzpBFhTodct2uYIBVu3ZEmedXFo0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Kfd91fdq+Pkyc2CECnXzaeixuSn2T17ZOO4Kw7/B9Qa5oWclr9GIXP5eXOCea4WjZTS2Ek6GuXb3s+00tcxkPmn+aUqWOnyEAn9yb969zPeqCT/UyYJTZ6LumadEocdfkUfHsVhg/g0rHqyNEL2IEOso5k8E9ZB93kh0MOJfVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HggCK/Cq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VdVqeC+W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HggCK/Cq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VdVqeC+W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85A201F38E;
	Sun, 14 Jul 2024 04:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720931515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUwGToKKARtiAo8j0bi3ivVl6DF2GFyT069klfBDpIM=;
	b=HggCK/CqMvnNvwIUEM4hn9BDytejEkTq2fz7y994rAxiIh2LImDtQ5HssG2JmpNir72+4F
	bYJ+oBYRQyfAhxuEVXQnv8p8ISJniF2C9F2omlOHdgEvWH9Z6pw1xq3/asXt8AxdBvrov/
	8DTrjKda8axWuPzIfXuexDaTzLE3m14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720931515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUwGToKKARtiAo8j0bi3ivVl6DF2GFyT069klfBDpIM=;
	b=VdVqeC+WMs8fVjH00Bqi6cMwuzIYcPEkoaNzgaVePuLrSzZCLdCaZZs13exsQZ+ixmk+Lc
	mqSdOrDI+YMhCNBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="HggCK/Cq";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VdVqeC+W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720931515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUwGToKKARtiAo8j0bi3ivVl6DF2GFyT069klfBDpIM=;
	b=HggCK/CqMvnNvwIUEM4hn9BDytejEkTq2fz7y994rAxiIh2LImDtQ5HssG2JmpNir72+4F
	bYJ+oBYRQyfAhxuEVXQnv8p8ISJniF2C9F2omlOHdgEvWH9Z6pw1xq3/asXt8AxdBvrov/
	8DTrjKda8axWuPzIfXuexDaTzLE3m14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720931515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUwGToKKARtiAo8j0bi3ivVl6DF2GFyT069klfBDpIM=;
	b=VdVqeC+WMs8fVjH00Bqi6cMwuzIYcPEkoaNzgaVePuLrSzZCLdCaZZs13exsQZ+ixmk+Lc
	mqSdOrDI+YMhCNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB639137AC;
	Sun, 14 Jul 2024 04:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uSPYG7ZUk2bEeQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 14 Jul 2024 04:31:50 +0000
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
Cc: "Gaosheng Cui" <cuigaosheng1@huawei.com>, trondmy@kernel.org,
 anna@kernel.org, jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com,
 tom@talpey.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH -next,v2] gss_krb5: refactor code to return correct
 PTR_ERR in krb5_DK
In-reply-to: <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
References: <>, <ZpE9luTCrUnh8RBH@tissot.1015granger.net>
Date: Sun, 14 Jul 2024 14:31:42 +1000
Message-id: <172093150291.15471.15426043640692195014@noble.neil.brown.name>
X-Rspamd-Queue-Id: 85A201F38E
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Sat, 13 Jul 2024, Chuck Lever wrote:
> On Fri, Jul 12, 2024 at 09:39:08AM -0400, Chuck Lever wrote:
> > On Fri, Jul 12, 2024 at 03:24:23PM +0800, Gaosheng Cui wrote:
> > > Refactor the code in krb5_DK to return PTR_ERR when an error occurs.
> >=20
> > My understanding of the current code is that if either
> > crypto_alloc_sync_skcipher() or crypto_sync_skcipher_blocksize()
> > fails, then krb5_DK() returns -EINVAL. At the only call site for
> > krb5_DK(), that return code is unconditionally discarded. Thus I
> > don't see that the proposed change is necessary or improves
> > anything.
>=20
> My understanding is wrong  ;-)

True, but I think your conclusion was correct.

krb5_DK() returns zero or -EINVAL.
It is only used by krb5_derive_key_v2(), which returns zero or -EINVAL,
or -ENOMEM.

krb4_derive_key_v2() is only used as a ->derive_key() method.
This is called from krb5_derive_key(), and various unit tests in
gss_krb5_tests.c

krb5_derive_key() is only called in gss_krb5_mech.c, and each call site
is of the form:
  if (krb5_derive_key(...)) goto out;
so it doesn't matter what error is returned.

The unit test calls are all followed by
	KUNIT_ASSERT_EQ(test, err, 0);
so the only place the err is used is (presumably) in failure reports
from the unit tests.

So the proposed change seems unnecessary from a practical perspective.

Maybe it is justified from an aesthetic perspective, but I think that
should be clearly stated in the commit message.  e.g.

  This change has no practical effect as all non-zero error statuses
  are treated equally, however the distinction between EINVAL and ENOMEM
  may be relevant at some future time and it seems cleaner to maintain
  the distinction.

NeilBrown


>=20
> The return code isn't discarded. A non-zero return code from
> krb5_DK() is carried back up the call stack. The logic in
> krb5_derive_key_v2() does not use the kernel's usual error flow
> form, so I missed this.
>=20
> However, it still isn't clear to me why the error behavior here
> needs to change. It's possible, for example, that -EINVAL is
> perfectly adequate to indicate when sync_skcipher() can't find the
> specified encryption algorithm (gk5e->encrypt_name).
>=20
> Specifying the wrong encryption type: -EINVAL. That makes sense.
>=20
>=20
> > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > > ---
> > > v2: Update IS_ERR to PTR_ERR, thanks very much!
> > >  net/sunrpc/auth_gss/gss_krb5_keys.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/=
gss_krb5_keys.c
> > > index 4eb19c3a54c7..5ac8d06ab2c0 100644
> > > --- a/net/sunrpc/auth_gss/gss_krb5_keys.c
> > > +++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
> > > @@ -164,10 +164,14 @@ static int krb5_DK(const struct gss_krb5_enctype =
*gk5e,
> > >  		goto err_return;
> > > =20
> > >  	cipher =3D crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
> > > -	if (IS_ERR(cipher))
> > > +	if (IS_ERR(cipher)) {
> > > +		ret =3D PTR_ERR(cipher);
> > >  		goto err_return;
> > > +	}
> > > +
> > >  	blocksize =3D crypto_sync_skcipher_blocksize(cipher);
> > > -	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
> > > +	ret =3D crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len);
> > > +	if (ret)
> > >  		goto err_free_cipher;
> > > =20
> > >  	ret =3D -ENOMEM;
> > > --=20
> > > 2.25.1
> > >=20
> >=20
> > --=20
> > Chuck Lever
> >=20
>=20
> --=20
> Chuck Lever
>=20



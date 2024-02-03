Return-Path: <linux-nfs+bounces-1724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5733A847DE7
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 01:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA191F2C99D
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Feb 2024 00:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1327E1369;
	Sat,  3 Feb 2024 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K1VW26R3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aH+rG5FA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GdPDP94m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5cM1fJFk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC2110B;
	Sat,  3 Feb 2024 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920553; cv=none; b=iHDazWz7+aC5qpE22Gg+OOAS9W7JzGnMy2ZvbMTip3kUxVXMcqnicOzv/ChAcQAEHSnZXC0a1U4Kh7UX6Y17BM/oZgTI10LOXWFhLF95jJUPpo1uYb1LJHwvJfqgpXHmzu6cmXC52L8LoQBXela8YRw1o4w5jK+QX1xrCeXxiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920553; c=relaxed/simple;
	bh=o3f8WBHFtsQSTs4pXd9D36LO7t0naP/Qwbn3G+gDoig=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kLRSyHcxuRe1nRTEfy5RCGKO9eWWBf741ArQywgSJza8yjUjVsMNfHNw6kbBtsaCXLle9uPmhTgsFLa2M2IWUQ+RqokJrtTgwdcq4XsVhFs6DXqh0kuJZ7xs/2OkQL+K3PJBdfRoQ1RViYkdjlmB10nUWgzWh7Vn6rT4+eRb0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K1VW26R3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aH+rG5FA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GdPDP94m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5cM1fJFk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E8EC1FD3F;
	Sat,  3 Feb 2024 00:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706920549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sybcZS63K+eW38EtNX7+G+dxH5WoMhRzCbG90F954k=;
	b=K1VW26R3Juv1LGEMyV049BTxT7iEe0SErCjB4ROiHsFstp/iAI5UIUEAWIDqPCPMm6kOWi
	19xPNJ6R9lAUdNxl9ilZdqfF4g9B0ng/EFm08JBNyws5WkhdUZsgeXpaburIiDd8qF3dLv
	9AK9on1KT5jyDYHaDPHYIB0sDe3seGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706920549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sybcZS63K+eW38EtNX7+G+dxH5WoMhRzCbG90F954k=;
	b=aH+rG5FAwNbmY00TerGQotgdu6Qlc2eC/TwxJorSSLfOKptDN+7RWqpX7KzsgaD7ACC8Jc
	yDeagzxOOhjcTcAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706920547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sybcZS63K+eW38EtNX7+G+dxH5WoMhRzCbG90F954k=;
	b=GdPDP94mcxDh8841dBdZb7vr9WN3FkHX14QMyl+WyjCpKcVuocrkGWrr8g5ooPn5zdiA+h
	RKet6c00gGJnthTuW8qUmOD91kmaw8GWqAm10wKw+bwmATFgnWcUXYknBBZg/TBmFyxvGJ
	Ll+tZiBoVjv94FoUIm8uaeQs7ZVLp54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706920547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sybcZS63K+eW38EtNX7+G+dxH5WoMhRzCbG90F954k=;
	b=5cM1fJFkS56O934lIPlsUkOfB3DYYQPsQpK0urRl4VsLKr5jhPz/t7LlRHANI264p+ez34
	+erx3VkCi2CO8BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A21213A58;
	Sat,  3 Feb 2024 00:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G2utAGCKvWUdKwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 03 Feb 2024 00:35:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Benjamin Coddington" <bcodding@redhat.com>
Cc: "Kunwu Chan" <chentao@kylinos.cn>, chuck.lever@oracle.com,
 jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Simplify the allocation of slab caches in
 nfsd_drc_slab_create
In-reply-to: <94F7DA15-6D4C-4205-9A23-E4593A4A2312@redhat.com>
References: <20240201081935.200031-1-chentao@kylinos.cn>,
 <94F7DA15-6D4C-4205-9A23-E4593A4A2312@redhat.com>
Date: Sat, 03 Feb 2024 11:35:41 +1100
Message-id: <170692054137.13976.14338822289976654430@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.63
X-Spamd-Result: default: False [-1.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.33)[75.81%]
X-Spam-Flag: NO

On Sat, 03 Feb 2024, Benjamin Coddington wrote:
> On 1 Feb 2024, at 3:19, Kunwu Chan wrote:
>=20
> > Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> > to simplify the creation of SLAB caches.
> > Make the code cleaner and more readable.
> >
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >  fs/nfsd/nfscache.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> > index 5c1a4a0aa605..64ce0cc22197 100644
> > --- a/fs/nfsd/nfscache.c
> > +++ b/fs/nfsd/nfscache.c
> > @@ -166,8 +166,7 @@ nfsd_reply_cache_free(struct nfsd_drc_bucket *b, stru=
ct nfsd_cacherep *rp,
> >
> >  int nfsd_drc_slab_create(void)
> >  {
> > -	drc_slab =3D kmem_cache_create("nfsd_drc",
> > -				sizeof(struct nfsd_cacherep), 0, 0, NULL);
> > +	drc_slab =3D KMEM_CACHE(nfsd_cacherep, 0);
> >  	return drc_slab ? 0: -ENOMEM;
> >  }
> >
> > --=20
> > 2.39.2
>=20
> I don't agree that the code is cleaner or more readable like this.  I really
> dislike having to parse through the extra "simplification" to see what's
> actually being called and sent.
>=20
> Just my .02 worth.
>=20

In general I agree that wrappers like this can hinder as much as they
help - if not more.

In this particular case it doesn't seem to bother me.  This is probably
because it is only used in initialisation code and I don't look at that
nearly as much as code that uses the initialised things.
Initialisation/cleanup code often has a lot of boilerplate which can
make it look messy.  Reducing that, which I think this patch helps with,
can be a good thing.

So I agree that we should be cautious about using (or creating) new
wrapper macros, but in this case I am mildly in favour.

Thanks,
NeilBrown


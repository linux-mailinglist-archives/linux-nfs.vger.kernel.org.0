Return-Path: <linux-nfs+bounces-670-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720768157E1
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 06:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDEE1F25EAC
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 05:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D237125A4;
	Sat, 16 Dec 2023 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oKB1G3G8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R1vD17Wr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oKB1G3G8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R1vD17Wr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22217731;
	Sat, 16 Dec 2023 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF9E21E77;
	Sat, 16 Dec 2023 05:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702706011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSGP6I8Ny4OeE7XmI3QQ1QBFHyKnDzH7eeoRkwZqFOM=;
	b=oKB1G3G8HeLTqaN9tm0hfaNUGJJN0KYA7gnHixOBz3qtXADal9sw93FB8i2xeAs7slkME1
	Hsw010R9pZd5gmvbGTH4RhflIeiHf3ep2/ogz+EDmf2RLlMWQCiYrj0vcy7EUkehsyqqm0
	//vPbf4rIErOAOZw8c1MTrro0rGEJYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702706011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSGP6I8Ny4OeE7XmI3QQ1QBFHyKnDzH7eeoRkwZqFOM=;
	b=R1vD17Wr3gMiuQ3jYZCh8zNkFimr9RaTJlrA2ZcgHdb/OfhERUfbTgRAG0QMyAkp28emIp
	UfQXMseGb0F1r3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702706011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSGP6I8Ny4OeE7XmI3QQ1QBFHyKnDzH7eeoRkwZqFOM=;
	b=oKB1G3G8HeLTqaN9tm0hfaNUGJJN0KYA7gnHixOBz3qtXADal9sw93FB8i2xeAs7slkME1
	Hsw010R9pZd5gmvbGTH4RhflIeiHf3ep2/ogz+EDmf2RLlMWQCiYrj0vcy7EUkehsyqqm0
	//vPbf4rIErOAOZw8c1MTrro0rGEJYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702706011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSGP6I8Ny4OeE7XmI3QQ1QBFHyKnDzH7eeoRkwZqFOM=;
	b=R1vD17Wr3gMiuQ3jYZCh8zNkFimr9RaTJlrA2ZcgHdb/OfhERUfbTgRAG0QMyAkp28emIp
	UfQXMseGb0F1r3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD491373E;
	Sat, 16 Dec 2023 05:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LYMDIVY7fWWXOQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 16 Dec 2023 05:53:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Ahelenia =?utf-8?q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sunrpc: sizeof('\0') is 4, not 1
In-reply-to:
 <ikgsiev777wvypqueii5mcshrdeftme22stfvztonxbvcrf35l@tarta.nabijaczleweli.xyz>
References: =?utf-8?q?=3C4zlmy3qwneijnrsbygfr2wbsnvdvcgvjyvudqnuxq5zvwmyaof?=
 =?utf-8?q?=40tarta=2Enabijaczleweli=2Exyz=3E=2C?=
 <170270083607.12910.2219100479356858889@noble.neil.brown.name>,
 <ikgsiev777wvypqueii5mcshrdeftme22stfvztonxbvcrf35l@tarta.nabijaczleweli.xyz>
Date: Sat, 16 Dec 2023 16:53:23 +1100
Message-id: <170270600360.12910.7954602598238459243@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[40.71%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Sat, 16 Dec 2023, Ahelenia Ziemia=C5=84ska wrote:
> On Sat, Dec 16, 2023 at 03:27:16PM +1100, NeilBrown wrote:
> > On Sat, 16 Dec 2023, Ahelenia Ziemia=C5=84ska wrote:
> > > To make it self-documenting, the referenced commit added the space
> > > for the null terminator as sizeof('\0'). The message elaborates on
> > > why only one byte is needed, so this is clearly a mistake.
> > > Spell it as 1 /* NUL */ instead.
> > >=20
> > > Fixes: commit 1e360a60b24a ("SUNRPC: Address  buffer overrun in
> > >  rpc_uaddr2sockaddr()")
> > It isn't clear to me that "Fixes" is appropriate as that patch isn't
> > harmful, just confused and sub-optimal.
> I definitely agree, I don't like Fixes here at all,
> but I don't really see another trailer in the documentation
> or in the log that could be used for this.
>=20

Make up a new Trailer?=20

I would probably just write

 To make it self-documenting,
   commit 1e360a60b24a ("SUNRPC: Address  buffer overrun in rpc_uaddr2sockadd=
r()")
 added the space for the null terminator as sizeof('\0') which is 4.  The com=
mit
 elaborates on  why only one byte is needed, so this is clearly a mistake.
 Spell it as 1 /* NUL */ instead.
=20
NeilBrown


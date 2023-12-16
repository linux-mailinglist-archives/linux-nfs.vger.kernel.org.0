Return-Path: <linux-nfs+bounces-668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD1815763
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 05:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DEA1C241AB
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Dec 2023 04:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF44C10A19;
	Sat, 16 Dec 2023 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="um2B1+nE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9mNKMGOO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="um2B1+nE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9mNKMGOO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5012B79;
	Sat, 16 Dec 2023 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B848C1FB52;
	Sat, 16 Dec 2023 04:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702700843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVonS9Qbmg0CjZt9IXuSbKCZuLqQBZLFqpMi/pkw/e0=;
	b=um2B1+nEHW2ESlTOmBsIvZHBuJ4CVmM5v0+iHcYZCYz9X9nGcs4wbElweVYGqi3qDjnwms
	Ly637NlXoFdEP3L8ujKXXPn6QFJgH7T1fp/VZwOsClDGL84g05tN336MttQ08a58Ks2E1/
	pTH8u1ex26g+uKAx7aw8hFGIYxyXBr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702700843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVonS9Qbmg0CjZt9IXuSbKCZuLqQBZLFqpMi/pkw/e0=;
	b=9mNKMGOOzX8lBWzxpIwfPbdCoUdo0RyCGtvFPWzMPUfHtiBmXW2d8lPbrP549aEKwOrbl7
	UoEzhp55A1ZyBXCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702700843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVonS9Qbmg0CjZt9IXuSbKCZuLqQBZLFqpMi/pkw/e0=;
	b=um2B1+nEHW2ESlTOmBsIvZHBuJ4CVmM5v0+iHcYZCYz9X9nGcs4wbElweVYGqi3qDjnwms
	Ly637NlXoFdEP3L8ujKXXPn6QFJgH7T1fp/VZwOsClDGL84g05tN336MttQ08a58Ks2E1/
	pTH8u1ex26g+uKAx7aw8hFGIYxyXBr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702700843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVonS9Qbmg0CjZt9IXuSbKCZuLqQBZLFqpMi/pkw/e0=;
	b=9mNKMGOOzX8lBWzxpIwfPbdCoUdo0RyCGtvFPWzMPUfHtiBmXW2d8lPbrP549aEKwOrbl7
	UoEzhp55A1ZyBXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E21F13AC1;
	Sat, 16 Dec 2023 04:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G0GtLSYnfWWzJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 16 Dec 2023 04:27:18 +0000
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
 <4zlmy3qwneijnrsbygfr2wbsnvdvcgvjyvudqnuxq5zvwmyaof@tarta.nabijaczleweli.xyz>
References:
 <4zlmy3qwneijnrsbygfr2wbsnvdvcgvjyvudqnuxq5zvwmyaof@tarta.nabijaczleweli.xyz>
Date: Sat, 16 Dec 2023 15:27:16 +1100
Message-id: <170270083607.12910.2219100479356858889@noble.neil.brown.name>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.51)[91.79%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=um2B1+nE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9mNKMGOO
X-Spam-Score: -1.82
X-Rspamd-Queue-Id: B848C1FB52

On Sat, 16 Dec 2023, Ahelenia Ziemia=C5=84ska wrote:
> To make it self-documenting, the referenced commit added the space
> for the null terminator as sizeof('\0'). The message elaborates on
> why only one byte is needed, so this is clearly a mistake.
> Spell it as 1 /* NUL */ instead.
>=20
> This is the only result for git grep "sizeof.'" in the tree.
>=20
> Fixes: commit 1e360a60b24a ("SUNRPC: Address  buffer overrun in
>  rpc_uaddr2sockaddr()")

It isn't clear to me that "Fixes" is appropriate as that patch isn't
harmful, just confused and sub-optimal.
But it probably doesn't mattter.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown



> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
> ---
>  net/sunrpc/addr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
> index d435bffc6199..c4ba342f6866 100644
> --- a/net/sunrpc/addr.c
> +++ b/net/sunrpc/addr.c
> @@ -311,7 +311,7 @@ size_t rpc_uaddr2sockaddr(struct net *net, const char *=
uaddr,
>  			  const size_t uaddr_len, struct sockaddr *sap,
>  			  const size_t salen)
>  {
> -	char *c, buf[RPCBIND_MAXUADDRLEN + sizeof('\0')];
> +	char *c, buf[RPCBIND_MAXUADDRLEN + 1 /* NUL */];
>  	u8 portlo, porthi;
>  	unsigned short port;
> =20
>=20
> base-commit: 26aff849438cebcd05f1a647390c4aa700d5c0f1
> --=20
> 2.39.2
>=20



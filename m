Return-Path: <linux-nfs+bounces-6620-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4676983912
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 23:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4C91F21BAC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Sep 2024 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C31839F4;
	Mon, 23 Sep 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BiVPcTPV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RthMSAos";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BiVPcTPV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RthMSAos"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420E7F7DB;
	Mon, 23 Sep 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126670; cv=none; b=m8DZIyqk0j9A78EHb95SQtA7DOEmUkwX4Ui61kdV96FgzXbbJZMAJKq2H6o7AHDAxY3yqH4mJtbi8WqCJiNHxsbD5gtGwQZ1JCbGNMvCAwg6dw4hhZFX6z2Ism404Hf1FHOnE9jYqDCff4xanElC9cJAxtz5IPAVL8YSBonJIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126670; c=relaxed/simple;
	bh=DWT9LTgTwgl3oI2zR0kqC0LrGcG2j48l8BSn+c9QYPw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HJoYNeKIhrv3WzQgOIVh3KR4tTNMkAqPUYTg8SV0Xl7C8lMh5JHKZ/4LyJX13T9WW55iPFMHbyUFqyD4RTnWVxZyGN9sKWdCt5JaRv5Li1BjjcYvzgxGTQOJ5h0yt8C15AbaefsfLK4Hcd6gkg1pWfdNL1OiZrX4F6QVE+i0oGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BiVPcTPV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RthMSAos; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BiVPcTPV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RthMSAos; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A88F421CAC;
	Mon, 23 Sep 2024 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727126666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6jB3NjLBHp1Hb3SCVME9sYqKJRwKArJJM5yKt3AWpM=;
	b=BiVPcTPVQQOXadtEkCT6qpOsPvatJsvHeHJGVFZGRFRwU2qceGX9Yge1cBgUxEaI9WXnzd
	ZZgoiHBRr2Z6DlnKdhYroQCZ459mSFYnoTq4wtN3q4g4A90d+Iv3AYOgUHNvD+x6Sq2XoD
	i1A1/nu3HKTiXC76YqB18jXM/yeHCuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727126666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6jB3NjLBHp1Hb3SCVME9sYqKJRwKArJJM5yKt3AWpM=;
	b=RthMSAoskmprqIuYzWJ0v2jTh7zRz6HFj8WbgEEo3NdElLavWk5mHRDUoD06JTlUzZ3F7E
	qY1/qrXn6ICjawCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BiVPcTPV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RthMSAos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727126666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6jB3NjLBHp1Hb3SCVME9sYqKJRwKArJJM5yKt3AWpM=;
	b=BiVPcTPVQQOXadtEkCT6qpOsPvatJsvHeHJGVFZGRFRwU2qceGX9Yge1cBgUxEaI9WXnzd
	ZZgoiHBRr2Z6DlnKdhYroQCZ459mSFYnoTq4wtN3q4g4A90d+Iv3AYOgUHNvD+x6Sq2XoD
	i1A1/nu3HKTiXC76YqB18jXM/yeHCuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727126666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6jB3NjLBHp1Hb3SCVME9sYqKJRwKArJJM5yKt3AWpM=;
	b=RthMSAoskmprqIuYzWJ0v2jTh7zRz6HFj8WbgEEo3NdElLavWk5mHRDUoD06JTlUzZ3F7E
	qY1/qrXn6ICjawCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4C671347F;
	Mon, 23 Sep 2024 21:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HHOTIYXc8WYCUwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 23 Sep 2024 21:24:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mirsad Todorovac" <mtodorovac69@gmail.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Mirsad Todorovac" <mtodorovac69@gmail.com>
Subject: Re: [PATCH v1 1/1] SUNRPC: Make enough room in servername[] for
 AF_UNIX addresses
In-reply-to: <20240923205545.1488448-2-mtodorovac69@gmail.com>
References: <20240923205545.1488448-2-mtodorovac69@gmail.com>
Date: Tue, 24 Sep 2024 07:24:10 +1000
Message-id: <172712665050.17050.14126694149839508223@noble.neil.brown.name>
X-Rspamd-Queue-Id: A88F421CAC
X-Spam-Score: -6.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,kernel.org,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,davemloft.net:email,talpey.com:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
> GCC 13.2.0 reported with W=3D1 build option the following warning:

See
  https://lore.kernel.org/all/20240814093853.48657-1-kunwu.chan@linux.dev/

I don't think anyone really cares about this one.

NeilBrown


>=20
> net/sunrpc/clnt.c: In function =E2=80=98rpc_create=E2=80=99:
> net/sunrpc/clnt.c:582:75: warning: =E2=80=98%s=E2=80=99 directive output ma=
y be truncated writing up to 107 bytes into \
> 					a region of size 48 [-Wformat-truncation=3D]
>   582 |                                 snprintf(servername, sizeof(servern=
ame), "%s",
>       |                                                                    =
       ^~
> net/sunrpc/clnt.c:582:33: note: =E2=80=98snprintf=E2=80=99 output between 1=
 and 108 bytes into a destination of size 48
>   582 |                                 snprintf(servername, sizeof(servern=
ame), "%s",
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
>   583 |                                          sun->sun_path);
>       |                                          ~~~~~~~~~~~~~~
>=20
>    548         };
>  =E2=86=92 549         char servername[48];
>    550         struct rpc_clnt *clnt;
>    551         int i;
>    552
>    553         if (args->bc_xprt) {
>    554                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC));
>    555                 xprt =3D args->bc_xprt->xpt_bc_xprt;
>    556                 if (xprt) {
>    557                         xprt_get(xprt);
>    558                         return rpc_create_xprt(args, xprt);
>    559                 }
>    560         }
>    561
>    562         if (args->flags & RPC_CLNT_CREATE_INFINITE_SLOTS)
>    563                 xprtargs.flags |=3D XPRT_CREATE_INFINITE_SLOTS;
>    564         if (args->flags & RPC_CLNT_CREATE_NO_IDLE_TIMEOUT)
>    565                 xprtargs.flags |=3D XPRT_CREATE_NO_IDLE_TIMEOUT;
>    566         /*
>    567          * If the caller chooses not to specify a hostname, whip
>    568          * up a string representation of the passed-in address.
>    569          */
>    570         if (xprtargs.servername =3D=3D NULL) {
>    571                 struct sockaddr_un *sun =3D
>    572                                 (struct sockaddr_un *)args->address;
>    573                 struct sockaddr_in *sin =3D
>    574                                 (struct sockaddr_in *)args->address;
>    575                 struct sockaddr_in6 *sin6 =3D
>    576                                 (struct sockaddr_in6 *)args->address;
>    577
>    578                 servername[0] =3D '\0';
>    579                 switch (args->address->sa_family) {
>  =E2=86=92 580                 case AF_LOCAL:
>  =E2=86=92 581                         if (sun->sun_path[0])
>  =E2=86=92 582                                 snprintf(servername, sizeof(=
servername), "%s",
>  =E2=86=92 583                                          sun->sun_path);
>  =E2=86=92 584                         else
>  =E2=86=92 585                                 snprintf(servername, sizeof(=
servername), "@%s",
>  =E2=86=92 586                                          sun->sun_path+1);
>  =E2=86=92 587                         break;
>    588                 case AF_INET:
>    589                         snprintf(servername, sizeof(servername), "%p=
I4",
>    590                                  &sin->sin_addr.s_addr);
>    591                         break;
>    592                 case AF_INET6:
>    593                         snprintf(servername, sizeof(servername), "%p=
I6",
>    594                                  &sin6->sin6_addr);
>    595                         break;
>    596                 default:
>    597                         /* caller wants default server name, but
>    598                          * address family isn't recognized. */
>    599                         return ERR_PTR(-EINVAL);
>    600                 }
>    601                 xprtargs.servername =3D servername;
>    602         }
>    603
>    604         xprt =3D xprt_create_transport(&xprtargs);
>    605         if (IS_ERR(xprt))
>    606                 return (struct rpc_clnt *)xprt;
>=20
> After the address family AF_LOCAL was added in the commit 176e21ee2ec89, th=
e old hard-coded
> size for servername of char servername[48] no longer fits. The maximum AF_U=
NIX address size
> has now grown to UNIX_PATH_MAX defined as 108 in "include/uapi/linux/un.h" .
>=20
> The lines 580-587 were added later, addressing the leading zero byte '\0', =
but did not fix
> the hard-coded servername limit.
>=20
> The AF_UNIX address was truncated to 47 bytes + terminating null byte. This=
 patch will fix the
> servername in AF_UNIX family to the maximum permitted by the system:
>=20
>    548         };
>  =E2=86=92 549         char servername[UNIX_PATH_MAX];
>    550         struct rpc_clnt *clnt;
>=20
> Fixes: 4388ce05fa38b ("SUNRPC: support abstract unix socket addresses")
> Fixes: 510deb0d7035d ("SUNRPC: rpc_create() default hostname should support=
 AF_INET6 addresses")
> Fixes: 176e21ee2ec89 ("SUNRPC: Support for RPC over AF_LOCAL transports")
> Cc: Neil Brown <neilb@suse.de>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Olga Kornievskaia <okorniev@redhat.com>
> Cc: Dai Ngo <Dai.Ngo@oracle.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-nfs@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> ---
>  v1:
> 	initial version.
>=20
>  net/sunrpc/clnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 09f29a95f2bc..67099719893e 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *arg=
s)
>  		.connect_timeout =3D args->connect_timeout,
>  		.reconnect_timeout =3D args->reconnect_timeout,
>  	};
> -	char servername[48];
> +	char servername[UNIX_PATH_MAX];
>  	struct rpc_clnt *clnt;
>  	int i;
> =20
> --=20
> 2.43.0
>=20
>=20



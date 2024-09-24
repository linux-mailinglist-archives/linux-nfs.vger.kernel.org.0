Return-Path: <linux-nfs+bounces-6629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4A9843E7
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 12:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C5AB2206A
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF919C568;
	Tue, 24 Sep 2024 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g5N+TQp7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fu6BGl2t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XI75/xVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BPGt5792"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55516F8E5;
	Tue, 24 Sep 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174648; cv=none; b=m3lqSXCjlXGQO5wxp4IGIcnCbhlQ5fU11TCh7yZRf9lsx2kGTQKRYSn6Dx/T5muXUcHHHjCF9mBtfeQIihwtV5JD/0UyyyBggZIkBhTdJnpk9OlzCzc6kMr9cP0StmB5tDRgKTXYGebqbLDnksWRBP7eioCA8dAkjeprdUNTkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174648; c=relaxed/simple;
	bh=WMxrcNg+sUq3BA1tgdk1Wp4wX/DkJ2CSmu7cQFtBiLE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tvnYs4f8yTxAdMSbwe9oFZvVQ+hzobnZh3Eqvnb2NRiyxgZBSDgDWh635juXnlrGn6nJFXalQS901ptGD0LRApqZ5kL2BwY9STEtnoFaqYXY/YxWsxfOAqobhIIQhcCyM9QmfE2/V96kKFEh+oeQ0bav0Vn6yi1IurQmSW+WI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g5N+TQp7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fu6BGl2t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XI75/xVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BPGt5792; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DABFB1F78F;
	Tue, 24 Sep 2024 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727174643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1G1oI8nCSI6zSyJAYdwR6R9b+YdQcBhWN7FoFbzc4o=;
	b=g5N+TQp7X5a0EnMHgl1DVXWuZzQqNxVTzXM0sxXHviEieuKiEeLsNL/duav7ZTm/Arsc2P
	S0bvZzGyqIKPPDIe/hR1FLIYaMJEuIAL4LZ93XfOrcA6IveEajXPo1anJFtryxQycI8Typ
	qx1kFj6KW2mL3j4VfXv3QhLor4djuho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727174643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1G1oI8nCSI6zSyJAYdwR6R9b+YdQcBhWN7FoFbzc4o=;
	b=Fu6BGl2tyxfu+AYsJGJD2DJoTzw85jHasWVwkynvB6XjVYeMOWYsbqgY7CDj8fCWMCZ7fe
	e3P6dKn/7Ya+9oBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="XI75/xVu";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BPGt5792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727174642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1G1oI8nCSI6zSyJAYdwR6R9b+YdQcBhWN7FoFbzc4o=;
	b=XI75/xVu5ffVpaTvAbJRtqRPbrTz1fKPfeZ2ZcBcA0gVKGCtKnBaqd+wZ0vu/rbVJO5zrd
	1pkyg9Gldft9nY69BrsSEjiwn/eOjk2VEkSfqY3d/PkxJ4wwCQRstePItLojosAlqCctlB
	IikZ8CE7eeCOO3a2MipaHfHSqrsavJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727174642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1G1oI8nCSI6zSyJAYdwR6R9b+YdQcBhWN7FoFbzc4o=;
	b=BPGt57929WDQ+Cw2ihwnenrqK8SOhUMUZfXzEb5fBFGltLcW/sHNiTnIGfmHfgArJ4B3Jl
	VuoqfWMIlzZrY4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 228BB1386E;
	Tue, 24 Sep 2024 10:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ypRuMu2X8mZGIwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 24 Sep 2024 10:43:57 +0000
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
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH v1 1/1] SUNRPC: Make enough room in servername[] for
 AF_UNIX addresses
In-reply-to: <b4435709-e112-4667-b458-411856a28389@gmail.com>
References: <>, <b4435709-e112-4667-b458-411856a28389@gmail.com>
Date: Tue, 24 Sep 2024 20:43:50 +1000
Message-id: <172717463033.17050.14835776993804647247@noble.neil.brown.name>
X-Rspamd-Queue-Id: DABFB1F78F
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email,suse.de:dkim,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO

On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
> Hi, Neil,
>=20
> Apparently I was duplicating work.
>=20
> However, using
>=20
> 	char servername[UNIX_PATH_MAX];
>=20
> has some advantages when compared to hard-coded integer?
>=20
> Correct me if I'm wrong.

I think you are wrong.  I agree that 48 is a poor choice.  I think that
UNIX_PATH_MAX is a poor choice too.  The "servername" string is used for
things other than a UNIX socket path.

Did you read all of the thread that I provided a link for?  I suggest a
more meaningful number in one of the later messages.

But I really think that the problem here is the warning.  The servername
array is ALWAYS big enough for any string that will actually be copied
into it.  gcc isn't clever enough to detect that, but it tries to be
clever enough to tell you that even though you used snprintf so you know
that the string might in theory overflow, it decides to warn you about
something you already know.

i.e.  if you want to fix this, I would rather you complain the the
compiler writers.  Or maybe suggest a #pragma to silence the warning in
this case.  Or maybe examine all of the code instead of the one line
that triggers the warning and see if there is a better approach to
providing the functionality that is being provided here.

NeilBrown

>=20
> Best regards,
> Mirsad Todorovac
>=20
> On 9/23/24 23:24, NeilBrown wrote:
> > On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
> >> GCC 13.2.0 reported with W=3D1 build option the following warning:
> >=20
> > See
> >   https://lore.kernel.org/all/20240814093853.48657-1-kunwu.chan@linux.dev/
> >=20
> > I don't think anyone really cares about this one.
> >=20
> > NeilBrown
> >=20
> >=20
> >>
> >> net/sunrpc/clnt.c: In function =E2=80=98rpc_create=E2=80=99:
> >> net/sunrpc/clnt.c:582:75: warning: =E2=80=98%s=E2=80=99 directive output=
 may be truncated writing up to 107 bytes into \
> >> 					a region of size 48 [-Wformat-truncation=3D]
> >>   582 |                                 snprintf(servername, sizeof(serv=
ername), "%s",
> >>       |                                                                 =
          ^~
> >> net/sunrpc/clnt.c:582:33: note: =E2=80=98snprintf=E2=80=99 output betwee=
n 1 and 108 bytes into a destination of size 48
> >>   582 |                                 snprintf(servername, sizeof(serv=
ername), "%s",
> >>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> >>   583 |                                          sun->sun_path);
> >>       |                                          ~~~~~~~~~~~~~~
> >>
> >>    548         };
> >>  =E2=86=92 549         char servername[48];
> >>    550         struct rpc_clnt *clnt;
> >>    551         int i;
> >>    552
> >>    553         if (args->bc_xprt) {
> >>    554                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC=
));
> >>    555                 xprt =3D args->bc_xprt->xpt_bc_xprt;
> >>    556                 if (xprt) {
> >>    557                         xprt_get(xprt);
> >>    558                         return rpc_create_xprt(args, xprt);
> >>    559                 }
> >>    560         }
> >>    561
> >>    562         if (args->flags & RPC_CLNT_CREATE_INFINITE_SLOTS)
> >>    563                 xprtargs.flags |=3D XPRT_CREATE_INFINITE_SLOTS;
> >>    564         if (args->flags & RPC_CLNT_CREATE_NO_IDLE_TIMEOUT)
> >>    565                 xprtargs.flags |=3D XPRT_CREATE_NO_IDLE_TIMEOUT;
> >>    566         /*
> >>    567          * If the caller chooses not to specify a hostname, whip
> >>    568          * up a string representation of the passed-in address.
> >>    569          */
> >>    570         if (xprtargs.servername =3D=3D NULL) {
> >>    571                 struct sockaddr_un *sun =3D
> >>    572                                 (struct sockaddr_un *)args->addre=
ss;
> >>    573                 struct sockaddr_in *sin =3D
> >>    574                                 (struct sockaddr_in *)args->addre=
ss;
> >>    575                 struct sockaddr_in6 *sin6 =3D
> >>    576                                 (struct sockaddr_in6 *)args->addr=
ess;
> >>    577
> >>    578                 servername[0] =3D '\0';
> >>    579                 switch (args->address->sa_family) {
> >>  =E2=86=92 580                 case AF_LOCAL:
> >>  =E2=86=92 581                         if (sun->sun_path[0])
> >>  =E2=86=92 582                                 snprintf(servername, size=
of(servername), "%s",
> >>  =E2=86=92 583                                          sun->sun_path);
> >>  =E2=86=92 584                         else
> >>  =E2=86=92 585                                 snprintf(servername, size=
of(servername), "@%s",
> >>  =E2=86=92 586                                          sun->sun_path+1);
> >>  =E2=86=92 587                         break;
> >>    588                 case AF_INET:
> >>    589                         snprintf(servername, sizeof(servername), =
"%pI4",
> >>    590                                  &sin->sin_addr.s_addr);
> >>    591                         break;
> >>    592                 case AF_INET6:
> >>    593                         snprintf(servername, sizeof(servername), =
"%pI6",
> >>    594                                  &sin6->sin6_addr);
> >>    595                         break;
> >>    596                 default:
> >>    597                         /* caller wants default server name, but
> >>    598                          * address family isn't recognized. */
> >>    599                         return ERR_PTR(-EINVAL);
> >>    600                 }
> >>    601                 xprtargs.servername =3D servername;
> >>    602         }
> >>    603
> >>    604         xprt =3D xprt_create_transport(&xprtargs);
> >>    605         if (IS_ERR(xprt))
> >>    606                 return (struct rpc_clnt *)xprt;
> >>
> >> After the address family AF_LOCAL was added in the commit 176e21ee2ec89,=
 the old hard-coded
> >> size for servername of char servername[48] no longer fits. The maximum A=
F_UNIX address size
> >> has now grown to UNIX_PATH_MAX defined as 108 in "include/uapi/linux/un.=
h" .
> >>
> >> The lines 580-587 were added later, addressing the leading zero byte '\0=
', but did not fix
> >> the hard-coded servername limit.
> >>
> >> The AF_UNIX address was truncated to 47 bytes + terminating null byte. T=
his patch will fix the
> >> servername in AF_UNIX family to the maximum permitted by the system:
> >>
> >>    548         };
> >>  =E2=86=92 549         char servername[UNIX_PATH_MAX];
> >>    550         struct rpc_clnt *clnt;
> >>
> >> Fixes: 4388ce05fa38b ("SUNRPC: support abstract unix socket addresses")
> >> Fixes: 510deb0d7035d ("SUNRPC: rpc_create() default hostname should supp=
ort AF_INET6 addresses")
> >> Fixes: 176e21ee2ec89 ("SUNRPC: Support for RPC over AF_LOCAL transports")
> >> Cc: Neil Brown <neilb@suse.de>
> >> Cc: Chuck Lever <chuck.lever@oracle.com>
> >> Cc: Trond Myklebust <trondmy@kernel.org>
> >> Cc: Anna Schumaker <anna@kernel.org>
> >> Cc: Jeff Layton <jlayton@kernel.org>
> >> Cc: Olga Kornievskaia <okorniev@redhat.com>
> >> Cc: Dai Ngo <Dai.Ngo@oracle.com>
> >> Cc: Tom Talpey <tom@talpey.com>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: linux-nfs@vger.kernel.org
> >> Cc: netdev@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> >> ---
> >>  v1:
> >> 	initial version.
> >>
> >>  net/sunrpc/clnt.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> >> index 09f29a95f2bc..67099719893e 100644
> >> --- a/net/sunrpc/clnt.c
> >> +++ b/net/sunrpc/clnt.c
> >> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *=
args)
> >>  		.connect_timeout =3D args->connect_timeout,
> >>  		.reconnect_timeout =3D args->reconnect_timeout,
> >>  	};
> >> -	char servername[48];
> >> +	char servername[UNIX_PATH_MAX];
> >>  	struct rpc_clnt *clnt;
> >>  	int i;
> >> =20
> >> --=20
> >> 2.43.0
> >>
> >>
> >=20
>=20



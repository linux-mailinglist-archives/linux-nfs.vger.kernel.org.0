Return-Path: <linux-nfs+bounces-6654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A3998686D
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 23:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9702847A5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9E14B95A;
	Wed, 25 Sep 2024 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xpUsuE5/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xiNG4oXt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xpUsuE5/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xiNG4oXt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE013AA5F;
	Wed, 25 Sep 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300560; cv=none; b=iOPYlmxs2uLlDMMQe+Jh+BkVcRV1U3/3ANQ+BjulewBetnSzxgOjt8z7sTPQ9zk9FeJbHENGHLkg+HBnFf28NmvC12vsi5itKc0qEQbWRoqq3re2J7q2s370hZZ/JQha5aSQa0rK355VS2nboBZ/7dhgkw/ucLooG+IrYKRa+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300560; c=relaxed/simple;
	bh=126q55YUZV/3Xh1O8r0ND4c2Pk0+d6vqTIeb+3Gcv+E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BqnEiQIBVXhVW5fMNIXbPUupyLI0AcBPMgVp6u/i71nmeYbhLoH0UXT1v6WAaBtjQGP0rSKeT9RcU0BxbGSEs3efyXJslJGd//81zvgqLeAE36RzTZj/8rK8hlmkyHCzX6i1lyMx0dWtiz3V73uMn+pTi26s7WY3wFESZY85oxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xpUsuE5/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xiNG4oXt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xpUsuE5/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xiNG4oXt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04B011F812;
	Wed, 25 Sep 2024 21:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727300556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5carKJQ5rKkbmC4I/ocpdUvxzjqQzJc4/8j5PFRfPY=;
	b=xpUsuE5/0FWVwmAtDcZm5Cayztgz4pV+9ikWcfMBvpya5M8vlPRKa8J/7K1q2Hb9ImpR02
	uMkYGLmy4jyiZhpZDKdJ1DB2901iEViRKVTOpYdSy48oWGmxycM1h2JSmqWSyhSprRc6fA
	tOuurKpbXS0K4L0RkEBqf7lwU1f7Skk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727300556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5carKJQ5rKkbmC4I/ocpdUvxzjqQzJc4/8j5PFRfPY=;
	b=xiNG4oXtBCpOBodwT5FY9p+OZCgYn8GJncEDpnT8DYmCC9WZFmKYBYjM5g/RSgZOOrcqHM
	8KIVMzVLnm/8GuBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727300556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5carKJQ5rKkbmC4I/ocpdUvxzjqQzJc4/8j5PFRfPY=;
	b=xpUsuE5/0FWVwmAtDcZm5Cayztgz4pV+9ikWcfMBvpya5M8vlPRKa8J/7K1q2Hb9ImpR02
	uMkYGLmy4jyiZhpZDKdJ1DB2901iEViRKVTOpYdSy48oWGmxycM1h2JSmqWSyhSprRc6fA
	tOuurKpbXS0K4L0RkEBqf7lwU1f7Skk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727300556;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5carKJQ5rKkbmC4I/ocpdUvxzjqQzJc4/8j5PFRfPY=;
	b=xiNG4oXtBCpOBodwT5FY9p+OZCgYn8GJncEDpnT8DYmCC9WZFmKYBYjM5g/RSgZOOrcqHM
	8KIVMzVLnm/8GuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7BD713793;
	Wed, 25 Sep 2024 21:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gm5+JsaD9Gb8ZQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 21:42:30 +0000
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
In-reply-to: <1430dbab-0540-448b-b503-e53268f60bfc@gmail.com>
References: <>, <1430dbab-0540-448b-b503-e53268f60bfc@gmail.com>
Date: Thu, 26 Sep 2024 07:42:23 +1000
Message-id: <172730054387.17050.12447592116066223771@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 26 Sep 2024, Mirsad Todorovac wrote:
> On 9/24/24 12:43, NeilBrown wrote:
> > On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
> >> Hi, Neil,
> >>
> >> Apparently I was duplicating work.
> >>
> >> However, using
> >>
> >> 	char servername[UNIX_PATH_MAX];
> >>
> >> has some advantages when compared to hard-coded integer?
> >>
> >> Correct me if I'm wrong.
> >=20
> > I think you are wrong.  I agree that 48 is a poor choice.  I think that
> > UNIX_PATH_MAX is a poor choice too.  The "servername" string is used for
> > things other than a UNIX socket path.
> > Did you read all of the thread that I provided a link for?  I suggest a
> > more meaningful number in one of the later messages.
>=20
> I see. Thanks for the tip. However, if UNIX_PATH_MAX ever changes in the
> future, the decl
>=20
>     char servername[108];
>=20
> might be missed when fixing all the changes caused by the change of the
> macro definition? Am I wrong again?

Realistically UNIX_PATH_MAX is never going to change, and if it did that
would not affect the correctness of this code.

>=20
> Making it logically depend on the system limits might save some headache
> in the future, perhaps.

Unlikely.  Did you look to see what the failure mode is here?
servername is only ever used in log messages.  Truncating names in log
message at 8 bytes can certainly be annoying.  Truncating at 48 bytes is
much less of a problem.


>=20
> If really the biggest string that will be copied there is: "/var/run/rpcbin=
d.sock",
> you are then right - stack space is precious commodity, and allocating
> via kmalloc() might preempt the caller thread.

It might.  But the string is always passed to xprt_create_transport()
which always calls kstrdup() on it.  So maybe that doesn't matter.  (As
I said, understanding the big picture is important).

>=20
> However, you got to this five weeks earlier - but the patch did not
> propagate to the main vanilla torvalds tree.

Actually it has.

Commit 9090a7f78623 ("SUNRPC: Fix -Wformat-truncation warning")

$ git show --format=3Dfuller  9090a7f78623 | grep CommitDate
CommitDate: Mon Sep 23 15:03:13 2024 -0400

Linus merged it=20
Commit 684a64bf32b6 ("Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/p=
rojects/anna/linux-nfs")
Date:   Tue Sep 24 15:44:18 2024 -0700

That patch used RPC_MAXNETNAMELEN which is the least-ugly simple fix.

Thanks for your interest in improving Linux.

NeilBrown

>=20
> Best regards,
> Mirsad Todorovac
>=20
> > But I really think that the problem here is the warning.  The servername
> > array is ALWAYS big enough for any string that will actually be copied
> > into it.  gcc isn't clever enough to detect that, but it tries to be
> > clever enough to tell you that even though you used snprintf so you know
> > that the string might in theory overflow, it decides to warn you about
> > something you already know.
> >=20
> > i.e.  if you want to fix this, I would rather you complain the the
> > compiler writers.  Or maybe suggest a #pragma to silence the warning in
> > this case.  Or maybe examine all of the code instead of the one line
> > that triggers the warning and see if there is a better approach to
> > providing the functionality that is being provided here.
> >=20
> > NeilBrown
> >=20
> >>
> >> Best regards,
> >> Mirsad Todorovac
> >>
> >> On 9/23/24 23:24, NeilBrown wrote:
> >>> On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
> >>>> GCC 13.2.0 reported with W=3D1 build option the following warning:
> >>>
> >>> See
> >>>   https://lore.kernel.org/all/20240814093853.48657-1-kunwu.chan@linux.d=
ev/
> >>>
> >>> I don't think anyone really cares about this one.
> >>>
> >>> NeilBrown
> >>>
> >>>
> >>>>
> >>>> net/sunrpc/clnt.c: In function =E2=80=98rpc_create=E2=80=99:
> >>>> net/sunrpc/clnt.c:582:75: warning: =E2=80=98%s=E2=80=99 directive outp=
ut may be truncated writing up to 107 bytes into \
> >>>> 					a region of size 48 [-Wformat-truncation=3D]
> >>>>   582 |                                 snprintf(servername, sizeof(se=
rvername), "%s",
> >>>>       |                                                               =
            ^~
> >>>> net/sunrpc/clnt.c:582:33: note: =E2=80=98snprintf=E2=80=99 output betw=
een 1 and 108 bytes into a destination of size 48
> >>>>   582 |                                 snprintf(servername, sizeof(se=
rvername), "%s",
> >>>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~
> >>>>   583 |                                          sun->sun_path);
> >>>>       |                                          ~~~~~~~~~~~~~~
> >>>>
> >>>>    548         };
> >>>>  =E2=86=92 549         char servername[48];
> >>>>    550         struct rpc_clnt *clnt;
> >>>>    551         int i;
> >>>>    552
> >>>>    553         if (args->bc_xprt) {
> >>>>    554                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_=
BC));
> >>>>    555                 xprt =3D args->bc_xprt->xpt_bc_xprt;
> >>>>    556                 if (xprt) {
> >>>>    557                         xprt_get(xprt);
> >>>>    558                         return rpc_create_xprt(args, xprt);
> >>>>    559                 }
> >>>>    560         }
> >>>>    561
> >>>>    562         if (args->flags & RPC_CLNT_CREATE_INFINITE_SLOTS)
> >>>>    563                 xprtargs.flags |=3D XPRT_CREATE_INFINITE_SLOTS;
> >>>>    564         if (args->flags & RPC_CLNT_CREATE_NO_IDLE_TIMEOUT)
> >>>>    565                 xprtargs.flags |=3D XPRT_CREATE_NO_IDLE_TIMEOUT;
> >>>>    566         /*
> >>>>    567          * If the caller chooses not to specify a hostname, whip
> >>>>    568          * up a string representation of the passed-in address.
> >>>>    569          */
> >>>>    570         if (xprtargs.servername =3D=3D NULL) {
> >>>>    571                 struct sockaddr_un *sun =3D
> >>>>    572                                 (struct sockaddr_un *)args->add=
ress;
> >>>>    573                 struct sockaddr_in *sin =3D
> >>>>    574                                 (struct sockaddr_in *)args->add=
ress;
> >>>>    575                 struct sockaddr_in6 *sin6 =3D
> >>>>    576                                 (struct sockaddr_in6 *)args->ad=
dress;
> >>>>    577
> >>>>    578                 servername[0] =3D '\0';
> >>>>    579                 switch (args->address->sa_family) {
> >>>>  =E2=86=92 580                 case AF_LOCAL:
> >>>>  =E2=86=92 581                         if (sun->sun_path[0])
> >>>>  =E2=86=92 582                                 snprintf(servername, si=
zeof(servername), "%s",
> >>>>  =E2=86=92 583                                          sun->sun_path);
> >>>>  =E2=86=92 584                         else
> >>>>  =E2=86=92 585                                 snprintf(servername, si=
zeof(servername), "@%s",
> >>>>  =E2=86=92 586                                          sun->sun_path+=
1);
> >>>>  =E2=86=92 587                         break;
> >>>>    588                 case AF_INET:
> >>>>    589                         snprintf(servername, sizeof(servername)=
, "%pI4",
> >>>>    590                                  &sin->sin_addr.s_addr);
> >>>>    591                         break;
> >>>>    592                 case AF_INET6:
> >>>>    593                         snprintf(servername, sizeof(servername)=
, "%pI6",
> >>>>    594                                  &sin6->sin6_addr);
> >>>>    595                         break;
> >>>>    596                 default:
> >>>>    597                         /* caller wants default server name, but
> >>>>    598                          * address family isn't recognized. */
> >>>>    599                         return ERR_PTR(-EINVAL);
> >>>>    600                 }
> >>>>    601                 xprtargs.servername =3D servername;
> >>>>    602         }
> >>>>    603
> >>>>    604         xprt =3D xprt_create_transport(&xprtargs);
> >>>>    605         if (IS_ERR(xprt))
> >>>>    606                 return (struct rpc_clnt *)xprt;
> >>>>
> >>>> After the address family AF_LOCAL was added in the commit 176e21ee2ec8=
9, the old hard-coded
> >>>> size for servername of char servername[48] no longer fits. The maximum=
 AF_UNIX address size
> >>>> has now grown to UNIX_PATH_MAX defined as 108 in "include/uapi/linux/u=
n.h" .
> >>>>
> >>>> The lines 580-587 were added later, addressing the leading zero byte '=
\0', but did not fix
> >>>> the hard-coded servername limit.
> >>>>
> >>>> The AF_UNIX address was truncated to 47 bytes + terminating null byte.=
 This patch will fix the
> >>>> servername in AF_UNIX family to the maximum permitted by the system:
> >>>>
> >>>>    548         };
> >>>>  =E2=86=92 549         char servername[UNIX_PATH_MAX];
> >>>>    550         struct rpc_clnt *clnt;
> >>>>
> >>>> Fixes: 4388ce05fa38b ("SUNRPC: support abstract unix socket addresses")
> >>>> Fixes: 510deb0d7035d ("SUNRPC: rpc_create() default hostname should su=
pport AF_INET6 addresses")
> >>>> Fixes: 176e21ee2ec89 ("SUNRPC: Support for RPC over AF_LOCAL transport=
s")
> >>>> Cc: Neil Brown <neilb@suse.de>
> >>>> Cc: Chuck Lever <chuck.lever@oracle.com>
> >>>> Cc: Trond Myklebust <trondmy@kernel.org>
> >>>> Cc: Anna Schumaker <anna@kernel.org>
> >>>> Cc: Jeff Layton <jlayton@kernel.org>
> >>>> Cc: Olga Kornievskaia <okorniev@redhat.com>
> >>>> Cc: Dai Ngo <Dai.Ngo@oracle.com>
> >>>> Cc: Tom Talpey <tom@talpey.com>
> >>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>> Cc: Jakub Kicinski <kuba@kernel.org>
> >>>> Cc: Paolo Abeni <pabeni@redhat.com>
> >>>> Cc: linux-nfs@vger.kernel.org
> >>>> Cc: netdev@vger.kernel.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> >>>> ---
> >>>>  v1:
> >>>> 	initial version.
> >>>>
> >>>>  net/sunrpc/clnt.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> >>>> index 09f29a95f2bc..67099719893e 100644
> >>>> --- a/net/sunrpc/clnt.c
> >>>> +++ b/net/sunrpc/clnt.c
> >>>> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args=
 *args)
> >>>>  		.connect_timeout =3D args->connect_timeout,
> >>>>  		.reconnect_timeout =3D args->reconnect_timeout,
> >>>>  	};
> >>>> -	char servername[48];
> >>>> +	char servername[UNIX_PATH_MAX];
> >>>>  	struct rpc_clnt *clnt;
> >>>>  	int i;
> >>>> =20
> >>>> --=20
> >>>> 2.43.0
> >>>>
> >>>>
> >>>
> >>
> >=20
>=20



Return-Path: <linux-nfs+bounces-2252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FBB87797B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 02:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625C2280ED3
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 01:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ED664C;
	Mon, 11 Mar 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yUt85KOU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mrIuUT/l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yUt85KOU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mrIuUT/l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA9631
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710119872; cv=none; b=XtuFJ87XYOAbF5RKNXBM7ESp6T96KWMVFQ+dIpMOsEHmNesU/oVoCBKvAR1Nw5W+dJp2HoZTGhl4zcvGV6fuYt0zkBUIfORgBQarWnCgW5EH6Z3wAWhvTicX2xCEAtvgXcjdK4dbKvBhlFg+wBGdVzKbyBjJN5db4i5mEJBjzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710119872; c=relaxed/simple;
	bh=QOIy4hboMIvVsZvhFeO8WtGxUI+H2aOpJ9Rkt2C8IC4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=idUY2l5fjmP2sjKr1vDhn8XvvX4DFQAbLHizkutmQ7GeAbjxYXD8vtonty0Q5dL5Q0iiPj1N2mGp92/stQAqEPcxy0GRpAwmtxvjyco1dTydL54h7a0qouIZd3zwAeDJsjizvv2LNGgIT/PrJ2DwfeAQ9JEUvy9CmZBpkQLpDpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yUt85KOU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mrIuUT/l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yUt85KOU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mrIuUT/l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2FCA3467E;
	Mon, 11 Mar 2024 01:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710119867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woRP1OD4KKU3NgLbNgbtUPM3J3ERoXNDM8bqEcoOJ7c=;
	b=yUt85KOUfoBCC+FQc2sMB6pUxPaxsfh7FG/YrxCI69K/kRO2RKl6ogsC72JA1YmNgMCGar
	l3Z6lrTTnTXh3t40VD+Q7ZpWz2SdxhVy+LTAui2k7i+HsQaS8oOY0P2ELP2dUolMr17RlQ
	6mGthpWrXuUDUcSeJLXkXzESZvUmHL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710119867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woRP1OD4KKU3NgLbNgbtUPM3J3ERoXNDM8bqEcoOJ7c=;
	b=mrIuUT/lupAmiR2mOBhtmKNEJFDknIXd1pblFxi/w3Ytf6MgrEaPEDc/Qo6sGHvJj9t/6H
	nQRjM6fOtay4EUAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710119867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woRP1OD4KKU3NgLbNgbtUPM3J3ERoXNDM8bqEcoOJ7c=;
	b=yUt85KOUfoBCC+FQc2sMB6pUxPaxsfh7FG/YrxCI69K/kRO2RKl6ogsC72JA1YmNgMCGar
	l3Z6lrTTnTXh3t40VD+Q7ZpWz2SdxhVy+LTAui2k7i+HsQaS8oOY0P2ELP2dUolMr17RlQ
	6mGthpWrXuUDUcSeJLXkXzESZvUmHL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710119867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woRP1OD4KKU3NgLbNgbtUPM3J3ERoXNDM8bqEcoOJ7c=;
	b=mrIuUT/lupAmiR2mOBhtmKNEJFDknIXd1pblFxi/w3Ytf6MgrEaPEDc/Qo6sGHvJj9t/6H
	nQRjM6fOtay4EUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3883713695;
	Mon, 11 Mar 2024 01:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mz1oM7lb7mWqeAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Mar 2024 01:17:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Steve Dickson" <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, "Petr Vorel" <pvorel@suse.cz>
Subject: Re: [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
In-reply-to: <52cc6a79-7c7c-47ec-b1f0-cc0de61fafab@redhat.com>
References: <20240225234337.19744-1-neilb@suse.de>,
 <20240225234337.19744-3-neilb@suse.de>,
 <52cc6a79-7c7c-47ec-b1f0-cc0de61fafab@redhat.com>
Date: Mon, 11 Mar 2024 12:17:42 +1100
Message-id: <171011986213.13576.8075278560238641614@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yUt85KOU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="mrIuUT/l"
X-Spamd-Result: default: False [-5.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -5.31
X-Rspamd-Queue-Id: B2FCA3467E
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sun, 10 Mar 2024, Steve Dickson wrote:
>=20
> On 2/25/24 6:40 PM, NeilBrown wrote:
> > Two callers of local_rpcb() want the target-addr, and local_rcpb() has
> > easy access to it.  So accept a pointer and fill it in if not NULL.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >   src/rpcb_clnt.c | 35 +++++++++++------------------------
> >   1 file changed, 11 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> > index 68fe69a320ff..f587580228ab 100644
> > --- a/src/rpcb_clnt.c
> > +++ b/src/rpcb_clnt.c
> > @@ -89,7 +89,7 @@ static struct address_cache *copy_of_cached(const char =
*, char *);
> >   static void delete_cache(struct netbuf *);
> >   static void add_cache(const char *, const char *, struct netbuf *, char=
 *);
> >   static CLIENT *getclnthandle(const char *, const struct netconfig *, ch=
ar **);
> > -static CLIENT *local_rpcb(void);
> > +static CLIENT *local_rpcb(char **targaddr);
> >   #ifdef NOTUSED
> >   static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netco=
nfig *);
> >   #endif
> > @@ -430,19 +430,12 @@ getclnthandle(host, nconf, targaddr)
> >   	    nconf->nc_netid, si.si_af, si.si_proto, si.si_socktype));
> >  =20
> >   	if (nconf->nc_protofmly !=3D NULL && strcmp(nconf->nc_protofmly, NC_LO=
OPBACK) =3D=3D 0) {
> > -		client =3D local_rpcb();
> > +		client =3D local_rpcb(targaddr);
> >   		if (! client) {
> >   			LIBTIRPC_DEBUG(1, ("getclnthandle: %s",
> >   				clnt_spcreateerror("local_rpcb failed")));
> >   			goto out_err;
> >   		} else {
> > -			struct sockaddr_un sun;
> > -
> > -			if (targaddr) {
> > -				*targaddr =3D malloc(sizeof(sun.sun_path));
> > -				strncpy(*targaddr, _PATH_RPCBINDSOCK,
> > -				    sizeof(sun.sun_path));
> > -			}
> >   			return (client);
> >   		}
> >   	} else {
> > @@ -541,7 +534,8 @@ getpmaphandle(nconf, hostname, tgtaddr)
> >    * rpcbind. Returns NULL on error and free's everything.
> >    */
> >   static CLIENT *
> > -local_rpcb()
> > +local_rpcb(targaddr)
> > +	char **targaddr;
> >   {
> >   	CLIENT *client;
> >   	static struct netconfig *loopnconf;
> > @@ -574,6 +568,8 @@ local_rpcb()
> >   	if (client !=3D NULL) {
> >   		/* Mark the socket to be closed in destructor */
> >   		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
> > +		if (targaddr)
> > +			*targaddr =3D strdup(sun.sun_path);
> >   		return client;
> >   	}
> >  =20
> > @@ -632,7 +628,7 @@ try_nconf:
> >   		endnetconfig(nc_handle);
> >   	}
> >   	mutex_unlock(&loopnconf_lock);
> > -	client =3D getclnthandle(hostname, loopnconf, NULL);
> > +	client =3D getclnthandle(hostname, loopnconf, targaddr);
> >   	return (client);
> >   }
> >  =20
> > @@ -661,20 +657,11 @@ rpcb_set(program, version, nconf, address)
> >   		rpc_createerr.cf_stat =3D RPC_UNKNOWNADDR;
> >   		return (FALSE);
> >   	}
> > -	client =3D local_rpcb();
> > +	client =3D local_rpcb(&parms.r_addr);
> >   	if (! client) {
> >   		return (FALSE);
> >   	}
> >  =20
> > -	/* convert to universal */
> > -	/*LINTED const castaway*/
> > -	parms.r_addr =3D taddr2uaddr((struct netconfig *) nconf,
> > -				   (struct netbuf *)address);
> > -	if (!parms.r_addr) {
> > -		CLNT_DESTROY(client);
> > -		rpc_createerr.cf_stat =3D RPC_N2AXLATEFAILURE;
> > -		return (FALSE); /* no universal address */
> > -	}
> >   	parms.r_prog =3D program;
> >   	parms.r_vers =3D version;
> >   	parms.r_netid =3D nconf->nc_netid;
> > @@ -712,7 +699,7 @@ rpcb_unset(program, version, nconf)
> >   	RPCB parms;
> >   	char uidbuf[32];
> >  =20
> > -	client =3D local_rpcb();
> > +	client =3D local_rpcb(NULL);
> >   	if (! client) {
> >   		return (FALSE);
> >   	}
> > @@ -1342,7 +1329,7 @@ rpcb_taddr2uaddr(nconf, taddr)
> >   		rpc_createerr.cf_stat =3D RPC_UNKNOWNADDR;
> >   		return (NULL);
> >   	}
> > -	client =3D local_rpcb();
> > +	client =3D local_rpcb(NULL);
> >   	if (! client) {
> >   		return (NULL);
> >   	}
> > @@ -1376,7 +1363,7 @@ rpcb_uaddr2taddr(nconf, uaddr)
> >   		rpc_createerr.cf_stat =3D RPC_UNKNOWNADDR;
> >   		return (NULL);
> >   	}
> > -	client =3D local_rpcb();
> > +	client =3D local_rpcb(NULL);
> >   	if (! client) {
> >   		return (NULL);
> >   	}
> It is not clear why... but this patch stop mountd from
> registering with rpcbind (both the old and changed via
> the latest patches), which means v3 mounts break.
> Not good :-)
>=20
> Turning debugging on... rpcbind is receiving the set prog
> but not recording it, since port 0 is returned when
> the client tries to do a v3 mount.
>=20
> Are you guys seeing this??

I am now.  Wonder why I didn't before..

The problem is the removal of that /* convert to universal */ section.

r_addr is meant to be based on 'address', not whatever local_rpcb()
finds.

I'll fix that up as well as a bug I found in patch 1 (a '\0' should have
been '@') and test and resend.

Thanks,
NeilBrown


>=20
> I remove this patch and everything works!
>=20
> steved.
>=20
>=20



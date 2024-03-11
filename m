Return-Path: <linux-nfs+bounces-2259-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD78877CFF
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 10:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE11C20FC9
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 09:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1833C471;
	Mon, 11 Mar 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7WNWmrz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jm174pr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7WNWmrz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2jm174pr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F83C068
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149716; cv=none; b=AHgKqxVoeGMNpej0xxHFa0W+gBpHqGcVWy69dRRl89x5BhK27G//oznHxJLHZdPHusfzIsq9rYTaxtQ80AxLIxpPv2nFHqi4G5zfQz6dXvEWDPEFhlRYLrTXFYUVvYCe3vm6IROKgipdxcGBqFVlDnI5fJ0v1lQMyis+dqu97Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149716; c=relaxed/simple;
	bh=Q2GX8acwuDQ+D5yCSx4RHSFWkuQ5EmL/9dtyLiTJtvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfVCq8NA1VHukh58NIGIWriNc6ZVaqGDdE249+CMD5rFqsW31E5Wwpw5hxCyTRoEkA5gjay0h2B6Ebn3BPbeh2ETgYEiX1K71ZvCYoNJEuGiN4Z50ClxjcgnGMJoYfr70C4pTmoyqiZEXgPj40/YPqvMvtP2ySIujvC988O8v2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7WNWmrz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jm174pr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7WNWmrz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2jm174pr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D9F834A99;
	Mon, 11 Mar 2024 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710149712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftHKaFUOUgfQE8tegXyJ6wUTR8Nu0JkfA2Z/+UH/i6A=;
	b=s7WNWmrzN/oyo6YNVKTB1aPnlUA4L8f7v8yob0PNQe4+1wIaFLsJBCk+Ya5fCN1wEouGz9
	j5+0LFojzaSgxI8RHIf8vjLqfe94N5Y+eIh0zRTjn9QcSNOWU3XBh5TvHyALycOPpnPWEw
	u6imbEda8A6BW61wOxBmzcVKOl9kWvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710149712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftHKaFUOUgfQE8tegXyJ6wUTR8Nu0JkfA2Z/+UH/i6A=;
	b=2jm174pr28qq6XavmZYuBicTPrMvXXXO3j07TTPJj8q0a3lWjkdVtAJzPhNph88yC/AAOq
	py0UjTYmG8pC66DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710149712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftHKaFUOUgfQE8tegXyJ6wUTR8Nu0JkfA2Z/+UH/i6A=;
	b=s7WNWmrzN/oyo6YNVKTB1aPnlUA4L8f7v8yob0PNQe4+1wIaFLsJBCk+Ya5fCN1wEouGz9
	j5+0LFojzaSgxI8RHIf8vjLqfe94N5Y+eIh0zRTjn9QcSNOWU3XBh5TvHyALycOPpnPWEw
	u6imbEda8A6BW61wOxBmzcVKOl9kWvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710149712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ftHKaFUOUgfQE8tegXyJ6wUTR8Nu0JkfA2Z/+UH/i6A=;
	b=2jm174pr28qq6XavmZYuBicTPrMvXXXO3j07TTPJj8q0a3lWjkdVtAJzPhNph88yC/AAOq
	py0UjTYmG8pC66DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 330CC136BA;
	Mon, 11 Mar 2024 09:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A7ZyC1DQ7mV9BwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 11 Mar 2024 09:35:12 +0000
Date: Mon, 11 Mar 2024 10:35:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Steve Dickson <steved@redhat.com>
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
Message-ID: <20240311093506.GA402014@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240225234337.19744-1-neilb@suse.de>
 <20240225234337.19744-3-neilb@suse.de>
 <52cc6a79-7c7c-47ec-b1f0-cc0de61fafab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52cc6a79-7c7c-47ec-b1f0-cc0de61fafab@redhat.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s7WNWmrz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2jm174pr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.71
X-Rspamd-Queue-Id: 4D9F834A99
X-Spam-Flag: NO



> On 2/25/24 6:40 PM, NeilBrown wrote:
> > Two callers of local_rpcb() want the target-addr, and local_rcpb() has
> > easy access to it.  So accept a pointer and fill it in if not NULL.

> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >   src/rpcb_clnt.c | 35 +++++++++++------------------------
> >   1 file changed, 11 insertions(+), 24 deletions(-)

> > diff --git a/src/rpcb_clnt.c b/src/rpcb_clnt.c
> > index 68fe69a320ff..f587580228ab 100644
> > --- a/src/rpcb_clnt.c
> > +++ b/src/rpcb_clnt.c
> > @@ -89,7 +89,7 @@ static struct address_cache *copy_of_cached(const char *, char *);
> >   static void delete_cache(struct netbuf *);
> >   static void add_cache(const char *, const char *, struct netbuf *, char *);
> >   static CLIENT *getclnthandle(const char *, const struct netconfig *, char **);
> > -static CLIENT *local_rpcb(void);
> > +static CLIENT *local_rpcb(char **targaddr);
> >   #ifdef NOTUSED
> >   static struct netbuf *got_entry(rpcb_entry_list_ptr, const struct netconfig *);
> >   #endif
> > @@ -430,19 +430,12 @@ getclnthandle(host, nconf, targaddr)
> >   	    nconf->nc_netid, si.si_af, si.si_proto, si.si_socktype));
> >   	if (nconf->nc_protofmly != NULL && strcmp(nconf->nc_protofmly, NC_LOOPBACK) == 0) {
> > -		client = local_rpcb();
> > +		client = local_rpcb(targaddr);
> >   		if (! client) {
> >   			LIBTIRPC_DEBUG(1, ("getclnthandle: %s",
> >   				clnt_spcreateerror("local_rpcb failed")));
> >   			goto out_err;
> >   		} else {
> > -			struct sockaddr_un sun;
> > -
> > -			if (targaddr) {
> > -				*targaddr = malloc(sizeof(sun.sun_path));
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
> >   	if (client != NULL) {
> >   		/* Mark the socket to be closed in destructor */
> >   		(void) CLNT_CONTROL(client, CLSET_FD_CLOSE, NULL);
> > +		if (targaddr)
> > +			*targaddr = strdup(sun.sun_path);
> >   		return client;
> >   	}
> > @@ -632,7 +628,7 @@ try_nconf:
> >   		endnetconfig(nc_handle);
> >   	}
> >   	mutex_unlock(&loopnconf_lock);
> > -	client = getclnthandle(hostname, loopnconf, NULL);
> > +	client = getclnthandle(hostname, loopnconf, targaddr);
> >   	return (client);
> >   }
> > @@ -661,20 +657,11 @@ rpcb_set(program, version, nconf, address)
> >   		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
> >   		return (FALSE);
> >   	}
> > -	client = local_rpcb();
> > +	client = local_rpcb(&parms.r_addr);
> >   	if (! client) {
> >   		return (FALSE);
> >   	}
> > -	/* convert to universal */
> > -	/*LINTED const castaway*/
> > -	parms.r_addr = taddr2uaddr((struct netconfig *) nconf,
> > -				   (struct netbuf *)address);
> > -	if (!parms.r_addr) {
> > -		CLNT_DESTROY(client);
> > -		rpc_createerr.cf_stat = RPC_N2AXLATEFAILURE;
> > -		return (FALSE); /* no universal address */
> > -	}
> >   	parms.r_prog = program;
> >   	parms.r_vers = version;
> >   	parms.r_netid = nconf->nc_netid;
> > @@ -712,7 +699,7 @@ rpcb_unset(program, version, nconf)
> >   	RPCB parms;
> >   	char uidbuf[32];
> > -	client = local_rpcb();
> > +	client = local_rpcb(NULL);
> >   	if (! client) {
> >   		return (FALSE);
> >   	}
> > @@ -1342,7 +1329,7 @@ rpcb_taddr2uaddr(nconf, taddr)
> >   		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
> >   		return (NULL);
> >   	}
> > -	client = local_rpcb();
> > +	client = local_rpcb(NULL);
> >   	if (! client) {
> >   		return (NULL);
> >   	}
> > @@ -1376,7 +1363,7 @@ rpcb_uaddr2taddr(nconf, uaddr)
> >   		rpc_createerr.cf_stat = RPC_UNKNOWNADDR;
> >   		return (NULL);
> >   	}
> > -	client = local_rpcb();
> > +	client = local_rpcb(NULL);
> >   	if (! client) {
> >   		return (NULL);
> >   	}
> It is not clear why... but this patch stop mountd from
> registering with rpcbind (both the old and changed via
> the latest patches), which means v3 mounts break.
> Not good :-)

> Turning debugging on... rpcbind is receiving the set prog
> but not recording it, since port 0 is returned when
> the client tries to do a v3 mount.

> Are you guys seeing this??

Hi Steve,

I'm sorry I haven't had time to test. Strange, I don't see any bug in that
commit.

Kind regards,
Petr

> I remove this patch and everything works!

> steved.



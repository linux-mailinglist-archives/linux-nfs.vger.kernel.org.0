Return-Path: <linux-nfs+bounces-4376-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89C91B589
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 05:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D6DB21DF2
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442F17583;
	Fri, 28 Jun 2024 03:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IwLnElv2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hc0NhEl6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IwLnElv2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hc0NhEl6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D545225CE
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546031; cv=none; b=qebByay0WBQ/jnQV86c9CALgdn4plPK+F8YdElQEgHJIZbMHEdklZ1RvENENumFZx0PcH8G9poyJ6vwueMLujmlnNd59MhMGWR6jzXk0MBdAr372RUl8Be12o/VZ/I5NkmJh/vAtw6w9yRvjpytS709phn1ZzeR/LfrlbvZm5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546031; c=relaxed/simple;
	bh=iLUPH2gmvXCezXgMqr77n9CgIEAkgpxArPiM7GlJ/lY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p33b2bZdMKCMIjb5HS76B0HdTYK4kLw4EgN8kEb6LXmf42rQ+6s8tormBZWTOQ0oENiC3oGHufrLKoW3YZT+pLdoV9nzsmsBzrXxGF99VfCI1M9vFxM5byJN84+FqHBIkFoxU9I2WwvLH//hbviYKt6Na4HRMmlkIORKxy7DWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IwLnElv2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hc0NhEl6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IwLnElv2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hc0NhEl6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0914621B4E;
	Fri, 28 Jun 2024 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719546027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+yRkQ0RqanUbH1RfCGcVMiq42ygb/RL0MDaS4bon0E=;
	b=IwLnElv2u0JuqEemPWdb90Wr93mleegUVfODhdzMB64ILx4zBT1KOiyKhfQie37PdH3iML
	SXOJ8R21K06N65zDRbRP17ngRskoOaJFhynZM2vvZSyEKJJ/tG1cINllNDwB1dIty8sYeH
	eEdTLwBwiic9VOvjH2bxUe49t2GdslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719546027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+yRkQ0RqanUbH1RfCGcVMiq42ygb/RL0MDaS4bon0E=;
	b=Hc0NhEl65+hth2i8VKb0IIBIYaU28vTZT9c/DDn8Bbd5OHJg156fbicKfp99u/eeSRKVcf
	RtJdQMovEjPr26Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IwLnElv2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Hc0NhEl6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719546027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+yRkQ0RqanUbH1RfCGcVMiq42ygb/RL0MDaS4bon0E=;
	b=IwLnElv2u0JuqEemPWdb90Wr93mleegUVfODhdzMB64ILx4zBT1KOiyKhfQie37PdH3iML
	SXOJ8R21K06N65zDRbRP17ngRskoOaJFhynZM2vvZSyEKJJ/tG1cINllNDwB1dIty8sYeH
	eEdTLwBwiic9VOvjH2bxUe49t2GdslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719546027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+yRkQ0RqanUbH1RfCGcVMiq42ygb/RL0MDaS4bon0E=;
	b=Hc0NhEl65+hth2i8VKb0IIBIYaU28vTZT9c/DDn8Bbd5OHJg156fbicKfp99u/eeSRKVcf
	RtJdQMovEjPr26Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 693D313A63;
	Fri, 28 Jun 2024 03:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JDd7A6gwfma6UAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 28 Jun 2024 03:40:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v8 09/18] nfsd: use percpu_ref to interlock
 nfsd_destroy_serv and nfsd_open_local_fh
In-reply-to: <70a92bcf0e6ad3e7ef9fa96edf68d9cdb32e6a2e.camel@kernel.org>
References: <>, <70a92bcf0e6ad3e7ef9fa96edf68d9cdb32e6a2e.camel@kernel.org>
Date: Fri, 28 Jun 2024 13:40:16 +1000
Message-id: <171954601675.16071.8822404139869125051@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0914621B4E
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Fri, 28 Jun 2024, Jeff Layton wrote:
> On Thu, 2024-06-27 at 13:14 -0400, Mike Snitzer wrote:
> > On Thu, Jun 27, 2024 at 07:24:54AM -0400, Jeff Layton wrote:
> > > On Wed, 2024-06-26 at 14:24 -0400, Mike Snitzer wrote:
> > > > Introduce nfsd_serv_get and nfsd_serv_put and update the nfsd
> > > > code to
> > > > prevent nfsd_destroy_serv from destroying nn->nfsd_serv until any
> > > > client initiated localio calls to nfsd (that are _not_ in the
> > > > context
> > > > of nfsd) are complete.
> > > > 
> > > > nfsd_open_local_fh is updated to nfsd_serv_get before opening its
> > > > file
> > > > handle and then drop the reference using nfsd_serv_put at the end
> > > > of
> > > > nfsd_open_local_fh.
> > > > 
> > > > This "interlock" working relies heavily on nfsd_open_local_fh()'s
> > > > maybe_get_net() safely dealing with the possibility that the
> > > > struct
> > > > net (and nfsd_net by association) may have been destroyed by
> > > > nfsd_destroy_serv() via nfsd_shutdown_net().
> > > > 
> > > > Verified to fix an easy to hit crash that would occur if an nfsd
> > > > instance running in a container, with a localio client mounted,
> > > > is
> > > > shutdown. Upon restart of the container and associated nfsd the
> > > > client
> > > > would go on to crash due to NULL pointer dereference that
> > > > occuured due
> > > > to the nfs client's localio attempting to nfsd_open_local_fh(),
> > > > using
> > > > nn->nfsd_serv, without having a proper reference on nn-
> > > > >nfsd_serv.
> > > > 
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfsd/localio.c |  2 ++
> > > >  fs/nfsd/netns.h   |  8 +++++++-
> > > >  fs/nfsd/nfssvc.c  | 39 +++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 48 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > > index 48118db801b5..819589ae2008 100644
> > > > --- a/fs/nfsd/localio.c
> > > > +++ b/fs/nfsd/localio.c
> > > > @@ -204,6 +204,7 @@ int nfsd_open_local_fh(struct net *net,
> > > >  	}
> > > >  	nn = net_generic(net, nfsd_net_id);
> > > >  
> > > > +	nfsd_serv_get(nn);
> > > >  	serv = READ_ONCE(nn->nfsd_serv);
> > > >  	if (unlikely(!serv)) {
> > > >  		dprintk("%s: localio denied. Server not
> > > > running\n", __func__);
> > > > @@ -244,6 +245,7 @@ int nfsd_open_local_fh(struct net *net,
> > > >  out_revertcred:
> > > >  	revert_creds(save_cred);
> > > >  out_net:
> > > > +	nfsd_serv_put(nn);
> > > >  	put_net(net);
> > > >  	return status;
> > > >  }
> > > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > > index 0c5a1d97e4ac..17a73c780ca1 100644
> > > > --- a/fs/nfsd/netns.h
> > > > +++ b/fs/nfsd/netns.h
> > > > @@ -13,6 +13,7 @@
> > > >  #include <linux/filelock.h>
> > > >  #include <linux/nfs4.h>
> > > >  #include <linux/percpu_counter.h>
> > > > +#include <linux/percpu-refcount.h>
> > > >  #include <linux/siphash.h>
> > > >  #include <linux/sunrpc/stats.h>
> > > >  #include <linux/nfslocalio.h>
> > > > @@ -140,7 +141,9 @@ struct nfsd_net {
> > > >  
> > > >  	struct svc_info nfsd_info;
> > > >  #define nfsd_serv nfsd_info.serv
> > > > -
> > > > +	struct percpu_ref nfsd_serv_ref;
> > > > +	struct completion nfsd_serv_confirm_done;
> > > > +	struct completion nfsd_serv_free_done;
> > > >  
> > > >  	/*
> > > >  	 * clientid and stateid data for construction of net
> > > > unique COPY
> > > > @@ -225,6 +228,9 @@ struct nfsd_net {
> > > >  extern bool nfsd_support_version(int vers);
> > > >  extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> > > >  
> > > > +void nfsd_serv_get(struct nfsd_net *nn);
> > > > +void nfsd_serv_put(struct nfsd_net *nn);
> > > > +
> > > >  extern unsigned int nfsd_net_id;
> > > >  
> > > >  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net
> > > > *nn);
> > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > > index a477d2c5088a..be5acb7a4057 100644
> > > > --- a/fs/nfsd/nfssvc.c
> > > > +++ b/fs/nfsd/nfssvc.c
> > > > @@ -258,6 +258,30 @@ int nfsd_minorversion(struct nfsd_net *nn,
> > > > u32 minorversion, enum vers_op change
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +void nfsd_serv_get(struct nfsd_net *nn)
> > > > +{
> > > > +	percpu_ref_get(&nn->nfsd_serv_ref);
> > > > +}
> > > > +
> > > > +void nfsd_serv_put(struct nfsd_net *nn)
> > > > +{
> > > > +	percpu_ref_put(&nn->nfsd_serv_ref);
> > > > +}
> > > > +
> > > > +static void nfsd_serv_done(struct percpu_ref *ref)
> > > > +{
> > > > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net,
> > > > nfsd_serv_ref);
> > > > +
> > > > +	complete(&nn->nfsd_serv_confirm_done);
> > > > +}
> > > > +
> > > > +static void nfsd_serv_free(struct percpu_ref *ref)
> > > > +{
> > > > +	struct nfsd_net *nn = container_of(ref, struct nfsd_net,
> > > > nfsd_serv_ref);
> > > > +
> > > > +	complete(&nn->nfsd_serv_free_done);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Maximum number of nfsd processes
> > > >   */
> > > > @@ -462,6 +486,7 @@ static void nfsd_shutdown_net(struct net
> > > > *net)
> > > >  		lockd_down(net);
> > > >  		nn->lockd_up = false;
> > > >  	}
> > > > +	percpu_ref_exit(&nn->nfsd_serv_ref);
> > > >  #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> > > >  	list_del_rcu(&nn->nfsd_uuid.list);
> > > >  #endif
> > > > @@ -544,6 +569,13 @@ void nfsd_destroy_serv(struct net *net)
> > > >  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> > > >  	struct svc_serv *serv = nn->nfsd_serv;
> > > >  
> > > > +	lockdep_assert_held(&nfsd_mutex);
> > > > +
> > > > +	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref,
> > > > nfsd_serv_done);
> > > > +	wait_for_completion(&nn->nfsd_serv_confirm_done);
> > > > +	wait_for_completion(&nn->nfsd_serv_free_done);
> > > > +	/* percpu_ref_exit is called in nfsd_shutdown_net */
> > > > +
> > > 
> > > At this point where you're waiting on these completion vars, what
> > > stops
> > > the client from issuing new localio requests?
> > 
> > The server going down.  The interlock is with nfsd_open_local_fh, so
> > once any active file opens complete the server will get these
> > completions and the server will go down.  The client will reconnect
> > if/when the server comes back up.
> > 
> > Maybe I'm not imaginative enough, but is there risk of never-ending
> > overlapping file opens that prevent nfsd_destroy_serv() from
> > progressing?
> > 
> 
> Yeah, I think it's a possibility, especially if the underlying
> filesystem is particularly slow. You can probably solve that by just
> not handing out new references somehow once you're going to call
> percpu_ref_kill_and_confirm.

percpu-refcount has just to tool you need.

Use percpu_ref_tryget_live().  nfsd_serv_get() must be able to fail, and
so it must use this.  If it does then it can safely read ->nfsd_serv
without checking for NULL.

NeilBrown


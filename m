Return-Path: <linux-nfs+bounces-4109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1E90F845
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 23:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918381F2140D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 21:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB26E7A724;
	Wed, 19 Jun 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wCWYY9OB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9N9zCQJR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J/vTI+4i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dOQpHtZw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD6249ED
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831376; cv=none; b=D00AOV/KDa2OhOjyoRGQo8kmPiGOO+JSIkeV7lqe4mKtjncJ3eeb0nvIE68qJjaD0owtMTHxoIYa5AxJQZi9qWfgMskJ8nm2sFvzlGlzYKkgv6xch+6bK27NA7SgreoAx1hXFll+G65Wio/1xzUrGtx1UIji3LTthmtdp7Yz9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831376; c=relaxed/simple;
	bh=xXH666Ldb/qFLInmoNIZAifXTECWJ8cxXAFvbCtaHd8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=spd4JfZ1SSVtXg47Of3Te5Z7zFZRznt+RMp/WzLJGALrdmaTsIrivRTRBvZHeSZQibOGJlqxNazeOrlF5iB6Jx+MdZ73tDY3+RcH++cF0sm/+9VJaOqk4DEL/kz7QRjhBorgTWqqAE6hmD5qJjMX3aTdbJOw/foMocqC+U7dal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wCWYY9OB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9N9zCQJR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J/vTI+4i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dOQpHtZw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EFDD219E5;
	Wed, 19 Jun 2024 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718831372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvRx/pJsC/TaUAERLuU6Ru5/6eJpOrz34y6dHcYnw8Q=;
	b=wCWYY9OB3v+8IycYrjSPeNSiWoqukWMzecxihY+CzDKzEiGuY+2ooyky5axX1VFiwqo1V3
	g+stevVsvvsbEsp60Xo4HgSga3E5Rl80GU25gebycoL39YtqqIqHT568IJHV/ehrfsNwC5
	Lj9L8WGvhgV0y1ebx8t3dgllLKlJraY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718831372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvRx/pJsC/TaUAERLuU6Ru5/6eJpOrz34y6dHcYnw8Q=;
	b=9N9zCQJRWVbOue/hmXTUQwFLh/IElXOohdD8BCjM4jIK88VF0c44l+yY1/uL/GpEQ3fE8F
	K1ibcGAM+ohY4FDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="J/vTI+4i";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dOQpHtZw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718831371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvRx/pJsC/TaUAERLuU6Ru5/6eJpOrz34y6dHcYnw8Q=;
	b=J/vTI+4iWsBhf1ZFH9sSb37F6pwfdaPHx7Y5dQZoYQ2wnQ7/7zNnKMuw+f4UsBcg0g9lHt
	PkbGeVeMtNkyQfEFnAdKWcUSxleHZdZDlodpuifzqHDYr2j3y6ng7A5539l4xkLmctmXBV
	gVl9WN4+9+54tfz+JPOtSJm8g94Z1Ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718831371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvRx/pJsC/TaUAERLuU6Ru5/6eJpOrz34y6dHcYnw8Q=;
	b=dOQpHtZwpGmIpkov2FPymUQNG1wlh2iGnlmL3zPP70U4cpFUdg4UJu40iKLi0VAbHIOWEx
	oYo10ZDhC0VqY+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75D0B13668;
	Wed, 19 Jun 2024 21:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 66rSBghJc2YbBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Jun 2024 21:09:28 +0000
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
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
In-reply-to: <23aa79999595e0ec5af04795be315de73ec5cfe0.camel@kernel.org>
References: <>, <23aa79999595e0ec5af04795be315de73ec5cfe0.camel@kernel.org>
Date: Thu, 20 Jun 2024 07:09:23 +1000
Message-id: <171883136311.14261.10658469664795186377@noble.neil.brown.name>
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
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6EFDD219E5
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Wed, 19 Jun 2024, Jeff Layton wrote:
> On Wed, 2024-06-19 at 17:10 +1000, NeilBrown wrote:
> > On Wed, 19 Jun 2024, Christoph Hellwig wrote:
> > > What happened to the requirement that all protocol extensions added
> > > to Linux need to be standardized in IETF RFCs?
> > > 
> > > 
> > 
> > Is that requirement documented somewhere?  Not that I doubt it, but it
> > would be nice to know where it is explicit.  I couldn't quickly find
> > anything in Documentation/
> > 
> > Can we get by without the LOCALIO protocol?
> > 
> > For NFSv4.1 we could use the server_owner4 returned by EXCHANGE_ID.  It
> > is explicitly documented as being usable to determine if two servers are
> > the same.
> > 
> > For NFSv4.0 ... I don't think we should encourage that to be used.
> > 
> > For NFSv3 it is harder.  I'm not as ready to deprecate it as I am for
> > 4.0.  There is nothing in NFSv3 or MOUNT or NLM that is comparable to
> > server_owner4.  If krb5 was used there would probably be a server
> > identity in there that could be used.
> > I think the server could theoretically return an AUTH_SYS verifier in
> > each RPC reply and that could be used to identify the server.  I'm not
> > sure that is a good idea though.
> > 
> 
> My idea for v3 was that the localio client could do an O_TMPFILE create
> on the exported fs and write some random junk to it (a uuid or
> something). Construct the filehandle for that and then the client could
> try to issue a READ for that filehandle via the NFS server. If it finds
> that filehandle and the contents are correct then you're on the same
> host. Then you just close the file and it should clean itself up.

I can't see how this would work, but maybe I don't have a good enough
imagination.

The high-level view of the proposed protocol is:
  - client asks remote server to identify itself.
  - server returns an identity
  - client uses local-sideband to ask each local server if it has the
    given identity.

I don't see where an O_TMPFILE could fit into this, or how a different
high-level approach would be any better.

For NFSv3 the client could ask with a new Program or Version or
Procedure, or all three.  Or it could ask with a new file-handle or path
name.  I imagine using a webnfs (rfc2054) multi-component lookup on the
public filehandle for "/linux/config/server-id" and getting back a
filehandle which encodes the server ID somehow.  All these seem credible
options and it is not clear than any one is better than any other.

For NFSv4.1 I think that LOCALIO looks a lot like trunking and so using
exactly the same mechanism to determine if two servers are the same is a
good idea.
But then LOCALIO also looks a lot like a new pNFS/DS protocol so maybe
we should specify that protocol and use GETDEVICELIST or GETDEVICEINFO
to find the identity of the server.

> 
> This is a little less straightforward and efficient than the localio
> protocol that Mike is proposing, but requires no protocol extensions.

I think that if we use anything other than the server-id in the
EXCHANGE_ID response, then we are defining a new protocol as it is a new
request which we expect existing servers to ignore or fail, even though
they have never been tested to ignore/fail that particular request.

Of all the options I would guess that a new version for an existing
protocol would be safest as that is the most likely to have been tested.
A new RPC program is probably conceptually simplest.  A little hack in
LOOKUPv3 to detect the public filehandle etc is probably the easiest to
code, and a new pnfs/ds protocol is probably the cleanest overall
except that it doesn't support NFSv3.

My purpose in all this is not to replace Mike's LOCALIO protocol, but to
explore the solution space to ensure there is nothing that is obviously
better.  As yet, I don't think there is.

NeilBrown


>  
> > Going through the IETF process for something that is entirely private to
> > Linux seems a bit more than should be necessary..
> > 
> 
> Agreed. Given that this our own protocol extension and we don't have
> any expectation of other clients or servers implementing this, I don't
> see the point. I do agree that trying to avoid program number conflicts
> is a good thing though.
> -- 
> Jeff Layton <jlayton@kernel.org>
> 



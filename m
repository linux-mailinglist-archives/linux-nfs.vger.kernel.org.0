Return-Path: <linux-nfs+bounces-5603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F795C5C6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 08:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7124A1C21A48
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F553D552;
	Fri, 23 Aug 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3uTcXI2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmHmZhps";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W3uTcXI2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmHmZhps"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3418485;
	Fri, 23 Aug 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395606; cv=none; b=XxzgCBBz+GjBa5CcXangDTOYe/cwvuO2jDy+m9wCm69yerC2w0UXlFl/tQ7Hj9VUHOW5WWa4pFbTnqQS71X8/xJ2nBH6jZffIVjfMdS3hq+XHFN5CedlL0jqtj/qPKSdzDIgwhhy+RjKVzFY+ae+WffV4vGJc2x7kjzInVY1bSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395606; c=relaxed/simple;
	bh=2aPu5n515vDjkiEo6NAbeohmoXKaLTdc8aanO+f11l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avp+wwfFHhBLV40ZmXbaosOuyFKdaF7EiQbNH1WsbVl94g59/C/b9A81NOBX4GOrElpAhLWT6Phb0AjBQmBGX3Ju8EANPFeyMwq3Fgwf/j8IO9gFXNNS6QGGfBhhurvYpzpk60/aUAz6dOHhur5eRJ/4tUi8uQQrw2pX4gTrlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3uTcXI2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmHmZhps; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W3uTcXI2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmHmZhps; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 799BF2260A;
	Fri, 23 Aug 2024 06:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724395602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OZZdDIUj7mMBfQFY5EgT+q7Q1jpLOu+EZCCUb9tNlg=;
	b=W3uTcXI2eUHCns4VryWfF7Dd5nRkI532yRyJ3RULLdWfEewN9sJNpgWxlFllb+SsXgEGKn
	SJ9fkLok+Jsj7KM+VuEE3/sZPxviLZ39Z/bNoYdrixV3rNJcUUc4TpIyItr0kyL0gX6gJW
	AFS3AWD/Utpa03PRVuLyN8zF2bC/I3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724395602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OZZdDIUj7mMBfQFY5EgT+q7Q1jpLOu+EZCCUb9tNlg=;
	b=HmHmZhpsCpYDJqEunhNbQWobTL74HOKcrHNOpWWuXAJEMcEyR5Cio0KdYw3aK4+5pbg5/C
	OslDOwTO3ztpwHCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W3uTcXI2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HmHmZhps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724395602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OZZdDIUj7mMBfQFY5EgT+q7Q1jpLOu+EZCCUb9tNlg=;
	b=W3uTcXI2eUHCns4VryWfF7Dd5nRkI532yRyJ3RULLdWfEewN9sJNpgWxlFllb+SsXgEGKn
	SJ9fkLok+Jsj7KM+VuEE3/sZPxviLZ39Z/bNoYdrixV3rNJcUUc4TpIyItr0kyL0gX6gJW
	AFS3AWD/Utpa03PRVuLyN8zF2bC/I3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724395602;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OZZdDIUj7mMBfQFY5EgT+q7Q1jpLOu+EZCCUb9tNlg=;
	b=HmHmZhpsCpYDJqEunhNbQWobTL74HOKcrHNOpWWuXAJEMcEyR5Cio0KdYw3aK4+5pbg5/C
	OslDOwTO3ztpwHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23F7F1333E;
	Fri, 23 Aug 2024 06:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bjzIBlIwyGahawAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 06:46:42 +0000
Date: Fri, 23 Aug 2024 08:46:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
	Cyril Hrubis <chrubis@suse.cz>, Avinesh Kumar <akumar@suse.de>,
	Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>,
	stable@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel 6.9
Message-ID: <20240823064640.GA1217451@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240814085721.518800-1-pvorel@suse.cz>
 <Zrytfw1DRse3wWRZ@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrytfw1DRse3wWRZ@tissot.1015granger.net>
X-Rspamd-Queue-Id: 799BF2260A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.71
X-Spam-Flag: NO

Hi Chuck, Neil, all,

> On Wed, Aug 14, 2024 at 10:57:21AM +0200, Petr Vorel wrote:
> > 6.9 moved client RPC calls to namespace in "Make nfs stats visible in
> > network NS" patchet.

> > https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Changes v1->v2:
> > * Point out whole patchset, not just single commit
> > * Add a comment about the patchset

> > Hi all,

> > could you please ack this so that we have fixed mainline?

> > FYI Some parts has been backported, e.g.:
> > d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
> > to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.

> > But most of that is not yet (but planned to be backported), e.g.
> > 93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
> > see Chuck's patchset for 6.6
> > https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/

> > Once all kernels up to 5.4 fixed we should update the version.

> > Kind regards,
> > Petr

> >  testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)

> > diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > index c2856eff1f..1beecbec43 100755
> > --- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > +++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
> > @@ -15,7 +15,14 @@ get_calls()
> >  	local calls opt

> >  	[ "$name" = "rpc" ] && opt="r" || opt="n"
> > -	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
> > +
> > +	if tst_net_use_netns; then
> > +		# "Make nfs stats visible in network NS" patchet
> > +		# https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
> > +		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"

> Hello Petr-

> My concern with this fix is it targets v6.9 specifically, yet we
> know these fixes will appear in LTS/stable kernels as well.

Great! I see you already fixed up to 5.15. I suppose the code is really
backportable to the other still active branches (5.10, 5.4, 4.19).

We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
that it works on all kernels. As I note [1]

1) either we give up on checking the new functionality still works (if we
fallback to old behavior)
2) or we need to specify from which kernel we expect new functionality
(so far it's 5.15, I suppose it will be older).

I would prefer 2) to have new functionality always tested.
Or am I missing something obvious?

Kind regards,
Petr

[1] https://lore.kernel.org/linux-nfs/172367387549.6062.7078032983644586462@noble.neil.brown.name/

> Neil Brown suggested an alternative approach that might not depend
> on knowing the specific kernel version:

> https://lore.kernel.org/linux-nfs/172078283934.15471.13377048166707693692@noble.neil.brown.name/

> HTH


> > +	else
> > +		[ "$nfs_f" != "nfs" ] && type="rhost"
> > +	fi

> >  	if [ "$type" = "lhost" ]; then
> >  		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
> > -- 
> > 2.45.2


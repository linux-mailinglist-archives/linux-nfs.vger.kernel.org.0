Return-Path: <linux-nfs+bounces-1871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6284F19F
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 09:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D04DB20C80
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C05C664A4;
	Fri,  9 Feb 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y06A0fHP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yF2eCexm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y06A0fHP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yF2eCexm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2526AD3
	for <linux-nfs@vger.kernel.org>; Fri,  9 Feb 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468604; cv=none; b=Q+rvxwXoWtYH2aAXeuAR/lRgr3UGD73YW1n+k3p0oOEb8Ds7q8D7oJZ6W/XEQE10HwiXwC2UG/+xB3ZF4ye2l3v0kFWiaT2PuidYVij5BRWdZK2co13Lr6uyUbBx7vhNrtJCdK/VhgOuzUYUNR1Sc/Vmu6aEQI6jyiRCv0Te+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468604; c=relaxed/simple;
	bh=MgcWVTSTcxNxmF9lmd7c7ICXzxQTYdolG5bb5sgOOUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyHhbnjETinnxgbK2TsdcjarSx4O/A3y07j00lt8sRQy73HaOD3kP1ieqgMlTNm1z1p9miNVTanLq381huj6enoZkd1O9KUHoWi5CTWBPbPqG9HBEv0tawawiU4uy/H+Ii7YssoMshiOcIsqe77oD4b7Y2mKmTEjTsGlUVn6qVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y06A0fHP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yF2eCexm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y06A0fHP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yF2eCexm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 340A41F7F2;
	Fri,  9 Feb 2024 08:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707468600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
	b=Y06A0fHPnaCvJaWPPaGazoLBHWhxUVqN4bHvjeh0uqFAGVvm0hVl5SH1+CjRgM1IVtS9gh
	H+K+UXK7xJhWfB9pcBSyJkleTcJuc0ljQpM93Ihdz6OExfiNHeYhb5gpWGtEzHmBjVZswi
	ZYZ6/3HMUAVyOlbAQ3xxnYSyP1aPH5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707468600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
	b=yF2eCexmDt0J6+z/ffMihJNpAR+BrF40nS3Ig61utzJLIyC2yHiLEmWzYniJiuYx4cSQ/q
	sJdS2IbUHBTxY9BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707468600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
	b=Y06A0fHPnaCvJaWPPaGazoLBHWhxUVqN4bHvjeh0uqFAGVvm0hVl5SH1+CjRgM1IVtS9gh
	H+K+UXK7xJhWfB9pcBSyJkleTcJuc0ljQpM93Ihdz6OExfiNHeYhb5gpWGtEzHmBjVZswi
	ZYZ6/3HMUAVyOlbAQ3xxnYSyP1aPH5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707468600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
	b=yF2eCexmDt0J6+z/ffMihJNpAR+BrF40nS3Ig61utzJLIyC2yHiLEmWzYniJiuYx4cSQ/q
	sJdS2IbUHBTxY9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 993C01326D;
	Fri,  9 Feb 2024 08:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZdKIjfnxWUBBgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 08:49:59 +0000
Date: Fri, 9 Feb 2024 09:49:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Cc: ltp@lists.linux.it, NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 4/4] nfsstat01.sh: Run on all NFS versions, TCP and UDP
Message-ID: <20240209084953.GA246045@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240131151446.936281-1-pvorel@suse.cz>
 <20240131151446.936281-5-pvorel@suse.cz>
 <1ad65f0c-430c-4805-83eb-81198303a888@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad65f0c-430c-4805-83eb-81198303a888@suse.cz>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y06A0fHP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yF2eCexm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 ARC_NA(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[25.14%]
X-Spam-Score: -0.71
X-Rspamd-Queue-Id: 340A41F7F2
X-Spam-Flag: NO

Hi Martin,

> Hi,
> for the whole patchset:

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks for your review, merged!

Kind regards,
Petr

> On 31. 01. 24 16:14, Petr Vorel wrote:
> > Due fix in previous version we can run nfsstat01.sh on all NFS versions
> > (added NFSv4, NFSv4.1, NFSv4.2) and on TCP and UDP.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   runtest/net.nfs | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)

> > diff --git a/runtest/net.nfs b/runtest/net.nfs
> > index 463c95c37..9c1c5c63e 100644
> > --- a/runtest/net.nfs
> > +++ b/runtest/net.nfs
> > @@ -94,7 +94,16 @@ nfslock01_v40_ip6t nfslock01.sh -6 -v 4 -t tcp
> >   nfslock01_v41_ip6t nfslock01.sh -6 -v 4.1 -t tcp
> >   nfslock01_v42_ip6t nfslock01.sh -6 -v 4.2 -t tcp
> > -nfsstat01_v30 nfsstat01.sh -v 3
> > +nfsstat01_v30_ip4u nfsstat01.sh -v 3 -t udp
> > +nfsstat01_v30_ip4t nfsstat01.sh -v 3 -t tcp
> > +nfsstat01_v40_ip4t nfsstat01.sh -v 4 -t tcp
> > +nfsstat01_v41_ip4t nfsstat01.sh -v 4.1 -t tcp
> > +nfsstat01_v42_ip4t nfsstat01.sh -v 4.2 -t tcp
> > +nfsstat01_v30_ip6u nfsstat01.sh -6 -v 3 -t udp
> > +nfsstat01_v30_ip6t nfsstat01.sh -6 -v 3 -t tcp
> > +nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
> > +nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
> > +nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp
> >   fsx_v30_ip4u fsx.sh -v 3 -t udp
> >   fsx_v30_ip4t fsx.sh -v 3 -t tcp


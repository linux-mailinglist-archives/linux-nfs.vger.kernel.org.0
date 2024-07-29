Return-Path: <linux-nfs+bounces-5181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFF94001F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 23:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0E2B22749
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29818C35B;
	Mon, 29 Jul 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cPB7o+3k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0l3yynyh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cPB7o+3k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0l3yynyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4D18786A
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287259; cv=none; b=m9vdq+xo7z0WxRxH80WZrhM8joFRgBkKmfxEHrCPq1C9k3obrqAtaplsnUKRLOiYLuUrzfJvWfodpBuDFRLt1RMc5R5PQn7Ou1I3YFweLy6FAMQ0tQ4IHbbLiw0qMuZABWXw0W4RBJw//Ho3llYYONz4eFAw/U/jIVxxwmB0BHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287259; c=relaxed/simple;
	bh=GRsgVkDh5fKeFpy9BmSHmPyDEKSwS+eDF5u3TcEUmh4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gA+4Zl3ofCILBxbOGPmKPvXU7FB9IcIyzai39MzO7l+d39U0+ew53tI4kEwBKcXwOQ+R8jJzLZgGlYx8wpFkwcZjKPxD+r7q48hy/iTUrBFRf3uLg1yYYLqbtZlTumIjvZkg/g5d+WWdhaWNsIoU7FL4XUsPpWedh/11KLwGHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cPB7o+3k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0l3yynyh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cPB7o+3k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0l3yynyh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7089E1F823;
	Mon, 29 Jul 2024 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722287255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Orjh42MPAeYNQOP+MFjwEwK2Us78RAbCLCvH5DFev0=;
	b=cPB7o+3kcsaVPU48nbE1P6ZE8Z5n/ZWfOysQCwyBuUf7QMm3/kXnGTPBm7Z6L4diKWAdh2
	2tVB2wEBLmD11DdIicaYm1XR5XvjmxjIMjaudYlW4bzdNsrxpb4eoaaVyDQBllu1usDEky
	vlKfh19VpIGskhvova0uyCPaUdGsqfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722287255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Orjh42MPAeYNQOP+MFjwEwK2Us78RAbCLCvH5DFev0=;
	b=0l3yynyhJV13iz9zO1trvtf8IqwDwIsFyiMVzJ5yYeDV4W/wMgWM4Peg1GbYx5eT3jBxqj
	YLC3DpahqMhwklAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722287255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Orjh42MPAeYNQOP+MFjwEwK2Us78RAbCLCvH5DFev0=;
	b=cPB7o+3kcsaVPU48nbE1P6ZE8Z5n/ZWfOysQCwyBuUf7QMm3/kXnGTPBm7Z6L4diKWAdh2
	2tVB2wEBLmD11DdIicaYm1XR5XvjmxjIMjaudYlW4bzdNsrxpb4eoaaVyDQBllu1usDEky
	vlKfh19VpIGskhvova0uyCPaUdGsqfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722287255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Orjh42MPAeYNQOP+MFjwEwK2Us78RAbCLCvH5DFev0=;
	b=0l3yynyhJV13iz9zO1trvtf8IqwDwIsFyiMVzJ5yYeDV4W/wMgWM4Peg1GbYx5eT3jBxqj
	YLC3DpahqMhwklAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55478138A7;
	Mon, 29 Jul 2024 21:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BiLkApUEqGZfVAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 21:07:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/2] nfsd: fix handling of error from unshare_fs_struct()
In-reply-to: <Zqeo1c37E6xDDgSA@tissot.1015granger.net>
References: <20240729022126.4450-1-neilb@suse.de>,
 <Zqeo1c37E6xDDgSA@tissot.1015granger.net>
Date: Tue, 30 Jul 2024 07:07:29 +1000
Message-id: <172228724989.18529.183021144838147324@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.10

On Tue, 30 Jul 2024, Chuck Lever wrote:
> On Mon, Jul 29, 2024 at 12:18:19PM +1000, NeilBrown wrote:
> > These two patches replace my previous patch:
> >  [PATCH 07/14] Change unshare_fs_struct() to never fail.
> > 
> > I had explored ways to change kthread_create() to avoid the need for
> > GFP_NOFAIL and concluded that we can do everything we need in the sunrpc
> > layer.  So the first patch here is a simple cleanup, and the second adds
> > simple infrastructure for an svc thread to confirm that it has started
> > up and to report if it was successful in that.
> > 
> > Thanks,
> > NeilBrown
> > 
> > 
> > 
> >  [PATCH 1/2] sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
> >  [PATCH 2/2] sunrpc: allow svc threads to fail initialisation cleanly
> 
> This series does not apply to nfsd-next. It looks like 1/2 expects
> to see the EXPORT_SYMBOL after svc_rqst_alloc() that you already
> removed in "SUNRPC: make various functions static, or not exported."
> 
> Also, 1/2 is From: your brown.name account, but the SoB is your
> SuSE email. (Maybe that doesn't matter).

Probably don't matter.  That happened because I wrote that patch on my
notebook instead of my desktop and they have different defaults.  I'll
try to remember that for next time.

> 
> Can you rebase and resend?

I can't see "SUNRPC: make various functions static, or not exported." in
    git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux 
Am I looking in the wrong place? If not, can you push out nfsd-next?
(and if you could delete "for-next" from there, and possibly other old
cruft, that might help too)

Thanks,
NeilBrown


> 
> In 2/2, what is the reason to make svc_thread_init_status() a static
> inline rather than an exported function? I don't think this is going
> to be a performance hot path, but maybe it becomes one in a future
> patch?
> 
> 
> -- 
> Chuck Lever
> 



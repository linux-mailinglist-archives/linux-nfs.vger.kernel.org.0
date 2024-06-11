Return-Path: <linux-nfs+bounces-3642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B8F902DD2
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 03:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D88281208
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 01:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCA4C8D;
	Tue, 11 Jun 2024 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qwabvw9h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tdAWlzLz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qwabvw9h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tdAWlzLz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328B14A3C
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067807; cv=none; b=HfXxj5ziR12ZHVHTAk/AkB738IrKxxqaHoVg00FCinVdvT4amgo69ScqAGfpaNcMIm6pD7PVMrPpM0TVZl0bTQP1dZ1cdqlgavvZTegS00eFSz8rKaWbKAgd7eEMVzkSImKJp2YwfrGLpdvzJeiKsVnrLRboc+WPdvC2yjZtBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067807; c=relaxed/simple;
	bh=b5L9K7uEVQ+LsuKJkMlC0UPX5nGhLmaBQ+muTwnysOI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=G1y93SU0esi/UPBcWWweHDN5duiM9TTg8oMBbDk6sWgj9RCnFcvR1KxiZR/Olhmfo69dKZQWm/GO6Zkj9SbJrE110kCOpdfihPM0jURd7eAfeVV+4EIvsqsVZrc9AJnh7oTkEre9LBYMsa/fdqg9g/GT9qhu6sizPfUOG1NeegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qwabvw9h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tdAWlzLz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Qwabvw9h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tdAWlzLz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BAE8219B8;
	Tue, 11 Jun 2024 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718067803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmHN95b8X1JYxFZJoTY7hL2GoNpknVwZTn008LmNtCs=;
	b=Qwabvw9h+d1sQaJVAwtvp05fTac4X2FWDq15Q7KaogMR4+yLWfUirXITRGGq1YGDf+Hubi
	vAcbKPmPNrFApwrEV9D5tkb0jq8I47J3TI12xVSOWSZ1MfxVI8H0MGHa2YTK3NRFiIg7p3
	YkBslfX/6ndK0MsM+ac+TjvCgpc950w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718067803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmHN95b8X1JYxFZJoTY7hL2GoNpknVwZTn008LmNtCs=;
	b=tdAWlzLzqifaUYba5/RUELoeeiUSVwztyJC0XIFritRFLtJFi2z4AbArV49S3f6I5gN95Q
	0nWXeggI6YhFtzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718067803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmHN95b8X1JYxFZJoTY7hL2GoNpknVwZTn008LmNtCs=;
	b=Qwabvw9h+d1sQaJVAwtvp05fTac4X2FWDq15Q7KaogMR4+yLWfUirXITRGGq1YGDf+Hubi
	vAcbKPmPNrFApwrEV9D5tkb0jq8I47J3TI12xVSOWSZ1MfxVI8H0MGHa2YTK3NRFiIg7p3
	YkBslfX/6ndK0MsM+ac+TjvCgpc950w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718067803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmHN95b8X1JYxFZJoTY7hL2GoNpknVwZTn008LmNtCs=;
	b=tdAWlzLzqifaUYba5/RUELoeeiUSVwztyJC0XIFritRFLtJFi2z4AbArV49S3f6I5gN95Q
	0nWXeggI6YhFtzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB8D013A51;
	Tue, 11 Jun 2024 01:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id adTLE1iiZ2ZLaQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 11 Jun 2024 01:03:20 +0000
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
Subject:
 Re: [for-6.11 PATCH 04/29] sunrpc: handle NULL req->defer in cache_defer_req
In-reply-to: <903610ef28512c03fd8db6b4b57e65b3a8bda8a9.camel@kernel.org>
References: <>, <903610ef28512c03fd8db6b4b57e65b3a8bda8a9.camel@kernel.org>
Date: Tue, 11 Jun 2024 11:03:16 +1000
Message-id: <171806779662.14261.6943542763312044917@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Mon, 10 Jun 2024, Jeff Layton wrote:
> On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> > From: Weston Andros Adamson <dros@primarydata.com>
> > 
> > Dont crash with a NULL pointer dereference when req->defer isn't
> > set. This is needed for the localio path.
> > 
> > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  net/sunrpc/cache.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > index 95ff74706104..b757b891382c 100644
> > --- a/net/sunrpc/cache.c
> > +++ b/net/sunrpc/cache.c
> > @@ -714,6 +714,8 @@ static bool cache_defer_req(struct cache_req
> > *req, struct cache_head *item)
> >  			return false;
> >  	}
> >  
> > +	if (!req->defer)
> > +		return false;
> >  	dreq = req->defer(req);
> >  	if (dreq == NULL)
> >  		return false;
> 
> I've gone over it many times, but I still don't quite "get" the
> deferral handling code. I think the above is probably safe, but please
> do Cc Neil Brown on later postings of this series since he has a better
> grasp of that code.
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

The patch is bound to be "safe" in a technical sense, but I wonder why
it is necessary.  And if we add code that isn't necessary we could make
the result look confusing, which isn't "safe" in a social sense...

->defer is always set non-NULL before svc_process() is called, and I
don't think cache_defer_req() can be reached without svc_process() being
called.  So I cannot see how ->defer could possibly be NULL.

Can you remove this patch and see if you can trigger a crash.  If you
can I'd love to see the kernel stack.

NeilBrown


Return-Path: <linux-nfs+bounces-3400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FD8CFE29
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 12:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2A22812A3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B685812F;
	Mon, 27 May 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VKZw32PC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHVKTRl2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kOELjz1Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EouhnNv9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083B79E1
	for <linux-nfs@vger.kernel.org>; Mon, 27 May 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805959; cv=none; b=eS92huYy4R/zawvTEE/a6j1MZTPuW2dCxXk6bimwcxvr3lFpqzV8uhLqX6Tgv/3i0c/f7fouIsDlx+AqNXjH05nd7bc7Wqx9PO8mK0xZiyJsHb92bsggYmfukOYIM7inxRNqxb6Cd65gQLNusQ95CBf1kuWWe5CpXcPpU9vpqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805959; c=relaxed/simple;
	bh=TjNNkAQXmBKXHYQY1qZhlCo+eQAP2H6uO2UvW02Ko7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARGXhkuo0Rdqfsa71SJg6TgC8U7Ue+r/b7Ie1vGzdsoIE7LSdWWx3n2DYye96Bf7rlNlCrfD6OGEVaoIeSUKw6oSQG4gEiQFMIUtCTwAbCjcQyYqZjMh1ryOdizqvZaSmDKFGZ7MMcf0oDJLbcX4fkzIotn1qsvRf93eflrfhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VKZw32PC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHVKTRl2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kOELjz1Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EouhnNv9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91DF221DFD;
	Mon, 27 May 2024 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716805954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7wKqAT0deT6oEIQm8DExcQrRQ5vSwxEAI4WvELHNlzY=;
	b=VKZw32PCCH9xM4XVT6aBBqIBX3huDzhgQvlYz63sWA1EUu0OzLS0tjZ6aZv4yn7B9oG9Bm
	UMR2qUx5kj93lK/Q7UkT+LO663oknXKXGxcQmAoG9AFA8B6ZOumyOxuY2DikoCXPNSXczN
	sxAA7TTcaxyg8XYDudWWNIYo6LcXMds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716805954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7wKqAT0deT6oEIQm8DExcQrRQ5vSwxEAI4WvELHNlzY=;
	b=vHVKTRl2ae30hjUMakBt3EJT/ruwycdl2aijyYsRuwtpG8o56sOLvDwRYGd0Bd5hol/f4S
	PnK/2AY26npEe+CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kOELjz1Z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EouhnNv9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716805953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7wKqAT0deT6oEIQm8DExcQrRQ5vSwxEAI4WvELHNlzY=;
	b=kOELjz1ZQ8ZgFaSdyjSqNOo56rOwELb7nMihvWyKpiLWyesHcZhoO5Wj9rAXw4r1bChUv+
	Tn7ABg2LqQY3zutS8avFn/J+csqgHNChAqsIw0bI3Cs6kZBqGYIbTAFwxcETmb90etKr3r
	l0quaAaDuKfrHYGsMZrQIP223HU7PI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716805953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7wKqAT0deT6oEIQm8DExcQrRQ5vSwxEAI4WvELHNlzY=;
	b=EouhnNv9Eu3lwuSGgowsqwq4kdLsskgIu1WMfiONc97LtV176A9BC70f2W9SkAeyGfYqjM
	Q1TeItx/BURoOkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8655B13A56;
	Mon, 27 May 2024 10:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nQy9IEFhVGalGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 27 May 2024 10:32:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A37FA07D0; Mon, 27 May 2024 12:32:33 +0200 (CEST)
Date: Mon, 27 May 2024 12:32:33 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Shelton <dan.f.shelton@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: Bad NFS performance for fsync(2)
Message-ID: <20240527103233.yuwrdjcdfs7lewed@quack3>
References: <20240523165436.g5xgo7aht7dtmvfb@quack3>
 <CAAvCNcB1hsS67Cy6sZP3Mf33VCKfFsg0Vc0pH2XJt0K6Po9ZQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAvCNcB1hsS67Cy6sZP3Mf33VCKfFsg0Vc0pH2XJt0K6Po9ZQQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 91DF221DFD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]

On Fri 24-05-24 19:08:51, Dan Shelton wrote:
> On Thu, 23 May 2024 at 18:55, Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > I've been debugging NFS performance regression with recent kernels. It
> > seems to be at least partially related to the following behavior of NFS
> > (which is there for a long time AFAICT). Suppose the following workload:
> >
> > fio --direct=0 --ioengine=sync --thread --directory=/test --invalidate=1 \
> >   --group_reporting=1 --runtime=100 --fallocate=posix --ramp_time=10 \
> >   --name=RandomWrites-async --new_group --rw=randwrite --size=32000m \
> >   --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1 \
> >   --filename_format='FioWorkloads.$jobnum'
> 
> Where do you get the fio command from?

Well, this is somewhat hand-edited fio command that our QA runs as part of
performance testing of our kernels.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


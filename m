Return-Path: <linux-nfs+bounces-3511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3536B8D6435
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BB91C2598C
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC516F85C;
	Fri, 31 May 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YDduCa7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N58seZjG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YDduCa7t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N58seZjG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26B176228
	for <linux-nfs@vger.kernel.org>; Fri, 31 May 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164764; cv=none; b=F4QfjJCskBDXmEkkQLxtHnjXWTCHcD7vIBz609BzG99m/rhXhefFzkTKU8vDh1WsrVakoRfJnaX3brAVmPAP6d5d+V8AGh0YoOrzcbTnhvWVLFz0/PrynE5xOFCruIZ9HuDH5Sl/weaCj7KjFp+na8tVGdTtCGKR6t2RhuBy5gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164764; c=relaxed/simple;
	bh=gdT5hy4kcndci+E1sN42JIFcD6sLXzWHw5OgGJqxbbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQcShDqJgpdlflhNJRhvG/JNVIpJ6Nw4bs5X6F5k/l7ZbH3Lpxr2KX64VBbU1yydLlnRE8BwGJQXbeOMvzmXuOr98z5nK7sXsfaNm+sjsPWOQ0PbbwfC5m6OqJEPSz4yKKiSbIxO0ym9wZeCUCxRqNg92uyIuIu5q34hnI/Bpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YDduCa7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N58seZjG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YDduCa7t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N58seZjG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9497321AD9;
	Fri, 31 May 2024 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717164759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv2/I2H0oAgyCEyHV93+fNsOBVxzv7RP4DJlstQ7idc=;
	b=YDduCa7tUizkHlI0pYT4vZ4/ydNEK/9RjAqDTzQt6YxKYoXzYmBP0Ki8NSO6XaG/70S7Lo
	ODq1Cb/VSczukwJE1AOGN0c3M+H0DeEbfGxbxIqmaIsRisPApBiEyOdvyh8nezRDJIjP/y
	+oclCNp0QrRbXEbw5mUlZmAg4bt9lzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717164759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv2/I2H0oAgyCEyHV93+fNsOBVxzv7RP4DJlstQ7idc=;
	b=N58seZjGv9lTrmOyUlTcXKdDeGeyxA/7sjI/zO7ufvKzYnfvYGOW9Z/HGFfmpu3TPNrwKG
	4k6MD9NwQgERJIAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YDduCa7t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N58seZjG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717164759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv2/I2H0oAgyCEyHV93+fNsOBVxzv7RP4DJlstQ7idc=;
	b=YDduCa7tUizkHlI0pYT4vZ4/ydNEK/9RjAqDTzQt6YxKYoXzYmBP0Ki8NSO6XaG/70S7Lo
	ODq1Cb/VSczukwJE1AOGN0c3M+H0DeEbfGxbxIqmaIsRisPApBiEyOdvyh8nezRDJIjP/y
	+oclCNp0QrRbXEbw5mUlZmAg4bt9lzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717164759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv2/I2H0oAgyCEyHV93+fNsOBVxzv7RP4DJlstQ7idc=;
	b=N58seZjGv9lTrmOyUlTcXKdDeGeyxA/7sjI/zO7ufvKzYnfvYGOW9Z/HGFfmpu3TPNrwKG
	4k6MD9NwQgERJIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B606137C3;
	Fri, 31 May 2024 14:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VxUDItfaWWajcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 31 May 2024 14:12:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B983A0877; Fri, 31 May 2024 16:12:35 +0200 (CEST)
Date: Fri, 31 May 2024 16:12:35 +0200
From: Jan Kara <jack@suse.cz>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>
Subject: Re: NFS write congestion size
Message-ID: <20240531141235.gthl6nvyrb354rfc@quack3>
References: <>
 <a86fdd86-7c3a-44e9-9d49-4b3edfab66e6@grimberg.me>
 <171706807360.14261.8929224868643154972@noble.neil.brown.name>
 <faf945a9-d1bc-45db-9543-057b7bc0ed8d@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf945a9-d1bc-45db-9543-057b7bc0ed8d@grimberg.me>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9497321AD9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 30-05-24 21:19:55, Sagi Grimberg wrote:
> > > btw, I think you meant that *slower* devices may need a larger queue to
> > > saturate,
> > > because if the device is fast, 256MB inflight is probably enough... So
> > > you are solving
> > > for the "consumer grade contemporary disks".
> > No, faster devices.  The context here is random writes.  The more of
> > those that are in the queue on the server, the more chance it has to
> > re-order or coalesce requests.
> 
> Umm, what would reorder help with if writes are random?

Well, even though writes are random, they are still from a limited space so
the more of them you have, the larger contiguous chunks you are actually
going to get. But that's not really the main helping factor here. The main
benefit of allowing more than 256MB to be fed into the server is indeed
that the writeback on the server can be more contiguous. With 256MB limit
what I see is that the server gets the data, then commit which triggers
writeout of the data on the server, the server then signals completion and
idles before the it gets more data from the client. With say 1GB or larger
limit, the server has some data to write most of the time so overall
throughput and disk utilization is much better.

So it is all about how latency of the network, the speed of the storage and
batching of writeback completions plays together. And yes, we can just
increase the limit but my opinion still is that limiting the number of MB
of writeback we have outstanding against the server is a wrong way of
throttling things because that number is difficult to get right without
knowing storage speeds, network speeds, load from other clients and
internals of page writeback...

I understand Trond's concerns about latency increase as well as your
concerns about overloading the server with RPC traffic so perhaps we need
*some* mechanism by which the client can detect contention. But I think we
need to come up with something better than fixed number of MB...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


Return-Path: <linux-nfs+bounces-5002-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC29386A6
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jul 2024 01:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF041C20A58
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Jul 2024 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F121119A;
	Sun, 21 Jul 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HLMV2/7t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCJcAuJX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HLMV2/7t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCJcAuJX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63738C8D1;
	Sun, 21 Jul 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721604334; cv=none; b=a3aHbWpRXuH044C0co2WVZxigOW7nMuHyWosDrGQl15QvXWHE7rq3Q14Ai3fTjnLOTMCs8BoIYd3+/VHJLiRjcTf8ZqlwwpHVNluvaz7ObTipNHQcWaXK+tzXgJhYcqBa3sRwHdahp1uP6Biq/+2Ag+JKujd1VJvdS0RlP6AXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721604334; c=relaxed/simple;
	bh=CbaYzrUD2iMm2wdIHqFl4k72sqXFd+rW/EZyjaakQ+A=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Gx8rKNV90gDRW1rnckZg7z9Mo1uJ/bZpmNpfLlRmrZrkOvIxlccCW4I25uEp1yAQFQrkPEp8pv8dzkFiAriHyHR7tx1OjXPCVRGTrdNpAE61IFFd9G65RXjkTHxNpf7bAF+TDkD9VS1wEULgwrpldPzBg8JDsqHeKk4sDrJF8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HLMV2/7t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCJcAuJX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HLMV2/7t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCJcAuJX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7778B2189C;
	Sun, 21 Jul 2024 23:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721604330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk1jHAwGkiu6UCef6ZEZVtApSi1BPm7kBs9tfGFJ7rk=;
	b=HLMV2/7tM9cqZXpRQyjpAFh5lB+OG+Wj19ADR8xdY9ZpAYVe8HCzz8zOP3/pDlZeGflgiu
	fYBBVrITfbff3irQYEBSzeqSc5XraQ1VPdvb4TtS/uAR4vh+7GNJUMfUw70ee6YPRKDeAa
	FGyyghTHr2C+JyCPuJsoC827Px8t8D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721604330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk1jHAwGkiu6UCef6ZEZVtApSi1BPm7kBs9tfGFJ7rk=;
	b=UCJcAuJXXRo9nEzL+fb885jzBJ0ABf3lYlPXesaj2jAg4ZAp4ueTAGZ2mW5nSfVBtXgttU
	UxinaAERnUkaVUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721604330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk1jHAwGkiu6UCef6ZEZVtApSi1BPm7kBs9tfGFJ7rk=;
	b=HLMV2/7tM9cqZXpRQyjpAFh5lB+OG+Wj19ADR8xdY9ZpAYVe8HCzz8zOP3/pDlZeGflgiu
	fYBBVrITfbff3irQYEBSzeqSc5XraQ1VPdvb4TtS/uAR4vh+7GNJUMfUw70ee6YPRKDeAa
	FGyyghTHr2C+JyCPuJsoC827Px8t8D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721604330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk1jHAwGkiu6UCef6ZEZVtApSi1BPm7kBs9tfGFJ7rk=;
	b=UCJcAuJXXRo9nEzL+fb885jzBJ0ABf3lYlPXesaj2jAg4ZAp4ueTAGZ2mW5nSfVBtXgttU
	UxinaAERnUkaVUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67430132CB;
	Sun, 21 Jul 2024 23:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJNaB+eYnWb9VwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 21 Jul 2024 23:25:27 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Steve Dickson" <steved@redhat.com>
Subject:
 Re: [PATCH] nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd sockets
In-reply-to: <Zpq4Ziq9YVuGqV7b@tissot.1015granger.net>
References: <20240719-nfsd-next-v1-1-b6a9a899a908@kernel.org>,
 <Zpq4Ziq9YVuGqV7b@tissot.1015granger.net>
Date: Mon, 22 Jul 2024 09:25:07 +1000
Message-id: <172160430713.18529.16870160544594676027@noble.neil.brown.name>
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On Sat, 20 Jul 2024, Chuck Lever wrote:
> On Fri, Jul 19, 2024 at 02:55:53PM -0400, Jeff Layton wrote:
> > When creating nfsd sockets via the netlink interface, we do want to
> > register with the portmapper. Don't set SVC_SOCK_ANONYMOUS.
> 
> NFSD's RDMA transports don't register with rpcbind, for example.

For RDMA, what does inet->sk_family and in->sk_protocol contain in
svc_setup_socket()? 

Could that code detect that it doesn't make sense to register the socket
with rpcbind?

NeilBrown


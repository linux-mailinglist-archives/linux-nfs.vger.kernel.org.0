Return-Path: <linux-nfs+bounces-8417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4379E821E
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 21:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3845718819A3
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Dec 2024 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F781547C8;
	Sat,  7 Dec 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yifr0ubk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nnFdG1d3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N8pxT9yj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IbVF0kHu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1515359A
	for <linux-nfs@vger.kernel.org>; Sat,  7 Dec 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733604797; cv=none; b=LB6HLUchQn1ONGEC9v1cfPlo7wtEOeKNlD37F0Zt6L7Qc0eLuLVSUxw15KKucjKWvXNECjMG/nZXj8gijBMOxadSgiwRouulPxgb9xXB2GT86jElCvOOLeo6Wn7FnSfVB6+jtZzgNvz++10uSL/XimLl78FAjwiJM8+/ba/ls2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733604797; c=relaxed/simple;
	bh=k5abR8jTkFIitRhsSFSy/d0i09usgMBPyDK7Rsphusk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Tcp/zoyJx5yn16UB1YZXUviD82ejL2vUq7tiJ2dX8jSlayU2Mp4FSW710KgdFOhaD3naz4V4ayorCHN83UFTe//R5bdZ728R5dRLxB1uJryLkfyLRAT02uWukRuFNtqYzbUAo4hjbEQdsuP3S/BnJl2Xg1wuJY/8zAxt4vEn3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yifr0ubk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nnFdG1d3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N8pxT9yj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IbVF0kHu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E11DD2115D;
	Sat,  7 Dec 2024 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733604793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2Dide88x1OE06GBfPheUZfPknGItVVjpOu77szerY=;
	b=Yifr0ubkndf5JbKoYQnlc6jN6a3xbrvjWXNMdG3HSEcjoJ78R9PiWyAfzBJgoC7ATSneDr
	06ol/YN6B8mYi9COu+zJVhJAa3iOgp84eAxw9FalmWwFWfuijcHWQRA7pwwIIGHZRaC2RE
	EipCQaFVf/P3XVZbq8GUaOKJ+ShuGis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733604793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2Dide88x1OE06GBfPheUZfPknGItVVjpOu77szerY=;
	b=nnFdG1d3i6Zpisj1+iTibwepWYlJ09yPfRJZQ6A+N7dJAtSwA0QSg0Lbc9z938j70AGRnN
	DO4JvUWKZqpxF2DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N8pxT9yj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IbVF0kHu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733604792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2Dide88x1OE06GBfPheUZfPknGItVVjpOu77szerY=;
	b=N8pxT9yjwc9inmOkM3aZwjOyKf2kmfblURMMerOSDwfoEGTdQyHhqtZxI1g716MnBrPAE9
	3ND2xlLK1QxgoJb/wfnBdXUL4n6xeOc15UmwWBOZIBkT03YbDda3Umr1SqZLWXTxTQdt01
	hIO1PtqbcjZu5GInnK9wObI3DrukZW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733604792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y2Dide88x1OE06GBfPheUZfPknGItVVjpOu77szerY=;
	b=IbVF0kHuS8N2gg6fW1AXzVb8Hmn5RLPmeP9jzLJ+XT+VGuqURMjg8k0IIBtvEkDsRehYwS
	C5YHkGtAddq0JNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6100C139AA;
	Sat,  7 Dec 2024 20:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id giHIBbe1VGdsIQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 07 Dec 2024 20:53:11 +0000
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
Cc: "Roland Mainz" <roland.mainz@nrubsig.org>,
 "Steve Dickson" <SteveD@redhat.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [patch] mount.nfs: Add support for nfs://-URLs ...
In-reply-to: <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
References:
 <CAKAoaQmaf7d01vK4TfR+=8k4CVN-CX3ESPFh88EaxvcOAQDWtQ@mail.gmail.com>,
 <fb7bf50a-29d3-4543-90e8-617fdd205f76@oracle.com>
Date: Sun, 08 Dec 2024 07:53:07 +1100
Message-id: <173360478780.1734440.2745315303841080285@noble.neil.brown.name>
X-Rspamd-Queue-Id: E11DD2115D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 07 Dec 2024, Chuck Lever wrote:
> Hi Roland, thanks for posting.
> 
> Here are some initial review comments to get the ball rolling.
> 
> 
> On 12/6/24 5:54 AM, Roland Mainz wrote:
> > Hi!
> > 
> > ----
> > 
> > Below (and also available at https://nrubsig.kpaste.net/b37) is a
> > patch which adds support for nfs://-URLs in mount.nfs4, as alternative
> > to the traditional hostname:/path+-o port=<tcp-port> notation.
> > 
> > * Main advantages are:
> > - Single-line notation with the familiar URL syntax, which includes
> > hostname, path *AND* TCP port number (last one is a common generator
> > of *PAIN* with ISPs) in ONE string
> > - Support for non-ASCII mount points, e.g. paths with CJKV (Chinese,
> 
> s/mount points/export paths
> 
> (When/if you need to repost, you should move this introductory text into
> a cover letter.)
> 
> 
> > Japanese, ...) characters, which is typically a big problem if you try
> > to transfer such mount point information across email/chat/clipboard
> > etc., which tends to mangle such characters to death (e.g.
> > transliteration, adding of ZWSP or just '?').
> > - URL parameters are supported, providing support for future extensions
> 
> IMO, any support for URL parameters should be dropped from this
> patch and then added later when we know what the parameters look
> like. Generally, we avoid adding extra code until we have actual
> use cases. Keeps things simple and reduces technical debt and dead
> code.
> 
> 
> > * Notes:
> > - Similar support for nfs://-URLs exists in other NFSv4.*
> > implementations, including Illumos, Windows ms-nfs41-client,
> > sahlberg/libnfs, ...
> 
> The key here is that this proposal is implementing a /standard/
> (RFC 2224).

Actually it isn't.  You have already discussed the pub/root filehandle
difference.  The RFC doesn't know about v4.  The RFC explicitly isn't a
standard.

So I wonder if this is the right approach to solve the need.

What is the needed?
Part of it seems to be non-ascii host names.  Shouldn't we fix that for
the existing syntax?  What are the barriers?

Part seems to be the inclusion of the port number.  Is a "URL" really
the best way to solve that need?
Mount.nfs currently expects ":/" to separate host name from path.
I think host:port:/path would be unambiguous providing "port" did not
start "/".

Do we really need the % encoding that the URL syntax gives us?  If so -
why?

NeilBrown


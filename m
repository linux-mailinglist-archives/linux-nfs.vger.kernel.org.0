Return-Path: <linux-nfs+bounces-6526-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DD697A9A8
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 01:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763F31C27664
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359AF165F19;
	Mon, 16 Sep 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UONCTQ3B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VpJ7oimK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UONCTQ3B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VpJ7oimK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F823165EE6
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529575; cv=none; b=sZpqrwV448CsCgBPay2hiGVp8jE4R2bpzyP8JieumEG5MJ5r68nogvBwjsHpywXHUMyTqSasTvwiCqGZ2IrUW2c7dV/XyMvvF79Lbf5gmY7wJdaCQUboo2ijHIi6moVBC6KR9tYv6RI/oGGerFePr4iI8AgDBYAjJeEIHXYrro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529575; c=relaxed/simple;
	bh=NIF5zyJfsE9Ux3z5DBBSZhO8SsPoj+lwO6ldNydrJiU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JVUwN7JOfQIk7VnLOH5yAew5eAv/GpzuF94ahV8WNUqAfKatTzCFn9wPCHbP45kCGw6Hj5BTRrTzjR0CoepaJyq1I1vvVYitTpxOfivjZo7uc4kbcF2bIPekMEIKsc5A5klC2PywCDBmVTe2G3+XZL49bsHzNSssmdWM/Pa3MXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UONCTQ3B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VpJ7oimK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UONCTQ3B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VpJ7oimK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B766A21D5A;
	Mon, 16 Sep 2024 23:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726529565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9asgaM2dbWb8BjzCfzmDC2NtmAaM+teMj0zP29Zl/U=;
	b=UONCTQ3BTjHRy3CbCnXe58GwEEuHLSqGCSFG6vf1mU2YfG2hklVPE4whtE5L6slWLcZT1q
	Zlrwq5txwzfahjNVa9TAOjJ1v8SD4lnG99FMIByAjNJcmmBC4X0IeRh1eME9XddJiIH3pN
	6igO4R9vGSxQFG1VoMVL+YZAWIUknrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726529565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9asgaM2dbWb8BjzCfzmDC2NtmAaM+teMj0zP29Zl/U=;
	b=VpJ7oimKbj1WMgRO7QznkP0YEYpHVKPsfJxURQW0DZMa1jE/CWqnv2PtcIrjEntEY36H1e
	tF2bHxjqglp7zdDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726529565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9asgaM2dbWb8BjzCfzmDC2NtmAaM+teMj0zP29Zl/U=;
	b=UONCTQ3BTjHRy3CbCnXe58GwEEuHLSqGCSFG6vf1mU2YfG2hklVPE4whtE5L6slWLcZT1q
	Zlrwq5txwzfahjNVa9TAOjJ1v8SD4lnG99FMIByAjNJcmmBC4X0IeRh1eME9XddJiIH3pN
	6igO4R9vGSxQFG1VoMVL+YZAWIUknrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726529565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9asgaM2dbWb8BjzCfzmDC2NtmAaM+teMj0zP29Zl/U=;
	b=VpJ7oimKbj1WMgRO7QznkP0YEYpHVKPsfJxURQW0DZMa1jE/CWqnv2PtcIrjEntEY36H1e
	tF2bHxjqglp7zdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DDA11397F;
	Mon, 16 Sep 2024 23:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x/DYOBvA6GYaSAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 16 Sep 2024 23:32:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Steven Price" <steven.price@arm.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
In-reply-to: <5c90c3d0-c51f-4012-9ab6-408d023570c8@arm.com>
References: <172558992310.4433.1385243627662249022@noble.neil.brown.name>,
 <5c90c3d0-c51f-4012-9ab6-408d023570c8@arm.com>
Date: Tue, 17 Sep 2024 09:32:36 +1000
Message-id: <172652955677.17050.4744720185342907808@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 17 Sep 2024, Steven Price wrote:
> 
> Hi Neil,
> 
> I'm seeing issues on a test board using an NFS root which I've bisected
> to this commit in linux-next. The kernel spits out many errors of the form:
> 
> [    7.478995] NFS: v4 server <ip>  returned a bad sequence-id error!
> [    7.599462] NFS: v4 server <ip>  returned a bad sequence-id error!
> [    7.600570] NFS: v4 server <ip>  returned a bad sequence-id error!
> [    7.615243] NFS: v4 server <ip>  returned a bad sequence-id error!
> [    7.636756] NFS: v4 server <ip>  returned a bad sequence-id error!
> [    7.644808] NFS: v4 server <ip>  returned a bad sequence-id error!
> [    7.653605] NFS: v4 server <ip>  returned a bad sequence-id error!
> [    7.692836] NFS: nfs4_reclaim_open_state: unhandled error -10026
> [    7.699573] NFSv4: state recovery failed for open file
> arm-linux-gnueabihf/libgpg-error.so.0.29.0, error = -10026
> [    7.711055] NFSv4: state recovery failed for open file
> arm-linux-gnueabihf/libgpg-error.so.0.29.0, error = -10026
> 
> (with the filename obviously varying)
> 
> The NFS server is a standard Debian 12 system.
> 
> Any ideas?

Not immediately.  It appears that when the client opens a file during
recovery, the server doesn't like the seqid that it uses...

Recover happens when the server restarts and when the client and server
have been out of contact for an extended period or time (>90 seconds by
default).
Was either of those the case here?  Which one?

Are you able to capture a network packet trace leading up to and
including these errors?  Something like:

   tcpdump -i any -s 0 -w /tmp/nfs.pcap port 2049

on the client (or server), then run the test which triggers the errors,
then interrupt the tcpdump.
Hopefully the nfs.pcap won't be too big and you can compress it and
email it to me.  Hopefully it will contain some useful hints.

Thanks for the report,
NeilBrown


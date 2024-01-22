Return-Path: <linux-nfs+bounces-1256-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11A837579
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1405B1F29C27
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462647F72;
	Mon, 22 Jan 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IDjC1U9d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ph8+enV6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IDjC1U9d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ph8+enV6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FB48CCC;
	Mon, 22 Jan 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959317; cv=none; b=QXs4Vso63rMeFgEEUnUXGJHf7RsJfHSmXvMnK9C1H3TZ0T1+VW1S4RgyvGnceOp+3YGo2F2lly9WXowSa3tgHuaVktnEdsS89ysjHGFfibb58AoepcXwcD/MiqnHKYAHJ7/QGEwtyThBLOnbCC05ixI9dEilcDExynS756OFAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959317; c=relaxed/simple;
	bh=rgrHix7tDW0Y8dDHErogRpVc+t2jcmJfydihB1V7DM0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Jd364Z+zH/3n4YqUblBVmytAkgsIDyerx4vFewfMyT8wT5PXxK9SK6EO/z39WM2/niiz5x2S2jJByc83OLs+cCuw1tezZxkIDSLBIztHBZx48EQn1kOAoReTRbmhF7BpkLqL1+09j3XydysAWYtsV+KTWFQZngn/g6JYv4VOjbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IDjC1U9d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ph8+enV6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IDjC1U9d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ph8+enV6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C111521F65;
	Mon, 22 Jan 2024 21:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705959313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU1meYvz04WxH8QZCx7k9EvWItvFczTKV2VqJvaq35M=;
	b=IDjC1U9dZQXBCu34UOTObZ4CM3wBpYD9l2jAvrComQr+kdNJCCF2e4MJs+6iSKWBXNMxn+
	i/yOyjLL7QqapGYvo4XgnyB4OmcptUu6DfTcCN711V+dZiuUqe9WNELMI/58Yla3v8W31m
	SpTuRPlPHQheHoEE1Evttwn/1tAkc9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705959313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU1meYvz04WxH8QZCx7k9EvWItvFczTKV2VqJvaq35M=;
	b=ph8+enV6PrYhSDTtqaRbH5AC+74LteDdZh+m8qWKrlZJ+2exWrqDbn4WAxI7zkD/+eefyw
	4xLGV5t/++dSvwBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705959313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU1meYvz04WxH8QZCx7k9EvWItvFczTKV2VqJvaq35M=;
	b=IDjC1U9dZQXBCu34UOTObZ4CM3wBpYD9l2jAvrComQr+kdNJCCF2e4MJs+6iSKWBXNMxn+
	i/yOyjLL7QqapGYvo4XgnyB4OmcptUu6DfTcCN711V+dZiuUqe9WNELMI/58Yla3v8W31m
	SpTuRPlPHQheHoEE1Evttwn/1tAkc9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705959313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QU1meYvz04WxH8QZCx7k9EvWItvFczTKV2VqJvaq35M=;
	b=ph8+enV6PrYhSDTtqaRbH5AC+74LteDdZh+m8qWKrlZJ+2exWrqDbn4WAxI7zkD/+eefyw
	4xLGV5t/++dSvwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2494C136A4;
	Mon, 22 Jan 2024 21:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r/WHM47frmVnUgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 22 Jan 2024 21:35:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Lorenzo Bianconi" <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
 lorenzo.bianconi@redhat.com, kuba@kernel.org, chuck.lever@oracle.com,
 horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
In-reply-to: <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
References: <cover.1705771400.git.lorenzo@kernel.org>,
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>,
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
Date: Tue, 23 Jan 2024 08:35:07 +1100
Message-id: <170595930799.23031.17998490973211605470@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IDjC1U9d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ph8+enV6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[12.42%]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: C111521F65
X-Spam-Flag: NO

On Tue, 23 Jan 2024, Jeff Layton wrote:
> On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> > Introduce write_ports netlink command. For listener-set, userspace is
> > expected to provide a NFS listeners list it wants to enable (all the
> > other ports will be closed).
> > 
> 
> Ditto here. This is a change to a declarative interface, which I think
> is a better way to handle this, but we should be aware of the change.

I agree it is better, and thanks for highlighting the change.

> > +	/* 2- remove stale listeners */
> 
> 
> The old portlist interface was weird, in that it was only additive. You
> couldn't use it to close a listening socket (AFAICT). We may be able to
> support that now with this interface, but we'll need to test that case
> carefully.

Do we ever want/need to remove listening sockets?
Normal practice when making any changes is to stop and restart where
"stop" removes all sockets, unexports all filesystems, disables all
versions.
I don't exactly object to supporting fine-grained changes, but I suspect
anything that is not used by normal service start will hardly ever be
used in practice, so will not be tested.

So if it is easiest to support reverting previous configuration (as it
probably is for version setting), then do so.  But if there is any
complexity (as maybe there is with listening sockets), then don't
add complexity that won't be used.

Thanks,
NeilBrown


Return-Path: <linux-nfs+bounces-14485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28421B59520
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 13:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF9C1B2807E
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572F72D73B2;
	Tue, 16 Sep 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iRsl15wP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QVJuz3Oz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iRsl15wP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QVJuz3Oz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5640283FE0
	for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022116; cv=none; b=p+eLvKnuvjI5YzycRP4JMwxG/jFbPrnviwlfKC/srG0XH+935E98j8hKgPmRkaitQ15B3szG74HNfsjinIV806hrCgWS3tO5E6RoDUnkskWJ6dG40Ldd82UuqwGZL/cyty4mdXtpCjnZI91ses7lY1t091kFUWRIe55tBVf1dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022116; c=relaxed/simple;
	bh=SqVgP+GfGAadYcUao5GJvrjWwnaMdU9RUmqq01HfK7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xj3OXV/Bz8glOWWB8hkVgGzPIB7pewWKR/gn1bZyLK+Di+lvoTEzE1kqB+ekr7iybfElw7EZQOtRhXOohQ1I4HSW/RbbmtN87zHWVEJ/xpBQNj1fbV71xWg+BqTJ1CdyubQr8D0ByFRXQrcbu5Jn7SJdf8HHhfy4qldoBnkIULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iRsl15wP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QVJuz3Oz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iRsl15wP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QVJuz3Oz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CE0221E2A;
	Tue, 16 Sep 2025 11:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758022112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=iRsl15wPBs+dpd5s3bWELQcCCYZvA4kVggDx5MyyLfYHvMUo8/E2nULZx4lM5y0ZBuXSyU
	6ldC+EHot2bA+mh1u6AXEJtFQJk8Xb5rBSt79e+uJ4xw8c12XJTbo1uVjwBCTA3DbYZyBM
	FdEnK3a44FLYoX5QVd/5BwThhZvurYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758022112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=QVJuz3Oz116B1y/b/5jqbhtvr1Mu3RUlMpdnnaKv+thZTJrM4Oq7iUxsXCeiKcQe6nvIM7
	Kukzafq15n4Cc5Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iRsl15wP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QVJuz3Oz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758022112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=iRsl15wPBs+dpd5s3bWELQcCCYZvA4kVggDx5MyyLfYHvMUo8/E2nULZx4lM5y0ZBuXSyU
	6ldC+EHot2bA+mh1u6AXEJtFQJk8Xb5rBSt79e+uJ4xw8c12XJTbo1uVjwBCTA3DbYZyBM
	FdEnK3a44FLYoX5QVd/5BwThhZvurYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758022112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9oCpgqurBom31W/n+RHNghX4/6UcJ4QSLsIdYBaQMw=;
	b=QVJuz3Oz116B1y/b/5jqbhtvr1Mu3RUlMpdnnaKv+thZTJrM4Oq7iUxsXCeiKcQe6nvIM7
	Kukzafq15n4Cc5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB93513ACD;
	Tue, 16 Sep 2025 11:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+4DMd9JyWgTZAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 16 Sep 2025 11:28:31 +0000
Message-ID: <40c707d6-db49-40a8-8372-7c3a91c2ff5f@suse.de>
Date: Tue, 16 Sep 2025 13:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
To: Jakub Kicinski <kuba@kernel.org>, Keith Busch <kbusch@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>,
 Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, trondmy@hammerspace.com, anna.schumaker@oracle.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, neil@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com, horms@kernel.org
References: <20250731180058.4669-1-okorniev@redhat.com>
 <20250731180058.4669-4-okorniev@redhat.com>
 <CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
 <aMg0jDkXOd8E7Ihj@kbusch-mbp> <20250915144651.7bec7ad4@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250915144651.7bec7ad4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0CE0221E2A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/15/25 23:46, Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 09:45:16 -0600 Keith Busch wrote:
>> On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
>>> Dear NvME maintainers,
>>>
>>> Are there objections to this patch? What's the path forward to
>>> including it in the nvme code.
>>
>> Sorry for the delay here. This series is mostly outside the nvme driver,
>> so we need at least need an Ack from the networking folks if we're going
>> to take this through the nvme tree.
> 
> In case you decide to take it, LGTM:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks!
> 
Okay, after further thinking I would vote for the
NVMe tree after all. There are more patches queued
up which will require these changes, and life will
be easier if we had just one branch where we could
base them on.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


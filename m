Return-Path: <linux-nfs+bounces-22393-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3oXbIYO2J2r90wIAu9opvQ
	(envelope-from <linux-nfs+bounces-22393-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 08:45:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FD965CE82
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 08:45:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uO+CVRNC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=69E88WFq;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tSSm9SWF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ykD56Yw/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22393-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22393-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E36C830EB647
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621E3D47D9;
	Tue,  9 Jun 2026 06:41:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAA3D75DC
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2026 06:41:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987268; cv=none; b=DmmJ/ERWelSl71ZvT61uYlZb0NE9+AiAqjA1PSOoWDGFjQk8zN2LPf3D0lgIaPVvPf7xGkdJqari/8doo6/c746A2QouB7oEIgpeBTKvFoeEfY6NzbvXb9w8bKOh0VZfbMnaHpOiyWL+dJMbTJSU2vuSDwlYmHNh9Hmyg3EO1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987268; c=relaxed/simple;
	bh=1i6O7smi8pGqu1NkRTlp9NFuy+eH84BhR9S9/Of+6b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqPfKhRO59lHaoH8B79UOMiP7y9UVStrdCGFFZmibUfmq2IpjQSaBkHB40poQrGsM6rinNIcxHpcMpnEilHHSz9jYOf0JQrkkH167/+8oQHEIvm6J0rNbSegnozLozu84nSaytRRcioQiGihEkp6BjDUR0DMq2NW76jp9Aun+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uO+CVRNC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=69E88WFq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tSSm9SWF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ykD56Yw/; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4148375A1E;
	Tue,  9 Jun 2026 06:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780987263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=uO+CVRNCVQNPJGpGo84zxPmocmTGbnUhLoV8MliKlsH5YGkBncbjbLtHmHzhuiUlBaE39k
	6rsIaaAb24XnvKmTz6o9XzykF8goFUncuhmQpARCvUBO9MVrYdjbFLqOxoExqdsxfrPDDv
	enrS7D3C6um5GeOY4wldYZWstn26Gt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780987263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=69E88WFqJZAWV1eGCkfLrbih0oqp1SWf7BqiFsJtOw7J250qXVOYQxQ3aaGk7B0xOWQ4R3
	PXvjETXgf1pLGrBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780987262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=tSSm9SWFlcl2Oz2TziMuAy9qLSMcs8sSmKLFGOflXo/jRrD6zFo9rQaUjYAirvWHuw4Rg0
	37jC5Cor11PKXjm7lqVtYkCxAWFa7mqkzjlCtfnMkQ+X71UoC04Mj2yhCpL4vSPG1CtbvP
	70nR/doZeKmuA2T2PAOZJjNvT/5GEwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780987262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cO0TS6ZXRdzfE2WsluHxfQNoDvWGY14VYEsWciA7wwQ=;
	b=ykD56Yw/RLLYbvoR3fovvfzZeSZOKIYyDCd6BMcQ4FOCCQt9KQlPhvrM0OxtxU0Uvirzmw
	o2rybcBNgv+BYsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64393779A7;
	Tue,  9 Jun 2026 06:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fDHdFn21J2oAbwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 06:41:01 +0000
Message-ID: <40199ef9-416e-4a58-908a-ed514dfd6ff2@suse.de>
Date: Tue, 9 Jun 2026 08:41:00 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] handshake: Add tags to "done" downcall
To: Chuck Lever <cel@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-2-47bd1d94d552@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605-tls-session-tags-v1-2-47bd1d94d552@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22393-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01FD965CE82

On 6/5/26 19:34, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> We'd like tlshd to tag certificates according to admin-defined
> characteristics. The tag list is to be returned on a successful
> handshake. Upper Layer Protocols (such as NFS) can then authorize
> access based on the set of tags returned to the kernel.
> 
> For example, suppose NFSD wants to restrict access to an export to
> only clients that present certificates whose issuer DN contains
> "O=Oracle". tlshd can parse incoming certificates, and add an
> "oraclegroup" tag to handshakes where a client presents a
> certificate with "O=Oracle" somewhere in its Issuer field. NFSD can
> then be configured to look for that tag and permit access only when
> it is present. NFSD needs no knowledge of x.509 certificates.
> 
> This patch plumbs in the netlink protocol elements for tlshd to
> return a list of tags to the kernel when a TLS or QUIC handshake
> succeeds. Subsequent patches add tag extraction and storage in
> the handshake layer.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   Documentation/netlink/specs/handshake.yaml | 11 +++++++++++
>   include/uapi/linux/handshake.h             |  3 +++
>   net/handshake/genl.c                       |  5 +++--
>   3 files changed, 17 insertions(+), 2 deletions(-)
> 
Not sure if I agree with this; to my untrained eye the 'tag' attribute 
is just a string, and someone else will have to parse that. But we
are at the netlink level here, so we _can_ have nested tags.
Wouldn't it be better to make 'tags' a nested tag (ie a list of tags)
such that we can avoid parsing in the caller/consumer?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


Return-Path: <linux-nfs+bounces-22392-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Duk+COezJ2pZ0wIAu9opvQ
	(envelope-from <linux-nfs+bounces-22392-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 08:34:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149E65CCFC
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 08:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lKukEZ87;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QHhtorVo;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hFGuxsAa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VJ07OCIE;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22392-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22392-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB0893004603
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11337C929;
	Tue,  9 Jun 2026 06:33:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2DCA4E
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2026 06:33:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986838; cv=none; b=PE/MnA93hY6VYJPqKbOPz9SjLqWERb1xb/P7mDGwvKMTHpwO6Ew+JZmAG6BLvq/1ijdsvX8yR5HkAxiegEVTdZgRDz/Vvddiwr7QpkRJRKD+CMhROumdMy0hZNRAncwVC6qBdkqvgphD8j95l6rlBypXz1ZDm0Q/KPn+PICjCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986838; c=relaxed/simple;
	bh=NcfAmqX1/Os0ct/tHp8ao3ztXfVLp7vHO87xAKg7398=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wd1LrAgle6Y4YupbCUwgBcWi6TowIEtxfZXuUUe1berqcrEdexMsfgHA2gRAebx6eyFVXJlOrbhiARHR4cFYdi0QjVkhl/XP/G8TyZcLhBhzpDumW8Di/Mr8T9xLSIBWkrghNzj0+bP8FJNdnZwcck9UHy72/nfaHzG6HHvcIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lKukEZ87; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QHhtorVo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hFGuxsAa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VJ07OCIE; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCBAB7592E;
	Tue,  9 Jun 2026 06:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780986834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=lKukEZ87WWZmMipW14oKd7IhQm4fBnD5z5ctJNtn8hFmJmZjtoiZfCUUBot+0jUeYdPKLk
	/CWBlr8/7e7Oh2nmgY6kZgG5HXegnSx0f5/Unc2MZg+WPz4bs9wzBGCWvzArgnSWWIaOPX
	4TudyXUP9Uk/E/4mx7t5xUqqiIxgUS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780986834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=QHhtorVoQUFH+xxQ7+SaTamZTisHr8Hb2pX4X2O6JHW6DYb2H064FXyYQqWAugqJchSgb0
	nd+Dij86ZrIpw5Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780986832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=hFGuxsAa0fiKdlWgGQ64jSSnHiO2GYSYcjGAMZ5FbJLZZRNRXrLXqR0+G3OcbLVBUMAllm
	cy3ziTM8tQ7TcXN8HaAANFk3YoESL6V6CkTrSRMC8YNde7lfr0KZAVXV0uQ0GVCtTHDCDR
	B5HLrKg9IcnmR1GZr1z/RgCwr6WF8tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780986832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKE/uJBVyB0X5nsgiFUDFtCb4ApOZevyMfjAVJep4rg=;
	b=VJ07OCIEqFLFTnFasawkxz8V90kT9RgZK+wrs1Z0AAzC/7ndDZ3CtsRQ+HrCUJwJxAiMA5
	O1uVKxBeq1UG8NDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94C62779A7;
	Tue,  9 Jun 2026 06:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yxStIs+zJ2qBaAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 06:33:51 +0000
Message-ID: <e578fbb5-2184-4052-a9db-b363ae758e3c@suse.de>
Date: Tue, 9 Jun 2026 08:33:51 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] handshake: Require admin permission for DONE command
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
 <20260605-tls-session-tags-v1-1-47bd1d94d552@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260605-tls-session-tags-v1-1-47bd1d94d552@oracle.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22392-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2149E65CCFC

On 6/5/26 19:34, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> ACCEPT and DONE are the two downcalls of the handshake genl
> family, both intended for use by the trusted handshake agent
> (tlshd). ACCEPT already requires GENL_ADMIN_PERM; DONE has
> no privilege check at all.
> 
> The fd-lookup in handshake_nl_done_doit() only confirms that
> some pending handshake request exists for the supplied sockfd;
> it does not authenticate the sender. An unprivileged process
> that guesses or observes a valid sockfd can therefore submit
> a DONE with HANDSHAKE_A_DONE_STATUS == 0, leaving the kernel
> consumer to proceed as if the handshake succeeded. A non-zero
> status on a forged DONE tears down a legitimate in-flight
> handshake before tlshd can report its real result.
> 
> A subsequent patch teaches the DONE handler to carry session
> tags consumed for access control. That work makes closing the
> existing gap a prerequisite, but the gap itself predates tags.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   Documentation/netlink/specs/handshake.yaml | 1 +
>   net/handshake/genl.c                       | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


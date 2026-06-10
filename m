Return-Path: <linux-nfs+bounces-22431-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id soHEEpoOKWoZPgMAu9opvQ
	(envelope-from <linux-nfs+bounces-22431-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 09:13:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C766684F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 09:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vZoXLgsL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vNI9vXR/";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vZoXLgsL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vNI9vXR/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22431-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22431-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51EB7305EA5B
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F993839AF;
	Wed, 10 Jun 2026 07:06:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D103372EDD
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2026 07:06:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075214; cv=none; b=r+zwQCSqUF5IVReOZTA8JHQBPUKUjkvi9WWZU8VqLVTdwQHFzButxZmpBLtjc4B4Yb+4CB+2WqrK31SLx4kG/fT7fOQL6TUB5+SJ/mdcqst80kUZSUXvq3qFUYhU2rZ3KlRUv6Fia6V+HBWf8Dce81uvJEF6For+nN5sZuLqun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075214; c=relaxed/simple;
	bh=uwEoaXiN/XXygk3f43wDiGsyQIn9DxeM52TsPBk93n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMjv4HEs431jFUvmb8Yiz8XrRIbcNEW8fl2dcNl7fsN8P6Qnq1trQgpKDmyCl1WPAMT/ifoaaOQnxLoe0QZAgLEIDprOR/anJofr/ZmGkO1sJ7B2AmhuQ+sAkT0eHaJCpmD95kaZ3r0vefU7NcCng89HzSCG2WG+gM6rG4SO7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vZoXLgsL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vNI9vXR/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vZoXLgsL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vNI9vXR/; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B550D75CA8;
	Wed, 10 Jun 2026 07:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781075211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1gAeOLgTuEAAzcY5bQb3xMUyBqJE6jmw0ao7FkdqP8=;
	b=vZoXLgsLK4JO+rXIi83jANeHzQ1nk6ZkXFQTTnc1Nn24iSwELqTySg7dIUWyHB5DJz49px
	2c5X9QP/7achVuMUZ7eAcU5IoKt5PKJbx7Jski0vm+l/G31eCu1aviXddmqSAgr8/l0Taw
	dffP1fHPyTZTarKZ68uw4ja23h1Kaj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781075211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1gAeOLgTuEAAzcY5bQb3xMUyBqJE6jmw0ao7FkdqP8=;
	b=vNI9vXR/WONDlg1KHtdE1YuXYMq4I1NH8lfuV1jwMzRgCiSEakWJ2s4vt6TglmRHhr7yA/
	4Kwqp5rpv1zsRvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781075211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1gAeOLgTuEAAzcY5bQb3xMUyBqJE6jmw0ao7FkdqP8=;
	b=vZoXLgsLK4JO+rXIi83jANeHzQ1nk6ZkXFQTTnc1Nn24iSwELqTySg7dIUWyHB5DJz49px
	2c5X9QP/7achVuMUZ7eAcU5IoKt5PKJbx7Jski0vm+l/G31eCu1aviXddmqSAgr8/l0Taw
	dffP1fHPyTZTarKZ68uw4ja23h1Kaj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781075211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1gAeOLgTuEAAzcY5bQb3xMUyBqJE6jmw0ao7FkdqP8=;
	b=vNI9vXR/WONDlg1KHtdE1YuXYMq4I1NH8lfuV1jwMzRgCiSEakWJ2s4vt6TglmRHhr7yA/
	4Kwqp5rpv1zsRvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03A1E779A7;
	Wed, 10 Jun 2026 07:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GD8JOwoNKWr+LgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jun 2026 07:06:50 +0000
Message-ID: <d14fff89-3c7b-40ea-9380-e8c37499916e@suse.de>
Date: Wed, 10 Jun 2026 09:06:50 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] lib: Add a "tagset" data structure
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
 <20260605-tls-session-tags-v1-3-47bd1d94d552@oracle.com>
 <922040b0-f87e-484d-9f7b-78098024ad04@suse.de>
 <2dc23995-3ff9-4714-ac6c-d70255b15687@app.fastmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2dc23995-3ff9-4714-ac6c-d70255b15687@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22431-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D22C766684F

On 6/9/26 15:35, Chuck Lever wrote:
> 
> On Tue, Jun 9, 2026, at 2:45 AM, Hannes Reinecke wrote:
>> On 6/5/26 19:34, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Access control mechanisms sometimes need to match metadata tags
>>> between a session and a resource. A tagset provides efficient
>>> membership testing and set intersection operations for this purpose.
>>>
>>> The implementation uses a sorted array of string pointers. Unlike
>>> hash tables, sorted arrays support efficient intersection without
>>> needing to iterate one set and probe the other. Unlike rbtrees,
>>> they require no per-element node allocation, minimizing memory
>>> overhead for small sets typical of resource tagging.
>>>
>> [ .. ]
>>
>>
>> Isn't this overcomplicating matters?
>> In the end, this a list of strings.
>> Wouldn't a simple rbtree holding the strings be sufficient?
>> (And quicker to lookup :-)
> 
> This isn't overcomplicating matters.
> 
> Consider that a TLS session might have several, even dozens of
> tags. An NFSD export might also have a dozen or more tags.
> 
> We need a mechanism that will compute the intersection of those
> two sets efficiently -- that is not a simple lookup. Keeping a
> set of tags in a list or in an r-b tree would require MxN look
> up operations to compute that intersection.
> 
It sure would. But we're dealing with a comparative small number
of entries (later patches cap it to 64), so runtime really is of
no concern.

But let me see if I can come up with an alternative implementation
using rb trees.

> 
>> Also see my comment in the previous patch. I really would make
>> 'tags' a nested attribute, and then parsing the 'tags' attribute
>> would be simple iteration over the tags.
> 
> I leave it to Jakub to decide the best approach for passing tags
> via the netlink protocol.
> 
> 
Sure.

>> (And don't name it tagset. That will be confusing the hell of out
>> of any storage folks, where a tagset is something completely
>> different.)
> 
> Since the primary operation on this container is "intersection",
> set makes the most sense. Stringset?
> 
> 
Better.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


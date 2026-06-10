Return-Path: <linux-nfs+bounces-22430-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e3lLBOgEKWqmOwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22430-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 08:32:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E2666448
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 08:32:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1eZ8uAO1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FvImT5ig;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1eZ8uAO1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FvImT5ig;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22430-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22430-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88865300E15C
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 06:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CD8373BE7;
	Wed, 10 Jun 2026 06:28:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C66371CEE
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2026 06:28:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072907; cv=none; b=lhv86xmAaOME+6hM8vcNgV9hoN7Yqb5fZca1X1eMhqgY4wxyef4KD+a1hh+FLGkGji9KlNxlj5/OD0eLglL1bPfy28Tqqu71w+H9eA14i2kVUKlx/AZmrjArp4n/UHVvrYvSdN4m+e0R1hATBtBNbpkOvv/jhaKsasBweN86mTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072907; c=relaxed/simple;
	bh=DyTeYd9vnRDq8G0JZHC8wrAMUnfSahzSGTPtCFrWgkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9glwglnQVTwluB47ldQmLgI3c1QbY0LvvWeERR7LagwRjbhgfupFT+TTZXKpELnSZzd8WsCaMtzbnVi87r7rYoF71oXpRvONNnHBzvK9EvlTItar/6XlTutUZ8+OF4DWfRnstBn/lcB6xkY0R6STD77Nu6ZAx6xmXZirPCocgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1eZ8uAO1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FvImT5ig; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1eZ8uAO1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FvImT5ig; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21A8175CAD;
	Wed, 10 Jun 2026 06:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781072904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKq54TbrhGR2RKbLwCmDopNOKQM89rNy60MxYSxRYSA=;
	b=1eZ8uAO1kHm49tmPC2q3ED8xJp6MTDoBYt3oiFtF0oq5WNgnWiF1P/FKgUSJ6a9oo/G+51
	fg6/mFVSq8bIdzLPD9WhpdjEJZjVHG2SFIDaKdpkp4K/aPyM4p8oz+hZdUi2UEYBhr1SQb
	SusT2Qk82FNHUVs/l644QPNTZqagX8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781072904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKq54TbrhGR2RKbLwCmDopNOKQM89rNy60MxYSxRYSA=;
	b=FvImT5igKlFgdnlITdLU9XlJzw0zRtVBqFn4Tf16atqsboP7hMxBBPdvO+NkqI9z6v+gk5
	OAf7cU7/g6UporCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781072904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKq54TbrhGR2RKbLwCmDopNOKQM89rNy60MxYSxRYSA=;
	b=1eZ8uAO1kHm49tmPC2q3ED8xJp6MTDoBYt3oiFtF0oq5WNgnWiF1P/FKgUSJ6a9oo/G+51
	fg6/mFVSq8bIdzLPD9WhpdjEJZjVHG2SFIDaKdpkp4K/aPyM4p8oz+hZdUi2UEYBhr1SQb
	SusT2Qk82FNHUVs/l644QPNTZqagX8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781072904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKq54TbrhGR2RKbLwCmDopNOKQM89rNy60MxYSxRYSA=;
	b=FvImT5igKlFgdnlITdLU9XlJzw0zRtVBqFn4Tf16atqsboP7hMxBBPdvO+NkqI9z6v+gk5
	OAf7cU7/g6UporCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48848779A7;
	Wed, 10 Jun 2026 06:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TSJhDwcEKWp+CQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jun 2026 06:28:23 +0000
Message-ID: <f967eb48-9e54-497a-b5dc-ade6fa6c49d3@suse.de>
Date: Wed, 10 Jun 2026 08:28:22 +0200
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
 <40199ef9-416e-4a58-908a-ed514dfd6ff2@suse.de>
 <7b5276ff-cceb-446c-97ec-65ad80689495@app.fastmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7b5276ff-cceb-446c-97ec-65ad80689495@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22430-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hare@suse.de,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A38E2666448

On 6/9/26 16:29, Chuck Lever wrote:
> 
> On Tue, Jun 9, 2026, at 2:41 AM, Hannes Reinecke wrote:
>> On 6/5/26 19:34, Chuck Lever wrote:
>>> We'd like tlshd to tag certificates according to admin-defined
>>> characteristics. The tag list is to be returned on a successful
>>> handshake. Upper Layer Protocols (such as NFS) can then authorize
>>> access based on the set of tags returned to the kernel.
>>>
>>> For example, suppose NFSD wants to restrict access to an export to
>>> only clients that present certificates whose issuer DN contains
>>> "O=Oracle". tlshd can parse incoming certificates, and add an
>>> "oraclegroup" tag to handshakes where a client presents a
>>> certificate with "O=Oracle" somewhere in its Issuer field. NFSD can
>>> then be configured to look for that tag and permit access only when
>>> it is present. NFSD needs no knowledge of x.509 certificates.
>>>
>>> This patch plumbs in the netlink protocol elements for tlshd to
>>> return a list of tags to the kernel when a TLS or QUIC handshake
>>> succeeds. Subsequent patches add tag extraction and storage in
>>> the handshake layer.
> 
>> Not sure if I agree with this; to my untrained eye the 'tag' attribute
>> is just a string, and someone else will have to parse that. But we
>> are at the netlink level here, so we _can_ have nested tags.
>> Wouldn't it be better to make 'tags' a nested tag (ie a list of tags)
>> such that we can avoid parsing in the caller/consumer?
> 
> Had some time to digest your comment a little more...
> 
> The tag attribute is declared "multi-attr: true", so it is already a
> list rather than a single delimited string. tlshd emits one
> HANDSHAKE_A_DONE_TAG attribute per tag, and the kernel receives each
> tag as a separate netlink attribute. There is no string to split in
> the consumer; the parsing you are worried about does not happen.
> 
> This matches remote-auth directly above it, which is likewise a
> multi-attr scalar list in the same DONE message.
> 
> A nested attribute earns its keep when each list element is a
> structured record with several sub-fields to group. A tag is a single
> string, so nesting would add a container attribute, a second
> attribute-set, and a nested policy without making anything on the
> consumer side simpler. If a tag later needs to carry structured
> metadata, nesting becomes the right tool, but that is not in scope for
> this series.
> 
Ah. So one can have several 'tag' attributes in one 'done' downcall?
That's perfect.

So you can add my:

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


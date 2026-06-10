Return-Path: <linux-nfs+bounces-22433-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R0CSJTFrKWowWgMAu9opvQ
	(envelope-from <linux-nfs+bounces-22433-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 15:48:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09885669ECB
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 15:48:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BVOSb6H3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22433-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22433-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D379030A6F06
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D558340BCB2;
	Wed, 10 Jun 2026 13:44:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A940B387
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2026 13:44:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099069; cv=none; b=Rdn5rpqa70UEVk9LPJyV+A3RcT0Kky4Zqg0kEGXFt/RI9Yj/YFRNy4+RoDLVewywPJhV/gPtE1AJ30fFqVFZAwR+CGpq3nxFdg9UC7bAeGqH7bsMD3UnVPrTbHruWAc+tHj513S4bZJ21O52fww6NYe6uwMPHF8sRYI1Iw8mOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099069; c=relaxed/simple;
	bh=HFdCixDVC26nIkym/DDw5BbdDTYYCZ75EgliOFovO8g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JucBRZmsTMGewh9YT1fWt1HbCneQsPT4B0Umm87qWYkPqyu4dsmv7U5r+AcSOizPg3DnJD2QBM15liZiuYnI3VRXlvVmrOZsVvqZI//wcDYBGftO03ncrlx6myaqqdhuCqdG+n91trETlzucuroTQxtCqrMu+MbKipnrSpQqEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVOSb6H3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A2F1F00898;
	Wed, 10 Jun 2026 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099068;
	bh=wPPDhxKh3hPc6l1/pq4WkUoyCmQ73QpGV3SN3sLOFRo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BVOSb6H3xr1dTTnA6IyJcvki9vKqeErst4XNJQblTnHZck+W55a5bkHy06PA/rFnk
	 BzeNsmCCR+ATshWPpMmlo2gztxWdn55c8KGJyJOGAH4FKWyZTviqHmrGgZfmrtO47J
	 rAYWUhy+/L5fGIUYkxwrOtkIaFAqCO1c103WVtdawY8TzxjEdd1oWbOaKCvfv0eKz1
	 LO/D5npkfeUSOdkHl5SZB836NW+DDVt2nxfzA4ZVvQuNv36qwmdAt693elYcL2lmTu
	 NbZanSLLCgP0sc96gpZhb4QHrCWGpxKNj47fqYPXftu/RAxXtR4qr+sW7xcN2c1lIh
	 1TtZIIf6YqTIg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E2E81F40077;
	Wed, 10 Jun 2026 09:44:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 09:44:26 -0400
X-ME-Sender: <xms:Omopaszll95i-3fJFd6CskCrToGzY4ZK5vyfiFZgBFxT5A37wj_iKQ>
    <xme:OmoparHzwNrSu-NHoBGiw2xAHot2S5IZPLxAX7cvsUO4E8cgFFtcUK-uvezsl8z7a
    qA4ZDPYhIc04TVClC9TyDxb9zuKDfHsd92yRUJ_GAkdehaZSGnbrEU>
X-ME-Proxy-Cause: dmFkZTFo6lJcIYlhfzO/M7VQ/JnV1u4EHs5xq3VlZnBCfR540veWQVuwQPexuiS4eLQ9He
    2632OciM8xFfTwlrrqsfBrJFYSd43AdzjUtlKEJQ7ztos01/QDK8f0NKCFDLtiH6/PI8Xe
    Rh2ta8+yx4RJ4qjkPUZJSjLMMGk67Y/x5VondMjwqe2J5HUezBrRZBfgby9HaDQa7uw9XA
    0ZO+vPRgUARmUBEwHVMK6OUZuHsQgeTPM7dNVId1LklSaSvhzscZLscEOlrBX68uUL7Uh4
    muMOzMveIndhSACewxMIyLTuWF4kgSGQA1trSBckDEF95S7IOLs0WvEff0ifWxq3h8dABF
    jXli4WNoMJObTrcXcZhT0yNEAGez015qGKZV3dDKd1g4fY1WCNfiR8az0cNsMcYG9r/f94
    RmJR6z8dJkqd2jYr+DvoCTuxD7PEMyJYsJSrBb9mIimXygUailkO9U7B6uHpBQY9n01Q97
    tKgpWLnVyvG97FcfHsXmTxL9sFLQFjuwEszrMy9he8qsdkIRErVenWi6bLoMWDswWmbGoo
    Ga+BkuaRorJ9sCj5WwOXAM3d4Q2TAaVa03KR3AWtXT98T3fz7h5B9Yzn+Ln2hbF/31V4D/
    6ygODKDG7YLbZ4wsWnGwkCvkMWUYOwu/ABIzt0CbYHI1lEj00Aa+97pJGzRA
X-ME-Proxy: <xmx:Omopajb9Q_c5ELOPrPCO6ibbO_KC0kOAKkNXt8CMSh5PlPS741hyyQ>
    <xmx:Omopaig0QQ3SWZ50PrMxg56iDMdHDDDh0_hGEPmNDcVjFvzwdG3V7Q>
    <xmx:OmopajyDVfnPWFVoqrteEXQ0si-20fOP1_OVPianFEFhUzhQ45fXcA>
    <xmx:Omopat4HlpRERPyyuchP9miI8KLrPxVqOjV1SbaSnUREM4u7j1P-3w>
    <xmx:Omopas17tC3U4tMRF30GWJtmyX6viVpeXC8T8icfy2hd8u-bp3QpqJGk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B460F780070; Wed, 10 Jun 2026 09:44:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AL3hV2aBoURB
Date: Wed, 10 Jun 2026 09:44:05 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Hannes Reinecke" <hare@suse.de>,
 "Donald Hunter" <donald.hunter@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <98b7f6ef-3c1d-4af0-86d0-cad6d1f29b1c@app.fastmail.com>
In-Reply-To: <d14fff89-3c7b-40ea-9380-e8c37499916e@suse.de>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <20260605-tls-session-tags-v1-3-47bd1d94d552@oracle.com>
 <922040b0-f87e-484d-9f7b-78098024ad04@suse.de>
 <2dc23995-3ff9-4714-ac6c-d70255b15687@app.fastmail.com>
 <d14fff89-3c7b-40ea-9380-e8c37499916e@suse.de>
Subject: Re: [PATCH 3/9] lib: Add a "tagset" data structure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hare@suse.de,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,app.fastmail.com:mid,oracle.com:email];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_TO(0.00)[suse.de,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22433-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09885669ECB



On Wed, Jun 10, 2026, at 3:06 AM, Hannes Reinecke wrote:
> On 6/9/26 15:35, Chuck Lever wrote:
>> 
>> On Tue, Jun 9, 2026, at 2:45 AM, Hannes Reinecke wrote:
>>> On 6/5/26 19:34, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> Access control mechanisms sometimes need to match metadata tags
>>>> between a session and a resource. A tagset provides efficient
>>>> membership testing and set intersection operations for this purpose.
>>>>
>>>> The implementation uses a sorted array of string pointers. Unlike
>>>> hash tables, sorted arrays support efficient intersection without
>>>> needing to iterate one set and probe the other. Unlike rbtrees,
>>>> they require no per-element node allocation, minimizing memory
>>>> overhead for small sets typical of resource tagging.
>>>>
>>> [ .. ]
>>>
>>>
>>> Isn't this overcomplicating matters?
>>> In the end, this a list of strings.
>>> Wouldn't a simple rbtree holding the strings be sufficient?
>>> (And quicker to lookup :-)
>> 
>> This isn't overcomplicating matters.
>> 
>> Consider that a TLS session might have several, even dozens of
>> tags. An NFSD export might also have a dozen or more tags.
>> 
>> We need a mechanism that will compute the intersection of those
>> two sets efficiently -- that is not a simple lookup. Keeping a
>> set of tags in a list or in an r-b tree would require MxN look
>> up operations to compute that intersection.
>> 
> It sure would. But we're dealing with a comparative small number
> of entries (later patches cap it to 64), so runtime really is of
> no concern.

I'm going to push back on that. Let's compare the proposed
tagset implementation with a putative r-b tree-based one.

On a big NFS server, mount operations happen frequently. With 5
tags on a session (say) and 5 allow-tags on an export, that is
25 lookups, each O(log(5)) (for r-b tree).

With the current tagset implementation, it is O(5 + 5).

If both the session and export tags are using the maximum number
of tags, an "intersection" turns into 4000+ lookups, each
O(log(64)). With the current tagset implementation, it's only
O(64 + 64).

The performance of one "intersection" operation goes south
quickly with the number of tags when conventional data types are
used.

And these are all memory fetches, so not all that fast. r-b trees
are notoriously non-optimal in terms of memory access efficiency,
though not as bad as a linked list.


> But let me see if I can come up with an alternative implementation
> using rb trees.

I'm skeptical that an r-b tree implementation will be much simpler.
It will definitely be more costly in terms of CPU and memory
accesses.

For the time being, note that TLS session tags have no support
for PSK -- there are no data items inside the shared keys on
which to match a tag. We might find something else to match on,
though, who knows?


-- 
Chuck Lever


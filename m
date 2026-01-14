Return-Path: <linux-nfs+bounces-17851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8DFD1F613
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9226A3016DC2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2933D1A9F90;
	Wed, 14 Jan 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbcZ3uUQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AE3D3B3
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400383; cv=none; b=YtiOLDJVU1B/c2LjRZD9PWHmcErH6AVlZXXBW52PMWr9D+MHTVLkuuxIuEVD6WGfdX/C6otVAwN4/CvDcsfLv6ktzG8n9OqhMQxWH+u0B7LZE5JHsxRc7QOzB6eKq5qopVl9igftNTFUw/9GWBzMNNQH3anClwXNQvh0Z/opVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400383; c=relaxed/simple;
	bh=qkKSbwZXtD8Jk9zgzKmL6i6WzGxa3gGh9iVh8ubyn38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCAL44w1hunyi8nLhF0FYNOf/46Dl7SoO/V0FzU/F1uVl75mdISMRzkmJk+RUuayphcK+jyuiNworf3tHNC9OpkWeo+AUefiqYT9HrAnYZstwGs5+RVnCaES5XVz2EpJD0fWsbJ0FMOb/BaEmo8sPHvleINeVvjg/dy0uLbo2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbcZ3uUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049B2C4CEF7;
	Wed, 14 Jan 2026 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400382;
	bh=qkKSbwZXtD8Jk9zgzKmL6i6WzGxa3gGh9iVh8ubyn38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QbcZ3uUQCoRu+yvUaNbvfaJs1ju0beAvachvPiUTTA7Y3tEd9YO9AXanE7iTjvM9Q
	 fQ1h3EpnL9qFNHWOiXwZzGaIuuiy8lJTBSGGj9uslM8FZc2YX1HAc2ubcM4dRR/zi1
	 1Ln0yw8jCS43wUbfpGexsizd8JwQF5gETc/hniaQFwKe0x/siq8yZugtaRdSMVVSi7
	 ZEnUPORJT7kVpiZJbCCGlgy5OkDYVPpi+PtBV0DxL8EQx5gNPQmiLAI0N1N6kJ+g91
	 oXUp54xqwQAX7ZfxFP2LqQLT6yGdya+5Kl77TlK7UbaspaDUK9l438icPo+5gdfO3a
	 IeesGW84WSzjA==
Message-ID: <c8ad96c5-1da1-4aeb-8999-2a8b63021a23@kernel.org>
Date: Wed, 14 Jan 2026 09:19:33 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
To: Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@hammerspace.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
References: <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
 <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
 <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
 <e711e1cb-eb8a-4723-a9af-39ce7d9658dd@app.fastmail.com>
 <C79886E5-3064-4202-9813-0D79091F78DF@hammerspace.com>
 <20260114004205.GC2178@quark>
 <834DBCBA-1CD8-4BA9-81E8-09E621B3F176@hammerspace.com>
 <a092bf21127a679a32ac9f9c476e7d070667c36b.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <a092bf21127a679a32ac9f9c476e7d070667c36b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 8:19 AM, Jeff Layton wrote:
> On Wed, 2026-01-14 at 07:39 -0500, Benjamin Coddington wrote:
>> On 13 Jan 2026, at 19:42, Eric Biggers wrote:
>>
>>> On Tue, Jan 13, 2026 at 05:33:37PM -0500, Benjamin Coddington wrote:
>>>>> - Individual filehandles are small, on the order of 32- or 64-bytes
>>>>>
>>>>> - But there are a lot of filehandles, perhaps billions, that would
>>>>>   be encrypted or signed by the same key
>>>>>
>>>>> - The filehandle plaintext is predictable
>>>>
>>>> Mostly, yes.  I think a strength of the AES-CBC implementation is that each
>>>> 16-byte block is hashed with the results of the previous block.  So, by
>>>> starting with the fileid (unique per-file) and then proceeding to the less
>>>> unique block (fsid + fileid again), the total entropy for each encrypted
>>>> filehandle is increased.
>>>
>>> This sort of comment shows that the choice of AES-CBC still isn't well
>>> motivated.  AES-CBC is an unauthenticated encryption algorithm that
>>> protects a message's confidentiality.  It isn't a hash function, it
>>> isn't a MAC, and it doesn't protect a message's authenticity.  AES-CBC
>>> will successfully decrypt any ciphertext, even one tampered with by an
>>> attacker, into some plaintext.  You may be confusing AES-CBC with
>>> AES-CBC-MAC.
>>
>> I'm not confusing them, and you're absolutely correct - if an encrypted
>> filehandle were tampered with we'd be relying on the decoded filehandle
>> being garbage - the routines to decode the fsid and fileid would return
>> errors, because a filehandle's data is meaningful and well-structured.
>>
>> That's a big difference from what using a MAC would provide - immediate
>> knowledge the filehandle had been modified.
>>
> 
> I think a MAC is a better idea here too:
> 
> One thing that people keep pointing out is that you could potentially
> sniff traffic and just nab the encrypted filehandles, and match them
> with inode numbers, etc.
> 
> If you append a MAC though and check it on the server, you could give
> out filehandles that are limited-use. For instance, with v4, you could
> salt the hash with the long-form clientid and ensure that that
> filehandle is only usable by that client. Anyone else gets back
> NFS4ERR_STALE.
> 
> Couple that with TLS and you'd have a pretty decent guard against
> sniffing and filehandle guessing attacks.

A sniffing attack is easier than guessing a file handle or constructing
one. Neither encrypting a filehandle nor signing it protects against
sniffing attacks. But using full in-transit encryption does, and we
have that implemented already.

With full in-transit encryption, the plaintext is much much less
predictable as well.

Just sayin'


-- 
Chuck Lever


Return-Path: <linux-nfs+bounces-19251-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CphM7I9n2kiZgQAu9opvQ
	(envelope-from <linux-nfs+bounces-19251-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:21:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FA19C300
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 19:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A52FD301220D
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Feb 2026 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECC2DF13B;
	Wed, 25 Feb 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKfgJ+Wm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945C2DF6EA
	for <linux-nfs@vger.kernel.org>; Wed, 25 Feb 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043696; cv=none; b=WnHrnCToqq/jMp60VEpT0XlIWrc202nVp/mYrpswK5Mkz2OvFCuRI1trXdGfChatomKokxthZ6rpyhvMfW8U0wZtAWQRUbF7ZDzup9r9QUDFaBzgP4yzwkujo7qBvMi7FVBA/9SCkxbM+Cfzg4ypv17lbntPb7jXgb2F0pDHlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043696; c=relaxed/simple;
	bh=yJmec7NQCOT3ZmBDFPmbjYk+eJh/HRbL7NNGhSU0G+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2Q3lrxK5z9O7e/qmX1BAq3P2EBI7QfX/UaIEdBmqRuPMfA205iA593EO1+sIgrWuJ11L8kOzAC4EVaR/ZSXeGqnWH7hPYRB+TAQ2Wf/D8PwzH4+bi8vAmJIhmm9XtwWUOkj/H2QIBBfSByrZI0iEcWRT3se/bIJsGj5ukX+HtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKfgJ+Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD574C116D0;
	Wed, 25 Feb 2026 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772043696;
	bh=yJmec7NQCOT3ZmBDFPmbjYk+eJh/HRbL7NNGhSU0G+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VKfgJ+Wmap5sPo17hfPYRhem8fQStranvgevXbLQDURJa0dbLdA29bStpRTHYUapF
	 5bCX26uVo273XWR2vOWBWBheUm4tl4eeqf5UwJO36QVFoSwQ0eBhKzzolLEpySO4uB
	 6HlvGOTFgJMzXwYuAECq/85n8LLiwsbVN4kFtCzKDa/wc3RpfxIO2rCC2yVjaCt0xk
	 AuGZjWtsT99QbbMHYofHF8VJYJWqXWBoseGuaPrkOisuxQm5Jl78B11Jh5PrBBBSL/
	 nz1oPdGhXZdexpn5JiA22fuldn0lGn1+BSVYdSf+1W2d0oBg3R84xOEFJaU3Zf2bne
	 wJ563jR3eun5A==
Message-ID: <feb25fdb-0409-498c-a519-91eba0ddb4f6@kernel.org>
Date: Wed, 25 Feb 2026 13:21:34 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4
 reexport
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org
References: <20260224192438.25351-1-snitzer@kernel.org>
 <3251bc70-6efd-4cc7-9060-28853f047d53@app.fastmail.com>
 <aZ8pDX2LWU5Qgxku@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aZ8pDX2LWU5Qgxku@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19251-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 734FA19C300
X-Rspamd-Action: no action

On 2/25/26 11:53 AM, Mike Snitzer wrote:
> On Tue, Feb 24, 2026 at 04:58:10PM -0500, Chuck Lever wrote:
>> Current NFSD support for DACL/SACL:
>>
>> - FATTR4_DACL (bit 58) and FATTR4_SACL (bit 59) are defined in
>>   `include/uapi/linux/nfs4.h` but not in any supported attrs mask
>> - Dispatch table (`fs/nfsd/nfs4xdr.c`):
>>       [FATTR4_DACL] = nfsd4_encode_fattr4__noop,
>>       [FATTR4_SACL] = nfsd4_encode_fattr4__noop,
>> - Not decoded in nfsd4_decode_fattr4()
>> - Not in NFSD_WRITEABLE_ATTRS_WORD1 (`fs/nfsd/nfsd.h`)
>>
>> Patch sequence might look something like:
>>
>>  1. NFSD: add acl_flags to struct nfs4_acl for nfsacl41
>>  2. NFSD: add DACL/SACL decode at correct fattr4 bit position
>>  3. NFSD: handle nfsacl41 wire format (aclflag4 + aces) in decode
>>  4. NFSD: add nfsacl41 encode for DACL/SACL responses
>>  5. NFSD: clear ACL, DACL, and SACL together in supported_attrs
>>  6. NFSD: add DACL/SACL to supported and writable attribute masks
>>
>>
>> For the API between NFSD and the local NFS client, I might favor an
>> alternative to new export operations: NFSD can set "system.nfs4_acl"
>> xattrs on NFS client inodes. The only issue there is it limits the
>> total number of bytes to 64K. But we can worry about that once the
>> DACL/SACL attributes are implemented.
> 
> This line of work _seems_ outside the scope of what is needed, so I
> won't be pursuing it unless you can help me better understand how this
> stepping stone of NFSD having native support for DACL and SACL will
> begin to offer more capable ACL pass-through support for NFS reexport.

This is not about what narrow use case Hammerspace happens to need.

Your series adds incomplete support for the DACL and SACL attributes.
That incomplete support is not sufficient for a properly compliant
server implementation, and makes that part of your proposal unacceptable
for merge because it adds significant technical debt and is likely to
result in bug reports. That's no skin off your nose, but it's
considerable effort for the community to have to deal with long-term.

Since your patches already do some of this work, I'm asking you to do
the right thing and provide a clean and complete implementation of the
feature.

If you want to look at this transactionally, I'm asking Hammerspace to
pay a small one-time price for the community's long-term support of this
feature. I regard that as very fair.


> Further review of the code provided in this series would be
> appreciated.

Adding .setacl/.getacl operations to the export_operations structure is
simply wrong, architecturally speaking. So NACK to that implementation.
All of that needs to be redone once we have agreed on a proper cross-
system API.

> I do think I've captured the essence of what is needed.

That's exactly what a prototype should do. That does not make a
prototype implementation acceptable in the long run, however.


-- 
Chuck Lever


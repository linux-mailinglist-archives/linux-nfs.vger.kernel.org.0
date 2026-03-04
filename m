Return-Path: <linux-nfs+bounces-19697-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZxalCBKAp2lJiAAAu9opvQ
	(envelope-from <linux-nfs+bounces-19697-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 01:42:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843EF1F8F7E
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 01:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBA293037498
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879F1C5486;
	Wed,  4 Mar 2026 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPCc8jX9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1F2AD10;
	Wed,  4 Mar 2026 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772584974; cv=none; b=b62C0jv9qYwDruMbKN5ts+rkw5lSemJy+6wx1bY032SlrLUieAMhG0Y4ysZn793Qf/Cvfq27cn0yRpRF2OAiN19ZRSoaW99aoxKpOhJNaIIKNLFn1LwdOo8NaUWn6Cap+dJB/k+jgNCUUaS+0RZJy1eaYslwT8xcsYnNxndhdho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772584974; c=relaxed/simple;
	bh=s1i6zYq9VR0Nt2HWigfY/LuyzHPlwvwiIvAmy1d/qSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coxPoQ9+eNt2BsSX0pqrQMyaDzU0sJmTimqCyax3g3ehjbYmuc/q7U917/VjgyC9GbcFhS8h8okAQBTXm+R5miqwr8X/aNY33ToXO4yozYbd/3DRAmNCrfJ4nnxb8wBuHZob2u3TYCRpmjm/hiBrZNRCKTUnnqB+LQp8tAKJ9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PPCc8jX9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=W54BrIv4OmsJTRbeowZQ9IcWhe4c1hxN6cqu3WGoh2s=; b=PPCc8jX9mbP1bIIfhLkPJBDfIv
	6nxgj/Z5vbqAoUrMv33mz6t1IlhdsrazxQLiCUjokEnaYKpCd0/XRX+YR2ksIW7CkLMyYNB006AcE
	g+mMkpB1SED1ZucNfwYaP17NgrhYXhGazl4OHddJEKVBVlI7dZvsP+/8eVmnAjHvtmB/PUuF9lFKF
	jgeUdDoYwAJSeksi+IBRwbt+aVa4SaHgrUIuja7CnAapUNLlNxxeqBN4FlOETP5eHvlLCPuJnowdt
	QNlzF8XfSfHNbKSOeQ9vxFhLiycZcX6xnaX9R3Nd63NtTRJ4JGFw8on7qF8bjSDTzFzeCivas5YzM
	hilkpE1w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxaK8-0000000GB88-3aiE;
	Wed, 04 Mar 2026 00:42:48 +0000
Message-ID: <e2f0b2df-11bb-43fb-b5c8-478cdb3f5362@infradead.org>
Date: Tue, 3 Mar 2026 16:42:48 -0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SUNRPC: xdr.h: fix all kernel-doc warnings
To: Chuck Lever <chuck.lever@oracle.com>, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20260228220922.2982492-1-rdunlap@infradead.org>
 <ccfa6bf5-6459-4633-bcbe-dfa487c8057b@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ccfa6bf5-6459-4633-bcbe-dfa487c8057b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 843EF1F8F7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19697-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:email,infradead.org:mid]
X-Rspamd-Action: no action



On 3/3/26 8:37 AM, Chuck Lever wrote:
> On 2/28/26 5:09 PM, Randy Dunlap wrote:
>> Correct a function parameter name (s/page/folio/) and add function
>> return value sections for multiple functions to eliminate
>> kernel-doc warnings:
>>
>> Warning: include/linux/sunrpc/xdr.h:298 function parameter 'folio' not
>>  described in 'xdr_set_scratch_folio'
>> Warning: include/linux/sunrpc/xdr.h:337 No description found for return
>>  value of 'xdr_stream_remaining'
>> Warning: include/linux/sunrpc/xdr.h:357 No description found for return
>>  value of 'xdr_align_size'
>> Warning: include/linux/sunrpc/xdr.h:374 No description found for return
>>  value of 'xdr_pad_size'
>> Warning: include/linux/sunrpc/xdr.h:387 No description found for return
>>  value of 'xdr_stream_encode_item_present'
>>
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Trond Myklebust <trondmy@kernel.org>
>> Cc: Anna Schumaker <anna@kernel.org>
>> Cc: Chuck Lever <chuck.lever@oracle.com>
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Cc: linux-nfs@vger.kernel.org
>>
>>  include/linux/sunrpc/xdr.h |   48 +++++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 24 deletions(-)
>>
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> 
> Randy, did you want me to take this one, or will you send it on to
> Linus?

Please take it. I don't have a direct route to Linus. :)

-- 
~Randy



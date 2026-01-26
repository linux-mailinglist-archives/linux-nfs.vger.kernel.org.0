Return-Path: <linux-nfs+bounces-18474-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OigGmh9d2m9hgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18474-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 15:42:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8389A73
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 15:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EFB2307A36E
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E752459C9;
	Mon, 26 Jan 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyHuuiFA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D84244667
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438193; cv=none; b=mge7aiaqO/Z+KPhgHW8CV58wRWciHhUNaSwiPv6hwm1tpfE4dOr/U95GggEsKjzZfd3uKmzJ4Mc7tKUHpm656WCfX1TK8/sdxXWqMUcMASMLQOm8o513zcBUqRhzXcKOGCqrtRA4CTuMv1BFVGbKSihJsA8FlFO90sMfDGuTJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438193; c=relaxed/simple;
	bh=yW/HGTjfESoj+wOOtp2D51B8Xc6V2fthd8WJljL/u00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTHPFoS7kQb2jkb18bVgDNBraNHzWuF1mUBmIUDDnRTlCprxhiS0/kq3pojGoHsotUF2UrBnHxaIk7K/VgZmBB2L8yY9DN8tzwV5iSvA9r1Z+MQnQmeRPzNHvNMgBVJbyxp5A+3/aKXFFkg/gLjlWNtNDiG69iB+H5rX9sXMulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyHuuiFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5690C16AAE;
	Mon, 26 Jan 2026 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769438193;
	bh=yW/HGTjfESoj+wOOtp2D51B8Xc6V2fthd8WJljL/u00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IyHuuiFAdDsZmEJQ1bENdazvXI8tCmHZvy0W1mGxiJWcIjrIm8iTZEiNKZb7x2C3N
	 MiA940kIJIjUnIdRd8WbnTdbCb9Fb0H14mO5OghfVV2pFDoxAEBzcO6lvXKVAC3vnJ
	 0vMGqM7gvC6P6eVxYKZLonKTSEQlyxSjoE67WZoIxV3CCycsz0x2M0SZOz23Snc6uZ
	 u6srP1ZDekHlRIEFfHBqU0SDd6CTeUU9ZFF9oa95BRqh+3I9CCRcp2agZnCbRF2qbM
	 uB+5PL7HepUoMJ5p2UqpyEvADNNDCdS4O1QYZKHM3OJLBnUDd/0qaQQ8AvZHELiGo6
	 6CDpPqQutYqUA==
Message-ID: <62b46748-213d-44ab-8eba-7c50997c3f94@kernel.org>
Date: Mon, 26 Jan 2026 09:36:24 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/42] lockd: Introduce nlm__int__deadlock
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260123185259.1215767-1-cel@kernel.org>
 <20260123185259.1215767-3-cel@kernel.org>
 <59cb862609db9a605c848805df55a60567be90ab.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <59cb862609db9a605c848805df55a60567be90ab.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18474-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAE8389A73
X-Rspamd-Action: no action

On 1/26/26 7:34 AM, Jeff Layton wrote:
> On Fri, 2026-01-23 at 13:52 -0500, Chuck Lever wrote:
>>  
>> +/*
>> + * Internal-use status codes, not to be placed on the wire.
>> + * Version handlers translate these to appropriate wire values.
>> + */
>> +#define nlm_drop_reply		cpu_to_be32(30000)
>> +#define nlm__int__deadlock	cpu_to_be32(30001)
> 
> nit: the double underscores look weird next to nlm_drop_reply. Maybe
> you could also rename it to nlm__int__drop_reply?
> 

What I'd really like to do is replace nlm_drop_reply with setting the
RQ_DROPME flag.


-- 
Chuck Lever


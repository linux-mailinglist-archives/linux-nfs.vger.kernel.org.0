Return-Path: <linux-nfs+bounces-22217-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dk6aKrWEH2oDmwAAu9opvQ
	(envelope-from <linux-nfs+bounces-22217-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 03:34:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59663374F
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 03:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=126.com header.s=s110527 header.b="ppk/GZ3J";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22217-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22217-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=126.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D09C83010F07
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 01:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81583624CB;
	Wed,  3 Jun 2026 01:34:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50F3603FE;
	Wed,  3 Jun 2026 01:34:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450480; cv=none; b=nBxf5eCLROgz4pNvCwmXDZCn+biLIL1xdIi24v9alJPT9/iZDxxXdvbzOpCAZiZ2ZiOSCE3Egn1KQ9iAu5ysFxAtUBFH7/lvkwUOqwB8yOFiC8Y52d0NcJVAsgUtbQoe1/Yc2Xv9zCQukDVrzkUZCkW5G6CxKMXXB1JUdG/u+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450480; c=relaxed/simple;
	bh=esmJIIxm5KHtqbg938bfkDA8ppwaZ16VwS7nKCJivPY=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=AzQDCkV5r7Xs8BuHjLowWzZGnLBpxsYeWfdmz56Espjqkrpl2astFqAuyG3L9/0SHowXc7c5TvlWfqe90LF95PZzH3CLyHo/01eNLY9EncXmQvaExd1VWkCbX5EYprXdtTilSgz+3v+iDUNM1fhdaZy7WsPeXtfhzU4Bpeap4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ppk/GZ3J; arc=none smtp.client-ip=220.197.31.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=BtEiAyLyIPFGiPQbhVD6Qlb1WOziCceBXDJcSwMDSjg=;
	b=ppk/GZ3Jq6c2rl1QNQ4l2GXnjiNQ/lVoHgm2IqAwqEoMuSMT2CByFuQIDJnL6D
	CKGI5PPcTiwamPlyUvTRW66BybZYIVTzKiSxSJP3ockfyTN+eAtiqcU3ACotxdSf
	eh+YM6PU28GLVlMJgnW6OP3oLRZo3Jrx9B6OX9zyLv/P4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnD4hphB9qJCFYAw--.12847S2;
	Wed, 03 Jun 2026 09:33:30 +0800 (CST)
Message-ID: <6A1F846C.6000405@126.com>
Date: Wed, 03 Jun 2026 09:33:32 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Anna Schumaker <anna@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
CC: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 stable@vger.kernel.org
Subject: Re: [PATCH] sunrpc: fix uninitialized xprt_create_args structure
References: <20260602083205.183807-1-zenghongling@kylinos.cn> <c3dc789b-c8c0-43e6-ae8d-615c932f4fa1@app.fastmail.com>
In-Reply-To: <c3dc789b-c8c0-43e6-ae8d-615c932f4fa1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD4hphB9qJCFYAw--.12847S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary5KFyDGFyrJr1xuFy5CFg_yoW8Kw43pr
	ZrGay5GFWDtws7Ww1rAw48C34Fyr4rGF45Gr4jyF98ArnxKas7tF12kFWj9F97CF4rGF1q
	q3Wjvwn5X3yqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jStC7UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoAqdbmofhGoDIAAA3h
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:zenghongling@kylinos.cn,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhongling0719@126.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-22217-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongling0719@126.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[126.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD59663374F

   Hi Anna and Jeff,

   Thanks for the review!

   Regarding Anna's question about copying fields from the main xprt:

   Based on my analysis, these missing fields are not stored in
   struct rpc_xprt:
   - srcaddr: only passed during creation, not stored in xprt
   - bc_xps: not present in rpc_xprt (only bc_xprt is stored)
   - flags: not stored in xprt after creation

   Since these values are not available in the main xprt, we cannot
   copy them. Zero-initializing is the correct approach with the
   current design.

   Updated to v2 with designated initializer as suggested by Jeff.

   Thanks,
   Hongling

在 2026年06月02日 23:59, Anna Schumaker 写道:
> Hi Hongling,
>
> Thanks for the patch!
>
> On Tue, Jun 2, 2026, at 4:32 AM, Hongling Zeng wrote:
>> The xprt_create_args structure is allocated on the stack without
>> initialization in rpc_sysfs_xprt_switch_add_xprt_store(). While some
>> fields are manually populated, critical fields like srcaddr, bc_xps,
>> and flags contain uninitialized stack garbage.
>>
>> This can lead to:
>> 1. Kernel panic when xs_setup_xprt() dereferences garbage srcaddr
>> 2. Information leak if srcaddr points to sensitive stack data
>> 3. Unpredictable behavior if flags has random bits set
> I took a look through the transport setup function to see what they
> do when these fields are set to NULL, and it looks like thy do their
> best to choose a default value which might be different than the
> values set to the original transport that we are trying to clone.
>
> Can we instead set the missing fields in the xprt_create_args based
> on how the main xprt is configured?
>
> Thanks,
> Anna
>
>> The fix is to zero-initialize the structure to ensure all unused
>> fields are NULL/0, preventing the transport setup code from acting
>> on garbage data.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   net/sunrpc/sysfs.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/sunrpc/sysfs.c b/net/sunrpc/sysfs.c
>> index a90480f80154..0a99d0f1eb4c 100644
>> --- a/net/sunrpc/sysfs.c
>> +++ b/net/sunrpc/sysfs.c
>> @@ -333,6 +333,7 @@ static ssize_t
>> rpc_sysfs_xprt_switch_add_xprt_store(struct kobject *kobj,
>>   	if (!xprt_switch)
>>   		return 0;
>>
>> +	memset(&xprt_create_args, 0, sizeof(xprt_create_args));
>>   	xprt = rpc_xprt_switch_get_main_xprt(xprt_switch);
>>   	if (!xprt)
>>   		goto out;
>> -- 
>> 2.25.1



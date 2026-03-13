Return-Path: <linux-nfs+bounces-20140-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOPDNOyCs2msXQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20140-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 04:22:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958227D0C7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 04:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513E430A6E2C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D6345721;
	Fri, 13 Mar 2026 03:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="HHrTzFMW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D44630100D;
	Fri, 13 Mar 2026 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372137; cv=none; b=DwoP0KqjIovbm/4pU7ucTqSPE4uTBAsdxpnV81/wajTfvRhVwJ14rz0ErsUA5pGW1MtHNq/tuMlJrFL5K1Ty1LiO8Qwu/yYDROunzPmhWL8BzjptmjVgw+nSU6S9vJlfkJVvzi1mJleNmJqNetNrnA7seWpsBHSGlShuJx7cjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372137; c=relaxed/simple;
	bh=tnNuZ4yUJHDXsaOth2vd1QVb49Vok0+TElzp4SquYiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n4XaJELZ5zUXuzIpDpP1D1wc52g8CBuJUnsqyPOn/0oInTiO+VTPpk96u30rN2VaQ5e8gfjG8XA6e52TApE+De3UiH90sGMaxwmZCe1s5G7Nkkyq1i0nEJL3W2tsP/3PX/TqoycSZXr14QPcdlNDJuRLwaqXk4bMUJGcx3pmTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=HHrTzFMW; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DZnt+BdtGHs0320DMPKnaxdpWTirbT2a5g6pZ3tbWmE=;
	b=HHrTzFMWE8B7ykPnok7WspvDyWzMlx7OrjSkDjR7W2pvPfKvBAmYYs2gj41XjS8mdKGTWILbu
	SznAhIpKoPQxxANYMfcbjcQ6I/Y4uHym55CMQCjWJVzK2XCxCs+rZjya38QOyDOzXcGsEjj1qVh
	+ekjJPKgyXU/n4AVrHcgo68=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fX8mV37GqzmV6v;
	Fri, 13 Mar 2026 11:17:14 +0800 (CST)
Received: from dggpemr100013.china.huawei.com (unknown [7.185.36.198])
	by mail.maildlp.com (Postfix) with ESMTPS id C44C2402AB;
	Fri, 13 Mar 2026 11:22:11 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 dggpemr100013.china.huawei.com (7.185.36.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Mar 2026 11:22:11 +0800
Message-ID: <731ebf8c-746d-465e-b6ad-006036f1d574@huawei.com>
Date: Fri, 13 Mar 2026 11:22:10 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]nfs: should nfs timeout even with
 NFS_CS_NO_RETRANS_TIMEOUT ?
To: Trond Myklebust <trondmy@kernel.org>, <anna@kernel.org>, Jeff Layton
	<jlayton@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
 <850dcbf562b7eb5848278937092d2d8511eb648f.camel@kernel.org>
 <1e1eadf5-fab9-4919-a71a-864aa7109c7b@huawei.com>
 <23b52d16-4b74-43e4-9fff-73ac57c9ef89@huawei.com>
 <80c9ba69f1d35928ea9d21e146e60f194cff7405.camel@kernel.org>
 <77b2c3ea-52d0-4f2f-8cca-4481f3426fc5@huawei.com>
 <c42bc9a8ccb53e4afbb74734a9705459c45d7909.camel@kernel.org>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <c42bc9a8ccb53e4afbb74734a9705459c45d7909.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr100013.china.huawei.com (7.185.36.198)
X-Spamd-Result: default: False [0.84 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	TAGGED_FROM(0.00)[bounces-20140-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjian496@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:dkim]
X-Rspamd-Queue-Id: 9958227D0C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/12/2026 9:09 PM, Trond Myklebust wrote:
> On Thu, 2026-03-12 at 12:19 +0800, zhangjian (CG) wrote:
>>
>>
>> On 3/6/2026 12:49 PM, Trond Myklebust wrote:
>>> On Fri, 2026-03-06 at 10:46 +0800, zhangjian (CG) wrote:
>>>> Hi experts on NFS:
>>>>
>>>> Recently we meet an error:
>>>> 1.Nfs wait for sunrpc
>>>> 2.Sunrpc send OPEN message and hang the rpc task onto sunrpc
>>>> pending
>>>> queue.
>>>> 3.Server never reply, and since NFS_CS_NO_RETRANS_TIMEOUT is
>>>> forced
>>>> and
>>>> connection is ESTABLISHED, task will never be retransmitted.
>>>> This cause procedures waiting on this file hang forever.
>>>> I know using "umount -f " to kill rpc task works. And the key to
>>>> the
>>>> problem most likely lies in the network layer. But should nfs
>>>> retransmit
>>>> it after waiting for so long?
>>>>
>>>> Wish for reply. Thanks
>>>>
>>>> Zhangjian
>>>>
>>> Please read the NFSv4 spec. It very clearly states that the client
>>> should never retransmit unless the connection breaks.
>>>
>>
>> NFSv4 spec said client should never retransmit, but not said client
>> need
>> to wait forever. Maybe sunrpc should tell nfs -ETIMEOUT and nfs
>> return
>> ERROR rather than retransmit.
> 
> You are 100% free to use the existing 'soft' or 'softerr' mount options
> if you have applications that can parse those (non-POSIX) errors.

I have already mounted with soft,retrans,timeo options. The connection
is in established state. But since NFS_CS_NO_RETRANS_TIMEOUT is set. The
OPEN rpctask will not return -ETIMEOUT. Any operation waiting for the
seqid will hang. The soft don't works when connection is good.

> Note however that there is no way to tell the server that you are
> 'cancelling' an RPC call, so it will hold onto that slot until it is
> done executing the call (see RFC8881, Section 2.10.6.1.). So you are
> eventually going to run out of usable slots, and the system will gum up
> anyway.

Maybe client hanging for so long is more serious than running out of
client slot. Even auto-reconnecting is better than this.

> 
> The default mount option is 'hard', because those are the only
> semantics that are compatible with POSIX and NFSv4.x.
> 



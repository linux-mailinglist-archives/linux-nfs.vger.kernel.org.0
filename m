Return-Path: <linux-nfs+bounces-20052-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAZsOiA/smk6KQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20052-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 05:20:48 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B25F326D0B2
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 05:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BE13073A70
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2026 04:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE138C404;
	Thu, 12 Mar 2026 04:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ALblATZc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3953932F9;
	Thu, 12 Mar 2026 04:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289199; cv=none; b=Na4Prc73p6ZLowty4aevGh+8AKDa983puDydZ1H8BPysxV6LckGTY0j2FWANsPd1ccrphzbb0qFWef4zw8V+2t8mKnhwfBNMk/xGIWArAEfplkXvBxAt35uj/IQ8CIFifIstqVuZJzMzuJLRa+quFzlfYkdEjEVgUvHDLIqd5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289199; c=relaxed/simple;
	bh=onY0noDIOZY0It9o6m2cbzlm+ygi2PZFHDQzINxi4d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=slSXAH3O6Es+5ZoYV88oJCWspor0XhNbDbSuMZi1+sTh3NMaK3oq/5gfWEdpgby03Wa+mtfgz2ZOHGHCV3JLllshOP83opmzwwLXsRq1GcOuusL9hpN4+tU2TUyUcFFtdOaLmvugRccSQLGKmnjxhB07k7OFJ+PPL3XofiUnW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ALblATZc; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=L5tV3rBARWrY6aK902XrsCccBNL9R4uJiM3GHUwNye4=;
	b=ALblATZcf1nks3bwTRFtediE/0n33vyZ5b4AcyfMCDlQx3Cc0j85wGj/Qc7fLDibzzW0UVTMP
	CZnTWLwl19cwVPxOCu11huO/2ka0yQTuu1/Qu8uAaV710zXkOQfwqqq5DxY7SrO4oiQMkc0TeoT
	thxqXM6RE3w69nEtxqrGVyw=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fWZ5P75cTz1prLl;
	Thu, 12 Mar 2026 12:14:49 +0800 (CST)
Received: from dggpemr100013.china.huawei.com (unknown [7.185.36.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C8D040561;
	Thu, 12 Mar 2026 12:19:48 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 dggpemr100013.china.huawei.com (7.185.36.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 12 Mar 2026 12:19:47 +0800
Message-ID: <77b2c3ea-52d0-4f2f-8cca-4481f3426fc5@huawei.com>
Date: Thu, 12 Mar 2026 12:19:46 +0800
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
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <80c9ba69f1d35928ea9d21e146e60f194cff7405.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100013.china.huawei.com (7.185.36.198)
X-Spamd-Result: default: False [0.84 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	TAGGED_FROM(0.00)[bounces-20052-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjian496@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B25F326D0B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/6/2026 12:49 PM, Trond Myklebust wrote:
> On Fri, 2026-03-06 at 10:46 +0800, zhangjian (CG) wrote:
>> Hi experts on NFS:
>>
>> Recently we meet an error:
>> 1.Nfs wait for sunrpc
>> 2.Sunrpc send OPEN message and hang the rpc task onto sunrpc pending
>> queue.
>> 3.Server never reply, and since NFS_CS_NO_RETRANS_TIMEOUT is forced
>> and
>> connection is ESTABLISHED, task will never be retransmitted.
>> This cause procedures waiting on this file hang forever.
>> I know using "umount -f " to kill rpc task works. And the key to the
>> problem most likely lies in the network layer. But should nfs
>> retransmit
>> it after waiting for so long?
>>
>> Wish for reply. Thanks
>>
>> Zhangjian
>>
> Please read the NFSv4 spec. It very clearly states that the client
> should never retransmit unless the connection breaks.
> 

NFSv4 spec said client should never retransmit, but not said client need
to wait forever. Maybe sunrpc should tell nfs -ETIMEOUT and nfs return
ERROR rather than retransmit.

> IOW: the problem here is your broken server, not the client.



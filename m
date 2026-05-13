Return-Path: <linux-nfs+bounces-21581-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLqqBZvTA2ol/AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21581-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 03:27:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2412E52BE00
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 03:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3537C300698A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 01:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816D37207C;
	Wed, 13 May 2026 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SJXdnYEU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909F3624DB
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635665; cv=none; b=K7kYFUiOiFzNelqwyfB5059goIjlnmuQp1dL3Xl8BHWYWVhMuzMTw0382sZJrzUaxErq2doOURSh7qtD3Zbg1rzG000ci0fZp/tX70+SqJ1A2zH7XrM2ypeQn59xGM+MPNM37fjcVGqrUVHVOQmlYbyUtV16b4MRBbLYJjX9qkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635665; c=relaxed/simple;
	bh=L3iEfuM34umzH7TK0WobwKZiAR/XIzxdOiB3u5/PXr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cuV1nmzy65d6d+rR2uFNSoHm9h157TIsf2MeRnSoY4FodKKGYjqH6ZuLl3NOjlFlh3fMckLJk6E+feMjSNDF+pXXptvhAgD9Zv6Xyjs4Y0kv8v37O2RM54X2pt6X+T12n0TjwANsVenSmt5sGvhukhqEcsYfxQ51SP2R1FHq4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SJXdnYEU; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DUu68nl4ZUdDtBn7RHF2STXguHSlCpMNpAqqE/wZM+M=;
	b=SJXdnYEU+xq2FgDhHS2beMQGLtmGXUVfWVO4GfQq09lZ4vtreGQExZOVrm/G2t4VTfGvCS3kh
	X4MkcGNCB5LdmzPvRTtI54jmkHAzn3m06raouTlCOFY4KIPbkES/VT3TsoebdyjM9xZ3rhaRlLw
	LSlzYFI8iTHHwNI3Rc3wfOU=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gFbGy6ndyzLm0T;
	Wed, 13 May 2026 09:19:54 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F5C54048B;
	Wed, 13 May 2026 09:27:31 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 09:27:30 +0800
Message-ID: <cd07fc25-8c9d-42af-9bd8-36d1565a80ca@huawei.com>
Date: Wed, 13 May 2026 09:27:29 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Misbah
 Anjum N <misanjum@linux.ibm.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown
	<neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <yi.zhang@huawei.com>, Zhihao Cheng
	<chengzhihao1@huawei.com>, Li Lingfeng <lilingfeng3@huawei.com>,
	<yangerkun@huaweicloud.com>
References: <20260512023322.2828939-1-yangerkun@huawei.com>
 <0ce8ae76-da17-4b25-b1f8-6fa955654a57@app.fastmail.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <0ce8ae76-da17-4b25-b1f8-6fa955654a57@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Queue-Id: 2412E52BE00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21581-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action



在 2026/5/12 21:48, Chuck Lever 写道:
> 
> On Mon, May 11, 2026, at 10:33 PM, Yang Erkun wrote:
>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>
>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks") describes an issue where calling svc_export_put, path_put,
>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>> accessing ex_path or ex_client->name. However, after discussion in [1],
>> it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for the
>> lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.
>>
>> Additionally, commit 48db892356d6 ("NFSD: Defer sub-object cleanup in
>> export put callbacks") introduces a regression that was already fixed by
>> commit 69d803c40ede ("nfsd: Revert "nfsd: release svc_expkey/svc_export
>> with rcu_work""). Therefore, reverting commit 48db892356d6 ("NFSD: Defer
>> sub-object cleanup in export put callbacks") is necessary to fix this
>> regression.
>>
>> Link:
>> https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com/
>> [1]
>> Fixes: 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks")
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/nfsd/export.c | 63 +++++++-----------------------------------------
>>   fs/nfsd/export.h |  7 ++----
>>   fs/nfsd/nfsctl.c |  8 +-----
>>   3 files changed, 12 insertions(+), 66 deletions(-)
>>
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index 665153f1720e..0baa58d1dbfc 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
>> @@ -36,30 +36,19 @@
>>    * second map contains a reference to the entry in the first map.
>>    */
>>
>> -static struct workqueue_struct *nfsd_export_wq;
>> -
> 
> Hi Erkun -
> 
> This patch doesn't apply to the nfsd-testing branch. What's more,
> the patch series already in flight removes nfsd_export_wq:

Hi Chuck,

Apologies, I initially submitted a patch based on the mainline, but I
will update it to be based on nfsd-testing later.

> 
> https://lore.kernel.org/linux-nfs/98268bb4-2e97-4728-96a6-37b2a4a3ae5d@app.fastmail.com/T/#t
> 
> That patch series replaces the nfsd_export_wq with a WQ that
> is managed in sunrpc.ko. Is that incorrect?
> 
> 

I'm not sure if I understood you correctly. Do you mean that since this
patchset has already removed nfsd_export_wq, I need to adapt more based
on this patchset? Or are you saying that replacing nfsd_export_wq with a
workqueue in sunrpc.ko might not be sufficient because they are two
completely different modules? If you prefer, I can adapt the patch based
on this patchset.

Thanks,
Erkun.


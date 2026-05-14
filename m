Return-Path: <linux-nfs+bounces-21611-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGlJG9wfBWopSwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21611-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 03:05:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A139A53C8A0
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 03:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62754301B70B
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 01:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18062F9D89;
	Thu, 14 May 2026 01:05:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD94C92
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720729; cv=none; b=JqE82d6zgKixMySjDTWvJdxKdeteRAR/rOmbc/pH7A0vnkljLKsJ7FetcfWUcucBcZGpsXmD2tpBuD+I8aVkmsKl+toRTlej/DXKW9Y5a43dNfYyN71NjnJpTmmErfUo69KGq1RmUiAxXgUyx6Kk5U7L12Ox0gb6HQB4nCC9Abg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720729; c=relaxed/simple;
	bh=aMO3phvNP5ouRz1dRyOFX7JDuskUJyNvv15VRoPVDnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGzaShwak3e+iuiSoxxe4MpvdwoIEEPHMzCUeq/ZYTo2Byl2BNUBMa6fGB6F+gahEbssm763drOAkbHvoLA6mzZM6TcrH0DFpz1fl3Z4SAjQV1BLYQVB6OArkavbRLkWYEOkpOsWioYT9e0Iia2bwKN8dBbcQjF5QfzNqnlKkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gGBth5VCtzKHLvk
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 09:04:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A5AFE40562
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 09:05:23 +0800 (CST)
Received: from [10.174.176.240] (unknown [10.174.176.240])
	by APP4 (Coremail) with SMTP id gCh0CgAX31rRHwVq86LbCA--.34013S3;
	Thu, 14 May 2026 09:05:23 +0800 (CST)
Message-ID: <52979c95-bf8a-48d6-b5af-45c82af2cbfc@huaweicloud.com>
Date: Thu, 14 May 2026 09:05:20 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
To: Chuck Lever <cel@kernel.org>, misanjum@linux.ibm.com, jlayton@kernel.org,
 neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 Yang Erkun <yangerkun@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, lilingfeng3@huawei.com
References: <20260513024252.3681597-1-yangerkun@huawei.com>
 <177868131676.213195.3678046994150964706.b4-ty@b4>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <177868131676.213195.3678046994150964706.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX31rRHwVq86LbCA--.34013S3
X-Coremail-Antispam: 1UD129KBjvJXoWrur4UAw4rJr1ftFWUuFW8Xrb_yoW8JF1UpF
	WrArZ8Grs8JFn7AayUA3WjvF4Y9wna9F18CayYkay2qa45Zr15Gr42yr4YgayUuw4rJayj
	q347Xwn8Kw1q9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/
X-Rspamd-Queue-Id: A139A53C8A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21611-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huaweicloud.com,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,huaweicloud.com:mid]
X-Rspamd-Action: no action



在 2026/5/13 22:09, Chuck Lever 写道:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On Wed, 13 May 2026 10:42:52 +0800, Yang Erkun wrote:
>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>
>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks") describes an issue where calling svc_export_put, path_put,
>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>> accessing ex_path or ex_client->name. But after discussion in [1], it
>> seems cannot happen and either will introduce a gression that was
>> already fixed by commit 69d803c40ede ("nfsd: Revert "nfsd: release
>> svc_expkey/svc_export with rcu_work""). Therefore, reverting commit
>> 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>> is necessary to fix this regression.
>>
>> [...]
> 
> Applied to nfsd-testing with an expanded commit message to preserve
> the context of our discussions.

Certainly, this commit message could be more detailed. Thank you for
taking the time to do this!

> 
> [1/1] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
>        commit: ef4e34669aa1a15d2f5ba86fd433fcac9aee81c9
> 
> --
> Chuck Lever <chuck.lever@oracle.com>



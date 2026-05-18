Return-Path: <linux-nfs+bounces-21665-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Le9GqxbC2oCGAUAu9opvQ
	(envelope-from <linux-nfs+bounces-21665-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 20:34:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3660572533
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 20:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16AA1308B352
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2026 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780FA38238D;
	Mon, 18 May 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/vIetob"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559ED2C0285
	for <linux-nfs@vger.kernel.org>; Mon, 18 May 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128897; cv=none; b=XYtHA68Sju2KK5IK0BWsXuY9XdTrcc0QHdAyBD6W/wWer9Ai6ieB/KBDGObr9hVQ05jmXaiqiNruTaFFde2tLmRpy3UMDCXbbkzSpy97mjBEOZZRcQ3Nb7hhb6m1dmBEcpGjTiozb9vPN0KWYyFYuD7McgEbtOVCfhpEsjGNaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128897; c=relaxed/simple;
	bh=5kkyyHtSdw+xAyOPqbRaipeuGguM6CvMFkhU1iLXuxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmiGFLUMCpQZkjcLIvXC0XB7cf3w+o5BKIRLxhK8pChvSkAMllfUJLv7qmTbSJdPiqwa03rsUySq7lV44J1ImUijysUX4qe5ZItmcoE7VxRZrG10gQk46IYN7LqwdsnYO9eFYQqKxrPomjGU7KkKgK5b4JyeIiiLk2gBBfEVDYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/vIetob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0069AC2BCB7;
	Mon, 18 May 2026 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128897;
	bh=5kkyyHtSdw+xAyOPqbRaipeuGguM6CvMFkhU1iLXuxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u/vIetobt9vHeatzbxx5QPiEf01j5aNrv3CTMFCYuEf5SEGMVwc78suTw4xiywooq
	 Pdvj4glGsLfRVRbRqVo2IctFo4bImIciny3q2mB9Cif9tK/Q7KcVb+9b3ngKtcmv0T
	 rsFo4cA2WV5C71n2z0UjTjEw2eLR3+tv/Lduqcim5F0riFRA8s9ILPzzkacnIn/8am
	 xJM0yzYAOkInZ1WLUpiHrSyHixs1c4dk3xDO5fir7yVBcKu9v068+Kw7JtXxGxvWb/
	 MzZbmp8EvphreAQN4PQy6s3QLbdoh6spfYciFddXKQS4QSQIwOJ0HdPagM6yyQFHDc
	 L59njctY1VnSw==
Message-ID: <17f897db-c1cc-4523-b88e-b8469765a21e@kernel.org>
Date: Mon, 18 May 2026 14:28:15 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
To: Calum Mackay <calum.mackay@oracle.com>, misanjum@linux.ibm.com,
 jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, Yang Erkun <yangerkun@huawei.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, lilingfeng3@huawei.com,
 yangerkun@huaweicloud.com
References: <20260513024252.3681597-1-yangerkun@huawei.com>
 <177868131676.213195.3678046994150964706.b4-ty@b4>
 <484d4fc3-8f02-42d6-b5f0-891289dac177@oracle.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <484d4fc3-8f02-42d6-b5f0-891289dac177@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21665-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F3660572533
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 12:57 PM, Calum Mackay wrote:
> On 13/05/2026 3:09 pm, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> On Wed, 13 May 2026 10:42:52 +0800, Yang Erkun wrote:
>>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>>
>>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>>> callbacks") describes an issue where calling svc_export_put, path_put,
>>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>>> accessing ex_path or ex_client->name. But after discussion in [1], it
>>> seems cannot happen and either will introduce a gression that was
>>> already fixed by commit 69d803c40ede ("nfsd: Revert "nfsd: release
>>> svc_expkey/svc_export with rcu_work""). Therefore, reverting commit
>>> 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>>> is necessary to fix this regression.
>>>
>>> [...]
>>
>> Applied to nfsd-testing with an expanded commit message to preserve
>> the context of our discussions.
> 
> Testing looks good, Chuck: no crashes, sosreport no longer hangs, no
> seq_file warnings.
> 
> Tested-by: Alexandr Alexandrov <alexandr.alexandrov@oracle.com>

Thanks. Marked in my private tree, will appear in nfsd-testing on the
next push.


>> [1/1] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
>>        commit: ef4e34669aa1a15d2f5ba86fd433fcac9aee81c9
>>
>> -- 
>> Chuck Lever <chuck.lever@oracle.com>
>>
> 
> 


-- 
Chuck Lever


Return-Path: <linux-nfs+bounces-13569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5046CB21AEE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 04:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F17A189145F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Aug 2025 02:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F214AD2D;
	Tue, 12 Aug 2025 02:46:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209F26AE4;
	Tue, 12 Aug 2025 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754966760; cv=none; b=RbHVxLY63v4EUTHxeieM/vpk0yBKkCvYixapMUDcEcwHhygqtmkwIHCRQnG954ZkKeU34/ez5ThdOZXMPMYR61RTC6ApkAyLL0apr1kIqOsom/P+07L7EgYKeZgH6GTuHTAG97i+0QKvG9bC0lb18afl4hJJib0soa/fkqLOp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754966760; c=relaxed/simple;
	bh=1HyhFN2npQrMKBU0x9wmjzGip5MugRbAfZFqYCyCpnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AwpMgSOMoLECj0jW42mY56n68ueMUAVecCI/ir50FYR4q0KKoclT8ukHeIg3AfhGMzVb3USh+ti91GucE2mdFXj9M/PxYIba3iEXht1wyyC3tCFXRCX7DPt3P2/9Q9RndjHvetlKAqWUMSOZlnvJymO3Xa4qfLSueG1S9xGq0aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c1G3f4nz3zdcDK;
	Tue, 12 Aug 2025 10:41:34 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id E60911402F7;
	Tue, 12 Aug 2025 10:45:53 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 10:45:53 +0800
Message-ID: <1e1eadf5-fab9-4919-a71a-864aa7109c7b@huawei.com>
Date: Tue, 12 Aug 2025 10:45:52 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question]nfs: never returned delegation
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	<anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ff8debe9-6877-4cf7-ba29-fc98eae0ffa0@huawei.com>
 <850dcbf562b7eb5848278937092d2d8511eb648f.camel@kernel.org>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <850dcbf562b7eb5848278937092d2d8511eb648f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemp200004.china.huawei.com (7.202.195.99)

Thanks a lot for reply.

Stateid is marked NFS4_INVALID_STATEID_TYPE when delegation is marked
NFS4ERR_DELEG_REVOKED. nfs_mark_test_expired_delegation will not mark
delegation as NFS_DELEGATION_TEST_EXPIRED again. In this case,
TEST_STATEID and FREE_STATEID will not be send to server any more.
This means that if return-delegation-procedure meet ETIMEOUT, delegation
will be in server clp->cl_revoked list forever.

On 2025/8/11 21:03, Jeff Layton wrote:
> On Mon, 2025-08-11 at 20:48 +0800, zhangjian (CG) wrote:
>> Recently, we meet a NFS problem in 5.10. There are so many test_state_id request after a non-privilaged request in tcpdump result. There are 40w+ delegations in client (I read the delegation list from /proc/kcore).
>> Firstly, I think state manager cost a lot in nfs_server_reap_expired_delegations. But I see they are all in NFS_DELEGATION_REVOKED state except 6 in NFS_DELEGATION_REFERENCED (I read this from /proc/kcore too). 
>> I analyze NFS code and find if NFSPROC4_CLNT_DELEGRETURN procedure meet ETIMEOUT, delegation will be marked as NFS4ERR_DELEG_REVOKED and never return it again. NFS server will keep the revoked delegation in clp->cl_revoked forever. This will result in following sequence response with RECALLABLE_STATE_REVOKED flag. Client will send test_state_id request for all non-revoked delegation.
>> This can only be solved by restarting NFS server.
>> I think ETIMEOUT in NFSPROC4_CLNT_DELEGRETURN procedure may be not the only case that cause lots of non-terminable test_state_id requests after any non-privilaged request. 
>> Wish NFS experts give some advices on this problem.
>>
> 
> What should happen is that the client should issue a TEST_STATEID and
> then follow up with a FREE_STATEID once it's clear that it has been
> revoked. Alternately, if the client expires then the server will purge
> any state it held at that point. The server is required to keep a
> record of these objects until one of those events occurs.
> 
> v5.10 is pretty old, and there have been a number of fixes in this area
> in both the client and server over the last several years. You may want
> to try a newer kernel (or look at doing some backporting).
> 
> Cheers,



Return-Path: <linux-nfs+bounces-20993-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMsGH7hx6GkSKgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20993-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 08:59:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13849442ABB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B11373076C88
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 06:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD9296BA9;
	Wed, 22 Apr 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1HdCSrVX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB235F5ED;
	Wed, 22 Apr 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840952; cv=none; b=OO/7fBvtAPglFfb7I41CizhaciOoycvpwi0HRnBLI2mWQRZKdX5RhcybV+Hm1WGQFfw5SIXg8EZNQywgwkOq8d9fqumIUXhS0tRmiyjwU1fItetIL7q9uN06EfSPQiSNhnrTecVR3Wz1Q/iVL1C/G5Nu+WuVJZI9KWuYvzZ5S6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840952; c=relaxed/simple;
	bh=mqEee0QrHYDOtmcWP/E5ZIAlxoDur/YXjXSnhUnG/kw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qQneRhdAfYwHKjAZ77km0se0pYdJ9MKFOudhzhfiIEKcMbm6qVJ6VGvdBD6gzIDOiowCFhDWs0IFFpDRMvy7e9Pw8u2QiTGEQRWrPuW4xVRorUYEnp6Wmg7j7wS7h9X1cjmWbHGod6q3NLb0vgrQG3p39Cbwy5QkuuINXrvsw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1HdCSrVX; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xbHRn6n8R8OV29cLZUd5H2L9yIWeX2QYHafkpcFNbpE=;
	b=1HdCSrVXC9ikeDIeBgGrWMcA+kDjL7dsJJQ/JXkpUnR7aqDfeDKxiHetgRwKHXFf1/FNKD0WP
	HT5Tu3szf4Tp5QYGZp6BAPF8CYMnX2XQj0CJIBbXaEfTqP60vYOrRUWsmyCDNq/4dMFafcCCIpL
	ZKlXfwFpAAb+ZfGyMKexn0c=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4g0qZt3fGKzLlSv;
	Wed, 22 Apr 2026 14:49:26 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 4DC1F4048B;
	Wed, 22 Apr 2026 14:55:48 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Apr 2026 14:55:47 +0800
Subject: Re: [PATCH] NFSv4: Fix state recovery deadlock when server misses
 grace period
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, Li Lingfeng <lilingfeng3@huawei.com>
References: <20260422064447.358447-1-chengzhihao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e8c5a503-e8b4-11ef-68fb-a0195ce07b07@huawei.com>
Date: Wed, 22 Apr 2026 14:55:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260422064447.358447-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500005.china.huawei.com (7.202.194.90)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20993-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengzhihao1@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13849442ABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/4/22 14:44, Zhihao Cheng 写道:
Add lilingfeng3@huawei.com
> NFS server restart causes client to enter an infinite loop during state
> recovery. The state manager gets stuck in NFS4CLNT_RECLAIM_NOGRACE processing,
> with the server repeatedly returning NFS4ERR_GRACE for each file iteration.
> This problem is reported in [1].
> 
> Trigger sequence:
>   1. Client opens 2 files. After server reboot, client enters
>      nfs4_do_reclaim(RECLAIM_REBOOT). Server misses grace period and returns
>      NFS4ERR_NO_GRACE, causing client to set NFS4CLNT_RECLAIM_NOGRACE.
>   2. Client enters nfs4_do_reclaim(RECLAIM_NOGRACE) to recover first file.
>      Server reboots again, open request returns NFS4ERR_BADSESSION, client
>      sets NFS4CLNT_SESSION_RESET.
>   3. nfs4_reset_session calls nfs4_proc_create_session which fails with
>      ETIMEDOUT due to network¹ÊÕÏ, nfs4_handle_reclaim_lease_error sets
>      NFS4CLNT_LEASE_EXPIRED but does NOT set NFS4CLNT_RECLAIM_REBOOT.
>   4. When nfs4_reclaim_lease runs, because NFS4CLNT_RECLAIM_NOGRACE is already
>      set, it skips setting NFS4CLNT_RECLAIM_REBOOT (the bug, modified by
>      commit b42353ff8d346 ("NFSv4.1: Clean up nfs4_reclaim_lease")).
>   5. Server never receives RECLAIM_COMPLETE, so cl_flags lacks
>      NFSD4_CLIENT_RECLAIM_COMPLETE. When processing subsequent files,
>      server always returns nfserr_grace, causing infinite retry loop.
> 
> Fix it by setting NFS4CLNT_RECLAIM_REBOOT in nfs4_reclaim_lease if
> NFS4CLNT_SERVER_SCOPE_MISMATCH is not set, so that the client sends
> RECLAIM_COMPLETE to the server first, allowing subsequent nograce
> recovery to proceed.
> 
> Fetch a reproducer in [2].
> 
> [1] https://lore.kernel.org/linux-nfs/55da00d4-a656-4ed2-ae57-7f881297a1b2@huawei.com/
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=221399
> 
> Fixes: b42353ff8d346 ("NFSv4.1: Clean up nfs4_reclaim_lease")
> Cc: stable@vger.kernel.org
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Closes: https://lore.kernel.org/linux-nfs/55da00d4-a656-4ed2-ae57-7f881297a1b2@huawei.com/
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   fs/nfs/nfs4state.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index 305a772e5497..817327e73d88 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -2012,7 +2012,7 @@ static int nfs4_reclaim_lease(struct nfs_client *clp)
>   		return nfs4_handle_reclaim_lease_error(clp, status);
>   	if (test_and_clear_bit(NFS4CLNT_SERVER_SCOPE_MISMATCH, &clp->cl_state))
>   		nfs4_state_start_reclaim_nograce(clp);
> -	if (!test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state))
> +	else
>   		set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
>   	clear_bit(NFS4CLNT_CHECK_LEASE, &clp->cl_state);
>   	clear_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
> 



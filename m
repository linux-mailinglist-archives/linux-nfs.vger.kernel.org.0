Return-Path: <linux-nfs+bounces-21023-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIpiOMXh6WmTmQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21023-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 11:09:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92BD44F0D7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 11:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3A943040C75
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470123E1CE3;
	Thu, 23 Apr 2026 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jKYuF0ev"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4893DE43B;
	Thu, 23 Apr 2026 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935136; cv=none; b=Wgu0mz0Zxh4tgDnq1hilT1RlDqUg3S/vGqeXubtUfAMXQAc67MCZbK8kcs+4VHlzReM6p0gHDOv/41M9U+jwsxSqXOCae7/rTl7CdIaO4PEq+kVkBqhoQHQCZSDCj3b2JpIeT1idoX4ZTzzTSkRfbO5sYOR0RQ4rUXxJ4Fvk4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935136; c=relaxed/simple;
	bh=rNMzBEgISL/pOQQX7hMEjmrq+UHR3PPddi5fC4KcJEU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pXs7jWrflcH9bNhlyriYVnXC/qMXQqcSVGV7ZeXbt53ZWWJ4ZdCr23Mr3ZZOEXiGnWucdOYnkCbLrIKWHNDU/wD13KQwG9TVj8MK4S89YIgWw0ii/g7rk7sabRlbZ1V3TDHbBDcep+gX/a0ZZyY4vA4PM7EI8MjiszWviAJlsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jKYuF0ev; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EBnY9xxEmhWT8p+gwIveP0t6HX5Nj9BiveA6sOgAoW4=;
	b=jKYuF0evtEVJKPWqGM4KxIdhEaJDCm6hu2z6opb4Q8QfB1dotTMGLLEnMI1NDVcCXPSBxTs3M
	HM+DHow8yYy25LjJ6/zHbTr2p/8ZQE5Q7xWYtBtMfOo3/lLq8LKtWDyQ75dVv4vrwUOc8QHAYOn
	inAXdDYP/SPDJ5NeiruxiFQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g1VQG1QWFz1T4JS;
	Thu, 23 Apr 2026 16:59:18 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 11BE840561;
	Thu, 23 Apr 2026 17:05:30 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Apr 2026 17:05:29 +0800
Subject: Re: [PATCH] NFSv4: Fix state recovery deadlock when server misses
 grace period
To: Trond Myklebust <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, Li Lingfeng <lilingfeng3@huawei.com>
References: <20260422064447.358447-1-chengzhihao1@huawei.com>
 <e8c5a503-e8b4-11ef-68fb-a0195ce07b07@huawei.com>
 <ac3165e050f4fa9ca4dfd102f7ec1c5e554db693.camel@kernel.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <863ecd04-01be-114e-f625-47b6a918a546@huawei.com>
Date: Thu, 23 Apr 2026 17:05:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ac3165e050f4fa9ca4dfd102f7ec1c5e554db693.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500005.china.huawei.com (7.202.194.90)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21023-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chengzhihao1@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C92BD44F0D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/4/22 20:38, Trond Myklebust 写道:
> On Wed, 2026-04-22 at 14:55 +0800, Zhihao Cheng wrote:
>> 在 2026/4/22 14:44, Zhihao Cheng 写道:
>> Add lilingfeng3@huawei.com
>>> NFS server restart causes client to enter an infinite loop during
>>> state
>>> recovery. The state manager gets stuck in NFS4CLNT_RECLAIM_NOGRACE
>>> processing,
>>> with the server repeatedly returning NFS4ERR_GRACE for each file
>>> iteration.
>>> This problem is reported in [1].
>>>
>>> Trigger sequence:
>>>    1. Client opens 2 files. After server reboot, client enters
>>>       nfs4_do_reclaim(RECLAIM_REBOOT). Server misses grace period
>>> and returns
>>>       NFS4ERR_NO_GRACE, causing client to set
>>> NFS4CLNT_RECLAIM_NOGRACE.
>>>    2. Client enters nfs4_do_reclaim(RECLAIM_NOGRACE) to recover
>>> first file.
>>>       Server reboots again, open request returns NFS4ERR_BADSESSION,
>>> client
>>>       sets NFS4CLNT_SESSION_RESET.
>>>    3. nfs4_reset_session calls nfs4_proc_create_session which fails
>>> with
>>>       ETIMEDOUT due to network¹ÊÕÏ, nfs4_handle_reclaim_lease_error
>>> sets
>>>       NFS4CLNT_LEASE_EXPIRED but does NOT set
>>> NFS4CLNT_RECLAIM_REBOOT.
>>>    4. When nfs4_reclaim_lease runs, because NFS4CLNT_RECLAIM_NOGRACE
>>> is already
>>>       set, it skips setting NFS4CLNT_RECLAIM_REBOOT (the bug,
>>> modified by
>>>       commit b42353ff8d346 ("NFSv4.1: Clean up
>>> nfs4_reclaim_lease")).
>>>    5. Server never receives RECLAIM_COMPLETE, so cl_flags lacks
>>>       NFSD4_CLIENT_RECLAIM_COMPLETE. When processing subsequent
>>> files,
>>>       server always returns nfserr_grace, causing infinite retry
>>> loop.
>>>
>>> Fix it by setting NFS4CLNT_RECLAIM_REBOOT in nfs4_reclaim_lease if
>>> NFS4CLNT_SERVER_SCOPE_MISMATCH is not set, so that the client sends
>>> RECLAIM_COMPLETE to the server first, allowing subsequent nograce
>>> recovery to proceed.
>>>
>>> Fetch a reproducer in [2].
>>>
>>> [1]
>>> https://lore.kernel.org/linux-nfs/55da00d4-a656-4ed2-ae57-7f881297a1b2@huawei.com/
>>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=221399
>>>
>>> Fixes: b42353ff8d346 ("NFSv4.1: Clean up nfs4_reclaim_lease")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> Closes:
>>> https://lore.kernel.org/linux-nfs/55da00d4-a656-4ed2-ae57-7f881297a1b2@huawei.com/
>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>> ---
>>>    fs/nfs/nfs4state.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
>>> index 305a772e5497..817327e73d88 100644
>>> --- a/fs/nfs/nfs4state.c
>>> +++ b/fs/nfs/nfs4state.c
>>> @@ -2012,7 +2012,7 @@ static int nfs4_reclaim_lease(struct
>>> nfs_client *clp)
>>>    		return nfs4_handle_reclaim_lease_error(clp,
>>> status);
>>>    	if (test_and_clear_bit(NFS4CLNT_SERVER_SCOPE_MISMATCH,
>>> &clp->cl_state))
>>>    		nfs4_state_start_reclaim_nograce(clp);
>>> -	if (!test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state))
>>> +	else
>>>    		set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
>>>    	clear_bit(NFS4CLNT_CHECK_LEASE, &clp->cl_state);
>>>    	clear_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
>>>
>>
> This will cause the client to try to do reboot recovery in a situation
> where it isn't allowed to do so by the spec. We should never be setting
> NFS4CLNT_RECLAIM_REBOOT if NFS4CLNT_RECLAIM_NOGRACE is already set.
Hi Trond, the client can only do reclaim reboot during the grace 
period(after server reboot), according to [1], any reclaim type messages 
should be rejected by server for NOGRACE state, am I understanding right?
[1] https://datatracker.ietf.org/doc/html/rfc5661#section-8.4.2.1
> 
> One solution would be to just immediately call
> nfs4_state_end_reclaim_reboot() if NFS4CLNT_RECLAIM_NOGRACE is set.
> 
I tried with your suggestion, and the problem still happens:
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5044bb4c870f..5b6cb3f7ff2e 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2014,6 +2014,8 @@ static int nfs4_reclaim_lease(struct nfs_client *clp)
                 nfs4_state_start_reclaim_nograce(clp);
         if (!test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state))
                 set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
+       else
+               nfs4_state_end_reclaim_reboot(clp);
         clear_bit(NFS4CLNT_CHECK_LEASE, &clp->cl_state);
         clear_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
         return 0;

The nfs4_state_end_reclaim_reboot sends RECLAIM_COMPLETE only if the clp 
has NFS4CLNT_RECLAIM_REBOOT flag, but it does not.

The root cause is that the client has identified an incorrect server 
status after the server's second reboot(since step 2). I think the 
client should do reclaim reboot every time the server restarts, so we 
should let client know the server reboots again, can we take following 
methods?
1. Clear NFS4CLNT_RECLAIM_NOGRACE flag if client knows that the server 
restart while doing nfs4_do_reclaim(NFS4CLNT_RECLAIM_NOGRACE). Client 
could identify the server state by NFS4ERR_BADSESSION retcode:
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5044bb4c870f..3f73dc3919a2 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1875,6 +1875,9 @@ static int nfs4_do_reclaim(struct nfs_client *clp, 
const struct nfs4_state_recov
  						clp->cl_hostname, lost_locks);
  				set_bit(ops->owner_flag_bit, &sp->so_flags);
  				nfs4_put_state_owner(sp);
+				if (ops == clp->cl_mvops->nograce_recovery_ops &&
+				    status == -NFS4ERR_BADSESSION)
+					clear_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state);
  				status = nfs4_recovery_handle_error(clp, status);
  				nfs4_free_state_owners(&freeme);
  				return (status != 0) ? status : -EAGAIN;

2. Client knows the server restarts by error code 
NFS4ERR_STALE_CLIENTID(nfs4_proc_create_session -> 
nfs4_handle_reclaim_lease_error), but nfs4_reset_session won't retry if 
the error code is ETIMEDOUT(eg. network failure in step 3), we should 
let client retry nfs4_reset_session if network failure.
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5044bb4c870f..62fd57e602d6 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2459,6 +2459,8 @@ static int nfs4_reset_session(struct nfs_client *clp)
  	if (status) {
  		dprintk("%s: session reset failed with status %d for server %s!\n",
  			__func__, status, clp->cl_hostname);
+		if (status == -ETIMEDOUT)
+			goto out;
  		status = nfs4_handle_reclaim_lease_error(clp, status);
  		goto out;
  	}
@@ -2552,6 +2554,8 @@ static void nfs4_state_manager(struct nfs_client *clp)
  		if (test_and_clear_bit(NFS4CLNT_SESSION_RESET, &clp->cl_state)) {
  			section = "reset session";
  			status = nfs4_reset_session(clp);
+			if (status == -ETIMEDOUT)
+				continue;
  			if (test_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state))
  				continue;
  			if (status < 0)
3. Conditionaly set NFS4CLNT_RECLAIM_REBOOT in nfs4_reclaim_lease, if 
the client has ever been recovered failed by 
nfs4_do_reclaim(NFS4CLNT_RECLAIM_NOGRACE)->BAD_SESSION, mark clp with 
NFS4CLNT_RECLAIM_REBOOT.
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5044bb4c870f..82eb650cc135 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1875,6 +1875,9 @@ static int nfs4_do_reclaim(struct nfs_client *clp, 
const struct nfs4_state_recov
  						clp->cl_hostname, lost_locks);
  				set_bit(ops->owner_flag_bit, &sp->so_flags);
  				nfs4_put_state_owner(sp);
+				if (ops == clp->cl_mvops->nograce_recovery_ops &&
+				    status == -NFS4ERR_BADSESSION)
+					__set_bit(NFS_CS_NOGRACE_REBOOT, &clp->cl_flags);
  				status = nfs4_recovery_handle_error(clp, status);
  				nfs4_free_state_owners(&freeme);
  				return (status != 0) ? status : -EAGAIN;
@@ -2012,7 +2015,7 @@ static int nfs4_reclaim_lease(struct nfs_client *clp)
  		return nfs4_handle_reclaim_lease_error(clp, status);
  	if (test_and_clear_bit(NFS4CLNT_SERVER_SCOPE_MISMATCH, &clp->cl_state))
  		nfs4_state_start_reclaim_nograce(clp);
-	if (!test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state))
+	if (!test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state) || 
test_bit(NFS_CS_NOGRACE_REBOOT, &clp->cl_flags))
  		set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
  	clear_bit(NFS4CLNT_CHECK_LEASE, &clp->cl_state);
  	clear_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
@@ -2624,6 +2627,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
  				continue;
  			if (status < 0)
  				goto out_error;
+			clear_bit(NFS_CS_NOGRACE_REBOOT, &clp->cl_flags);
  			clear_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state);
  		}

diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 4daee27fa5eb..8d36a727513c 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -51,6 +51,7 @@ struct nfs_client {
  #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
  #define NFS_CS_PNFS		9		/* - Server used for pnfs */
  #define NFS_CS_NETUNREACH_FATAL	10		/* - ENETUNREACH errors are fatal */
+#define NFS_CS_NOGRACE_REBOOT	11		/* - Server reboot during nograce 
recovery */
  	struct sockaddr_storage	cl_addr;	/* server identifier */
  	size_t			cl_addrlen;
  	char *			cl_hostname;	/* hostname of server */


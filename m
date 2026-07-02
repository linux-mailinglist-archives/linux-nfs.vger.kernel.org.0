Return-Path: <linux-nfs+bounces-22947-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7MR4OniGRmpyXwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22947-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 17:40:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C56F98A1
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 17:40:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JCx8n3YK;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22947-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22947-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B733C3085300
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ACC2D7DF1;
	Thu,  2 Jul 2026 15:26:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3537A845
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 15:26:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005989; cv=none; b=sfHAB/SC0JCmkAit15Mt7jodmX9SYkoRtdNiZSc/18nLSf8Bd81Yq1y2Eit/1O/fgDWIA/UeqMD5CMPnTaIJhEtQaNzM6BcQ/oBzeZ88hS+3IoD9mAYcnztNetdALaHW0I2pVCUBbYgEwK0OnEMU+XBYsp6zcQZ5OZhRBJGAjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005989; c=relaxed/simple;
	bh=lYbLfSY2wfPqYaLAz0yoNW+0d/A5ys/3OjQ2XVM1hp8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pPt2CyuoaPu+aA3GkypG5frQIiXOcxl0dhx0/iUxtxsWY4v6Pmvvar2NznhusUa7wWrMO73JMoPje1VaB+ovSsALMLPUBzntz9Vk7BM2myl+50cX8iyw1+/Dm56cKMukC37v1KpH1/K4p2ED0OXCLPs59uwZ52wIthc0h8Zq65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCx8n3YK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31C21F00A3F;
	Thu,  2 Jul 2026 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005987;
	bh=fakQUbhg4iu5o1DAGppVJkuxE9j8ecRQDNR94Opy4YU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=JCx8n3YKRr0lxWnoWJllhKLZkJ1hc6N1cjJOfX9yxef4Lhust61ccorkjqVY5pWGn
	 FfvROSIyqX7vTsVNkFs4joyLONuZdRR1YOTqW9PcqPS4SBraT33GOzPPwCDIHB/6bC
	 dRgB08G4v6PaxZEf6ZlIvKPEKRWUo20hwxWct+XjVcFUzZpeEFGf+z2xIDbaUjzXoK
	 6EyEw6MFmOVibBmeYhfx9XzOy5U9PK5yLABF/hxZmPs7pCfd5blfyuhQM1ZKwhviK3
	 v8CxHsi2YWpusbVfq8P8SP/HIPnWOOWUyy/aYi6gkqU8EJBff478WYSUHGEz89wq4F
	 41fsn3l2kEmZw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id B95AFF40068;
	Thu,  2 Jul 2026 11:26:26 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Thu, 02 Jul 2026 11:26:26 -0400
X-ME-Sender: <xms:IoNGalyZ0dzIe4PdzZx22Swr3pMFLDbs4gtqi891mjy5O5OLFYTtSQ>
    <xme:IoNGagHIZVnZUOX-884-ZN9pTI7YX56Rg1zatraOaj_pW_FU7WQJthSNtZGotdT8f
    _ghpKBQpkNmCKR79hJLFd13ZCHoltiZKXIhoOV3ZFg3bUc9TUVSJnx2>
X-ME-Proxy-Cause: dmFkZTFELOyUmKJXOGybPbSVViV8kEtTpce/IMoJOn3uVRFL02I+DxceOiZW5VV1DFLoTt
    /nbB0SbufJPvnnyk2HVjSCCRjRxsfVw3L6B4kzBm/D/nqXvia/JiLf9/f6p98f4fgJvHIM
    BK05UaLTJCYqSuuRXsB/H1ZA5mj+K4ogAM5lj4LqOMTNCEaPBaL1KfHY81+ZNQzcOcC89O
    ZN0wMJmjSdRrEG5LWBo+2iq+Rm7FupjC67uPt4dxJ4MkeuKbKSCjLKVVYW0X34MSG3PpPE
    R3kAe8KMzCA32YgZcNQ2aXjFWcwHZ1ijbnWkxiIwOY17U24Arah0uW6jzpRogbrwmay6Z+
    8W2owDY+7KuAjqZFOAuucpL/5iBdSGiWukXDFC4wLWKObqxbqZm01l3Y7/xix+6q1iuuts
    fr7C5qxF5lYQbO3yhW9kN1YJwoYAOCkc1pwT4pve6vxSPjWT5EvNZcNQJZRt5vNye26TiH
    zjOr0Rc0yZj5BKSLbqEnWXgk8QwxVvubjEx4vj72q0RK19y4tdMJezNwES5kGq75IHZsSG
    p8xnoisgzszU8BIdLJSCNFAQMyde38Bc6IlepPvHbx16CGp7HuXzzMjGs2kINGDKIFLrl8
    sMSkWlktfvH0mnbk0LW2L/cBS/8JFB4IgJbWN5DQuuDZK76zjyG6gJiN0Rbw
X-ME-Proxy: <xmx:IoNGatMyYm9-5ZK2aDsoajuJ8PwYTJ2bZ8kx77ij5W2oPoIXe4ie_g>
    <xmx:IoNGanu5x2PO4oFzTbS7IjOoVP6Lrt9kpRcmSvV32qZDE8ButUtmyA>
    <xmx:IoNGavX2c_7u4ZCd-Ks188XKmBwPjrBxAVTtU9zetDF28Br86IXDKg>
    <xmx:IoNGanvFrbGnN_VdvwijThjMyMwQDkcjf-x2Rl5YoN2BVxt7IzFifQ>
    <xmx:IoNGajWhoOvousirhRXuMGD391f8lvxKvUaMyTvB8IQZ84tOgt8G4SWz>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9CC45B6006E; Thu,  2 Jul 2026 11:26:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzkmeHV0Khwo
Date: Thu, 02 Jul 2026 11:26:05 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Chuck Lever" <cel@kernel.org>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Message-Id: <dbc2708d-c5b9-494c-ae5e-d95681d55cff@app.fastmail.com>
In-Reply-To: <c0f1a164-7428-4f20-aeb8-8d84759dd73b@app.fastmail.com>
References: <20260617125257.1293452-1-cel@kernel.org>
 <c0f1a164-7428-4f20-aeb8-8d84759dd73b@app.fastmail.com>
Subject: Re: [PATCH] NFS: Return a delegation the client fails to record
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:trond.myklebust@hammerspace.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22947-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE1C56F98A1

Hi Chuck,

On Thu, Jul 2, 2026, at 10:51 AM, Chuck Lever wrote:
> On Wed, Jun 17, 2026, at 8:52 AM, Chuck Lever wrote:
>> When an NFS server grants a delegation in an OPEN reply,
>> nfs_inode_set_delegation() records it on the client. However, three
>> of its error flows return without sending DELEGRETURN.
>>
>> A delegation can be relinquished only by DELEGRETURN (RFC 8881
>> Section 20.2.4), so dropping one silently leaves the server believing
>> the client still holds it. If the server happens to recall that
>> delegation, the client answers CB_RECALL with NFS4ERR_BADHANDLE
>> because it has no record of the stateid. The server revokes the
>> delegation and moves it onto its cl_revoked list, because the client
>> never sends the FREE_STATEID that would drain it. Every subsequent
>> SEQUENCE reply then carries SEQ4_STATUS_RECALLABLE_STATE_REVOKED,
>> and the client's state manager loops issuing TEST_STATEID across its
>> delegations without ever clearing the condition.
>>
>> The window is easy to reach now that a server offers a write
>> delegation on any write OPEN: a delegation recalled for one opener
>> races a re-open that the server answers with a fresh write
>> delegation.
>>
>> Instead of dropping it, hand the delegation back during these error
>> flows.
>>
>> Fixes: ade04647dd56 ("NFSv4: Ensure we honour NFS_DELEGATION_RETURNING 
>> in nfs_inode_set_delegation()")
>> Signed-off-by: Chuck Lever <cel@kernel.org>
>> ---
>>  fs/nfs/delegation.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
>> index 122fb3f14ffb..cb579f8c55ce 100644
>> --- a/fs/nfs/delegation.c
>> +++ b/fs/nfs/delegation.c
>> @@ -440,11 +440,14 @@ int nfs_inode_set_delegation(struct inode *inode, 
>> const struct cred *cred,
>>  	struct nfs_inode *nfsi = NFS_I(inode);
>>  	struct nfs_delegation *delegation, *old_delegation;
>>  	struct nfs_delegation *freeme = NULL;
>> +	bool orphaned = false;
>>  	int status = 0;
>> 
>>  	delegation = kmalloc_obj(*delegation, GFP_KERNEL_ACCOUNT);
>> -	if (delegation == NULL)
>> +	if (delegation == NULL) {
>> +		nfs4_proc_delegreturn(inode, cred, stateid, NULL, 0);
>>  		return -ENOMEM;
>> +	}
>>  	nfs4_stateid_copy(&delegation->stateid, stateid);
>>  	refcount_set(&delegation->refcount, 1);
>>  	delegation->type = type;
>> @@ -493,11 +496,15 @@ int nfs_inode_set_delegation(struct inode *inode, 
>> const struct cred *cred,
>>  			goto out;
>>  		}
>>  		if (test_and_set_bit(NFS_DELEGATION_RETURNING,
>> -					&old_delegation->flags))
>> +					&old_delegation->flags)) {
>> +			orphaned = true;
>>  			goto out;
>> +		}
>>  	}
>> -	if (!nfs_detach_delegations_locked(nfsi, old_delegation, clp))
>> +	if (!nfs_detach_delegations_locked(nfsi, old_delegation, clp)) {
>> +		orphaned = true;
>>  		goto out;
>> +	}
>>  	freeme = old_delegation;
>>  add_new:
>>  	/*
>> @@ -532,8 +539,11 @@ int nfs_inode_set_delegation(struct inode *inode, 
>> const struct cred *cred,
>>  		nfs_update_delegated_mtime(inode);
>>  out:
>>  	spin_unlock(&clp->cl_lock);
>> -	if (delegation != NULL)
>> +	if (delegation != NULL) {
>> +		if (orphaned)
>> +			nfs_do_return_delegation(inode, delegation, 0);
>>  		__nfs_free_delegation(delegation);
>> +	}
>>  	if (freeme != NULL) {
>>  		nfs_do_return_delegation(inode, freeme, 0);
>>  		nfs_mark_delegation_revoked(server, freeme);
>> -- 
>> 2.54.0
>
> Friendly bump! What is the disposition of this submission?

I have it in a testing branch that I haven't pushed out yet. I'm planning
to include it in the next round of bugfixes that I send out.

Anna

>
>
> -- 
> Chuck Lever


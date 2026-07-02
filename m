Return-Path: <linux-nfs+bounces-22946-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pWgcDgp/RmpeXQsAu9opvQ
	(envelope-from <linux-nfs+bounces-22946-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 17:08:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A346F937E
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 17:08:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QZIyfaqb;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22946-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22946-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F353185370
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D70433E73;
	Thu,  2 Jul 2026 14:51:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56F433E76
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 14:51:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003904; cv=none; b=i20dPOIbm5U2cjOMbjBBLgv6JFXToAUbKLBtcMFBMJSN0fBezGagU5MNRMkutvKbRjWVILWlOI3HQUf+T+JsE2kZ+DLrn+QrkGaxSpMb3pBqZrGxRuUlm0qK6kfe5IHkqmQotFS4regpTYWCLCTOfR5XtWHflLpGysCKbs9zqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003904; c=relaxed/simple;
	bh=x6Go4w10QAp67QmubmxUbdtD1IvbhzJGFFMnMp/kd2o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TKgoL8uM3Twh5/OwRssGLtVeeak3CJeG2dSCO2UTFx+FB8QGvVu5fCxGJd7Di2Kk4Y5zK/0BGJWCwj7LhaIwb062B+ZmSzXZsNpGRgRbBhxHAPxN6lkmoQO+N83K0KMmGpUUSoDZ6glVa9mxWr87f2iKNGXz8uDvAahIeV4UEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZIyfaqb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395311F00A3D
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003903;
	bh=ZRhRMu1KEJdMJlvheJQn5pXVsg6Xcf6J3FWrDwmj22g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=QZIyfaqby8zXL+qBsJFq69BTk/oOviNkgdnzRfKSqbJRD5LQ4Wy7vJs4p5zLJWdYq
	 Wzm2YoNTt+7+yvC1NOfCD2JluHHnxLRJ0Jh1GRmHZ7PYdmeCewDw221L0DS7dZnyu6
	 EEjOrxN3qkTiVBTtdqKcdDAi5aWzvlzTkfhag4tsdw5oZeYFH6g78gK4QKygcNESM2
	 y2jg2E2i2I5lT6RSbHFZzNiHl9X3eOzmQzV2vEOJPcIpNb8/GpIoZajGD9Er/9Mzjd
	 q9qFM1xl3le6AmCNnXEbrpIO0ZJEF6QPoL6lSAOMDeKcxYHVwXPXuFDZ7wDo7jSMm1
	 et5wljSS9Uqjw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2855DF40069;
	Thu,  2 Jul 2026 10:51:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jul 2026 10:51:42 -0400
X-ME-Sender: <xms:_npGaiCfkkRYsX6mms4zy3PUA5IcEc2HP8Jafy5K5L63w5KVkvgPdw>
    <xme:_npGanVUczqN8HuWv-z0mt8KIWEoIAkTy_MI8ggJLj4StqEiiHjGokr-5z4uf9Hlm
    O4yCcm82YDCGPMXpTpusJl757ms87r0dc85J3Cz_zrDSR2XFSl2Tg>
X-ME-Proxy-Cause: dmFkZTEN41cA+JqFTcKFXyREOOTnBZcJlJroRts1lyXTF8AoUAffirRjSlcfW+OxJhvT7v
    AjWHqqlfMlBpsfQbRIPskMnK1UY0PhBvnxQ2+5al+x8HhMOlW0LDs4wOvECOuuAOztyZaG
    mUpgu6dJmEoo45T8QqA1H8A87CI0/x+AqQHq9qnrmY2mk78ZBm8hefiZ7HlX30wQv4Z7lR
    +L+ctbF1cfSblX1pWPOjuzPNhCzyUg02Xiq8K29nMBA3mvNgrXxm812UnPsIXdRdcE/LXw
    qSIgA1L7GT2/T0WI+aMlDoP3XkKI4gNIW9sPauYToLgCd3TVn9/0aORJPge9eKW7WE2cRm
    r01KpU8GDO6OZWMp4P6tW+8jzKCpGOK3RRjQe06HIDARmFKizgGw+guDQoC8gU1aSHmHP7
    Tzxd3Yq46YcMFMG19u8kpV6H9BCAnGzJIYXcIeSvrKrt9ZTJVg73sDcGq19JcNxNz83ZsH
    VkiPFwTDYSrzkSphvP4MjFYgp+XcuIEThuxDkVeSMW4bVHPThc+mPzvVEfErrYF4N2lFUA
    P0uXLiYIx5acysr1D752itr7HgmCFp+09qroXLUTxzGei+87TmJHMSxmbGhVu4vSLFwjNL
    I+vszalF96iY+YX/LChdEEITtO/NeHalMaDI+EAVDOjQ92SS+nQdtvMQH9DA
X-ME-Proxy: <xmx:_npGanfbZCDc_IPiXP-5XFGnRKjjNGybAdeOehhZZArCK74mUI5Z3A>
    <xmx:_npGak_fnNQ4l2pH1o6PFvcIU-PteNPDkPiQZ-Emqzck45kJTXVS1w>
    <xmx:_npGajmKoUDLc0HHxQF--XI7ItSxLvwsoLbZYQXrLBP1l5vbbE43IQ>
    <xmx:_npGam-RFIwOQ5Z2S__bYVFR-BHV3fma431vsl3cmF2cZLAjA6xrUQ>
    <xmx:_npGahmwkuHcBWy4hvjMKU8Y3zEFtSo-WbFqi4Pr9jlMGo_kZQLMShZt>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 089C8780AB5; Thu,  2 Jul 2026 10:51:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AahlwDkG3FqF
Date: Thu, 02 Jul 2026 10:51:21 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org
Message-Id: <c0f1a164-7428-4f20-aeb8-8d84759dd73b@app.fastmail.com>
In-Reply-To: <20260617125257.1293452-1-cel@kernel.org>
References: <20260617125257.1293452-1-cel@kernel.org>
Subject: Re: [PATCH] NFS: Return a delegation the client fails to record
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22946-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:trond.myklebust@hammerspace.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82A346F937E



On Wed, Jun 17, 2026, at 8:52 AM, Chuck Lever wrote:
> When an NFS server grants a delegation in an OPEN reply,
> nfs_inode_set_delegation() records it on the client. However, three
> of its error flows return without sending DELEGRETURN.
>
> A delegation can be relinquished only by DELEGRETURN (RFC 8881
> Section 20.2.4), so dropping one silently leaves the server believing
> the client still holds it. If the server happens to recall that
> delegation, the client answers CB_RECALL with NFS4ERR_BADHANDLE
> because it has no record of the stateid. The server revokes the
> delegation and moves it onto its cl_revoked list, because the client
> never sends the FREE_STATEID that would drain it. Every subsequent
> SEQUENCE reply then carries SEQ4_STATUS_RECALLABLE_STATE_REVOKED,
> and the client's state manager loops issuing TEST_STATEID across its
> delegations without ever clearing the condition.
>
> The window is easy to reach now that a server offers a write
> delegation on any write OPEN: a delegation recalled for one opener
> races a re-open that the server answers with a fresh write
> delegation.
>
> Instead of dropping it, hand the delegation back during these error
> flows.
>
> Fixes: ade04647dd56 ("NFSv4: Ensure we honour NFS_DELEGATION_RETURNING 
> in nfs_inode_set_delegation()")
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/nfs/delegation.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 122fb3f14ffb..cb579f8c55ce 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -440,11 +440,14 @@ int nfs_inode_set_delegation(struct inode *inode, 
> const struct cred *cred,
>  	struct nfs_inode *nfsi = NFS_I(inode);
>  	struct nfs_delegation *delegation, *old_delegation;
>  	struct nfs_delegation *freeme = NULL;
> +	bool orphaned = false;
>  	int status = 0;
> 
>  	delegation = kmalloc_obj(*delegation, GFP_KERNEL_ACCOUNT);
> -	if (delegation == NULL)
> +	if (delegation == NULL) {
> +		nfs4_proc_delegreturn(inode, cred, stateid, NULL, 0);
>  		return -ENOMEM;
> +	}
>  	nfs4_stateid_copy(&delegation->stateid, stateid);
>  	refcount_set(&delegation->refcount, 1);
>  	delegation->type = type;
> @@ -493,11 +496,15 @@ int nfs_inode_set_delegation(struct inode *inode, 
> const struct cred *cred,
>  			goto out;
>  		}
>  		if (test_and_set_bit(NFS_DELEGATION_RETURNING,
> -					&old_delegation->flags))
> +					&old_delegation->flags)) {
> +			orphaned = true;
>  			goto out;
> +		}
>  	}
> -	if (!nfs_detach_delegations_locked(nfsi, old_delegation, clp))
> +	if (!nfs_detach_delegations_locked(nfsi, old_delegation, clp)) {
> +		orphaned = true;
>  		goto out;
> +	}
>  	freeme = old_delegation;
>  add_new:
>  	/*
> @@ -532,8 +539,11 @@ int nfs_inode_set_delegation(struct inode *inode, 
> const struct cred *cred,
>  		nfs_update_delegated_mtime(inode);
>  out:
>  	spin_unlock(&clp->cl_lock);
> -	if (delegation != NULL)
> +	if (delegation != NULL) {
> +		if (orphaned)
> +			nfs_do_return_delegation(inode, delegation, 0);
>  		__nfs_free_delegation(delegation);
> +	}
>  	if (freeme != NULL) {
>  		nfs_do_return_delegation(inode, freeme, 0);
>  		nfs_mark_delegation_revoked(server, freeme);
> -- 
> 2.54.0

Friendly bump! What is the disposition of this submission?


-- 
Chuck Lever


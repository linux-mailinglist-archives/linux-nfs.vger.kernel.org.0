Return-Path: <linux-nfs+bounces-20634-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDlmI43Pz2m50gYAu9opvQ
	(envelope-from <linux-nfs+bounces-20634-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 16:32:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F20D39544B
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Apr 2026 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAB4B3007ACD
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2026 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3B239E7E;
	Fri,  3 Apr 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCpXdboG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFA1FE47B
	for <linux-nfs@vger.kernel.org>; Fri,  3 Apr 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226712; cv=none; b=V5hIIyVN4ZgzYSiEt2f/hyWx9tnpJoyVT5SFRE6/QVa5hBv7SjplQL4ZONSlWe+Eq1VyGNZpDlo4rIw8qu0P2ZuDSUq/aPBmzfFqaDb15ZCrlC9k0uH5VAM4CHXg+EAVPmIpCVwFiuPq7w6p/qC+kGaOWHAwhcdyUHugUc2QL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226712; c=relaxed/simple;
	bh=8QWXJhKc6kVtYHpYob9hWVVWYN+lqouzr4OFq0F540Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZDOMU7SFJ94cU9byjatsZkpLDb/cP2wefyaq0fvGFKONwWzOzKVwimt/OZqPIpeSQzED1Ay922wTn6soZV25w7c6ixIniSU0XiufC59RyxQT7ucOdPtnAm3huge5drtbzrSM5HtnRQZ3PfYoArp7RqCRcKLT2K9/utWRI8gTphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCpXdboG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EC3C4CEF7;
	Fri,  3 Apr 2026 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775226711;
	bh=8QWXJhKc6kVtYHpYob9hWVVWYN+lqouzr4OFq0F540Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MCpXdboGj4vHYwB9WqsY+mOrqrZDUKpo7q8X6MXp/lnwLSSfZbY2l8PcWMbCmPvNu
	 T7bM+t6UK9zlNTjlEaw5onva2hq3sKVjz1KcleaSA8QuThHQ7QP6rqCQ6+8V83Spar
	 M+AvLh5FP+Y7Rgn8APYhmGLI5aPaciNKITwMiZNGnc7sljuG1a1C/O1xfxeta3Lpmh
	 F/4hXq77mPVVyLo+IOkGvV67qMmVO0wJfnl0AMj8BhPBK3C5MRdbhRRaHP0++ftTs3
	 UYhOuVtAqOiWvT6Uc0fdKQFsrsSbVf6Qhrz34amLJQHcBSzMpwxRz8rpICYlUMoAMh
	 HpXt+nwlrFJGw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 71B4BF40068;
	Fri,  3 Apr 2026 10:31:50 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 03 Apr 2026 10:31:50 -0400
X-ME-Sender: <xms:Vs_PaRKEKBa_kHTHOFWjFM2PwLV2AG7DfNEZRhBkpXU8S-eJ0JKY4A>
    <xme:Vs_PaX87Dw5epvenrvawciVewcWgI9o5hJIWns8cA0Hhu39PhuzrCVVnZBL1pxmAL
    XGY1QFMLVt7I7IZXnGKgRry-t4U45hNVcERhj2tulHg087ykhNDa2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeludelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgtkhcu
    nfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    fhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutghklh
    gvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleelleeh
    ledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhmrgihhhgv
    fiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Vs_PaddWIOoWBn03K2N5X0BGr0_RoL1ljjBa8wJRDKBsRxZNLmjqAw>
    <xmx:Vs_PaVNB57JYSeehtCA365-RaXqaYSm5hwMpwtnwZwGVRavgH6rioA>
    <xmx:Vs_PadLw6UtGxB0wq_58m-EI9DePaDCtom0Er6ey43kwAqUoWLdF0Q>
    <xmx:Vs_PaVIzSH8Ux7x-N4pisidcoBi0ukjf4SfF23HwKjUpflVPWQBiHA>
    <xmx:Vs_PaX7WNP6bImZ5OTXEqUHv7AsTzzEhtab01Qvi6Ii4TOt6vEGpu9Ei>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 49FDC780075; Fri,  3 Apr 2026 10:31:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO-MVTSxhpB3
Date: Fri, 03 Apr 2026 10:31:29 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Scott Mayhew" <smayhew@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Message-Id: <7ab0da92-bb0e-466a-b566-acc832ae56c2@app.fastmail.com>
In-Reply-To: <20260403132209.1479385-1-smayhew@redhat.com>
References: <20260403132209.1479385-1-smayhew@redhat.com>
Subject: Re: [PATCH] nfsd: fix file change detection in CB_GETATTR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20634-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8F20D39544B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, Apr 3, 2026, at 9:22 AM, Scott Mayhew wrote:
> RFC 8881, section 10.4.3 doesn't say anything about caching the file
> size in the delegation record, nor does it say anything about comparing
> a cached file size with the size reported by the client in the
> CB_GETATTR reply for the purpose of determining if the client holds
> modified data for the file.
>
> What section 10.4.3 of RFC 8881 does say is that the server should
> compare the *current* file size with size reported by the client holding
> the delegation in the CB_GETATTR reply, and if they differ to treat it
> as a modification regardless of the change attribute retrieved via the
> CB_GETATTR.
>
> Doing otherwise would cause the server to believe the client holding the
> delegation has a modified version of the file, even if the client
> flushed the modifications to the server prior to the CB_GETATTR.  This
> would have the added side effect of subsequent CB_GETATTRs causing
> updates to the mtime, ctime, and change attribute even if the client
> holding the delegation makes no further updates to the file.
>
> Modify nfsd4_deleg_getattr_conflict() to obtain the current file size
> via vfs_getattr().  Retain the ncf_cur_fsize field, since it's a
> convenient way to return the file size back to nfsd4_encode_fattr4(),
> but don't use it for the purpose of detecting file changes.
>
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> Note this patch is against Chuck's nfsd-next branch.

Thanks for the patch! I prefer patches against nfsd-testing, though
this patch applied just fine there. This fix will likely go in via
an early 7.1-rc PR.


> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b4d0e82b2690..2c82438918f6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9372,7 +9372,7 @@ static int cb_getattr_update_times(struct dentry 
> *dentry, struct nfs4_delegation
>   * caller must put the reference.
>   */
>  __be32
> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry 
> *dentry,
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
>  			     struct nfs4_delegation **pdp)

The kernel-doc comment for nfsd4_deleg_getattr_conflict also
needs to be updated since you have modified the name of one
of its parameters.


>  {
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> @@ -9381,7 +9381,9 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst 
> *rqstp, struct dentry *dentry,
>  	struct nfs4_delegation *dp = NULL;
>  	struct file_lease *fl;
>  	struct nfs4_cb_fattr *ncf;
> -	struct inode *inode = d_inode(dentry);
> +	struct inode *inode = d_inode(path->dentry);

Nit: relocate this declaration to maintain reverse-christmas
tree ordering

> +	struct kstat stat;

A minor concern here -- The caller already allocates its own
struct kstat via struct nfsd4_fattr_args. Two kstat instances
on the stack simultaneously is meaningful on 8KB stacks. Worth
verifying with scripts/checkstack.pl, especially under
CONFIG_KASAN or CONFIG_FRAME_WARN builds.


> +	int err;
>  	__be32 status;
> 
>  	ctx = locks_inode_context(inode);
> @@ -9430,19 +9432,22 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst 
> *rqstp, struct dentry *dentry,
>  		    !nfsd_wait_for_delegreturn(rqstp, inode))
>  			goto out_status;
>  	}
> +	err = vfs_getattr(path, &stat, STATX_SIZE, AT_STATX_SYNC_AS_STAT);
> +	if (err) {
> +		status = nfserrno(err);
> +		goto out_status;
> +	}

When ncf_file_modified is already true (set on a prior call),
the check at line 9527 is skipped, so stat.size is never used.
Perhaps the new vfs_getattr() could be skipped in that case.

Also, after a successful delegation recall, proceeding with
CB_GETATTR comparison logic is probably unnecessary. But that
particular control flow predates your patch.


>  	if (!ncf->ncf_file_modified &&
>  	    (ncf->ncf_initial_cinfo != ncf->ncf_cb_change ||
> -	     ncf->ncf_cur_fsize != ncf->ncf_cb_fsize))
> +	     stat.size != ncf->ncf_cb_fsize))
>  		ncf->ncf_file_modified = true;
>  	if (ncf->ncf_file_modified) {
> -		int err;
> -
>  		/*
>  		 * Per section 10.4.3 of RFC 8881, the server would
>  		 * not update the file's metadata with the client's
>  		 * modified size
>  		 */
> -		err = cb_getattr_update_times(dentry, dp);
> +		err = cb_getattr_update_times(path->dentry, dp);
>  		if (err) {
>  			status = nfserrno(err);
>  			goto out_status;


-- 
Chuck Lever


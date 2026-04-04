Return-Path: <linux-nfs+bounces-20655-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBaAGs0p0WlsGAcAu9opvQ
	(envelope-from <linux-nfs+bounces-20655-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 17:10:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AF239B83D
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 17:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5F1A301F9CF
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916772DEA95;
	Sat,  4 Apr 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThJPlP3G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB82DB79F
	for <linux-nfs@vger.kernel.org>; Sat,  4 Apr 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315301; cv=none; b=lvm55U8977tU76u6xJqA751UQ57ygRtO2vw+oJXMatzm+fAy6eP6TJTciggltvNI8oMiGotR4pIBhfrnQJALwkvxhuLqvhn8dnUzEQMgR5iLg837foIdOTnWbAyhwcCwqzvAQsT8PGDY6sGKyvGX4c5DeNJGUXeuSpxd+GFZEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315301; c=relaxed/simple;
	bh=EC7OkasM5IygTNZ+kQsUWEqyT0X9rQNK0sXtIZkDcjo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sP9ybltFm8OSFgVvZGsa4cOqxP8sCJOXIqKxiEcVlN51yDI/t1eR4OxaAkRDxDXAqmrwt2tuJAKpcV2v23yTP5ApMMCVl7dgpTRg3jxXMqrBQ149r2adai21NwBnwQl6ifrDj/eYl0u/PTLV3/MTVGc9ARBmIpIJBZRRIDu2KBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThJPlP3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB6EC19425;
	Sat,  4 Apr 2026 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775315301;
	bh=EC7OkasM5IygTNZ+kQsUWEqyT0X9rQNK0sXtIZkDcjo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ThJPlP3GL+950M42ZbPhopTP8ANKLEAYfqaqpTpsKkIbUvq/0eoJwnk9HOxxRxEF4
	 n8LwgZdlD1hs7DsfLLY1izXZDHMcgZ5Ww30NScaaqMojnhUupi2B6KT2Ayg5NDGmOi
	 AHJWseWzwFHdc5jStTw5w5+neElyK9oPi0X8+e6/qux/eWzy3VqMrkvig3Vz7QRPPv
	 smBEjKFYWSQ4CY58zB3Ap8qBIB8IfzU7LUk69yIytFKXD8q5RGDhs/GjVipLjx3BTq
	 osAm9F+JwPeFTzacGg71hJqW/uz4LVOFllBNs+AkkE9kUqMOCG3hC3YjDQ21bZlOG4
	 oCyLbbRzB2GGQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9560AF40084;
	Sat,  4 Apr 2026 11:08:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 04 Apr 2026 11:08:19 -0400
X-ME-Sender: <xms:YynRaeENzVywyfGa5otnLQe2Ora0UIxVKIYdIjnm9-xvmqSEiuUKNg>
    <xme:YynRaaLiwYKagOH_Vdip2qJIOjKifS6uJISFneFIQ6_V6dJzAvBNwR6bjyqYk_kX8
    5JDVjHx6mlxLOFXHu9OrbndYYk9RpXleWe2pwQJI-qRbMTRFwkzlOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpth
    htohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehsmhgrhihh
    vgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomh
    dprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YynRadZnMqRNyhGp6fGjRNBgsq29CTNTyGLuxEt1QGNjK0bXwkAdwQ>
    <xmx:YynRaeaX8fSl2qXBtqTvKBWpCkXnHCIIAclUhdJwGms5FKljKfqB_Q>
    <xmx:YynRaWnfnP3pwbuCgi2AT-LBp5yXJANArabePtPeL_ohaT5fV8dSMA>
    <xmx:YynRaZ1zB9AD39wQnqNVa1HKs45TWwOsdxQuolLgIo2vcLa-OJItTw>
    <xmx:YynRaW2YioIsgKNtVM2xMdMs7iXlslPazBJAMtN8SsHBQUNyX3IaI8Ah>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 722B5780070; Sat,  4 Apr 2026 11:08:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMVA-RgOnKPZ
Date: Sat, 04 Apr 2026 11:07:59 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Scott Mayhew" <smayhew@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Message-Id: <e03d3523-06e1-4414-b185-d349e7edbe54@app.fastmail.com>
In-Reply-To: <20260404005405.1565136-1-smayhew@redhat.com>
References: <20260404005405.1565136-1-smayhew@redhat.com>
Subject: Re: [PATCH v2] nfsd: fix file change detection in CB_GETATTR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20655-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3AF239B83D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Fri, Apr 3, 2026, at 8:54 PM, Scott Mayhew wrote:
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
> Also, if we recall the delegation (because the client didn't respond to
> the CB_GETATTR), then skip the logic that checks the nfs4_cb_fattr
> fields.
>
> Fixes: c5967721e106 ("NFSD: handle GETATTR conflict with write delegation")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fa657badf5f8..53d8e7e7d60b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c

> @@ -9459,17 +9461,18 @@ static int cb_getattr_update_times(struct 
> dentry *dentry, struct nfs4_delegation
>   * caller must put the reference.
>   */
>  __be32
> -nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry 
> *dentry,
> -			     struct nfs4_delegation **pdp)
> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct path *path,
> +			     struct kstat *stat, struct nfs4_delegation **pdp)

Passing the kstat struct in saves some stack just as I suggested,
but it is an ugly API. The nfsd4_encode_fattr4() call stack is tall,
though -- did you happen to measure how deep it gets after this patch
is applied?


>  {
>  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
>  	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
> +	struct inode *inode = d_inode(path->dentry);
>  	struct file_lock_context *ctx;
>  	struct nfs4_delegation *dp = NULL;
>  	struct file_lease *fl;
>  	struct nfs4_cb_fattr *ncf;
> -	struct inode *inode = d_inode(dentry);
>  	__be32 status;
> +	int err;
> 
>  	ctx = locks_inode_context(inode);
>  	if (!ctx)

-- 
Chuck Lever


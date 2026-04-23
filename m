Return-Path: <linux-nfs+bounces-21043-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJaZLJMi6mnKuwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21043-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:45:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5533453391
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A14530406A0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C75274B2B;
	Thu, 23 Apr 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxoX0D3c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF626E173
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951463; cv=none; b=AzOjR6VpOEz6vfuciflcd13ORx2FUVEscGbpEhrxUYvDCrPIAg0raRbA+OZHCPgHkx9Cgejg5KOzReRlt3Dwq5aafObVAS8iRvuF88C/ha4pEnaG4xg8XMc4jR3Ml7Vgdw0x6YEtqt7OHpRardiO6uhlbICugzflkUJrto6htqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951463; c=relaxed/simple;
	bh=Wi00w6ENjFNwsu8/dJgFFPmgYZs90mEnllO5mBGsrM0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BixnT/DutIC+sRK9SHTXOHdUp4jQfkSCWC6tFfGVT+aXB4cDlVEC+pZnhKxBt+ApX8A5DbtTiCmfd16EACkzIn9GwArMVmgkLReXUqx7Xwu6o99rOk8sQ1nqd9/Jk4jUTEkM6b9jVlomkvA63Fl+JuNAPUBTTnL64DGMxjCx+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxoX0D3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F26C2BCAF
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 13:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776951463;
	bh=Wi00w6ENjFNwsu8/dJgFFPmgYZs90mEnllO5mBGsrM0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pxoX0D3clZWiB0ZR66n04KfuXb/qAoJQNlMfL3U/7RgwGk4dBdYwdxIxWltjs5tyB
	 hnlVrJDQCVb588UgPPSPoUpSs8va1GE/H557BxqoBdhCAZursLBfVlhds5Hcg3c11H
	 Os1nJ7QelDsmAWsINKlq4Ck0dSaKI0VM5OheZeeEgM+PPcT1wU04vl44FKNh8VE98Q
	 h11gC2epT6jX84snPVpaXh4axDEWxnITx3TEivv689hvIOblOTS2aOp0zRtfMuPG1T
	 BAuTeudet/zXVm5vAukwitdv5GZvAhG3nKCsg+ROYaIbnmwBkkdn9Wq0+Y0vqeuFCT
	 yL/27+FWOX1LQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 30048F40068;
	Thu, 23 Apr 2026 09:37:42 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Thu, 23 Apr 2026 09:37:42 -0400
X-ME-Sender: <xms:piDqaX2Bl0a1ksMttUMTWXRZsQFTKzhrf5SGOwUGouEeBI_wdqLvcQ>
    <xme:piDqaQ5Eo81o__dchltCR-bC5rYmm4sC0zKmKJEQk9rjkY3Tgv3pPTw8s6_BpZZ6j
    caSQBfj1rFSyO-NXwvrx-XdZyeWNTpaJmEIaM3POPFt4UnpOxAQJQVe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetnhhnrgcu
    ufgthhhumhgrkhgvrhdfuceorghnnhgrsehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepfeeikeejieelgeettdeukeejheeghfduhfejjefgfeetffetkeeghfetveei
    ueeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnnhgrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejjeduvddtjeel
    qdeffedvvdefgeejuddqrghnnhgrpeepkhgvrhhnvghlrdhorhhgsehnohifhhgvhigtrh
    gvrghmvghrhidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhoghhhhihrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlrg
    ihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:piDqaRYBsV0DXTuV_v3FuaVERBJORELd1ab2SO4878okev_5a9CSTw>
    <xmx:piDqaZ5kQIWlW7E8a9N5-MUANgpiRGUEsG43pgY_LpMqv-NF6NX22w>
    <xmx:piDqaUCIjpGJUeqIUqF-YZoV8x0DRdQYolPcf7f_FuXXLuV7SelPkw>
    <xmx:piDqaffcFSdxeccDPvRrbEfYybTz91NS9jrJsMeSAuv8ZpdL3GR2jQ>
    <xmx:piDqaTJHwoQiSpyLuGx7ohQdCG6RJVX0IAAyI37OzUHV8psV4knqdElR>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E562B6006E; Thu, 23 Apr 2026 09:37:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-TK9qMDiVvw
Date: Thu, 23 Apr 2026 09:37:21 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Tom Haynes" <loghyr@gmail.com>, linux-nfs@vger.kernel.org
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <32c25063-3b89-4d00-87c5-3334327586c3@app.fastmail.com>
In-Reply-To: <20260418190301.3661-2-loghyr@gmail.com>
References: <20260418190301.3661-1-loghyr@gmail.com>
 <20260418190301.3661-2-loghyr@gmail.com>
Subject: Re: [PATCH 1/1] nfs: don't skip revalidate on directory delegation when attrs
 flagged stale
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21043-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:server fail];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A5533453391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tom

On Sat, Apr 18, 2026, at 3:03 PM, Tom Haynes wrote:
> On a local directory mutation (rename/create/unlink) the client marks
> CHANGE / MTIME / CTIME as invalid in NFS_I(dir)->cache_validity.  When
> a subsequent stat(2) enters __nfs_revalidate_inode() and finds a
> directory delegation held, the function currently early-exits and
> returns the cached (now stale) mtime to userspace without sending a
> GETATTR RPC.
>
> Keep the early-exit for the fast path, but take the RPC when CHANGE,
> MTIME, or CTIME are already marked invalid.  The delegation alone is
> not a guarantee of cached-attr freshness once the code itself has
> flagged the cache as stale.

Is this a problem only for the attributes you've flagged, or do you think
it would be a problem for size, nlink, or mode attributes as well? I'm asking
because we have NFS_INO_INVALID_ATTR which includes all of these attributes
which might make this a little more generic rather than carving out an
exception an attribute at a time.

Thoughts?
Anna

>
> Assisted-by: Claude:claude-opus-4-7 [bpftrace] [tshark]
> Signed-off-by: Tom Haynes <loghyr@gmail.com>
> ---
>  fs/nfs/inode.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 98a8f0de1199..936bc329f462 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1390,7 +1390,11 @@ __nfs_revalidate_inode(struct nfs_server 
> *server, struct inode *inode)
>  		status = pnfs_sync_inode(inode, false);
>  		if (status)
>  			goto out;
> -	} else if (nfs_have_directory_delegation(inode)) {
> +	} else if (nfs_have_directory_delegation(inode) &&
> +		   !(NFS_I(inode)->cache_validity &
> +		     (NFS_INO_INVALID_CHANGE |
> +		      NFS_INO_INVALID_MTIME  |
> +		      NFS_INO_INVALID_CTIME))) {
>  		status = 0;
>  		goto out;
>  	}
> -- 
> 2.53.0


Return-Path: <linux-nfs+bounces-20657-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL9VEX1Y0Wm/HwcAu9opvQ
	(envelope-from <linux-nfs+bounces-20657-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 20:29:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A437D39C097
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 20:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E880E3006B2B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC603368AB;
	Sat,  4 Apr 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hNkDZfNE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C732512C8;
	Sat,  4 Apr 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775327353; cv=none; b=HMBbKVq6nXrMbdqaIueK66UClvHfZmyHWjgwlGoJD3MR/c4b3rIMNJNQyh/+oPFdPSNqGgi7LTiKl1cRml8gU4oAogAKrCcskAmZX+lds6WevM5WrJxe+qq1+NhsxKs4rRQt3ze5/HcahtsGMgoCq26B8GDx/h8LqTEhHlD0fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775327353; c=relaxed/simple;
	bh=nL1L7o+lv3KBLOUnskn8apIM+PiqO7lhuZh5ljkMjqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPZhMejGExW/mgJeTX7eCuq7S9UN+GtHQQUuSGP536T4eqvPPK8RxCI4oKkW4wCZ84smf6Cisrv2h8BS4WOrrS/4rKDEg1aJ5AIREm8X5LSQIR/h6CD8n94x2wVqwnLN8QZRcj4ugrBlS7FDNNoi6uW7nmfYk88GVQoxT0pdPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hNkDZfNE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rrTHR7dNnaez2Bbwh4FimXhFORdbtkfPUjsahhkg/8s=; b=hNkDZfNEtm92gnsyOSfdlc/lpg
	P+vYPCDL6+0Z98oqOI2UD3ZPgicqWqYKVQuAn61sDrT7R0IM+3pG+lBQjC1VxJSOridwZGtiR10DC
	leYYZYl1MKij1c2OuWo4qTE1gVITijDdlUfqijnL5amfV8Cyerx0pdZ+70etVPT7A4eFsiZAny5aU
	ggnd4IcvPEVim6EGhwpR0C3G1ICJd+8xOeOliV6osuc2sprNMVEV3hJHoXIljjd+PmipZNkQRMx4p
	TratFN6vAUT84od2SvVjFhIqM5NBFtOTULR02Bk2+Itja+dozYrvZYh3DpujaND0JyBttPEcC9J4x
	YVH+IMxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w95nb-0000000BkjH-443x;
	Sat, 04 Apr 2026 18:32:48 +0000
Date: Sat, 4 Apr 2026 19:32:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <20260404183247.GA2798238@ZenIV>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org>
 <aUnq_d93Wo9e-oUD@infradead.org>
 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20657-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A437D39C097
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[cc to fsdevel added]

On Wed, Dec 31, 2025 at 09:52:35PM +0000, Trond Myklebust wrote:

> +static void nfs_clear_verifier_directory(struct inode *dir)
> +{
> +	struct dentry *this_parent;
> +	struct dentry *dentry;
> +	struct inode *inode;
> +
> +	if (hlist_empty(&dir->i_dentry))
> +		return;
> +	this_parent =
> +		hlist_entry(dir->i_dentry.first, struct dentry, d_u.d_alias);
> +
> +	spin_lock(&this_parent->d_lock);
> +	nfs_unset_verifier_delegated(&this_parent->d_time);
> +	dentry = d_first_child(this_parent);
> +	hlist_for_each_entry_from(dentry, d_sib) {
> +		if (unlikely(dentry->d_flags & DCACHE_DENTRY_CURSOR))
> +			continue;
> +		inode = d_inode_rcu(dentry);
> +		if (inode &&
> +		    NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0))
> +			continue;

What's to stop the inode from being freed right under you?  You are *not*
guaranteed to be holding rcu_read_lock(), unless I'm missing something
in the call chain, so... what's going on here?


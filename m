Return-Path: <linux-nfs+bounces-22247-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yHs/KYFxIGom3gAAu9opvQ
	(envelope-from <linux-nfs+bounces-22247-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:25:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 112FC63A86D
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=tUVPAFX1;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22247-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22247-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E9A93020EAA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619AE388E63;
	Wed,  3 Jun 2026 18:25:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB03955CC;
	Wed,  3 Jun 2026 18:24:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511100; cv=none; b=XuVUR3q/SUzCeigy2li9QXZ39JF8ggG9em8WVeaVp+alKOHSSENnWaY/cvzB4eJW2c6iW9FgprPSwlejyJLKk45UI6YbZ7dsOMZ69ZFVRNdhq271Nh65HojINDHnhlroGDfxkh7x2vixxT7y6DaUGk9x/mWjTI3/aKK/BIt8aiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511100; c=relaxed/simple;
	bh=WLYqUesgcDr4LX2n8qfsKdbsKIVER8TwmjRwMb3Ma1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=devRpu6p8VZy7S3vk/c5OcjA8Uh0+43Um/3wApDc7/y84xEk8nOPGfmEpMRcZmhGexyH/Iot6rd6BGCm/bH5uz1i9VG8yMUXyNwWpCkknSLHqgKuBT98PaBY58R3j8W259VTcIrLli5UMfdl0gn2+TnMq7ZcNEriCptPntMr11Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tUVPAFX1; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vxqXf4xINuxySC9gZHqUgg5CWpYdSyQtcELGTA+vJ8w=; b=tUVPAFX1eNVGspOtZ/bkOnwx8t
	hb47GN2YysvwHcZN7c0EMASO0RMsp2goPITxrGJRSu/ZVp85nrWuKPZ/BzwEg6EIliUoE4cZmu0fW
	UX3skZz1+WrSw/kbr5OmF8z4kcbhKn8bppn1ohJGG/eXVKmMODTF/NpBnv3B0j8sq8k/sZjKugRYB
	71UX9D5JpsqkTSRuFOP9XDfCoIICq3nJrAqbxX8g7vV5s4RxBJSLOy4ywjL/7OngnDft3BTxOlUM5
	fjT9wUNQ1i5HdfgSlnt/74j/DcbUxpYI4gzIJ93ZnWKrX0RBlZEELOTWKysSc/nyYyhrjczKHyuwh
	GdnJKqjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUqGs-0000000F5wI-3oey;
	Wed, 03 Jun 2026 18:24:55 +0000
Date: Wed, 3 Jun 2026 19:24:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in
 may_decode_fh()
Message-ID: <20260603182454.GX2636677@ZenIV>
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603181523.GW2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22247-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 112FC63A86D

On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> 
> > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
> > in __prepend_path().
> 
> > +	/*
> > +	 * Containing namespace.
> > +	 * Normally protected by namespace_sem, but there are also lockless
> > +	 * readers (which must use RCU to guard against the namespace being
> > +	 * freed).
> > +	 */
> > +	struct mnt_namespace *mnt_ns;
> 
> Umm...  It's somewhat subtle - at the very least you need to explain why
> there will be an RCU delay between umount_tree() clearing that and
> having the sucker freed.

Something along the lines of "removals from namespace are serialized on
namespace_sem and guaranteed to happen no later than the active
refcount on namespace reaches zero; freeing of namespace happens only
after the passive refcount hitting zero and there's an RCU delay between
dropping the last active ref and dropping the passive one that had been
implicitly held by the fact of having actives", perhaps?  Only in
more readable form than that, please...


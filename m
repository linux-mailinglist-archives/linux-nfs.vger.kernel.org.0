Return-Path: <linux-nfs+bounces-22250-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xOGNGnJ5IGoi4AAAu9opvQ
	(envelope-from <linux-nfs+bounces-22250-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:58:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ACC63AB48
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=SoillID1;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22250-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22250-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B69F30D4353
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDA47887A;
	Wed,  3 Jun 2026 18:50:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DB477E53;
	Wed,  3 Jun 2026 18:50:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512619; cv=none; b=rWl1WfdDgtPe4YY642hKGNxa6/JQ+GYcJomBFFvurSjn8AvkAb6ZIO5/FP7fshKTQFl0KsVESHAE+Euz5nLcjTwIi33KnYJWtoSVanwT8dC28tuOUh6mgSDroT0dluiVbc8SszAitc6376sS5YQdpGyhS/2w6k6UYHw5DJJ2sWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512619; c=relaxed/simple;
	bh=SOlEDK8Sh9S2cMXhhYkWYasiHpYHLpJKORMAEbz9zyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU84O7mFiPUiiB4TrpOY8JcAj+1BFmeNT0TorqxnPQkrXMb1SD+Tsx/LTP861qmlOPZwLLvKwn+fWBisbYFOfpWBb2ZerI6BtoA3KWIg+e4E64J7+aIWi/GbK3oE7Jv+LPdU1w6691quxU1cpWMO3o3FZP9UqPFgjuq/y5tmyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SoillID1; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HQV8SMIS7Y3ZO98u+aiPCRRGt8QfOs3Rmxeaom911Yk=; b=SoillID1fearalSiq+aJ5RD241
	H8yqIqX4OiMpcxANNHIZPvR6XdNBHvA1mUMM+G9qpBwyUP8YCr7tiE4QxfjMzhtzZ3guxLIKIjgBv
	sDKpjV56h8JtXuBhiMW5RUmyq+NEB/0FtX3uf/lsMX9GQRaqjrDPN3CzgH0WgLrNAJNsLqowT3Fj/
	xCG2c/RhVi6dB3sr089gkLt6/ZL+k96vaEtsdEMEb4YrWd78s8rrp+qOE6S4Bge4GMnbvU36Ye/b2
	440ZzgstzY1UxelZ1S+LgYKtDIyR/wYTZalxy8cXzF3djXE/exINiZV5UIHmg0s5Td37S9FsTLbOD
	OybePIHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUqfN-0000000FC3C-2Z3m;
	Wed, 03 Jun 2026 18:50:14 +0000
Date: Wed, 3 Jun 2026 19:50:13 +0100
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
Message-ID: <20260603185013.GZ2636677@ZenIV>
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV>
 <CAG48ez1DGQ8MbFWWi+n0Br84cBF_wSrNgPqd+NSxAcbAK7WR7g@mail.gmail.com>
 <20260603184151.GY2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603184151.GY2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22250-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ZenIV:mid,vger.kernel.org:from_smtp,linux.org.uk:dkim,zeniv.linux.org.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6ACC63AB48

On Wed, Jun 03, 2026 at 07:41:51PM +0100, Al Viro wrote:

> Basically, the store that cleared ->mnt_ns has been done in namespace_sem
> scope and that scope is either no later than the scope in put_mnt_ns()

argh...  s/either//

> that has dropped the active refcount of ns to zero.  At the beginning
> of that scope in put_mnt_ns() we are guaranteed to have the passive
> refcount positive.  Dropping the passive reference happens after an
> rcu delay started in later in the same namespace_sem scope and namespace
> is not freed until the passive refcount reaches zero.

TL;DR: your fix is correct, but needs a better explanation of correctness.
If nothing else, I'd like to have the above findable on lore - I've way
too many pieces of half-baked docs sitting around in local notes as it is ;-/


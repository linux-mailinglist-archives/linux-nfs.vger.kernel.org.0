Return-Path: <linux-nfs+bounces-22033-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I/xAAwzGGpwfggAu9opvQ
	(envelope-from <linux-nfs+bounces-22033-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 14:20:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B15F1FCF
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 14:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 247293044229
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970003E8334;
	Thu, 28 May 2026 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKiHipbQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575AE3C1995;
	Thu, 28 May 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970559; cv=none; b=MOw+XnFT/qQjSn9lNKvv1AopQ42xj2h9Uba9h/TGGcJSzOoLojdTidEEsByCeZVsJKRSPHc+EzjPKDvnEh9lUfStioeolz+kgeuomnrNsdfpPg8ADjMs2YXqpN0Dy2WiDOsVV6uOLilmZ+77t2ipj4Dri0xsbqCqCWSfkK8/cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970559; c=relaxed/simple;
	bh=jduyOddm1w/62GxuKwhZlAMn9Uy1hy6B1CYxpzSvEIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4Y3GTkK/sUqf6Cy9XCp9StcptJmNQc+Zo9nuwEeszSFRvm4dhAVfGXxHajgiR5zu9ns24NBRk4xmM0flVAnSXdidrdVe6mGJSSLKJ3OA89ouX/7IsIZzEt3kl3porevBp2rgwTpY11MTWzItr0T3g8dThrQnm+0508zFzzFLr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKiHipbQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D552D1F000E9;
	Thu, 28 May 2026 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779970558;
	bh=UysbNyfvAjkVy9DRRcTvJQ6wPGWubJrnwL4DjUJ3YqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jKiHipbQ5OmOEhk3X2ii96RMwbZaGSuyaSm551RYWptZ9b/JypkdTWn7YY7at+eHE
	 eFWymWGCCqScj4/frMG99Zx9hbpc2bg9tQsLxi+lylCmGJ8Puw7PjWd0ulLEqJDOds
	 TxqVd9irp9tiO/JdN+lEGSE5foHFkW3MBIMHQ624iPQ72JvhXPZdaZ7Bh3fAlZB1QR
	 jHf4WP3GpNxTaquBytHqZWNqXjrtQqkdkLXNTKlbgvc4opWjTYJKcB1rJ9v0k+7A1L
	 04vkPxW2dusClfVoP6IVZXR2AgfpBzSffVEiiLqSiO0TYXTJM6VoGUnvO0U+V5OtGL
	 WMXjGVxuv/pqw==
Date: Thu, 28 May 2026 14:15:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: fix possible failure to unlock in
 nfsd4_create_file()
Message-ID: <20260528-flohmarkt-leiharbeit-vielzahl-797524281a0f@brauner>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22033-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 701B15F1FCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 04:23:45PM +1000, NeilBrown wrote:
> 
> atomic_create() in fs/namei.c drops the reference to the dentry
> when it returns an error.
> This behaviour was imported into dentry_create() so that it
> will drop the reference if an error is returned from atomic_create(),
> though not if vfs_create() returns an error (in the case where
> ->atomic_create is not supported).
> 
> The caller - nfsd4_create_file() - is made aware of this by checking
> path->dentry, which will either be a counted reference to a dentry, or
> an error pointer.
> 
> However the change to use start_creating()/end_creating() (which landed
> shortly before the dentry_create() change landed, though was likely
> developed around the same time) means that nfsd4_create_file() *needs* a
> valid dentry so that it can unlock the parent.
> 
> The net result is that if NFSD exports a filesystem which uses
> ->atomic_create, and if a call to ->atomic_create returns an error, then
> nfsd4_create_file() will pass an error pointer to end_creating()
> and the parent will not be unlocked.

Ugh, that's an unfortunate interaction.


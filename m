Return-Path: <linux-nfs+bounces-20537-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH3TKZ7FymnE/wUAu9opvQ
	(envelope-from <linux-nfs+bounces-20537-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 20:49:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A6035FF1D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 20:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41FAE301ABAF
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D74391826;
	Mon, 30 Mar 2026 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Efg8pyHy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA5377031
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896413; cv=none; b=NuAxo6FfLorZK2wznc9aS84nMddlz3bRH3NXyRoXaeqSPZLUyrTLsZJHjGf/5tXo+1jMnGXWqAMerYlMobzl9Lkgu7bofzU55FO5Q93Jv+12zlt3d0n+XJc8agn/g3wlgnI1D4OD1NlUOiXjYZEgZUeqH21bv68RRYsk1uBMMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896413; c=relaxed/simple;
	bh=ualoCU9xZiTW/5azMt6BlLYYx9lZyL0DJlQD7dTMZQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJYaPNKdVpecHQk5KWPLXAjOT4d2nrCl7H7AiDYYjCpsBa8epwKtBOzC9QSb+T4CTQ5QakV3NtwgW6isetY/9FKNdLxbT6SONgGrk4XPodnAV+K/Gk+3OfxATdAIRcr0SaY8PbRx8S4PONluUAX0W3D7ypeSmIJEkiHkSEJ939s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Efg8pyHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955BEC4CEF7;
	Mon, 30 Mar 2026 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774896412;
	bh=ualoCU9xZiTW/5azMt6BlLYYx9lZyL0DJlQD7dTMZQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Efg8pyHyrJjzKx1JfO65rRvEbi+18yDM2pSEcGbf24gbPEBmaRhUy4XOnAYpkJ1tz
	 UFccLxvgeQAykim1aqgaFAx98JjkJTseok25y3WOXh4/Fvsj5EfmGk/GdeH1l/QUEL
	 mIZj61Oqx0jfJoY3uzem3dRyZ79YmjJCv+k36jslxgD0kCdW2SCCe5bRdMLU0vStEj
	 nyUbYIoW5odE5ueAM9oo3CIeIS9yKl+MGes5wJ9y3naTNyQ4QhCLJlFtbmuwvwpLvu
	 IxfLWAM9Goe+RTwL4ArDOlfSFVkKs8xU4joSO25VzhPNEKyGZOPcjfLr7LX0zMAFX1
	 yzed1AqNRqeIw==
Date: Mon, 30 Mar 2026 14:46:51 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>,
	Cedric Blancher <cedric.blancher@gmail.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Increase default NFSv4 server size "max_block_size" to 4MB
Message-ID: <acrFG--e2CYhqw0b@kernel.org>
References: <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
 <88adbb3b-38da-4279-a4b8-db68551d6a8b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88adbb3b-38da-4279-a4b8-db68551d6a8b@app.fastmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20537-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 22A6035FF1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:51:23AM -0400, Anna Schumaker wrote:
> 
> 
> On Mon, Mar 16, 2026, at 8:39 AM, Chuck Lever wrote:
> > On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
> >> As debated a while ago, can the default NFSv4 server size for
> >> "max_block_size" be increased to 4MB, please?
> >
> > There is an administrative setting to raise this limit for
> > recent versions of the kernel. Can you report your experience
> > when you raise the limit? Hiccups, performance issues, etc? I
> > would kind of like this exercise to be data-driven.
> >
> > What is still unknown to me is which NFS client implementations
> > can support 4MB or 8MB. Without client support, an increase in
> > the default in NFSD doesn't mean anything. Rick, Anna, Roland?
> 
> The NFS client would need a code change to support >1MB sizes. I
> spent some time playing around with 4MB yesterday and it passed
> all my tests.

Is this something you'd be open to posting to the list?

Would be interested to see how 'git clone' improves with it.

Thanks,
Mike


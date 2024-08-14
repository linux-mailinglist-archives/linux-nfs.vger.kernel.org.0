Return-Path: <linux-nfs+bounces-5391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59CF952451
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 22:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5FB28BE08
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Aug 2024 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45281C7B66;
	Wed, 14 Aug 2024 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqWwRQIN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rIJLONRs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqWwRQIN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rIJLONRs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8632139CE3;
	Wed, 14 Aug 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668933; cv=none; b=fZWzVH9Di8P2OoDbwV0qxLGj+Q0p4gpk3AAm3IMA5qifRTwc6mwkDBLnbT/ZPCC4J3LLdC+TLt/I6PAlWFOCFHTE46j6mKcbIyLpsnVHmHDZk4fQxqgct/8rj9jNTkzZBSm+bVqW4iHNDslmcGF9xYsypDRaBZUS2PNsffjueQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668933; c=relaxed/simple;
	bh=v2IX03IhpCuH6MLem2g/w9nxBu0Dw9BexMpD2Pa9Nbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqD5PbMCCkGpJZ81w0NtFG0SyHN8sOx17TEI6IB91mlrpOrmTegQcCpxTn1z2Ub7BFA5ZnAkO0WAuU6WD9wzDuFah5tWRLNcWTAbUj7Lpmr06JtHjzjzg6TT3XWzzLvEEyYY+IXF7UMAaosV5bnvEQOZs4J1QdLLdgCIt+VhkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqWwRQIN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rIJLONRs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqWwRQIN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rIJLONRs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7E5522491;
	Wed, 14 Aug 2024 20:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723668929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAjON+M4IeNnOood1XuavEXjY8AwurJgpvp+EZZXZco=;
	b=yqWwRQINYL2+afUCxk95HWgkkIE/LcDZHZFke7nCFSiyGW7cGrcgw/SGw24WQ4WKpcJnhy
	5g1ZXwhZLdb7Ewxi/OmneCaTSA80SQIJHL+aOuwuuXWaI+ft0uIK5gBvAf8nqxXwuo5xzO
	s7hlO6PIrtP42Hrs5TJVPaNJNhJuWA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723668929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAjON+M4IeNnOood1XuavEXjY8AwurJgpvp+EZZXZco=;
	b=rIJLONRsh0V6mMbzTbgadksDWdvGbj3aZW2qkkP8TwYELkvOSS8kZ0Vzz+xnXiA/g9L41M
	R5E5OXPPe0rJIWBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723668929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAjON+M4IeNnOood1XuavEXjY8AwurJgpvp+EZZXZco=;
	b=yqWwRQINYL2+afUCxk95HWgkkIE/LcDZHZFke7nCFSiyGW7cGrcgw/SGw24WQ4WKpcJnhy
	5g1ZXwhZLdb7Ewxi/OmneCaTSA80SQIJHL+aOuwuuXWaI+ft0uIK5gBvAf8nqxXwuo5xzO
	s7hlO6PIrtP42Hrs5TJVPaNJNhJuWA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723668929;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAjON+M4IeNnOood1XuavEXjY8AwurJgpvp+EZZXZco=;
	b=rIJLONRsh0V6mMbzTbgadksDWdvGbj3aZW2qkkP8TwYELkvOSS8kZ0Vzz+xnXiA/g9L41M
	R5E5OXPPe0rJIWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC476139B9;
	Wed, 14 Aug 2024 20:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yRkRNMAZvWa1RwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 20:55:28 +0000
Date: Wed, 14 Aug 2024 22:55:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>, Greg KH <greg@kroah.com>,
	Sherry Yang <sherry.yang@oracle.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Avinesh Kumar <akumar@suse.de>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
Message-ID: <20240814205519.GA550121@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <>
 <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
 <172078283934.15471.13377048166707693692@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172078283934.15471.13377048166707693692@noble.neil.brown.name>
X-Spam-Score: -3.50
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 

> On Fri, 12 Jul 2024, Jeff Layton wrote:
> > On Fri, 2024-07-12 at 16:12 +1000, NeilBrown wrote:

> > > My point is that if we are going to change the kernel to accommodate LTP
> > > at all, we should accommodate LTP as it is today.  If we are going to
> > > change LTP to accommodate the kernel, then it should accommodate the
> > > kernel as it is today.


> > The problem is that there is no way for userland tell the difference
> > between the older and newer behavior. That was what I was suggesting we
> > add.

> To make sure I wasn't talking through my hat, I had a look at the ltp
> code.

> The test in question simply tests that the count of RPC calls increases.

> It can get the count of RPC calls in one of 2 ways :
>  1/ "lhost" - look directly in /proc/net/rpc/{nfs,nfsd}
>  2/ "rhost" - ssh to the server and look in that file.

FYI "rhost" in LTP can be either using namespaces (Single Host Configuration [1]),
which is run by default, or SSH based (Two Host Configuration [2]). IMHO most of
the testers (including myself run tests simply via network namespaces).

NOTE: I suppose CONFIG_NAMESPACES=y is a must for 'ip netns' to be working, thus
tests would hopefully failed early on kernel having that disabled.

> The current test to "fix" this for kernels -ge "6.9" is to force the use
> of "rhost".

> I'm guessing that always using "rhost" for the nfsd stats would always
> work.

FYI this old commit [3] allowed these tests to be working in network namespaces.
It reads for network namespaces both /proc/net/rpc/{nfs,nfsd} from non-namespace
("lhost").  This is the subject of the change in 6.9, which now fails.
And for SSH based we obviously look on "rhost" already.

> But if not, the code could get both the local and remote nfsd stats, and
> check that at least one of them increases (and neither decrease).

This sounds reasonable, thanks for a hint. I'll just look for client RPC calls
(/proc/net/rpc/nfs) in both non-namespace and namespace. The only think is that
we effectively give up checking where it should be (if it for whatever reason in
the future changes again, we miss that). I'm not sure if this would be treated
the same as the current situation (Josef Bacik had obvious reasons for this to
be working).

@Josef @NFS maintainers: WDYT?

Kind regards,
Petr

> So ltp doesn't need to know which kernel is being used - it can be
> written to work safely on either.

> NeilBrown

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/network#single-host-configuration
[2] https://github.com/linux-test-project/ltp/tree/master/testcases/network#two-host-configuration
[3] https://github.com/linux-test-project/ltp/commit/40958772f11d90e4b5052e7e772a3837d285cf89

> > To be clear, I hold this opinion loosely. If the consensus is that we
> > need to revert things then so be it. I just don't see the value of
> > doing that in this particular situation.
> > -- 
> > Jeff Layton <jlayton@kernel.org>




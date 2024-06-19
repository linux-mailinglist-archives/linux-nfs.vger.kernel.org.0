Return-Path: <linux-nfs+bounces-4086-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C5290F5D2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1C91F23D27
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D5156673;
	Wed, 19 Jun 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1b2+JBk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51C1CAA2
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820831; cv=none; b=en22LjlrzcVd6aJuIfZ9dAAmstEhIgM+vdsG3fjSQaBLI7KhVSQ8aEzbR8fB0DfnwHy2XAZpDnuzYzr6/Mvz5JJEWJPkm89nUQO3rCzt7fpZsYcQ/5ghnA8D0No7r8RBRCcQMnVr1viquVSafpL6QO2r5jOUgcmJpHE8RmN7v8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820831; c=relaxed/simple;
	bh=EYULiGI6oIpUO4RP7xvsZjNzRmQev8LdmlgU480hLMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOr3s019HTo/nQpFyItLmIUIXSxWS4buxxW0UiLSVB6uxBf8MHR+x2DiCRFhlnGJNwnPki1sRMixag3qgmKHSm/S5mN7lQlgzHGyJHdkmsTrzx5wT7aaXNaXjQcaWgTueRGI8wRAWEhsDtu7O4tfwy22ZFl7UpVk3wkFKFIgn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1b2+JBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A7EC2BBFC;
	Wed, 19 Jun 2024 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718820831;
	bh=EYULiGI6oIpUO4RP7xvsZjNzRmQev8LdmlgU480hLMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1b2+JBkkN7R4lsUKMcYY5TfcwEKmRAOCrpe5NI+9elgUQl33r1fWMEayk1uVEbRY
	 QKxZwj1mSY1UU5eQ1fJz5KnhN9KwFtYK+4B3LobC3L9dhL8ErK8KMrDZcHqCYetmS/
	 Qb6N0Wprz3CRKzO/Gb5DXGqwYJz3iXjVtpGl0fpX4/9juAST9Tb5jkPbAKmZk6MONv
	 Nsaw6p5eutOYvuhlY1HBqQLLDHK6OU6B+8wDdNa0m+6cKnzt0XxrG1DvcWM5dEcF/e
	 4FBuWkznRZ3bn+uRMo01nd0L4Y6KLzJxmN1BjjM0i2JAIR7WDdhkrktOidt5LTArGr
	 c5A2fnb9Xmqmw==
Date: Wed, 19 Jun 2024 14:13:49 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"snitzer@hammerspace.com" <snitzer@hammerspace.com>
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Message-ID: <ZnMf3dtGkAHfuFJe@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <ZnJxTsUuAkenmvWP@infradead.org>
 <171878101003.14261.1089014272023335768@noble.neil.brown.name>
 <ZnMb7NxuXnIikSQK@kernel.org>
 <D1A3A43F-757A-43D6-BB71-AFAF2E17C060@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1A3A43F-757A-43D6-BB71-AFAF2E17C060@oracle.com>

On Wed, Jun 19, 2024 at 06:04:46PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 19, 2024, at 1:57 PM, Mike Snitzer <snitzer@kernel.org> wrote:
> > 
> > On Wed, Jun 19, 2024 at 05:10:10PM +1000, NeilBrown wrote:
> >> On Wed, 19 Jun 2024, Christoph Hellwig wrote:
> >>> What happened to the requirement that all protocol extensions added
> >>> to Linux need to be standardized in IETF RFCs?
> >>> 
> >>> 
> >> 
> >> Is that requirement documented somewhere?  Not that I doubt it, but it
> >> would be nice to know where it is explicit.  I couldn't quickly find
> >> anything in Documentation/
> >> 
> >> Can we get by without the LOCALIO protocol?
> >> 
> >> For NFSv4.1 we could use the server_owner4 returned by EXCHANGE_ID.  It
> >> is explicitly documented as being usable to determine if two servers are
> >> the same.
> > 
> > My first approach was to (ab)use EXCHANGE_ID. It worked, but it
> > required exporting a symbol to query the hash table local to
> > nfs4state, etc.  It wasn't very clean.. could it have been made
> > clean?: I guess... but in the end I elected to solve both v3 and v4.x in
> > the same way using LOCALIO protocol.
> > 
> >> For NFSv4.0 ... I don't think we should encourage that to be used.
> >> 
> >> For NFSv3 it is harder.  I'm not as ready to deprecate it as I am for
> >> 4.0.  There is nothing in NFSv3 or MOUNT or NLM that is comparable to
> >> server_owner4.  If krb5 was used there would probably be a server
> >> identity in there that could be used.
> >> I think the server could theoretically return an AUTH_SYS verifier in
> >> each RPC reply and that could be used to identify the server.  I'm not
> >> sure that is a good idea though.
> >> 
> >> Going through the IETF process for something that is entirely private to
> >> Linux seems a bit more than should be necessary..
> > 
> > I have to believe Christoph didn't appreciate this LOCALIO protocol is
> > an entirely private implementation detail to Linux (that allows client
> > and server handshake).  I've clarified that in Documentation (for v6).
> 
> Even though this is a private protocol, you don't want some
> other NFS implementation re-using that RPC program number
> for its own purposes.
> 
> I think registering the RPC program number and name with
> IANA is going to save everyone some potential headaches
> and won't be an arduous process.

I fully agree, I will work on it. If you have hints for the best place
to start I'd welcome any help getting the process started.

In v6 I switch to using rpc program number 0x20000002 


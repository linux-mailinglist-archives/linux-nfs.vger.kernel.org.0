Return-Path: <linux-nfs+bounces-4083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768590F590
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA11C20CB6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BD155C98;
	Wed, 19 Jun 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVS9LVEp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9255884
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819821; cv=none; b=O6hAYvUqaaKCNXQSNdH4t4N7NyHifN5GHk4fsF9bi6k5yWXkvsQFshNlrZ6f8Zz0nHqKHurFQ6XJGGTQ7TQZkcPHbLKHx88/A24jvwh01cmHL3cldri9so4reJoDZJsqOhfmqGwMzGox81Lwcelstzzq3bMJUTB4/C9lecI4P+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819821; c=relaxed/simple;
	bh=LBOSjeEeAboxL++C6U9vo35wZQelzxlYseBkNQHm5Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTKWHH4Eh6iENd4P9fa0To/PAXEQdb8K1Zkpay5C3cXETc1/zXhNk00w4cv+AVI3cRTacGpK6/B+TqW1N+GTOrJcIsMAS1yCee1KT8Q/t8ulFXE6N1VSc9FFhkmADmgWQ63oyEcdfiYdOqtSyHriKOSpfu1Io0ePBRKfSVnRfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVS9LVEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DD3C2BBFC;
	Wed, 19 Jun 2024 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718819821;
	bh=LBOSjeEeAboxL++C6U9vo35wZQelzxlYseBkNQHm5Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVS9LVEp9PdaiLBV3XR5FRRlzlHcZP6zDzzjTZD0XeuR6LYrAQLrJdh0Kf3Tq72VF
	 Ec/Sby6gbx++Ga1/Qiy5r3X5l1mks9dfCASGWMfJjmlFGKop6CrucaK46p4V6RKPCn
	 4HHPfjSTJDro+B8raXBmwCZYUuxbdxfCjkiru8SkocaF/SiNndUYyyFCn69Z4WtTT8
	 NepZG8o1JGPn7uRD0buiT85i8tk4y48KqySbiq/sm2F7g4c4NVcaaCO3a52Qt3J2cu
	 NDGa8Uo6Eq56wtT2mv1Sbnq6ACBVINLqScf9Awx3h2jU5lVChil7yg4gAoZOEzEXD6
	 gOemOlj3vXq6g==
Date: Wed, 19 Jun 2024 13:57:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v5 00/19] nfs/nfsd: add support for localio
Message-ID: <ZnMb7NxuXnIikSQK@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
 <ZnJxTsUuAkenmvWP@infradead.org>
 <171878101003.14261.1089014272023335768@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171878101003.14261.1089014272023335768@noble.neil.brown.name>

On Wed, Jun 19, 2024 at 05:10:10PM +1000, NeilBrown wrote:
> On Wed, 19 Jun 2024, Christoph Hellwig wrote:
> > What happened to the requirement that all protocol extensions added
> > to Linux need to be standardized in IETF RFCs?
> > 
> > 
> 
> Is that requirement documented somewhere?  Not that I doubt it, but it
> would be nice to know where it is explicit.  I couldn't quickly find
> anything in Documentation/
> 
> Can we get by without the LOCALIO protocol?
> 
> For NFSv4.1 we could use the server_owner4 returned by EXCHANGE_ID.  It
> is explicitly documented as being usable to determine if two servers are
> the same.

My first approach was to (ab)use EXCHANGE_ID. It worked, but it
required exporting a symbol to query the hash table local to
nfs4state, etc.  It wasn't very clean.. could it have been made
clean?: I guess... but in the end I elected to solve both v3 and v4.x in
the same way using LOCALIO protocol.

> For NFSv4.0 ... I don't think we should encourage that to be used.
> 
> For NFSv3 it is harder.  I'm not as ready to deprecate it as I am for
> 4.0.  There is nothing in NFSv3 or MOUNT or NLM that is comparable to
> server_owner4.  If krb5 was used there would probably be a server
> identity in there that could be used.
> I think the server could theoretically return an AUTH_SYS verifier in
> each RPC reply and that could be used to identify the server.  I'm not
> sure that is a good idea though.
> 
> Going through the IETF process for something that is entirely private to
> Linux seems a bit more than should be necessary..

I have to believe Christoph didn't appreciate this LOCALIO protocol is
an entirely private implementation detail to Linux (that allows client
and server handshake).  I've clarified that in Documentation (for v6).

Mike


Return-Path: <linux-nfs+bounces-11762-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F620AB9573
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 07:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854D33BA1E1
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 05:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F60190462;
	Fri, 16 May 2025 05:17:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9A481C4;
	Fri, 16 May 2025 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747372678; cv=none; b=dzX+g2n8O4Cj23Lqpck9bK18gor8UDYgC/fEzyVBWhJI6Or7V3DL5CSWLA0qiFAUh3FvjWokX/eu5s+A7HRxt1SLUMYtD4/F6sJPv8CTR2FV8yCrIIaQ1g14vkXuOR+X/TpS86gniV66ZUF7qIyYiCS1TffLPqRp2kqhYqBeZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747372678; c=relaxed/simple;
	bh=cpd0/pJh5sUWAGsCtT9PLuj1QUMfVHesnVngUzB8pLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEeHNVKMCx4IteiXGi9ATDroLgeszJ0uionqjLeNedxINsd5h0Q3B+3H5MD/rBt3wNTEpqZvkdjoriaeFJ+EbyLhjWlRI8dXlo9YxsX+ahEShfucoLJQNgDvWOlXCsBzbo8ano1c3xZ+i1cjKa8DNyDA+CrNba5J4qqZCPCHdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0DE1A68AA6; Fri, 16 May 2025 07:17:53 +0200 (CEST)
Date: Fri, 16 May 2025 07:17:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
Message-ID: <20250516051752.GB13495@lst.de>
References: <20250515115107.33052-1-hch@lst.de> <20250515115107.33052-2-hch@lst.de> <aCXjaDas4aJkoS7-@kernel.org> <cd2444ca-3d92-4c4e-a93c-ed2bfc4d18d5@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2444ca-3d92-4c4e-a93c-ed2bfc4d18d5@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 15, 2025 at 04:46:43PM +0200, Hannes Reinecke wrote:
> With this patch the keyring is pretty much immaterial; the interface
> is passing in a serial number which is unique across all keyrings.
> Where the keyring comes in when looking up keys on the TLS server,
> as there the TLS client hello only transports the key description
> (which are not required to be unique across all keyrings).
> So there we'll need the keyring to be specified.
> But for the client we really don't.

Yes.  Patch 1 on it's own actually works fine-ish.  The big difference
is that the keys would have to be made user-readable as without the
keyring, tlshd would not be the possesor of the key.



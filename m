Return-Path: <linux-nfs+bounces-11781-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C76ABA171
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDD2188E7AE
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AD025A2C5;
	Fri, 16 May 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqkH5Xot"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F3259CBD;
	Fri, 16 May 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414866; cv=none; b=C1xvwuJhSPg9R5Pnzn6iM/TA0h7OI4oikB1WjXbZXjsQWFf0lWol16WRHs9nOJmN9BRw83xFTUktusEKqh48oO9pMaFQbaoS+DxjBcrmOwi2IE6HfVMkkMuyogKqv8RQp66lhYmPPFqAct8gd8g5hXXlcdRBYpomszEeRk0didQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414866; c=relaxed/simple;
	bh=8Wdcw89gCS8xamushy5PFAMxsBaTvuYpeNAksJu6LJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLlYEs8Nz6NXUMczk3Mv14pTHjUWoFyQq0x5QoONLUwDcfEMiY+HjgROiRFJ+6i0M/XLlYmm5S9ZWe4xFkHzli0I8+L/JvtH1CqpSKuxClTVBu04BWKShaUVnDjr/lIqzAyjQt7ACXiXClUYdUZzGqfy6mNvlWfsfXnI97IAYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqkH5Xot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32259C4CEE4;
	Fri, 16 May 2025 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747414865;
	bh=8Wdcw89gCS8xamushy5PFAMxsBaTvuYpeNAksJu6LJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqkH5Xot/Em6lwN13NVRmXgOHpRjMZ9OQ0K1yIZzBJcxZllsT9UWDfkGgE7iJjW5/
	 dt+oKR5XxYuCDNX8NX0537zkaAaBxI7M7A9T5CnJi+3WSGNnehl5pjZ3uBbLU4vPid
	 IgYuaB+4U3jubhvDTfOM5kz2TfYWMoDvb8GS+oOYTApOLXNtZkZV8VGObiRms0tXit
	 rglFcIIhDHpPKQMX9+JSQfrD7rN7XkR4b5lOqvv+8MtTIdZXA5Pvu0TsG3g7YK0n3z
	 UEnxihrgO0CP2/Q3TAo9IGyDakhYOhO+Z4hYX5rUONCMjNi24KQgd61ensP0edbBTR
	 8friivyRgygPw==
Date: Fri, 16 May 2025 20:01:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
Message-ID: <aCdvTUCNVV7lYJh9@kernel.org>
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-2-hch@lst.de>
 <aCXjaDas4aJkoS7-@kernel.org>
 <cd2444ca-3d92-4c4e-a93c-ed2bfc4d18d5@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd2444ca-3d92-4c4e-a93c-ed2bfc4d18d5@suse.de>

On Thu, May 15, 2025 at 04:46:43PM +0200, Hannes Reinecke wrote:
> > This is equivalent nvme_tls_key_lookup() so would it be more senseful
> > to call it nfs_tls_key_lookup()? I'm also a bit puzzled how the code
> > will associate nfs_keyring to all this (e.g., with keyring_search as
> > done in nvme_tls_psk_lookup())?
> > 
> With this patch the keyring is pretty much immaterial; the interface
> is passing in a serial number which is unique across all keyrings.
> Where the keyring comes in when looking up keys on the TLS server,
> as there the TLS client hello only transports the key description
> (which are not required to be unique across all keyrings).
> So there we'll need the keyring to be specified.
> But for the client we really don't.

I did not see anything that would depend on having 2/2 at all, or
it getting populated.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

BR, Jarkko


Return-Path: <linux-nfs+bounces-12118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A9ACE8F9
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 06:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652513AA2CE
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jun 2025 04:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42A13AD1C;
	Thu,  5 Jun 2025 04:28:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8314F90;
	Thu,  5 Jun 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749097696; cv=none; b=JL/zYqrNdewHrHqgyWZBI6akbUj+67szPLQ3oy0OJrzMoYAn+g5D7ej9rcdLpmElmI1lPUuyo5xuNpnL/QSZQPdjIQ2orn2QYBIXWJ4WvOYRK1UyvWLDG9TAbCUWxAIPR6cL3ad8RwiZHZIT/eRgEzJJAla1y+lw6hVkeJdDbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749097696; c=relaxed/simple;
	bh=rw7BQEsfWstFCbv+P3B5Q8fzv//XASa7jRNHdWNpfp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAwUz8/0QZOsG+0JdJiLPMUvHi4+n9UgF0Xcjsy1+VAS6ZtLtqF1KBei3kWTZX7kmvjUNblXv2f98mwSlgcouedGKiqEhXik2Gm4lDdvWpzAys+qEoDM8DuRioHFTkPTj9lXUeDpVKvENu8RGBZCLVx2YROiBwsBWc4MyAp/a0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 44A4E68AA6; Thu,  5 Jun 2025 06:28:03 +0200 (CEST)
Date: Thu, 5 Jun 2025 06:28:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <20250605042802.GA834@lst.de>
References: <20250515115107.33052-1-hch@lst.de> <20250515115107.33052-3-hch@lst.de> <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me> <aCdv56ZcYEINRR0N@kernel.org> <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me> <20250602152525.GA27651@lst.de> <aEB3jDb3EK2CWqNi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEB3jDb3EK2CWqNi@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 04, 2025 at 07:42:52PM +0300, Jarkko Sakkinen wrote:
> OK, I put this in simple terms, so perhaps I learn something from
> nvme and nfs code:
> 
> 1. The code change itself, if this keyring is needed, it looks
>    reasonable.
> 2. However, I don't see any callers within the scope of patch set
>    for this keyring.
> 
> I could quite quickly grab the idea how NVME uses nvme_keyring in TLS
> handshake code from drivers/nvme/target/{configfs.c,tcp.c}. I guess
> similar idea will be used in nfs code but I don't see any use for it
> in the patch set.
> 
> Thus, it is hard to grasp the idea of having this patch applied without
> any supplemental patch set.

Maybe I'm missing something.  The reason I added the keyring was that
without it, tlshd is not the possesor of the keys and can't read them.

I guess you refer to the fact that nvme_tls_psk_lookup does a
keyring_search and nothing in the NFS code does?  nvme_tls_psk_lookup is
only used for the default key based on the server side identification in
NVMe, a concept that doesn't exist in NFS.  But the fact that the keys
aren't otherwise readable exists for both nvme and NFS.



Return-Path: <linux-nfs+bounces-14954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A341ABB666C
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 11:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C28319E0F7C
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611392DEA93;
	Fri,  3 Oct 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcXqUEWf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C275288522;
	Fri,  3 Oct 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759485094; cv=none; b=LyXaixXfU64TxBF9Ph04hWUooBOt8BX1t5T61ZGwFSOkbjM74NwHwSf7O4LrY9cwVaG+WiB75sBD6PC4Li0z6E6pb0AbMrmEwSUlf+pTOoPm8aMLky5urTn32VMYbMQKESDFmqyD4T1DvdvL+qB5xHs5dad9hQXnT7DThAb/164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759485094; c=relaxed/simple;
	bh=WfLYqcOX9sMYZKj4wlYxcoZbm5OgeeZwYCvrlL3mENw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qonRAoApFmb1kmz1InECAcvCE/tXrIUDP0SBcSysG4SK0iACRVJCC5jU1Og8Kg223VXEcBixbGqQud6Rl3dUYf3lxkqQ/6MJmmFV2uM7u14BpP+Ar2F8mgrbj01rIchn0uQwwg5LIqPvXqA8Pxb9et6w4Pn6Acpb9sKUZmx/Gg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcXqUEWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0531CC4CEF9;
	Fri,  3 Oct 2025 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759485094;
	bh=WfLYqcOX9sMYZKj4wlYxcoZbm5OgeeZwYCvrlL3mENw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcXqUEWfJ0IiMLVaZtd6pUxE4O/0uoOsxh3H211dEstLJpAFvkOtBNIpUxteL2aI1
	 8AaH40SjPRGeNBKJEoRDFxa8iKd/gVFAiPe9Fby25bUYuqEJ8eeSgs4ekHkdeMGbws
	 KXt1pkuppx59pH0cKSFfbeOV3YqAPZ0jS0avN2iNwP6qmCnpGAjmaR6aiWs/3KjoOR
	 WxtkgzG7XpVSyn2YdqNWPyZKzJPQH9ZyBtZ6OgAGI1SgoXlxEQ6ucGlC+G8Arstk2x
	 YHifqR7C4foIwGfJw8FjId0SRo+NWovjyeVk9BwLUMz93dNUwBcFuqkRfkw48gpU/7
	 wOaS8NN/1l0tQ==
Date: Fri, 3 Oct 2025 10:51:28 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 2/8] net/handshake: Define handshake_sk_destruct_req
Message-ID: <20251003095128.GG2878334@horms.kernel.org>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003043140.1341958-3-alistair.francis@wdc.com>

On Fri, Oct 03, 2025 at 02:31:33PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Define a `handshake_sk_destruct_req()` function to allow the destruction
> of the handshake req.
> 
> This is required to avoid hash conflicts when handshake_req_hash_add()
> is called as part of submitting the KeyUpdate request.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>  - New patch

Hi Alistair,

This is a not a proper review: I'll leave that to others.
But I notice that both Clang 21.1.1 and GCC 15.2.0, when run with
-Wunused-function, flag handshake_sk_descruct_req() as unused.
Which is the case until the following patch.

As both this and the following patch are small, and touch the same file,
I'm wondering if a simple approach is to squash the two patches into one.

Or perhaps no one cares. If so, sorry for the noise.

...


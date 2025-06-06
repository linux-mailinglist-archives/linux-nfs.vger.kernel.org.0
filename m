Return-Path: <linux-nfs+bounces-12177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6B9AD06F6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 18:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1617A8F90
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21BB288CB4;
	Fri,  6 Jun 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inOeMvNB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F019F12A;
	Fri,  6 Jun 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228481; cv=none; b=GUwUYQBGjZ/CWlU5ZxCj7MLXPck8B6ufacGKYSz6lWqGt/qFFjOtrLdufUYgHymcb3vPHyI1ZSh3Q+ZCzTd8vtCxTek4aFPIA2C2uiabMluJsEoPNIpnNFrOjOWbk05/ZMonzli8+DodBTp0nf6QatP7pIjGV+CTAn1Mtbj1Q10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228481; c=relaxed/simple;
	bh=p8tS0XdkmAXrdGHWz6cHq5xlxMNiFfXisvyz6/JfLjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNpBcqojle8yt3GX/mCaqvXUWyRxHo8f6jxxCcvn4WqjJBSkTfbf+MYM6lW7jHIjfjsbIhE2P39w4FvO7wX1b6vbNTJ2MFRqpDg+ogwiZOmSYJ+KG1R0uy8l0kqs0+jXxp678EGk1Yp371sFTHXk9sBy7RuJV8hZ9Cyz7aWkyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inOeMvNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA213C4CEEB;
	Fri,  6 Jun 2025 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749228481;
	bh=p8tS0XdkmAXrdGHWz6cHq5xlxMNiFfXisvyz6/JfLjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inOeMvNB1tF6c15fe96FJfWDiplB2X9wI9+/Sd+LvGD4cR85mSe0j6w4PK9ytEITW
	 csqZo+RnGIhzOx1C7ytA9cW/ZGemF5n10Wv+naKOhpNbbEDlBfS5HiDjmLWo+K9leV
	 j8VTo9v1wSsJIZqlWFdcGx6Sius4ceM5bk8W51DG9CYrdg3pbuBO+nQ9Vlir3fTHxr
	 W3GaG7Zj1raBsmpZr284zLnhB64rZFemy8WV+x7SWokzykwErB/qpBM6XUGK/YbvB8
	 i+MfhC6zZvLCXfVLNRmsyK2YGRVnVLgVC1dKxgjDACP1h6bevNBTcOX+ZL84dkIwx9
	 LjJgc/OyFJ/ow==
Date: Fri, 6 Jun 2025 19:47:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 2/2] nfs: create a kernel keyring
Message-ID: <aEMbvQ7EekwPHQ8c@kernel.org>
References: <20250515115107.33052-1-hch@lst.de>
 <20250515115107.33052-3-hch@lst.de>
 <c2044daa-c68e-43bf-8c28-6ce5f5a5c129@grimberg.me>
 <aCdv56ZcYEINRR0N@kernel.org>
 <692256f1-9179-4c19-ba17-39422c9bad69@grimberg.me>
 <20250602152525.GA27651@lst.de>
 <aEB3jDb3EK2CWqNi@kernel.org>
 <20250605042802.GA834@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605042802.GA834@lst.de>

On Thu, Jun 05, 2025 at 06:28:02AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 04, 2025 at 07:42:52PM +0300, Jarkko Sakkinen wrote:
> > OK, I put this in simple terms, so perhaps I learn something from
> > nvme and nfs code:
> > 
> > 1. The code change itself, if this keyring is needed, it looks
> >    reasonable.
> > 2. However, I don't see any callers within the scope of patch set
> >    for this keyring.
> > 
> > I could quite quickly grab the idea how NVME uses nvme_keyring in TLS
> > handshake code from drivers/nvme/target/{configfs.c,tcp.c}. I guess
> > similar idea will be used in nfs code but I don't see any use for it
> > in the patch set.
> > 
> > Thus, it is hard to grasp the idea of having this patch applied without
> > any supplemental patch set.
> 
> Maybe I'm missing something.  The reason I added the keyring was that
> without it, tlshd is not the possesor of the keys and can't read them.
> 
> I guess you refer to the fact that nvme_tls_psk_lookup does a
> keyring_search and nothing in the NFS code does?  nvme_tls_psk_lookup is
> only used for the default key based on the server side identification in
> NVMe, a concept that doesn't exist in NFS.  But the fact that the keys
> aren't otherwise readable exists for both nvme and NFS.

Ah, ok this cleared it up, thanks! Just learning these subsystem,
appreciate the patience with this one :-)

BR, Jarkko


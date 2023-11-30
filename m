Return-Path: <linux-nfs+bounces-182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A87FE4D4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 01:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB75282307
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 00:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43CF386;
	Thu, 30 Nov 2023 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsjndXiy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0A79C7;
	Thu, 30 Nov 2023 00:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6824C433C9;
	Thu, 30 Nov 2023 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701304322;
	bh=TolSuksUmy70PAxyUR3VC0RS2UTzcZi0sMUNnCF3mII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsjndXiyNAFfpcLkGuJZAWYqIziV5wfajNU2wXHmYNlRdeq1xnzu6vODR1cu9RsUL
	 4iTMYqEI1y9RMGfC+pO1cZ+lHnJ9JMFeOIoP0KUjuhAZF5rIa3uNL4exGFzVlW8Sts
	 XVmsDqbi4KJFh8ZMDAFFDHGbFxtGHrL/SAQN8kH2+A5x165gFTjFtLe0JBoNzhARsb
	 7/cjIEe29B4HgugJ7S3CAdqJzGpWFH8suZ5ul7aEb7ZuiOWtgdwskUveNjAqm8E0yD
	 /qM7J+Ziz5eV92ENOr4ScJxkRaNKBeB4U0D6en7SWSTA8YyGaCsxwajqB4FNumbkCj
	 t9RfN8iM/MjMA==
Date: Wed, 29 Nov 2023 16:32:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
 netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/3] NFSD: convert write_threads to netlink command
Message-ID: <20231129163200.77c7e788@kernel.org>
In-Reply-To: <ZWeDdSVWcrUxSU7L@tissot.1015granger.net>
References: <cover.1701277475.git.lorenzo@kernel.org>
	<d9461e660b5f47df7b869f0f809485c9b4bf60ea.1701277475.git.lorenzo@kernel.org>
	<ffbbdd1ce7c87b02f75095f0146924d996268957.camel@kernel.org>
	<ZWeDdSVWcrUxSU7L@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 13:31:17 -0500 Chuck Lever wrote:
> Before applying these, I'd like an Acked-by from Jakub for the
> tools/net/ynl modifications, and at least a fresh sanity check from
> Jakub on the changes to the nfsd netlink protocol (though I don't
> anything problematic so far).

I left a couple of suggestions, looks good overall.


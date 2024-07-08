Return-Path: <linux-nfs+bounces-4705-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676FA929EAE
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245CB280E8E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D184AEF7;
	Mon,  8 Jul 2024 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8YNNCtw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E5AD31;
	Mon,  8 Jul 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429811; cv=none; b=XG3fHRI7hU/V9hlY98lN3lR/SpYDjHcdcJrPTuj1gOVCbVpEsa2oimmEQinAjBKBlkb1FGDNe8Tl604V5mNcFIgpncp0l3P7deiKj8h3JheuBY7wJ44OcGRNfw52WAenLMv46cDHy6BXI5ZRztF4utpDP2qWpQP3dTWo6xtwoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429811; c=relaxed/simple;
	bh=mFEaZO2tWCG+ts/iG47KVGdxRadCEAG/yYrMVUas+30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqoQxffiYCg/Re6NeomZruUg975ekiSsuBE9p6CentTcyFGuhemMLtIywttUdO6oefF21o5XStsjV227y4aDeGUPgN/1uWlwar8KWPBpjkLQC7zEPXpuvajD1bhq2HClZuubxqVC4cyKlw22iAC2AHl4LgnqpiWnDhElFaZ447k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8YNNCtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67364C116B1;
	Mon,  8 Jul 2024 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720429809;
	bh=mFEaZO2tWCG+ts/iG47KVGdxRadCEAG/yYrMVUas+30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8YNNCtw5weviFhEveXgi4zTidAL7QXJs/gcscrmBVygtXEiaTSW045TRKcNapWGY
	 SlabD/AOTeKGf/XmG8piIBv9oC01yOPr+EdQdfYS47ZhdWDhAsGJAbro5bqryBlkiU
	 aOxBSZPcT6qLhctKxMtx/AwdFvNIc1ZqdXH4v3kPy3hDFmJGWuqP8mmTWVK8tW6yLc
	 ERfUrw5q5E+oZPMdGtXP4HFvVEarFdZw0axJhKwvp5rLZl0icB13+40ZI8f7YJoY0c
	 0jYRv7CCRv77aq5k/OZ1Ieq6jMMizNMab0vM3fL2WOuh5R8OI6ZPCntUlVxRrtaY6E
	 G45DSSH0wpHsg==
Date: Mon, 8 Jul 2024 10:10:04 +0100
From: Simon Horman <horms@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
	Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	steved@redhat.com, kwc@citi.umich.edu, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH -next] gss_krb5: Fix the error handling path for
 crypto_sync_skcipher_setkey
Message-ID: <20240708091004.GH1481495@kernel.org>
References: <20240706065008.451441-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706065008.451441-1-cuigaosheng1@huawei.com>

On Sat, Jul 06, 2024 at 02:50:08PM +0800, Gaosheng Cui wrote:
> If we fail to call crypto_sync_skcipher_setkey, we should free the
> memory allocation for cipher, replace err_return with err_free_cipher
> to free the memory of cipher.
> 
> Fixes: 4891f2d008e4 ("gss_krb5: import functionality to derive keys into the kernel")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>



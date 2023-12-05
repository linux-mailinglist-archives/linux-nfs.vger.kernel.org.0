Return-Path: <linux-nfs+bounces-342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C71805F7B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 21:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A211F2172D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Dec 2023 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994668B8A;
	Tue,  5 Dec 2023 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE20jbLb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452EA3D98C;
	Tue,  5 Dec 2023 20:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D0C433C8;
	Tue,  5 Dec 2023 20:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701808397;
	bh=ct9NsTNEDirO8IhjablbfPQ/GBvefxGEDEkJ9VZbwD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VE20jbLbAdpt1MC4bCEJdWA8Q5jrShzmQ+rAobBQIwZtv7+CCA//LFaw4pmN6Uzo6
	 pQXCosWg0Ghx5lfSFoqGd3fjbSt4k8UgDxF+LdJ4MG0+hJWY5sgSMC9wRK4KigBUr+
	 kleyc3JCu8ACQD3hSgNcZ4UguuMu6A+66vG+iAmK4GMJsirSrrlILoNLNqCWWffT0x
	 jSW8nePOcRt/jde0bpqKC9t2C56YcoKJAuz5wVJKRTL/8hFSlpBnqFgQWCRiWPHTSd
	 uYk6sDXoC4uxxIUf6n3atvMy7bdJujK51WRYGFQQvRyJ5w0j8M3zrBGjGIcVhAqCjG
	 2uECMLppd5cQQ==
Date: Tue, 5 Dec 2023 20:33:12 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
	netdev@vger.kernel.org, jlayton@kernel.org, kuba@kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Message-ID: <20231205203312.GV50400@kernel.org>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>

On Wed, Nov 29, 2023 at 06:12:44PM +0100, Lorenzo Bianconi wrote:
> Introduce write_version netlink command similar to the ones available
> through the procfs.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> +/**
> + * nfsd_nl_version_get_doit - Handle verion_get dumpit

Hi Lorenzo,

a minor nit: this function is nfsd_nl_version_get_dumpit

> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,

...


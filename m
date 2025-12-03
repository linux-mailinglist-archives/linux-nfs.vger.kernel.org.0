Return-Path: <linux-nfs+bounces-16869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD118C9F537
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 15:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 52A8230000B6
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7922FFDF4;
	Wed,  3 Dec 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ/lBq2p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082F2FF15A;
	Wed,  3 Dec 2025 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772881; cv=none; b=IeTMrcH85KKedWk/+1gzxL9pU0GUuvESfTUwW1rAE6o9/0KlwjnuGdK7JqCWyVl/x7F7JxCVxOkb2tcXw+3xz3ZfJUMYGbIGb78ZgQNJFDf+4uxCN/KnDAeJM0aU1WD1k9pJYH8UogN8k27j3jEBoq/SqIPJ2jssKTWHstf6w7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772881; c=relaxed/simple;
	bh=394n7gwiwxM2C8tCdb/2LUSTj5/iwWPEBNhZT6FoT4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9ploikowSpYcqyPen6CyQ+znvNDVL+LWnvYXeiBW8r9M1o1gdo5zbgwpluKRxkCSuWtylQ1TjsW/l/YjAtm10ZdgKINTOjp+54iD8gypgOaFnSkt7KoUeN2d4OvZY96L3M+8762nMsTYrd5pETSG4wWTURYVsE5Yvz17IGWix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ/lBq2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF6C4CEF5;
	Wed,  3 Dec 2025 14:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764772880;
	bh=394n7gwiwxM2C8tCdb/2LUSTj5/iwWPEBNhZT6FoT4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZ/lBq2pbfWmi3mh6mLNwKV2uZqBRo8UAumUVDUyPNxqv3tOPu/xihuZmT81+1M0D
	 dxCYT+c/33vxLdarNY46+rAKNr/PfyiwL7ZPKAx1WymCNHxEzwvqWYWoMJviCf6v6n
	 5xN3QlT+fQws9ZCtz4X5zQn2EqPGnwEpDHqXxDbkYUvt7sbQioYP5haCanhH9oR8IJ
	 QeErpPYpVHVv4JORML1w6s3+sjLTXsJ1uUufrVH1VD29iVSJtwfBHunfc+gh+TTcGT
	 IP5GCNX52TqY7Zj7aG4lZ1qnY/JkwYm4bBKuDtaxReJJE+oitxypKJrftEnsj/9TGm
	 C6TyL2Iu7Yjew==
From: Chuck Lever <cel@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux NFS <linux-nfs@vger.kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 0/3] NFSD IO MODES documentation fixes
Date: Wed,  3 Dec 2025 09:41:16 -0500
Message-ID: <176477285993.13091.8474374016571986283.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203010911.14234-1-bagasdotme@gmail.com>
References: <20251203010911.14234-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 03 Dec 2025 08:09:08 +0700, Bagas Sanjaya wrote:
> Here are fixes for NFSD IO modes documentation as reported in linux-next [1].
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-next/20251202152506.7a2d2d41@canb.auug.org.au/
> 
> Bagas Sanjaya (3):
>   NFSD: Add toctree entry for NFSD IO modes docs
>   NFSD: nfsd-io-modes: Wrap shell snippets in literal code blocks
>   NFSD: nfsd-io-modes: Separate lists
> 
> [...]

Applied to nfsd-next, thanks!

[1/3] NFSD: Add toctree entry for NFSD IO modes docs
      commit: 21478b6ecaa443ee5a89ae744559583ffbe50f30
[2/3] NFSD: nfsd-io-modes: Wrap shell snippets in literal code blocks
      commit: 4fcf9952fb3137c64e32edb5fcd03da6febe4724
[3/3] NFSD: nfsd-io-modes: Separate lists
      commit: df8c841dd92a7f262ad4fa649aa493b181e02812

--
Chuck Lever



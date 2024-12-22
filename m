Return-Path: <linux-nfs+bounces-8710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410CD9FA6E4
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685F31887086
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Dec 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63B18BB9C;
	Sun, 22 Dec 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P047XX0V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2162152E1C;
	Sun, 22 Dec 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734885628; cv=none; b=Td6eRVLk6ogg2KxUhCBKDgLuUHbupDmZKxUCX0/9LQbuYfkc9qiYCDNOHOYjCgbrAQ8TVNLDGvDosVKo3ZIf3zI8A31SwbQEttHMp3w+aNFZG/thKCJzXyz/RyX+Fi7vb3sSOW8rl4JBEhm89H2gwJcF0G6Rw4ZbGmKzevSrk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734885628; c=relaxed/simple;
	bh=jjQdUNmOzo9/eDsLK6FQx+nZ2Mdq5f4NDQUHBYaTO9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcrH68NHScG3fnSzlcySACnsS1NxLL9eqsBPmYQvH+vgtkludzUg49lsWYTUSTV9PZ92a0VD8Rd4Sqba/MsRNPFv6jqa5Rk529Z8qVSOLi3p6AeGjSwtcXNOnpFSANXMAZpHVycYwPkdh8ps4JPQk7FU2WWZEnZY/oOT8aEINf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P047XX0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A583C4CECD;
	Sun, 22 Dec 2024 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734885628;
	bh=jjQdUNmOzo9/eDsLK6FQx+nZ2Mdq5f4NDQUHBYaTO9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P047XX0VyZ6O4ilW3t+ngVsQgBj4I2PSAPGJW1dHpk/iPgbyYPtjagS/Ni6mWKv9s
	 RwoBE4EqDXemblnY4umzUXmN19P8f7yPSVRmfpSrO+CzJzQQzU9JlWbB93V/dCK1p1
	 01JZxW+OU7MYxnSzcl8rBDlwheSvTQS+grL8Vkn54PreumI2yeiw6r6nB6Fci0QEYj
	 d2PpAu5Ag9B8KC2QgIxrmE0Tgjw6YWWERQfdYPfQ09WS9Oshkz7AmH3OogLZVidy6R
	 JF/ynsdBryms7xUcuV4izg3NIt2u7wW4hz4qyyGS/iyC2S3LOLi9dnlBD+9nCw1V83
	 tM8LvOfBeXTyw==
Received: by pali.im (Postfix)
	id E59407F2; Sun, 22 Dec 2024 17:40:18 +0100 (CET)
Date: Sun, 22 Dec 2024 17:40:18 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] nfs: Fix mounting NFS3 AUTH_NULL exports
Message-ID: <20241222164018.id3ul7ucaxsrdkyq@pali>
References: <20240912130220.17032-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912130220.17032-1-pali@kernel.org>
User-Agent: NeoMutt/20180716

PING? If there is no objection, could you include series into -next?

On Thursday 12 September 2024 15:02:15 Pali Rohár wrote:
> Linux NFS3 kernel client currently has broken support for NFS3
> AUTH_NULL-only exports and also broken mount option -o sec=none
> (which explicitly specifies that mount should use AUTH_NULL).
> 
> For AUTH_NULL-only server exports, Linux NFS3 kernel client mounts such
> export with AUTH_UNIX authentication which results in unusable mount
> point (any operation on it fails with error because server rejects
> AUTH_UNIX authentication).
> 
> Half of the problem is with MNTv3 servers, as some of them (e.g. Linux
> one) never announce AUTH_NULL authentication for any export. Linux MNTv3
> server does not announce it even when the export has the only AUTH_NULL
> auth method allowed, instead it announce AUTH_UNIX (even when AUTH_UNIX
> is disabled for that export in Linux NFS3 knfsd server). So MNTv3 server
> for AUTH_NONE-only exports instruct Linux NFS3 kernel client to use
> AUTH_UNIX and then NFS3 server refuse access to files with AUTH_UNIX.
> 
> Main problem on the client side is that mount option -o sec=none for
> NFS3 client is not processed and Linux NFS kernel client always skips
> AUTH_NULL (even when server announce it, and also even when user
> specifies -o sec=none on mount command line).
> 
> This patch series address these issues in NFS3 client code.
> 
> Add a workaround for buggy MNTv3 servers which do not announce AUTH_NULL,
> by trying AUTH_NULL authentication as an absolutely last chance when
> everything else fails. And honors user choice of AUTH_NULL if user
> explicitly specified -o sec=none as mount option.
> 
> AUTH_NULL authentication is useful for read-only exports, including
> public exports. As authentication for these types of exports do not have
> to be required.
> 
> Patch series was tested with AUTH_NULL-only, AUTH_UNIX-only and combined
> AUTH_NULL+AUTH_UNIX exports from Linux knfsd NFS3 server + default Linux
> MNTv3 userspace server. And also tested with exports from modified MNTv3
> server to properly return AUTH_NULL support in response list.
> 
> Patch series is based on the latest upstream tag v6.11-rc7.
> 
> Pali Rohár (5):
>   nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3
>     server
>   nfs: Propagate AUTH_NULL/AUTH_UNIX PATHCONF NFS3ERR_ACCESS failures
>   nfs: Try to use AUTH_NULL for NFS3 mount when no -o sec was given
>   nfs: Fix -o sec=none output in /proc/mounts
>   nfs: Remove duplicate debug message 'using auth flavor'
> 
>  fs/nfs/client.c | 14 ++++++++++-
>  fs/nfs/super.c  | 64 +++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 65 insertions(+), 13 deletions(-)
> 
> -- 
> 2.20.1
> 


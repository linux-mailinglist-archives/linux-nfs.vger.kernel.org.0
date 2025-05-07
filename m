Return-Path: <linux-nfs+bounces-11555-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E272DAAD9D7
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 10:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DDB7A51F1
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581862367B6;
	Wed,  7 May 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YyGuaGcX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A692356C1;
	Wed,  7 May 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604700; cv=none; b=n113AzSn9wFkl0wSyoZxXnFtB9EipSd67+chQxzgXsgN4ALXmh4Nh7RvY7tVO71h1pSSDviNZ6HYBvs2BkOrErNt+5smk7ivpDG/olq0LGYPCzT9qO0AOf3Cc74e6nqFAV3kgc4Hw8uFcN9tT5DqAzVH4jwvdrygnv5VMXK5wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604700; c=relaxed/simple;
	bh=NMTo+1VygE2ZFq6WoroMJsC8B4qd1zRnTFVKTKeDk3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYpw0UeMWyz+ShQWdLd8OuX/dZheywYwzjr4DrP4fHaTUlXW1V8sFLGELPo5A3aRym0LLDeibfUociWxWK/uZdC/Hv1YB75JhE+qkJbDRPT2NFYQ+CePVecndL4AuDKudpKuXVQyONx3z+JGOWpdVjmF2/yJIkd+udhmX6tKXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YyGuaGcX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6R+/rzZGlEzyBHm38RJzx156qjs1ux1Xuk5DeVo6vl8=; b=YyGuaGcXrQj/z7oR9+Bio64YIv
	LH/u1R0ycClWGSrfKgI6X3axgPWEoN2sCHt3j93vpG+bXjhoLyoA0/Z9wh4zV69bMCqTl7tnW325r
	7TGKy6JfpbobN7k5bk/gkz/Fhyddigl7F74cT3wvZGM2BgDOe2/Bvo4zrRViNRPdTv+TAmGFdYsNE
	ISBl87yDh0hq9KZinMri/fSeBTK4OX3mTWjmsuw4ZIJRLxdsNxhOX6Ygb4yejT7eiJrGeyvHWqf1G
	EEPcGLhh1y3bR36C4FhvFGOAbs8IkXfp7PvG+FwOaqzNwvzwDPr/6a0NreSqourCDBbLym0XJNvGi
	3tB5I7aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZfV-0000000EdFz-3s23;
	Wed, 07 May 2025 07:58:17 +0000
Date: Wed, 7 May 2025 00:58:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBsSmc7W8Cx7n9md@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 07, 2025 at 10:50:00AM +0300, Sagi Grimberg wrote:
> Just so I understand, this is a separate issue from passing the keyring to
> tlshd correct? Is the suggesting that nfs will create a special .nfs keyring
> similar to what nvme does?

Yeah.

> Note that nvme also allows the user to pass its own keyring (never tried
> it before - we probably need a blktest for it //hannes). So in this case,
> the
> possessor will need to set user READ perms on the key itself (assuming that
> it updated tlshd.conf to know this keyring)?

I think so.  Or give user read permissions for the keys (which from
my limited undertanding renders the patches a bit useless).

Let me send out my current patches and discuss it there.


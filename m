Return-Path: <linux-nfs+bounces-4982-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9514934DDB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 15:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CA6284845
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05213C806;
	Thu, 18 Jul 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Hl7ZeA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C354645
	for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308406; cv=none; b=tVLbedYQVB8h/lU/Y9IGcIWNd0xwlqJrKJGNMjiU1tb6Vq2vLpD63dkLDIOM9pI816IgHcGgZzZ/SOx6PBIkM5kFWm55qavou6McGqOrDRunEBKkc5zdxQuP0haHNYRADj5NMbGZjzZVebhrIRAi6HmzWP2G+jPVXAcZ2k1beIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308406; c=relaxed/simple;
	bh=/LCWzpvqytCDN+D908oe8TLMFxu2F8RKp69rl3H1wag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bo8ZVNeMrNA4QoyblEqewjAjLyFGROZssgp9Al4TG6M4Gje1R3chTq9NdHmPYTv7skxVb3kVGR37krU9MDdZLIJcpZsRvUkMkFROuDu4XsVr4xnXiwTZSJG0vKJy9xsFFGd1Phk3UERs2DgSLRwdIFhyw13DiaJ/bC6zZi9cY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5Hl7ZeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD1AC116B1;
	Thu, 18 Jul 2024 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721308406;
	bh=/LCWzpvqytCDN+D908oe8TLMFxu2F8RKp69rl3H1wag=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G5Hl7ZeAAxRPvLwZGqSGScQWmsmxTYL2AsQOieas2OHFBKnJtK1KxxCjHJ8I+i41s
	 xDx29ZhoSJyYMsM01yVOT1MlhrrkMZUz0YYJFooovy01ZqrzCMPPPQnt1heUbXzLKQ
	 fH9Ix7GxXsBOV/MA3+RLpPPhL6SVUcFMqUBPDFpJXhocQCxq73yQrlW+VGq7LBaaVK
	 KExi0+UQyST96mxAAc+G1gCE0+cFXL3FHnU3cXwjezMqvEGwPMynNZAlQt+YJCtX2f
	 iOnjwAU34QfdtONLgtk990frJTmYaM9dJZTdYYYI39myEaNTYwZB5g99Kg+vRWX0+n
	 RzESUH+VqwQcg==
Message-ID: <eedd6203b6869d423f5d680eb52b8a3ce56e90ce.camel@kernel.org>
Subject: Re: [PATCH] NFS: trace: show TIMEDOUT instead of 0x6e
From: Jeff Layton <jlayton@kernel.org>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Chuck Lever
 <chuck.lever@oracle.com>,  Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 18 Jul 2024 09:13:23 -0400
In-Reply-To: <20240718070640.1913-1-chenhx.fnst@fujitsu.com>
References: <20240718070640.1913-1-chenhx.fnst@fujitsu.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-18 at 15:06 +0800, Chen Hanxiao wrote:
> __nfs_revalidate_inode may return ETIMEDOUT.
>=20
> print symbol of ETIMEDOUT in nfs trace:
>=20
> before:
> cat-5191 [005] 119.331127: nfs_revalidate_inode_exit: error=3D-110
> (0x6e)
>=20
> after:
> cat-1738 [004] 44.365509: nfs_revalidate_inode_exit: error=3D-110
> (TIMEDOUT)
>=20
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
> =C2=A0include/trace/misc/nfs.h | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
> index 7b221d51133a..c82233e950ac 100644
> --- a/include/trace/misc/nfs.h
> +++ b/include/trace/misc/nfs.h
> @@ -51,6 +51,7 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
> =C2=A0		{ NFSERR_IO,			"IO" }, \
> =C2=A0		{ NFSERR_NXIO,			"NXIO" }, \
> =C2=A0		{ ECHILD,			"CHILD" }, \
> +		{ ETIMEDOUT,			"TIMEDOUT" }, \
> =C2=A0		{ NFSERR_EAGAIN,		"AGAIN" }, \
> =C2=A0		{ NFSERR_ACCES,			"ACCES" }, \
> =C2=A0		{ NFSERR_EXIST,			"EXIST" }, \

Reviewed-by: Jeff Layton <jlayton@kernel.org>


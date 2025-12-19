Return-Path: <linux-nfs+bounces-17235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9ECD0687
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D0C3087D7E
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC733AD8F;
	Fri, 19 Dec 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO3nYkeS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3633A71F
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155871; cv=none; b=Is//FYlotY831W1b6Ngqj3jIkJ091I97rjSb4fYJD6mJ0QBqccmgFF1taJe209E/Dm9xAfTDi0ufaAjAoYSv7kehZ+zHDDhzwoRA0VmnNlgXPUvrZssdO9ijECDqeTo1LTxsCVKS3Ne0ZbMeV9e9YzJePYmCYOLnQ0RlMRcqBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155871; c=relaxed/simple;
	bh=XsaWKZZY3iGrGkJPQFWgPsgIHRMx0oteO5KeQ8GWimo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QF0VWqN6mtT8lF4EvXhmBDak8o8peLEQP7/DKwY9eNFsCdR53sz9kpS1jqu7NHyLblRTA53GMrrULTsfw4FMF6NTGHxk+HRdHJtftq5KFxNJyT9NUO6iELQSJOsB9YHteWRn5pixqhUJWF7vHK15WwPNMDx2WcWCNA0kjixyZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO3nYkeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495F0C4CEF1;
	Fri, 19 Dec 2025 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766155870;
	bh=XsaWKZZY3iGrGkJPQFWgPsgIHRMx0oteO5KeQ8GWimo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jO3nYkeSeVmPtZtT1pNrz0OgKAHAOn5Wxjq7M7wtOoTr4Nxd7JE8IFFirlB6PcJ5K
	 FINm7FPJiTuzROTHgCDpi7x3VWTSIXCCdwNW7LtAieauMI3XVizpfgPqBSDMvYlEKu
	 fNw1nziwm9s48a5vf225iFcu+Hdfmfv+wNQuNIND1h+oN9rY1aiXbntF97wbHk3N9U
	 s4gJnJj8xDeycQrloPEXD4ikYzCVfifkAt/Ioo1WHEylr43G4GCFJwPzJ8CxL1i3RW
	 KUk6KIEWh4iuUy2aytD2ya9sDCN5xriv5A+OJAY1+zOzbZEdNGk+bUG5ysVX6Uk6EA
	 K0W0bruUhfqHQ==
Message-ID: <3dffab431dc12e484826ee9712806bbfafcb03ab.camel@kernel.org>
Subject: Re: [PATCH v1 00/36] Clarify module API boundaries
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Fri, 19 Dec 2025 09:51:07 -0500
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 15:13 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The first nine patches in this series refactor the lockd code base
> to clearly separate its public API from internal implementation
> details.
>=20
> The lockd subsystem currently exposes internal implementation headers
> through include/linux/lockd/, creating implicit API contracts that
> complicate maintenance. External consumers such as NFSD and the NFS
> client have developed dependencies on internal structures like struct
> nlm_host, and wire protocol constants leak into high-level module
> interfaces.
>=20
> These patches work to establish clean architectural boundaries. The
> public API in include/linux/lockd/ is reduced to bind.h and nlm.h,
> which define the contract between lockd and its consumers. Private
> implementation details including XDR definitions, share management,
> and host structures are relocated to fs/lockd/ where they belong.
> Layering violations are corrected: the NFS client now uses accessor
> helpers instead of dereferencing internal structures, and nlm_fopen()
> returns errno values instead of wire protocol codes.
>=20
> These changes enable subsequent work to modernize the NLMv4 XDR
> layer using xdrgen without risk of breaking external consumers.
> This work appears in the remaining patches in this series, which
> are presented here only to provide context for the API adjustments.
> No need to review those closely just yet.
>=20
> The series is based on commit 771cfff228fc in the public
> nfsd-testing branch.
>=20
>=20
> Chuck Lever (36):
>   lockd: Have nlm_fopen() return errno values
>   lockd: Relocate nlmsvc_unlock API declarations
>   NFS: Use nlmclnt_rpc_clnt() helper to retrieve nlm_host's rpc_clnt
>   lockd: Move xdr4.h from include/linux/lockd/ to fs/lockd/
>   lockd: Move share.h from include/linux/lockd/ to fs/lockd/
>   lockd: Relocate include/linux/lockd/lockd.h
>   lockd: Remove lockd/debug.h
>   lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
>   Documentation: Add the RPC language description of NLM version 4
>   lockd: Use xdrgen XDR functions for the NLMv4 NULL procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 TEST procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 LOCK procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 CANCEL procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 GRANTED procedure
>   lockd: Refactor nlm4svc_callback()
>   lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 CANCEL_MSG procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 UNLOCK_MSG procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 GRANTED_MSG procedure
>   lockd: Convert server-side NLMPROC4_TEST_RES to use xdrgen
>   lockd: Convert server-side NLMPROC4_LOCK_RES to use xdrgen
>   lockd: Convert server-side NLMPROC4_CANCEL_RES to use xdrgen
>   lockd: Convert server-side NLMPROC4_UNLOCK_RES to use xdrgen
>   lockd: Convert server-side NLMPROC4_GRANTED_RES to use xdrgen
>   lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
>   lockd: Convert server-side undefined procedures to xdrgen
>   lockd: Hoist file_lock init out of nlm4svc_decode_shareargs()
>   lockd: Update share_file helpers
>   lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 UNSHARE procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 NM_LOCK procedure
>   lockd: Use xdrgen XDR functions for the NLMv4 FREE_ALL procedure
>   lockd: Remove utilities that are no longer used
>   lockd: Remove dead code from fs/lockd/xdr4.c
>=20
>  Documentation/sunrpc/xdr/nlm4.x     |  211 ++++
>  fs/lockd/Makefile                   |   21 +-
>  fs/lockd/clnt4xdr.c                 |    5 +-
>  fs/lockd/clntlock.c                 |    2 +-
>  fs/lockd/clntproc.c                 |    2 +-
>  fs/lockd/clntxdr.c                  |    5 +-
>  fs/lockd/host.c                     |    2 +-
>  {include/linux =3D> fs}/lockd/lockd.h |   49 +-
>  fs/lockd/mon.c                      |    2 +-
>  fs/lockd/nlm4xdr_gen.c              |  724 +++++++++++++
>  fs/lockd/nlm4xdr_gen.h              |   32 +
>  {include/linux =3D> fs}/lockd/share.h |   16 +-
>  fs/lockd/svc.c                      |    2 +-
>  fs/lockd/svc4proc.c                 | 1562 +++++++++++++++++----------
>  fs/lockd/svclock.c                  |    5 +-
>  fs/lockd/svcproc.c                  |   13 +-
>  fs/lockd/svcshare.c                 |   40 +-
>  fs/lockd/svcsubs.c                  |   43 +-
>  fs/lockd/trace.h                    |    3 +-
>  fs/lockd/xdr.c                      |    3 +-
>  {include/linux =3D> fs}/lockd/xdr.h   |   12 +-
>  fs/lockd/xdr4.c                     |  347 ------
>  fs/lockd/xdr4.h                     |  104 ++
>  fs/nfs/sysfs.c                      |   10 +-
>  fs/nfsd/lockd.c                     |   51 +-
>  fs/nfsd/nfsctl.c                    |    2 +-
>  include/linux/lockd/bind.h          |   17 +-
>  include/linux/lockd/debug.h         |   40 -
>  include/linux/lockd/xdr4.h          |   43 -
>  include/linux/sunrpc/xdrgen/nlm4.h  |  231 ++++
>  30 files changed, 2513 insertions(+), 1086 deletions(-)
>  create mode 100644 Documentation/sunrpc/xdr/nlm4.x
>  rename {include/linux =3D> fs}/lockd/lockd.h (94%)
>  create mode 100644 fs/lockd/nlm4xdr_gen.c
>  create mode 100644 fs/lockd/nlm4xdr_gen.h
>  rename {include/linux =3D> fs}/lockd/share.h (63%)
>  rename {include/linux =3D> fs}/lockd/xdr.h (94%)
>  delete mode 100644 fs/lockd/xdr4.c
>  create mode 100644 fs/lockd/xdr4.h
>  delete mode 100644 include/linux/lockd/debug.h
>  delete mode 100644 include/linux/lockd/xdr4.h
>  create mode 100644 include/linux/sunrpc/xdrgen/nlm4.h

Big pile! I looked over the more interesting bits and didn't see
anything objectionable. This looks like a nice change that removes a
pile of stuff from include/ and gets lockd working with xdrgen'ed
definitions. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>


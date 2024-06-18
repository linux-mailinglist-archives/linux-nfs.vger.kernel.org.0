Return-Path: <linux-nfs+bounces-4029-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C5890DE0F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC2C1C235EF
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A3A16B3BF;
	Tue, 18 Jun 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT7O/gl2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40C13BC30
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745453; cv=none; b=sVcr4tmIymGtJl0jS8IS5JOujWjWvaS5h97GuzxxDhGifyWBc/W3W4toRx7cj8B8uk2h6NQ1pB1dzRfhTIiL4wvvykb9ZzSqGgJE1nrAUmqoheknjzLU70h2bLxMimZNV+abUalT9Z9E9e9G0MamoWwVSB55aJtGsojzJrJk/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745453; c=relaxed/simple;
	bh=6R8yHjxejR0qD9Mx+uxDumblT4DxTLeUkAaULsH5sUA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPss2bJWu6GtCo2tFpyXdrR2hZJ+So2tb7Yf9gOYf9upVf3uY5KTAdxMRnsK7LPPANZIPJU5S54xoYDzDDohpHLOhC7yjVYwcdZLAfRIfALaa/6z+bZ/mURVZFd4HB7hGAIiftif24Oi6He1YFqjROlqSwMz/aQ+lDU05Th1278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT7O/gl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE36C3277B;
	Tue, 18 Jun 2024 21:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718745452;
	bh=6R8yHjxejR0qD9Mx+uxDumblT4DxTLeUkAaULsH5sUA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VT7O/gl2JxVZG2VZIO3Ul446JBiosJA7e2EuoOo3j9hEq5aBV2FcLCi7nxcrjjIiZ
	 4mJ24D7zIsQ+Ce12ALnHjZEn8ueABgY1NbjTKX+ifLzvVS1Lik+YLcoeTYwCWOXLAI
	 1qCqyErP6sAobya2hLmxoH0AEqMLhj4wtopxdO5dWIrgJHnNzv1EPgEx64x1WxtVCA
	 nIavYZeXzidqeJmolj0INUNhWKYDgLaM/PrvD/IqxOC71PGYolBzZS/tPLaDOAn0ng
	 0voOfQ9/ptaIGnknZYgxH7Hg+m80yEMVDetdmJNpWYChmdQJ0/ZEDPHZGxVrgRcmN+
	 doizkBRV51AFg==
Message-ID: <44aa2b7d8eb6591bbf43cef2ca38046e61d5e0a8.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix backchannel reply, again
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, linux-nfs@vger.kernel.org
Cc: Ben Coddington <bcodding@redhat.com>, Chuck Lever
 <chuck.lever@oracle.com>
Date: Tue, 18 Jun 2024 17:17:30 -0400
In-Reply-To: <20240614141851.97723-2-cel@kernel.org>
References: <20240614141851.97723-2-cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-14 at 10:18 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> I still see "RPC: Could not send backchannel reply error: -110"
> quite often, along with slow-running tests. Debugging shows that the
> backchannel is still stumbling when it has to queue a callback reply
> on a busy transport.
>=20
> Note that every one of these timeouts causes a connection loss by
> virtue of the xprt_conditional_disconnect() call in that arm of
> call_cb_transmit_status().
>=20
> I found that setting to_maxval is necessary to get the RPC timeout
> logic to behave whenever to_exponential is not set.
>=20
> Fixes: 57331a59ac0d ("NFSv4.1: Use the nfs_client's rpc timeouts for
> backchannel")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> =C2=A0net/sunrpc/svc.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 965a27806bfd..f4ddb2961042 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1643,6 +1643,7 @@ void svc_process_bc(struct rpc_rqst *req,
> struct svc_rqst *rqstp)
> =C2=A0		timeout.to_initval =3D req->rq_xprt->timeout-
> >to_initval;
> =C2=A0		timeout.to_retries =3D req->rq_xprt->timeout-
> >to_retries;
> =C2=A0	}
> +	timeout.to_maxval =3D timeout.to_initval;
> =C2=A0	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req-
> >rq_snd_buf));
> =C2=A0	task =3D rpc_run_bc_task(req, &timeout);
> =C2=A0

Reviewed-by: Jeff Layton <jlayton@kernel.org>


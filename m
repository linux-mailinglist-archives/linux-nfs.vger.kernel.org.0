Return-Path: <linux-nfs+bounces-5585-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA795BC08
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 18:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3791A1F25DB4
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE31CDA20;
	Thu, 22 Aug 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVvqIpQS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191A1CDA0F
	for <linux-nfs@vger.kernel.org>; Thu, 22 Aug 2024 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344494; cv=none; b=Vl+2rmvZ384ud0hbtJFIocLbaZ8Zv8emy7y8pAZcJY+caCnS2NhBBBgtNeXJXmI8P5r/aUcngNklMYXwyT4fqCbbcQD/lpKt8G8z4l0v8dZg5nRQnjvoqIi5lA1HjcF0xS3QTnXfIRkUk77WUArbRW119RnvcoZDX2nq93FyJ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344494; c=relaxed/simple;
	bh=U5wSvTeKsZGpxWcH+lzkllyejlYI205tB5pRnksS6zE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRgjQ7vxO1qhUcItHUFjDkTMOgQt9s6V1cJ9Y8ALfqg3dkhLXz9dW9bH1b22JJ4gwuvQYEHWbn28UDLiSsBsVveU8LW0Z1R37AvksxIUhN/gDsWrEChetum7IYsgEIQotz0KqHt2OYFfik5AjX0e31xuVUwlqQmJ8umvqiqAJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVvqIpQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C54C32782;
	Thu, 22 Aug 2024 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724344493;
	bh=U5wSvTeKsZGpxWcH+lzkllyejlYI205tB5pRnksS6zE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mVvqIpQScWv0beAOgJYNib7AS+dB9UexvqE2F/eYtDzNLHi/Lfk3eXsyvDghAE85X
	 /n2B+mePoRpjWBb1f+lL4AOnmCGEhmtnVPcZ13nS8zE63btTsIKCfUCEhAlB5mCprl
	 GRncLxPi5BNnOAazMQh9Rds2sqnIA1E6f1PAbIOspAAeIAUsZ5Rp3d8PSNBpOIvhsu
	 beKwDw3PsjM7Vg1JTHTxz+eHcU2AsAk2rpNb/SidrsfRhcS6Z2knUgOM4S813yda6y
	 qKHGm85T04tcn0AGrIYDUCjWxYU+B5rJUsCDPA60SSYawI2cZymqxQax4/D/W8zMi+
	 AZrtPNEt683NA==
Message-ID: <dfe79cbc14abb36faa4e453c5baa67f0d0c12264.camel@kernel.org>
Subject: Re: [RFC PATCH 2/2] NFSD: Create an initial nfs4_1.x file
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 22 Aug 2024 12:34:52 -0400
In-Reply-To: <20240820144600.189744-3-cel@kernel.org>
References: <20240820144600.189744-1-cel@kernel.org>
	 <20240820144600.189744-3-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-20 at 10:46 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Build an NFSv4 protocol snippet to support the delstid extensions.
> The new fs/nfsd/nfs4_1.x file can be added to over time as other
> parts of NFSD's XDR functions are converted to machine-generated
> code.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4_1.x      | 164 +++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr_gen.c | 236 ++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4xdr_gen.h | 113 ++++++++++++++++++++
>  3 files changed, 513 insertions(+)
>  create mode 100644 fs/nfsd/nfs4_1.x
>  create mode 100644 fs/nfsd/nfs4xdr_gen.c
>  create mode 100644 fs/nfsd/nfs4xdr_gen.h
>=20
> diff --git a/fs/nfsd/nfs4_1.x b/fs/nfsd/nfs4_1.x
> new file mode 100644
> index 000000000000..d2fde450de5e
> --- /dev/null
> +++ b/fs/nfsd/nfs4_1.x
> @@ -0,0 +1,164 @@
> +/*
> + * Copyright (c) 2010 IETF Trust and the persons identified
> + * as the document authors.  All rights reserved.
> + *
> + * The document authors are identified in RFC 3530 and
> + * RFC 5661.
> + *
> + * Redistribution and use in source and binary forms, with
> + * or without modification, are permitted provided that the
> + * following conditions are met:
> + *
> + * - Redistributions of source code must retain the above
> + *   copyright notice, this list of conditions and the
> + *   following disclaimer.
> + *
> + * - Redistributions in binary form must reproduce the above
> + *   copyright notice, this list of conditions and the
> + *   following disclaimer in the documentation and/or other
> + *   materials provided with the distribution.
> + *
> + * - Neither the name of Internet Society, IETF or IETF
> + *   Trust, nor the names of specific contributors, may be
> + *   used to endorse or promote products derived from this
> + *   software without specific prior written permission.
> + *
> + *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS
> + *   AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
> + *   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + *   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *   FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
> + *   EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
> + *   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + *   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + *   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> + *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> + *   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
> + *   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> + *   ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +pragma header nfs4;
> +
> +/*
> + * Basic typedefs for RFC 1832 data type definitions
> + */
> +typedef hyper		int64_t;
> +typedef unsigned int	uint32_t;
> +
> +/*
> + * Basic data types
> + */
> +typedef uint32_t	bitmap4<>;
> +
> +/*
> + * Timeval
> + */
> +struct nfstime4 {
> +	int64_t		seconds;
> +	uint32_t	nseconds;
> +};
> +
> +
> +/*
> + * The following content was extracted from draft-ietf-nfsv4-delstid
> + */
> +
> +typedef bool            fattr4_offline;
> +
> +
> +const FATTR4_OFFLINE            =3D 83;
> +
> +
> +struct open_arguments4 {
> +  bitmap4  oa_share_access;
> +  bitmap4  oa_share_deny;
> +  bitmap4  oa_share_access_want;
> +  bitmap4  oa_open_claim;
> +  bitmap4  oa_create_mode;
> +};
> +
> +
> +enum open_args_share_access4 {
> +   OPEN_ARGS_SHARE_ACCESS_READ  =3D 1,
> +   OPEN_ARGS_SHARE_ACCESS_WRITE =3D 2,
> +   OPEN_ARGS_SHARE_ACCESS_BOTH  =3D 3
> +};
> +
> +
> +enum open_args_share_deny4 {
> +   OPEN_ARGS_SHARE_DENY_NONE  =3D 0,
> +   OPEN_ARGS_SHARE_DENY_READ  =3D 1,
> +   OPEN_ARGS_SHARE_DENY_WRITE =3D 2,
> +   OPEN_ARGS_SHARE_DENY_BOTH  =3D 3
> +};
> +
> +
> +enum open_args_share_access_want4 {
> +   OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG           =3D 3,
> +   OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG            =3D 4,
> +   OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL              =3D 5,
> +   OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL
> +                                                   =3D 17,
> +   OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED
> +                                                   =3D 18,
> +   OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS    =3D 20,
> +   OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION =3D 21
> +};
> +
> +
> +enum open_args_open_claim4 {
> +   OPEN_ARGS_OPEN_CLAIM_NULL          =3D 0,
> +   OPEN_ARGS_OPEN_CLAIM_PREVIOUS      =3D 1,
> +   OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR  =3D 2,
> +   OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV =3D 3,
> +   OPEN_ARGS_OPEN_CLAIM_FH            =3D 4,
> +   OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH  =3D 5,
> +   OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH =3D 6
> +};
> +
> +
> +enum open_args_createmode4 {
> +   OPEN_ARGS_CREATEMODE_UNCHECKED4     =3D 0,
> +   OPEN_ARGS_CREATE_MODE_GUARDED       =3D 1,
> +   OPEN_ARGS_CREATEMODE_EXCLUSIVE4     =3D 2,
> +   OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1  =3D 3
> +};
> +
> +
> +typedef open_arguments4 fattr4_open_arguments;
> +pragma public fattr4_open_arguments;
> +
> +
> +%/*
> +% * Determine what OPEN supports.
> +% */
> +const FATTR4_OPEN_ARGUMENTS     =3D 86;
> +
> +
> +const OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION =3D 0x200000;
> +
> +
> +const OPEN4_RESULT_NO_OPEN_STATEID =3D 0x00000010;
> +
> +
> +/*
> + * attributes for the delegation times being
> + * cached and served by the "client"
> + */
> +typedef nfstime4        fattr4_time_deleg_access;
> +typedef nfstime4        fattr4_time_deleg_modify;
> +
> +
> +%/*
> +% * New RECOMMENDED Attribute for
> +% * delegation caching of times
> +% */
> +const FATTR4_TIME_DELEG_ACCESS  =3D 84;
> +const FATTR4_TIME_DELEG_MODIFY  =3D 85;
> +
> +
> +const OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS =3D 0x100000;
> +
> diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
> new file mode 100644
> index 000000000000..bb714859d6c6
> --- /dev/null
> +++ b/fs/nfsd/nfs4xdr_gen.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Generated by xdrgen. Manual edits will be lost.
> +// XDR specification modification time: Mon Aug 19 23:28:23 2024
> +
> +#include "nfs4xdr_gen.h"
> +
> +static bool __maybe_unused
> +xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
> +{
> +	return xdrgen_decode_hyper(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_uint32_t(struct xdr_stream *xdr, uint32_t *ptr)
> +{
> +	return xdrgen_decode_unsigned_int(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_bitmap4(struct xdr_stream *xdr, bitmap4 *ptr)
> +{
> +	if (xdr_stream_decode_u32(xdr, &ptr->count) < 0)
> +		return false;
> +	for (u32 i =3D 0; i < ptr->count; i++)
> +		if (!xdrgen_decode_uint32_t(xdr, &ptr->element[i]))
> +			return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_nfstime4(struct xdr_stream *xdr, struct nfstime4 *ptr)
> +{
> +	if (!xdrgen_decode_int64_t(xdr, &ptr->seconds))
> +		return false;
> +	if (!xdrgen_decode_uint32_t(xdr, &ptr->nseconds))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_fattr4_offline(struct xdr_stream *xdr, fattr4_offline *ptr=
)
> +{
> +	return xdrgen_decode_bool(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_arguments4(struct xdr_stream *xdr, struct open_argume=
nts4 *ptr)
> +{
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_deny))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_share_access_want))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_open_claim))
> +		return false;
> +	if (!xdrgen_decode_bitmap4(xdr, &ptr->oa_create_mode))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_share_access4(struct xdr_stream *xdr, enum open_=
args_share_access4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr =3D val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_share_deny4(struct xdr_stream *xdr, enum open_ar=
gs_share_deny4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr =3D val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_share_access_want4(struct xdr_stream *xdr, enum =
open_args_share_access_want4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr =3D val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_open_claim4(struct xdr_stream *xdr, enum open_ar=
gs_open_claim4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr =3D val;
> +	return true;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_decode_open_args_createmode4(struct xdr_stream *xdr, enum open_ar=
gs_createmode4 *ptr)
> +{
> +	u32 val;
> +
> +	if (xdr_stream_decode_u32(xdr, &val) < 0)
> +		return false;
> +	*ptr =3D val;
> +	return true;
> +}
> +
> +bool
> +xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_=
arguments *ptr)
> +{
> +	return xdrgen_decode_open_arguments4(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_ti=
me_deleg_access *ptr)
> +{
> +	return xdrgen_decode_nfstime4(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_ti=
me_deleg_modify *ptr)
> +{
> +	return xdrgen_decode_nfstime4(xdr, ptr);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_int64_t(struct xdr_stream *xdr, const int64_t value)
> +{
> +	return xdrgen_encode_hyper(xdr, value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_uint32_t(struct xdr_stream *xdr, const uint32_t value)
> +{
> +	return xdrgen_encode_unsigned_int(xdr, value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_bitmap4(struct xdr_stream *xdr, const bitmap4 value)
> +{
> +	if (xdr_stream_encode_u32(xdr, value.count) !=3D XDR_UNIT)
> +		return false;
> +	for (u32 i =3D 0; i < value.count; i++)
> +		if (!xdrgen_encode_uint32_t(xdr, value.element[i]))
> +			return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_nfstime4(struct xdr_stream *xdr, const struct nfstime4 *va=
lue)
> +{
> +	if (!xdrgen_encode_int64_t(xdr, value->seconds))
> +		return false;
> +	if (!xdrgen_encode_uint32_t(xdr, value->nseconds))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_fattr4_offline(struct xdr_stream *xdr, const fattr4_offlin=
e value)
> +{
> +	return xdrgen_encode_bool(xdr, value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_arguments4(struct xdr_stream *xdr, const struct open_=
arguments4 *value)
> +{
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_deny))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_share_access_want))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_open_claim))
> +		return false;
> +	if (!xdrgen_encode_bitmap4(xdr, value->oa_create_mode))
> +		return false;
> +	return true;
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_share_access4(struct xdr_stream *xdr, enum open_=
args_share_access4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_share_deny4(struct xdr_stream *xdr, enum open_ar=
gs_share_deny4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_share_access_want4(struct xdr_stream *xdr, enum =
open_args_share_access_want4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_open_claim4(struct xdr_stream *xdr, enum open_ar=
gs_open_claim4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> +}
> +
> +static bool __maybe_unused
> +xdrgen_encode_open_args_createmode4(struct xdr_stream *xdr, enum open_ar=
gs_createmode4 value)
> +{
> +	return xdr_stream_encode_u32(xdr, value) =3D=3D XDR_UNIT;
> +}
> +
> +bool
> +xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4=
_open_arguments value)
> +{
> +	return xdrgen_encode_open_arguments4(xdr, &value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fat=
tr4_time_deleg_access value)
> +{
> +	return xdrgen_encode_nfstime4(xdr, &value);
> +};
> +
> +static bool __maybe_unused
> +xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fat=
tr4_time_deleg_modify value)
> +{
> +	return xdrgen_encode_nfstime4(xdr, &value);
> +};
> diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
> new file mode 100644
> index 000000000000..27c601b36580
> --- /dev/null
> +++ b/fs/nfsd/nfs4xdr_gen.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Generated by xdrgen. Manual edits will be lost. */
> +/* XDR specification modification time: Mon Aug 19 23:28:23 2024 */
> +
> +#ifndef _LINUX_NFS4_XDRGEN_H
> +#define _LINUX_NFS4_XDRGEN_H
> +
> +#include <linux/types.h>
> +#include <linux/sunrpc/svc.h>
> +
> +#include <linux/sunrpc/xdrgen-builtins.h>
> +
> +typedef s64 int64_t;
> +
> +typedef u32 uint32_t;
> +
> +typedef struct {
> +	u32 count;
> +	uint32_t *element;
> +} bitmap4;
> +
> +struct nfstime4 {
> +	int64_t seconds;
> +	uint32_t nseconds;
> +};
> +
> +typedef bool fattr4_offline;
> +
> +enum {
> +	FATTR4_OFFLINE =3D 83
> +};
> +
> +struct open_arguments4 {
> +	bitmap4 oa_share_access;
> +	bitmap4 oa_share_deny;
> +	bitmap4 oa_share_access_want;
> +	bitmap4 oa_open_claim;
> +	bitmap4 oa_create_mode;
> +};
> +
> +enum open_args_share_access4 {
> +	OPEN_ARGS_SHARE_ACCESS_READ =3D 1,
> +	OPEN_ARGS_SHARE_ACCESS_WRITE =3D 2,
> +	OPEN_ARGS_SHARE_ACCESS_BOTH =3D 3,
> +};
> +
> +enum open_args_share_deny4 {
> +	OPEN_ARGS_SHARE_DENY_NONE =3D 0,
> +	OPEN_ARGS_SHARE_DENY_READ =3D 1,
> +	OPEN_ARGS_SHARE_DENY_WRITE =3D 2,
> +	OPEN_ARGS_SHARE_DENY_BOTH =3D 3,
> +};
> +
> +enum open_args_share_access_want4 {
> +	OPEN_ARGS_SHARE_ACCESS_WANT_ANY_DELEG =3D 3,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_NO_DELEG =3D 4,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_CANCEL =3D 5,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_SIGNAL_DELEG_WHEN_RESRC_AVAIL =3D 17,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_PUSH_DELEG_WHEN_UNCONTENDED =3D 18,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS =3D 20,
> +	OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION =3D 21,
> +};
> +
> +enum open_args_open_claim4 {
> +	OPEN_ARGS_OPEN_CLAIM_NULL =3D 0,
> +	OPEN_ARGS_OPEN_CLAIM_PREVIOUS =3D 1,
> +	OPEN_ARGS_OPEN_CLAIM_DELEGATE_CUR =3D 2,
> +	OPEN_ARGS_OPEN_CLAIM_DELEGATE_PREV =3D 3,
> +	OPEN_ARGS_OPEN_CLAIM_FH =3D 4,
> +	OPEN_ARGS_OPEN_CLAIM_DELEG_CUR_FH =3D 5,
> +	OPEN_ARGS_OPEN_CLAIM_DELEG_PREV_FH =3D 6,
> +};
> +
> +enum open_args_createmode4 {
> +	OPEN_ARGS_CREATEMODE_UNCHECKED4 =3D 0,
> +	OPEN_ARGS_CREATE_MODE_GUARDED =3D 1,
> +	OPEN_ARGS_CREATEMODE_EXCLUSIVE4 =3D 2,
> +	OPEN_ARGS_CREATE_MODE_EXCLUSIVE4_1 =3D 3,
> +};
> +
> +typedef struct open_arguments4 fattr4_open_arguments;
> +bool xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_=
open_arguments *ptr);
> +bool xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const f=
attr4_open_arguments value);
>=20

Question: why does xdrgen generate the above prototype functions for
the encoder and decoder for that typedef, but no corresponding
prototypes for the nfstime4 ones below?

>=20
> +
> +enum {
> +	FATTR4_OPEN_ARGUMENTS =3D 86
> +};
> +
> +enum {
> +	OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION =3D 0x200000
> +};
> +
> +enum {
> +	OPEN4_RESULT_NO_OPEN_STATEID =3D 0x00000010
> +};
> +
> +typedef struct nfstime4 fattr4_time_deleg_access;
> +
> +typedef struct nfstime4 fattr4_time_deleg_modify;
> +
> +enum {
> +	FATTR4_TIME_DELEG_ACCESS =3D 84
> +};
> +
> +enum {
> +	FATTR4_TIME_DELEG_MODIFY =3D 85
> +};
> +
> +enum {
> +	OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS =3D 0x100000
> +};
> +
> +#endif /* _LINUX_NFS4_XDRGEN_H */

--=20
Jeff Layton <jlayton@poochiereds.net>

--=20
Jeff Layton <jlayton@kernel.org>


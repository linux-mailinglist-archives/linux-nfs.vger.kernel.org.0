Return-Path: <linux-nfs+bounces-12506-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3064AADBE8B
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 03:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79AD173853
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jun 2025 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565D9194AD5;
	Tue, 17 Jun 2025 01:29:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB511EB2F;
	Tue, 17 Jun 2025 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750123785; cv=none; b=Y/gZ7MbmMhglkzJPLhgWvQklyf7vydLic13OdRvJhElm0gBxzIrlggYIUGu2J82Wlpuk3NioSLUiSjHcb9gNBYoBG+Mkxa39t0PZOneE1m73tIyWy2kDlS720OETa7Rpxco57qaaHrMKAgGtqL5Cu4/6k2GiBXjJAzM8jdV9iG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750123785; c=relaxed/simple;
	bh=vxegoV2BgUHnQ0atJz+spQ82J2b82Fix3qd/gZSIPT0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=h86pJFGd9ff7sJhdfCOQorwoIOhQjwBFy2x7Jc38sw5pZMFfvaRI58KJAsdYw5O6KBQjHmoRQbPSXDiolSC4zRwFSEOaz908y1q6a+2jEXGelDdwe39zeuLavUgaYkhkuX+FSAFqb9iz3wGC9mR6cIW6DcaCcz9Vrdf5a8zY9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uRL8m-00GzoS-OP;
	Tue, 17 Jun 2025 01:29:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] NFSD: Avoid multiple
 -Wflex-array-member-not-at-end warnings
In-reply-to: <aFCbJ7mKFOzJ8VZ6@kspp>
References: <aFCbJ7mKFOzJ8VZ6@kspp>
Date: Tue, 17 Jun 2025 11:29:32 +1000
Message-id: <175012377224.608730.8179235443153600742@noble.neil.brown.name>

On Tue, 17 Jun 2025, Gustavo A. R. Silva wrote:
> Replace flexible-array member with a fixed-size array.
>=20
> With this changes, fix many instances of the following type of
> warnings:
>=20
> fs/nfsd/nfsfh.h:79:33: warning: structure containing a flexible array membe=
r is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:763:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:669:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/state.h:549:33: warning: structure containing a flexible array memb=
er is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:705:33: warning: structure containing a flexible array membe=
r is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/xdr4.h:678:33: warning: structure containing a flexible array membe=
r is not at the end of another structure [-Wflex-array-member-not-at-end]
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v3:
>  - Replace flexible-array member with a fixed-size array. (NeilBrown)
>=20
> Changes in v2:
>  - Use indices into `fh_raw`. (Christoph)
>  - Remove union and flexible-array member `fh_fsid`. (Christoph)
>  - Link: https://lore.kernel.org/linux-hardening/aEoKCuQ1YDs2Ivn0@kspp/
>=20
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aBp37ZXBJM09yAXp@kspp/
>=20
>  fs/nfsd/nfsfh.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 5103c2f4d225..760e77f3630b 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -56,7 +56,7 @@ struct knfsd_fh {
>  			u8		fh_auth_type;	/* deprecated */
>  			u8		fh_fsid_type;
>  			u8		fh_fileid_type;
> -			u32		fh_fsid[]; /* flexible-array member */
> +			u32		fh_fsid[NFS4_FHSIZE / 4 - 1];
>  		};

Thanks.  I think this is a good and simple solution.

Reviewed-by: NeilBrown <neil@brown.name>


>  	};
>  };
> --=20
> 2.43.0
>=20
>=20



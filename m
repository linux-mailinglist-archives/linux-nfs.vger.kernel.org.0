Return-Path: <linux-nfs+bounces-12884-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4F3AF8454
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 01:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B65581E7E
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Jul 2025 23:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345892BEC20;
	Thu,  3 Jul 2025 23:37:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704D2BEFEF;
	Thu,  3 Jul 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585862; cv=none; b=klmhsA3YSyPeerjxcxENY2t22gCksPUeA9L7DYsp2cZe45TTOUGa1Q2aZv0SZAU/POdGO793S1f/7QLBCHuN7HHwUutVB30PdZYvKRI5W7zet/XiBzn/H5ashIGvETX9ByM+lEo2NNfgDue93lXdxoC37xnWqH7kh8agSKmJ88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585862; c=relaxed/simple;
	bh=gWl5+RALBSHUZ5H8Q0OFt0AOy4pyx/H64SvNR+JgFpI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=u01W94bBSRgk+2xAkU9TdBYRyoik0wYZnY0zhJZY2tpPY91CIOiqm7x4BCPEqdXMoVm0BNUmpnLRpgy6sFWa+i0dTZfBBOouHS6P7fw9CQ/AWfNchu7YEbUV1v+Lb2NaG6coR8bw1nZ26ozuDbp/kV/h35r57lMkfvFTA2WbG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXTRN-0018qw-FQ;
	Thu, 03 Jul 2025 23:34:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Mike Snitzer" <snitzer@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH RFC 1/2] sunrpc: delay pc_release callback until after
 sending a reply
In-reply-to: <20250703-nfsd-testing-v1-1-cece54f36556@kernel.org>
References: <20250703-nfsd-testing-v1-0-cece54f36556@kernel.org>,
 <20250703-nfsd-testing-v1-1-cece54f36556@kernel.org>
Date: Fri, 04 Jul 2025 09:33:33 +1000
Message-id: <175158561386.565058.1936125782874530200@noble.neil.brown.name>

On Fri, 04 Jul 2025, Jeff Layton wrote:
> The server-side sunrpc code currently calls pc_release before sending
> the reply. A later nfsd patch will change some pc_release callbacks to
> do extra work to clean the pagecache. There is no need to delay sending
> the reply for this, however.
>=20
> Change svc_process and svc_process_bc to call pc_release after sending
> the reply instead of before.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/sunrpc/svc.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index b1fab3a6954437cf751e4725fa52cfc83eddf2ab..103bb6ba8e140fdccd6cab124e7=
15caeb41bb445 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1426,8 +1426,6 @@ svc_process_common(struct svc_rqst *rqstp)
> =20
>  	/* Call the function that processes the request. */
>  	rc =3D process.dispatch(rqstp);
> -	if (procp->pc_release)
> -		procp->pc_release(rqstp);
>  	xdr_finish_decode(xdr);
> =20
>  	if (!rc)
> @@ -1526,6 +1524,14 @@ static void svc_drop(struct svc_rqst *rqstp)
>  	trace_svc_drop(rqstp);
>  }
> =20
> +static void svc_release_rqst(struct svc_rqst *rqstp)
> +{
> +	const struct svc_procedure *procp =3D rqstp->rq_procinfo;
> +
> +	if (procp && procp->pc_release)
> +		procp->pc_release(rqstp);
> +}
> +
>  /**
>   * svc_process - Execute one RPC transaction
>   * @rqstp: RPC transaction context
> @@ -1533,7 +1539,7 @@ static void svc_drop(struct svc_rqst *rqstp)
>   */
>  void svc_process(struct svc_rqst *rqstp)
>  {
> -	struct kvec		*resv =3D &rqstp->rq_res.head[0];
> +	struct kvec			*resv =3D &rqstp->rq_res.head[0];

Commas and Tabs - you can never really have enough of them, can you?

>  	__be32 *p;
> =20
>  #if IS_ENABLED(CONFIG_FAIL_SUNRPC)
> @@ -1565,9 +1571,12 @@ void svc_process(struct svc_rqst *rqstp)
>  	if (unlikely(*p !=3D rpc_call))
>  		goto out_baddir;
> =20
> -	if (!svc_process_common(rqstp))
> +	if (!svc_process_common(rqstp)) {
> +		svc_release_rqst(rqstp);
>  		goto out_drop;
> +	}
>  	svc_send(rqstp);
> +	svc_release_rqst(rqstp);
>  	return;

Should we, as a general rule, avoid calling any cleanup function more
than once?  When tempted, we DEFINE_FREE() a cleanup function and
declare the variable appropriately.

Though in this case it might be easier to:

  if (svc_process_common(rqstp))
       svc_send(rqstp);
  else
       svc_drop(rqstp);
  svc_rlease_rqst(rqstp);
  return;

svc_process_bc() is a little more awkward.

But in general, delaying the release function until after the send seems
sound, and this patches appears to do it corretly.

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


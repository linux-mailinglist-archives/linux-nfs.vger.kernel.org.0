Return-Path: <linux-nfs+bounces-11369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26654AA4205
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 06:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31909C0033
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD671B21BF;
	Wed, 30 Apr 2025 04:54:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3B10F1;
	Wed, 30 Apr 2025 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745988844; cv=none; b=Y/Ho74c1uDo8GN18ELc1EVUUDFFXC1yd9HSPt4K+bapGNOiDcOH5xBsZrUzJY2yGTo6u+AFPMl8cUoFGEJwvESFOSaLayOPMSER05FIQDm2lN4iszopZiPQP18dInFCts8gVFLWCN/VGrxNJgb+Qp+duTix4PVQThGoV2mA+HSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745988844; c=relaxed/simple;
	bh=DP/TCRvjNddrF0jB+aH3+vJQ4re7mA8SAztgvsnODac=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=D0qS0jAtyg+ZgUfvDujRySrMgmBdf8aWrfJNPXCmtsuY7VlOWcZNGYQ5Y27ytf8/RMiSW3zN7DKzt8bpaVAZXMKweuxHG7VTdgrP9zLkMEKOqX/5kY1eQBG2NFz1r1wmjjaBKxQl9F6xrfduiT1+qX0H05zKsGiCL/p7knKvoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9zSH-005Hxf-D2;
	Wed, 30 Apr 2025 04:53:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 04/14] sunrpc: Replace the rq_pages array with
 dynamically-allocated memory
In-reply-to: <20250428193702.5186-5-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>,
 <20250428193702.5186-5-cel@kernel.org>
Date: Wed, 30 Apr 2025 14:53:56 +1000
Message-id: <174598883695.500591.9691141765386746394@noble.neil.brown.name>

On Tue, 29 Apr 2025, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> As a step towards making NFSD's maximum rsize and wsize variable at
> run-time, replace the fixed-size rq_vec[] array in struct svc_rqst
> with a chunk of dynamically-allocated memory.
>=20
> On a system with 8-byte pointers and 4KB pages, pahole reports that
> the rq_pages[] array is 2080 bytes. This patch replaces that with
> a single 8-byte pointer field.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h        |  3 ++-
>  net/sunrpc/svc.c                  | 34 ++++++++++++++++++-------------
>  net/sunrpc/svc_xprt.c             | 10 +--------
>  net/sunrpc/xprtrdma/svc_rdma_rw.c |  2 +-
>  4 files changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index e83ac14267e8..ea3a33eec29b 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -205,7 +205,8 @@ struct svc_rqst {
>  	struct xdr_stream	rq_res_stream;
>  	struct page		*rq_scratch_page;
>  	struct xdr_buf		rq_res;
> -	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
> +	unsigned long		rq_maxpages;	/* num of entries in rq_pages */
> +	struct page *		*rq_pages;
>  	struct page *		*rq_respages;	/* points into rq_pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
>  	struct page *		*rq_page_end;  /* one past the last page */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 8ce3e6b3df6a..682e11c9be36 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -636,20 +636,25 @@ svc_destroy(struct svc_serv **servp)
>  EXPORT_SYMBOL_GPL(svc_destroy);
> =20
>  static bool
> -svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
> +svc_init_buffer(struct svc_rqst *rqstp, const struct svc_serv *serv, int n=
ode)
>  {
> -	unsigned long pages, ret;
> +	unsigned long ret;
> =20
> -	pages =3D size / PAGE_SIZE + 1; /* extra page as we hold both request and=
 reply.
> -				       * We assume one is at most one page
> -				       */
> -	WARN_ON_ONCE(pages > RPCSVC_MAXPAGES);
> -	if (pages > RPCSVC_MAXPAGES)
> -		pages =3D RPCSVC_MAXPAGES;
> +	/* Add an extra page, as rq_pages holds both request and reply.
> +	 * We assume one of those is at most one page.
> +	 */
> +	rqstp->rq_maxpages =3D svc_serv_maxpages(serv) + 1;

The calculation in svc_serv_maxpages() already allows for both request
and reply.  I think the "+ 1" here is wrong.

NeilBrown


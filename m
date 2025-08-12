Return-Path: <linux-nfs+bounces-13610-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F68CB23CF3
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 02:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234D617BAD2
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Aug 2025 00:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF10BA48;
	Wed, 13 Aug 2025 00:04:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610B2C0F87
	for <linux-nfs@vger.kernel.org>; Wed, 13 Aug 2025 00:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043496; cv=none; b=YPwGA+45R9xrDN9cYtEzyd88ZMe0WwtybeXHnwWBFPxFTCF69O3IOyRK7wJuekCDFkeixIhjgK0psaEhnGOT+CDO2PX5BPT0N6EzcgTTr9U2GDJiBeZzPBgyNZqq9M0I2vqpYY6D99B9fgsWiHm3RjNcWfLT6hVlJlXvSGrZlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043496; c=relaxed/simple;
	bh=0JdL0dI2k+fxtGRDQICsRVfCWQgNKrUopN3GTPmaSDY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=H8n71/zXhc67TICAkG3pyXYoYDMz1NDKgc64TKbhNYfjIG+EJwYZ4387Bc2j1m2s2HWp9NY/1jqtooC1SjUq2Hh13z25v/ZP+S3tKjcKydLyHOoCHOnSHqofwSJBQJUOJUHehKxGVNgKGuYLD25Z8kWyE1vYBg0S3OYYmoI7ofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulyka-005Y13-LI;
	Tue, 12 Aug 2025 23:49:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 Dai.Ngo@oracle.com, tom@talpey.com
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with
 nlm_lck_denied_grace_period
In-reply-to: <20250812160317.25363-2-okorniev@redhat.com>
References: <20250812160317.25363-1-okorniev@redhat.com>,
 <20250812160317.25363-2-okorniev@redhat.com>
Date: Wed, 13 Aug 2025 09:49:54 +1000
Message-id: <175504259409.2234665.8366862194585275180@noble.neil.brown.name>

On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> When nfsd is in grace and receives an NLM LOCK request which turns
> out to have a conflicting delegation, return that the server is in
> grace.
>=20
> Reviewed-by: Jeff Layton <jlayton@redhat.com>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/lockd/svc4proc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 109e5caae8c7..7ac4af5c9875 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm=
_res *resp)
>  	resp->cookie =3D argp->cookie;
> =20
>  	/* Obtain client and file */
> -	if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
> -		return resp->status =3D=3D nlm_drop_reply ? rpc_drop_reply :rpc_success;
> +	resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file);
> +	switch (resp->status) {
> +	case 0:
> +		break;
> +	case nlm_drop_reply:
> +		if (locks_in_grace(SVC_NET(rqstp))) {
> +			resp->status =3D nlm_lck_denied_grace_period;

I think this is wrong.  If the lock request has the "reclaim" flag set,
then nlm_lck_denied_grace_period is not a meaningful error.
nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
getting a response to an upcall to mountd.  For NLM the request really
must be dropped.

At the very least we need to guard against the reclaim flag being set in
the above test.  But I would much rather a more clear distinction were
made between "drop because of a conflicting delegation" and "drop
because of a delay getting upcall response".
Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm4
(and ideally nlm2) handles appropriately.

NeilBrown


> +			return rpc_success;
> +		}
> +		return nlm_drop_reply;
> +	default:
> +		return rpc_success;
> +	}
> =20
>  	/* Now try to lock the file */
>  	resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock,
> --=20
> 2.47.1
>=20
>=20



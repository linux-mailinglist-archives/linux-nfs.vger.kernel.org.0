Return-Path: <linux-nfs+bounces-22641-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pkhSHYluMWq4jAUAu9opvQ
	(envelope-from <linux-nfs+bounces-22641-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 17:40:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 002FF691490
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 17:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lmH74f3/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22641-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22641-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 193DC304E410
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5264418FC;
	Tue, 16 Jun 2026 15:29:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590782E1F0E;
	Tue, 16 Jun 2026 15:29:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623758; cv=none; b=cUtZihNB35p6+PDXWL8CLjtPkU6wQThv+jyPeUjEJB50LWjosEWQac6lQLdWhCmmsn5wI1j2HNv/ojry9mMG+h3cAIFaNcGCh2HtY0g053usOoPOQ2JOtk3eJKoScITu/pFbS23Na5XHMGwunvJaC1JJAO/5OueM87R9JrPJH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623758; c=relaxed/simple;
	bh=b3j+8Gqr1eKXe+nRU/7Lfkqdj4ywh3U9VEwDwhRuf3Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+tT85CzZgeW7hXGDUm+k9HUoZHU4AatUF3MOIWA8jDeuRsDSlvboVIXxMmC7+LjfABbnDbj9UOwdIybMebheY6H/rMUq553lTPRO9eOpp0QSV+OyVcF7WC8a8SfEC9HeX1unWqxcuFm+6EiaSQHdS+dGcID2Hh6U+fJbyvIF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmH74f3/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E0D1F00A3D;
	Tue, 16 Jun 2026 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623755;
	bh=u9ajj7vorYtKWOz2AxvgqdXkzrZ0eI4rdz7Vi9ieD0A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lmH74f3/luKoije11e2eHZmw9Vr5vcaIP7g0Sl66bF3w/j3/dVCMDO9+4Q3bHGiGL
	 X5mYX58b6lq9iwaB0AnBkzQteA+60bd14OpExY9TAG6rz7QY+m/eDyORkJS6XgEcVQ
	 0cqtGZM5a1z0AJV8HOdb2LQhH9keu4zkiEp6PpLTXnQap8RvFM+Vpt5Rz1q8ITNlKK
	 JEMwG9POFZpp8wMR8Xm9iR51thDR6brKH7a2yXP444WEZ93cjffSBnXTaekg0ZWjIQ
	 k0loySBruIc4OLq213urYCnKYXXLs63av4BSk8HcntiM13z2FMjVySYK5E6uxrQiO+
	 O/PdJn9C11c8g==
Message-ID: <7ee3bcfdd6126c93cbb1c219bf601182b95c10d9.camel@kernel.org>
Subject: Re: [PATCH v2 6/7] nfs: Optimize direct I/O to use folios for
 requests
From: Trond Myklebust <trondmy@kernel.org>
To: Pranjal Shrivastava <praan@google.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Christoph Hellwig
	 <hch@infradead.org>, Shivaji Kant <shivajikant@google.com>
Date: Tue, 16 Jun 2026 11:29:13 -0400
In-Reply-To: <20260616134000.2733403-7-praan@google.com>
References: <20260616134000.2733403-1-praan@google.com>
	 <20260616134000.2733403-7-praan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22641-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:praan@google.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trondmy@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 002FF691490

On Tue, 2026-06-16 at 13:39 +0000, Pranjal Shrivastava wrote:
> Optimize nfs_direct_extract_pages() to group contiguous pages from
> the
> same folio into single nfs_page structures. This effectively migrates
> NFS Direct I/O from being page-based to being folio-based.
>=20
> Reduce the number of nfs_page allocations and subsequent iterations
> by utilizing nfs_page_create_from_folio() to create aggregated
> requests.
>=20
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
> =C2=A0fs/nfs/direct.c | 47 +++++++++++++++++++++++++++++++++++++---------=
-
> =C2=A01 file changed, 37 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index e2a93cfb6c72..ddc6b27f5315 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -194,23 +194,45 @@ static ssize_t nfs_direct_extract_pages(struct
> nfs_direct_req *dreq,
> =C2=A0		return result;
> =C2=A0
> =C2=A0	npages =3D (result + pgbase + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -	for (i =3D 0; i < npages; i++) {
> +	for (i =3D 0; i < npages; ) {
> +		unsigned int chunk_len, folio_offset;
> +		unsigned int nr_to_add =3D 1;
> =C2=A0		struct nfs_page *req;
> -		unsigned int req_len =3D min_t(size_t, result - bytes,
> PAGE_SIZE - pgbase);
> +		struct folio *folio;
> =C2=A0
> -		req =3D nfs_page_create_from_page(dreq->ctx,
> pagevec[i],
> -						pinned, pgbase,
> *pos,
> -						req_len);
> +		folio =3D page_folio(pagevec[i]);

I'm clearly missing something. The memory pointed to by these pages can
be any arbitrary user space (or kernel space) memory region. It could
be mapped device memory, for instance.

So why can you assume that page_folio() will resolve to a valid folio
here?


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com


Return-Path: <linux-nfs+bounces-22954-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vKsVLtbNRmqhdwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22954-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 22:45:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5C6FCCCA
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 22:45:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OGkWOZtk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22954-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22954-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA31300BC97
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE6E38944E;
	Thu,  2 Jul 2026 20:45:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDB3A7582
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 20:45:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025107; cv=none; b=jdjI7e1pqBw67ebfe5ovETAormxInekB7bugBFNPQJzjLqQtrUF7rIBE2OxHmCqQDpBOnumhjqM5Ng7tC0nFr0kx8UVeJ+s2QsAswwx7+Fvz/qPlMn3KCUh+z4fZ4ujaaRQbo+jflasB4m0nGz9Y+a/7HCi3cj0fbr23eDaO3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025107; c=relaxed/simple;
	bh=1pxlkmj4y45VqvpKjNkaDuYMWJGtHwV4sKxJ/kJkNUE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lL3+PaBwAWVHx2z3aO2Bqx3ULbP0+Hu/doskjDDd+ls+/lxfrFpSOfH6wTZCL9wyin5up4a+3L7xok6em/F6Zqd8AEcF1N3YZ8RDJvlFifvOTYDuop45dZ11KNTq+tiINw74/2hKMsxyWvD8Iu++t67Ze0iWZNYc57k0XbcNaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGkWOZtk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65041F000E9
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 20:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783025105;
	bh=7CikJ+MF87hrsKDKCcMN4/tKFVXjg+aZFHK9KZ9FaIE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=OGkWOZtkuHJEfBcnOdXWAkuC4wYYredJsBeX3eeng+KCOyr3uReNbY1Y9suRQiC0A
	 uch8qRlYwsThe169FElQTbHoRT+geHTXJItMRD0EYTgTtrhLeSBe2jcJlt6CCAjPxv
	 SllQ8/AMn97QMbtBI+5NM3wLJpR5TIh6Z8eMTrOAAjNe4TT2AIhR274GTQ0zfi52fj
	 2MW6lViAl4Obr0v5bHV0keh4YqLTyOhCndp7uF6GYCZPAtuDzMLWoSbGEMrvR0q2tC
	 gTkUE1lObqyQMnihUxTuBkl3H47QikQPpyXRBlm7mKCPx7eqQA9SH2ixGlvc7a9GDV
	 tjPAThQ48heEA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B2E15F40068;
	Thu,  2 Jul 2026 16:45:04 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jul 2026 16:45:04 -0400
X-ME-Sender: <xms:0M1Gap8W4IrZBCwoTk-CfQI8-B1zH5GF9k3lmnNJ7-qG6r3kq0LIHA>
    <xme:0M1GaohP3w2FvhBIHSUcgYVYGdZ-wNeMaTUrO9zOFwo7__lCU1h3MWMJ6hKcoCH60
    vZrKIg6gAJ1bj8HHSbl6M_mIGKh5wgBkwgXgLdSG9tamTM7Idt9koLk>
X-ME-Proxy-Cause: dmFkZTGpmMOnV4VYJnslrsNNFhfsxv7i516r1onPwbDWgshiYQO/ZE4yKYhe7KBFpp2xer
    h1EkWYiBQXp3xIjSvbyXL0XWuqwDkumprVUtUkfroOV4CXhOZ5rainm5Wsi5uiwm1xQuHm
    rkrcIF+lCUozdBM8UZdddkOfzXsufGc4vY3YxHReUM4vRcYig+MkQnUYNpfkxX1ENhM30V
    Cs2ipaKVwqvYDNepq7ALoodUS6yXzz6UbtddhHxXM0DjUCA2I0BOA01F3wBmTWIM7MwnMc
    +wHSzOXnoScu5+CrPtoLvruOCW0inMP9+NZY3x3yKOtlVIpInl6aK8CgwPc1pQsXgEzKPe
    WKL1dwgvHSLaP15Tdn14gtYY86bJBJbsdOMNY+EHbnwE4GxBm5EBMfng9O7nXjC5zQM4qw
    Oy9dh5QKrLNz7+XhBbU5ZQFhlNLnJ80HPN5d78txg3fpLjIO0lpQwq7bhIvsNLsOuAxgu1
    VXHCY8+ls/DfZaFH36wf5tnCkiEC46alKDSyCPBTaESowD7h7Yj4DSPabdZjC5eCYUXs/N
    6S0cTUC/5bYyeWKvLpqHPsdfP3T6Trq2l+DA3+IMC1CRwHwA09PsHDVOj3ccOVd1HPpwAh
    D+PAyp5M3shmkOvfHf6wdmQ4NhIbUC25v1jeKeNI0WCRoWpegayc8JCSBvpA
X-ME-Proxy: <xmx:0M1GalionwFoWRRo9SyUcLjARLqYXjMStYCRIJ4nWRbb7JlvKdGeCw>
    <xmx:0M1GaqI-661a5C0i-ciMHa-hStLVx-Nw8bYAVB6znV0sGvZAQx1QcA>
    <xmx:0M1GatBAmg5QqEg40cRk8jYyuMQVX0hwDQzHZl5OrvjoSMrJyy_Iwg>
    <xmx:0M1Gaig511CfNdP3tzV3MMY5QGRhxnZNfU8rcajjF9GT6XYoiAm4PQ>
    <xmx:0M1GatlTx5eYMRMxz4Ncsr6vPizskkqAOnFVuaf6gPCWohgeB84v1MXG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8D3D0780AB5; Thu,  2 Jul 2026 16:45:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJFl0k_2bwMR
Date: Thu, 02 Jul 2026 16:44:43 -0400
From: "Chuck Lever" <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Message-Id: <920c6ce7-fbb5-4651-afb6-1c025add5716@app.fastmail.com>
In-Reply-To: <20260702202409.1583677-3-cel@kernel.org>
References: <20260702202409.1583677-1-cel@kernel.org>
 <20260702202409.1583677-3-cel@kernel.org>
Subject: Re: [PATCH 6.18.y 3/3] nfsd: release layout stid on setlease failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22954-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,meta.com:email,oracle.com:email,app.fastmail.com:mid];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEC5C6FCCCA

Please note: The correct Author for this patch is "Chris Mason <clm@meta.com>"

On Thu, Jul 2, 2026, at 4:24 PM, Chuck Lever wrote:
> commit 30d55c8aabb261bc3f427d6b9aae7ef6206063f9 upstream.
>
> nfs4_alloc_stid() publishes the new stid into cl->cl_stateids via
> idr_alloc_cyclic() under cl_lock before returning to
> nfsd4_alloc_layout_stateid(). When nfsd4_layout_setlease() then
> fails, the error path frees the layout stateid directly with
> kmem_cache_free() without ever calling idr_remove(), leaving the
> IDR slot pointing at freed slab memory. Any subsequent IDR walker
> (states_show, client teardown) dereferences the dangling pointer.
>
> The correct teardown for an IDR-published stid is nfs4_put_stid(),
> which removes the IDR slot under cl_lock, dispatches sc_free
> (nfsd4_free_layout_stateid) to release ls->ls_file via
> nfsd4_close_layout(), and drops the nfs4_file reference in its
> tail.
>
> A second issue blocks that switch: nfsd4_free_layout_stateid()
> unconditionally inspects ls->ls_fence_work via
> delayed_work_pending() under ls_lock, but
> INIT_DELAYED_WORK(&ls->ls_fence_work, ...) currently runs only
> after the setlease call. On the setlease-failure path the
> destructor would touch an uninitialized delayed_work.
>
>     nfsd4_alloc_layout_stateid()
>       nfs4_alloc_stid()           /* idr_alloc_cyclic under cl_lock */
>       nfsd4_layout_setlease()     /* fails */
>         nfs4_put_stid()
>           nfsd4_free_layout_stateid()
>             delayed_work_pending(&ls->ls_fence_work)  /* needs INIT */
>             nfsd4_close_layout()  /* nfsd_file_put(ls->ls_file) */
>           put_nfs4_file()
>
> Fix by hoisting the ls_fenced / ls_fence_delay / INIT_DELAYED_WORK
> initialization above the nfsd4_layout_setlease() call, and replace
> the manual nfsd_file_put + put_nfs4_file + kmem_cache_free cleanup
> with a single nfs4_put_stid(stp).
>
> Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
> Cc: stable@vger.kernel.org
> Assisted-by: kres (claude-opus-4-7)
> Signed-off-by: Chris Mason <clm@meta.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> [ cel: drop fence_work init hoist absent from 6.18.y ]
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/nfsd/nfs4layouts.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 683bd1130afe..62762e43f810 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -256,9 +256,7 @@ nfsd4_alloc_layout_stateid(struct 
> nfsd4_compound_state *cstate,
>  	BUG_ON(!ls->ls_file);
> 
>  	if (nfsd4_layout_setlease(ls)) {
> -		nfsd_file_put(ls->ls_file);
> -		put_nfs4_file(fp);
> -		kmem_cache_free(nfs4_layout_stateid_cache, ls);
> +		nfs4_put_stid(stp);
>  		return NULL;
>  	}
> 
> -- 
> 2.54.0

-- 
Chuck Lever


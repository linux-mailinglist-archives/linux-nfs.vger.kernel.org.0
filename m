Return-Path: <linux-nfs+bounces-22851-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M4+cODX2PWpv9QgAu9opvQ
	(envelope-from <linux-nfs+bounces-22851-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 05:47:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A866C9F51
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 05:47:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=Np4ABYPG;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="b m74Cn+";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22851-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22851-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1076D3032F7C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5202E612E;
	Fri, 26 Jun 2026 03:46:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30981233933;
	Fri, 26 Jun 2026 03:46:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782445618; cv=none; b=L75HGtppRThxdNb0aoYfcbcPfkIKErURswkimZObmsGPEBLbcMiNpQj68pTcagCSpURvxykx/6YWCl0ryVpC/ODuwdkTb0FLMvAt2ZvFQRkJpKhFS2m6wSX8sV4l9BzmALTAb85LYRW/F7wPit3sbaK/89MyyFH/fxEpeN5RU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782445618; c=relaxed/simple;
	bh=7tRUce5twtKuJLGfDIHGuYvPNq7uDsECCnHdZOTjDh0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oixk9BlADALHx1mNYfTH5gz/REbPKji6LWjSXwR2bWJw/F/yLkXr9NIoIm24R9kmRZ4NGbto9Ao4c2k9dt23x5nDm1W2CCKQqv4suUOj9e+R7HpAQ1Lg3wxiDHDluxXNHZlQju+kPivWeI1M5pAznD9Teno9/McWeFoua/X7Koo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Np4ABYPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bm74Cn+c; arc=none smtp.client-ip=202.12.124.150
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D6841D0007A;
	Thu, 25 Jun 2026 23:46:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 25 Jun 2026 23:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782445615; x=1782532015; bh=ZEZvK79H95SfqIPGAvGC0awX9/IKWU1aGGV
	pk0EZQ3A=; b=Np4ABYPGFfSIGh75CwRkHwAnN3lgYGksoiobyaIh5lQ9HYLj4BS
	kG8rXdtvEI8Xgr95U3EdeV1vq/Wm5yvCo0uJ+cq8KdpnmJaUm5AmX4Qnv7F/jiqG
	tAk+TNxrE9RkS9FtBGebyHX+W5Hbm23YIuau8Dxu2HMS/SHpchlRQ7uEvQZLm1TR
	fIRLYWO+V4yUUEvc665JLqpSYVE1/YhaLUwHLrZYlfZ1CcfONnud6Y+wS68jg1/a
	yf0MM00CxhcJ4941eM0yWWgXY/ZU8+GSQUSQe12ul5BuhKA7y6kufBYaHTcgk1E0
	1ZtNQWA+tIrrVCCGijfqQUGg2/jhU82tElA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782445615; x=
	1782532015; bh=ZEZvK79H95SfqIPGAvGC0awX9/IKWU1aGGVpk0EZQ3A=; b=b
	m74Cn+cPbh98qUYo2IUfT3Frilwo6lAA89L7v1C0Tll1LROAk3OCKGmy9JnR/nj1
	3TZaUsa4rIlqNaedgHHxRptVJQupzJDT6oRTWbeQ4V0jVZ7pnRc+rl0I2h4A02Ke
	+CKb3qJ+1XFLElx7gYypg8TiyxIT4eNwfDJAttuCsnq/fs64AlivIPlBMNqkRvxV
	8XDUKs3tsEoqGe1hxAp5iFj60FPPP6Gq/BBxsPs/nVB+OJVYZJeJGLL/dfymq+Uy
	lDtiweoyjVtWUDIJg/BF0z0N4JykY4F7Jtr49t3ibDcXsZpKOVUzpu+rRQ5Bke6H
	19NA25LXJtB/UChX41kHg==
X-ME-Sender: <xms:L_Y9asUzldMWgzSes-0Oni3lSV-Fo0ebopTX-UsEvf0cJa12kHamQA>
    <xme:L_Y9ali-MsBxTxf3HKwo21ojeqDYePe65KycMjufI6oc1onh1Ham7zzywk3ApES4x
    AXFc0LUO3KL1dPxHK4g6n3gUNJMW33I-ugEYNZclMLJzt0aUw>
X-ME-Received: <xmr:L_Y9akpLPrfmBu1IfTb-KMXECkmtfFLJKHgiSgd6a8f6SPvTwom3AFQqdQS0xqXRh0dvWl2XNNKIw7GU9kjf8Jv1jnw09X0>
X-ME-Proxy-Cause: dmFkZTFBpAzxouST4EGSfnUDpxpcIJdpffWzauY4DgA7DdIT5DYCnAvrVK7O/UCWszNkwg
    CfctknbTdPok2MOdtut7zf9ZdFb/XS87v8CPvw+oteLcGsemUz38TjzK6VCH0p+J7Ojpuv
    gItctLDwr3PC2k63Vh8gQ+UlAjxfFnGCTwr7EvSjh1coQl49sVh3FFTEJsv37vu70qldF7
    fVEdC3dIifmplebcMNlX3sI2cGtdHB0V49+OEQt7bcTIfWDugLIcc5tC+/6GQK4b9iaCPl
    P//Mx6r0JvWLbYzeDBuB3Ea/jbDkw0WqVnUKiu1pLKZjU1EFeIvCdj+eveHEuegWTm13Mf
    +HpmiQaKzCw76euQlMQ0kgq/cshzrjC8pj2HxBWT4fXNj+7428NK72igBdU5PtjKsQ51J6
    /o+8ArCq44/+pOtcum8f927+jfxsQ+oi23gOQpytz7DLvVD0zS5ztgOu+v6Jy/UzjYS44a
    rWfkq6AEHyr7P/+24z0alG955+1KkEL4ZEBCfGB4UHnwdwAEZHJG7nZcjumC9rZ/EM1pEn
    btgblOeFJUxLOe96YmIsKpywq7syVYjcp/KD1Hmt0zh35LK66idjlmvA0XCMrJN366t95n
    Do95u1yL4v0YwQTPRbl7if8Tx4WABKiAKI9g9X/hhsp4anBiev8MNETUuR2g
X-ME-Proxy: <xmx:L_Y9arFABKPCyc5eIDkrIBzaEMx92K0Q9dzJ-PTD8Tn61SYdOqYlJA>
    <xmx:L_Y9ap6NISUd9O0t8nUdalVlYqxnuD6LaUW6zyqcp_yuYfvqXJ7m7Q>
    <xmx:L_Y9ajcn-f1Ns8eI8idRQbz7H4t-_FCNfIdnG8w5iOiWjzdB-9zhfA>
    <xmx:L_Y9ak5Vq0iu9_EdvSAOLtC-7A4ZUznyDNvY9lEZwdOJjATzTXaAhg>
    <xmx:L_Y9anuzYMlAlSqhscU4kb0pPiDhI4PGI_K-BJze7BOMvS7_U15DvTdn>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 23:46:52 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <cel@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Andy Adamson" <andros@netapp.com>, "Chris Mason" <clm@meta.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 1/3] nfsd: fix cpntf publish race in nfs4_init_cp_state
In-reply-to: <20260624-nfsd-testing-v1-1-b8853eb22e45@kernel.org>
References: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
  <20260624-nfsd-testing-v1-1-b8853eb22e45@kernel.org>
Date: Fri, 26 Jun 2026 13:46:49 +1000
Message-id: <178244560927.27465.13286940935760902704@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22851-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:cel@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,vger.kernel.org:from_smtp,messagingengine.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43A866C9F51

On Thu, 25 Jun 2026, Jeff Layton wrote:
> From: Chris Mason <clm@meta.com>
>=20
> nfs4_alloc_init_cpntf_state() splits IDR publication and cp_list
> linkage across two separate s2s_cp_lock critical sections. The first
> installs the new nfs4_cpntf_state into nn->s2s_cp_stateids and then
> assigns cs_type =3D NFS4_COPYNOTIFY_STID; the second acquires the lock
> again to list_add() the entry onto p_stid->sc_cp_list. Between the
> two, the entry is reachable by so_id with the correct cs_type, but
> cp_list is still {NULL, NULL} from kzalloc.
>=20
> A second NFSv4.2 request can race in that gap:
>=20
>     CPU 0                              CPU 1
>     -----                              -----
>     nfs4_alloc_init_cpntf_state()
>       nfs4_init_cp_state()
>         spin_lock(&s2s_cp_lock)
>         idr_alloc_cyclic()
>         spin_unlock(&s2s_cp_lock)
>       cps->cp_stateid.cs_type =3D
>           NFS4_COPYNOTIFY_STID
>                                        nfsd4_offload_cancel()
>                                          find_async_copy() -> NULL
>                                          manage_cpntf_state(clp!=3DNULL)
>                                            spin_lock(&s2s_cp_lock)
>                                            idr_find() -> cps
>                                            cs_type check passes
>                                            _free_cpntf_state_locked()
>                                              refcount_dec_and_test
>                                              list_del(&cps->cp_list)
>       spin_lock(&s2s_cp_lock)             /* {NULL,NULL} -> oops */
>       list_add(&cps->cp_list, ...)
>=20
> The so_id returned to the client by COPY_NOTIFY is echoed back as
> cnr_stateid, so any authenticated NFSv4.2 client can drive
> OFFLOAD_CANCEL into manage_cpntf_state() against an entry still in
> the window. list_del() on a zeroed list_head dereferences NULL and
> oopses the server.
>=20
> Fold cs_type assignment and the list_add() onto p_stid->sc_cp_list
> into the same s2s_cp_lock critical section that runs idr_alloc_cyclic.
> A concurrent manage_cpntf_state() now either fails idr_find() (entry
> not yet visible) or observes a fully linked cp_list. Initialize
> cp_list with INIT_LIST_HEAD() after allocation, and switch
> _free_cpntf_state_locked() to list_del_init() so that any stale
> unlink on an already-unlinked entry is a benign no-op rather than a
> NULL dereference. nfs4_init_copy_state() passes NULL for p_stid and
> skips the list_add branch, preserving NFS4_COPY_STID semantics.
>=20
> Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a4398dc861a5..b8946db3ebaa 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -944,7 +944,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *c=
l, struct kmem_cache *sla
>   * Create a unique stateid_t to represent each COPY.
>   */
>  static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
> -			      unsigned char cs_type)
> +			      unsigned char cs_type, struct nfs4_stid *p_stid)
>  {
>  	int new_id;
> =20
> @@ -954,19 +954,37 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, co=
py_stateid_t *stid,
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&nn->s2s_cp_lock);
>  	new_id =3D idr_alloc_cyclic(&nn->s2s_cp_stateids, stid, 0, 0, GFP_NOWAIT);
> -	stid->cs_stid.si_opaque.so_id =3D new_id;
> -	stid->cs_stid.si_generation =3D 1;
> +	if (new_id >=3D 0) {
> +		stid->cs_stid.si_opaque.so_id =3D new_id;
> +		stid->cs_stid.si_generation =3D 1;
> +		/*
> +		 * Publish cs_type and link onto the parent stid's
> +		 * sc_cp_list inside the same critical section that
> +		 * installed the entry into nn->s2s_cp_stateids. A
> +		 * concurrent manage_cpntf_state() either fails the
> +		 * idr_find() (entry not yet visible) or observes a
> +		 * fully linked cp_list, so list_del_init() in
> +		 * _free_cpntf_state_locked() is always well-defined.
> +		 */

This comment seems excessive.  The explanation certainly should be in
the commit message, and is probably there already.  It doesn't need to
be here too.

> +		stid->cs_type =3D cs_type;
> +		if (p_stid) {

I would rather this switched on "cs_type =3D=3D NFS4_COPYNOTIFY_STID"

A substantially simpler solution would be to *not* pass cs_type to
nfs4_init_cp_state() so the type remains initialised to zero, which is
invalid.
Anything which finds that stateid will ignore it because they already
check the type.
Then callers of nfs4_init_cp_state() set the type themselves.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f4d12dbcf97b..7a8010f450ea 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -943,8 +943,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl,=
 struct kmem_cache *sla
 /*
  * Create a unique stateid_t to represent each COPY.
  */
-static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
-			      unsigned char cs_type)
+static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid)
 {
 	int new_id;
=20
@@ -960,13 +959,16 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy=
_stateid_t *stid,
 	idr_preload_end();
 	if (new_id < 0)
 		return 0;
-	stid->cs_type =3D cs_type;
 	return 1;
 }
=20
 int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
 {
-	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID);
+	if (nfs4_init_cp_state(nn, &copy->cp_stateid)){
+		stid->cs_type =3D NFS4_COPY_STID;
+		return 1;
+	}
+	return 0;
 }
=20
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
@@ -979,10 +981,11 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(st=
ruct nfsd_net *nn,
 		return NULL;
 	cps->cpntf_time =3D ktime_get_boottime_seconds();
 	refcount_set(&cps->cp_stateid.cs_count, 1);
-	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
+	if (!nfs4_init_cp_state(nn, &cps->cp_stateid))
 		goto out_free;
 	spin_lock(&nn->s2s_cp_lock);
 	list_add(&cps->cp_list, &p_stid->sc_cp_list);
+	stid->cs_type =3D NFS4_COPYNOTIFY_STID;
 	spin_unlock(&nn->s2s_cp_lock);
 	return cps;
 out_free:


Maybe not a "Better" solution, I'm not sure.  But certainly "simpler".
NeilBrown



> +			struct nfs4_cpntf_state *cps =3D
> +				container_of(stid, struct nfs4_cpntf_state,
> +					     cp_stateid);
> +
> +			list_add(&cps->cp_list, &p_stid->sc_cp_list);
> +		}
> +	}
>  	spin_unlock(&nn->s2s_cp_lock);
>  	idr_preload_end();
>  	if (new_id < 0)
>  		return 0;
> -	stid->cs_type =3D cs_type;
>  	return 1;
>  }
> =20
>  int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
>  {
> -	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID);
> +	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID, NULL);
>  }
> =20
>  struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
> @@ -977,13 +995,17 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(=
struct nfsd_net *nn,
>  	cps =3D kzalloc_obj(struct nfs4_cpntf_state);
>  	if (!cps)
>  		return NULL;
> +	/*
> +	 * Initialize cp_list so any stale unlink (e.g. on an
> +	 * entry that never reached its parent's sc_cp_list)
> +	 * degrades to a benign self-unlink via list_del_init().
> +	 */
> +	INIT_LIST_HEAD(&cps->cp_list);
>  	cps->cpntf_time =3D ktime_get_boottime_seconds();
>  	refcount_set(&cps->cp_stateid.cs_count, 1);
> -	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
> +	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID,
> +				p_stid))
>  		goto out_free;
> -	spin_lock(&nn->s2s_cp_lock);
> -	list_add(&cps->cp_list, &p_stid->sc_cp_list);
> -	spin_unlock(&nn->s2s_cp_lock);
>  	return cps;
>  out_free:
>  	kfree(cps);
> @@ -7854,7 +7876,7 @@ _free_cpntf_state_locked(struct nfsd_net *nn, struct =
nfs4_cpntf_state *cps)
>  	WARN_ON_ONCE(cps->cp_stateid.cs_type !=3D NFS4_COPYNOTIFY_STID);
>  	if (!refcount_dec_and_test(&cps->cp_stateid.cs_count))
>  		return;
> -	list_del(&cps->cp_list);
> +	list_del_init(&cps->cp_list);
>  	idr_remove(&nn->s2s_cp_stateids,
>  		   cps->cp_stateid.cs_stid.si_opaque.so_id);
>  	kfree(cps);
>=20
> --=20
> 2.54.0
>=20
>=20



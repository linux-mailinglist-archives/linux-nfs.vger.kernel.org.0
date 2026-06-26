Return-Path: <linux-nfs+bounces-22852-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +0WqJFr8PWro9wgAu9opvQ
	(envelope-from <linux-nfs+bounces-22852-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 06:13:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E96CA118
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 06:13:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=fShDe+KK;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="D fFqfmj";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22852-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22852-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7791317EF94
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F613002A9;
	Fri, 26 Jun 2026 04:02:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B92384CE4;
	Fri, 26 Jun 2026 04:02:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782446561; cv=none; b=jOkIxxhHC29hB8VDfcbBUczbiV3cDQozEcTlVoJFM019XMaNxLWU77Of6g154giT7boH7hvg8RHyo63jD1Gd8BI1vwS7vu9AZVmSA3Zz0iQaoNhWyvmXNYgi91WyXBqrprZ7n9Dk3yaQCkYs3XS1vJkZi8m32vMkdSI6PAjdvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782446561; c=relaxed/simple;
	bh=Au4ZI9p9TCB7E2vFE5/gqn0YCEGUKAME17+ib055OqA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oMSoDTnaMk6+W6NNNzh1UNV9wUPUAScKKHI37C2R13b2zNK68ZOOPSL9cUibwJCLfhzdaPN9XtpyQy8WdBnHEKo34vGtR6CaE4TMyX+S77op+UkK89jVo4KKZA2U+gfCyzfRG0LK3oKNd5VAgEAYsS+418jUwrDM7DH38npGOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fShDe+KK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfFqfmjJ; arc=none smtp.client-ip=202.12.124.150
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 288561D00067;
	Fri, 26 Jun 2026 00:02:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 00:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782446559; x=1782532959; bh=XVkcH1niMjxEYz/hmXilgEIDEBazfqt4C1T
	byh9N0AM=; b=fShDe+KK02c5ny9RzR2B1npHmys6Y25u9mm1ZFyD3qNPPxWJLnn
	Ko5Kt3AGL7bEzWA5Cdftj5PuKmDEBY+k6pqz0ykGl6MyIR1MF+q2HcNBFSVzBwS6
	UlzGWl7HPLisTfm02/AihyCv8m0zA52/dKHHYh3kvbRJtkZm/2CoSJ6/AhZvIoy7
	w3DvfXk63vjyDtgOqNtq1Qz79g9ZmxbrZXEJE0wUXCPCH1HrvQ19lWPhRgNT+/CY
	JhRUtSgnw2QsJ7fls9rWpxChanZmWpZvyZjX6AzuSkg4J/GcHwXGYAPOI+qoueGO
	KXnJl+50VBGgJbuw20NBFBmmZ6CKjooP31Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782446559; x=
	1782532959; bh=XVkcH1niMjxEYz/hmXilgEIDEBazfqt4C1Tbyh9N0AM=; b=D
	fFqfmjJHzf7N+yWw42sXo+uXPfi6NxsfOeUGSFPTCNEuo6YPlTedU0l2czZ8PqvO
	5fWCeMCcdVzmPTLNxngT29TF7f8CYS/8IQS6BV1rXHjndijX/YH8b02QaRZ8M1wf
	JfVAtCo/4lohxRMa0LXpxUStfDOuUERjnoaad//D9WjrKc+f8L6dZw90ZYeYmfU7
	ZYYohuu0jwXIeohOqtmq7DugFcTWud2hhGjnxslQUsFwWedLiTdI/kwb6iF6FxEj
	ipSF0YuJvjje8w7NBCkDszctEnTM0Mx+rLS11KKUNyaa9kMovFG/oU9lqFXfDzIi
	6eMZS/SYxLomeSl61Tyiw==
X-ME-Sender: <xms:3vk9ambbc4j0mRFWxpPSsp01vdg01Vw7HZsBa6hj-MXADojppBg7Wg>
    <xme:3vk9auXDBvSdguwPuOARb6sEEsI4tMbO_04tskiAWqJzBAtXvbH3_z94Oqd6EkQ4c
    eTSFePsB4_1oIV7yeqz7hjwgVTeD8d98AIW6pLhr_gM2xnyQw>
X-ME-Received: <xmr:3vk9alNWfan7Z3CJBd5mCyU9BdASAN_TK-hVwdJJxFXc5EinCZn6Ifhp2rkAh0UUwO_eUDy3ELyYwtQyNAYRNOBTFlHJzlc>
X-ME-Proxy-Cause: dmFkZTGEx+fsRijfZgU7OvAtag+l6Fd3/E07guWJAJVkyCofXWDtrLKkteh1oml4Eg+G7Q
    FFhDHgXJEk28U+kM/c32m2t3G8/8P9yxOteJs1kC/Ov4fEFr8+PZYE7PuV2o3PiztUTdxh
    npI5rgVPqFhthtNpi/oA0Ip+Ftp2oLkxiYhjyEDlL7LmordFEVqBYxH9NCOVczrfvH4Smt
    Rh3mgDH9Rvq4KiNsMgg4MbMs0qF/IjAlfSRhrX6jDae3eS4clpRqCFlPBv/u1c1UvKW/pc
    v3R6lGfWLpsTGC1mhzogrRce0Vbqhzvu5FHMHUh9H9+47l/o1DLGG4Kz++LUB5rtseY8aX
    FhRWC0hbAhjMqMAxf3N35ambK7U7wS867Sr6+byvboT/AeZQwzqtgx9x2ciSSXvnAdWDJm
    B1zkOq/PVdcSzz/TQm4uR6JLgJiCM37kw8xOzSaHgWnjqZgS3Pd7wWaRk8lvl556SwK7Gw
    8TbEziOY7LOF2s5kAXbwpxxJ3r0lpUKTsWp8SEDgSA11A8MMh+MMeQ3KO1mL5ZY+7Inttz
    AukgUx0uVWitkWvg9Aobfw5vk0mngBaA/wBTzar687lTCyqMAc4Bebexq58adqkNYEtLTM
    qe0b/SBHHbgRRtskkPg5Ltvr6z4g0adKa7AL8JpaAL2s15vcvSdLBJtI6byw
X-ME-Proxy: <xmx:3vk9aoYJEmZ5zCobEiTn-YjAGqg6YXh-pxh3HJMwRIWAiL_xJcgf8w>
    <xmx:3vk9ak9uy26vXljP3S4BsA3ewAOsjvYLuFoLIrlcsdO7jNaIkaBexg>
    <xmx:3vk9apTYWJxn1Gcg3SyM_3SkI06LkEuKbjRK0gSAMuVjDO8W8oUmIg>
    <xmx:3vk9audnf9iQ51mhhRisogg1ZwJshsD0C1XltA14ba9DqJ4_IAF8Fg>
    <xmx:3_k9ahBruOAEAc0nBRf-40rP0QcjAgud72aKTqH0aUK3NNPVLM7iKzSO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 00:02:35 -0400 (EDT)
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
Subject: Re: [PATCH 2/3] nfsd: fix UAF in cpntf statelist drain
In-reply-to: <20260624-nfsd-testing-v1-2-b8853eb22e45@kernel.org>
References: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
  <20260624-nfsd-testing-v1-2-b8853eb22e45@kernel.org>
Date: Fri, 26 Jun 2026 14:02:33 +1000
Message-id: <178244655384.27465.3970721725119073229@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22852-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:from_mime,messagingengine.com:dkim,meta.com:email,brown.name:replyto,brown.name:email,noble.neil.brown.name:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA8E96CA118

On Thu, 25 Jun 2026, Jeff Layton wrote:
> From: Chris Mason <clm@meta.com>
>=20
> nfs4_free_cpntf_statelist() drains a parent stid's sc_cp_list by
> repeatedly taking the first entry and calling
> _free_cpntf_state_locked(), which only unlinks and frees the entry
> when refcount_dec_and_test() drops cs_count to zero.  When a
> concurrent holder has bumped cs_count via manage_cpntf_state(),
> the helper returns early and leaves the entry on sc_cp_list, so
> the drain re-decrements the same entry on the next iteration and
> burns the reference that belonged to that concurrent holder.
>=20
>     CPU 0                              CPU 1
>     -----                              -----
>     find_cpntf_state()
>       manage_cpntf_state(clp=3DNULL)
>         spin_lock(&nn->s2s_cp_lock)
>         refcount_inc(cs_count) 1->2
>         spin_unlock(&nn->s2s_cp_lock)
>       /* caller now owns a ref */
>                                        nfs4_free_cpntf_statelist()
>                                          spin_lock(&s2s_cp_lock)
>                                          iter 1: dec_and_test 2->1
>                                                  (no unlink/free)
>                                          iter 2: dec_and_test 1->0
>                                                  list_del + idr_remove
>                                                  kfree(cps)
>                                          spin_unlock(&s2s_cp_lock)
>     nfs4_put_cpntf_state(cps)
>       spin_lock(&s2s_cp_lock)
>       _free_cpntf_state_locked(cps)    /* cps is freed slab */
>=20
> The late put writes into the freed slab object's refcount_t, a
> KASAN-detectable use-after-free.
>=20
> Fix by rewriting the drain to unconditionally revoke each entry
> before dropping the parent's reference.  Walk sc_cp_list with
> list_for_each_entry_safe(), list_del_init() the entry, remove it
> from nn->s2s_cp_stateids, and only then drop the parent-owned
> reference via a new put_cpntf_state_unlinked_locked() helper
> that does refcount_dec_and_test() + kfree().  The drain now
> terminates in one pass per entry regardless of cs_count.
>=20
> Concurrent holders keep their own reference; their eventual
> nfs4_put_cpntf_state() reaches _free_cpntf_state_locked() on an
> entry the drain has already unlinked from sc_cp_list and from
> nn->s2s_cp_stateids.  _free_cpntf_state_locked() gates its
> list_del_init() and idr_remove() on !list_empty(&cps->cp_list);
> the drain's list_del_init() leaves cp_list self-linked, so the
> late put skips both calls and only the final refcount drop runs.
>=20
> Gating idr_remove() on the same check is required because
> idr_alloc_cyclic() may already have recycled the so_id for an
> unrelated cpntf entry by the time the late put runs; an
> unconditional idr_remove() would silently unhash that live entry
> and corrupt subsequent find_cpntf_state() lookups.
>=20
> Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Chris Mason <clm@meta.com>
> ---
>  fs/nfsd/nfs4state.c | 65 ++++++++++++++++++++++++++++++++++++++++++-------=
----
>  1 file changed, 52 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b8946db3ebaa..374155e57f3f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1025,17 +1025,58 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
>  	spin_unlock(&nn->s2s_cp_lock);
>  }
> =20
> +/*
> + * Drop the parent stid's reference on a cpntf entry that has already been
> + * removed from sc_cp_list and the s2s_cp_stateids IDR. If a concurrent ho=
lder
> + * still owns a reference (acquired viamanage_cpntf_state() before the unl=
ink),
> + * that holder's nfs4_put_cpntf_state() will perform the final free.
> + *
> + * The nn->s2s_cp_lock must be held!
> + */
> +static void put_cpntf_state_unlinked_locked(struct nfs4_cpntf_state *cps)
> +{
> +	WARN_ON_ONCE(cps->cp_stateid.cs_type !=3D NFS4_COPYNOTIFY_STID);
> +	WARN_ON_ONCE(!list_empty(&cps->cp_list));
> +
> +	if (refcount_dec_and_test(&cps->cp_stateid.cs_count))
> +		kfree(cps);
> +}
> +
> +/*
> + * Unhash the stateid from the s2s stateid hash, and detach it from the sc=
_cp_list.
> + * Note that this is gated on a list_empty() check, to avoid problems with=
 IDR
> + * hashval reuse.
> + */
> +static void nfsd4_unhash_cpntf_state(struct nfsd_net *nn, struct nfs4_cpnt=
f_state *cps)
> +{
> +	lockdep_assert_held(&nn->s2s_cp_lock);
> +
> +	if (!list_empty(&cps->cp_list)) {
> +		list_del_init(&cps->cp_list);
> +		idr_remove(&nn->s2s_cp_stateids, cps->cp_stateid.cs_stid.si_opaque.so_id=
);
> +	}
> +}
> +
>  static void nfs4_free_cpntf_statelist(struct net *net, struct nfs4_stid *s=
tid)
>  {
> -	struct nfs4_cpntf_state *cps;
> +	struct nfs4_cpntf_state *cps, *tmp;
>  	struct nfsd_net *nn;
> =20
>  	nn =3D net_generic(net, nfsd_net_id);
>  	spin_lock(&nn->s2s_cp_lock);
> -	while (!list_empty(&stid->sc_cp_list)) {
> -		cps =3D list_first_entry(&stid->sc_cp_list,
> -				       struct nfs4_cpntf_state, cp_list);
> -		_free_cpntf_state_locked(nn, cps);
> +	/*
> +	 * Unlink every entry from sc_cp_list and the IDR before dropping
> +	 * the parent's reference.  This makes the drain terminate in one
> +	 * pass per entry regardless of cs_count: a concurrent holder that
> +	 * obtained the entry via manage_cpntf_state() retains its own
> +	 * reference, and its eventual nfs4_put_cpntf_state() will see the
> +	 * entry already unlinked (list_del_init() in
> +	 * _free_cpntf_state_locked makes that a no-op) and drive the final
> +	 * kfree itself.
> +	 */

Again, this comment doesn't belong in the final code.

> +	list_for_each_entry_safe(cps, tmp, &stid->sc_cp_list, cp_list) {

The switch from while() to list_for_each_entry_safe() isn't required for
this change, and isn't justified by the commit message.

I prefer while() is it makes it abundantly clear that the list will be
emptied.
I personally prefer

  while ((cps =3D list_first_entry_or_null(&stid->sc_cp_list,
				       struct nfs4_cpntf_state,
				       cp_list)) !=3D NULL) {

but I understand that might not be everyone's favourite.

Apart from the comment, the code changes looks correct.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown



> +		nfsd4_unhash_cpntf_state(nn, cps);
> +		put_cpntf_state_unlinked_locked(cps);
>  	}
>  	spin_unlock(&nn->s2s_cp_lock);
>  }
> @@ -7870,16 +7911,14 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp, struct nfs4_stid *s,
>  out:
>  	return status;
>  }
> -static void
> -_free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
> +
> +static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpnt=
f_state *cps)
>  {
>  	WARN_ON_ONCE(cps->cp_stateid.cs_type !=3D NFS4_COPYNOTIFY_STID);
> -	if (!refcount_dec_and_test(&cps->cp_stateid.cs_count))
> -		return;
> -	list_del_init(&cps->cp_list);
> -	idr_remove(&nn->s2s_cp_stateids,
> -		   cps->cp_stateid.cs_stid.si_opaque.so_id);
> -	kfree(cps);
> +	if (refcount_dec_and_test(&cps->cp_stateid.cs_count)) {
> +		nfsd4_unhash_cpntf_state(nn, cps);
> +		kfree(cps);
> +	}
>  }
>  /*
>   * A READ from an inter server to server COPY will have a
>=20
> --=20
> 2.54.0
>=20
>=20



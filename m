Return-Path: <linux-nfs+bounces-22064-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCByKBnTGGqTnwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22064-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 01:43:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0425FB7E9
	for <lists+linux-nfs@lfdr.de>; Fri, 29 May 2026 01:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24233021E57
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0317936C5B3;
	Thu, 28 May 2026 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="pCCWHNQS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtvO0pYR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4F768EA;
	Thu, 28 May 2026 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011653; cv=none; b=XBjGkjJFcwbaBcdr2j8WCYnozDmWFs4tPBcOxS8Rig0KCmZjBfvyzVKfwNlqueLaRkeaIpVmES0Sbj1BEhP6kHn+NOjSxv+dmdl+B8XYuUaMehCZOiNrwLg5jBV41jYzrSPD41IVuKLOmWz/Mk20Z3UVLl5Jfe3UWNCl3HBPouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011653; c=relaxed/simple;
	bh=IUV0J84IyfUJ3bUzBP7Jivo6H9FIy0mLK2w/b4crsjk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Sqs2ez9/tEcIt7WpByNZ49QRc+11mS7dC/aFEYNtV4OFJ65eVFpVaYXXPT8Nsy9uV2IdqJoxzqpiZd3ZxA+OAzg/2WQllqyhZfG2Q5iCaYLqC+qkUn65XbSyWQlntExMt8YrOKMyjMGzQ3heNIpR2D3+aize3nXhtSkjaMJgtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=pCCWHNQS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtvO0pYR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F3FBEC0A10;
	Thu, 28 May 2026 19:40:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 28 May 2026 19:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780011651; x=1780098051; bh=aOOuQIAXy31tgHemjvXZ8YegSuqZ0GnCjwc
	27h72uy0=; b=pCCWHNQS+CxdTqn4LGnN3veVFnhKRQXFha/A655jIfdAn79YJ07
	OqrsMctxNv9GppvXk54iskuzkKoVnVAiCLtskEJU01kcFos8DFmhC3iD5h9hgJxJ
	ZkCOD/Wet05N0cPXVE+cW/OcW9mG9aGbSyzMJvw0xsABX5GHw0TlqscU8+uUNoyR
	TtRcZbmAufd06cmT9P6GMZJM5OztwO+qTN8CuH1Y6PoOukgqoxj40ZIaVOy3gpsh
	zv11Jp0F2OlVWmM5Vvv5lpJOhcvdKFYFafTcDMMAYlQ1VnGswJ2Myu7Uu/ZRLZeX
	2aDANgwBzUCXzMND0wyLEa9+9GcIzn22xDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780011651; x=
	1780098051; bh=aOOuQIAXy31tgHemjvXZ8YegSuqZ0GnCjwc27h72uy0=; b=O
	tvO0pYR9rZyoL0tJlwvmmlyqbk/tZiHpBYwePMCr4SYQ5m3zMH7Wzg59toFWaX2E
	XuukOxloKJu5BowjCTLXuv1uJeVIPNS3qY2SnxtVQ1Ns1Kx7wYGYZtYashuslAwh
	9BDbbCxjbij+fjNNauCGEGTpAfJzrEF6XYyBMd37a1PfrTY1CR/XND0qPngQwoHn
	o26iPdxHPexlby8mu7IMvTFVzMW/PQ3DBtdfGkKD8PxL7b3k01nUCqnWrtLpdux/
	QZbuoJi15rtqfIJQeZfRq9cUS47+ymNiLVilmVerkyhTXCGhdc7v1/sxfu9BKEYr
	hhnFWLqC5tWhPi08pgETQ==
X-ME-Sender: <xms:gtIYateoL_rssLk2I_AcCpLxlZtHwd5K9iHuulMl05sybl1qmXMq_Q>
    <xme:gtIYagZVsKD7-MKDrn7BG75ARfI_f27x3rQ6y5GR9nSGAlwPdsBnWuSwubrfZsy82
    elVIZttGIlzfNoJgG9rO4rxZxw_ZjQM1rA3-q12RFSl4oVoRg>
X-ME-Received: <xmr:gtIYap4faowj8nz9j4xBVJ7hoLLVKPyVA0AWotI3_uXzNSEkhgYzu6AdcSlckN3gqoPSFHNAy4LYp9_ccnWZnVkr2GIdqhc>
X-ME-Proxy-Cause: dmFkZTEJYNSFj6FlZ6tER0ihsHHRFUUDcB+Z32YpIW8sKbB0d4DJq+6Dc4zlVrYLozs54N
    SidB7+eQ9T3FJWso7PCd8duOc6t5itKhyLAUjxIy/i45iXuujWgTkQNuIdEf8aOM122OHh
    bECC/++v+wlzmv2prHjwA9gjnmV13D+PWtVNafaEruevLn0tTpovrSWRX1fDY8V6H/zewL
    eHz4OElj4rloGcLoRFWil9AQX14c2s5wZkRMT4ALLwfbaHoAp5lb3rjfeObUJi/Imo3gGA
    JynjvtsZsWuX+SA52M69WewNS46sR4I45L5VjkI+q7QFcRRYyWTt3HaYXiEc1l1mbEYel7
    xJTxAvsk88yIC9NMYjBiBUMhONj8qPF3mLbEGr0vy2Ut+lEXk9eEoZnBn8aw8f0sArX7Yd
    pS+5eQBdw5qgOIi/DHLMo19tfopnr90NCNSyaF6wgwnOX/wSq3XapWpBO8C1F1r64Qk1mw
    4Dlv0hrbeVdm+Oj5bQvOucBScBhYzu0MaOMvIGWb0zldqlhj2+OBLJ5q8OE6tgdaFkGldU
    q397lflnfRBijBKcRUvfxY7IIhRUBLY56vz/IkufvfCTd9dqdIZbCLw9z/p7yw51til9fG
    BCyZta+G5wzsbpH7Ik8H+nZyu4UxrgMZQCnlFMDD3iwTM4HUlEzZEAhFC62Q
X-ME-Proxy: <xmx:gtIYamepXelqBxm6j_RvrvVkRmrU9ael5YC1wU8qzgKMTkyFLjMO9Q>
    <xmx:gtIYakw-g-JuellEiIgl24Y7ERduVjLZNloB8LMhDU3K73Ft7z5T0g>
    <xmx:gtIYakpOyvL5kOKYSAqNr03ksRI7Jq-q3hqvSytr1CCqyQ0qvZQKDg>
    <xmx:gtIYaqxibb1bequterMwRbKc8NRh68vspORQhU-R8FlkF1V41nGScg>
    <xmx:g9IYahZbfCdwq6_weIk1BJltH7Cv1KWmU0587xgaNtvdMzlU1uXGFfxa>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 19:40:46 -0400 (EDT)
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>,
 "Scott Mayhew" <smayhew@redhat.com>,
 "Trond Myklebust" <Trond.Myklebust@netapp.com>,
 "Andreas Gruenbacher" <agruen@suse.de>, "Mike Snitzer" <snitzer@kernel.org>,
 "Rick Macklem" <rmacklem@uoguelph.ca>, "Chris Mason" <clm@meta.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 01/10] nfsd: fix BUG_ON in nfsd4_alloc_layout_stateid on
 racing delegation revoke
In-reply-to: <20260528-nfsd-fixes-v1-1-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
  <20260528-nfsd-fixes-v1-1-e78708eff77d@kernel.org>
Date: Fri, 29 May 2026 09:40:43 +1000
Message-id: <178001164345.3379282.16920221845834080481@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22064-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,brown.name:replyto,noble.neil.brown.name:mid,messagingengine.com:dkim,ownmail.net:dkim]
X-Rspamd-Queue-Id: 0A0425FB7E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026, Jeff Layton wrote:
> nfsd4_alloc_layout_stateid reads fp->fi_deleg_file without holding
> fi_lock when the parent stateid is a delegation. A concurrent delegation
> revoke via the laundromat can clear fi_deleg_file under fi_lock, causing
> nfsd_file_get() to return NULL and triggering the BUG_ON.
>=20
> This race is client-reachable: two NFS clients can trigger it by having
> one hold a delegation while another opens the same file to force a
> recall. When the first client doesn't respond to the recall, the
> laundromat revokes it. A concurrent LAYOUTGET from any client using the
> delegation stateid hits the race window.
>=20
> Fix this by taking fi_lock around the fi_deleg_file read in the
> SC_TYPE_DELEG path, and replacing the BUG_ON with a graceful error
> return that cleans up the partially-initialized layout stateid.

Replacing the BUG_ON with a graceful error is certainly sensible and
probably all that is needed to fix the problem.

I cannot see how the spinlock achieves anything.  If ->fi_deleg_file
could become NULL at this point, it can become NULL just before we take
the spinlock.

We do need to be sure the file (if there is one) doesn't get freed while
nfsd_file_get() is incrementing the refcount, but rcu_read_lock() is the
normal tool for that.
In this case we have

  		ls->ls_file =3D nfsd_file_get(rcu_dereference_protected(fp->fi_deleg_file=
, 1));

rcu_dereference_protected(...., 1)
which for me is a warning sign.  What does the '1' mean here?
Presumably something that we cannot easily assert with a C condition, in
which case a comment is called for.

Based on the recent commit which added this I'm guessing=20
   fi_delegees > 0 guarantees stability

If that is right, then why do we also need a spinlock to guarantee
stability?

Confused.

NeilBrown

>=20
> Fixes: c5c707f96fc9 ("nfsd: implement pNFS layout recalls")
> Assisted-by: kres:claude-opus-4-7
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4layouts.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 9ed2e3d65062..5d48c7673fa1 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -247,11 +247,17 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_stat=
e *cstate,
>  	nfsd4_init_cb(&ls->ls_recall, clp, &nfsd4_cb_layout_ops,
>  			NFSPROC4_CLNT_CB_LAYOUT);
> =20
> -	if (parent->sc_type =3D=3D SC_TYPE_DELEG)
> +	if (parent->sc_type =3D=3D SC_TYPE_DELEG) {
> +		spin_lock(&fp->fi_lock);
>  		ls->ls_file =3D nfsd_file_get(rcu_dereference_protected(fp->fi_deleg_fil=
e, 1));
> -	else
> +		spin_unlock(&fp->fi_lock);
> +	} else {
>  		ls->ls_file =3D find_any_file(fp);
> -	BUG_ON(!ls->ls_file);
> +	}
> +	if (!ls->ls_file) {
> +		nfs4_put_stid(stp);
> +		return NULL;
> +	}
> =20
>  	ls->ls_fenced =3D false;
>  	ls->ls_fence_delay =3D 0;
>=20
> --=20
> 2.54.0
>=20
>=20



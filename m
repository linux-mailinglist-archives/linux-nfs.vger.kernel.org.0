Return-Path: <linux-nfs+bounces-22453-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IXlDOwksKmpCjgMAu9opvQ
	(envelope-from <linux-nfs+bounces-22453-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 05:31:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64C66DFC6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 05:31:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=ZlgVZzaW;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="G VxApSH";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22453-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22453-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24DA530B9C40
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4E2367CF;
	Thu, 11 Jun 2026 03:31:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148C213E9C
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 03:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148663; cv=none; b=UW0OqsCkUQFsGlOT4CQwmWwTr2DO3Skcul5OdiduZkrVKsbALRU0HECFH7W9p429uRc/xSGCNE3MRWcyxc6P3UmsWukKevKhcz2hpiWzc8qzZ4T8QlX99D+86wp977ldPOzVeY2E0vCAv4Sr/DKgxkLBQaI/IvKeCR6k/QAx1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148663; c=relaxed/simple;
	bh=GVl1DLnF7kii4o5lYLDFiF36DWp3XZu7+YBEe38BSXo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Fx6C4MqJvozXUqsXxfLV/DOaa7/AgyS/bE4QP0vqVfz7k9yjpqlo8RohaLLkWF5ICT6zY+zGuajkYijUG8pkiD4lhW4k3/NYSEY9hlkK5ZOcy6GF71tI1mzcQx3kq0VcvJOQ1LeQe7BiWTKE/dHB5ESTYypNsPKhxF7DTxy+ASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZlgVZzaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVxApSHj; arc=none smtp.client-ip=202.12.124.155
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 483BE7A01A8;
	Wed, 10 Jun 2026 23:31:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 23:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1781148660; x=1781235060; bh=Rz/eh15mutPQk5VNsNKHo3wHBs9hRMJruDW
	drLCETN8=; b=ZlgVZzaWUqnfAcwFwNdVfQ+XO4Wgf1DFKXPYDa5919+F2UeaA5U
	TJSh5cLUsA15R1xpHGSzuIhrajReKRVOmMo5fP05o6HwcDL5aWDvgb3ApB6ZyJk4
	DcnJiS9lNMFboMt22fPxuPmMtqbq4fPJUm9GutGtjeClGPyqz2DRmJ2XliUM9tfb
	yJYEWIfXyHlutB10EztB37GrAkTkySPd9w53BgF5iQWLYhkGpNC7G/QFXwEVBwSL
	NY7IvTZ3C9ZUXXktx/oj8AzGLeC+B1/OSp/SBrr1pmjvhXmHrcKRAZRHH1PdUYkH
	ry+gjXRFbr6+qBf9xqMEwjGS5NZ4bA+Rjqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781148660; x=
	1781235060; bh=Rz/eh15mutPQk5VNsNKHo3wHBs9hRMJruDWdrLCETN8=; b=G
	VxApSHjcE/12ppFaKaZKF88KYPWFQumPy+pwnOBsvzbq4jAXh2qFiNNHMEV3aed3
	WixOnwVctqof0F6dTIuANChoU6vfNN3mx/WQq4Z44HAFW/MpQgIbX8LRDALCm9bb
	MBwzS+tOIFlr66rpAqmimOEGBnzRAimvW1KdfTMG3gWEzkkA4tOt1QTkzC0Y7OJo
	rmt2DQj0wILSDzKACLiq1IGyIz77Rx+nQ9IgJEzzjfi5bcP0+XJsyGF8H7Cz+jf/
	bLAWtv76zpurs0qWZVLGR6QQDUg42+bMTiWT4byRvmZuHBnrI38hV4Ex/0BAmnQ3
	r+fGm2oPNJaopC8D0o/0A==
X-ME-Sender: <xms:8ysqamb2QIMQtHTD6CuhxEo8s_BzXy2DoKpvBZLgtSlu_i26KZRL_g>
    <xme:8ysqar9txAwqOowTYUHYKyVj-tMkUDRb5oslqB_iq7nSswDfr7qEDXjoYIVKrvU9I
    eNqCCjidKIEbAuJRu0cSWum24u3WxrngqUq6j2Jn9xZuxit>
X-ME-Received: <xmr:8ysqakkpbj_nE1Hd4FXrdQNWRfG5zJSr2N0f-UI91Z_IcGOIXjhmqoshGkgx_DPgalpbFmnt-uDouS5lq-MlgDwM9B6yGro>
X-ME-Proxy-Cause: dmFkZTEpMaD9fuwD7W+CVCE+aGr2Sy0ezcvpL+TGmyTFCE82jx0hgd9Tac2Xlinvf2/Spz
    HGk/E38/5gbvlWy5BWDAz4GmXjbDZ7GwSloVjEQa8OughutNeTe+GVTiq8Offl0JL7mYwE
    STaILJZPXhmocefvOVJeLUsKXSeR+eJIC9JcWoaRMfrIBio6YnAJ4w9IOgjkfIzCmnjh1M
    oiLY8wp1d7Ht54Jjq2GsrzW1ff/Y/j5E4d99jBlBlkvESFT3kF9jMQbl8M+BfRN0MNYflq
    B4IMgO3h2DIjpKaiM1mFmUxOoIjDacJiqzXsaQqcuqxSF9kseDX8ifqB8SRupMPJGjJ7gh
    Rz8UqBnCzjtRGQvT9hW9VQnY95x/8UQujexezBUrsIt1HbsQGAZyQzRlGwy4q5qb2385Ax
    146d4mAEj7qp3wPCjjVVUNAw/ec5FqTyfZcfwq/rH7EjEtX0nMH/7PNSL6tlFjV7AAp0h7
    neqAxGHf9J8HtoIxdwvG+xmDfqz2n3clq/rzTKk13LmncKYKFE5a9h6tkTvQ/yzH5Vfazb
    AzDMGyNw5SHoxvYJw3Xp7TMvPoO9HXC5bS2VB+t3ypRqthcvW/bBrez68hFay8Z7jrVPEj
    16tZ7FfzSsK53fE4Gh/xRUxrLoeDY9ZJEcwOfYcwo1g4eGboRRbk91S7tC6g
X-ME-Proxy: <xmx:8ysqaozf12VOVEy1Ks_cOIigwzvfKVtOR0UlHT2ZQyy0o7B43YTN6g>
    <xmx:8ysqam4mUk7hxCPcU96sBFjW3YpGORCs-uhJmFVBvltaAKI4zMS5jA>
    <xmx:8ysqagXnigoLBWvOTWJkSgwjBmSUMxNj22K35g3KDbVAAu57XtupBA>
    <xmx:8ysqamLXVWDeYFZkaDBw_ufwwImMH3_qC3hnSC1XUTuFUVVAp5p-3g>
    <xmx:9Csqan1uObDju64KE5Vv7oqnvuANCYXtGP9X-W-8cjVdGbFjPKFF8uy1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 23:30:56 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>,
 "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Jonathan Flynn" <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH 2/5] NFSD: Count slot 0 in nfsd_total_target_slots
In-reply-to: <20260610-nfsd-slot-growth-clamp-v1-2-7b966700df0b@kernel.org>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
  <20260610-nfsd-slot-growth-clamp-v1-2-7b966700df0b@kernel.org>
Date: Thu, 11 Jun 2026 13:30:53 +1000
Message-id: <178114865356.3002522.17708266499271377287@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22453-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:bcodding@hammerspace.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC64C66DFC6

On Thu, 11 Jun 2026, Chuck Lever wrote:
> nfsd_total_target_slots sums "target_slots - 1" across sessions
> rather than the full target. Its sole consumer, the NFSv4.1 session
> slot shrinker's count callback, must report only reclaimable slots,
> and slot 0 is never reclaimable while a session is active. That
> correction is open-coded where a session's full target enters and
> leaves the counter, as "i - 1" on alloc and "from ?: 1" on free,
> and reads as an unexplained fudge.

You reasonably describe "from ?: 1" as an unexplained fudge ...

>=20
> Give nfsd_total_target_slots the full-target meaning its name
> implies, and move the reclaimability correction to the single place
> that consumes it: nfsd_slot_count() subtracts nfsd_total_sessions, a
> new tally of the sessions on nfsd_session_list. One correction at the
> consumer is clearer than repeating it wherever a session's target
> enters or leaves the counter.
>=20
> The reclaimable figure the shrinker sees is unchanged: slot 0 was
> never reclaimable and still is not. The change only relocates the
> minus-slot-0 correction.
>=20
> Signed-off-by: Chuck Lever <cel@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6837b63d9864..f2c92e7eee6a 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1952,12 +1952,10 @@ gen_sessionid(struct nfsd4_session *ses)
>  static struct shrinker *nfsd_slot_shrinker;
>  static DEFINE_SPINLOCK(nfsd_session_list_lock);
>  static LIST_HEAD(nfsd_session_list);
> -/* The sum of "target_slots-1" on every session.  The shrinker can push th=
is
> - * down, though it can take a little while for the memory to actually
> - * be freed.  The "-1" is because we can never free slot 0 while the
> - * session is active.
> - */
> +/* The sum of "target_slots" on every session, slot 0 included. */
>  static atomic_t nfsd_total_target_slots =3D ATOMIC_INIT(0);
> +/* Session count, subtracted from the sum to exclude slot 0. */
> +static atomic_t nfsd_total_sessions =3D ATOMIC_INIT(0);
> =20
>  static void
>  free_session_slots(struct nfsd4_session *ses, int from)
> @@ -1981,9 +1979,10 @@ free_session_slots(struct nfsd4_session *ses, int fr=
om)
>  	}
>  	ses->se_fchannel.maxreqs =3D from;
>  	if (ses->se_target_maxslots > from) {
> -		int new_target =3D from ?: 1;
> -		atomic_sub(ses->se_target_maxslots - new_target, &nfsd_total_target_slot=
s);
> -		ses->se_target_maxslots =3D new_target;
> +		int delta =3D ses->se_target_maxslots - from;
> +
> +		atomic_sub(delta, &nfsd_total_target_slots);
> +		ses->se_target_maxslots =3D from ?: 1;

.... yet here it still is with no explanation :-)

But that is a minor detail and I do like the patch.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

>  	}
>  }
> =20
> @@ -2079,7 +2078,7 @@ static struct nfsd4_session *alloc_session(struct nfs=
d4_channel_attrs *fattrs,
>  	fattrs->maxreqs =3D i;
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
>  	new->se_target_maxslots =3D i;
> -	atomic_add(i - 1, &nfsd_total_target_slots);
> +	atomic_add(i, &nfsd_total_target_slots);
>  	new->se_cb_slot_avail =3D ~0U;
>  	new->se_cb_highest_slot =3D min(battrs->maxreqs - 1,
>  				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> @@ -2207,9 +2206,10 @@ static void free_session(struct nfsd4_session *ses)
>  static unsigned long
>  nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
>  {
> -	unsigned long cnt =3D atomic_read(&nfsd_total_target_slots);
> +	int cnt =3D atomic_read(&nfsd_total_target_slots) -
> +		  atomic_read(&nfsd_total_sessions);
> =20
> -	return cnt ? cnt : SHRINK_EMPTY;
> +	return cnt > 0 ? cnt : SHRINK_EMPTY;
>  }
> =20
>  static unsigned long
> @@ -2260,6 +2260,7 @@ static void init_session(struct svc_rqst *rqstp, stru=
ct nfsd4_session *new, stru
> =20
>  	spin_lock(&nfsd_session_list_lock);
>  	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
> +	atomic_inc(&nfsd_total_sessions);
>  	spin_unlock(&nfsd_session_list_lock);
> =20
>  	{
> @@ -2333,6 +2334,7 @@ unhash_session(struct nfsd4_session *ses)
>  	spin_unlock(&ses->se_client->cl_lock);
>  	spin_lock(&nfsd_session_list_lock);
>  	list_del(&ses->se_all_sessions);
> +	atomic_dec(&nfsd_total_sessions);
>  	spin_unlock(&nfsd_session_list_lock);
>  }
> =20
> @@ -2481,7 +2483,17 @@ unhash_client_locked(struct nfs4_client *clp)
>  	spin_lock(&nfsd_session_list_lock);
>  	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt) {
>  		list_del_init(&ses->se_hash);
> -		list_del_init(&ses->se_all_sessions);
> +		/*
> +		 * unhash_client_locked() can run more than once for a
> +		 * client; the session stays on cl_sessions across calls.
> +		 * The first pass empties se_all_sessions via
> +		 * list_del_init(), so skip the decrement on later passes
> +		 * to keep nfsd_total_sessions from being double-counted.
> +		 */
> +		if (!list_empty(&ses->se_all_sessions)) {
> +			list_del_init(&ses->se_all_sessions);
> +			atomic_dec(&nfsd_total_sessions);
> +		}
>  	}
>  	spin_unlock(&nfsd_session_list_lock);
>  	spin_unlock(&clp->cl_lock);
>=20
> --=20
> 2.54.0
>=20
>=20
>=20



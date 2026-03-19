Return-Path: <linux-nfs+bounces-20281-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OA5BOg+vGn6vgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20281-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:22:32 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA972D0BF7
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 19:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFF52300B185
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4A3ED12E;
	Thu, 19 Mar 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdaJKv0k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72A38D685;
	Thu, 19 Mar 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944548; cv=none; b=DMWtt15W4o5dHoJoHWKxCJFNB9RnYOgEPRkUHDjo2ssTwF6f640wl8eInd83lLhT07PA/AYXIMORroh4XvMz8JlLsIs+N2TNHACqjGczlMqzFi54hMrsfgq5dBjiczYpPAFMymmdEIdQXJxHMSK4LH0RVkYr2ccZaBcqdYfaF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944548; c=relaxed/simple;
	bh=Xc/xBoq/UjF0S/fSdiqUyiKLDJSNLSpMj78/1XWgJYI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ClFoDlC7tTpGi7hyzWf+z/JJaZPQhz0omzKLheQw6eIr7SCHR/vtAdjdDIwsh4ShJSvXjy1JJw4q+viyyhOBLCXmqF/8/UIcAVgcmiUYfp1h/bJsyN7PzgpL5YJxpoWkKaCkgHIex7EkfzbO3lAaYhkMbB3GG7yLRhq/iu6MceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdaJKv0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A9DC19424;
	Thu, 19 Mar 2026 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773944548;
	bh=Xc/xBoq/UjF0S/fSdiqUyiKLDJSNLSpMj78/1XWgJYI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SdaJKv0kJ4Nxclf8wb6Hahoalxxg2n5XMKnxyWFuLaCHczhxDBgmqpbVywdRlp/2d
	 8rsrvYftvaEshcGeMxMET2sMX+nDdPF5bIR1/Am5Y8HlanEqm6fNkxxzYuY65ETp0Q
	 UkKA6K4rbxRak/xY855GyFhJxBC0Dnp3xlB/4Ixaly5GQ9JZFILjORvHR0kO1iYwO1
	 +xLVNSmjXO3adS/y3N7sQNYzyM0WmBHObexq+HZG/iZy+qmFVjRcbA9088Qe1Uls9B
	 TRNzq+wvCBa4a/JH1nrSNIkZhOhqL8hKdjEdMGMlO43XzDo5Ce902zPwVDLeGhfzeq
	 G2OLGKKVLFeHg==
Message-ID: <579b0239abbbb0b95d619e6b400bb919fedab60d.camel@kernel.org>
Subject: Re: [PATCH 06/14] sunrpc: add helpers to count and snapshot pending
 cache requests
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Mar 2026 14:22:25 -0400
In-Reply-To: <0908b7ac-658f-491b-89be-f5a1d97e991e@oracle.com>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
	 <20260316-exportd-netlink-v1-6-6125dc62b955@kernel.org>
	 <0908b7ac-658f-491b-89be-f5a1d97e991e@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20281-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABA972D0BF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-19 at 14:07 -0400, Chuck Lever wrote:
> On 3/16/26 11:14 AM, Jeff Layton wrote:
> > Add sunrpc_cache_requests_count() and sunrpc_cache_requests_snapshot()
> > to allow callers to count and snapshot the pending upcall request list
> > without exposing struct cache_request outside of cache.c.
> >=20
> > Both functions skip entries that no longer have CACHE_PENDING set.
> >=20
> > The snapshot function takes a cache_get() reference on each item so the
> > caller can safely use them after the queue_lock is released.
> >=20
> > These will be used by the nfsd generic netlink dumpit handler for
> > svc_export upcall requests.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/sunrpc/cache.h |  5 ++++
> >  net/sunrpc/cache.c           | 57 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 62 insertions(+)
> >=20
> > diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.=
h
> > index c358151c23950ab48e83991c6138bb7d0e049ace..343f0fb675d761e019989e4=
7e03645484e0aa30f 100644
> > --- a/include/linux/sunrpc/cache.h
> > +++ b/include/linux/sunrpc/cache.h
> > @@ -251,6 +251,11 @@ extern int sunrpc_cache_register_pipefs(struct den=
try *parent, const char *,
> >  extern void sunrpc_cache_unregister_pipefs(struct cache_detail *);
> >  extern void sunrpc_cache_unhash(struct cache_detail *, struct cache_he=
ad *);
> > =20
> > +int sunrpc_cache_requests_count(struct cache_detail *cd);
> > +int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
> > +				   struct cache_head **items,
> > +				   u64 *seqnos, int max);
> > +
> >  /* Must store cache_detail in seq_file->private if using next three fu=
nctions */
> >  extern void *cache_seq_start_rcu(struct seq_file *file, loff_t *pos);
> >  extern void *cache_seq_next_rcu(struct seq_file *file, void *p, loff_t=
 *pos);
> > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > index 819f12add8f26562fdc6aaa200f55dec0180bfbc..2a78560edee5ca07be0fce9=
0f87ce43a19df245f 100644
> > --- a/net/sunrpc/cache.c
> > +++ b/net/sunrpc/cache.c
> > @@ -1906,3 +1906,60 @@ void sunrpc_cache_unhash(struct cache_detail *cd=
, struct cache_head *h)
> >  		spin_unlock(&cd->hash_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(sunrpc_cache_unhash);
> > +
> > +/**
> > + * sunrpc_cache_requests_count - count pending upcall requests
> > + * @cd: cache_detail to query
> > + *
> > + * Returns the number of requests on the cache's request list that
> > + * still have CACHE_PENDING set.
> > + */
> > +int sunrpc_cache_requests_count(struct cache_detail *cd)
> > +{
> > +	struct cache_request *crq;
> > +	int cnt =3D 0;
> > +
> > +	spin_lock(&cd->queue_lock);
> > +	list_for_each_entry(crq, &cd->requests, list) {
> > +		if (test_bit(CACHE_PENDING, &crq->item->flags))
> > +			cnt++;
> > +	}
> > +	spin_unlock(&cd->queue_lock);
> > +	return cnt;
> > +}
> > +EXPORT_SYMBOL_GPL(sunrpc_cache_requests_count);
> > +
> > +/**
> > + * sunrpc_cache_requests_snapshot - snapshot pending upcall requests
> > + * @cd: cache_detail to query
> > + * @items: array to fill with cache_head pointers (caller-allocated)
> > + * @seqnos: array to fill with sequence numbers (caller-allocated)
> > + * @max: size of the arrays
> > + *
> > + * Only entries with CACHE_PENDING set are included. Takes a reference
> > + * on each cache_head via cache_get(). Caller must call cache_put()
> > + * on each returned item when done.
> > + *
> > + * Returns the number of entries filled.
> > + */
> > +int sunrpc_cache_requests_snapshot(struct cache_detail *cd,
> > +				   struct cache_head **items,
> > +				   u64 *seqnos, int max)
> > +{
> > +	struct cache_request *crq;
> > +	int i =3D 0;
> > +
> > +	spin_lock(&cd->queue_lock);
> > +	list_for_each_entry(crq, &cd->requests, list) {
> > +		if (i >=3D max)
> > +			break;
> > +		if (!test_bit(CACHE_PENDING, &crq->item->flags))
> > +			continue;
> > +		items[i] =3D cache_get(crq->item);
> > +		seqnos[i] =3D crq->seqno;
> > +		i++;
> > +	}
> > +	spin_unlock(&cd->queue_lock);
> > +	return i;
> > +}
> > +EXPORT_SYMBOL_GPL(sunrpc_cache_requests_snapshot);
> >=20
>=20
> This API architecture introduces a TOCTOU, since as soon as the
> queue_lock is dropped, the count can immediately become stale.
>=20
> The count returned by sunrpc_cache_requests_count() is used as the array
> bound. To wit:
>=20
>   cnt =3D sunrpc_cache_requests_count(cd);
>=20
>   items =3D kcalloc(cnt, sizeof(*items), GFP_KERNEL);
>=20
>   seqnos =3D kcalloc(cnt, sizeof(*seqnos), GFP_KERNEL);
>=20
>   cnt =3D sunrpc_cache_requests_snapshot(cd, items, seqnos, cnt);
>=20
>=20
>=20
> This appears in all four dumpit handlers (ip_map, unix_gid, svc_export,
> expkey).
>=20
> This isn't a memory safety issue; _snapshot() caps its output at max, so
> if the list grows between the two calls, entries are silently truncated
> rather than overflowing the buffer. If the list shrinks, the arrays are
> merely oversized.
>=20
> However, the practical risk is incomplete data returned to userspace. If
> the caller is guaranteed to be re-invoked (e.g., the netlink dumpit
> callback gets called again until it returns 0), then missing items due
> to list growth between count() and snapshot() is harmless: they'll be
> picked up on the next pass.
>=20
> But looking at the callers, they all do this:
>=20
>   if (cb->args[0])
>       return 0;
>=20
> and then set cb->args[0] after the single snapshot dump.
>=20
> The dumpit is a one-shot: it snapshots once and signals completion. If
> the list grows between count() and snapshot(), the truncated entries are
> silently lost and there's no subsequent pass to pick them up, IIUC.
>=20

Userland will receive a separate notify request whenever a
cache_request is queued, and that notification is only sent after the
cache_request is queued.

So while it might not receive all of the queued requests from the
kernel in the race you describe, it won't matter because select() will
return the notify descriptor again on the next pass and mountd will
pick up the remaining entries at that point.
--=20
Jeff Layton <jlayton@kernel.org>


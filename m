Return-Path: <linux-nfs+bounces-22261-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OCPcEXC0IGrI6wAAu9opvQ
	(envelope-from <linux-nfs+bounces-22261-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 01:10:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A863BC54
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 01:10:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=F0K3OqSO;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="C n5S+Xq";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22261-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22261-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85BA630546F8
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 23:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B323D7CE;
	Wed,  3 Jun 2026 23:08:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B66340404
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 23:08:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528085; cv=none; b=GI8Z1jdfWuHGMchK6095Xt3i4Ed9ENbFtgyQSI1utzGwtXkcqmY+UO/tTPipsNO0VrDyTqMDw2lLf6oV/H9ZP5YTSfTAfGPYnxiENmhIbqmNk5fgrHZh+VSvnCV+qzSuN3rGyDKz1yLavQEumBaiEzgZIi3DGq1vrAoG6yy1LCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528085; c=relaxed/simple;
	bh=YM6iHiPPHGMQ7S4ZsgJB32oMmsYtuRNEF2wndbbsB9I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RmlM1hzt/wTqQVMui2Lbyi9fpArSAjmX2AA0gJDo+1pwCi2yWVTDK8tYKR8cC2m7JaSbZzWFXmn96BodcazyW5Q2xpv5f5P4GBNDFMPDhqgOMihcLWB67PM85tSnXs6u1Q3IIYU7wYSVL90EeVB6C6jH/PqXmB96DGF3lOJj454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=F0K3OqSO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cn5S+XqQ; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 991BE7A015E;
	Wed,  3 Jun 2026 19:08:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 19:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780528083; x=1780614483; bh=fh+/2Kwo0+QhVU6hQvUgUfj1se1Kvselu4L
	KwKnuhbM=; b=F0K3OqSOjHYe3Py99C71PTJHr6VExhiCgw9dzSRBNFpWWm1kX8G
	R/0U5ZV/of0+2fcTvKtCsduoo2ndfgUQftT7JXDj+54NgQTVY//Mhpg6Oqk6cvyF
	cN3grQdwS7UKGddsdSCuPT95Vl7zQCPWchabpiMX03w1OtKPKVUVabd/dhxzFQ5+
	mLUEGaElNVizqHEh8rgzcX0gkoc6IlamOiTf7SQuWFTKhJ2vzrUa9Gns46F4rYC8
	Vrw+vkNRrDIQqo+BLm3pAob8ISc9ql8YUz+cMgCgCK5Se9JoJ59TLela6YnClktr
	dK9qv9XeQo1U/DzZfVMwCE+P/K727xU9e4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780528083; x=
	1780614483; bh=fh+/2Kwo0+QhVU6hQvUgUfj1se1Kvselu4LKwKnuhbM=; b=C
	n5S+XqQWLIWsSl6NQtnJ/UcvJKDZ7nbjxcRDDJV13ZqUPDZ9iwE6NZp3YT6fMiLD
	8Mv5p6Lied+jMYbBm2Fr2x7R1chptW/rLE6ZvewLm4zvSMxlbJisJ1Uu7XVLGM/s
	1LjjD34l/jLZ/oWKXbbZH2waV7qR818F1FgFMjSYKRhhmbAnA5Gfv6xNDIoxnejc
	aAyevJbvRUbdVwn5nWBZB3s/W0veVRgiInWO+tXYEZaldnSkeF9IFVhkZ/BLiWLj
	OAtfc/EmZ47+atW4Hi0mNRkke+k/hwP+1GAe1lvRHKZAP6ywLQTyWuH279F9DYlI
	d9hR9eBVdp/LhG55RLbrA==
X-ME-Sender: <xms:07Mgam2zfbgcRuqEq29VsliUORLz3J0JMkqPNdJ6xnE98fGd3CY9zg>
    <xme:07MgagEUZM4pJtQwmqv7Rm3kHrL0vbnLQVUOam37eRVOC5gkzwEthDNZknArAHwne
    P703gAXZFxGU2bk9Ww3xqGwhUsA1HU2jouWZqJW7NtGcLA>
X-ME-Received: <xmr:07Mgaj54a4eqMlh-SRYZNG6mbLQ2f3GXhX5C7ZXnr5DPyw0TO1BAFDI73TgMamK3qAvenIeKI1hk4P5T_zd33wVmoqdrCEE>
X-ME-Proxy-Cause: dmFkZTFREoGfoZcKUETwjfnLD/H5PLA8Pe8lQMHhB4kHwtZX3pdyZs4Tc0WKMl4ZQfQwDf
    pHGLlX91juLLLqx+SmVS95ITQpg+9p0QOrGsLe06Q2p2+AWyehdDPTJexldrjuk5ML0t0p
    /vI3PLRtutlf0fFq1d2QjLoKILZetIIoHZkyGJ7xNPLpcJP7nA2jztS+1bSx+ziTnrfN+a
    3mWE06XIxR79CK0mkJ8Xufu4MtRGSuFnJY3vMU+RKIqd6bY7Q2OXjBuwMhlzcs61ZvMnZK
    SPUsuNrvZ3lT8AGW+R5Mm0oGgA9Db0cK4eGP6FWnomh/Ayc4CePBWxMJpzVKHyNZAkeQnn
    iOVeYi749v/mU3r+UWayPnaQGSc+BNBWR/S/E8GBwS0qKrdYLLWyw2HBC+AmO6uiuhEuDs
    Wsnafxt0ngz/on+3TB6R3QXzQZNBFy+cHH51ZXehuldKnVcmjgE28bxgnBeoJDiJwfAuof
    ltdPSymQ2Dohk+qyx5diBtWSIGQl0+4NurHh1fqDp0blHiZOlECR2otqbFQoy0TXvx36Jl
    CFmCQSrXYUXo5BOq44vWv3b/6ZnDAG9ba1dpDiNCpZkpyiZcwpgyslCdymoIxaejOBlqOE
    B/E0puo2PB2N6eGHDsbRcgZEdtlo2Yb3H1isfb4d9bZSDbUWsDy7se/00cJg
X-ME-Proxy: <xmx:07Mgamv0Ea01RkWWwSub2IJP2gj8THaXA5M-wP7Nh80_fZyeblla7g>
    <xmx:07Mgak5pIpyw-GucpEslhktQKQlqlvQ0H7dT_Qdw5SNwv_jmFATu3g>
    <xmx:07MgahU4wWtiLCHwYzZRtEJObDhnj8yJzunF7kXoiVyCBhXRANUD8g>
    <xmx:07Mgam_S7urpyrf_hs16RXEWE3FBj2S3uaMxHlccEg_89OahShp2wQ>
    <xmx:07Mgai3VtUl7KyRwSqbNLXv63RMLVCw6zJqeORZWmqSB-JgWPbOjLYAl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 19:08:01 -0400 (EDT)
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
Cc: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
In-reply-to: <561e9ac6-348f-4d6d-b896-38dbe5ede3bc@app.fastmail.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
  <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
  <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
  <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
  <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
  <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
  <178044079821.2082204.6117918610145832039@noble.neil.brown.name>
  <561e9ac6-348f-4d6d-b896-38dbe5ede3bc@app.fastmail.com>
Date: Thu, 04 Jun 2026 09:07:59 +1000
Message-id: <178052807961.2082204.13323491503071931242@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22261-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,brown.name:replyto,messagingengine.com:dkim,ownmail.net:from_mime,ownmail.net:dkim,noble.neil.brown.name:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E69A863BC54

On Wed, 03 Jun 2026, Chuck Lever wrote:
>=20
> On Tue, Jun 2, 2026, at 3:53 PM, NeilBrown wrote:
> > On Wed, 20 May 2026, Chuck Lever wrote:
> >>=20
> >> On Tue, May 19, 2026, at 6:02 PM, Benjamin Coddington wrote:
> >> > On 19 May 2026, at 14:44, Chuck Lever wrote:
> >> >
> >> >> On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
> >> >>> Just to be clear - the issue I'm exploring isn't the same as when al=
l the
> >> >>> kNFSD threads are slow due to their workload.  This is very much a
> >> >>> multi-client dynamic where one client (or a group of automated client
> >> >>> instances) are able to easily starve another simply because they cre=
ate the
> >> >>> most connections.
> >> >>>
> >> >>> That's different from the other problem that we've discussed a bunch=
 at
> >> >>> bakeathon and on the list previously.
> >> >>>
> >> >>> This is not so much a deadlock issue as it is an issue
> >> >>> of per-client fairness.  I think this problem is in a different clas=
s.
> >> >>
> >> >> Does dynamic svc thread creation have any impact?
> >> >
> >> > I haven't tested it - I think it would just pin to max-threads for the
> >> > workload in question.
> >>=20
> >> If the aggregate workload consumes all the threads, then that doesn=E2=
=80=99t
> >> sound like xprt scheduling is the bottleneck. But I should look at
> >> numbers instead of speculating.
> >>=20
> >> Are you seeing connection loss in these scenarios?
> >>=20
> >>=20
> >> > I'm probably not understanding you here, because for the problem I'm
> >> > interested in fair would look like prioritizing each client's request
> >> > queue equally, no matter how many xprts each client has.
> >>=20
> >> Then for NFSv4.1 and later, NFSD might schedule work on the session, and
> >> manage each session=E2=80=99s workload by raising and lowering the numbe=
r of slots
> >> in its slot table.
> >
> > I agree that managing slot numbers is likely to be a good approach.
> > It doesn't make much sense to allocate to any client more slots than the
> > maximum number of threads - does it?
> >
> > We already have code to reduce slots numbers based on memory pressure.
> > We could extend that to reduce based on demand compared to number of
> > threads.
> >
> > e.g. let every client have a least one unused slot until the total slots
> > across all clients reaches the maximum number of threads.  Then apply
> > pressure evenly like we do for memory shortage.
>=20
> Sensible!
>=20
> But these days the number of threads isn=E2=80=99t fixed. As load goes up t=
he
> number of threads increases.

Yes, but there is still an upper limit.  That is what I was thinking of.

But in practice the upper limit might be less than the configured upper
limit if allocating a new server fails (hmm...  I wonder if it can
fail...  it should probably use GFP_RETRY_MAYFAIL or maybe even
GFP_NORETRY when adding extra threads).
To be able to compare the number of slots to the number of threads we
would need to track an effective-maximum which is probably the largest
maximum seen.

Hmmm..  should we add a shrinker to stop nfsd threads when memory is
tight?

Thanks,
NeilBrown


>=20
>=20
> > Idle clients will get pushed back to 1 slot, active client will tend
> > towards a "fair" share based on how comparatively busy they are.
> >
> > This wouldn't help for v3 of course but I don't think we need these
> > advanced features for v3.
>=20
> Ben=E2=80=99s employer might disagree with that :-)
>=20
> I think NFSD might also need to consider LOCALIO workloads.
>=20
> --=20
> Chuck Lever
>=20



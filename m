Return-Path: <linux-nfs+bounces-23017-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OEw9Ld4mS2oSMgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23017-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 05:54:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91DC70C601
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 05:54:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=e3LJMn9e;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="g D43Saf";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23017-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23017-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27333005D0A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 03:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541B3ACEEA;
	Mon,  6 Jul 2026 03:54:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7A13B7A3
	for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2026 03:54:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310043; cv=none; b=AjcGywldGVduQL+sZGI0zjhzK78p+A6HotsMW4Wu/LQN4azTUSbNcC5RGDr3XbnU4vks98Y0pmI3JWWA9fe8XRbE5jMIX7we07UTsWtTsVzUmOhYgJpLIP8QZw/zg29bHUCb3V0FnHKLqrI5elzToLTDMcbY89zcw3YVHLpn2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310043; c=relaxed/simple;
	bh=KQnQ/ZX9jTQ/xC9qC1ca/4V+oqdntmULc4ONmKjF2v0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dFZwkrjh93TmMzyTo/HRH7NsmNiBE0JtX+q0HWXb1DqQ+OHnzTU1W3hQS5e3Ixk0LdSo6hbCSb+jeEu9VUwUmPxkh3AEnLjz3ig2rAfFdyHzHfDDPbzL/oqa47J84f8rskn4Nk91J94sNtfRNWlwFx30UsZJLgxfXkbC20A6c74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=e3LJMn9e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gD43Safp; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45B267A00C4;
	Sun,  5 Jul 2026 23:54:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 05 Jul 2026 23:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783310040; x=1783396440; bh=MK7m7WVlebiTF2SAPXfJHpF4F6t9AqpM30/
	ITHAHLEk=; b=e3LJMn9efG07/MTWyus8AdzFuzqitVcK4MegfZxrrIAFQVJd7Jl
	5J8JmNumdvJ0u2Xr8RSJsdmGvD1DkZicwGcY3UTvgr9h8RYGIezf1a5TsTprNizh
	K2DU8fUMNASWd3PnvUquZI1VEEoJgSNR1NOp1u3Kihngaj9Is7xOn/AdPl9s7hQ6
	0Ovm1DKoX03NWUBkGox5cKyRsarJk6FnQ6xIw5P+IcXw0GShmI/hgx0I2S0C+Y0y
	q558xJD2x9416lJG/AnowjnNISswftR4zERhNndd1Xs7zbsxz5bNbPkxdqJC/n5R
	9ZtZtpKsTpRF9G0cy5/m5z90N3ncpPI7zoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783310040; x=
	1783396440; bh=MK7m7WVlebiTF2SAPXfJHpF4F6t9AqpM30/ITHAHLEk=; b=g
	D43Safp5ImSmEUeltDja5AqTVirkmZynAseQ/dT0RkgY2YI0cn2sjUuRV4CjQ8Td
	f4XSsHxQG223b+GU4wFkeZjlAlxv65IpznLS5dzfYYZr6XQSfBEsb1OKbVh+ToeO
	8JxaNiI5TqMEYGUP/CNjKiHmJ6ZEpBf9uRTk+qISZKp0aDfwgwoPJv+zoy4jtoo4
	tu0Il3z/B+6nHHTvpaa3oyQO3gxRQXarCV8PXI+HgHGlTOtEonzkEZm0VMQzzUH7
	KkUEjqWqpnkwUmEQTBBSL6HcY0su00cwY19P+1rOOtBgURR+o0PXEK0JNIpOSy+B
	UYF7YJeVs9blBMwpDxKxw==
X-ME-Sender: <xms:1yZLarxJApUAjqwJ6hqbQ-uT9g55OVGC1_uiZSCkKAv3dYDtArE19Q>
    <xme:1yZLalhRVoAKZD90coPwqxFbHPbuK9_P6DueFjPG_WeraGHeAvWO0vWj_V7nQRsUu
    egu9UjkHdDfHOlJ2P4wgC_GoREyOHEYQP5EQH0m2t8Uhyu0Ww>
X-ME-Received: <xmr:1yZLanmOOWoeqVk68GRoeU1WkFmWSiubS_j0usdHlmL8KkN9yjCbmwwlwRYrm8hH-mrxVnOpeVlea3hpC5sqFSJpG_4-1qQ>
X-ME-Proxy-Cause: dmFkZTExBrKU7kC5ajHoh05usjmIObUphQDeVZX3TrZjIHBLiOGdo425i7s421dRoKisyt
    OhEY2BEkYGcIYwFK0AFkb/ozotpV+fDvszykkUqiJ68U9KToRgr8M1kztwbfLffoOHpciA
    nA1yLF25aZTO+Nlw/tzGzbCTenxL+CctebKOzO/bt3t+Q20YfhAdXqOybYYsnpOdwGAEmi
    zEqteP2zhhHuLYEHnGLTCm4rcZyjxD2aT83w+Op21tcbSAfNluwBsRyV0IQHhXewnZt47m
    spJ5k3W7Kv0tLc3LDCtcm8ppHt6IsDZ3Kmep1PBEPL2NCZOvkX77brd4KP4GNm3mXKQNia
    VdAI6pCBGTdO67gD7Hm6sVeuWKh8dVsmKTTNtlYExrALV4AliuDzvohVtyCxD4O+/+WURj
    ocNtF3vyxIiXFe9KTcyrH2/+KPY/EjYNjSS3G91zbNDWIUYzh+qPpQo6T7d31QFCIHmLfr
    +7f0uW8AEgwnU90qs2jKkHTbKH6EFAVg0Ag7aJ5RhYM2SUXeEOlTZaT4Rdgo4ZujoIlxHR
    vbfpf5NxyemBFHIckuC6NzNLYHUyLHAk+GaVHRyXP5nmyKnNmBOn8p/CEAiGMS0xOXw0vw
    ZNZtQApr+t0YV9nZcOStvUcTonPXiaSCnEyPH4xuLPJEWFNc2w6f3FCzgLOQ
X-ME-Proxy: <xmx:1yZLarjNvcQOh2i5akiiD4t599ji8tZI9m45ktoYdUUYsZLpj40ALA>
    <xmx:1yZLar27-MgGZhx5LUxQSuCzEt9I4u-ek3C4qBsOzE2OeFZ-qCtikg>
    <xmx:1yZLakIdHVXeuIe_dNQgu1uW_seexUH16F1toS6HjWYSz8pVTc9l0A>
    <xmx:1yZLarwcYQ6EztjPxi_S1PG0qI1ifznnnFoijLQGrLBlwuvzG5HVgg>
    <xmx:2CZLanl8oDJ4LQdhj-0a0IIwDwMKzp11ieVA3Viu0ygMfNmA_gwJcI91>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 23:53:57 -0400 (EDT)
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
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Wolfgang Walter" <linux@stwm.de>, "Chuck Lever" <cel@kernel.org>
Subject:
 Re: [PATCH v2 0/6] NFSD: Fix UAFs in client teardown and state revocation
In-reply-to: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
References: <20260705-cel-v2-0-d88c3b68e8bc@kernel.org>
Date: Mon, 06 Jul 2026 13:53:53 +1000
Message-id: <178331003326.27465.17776206334015632059@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23017-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux@stwm.de,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim,ownmail.net:from_mime,ownmail.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C91DC70C601

On Mon, 06 Jul 2026, Chuck Lever wrote:
> A NULL-pointer dereference reported during NFSv4 client teardown
> (patch 1) proved to be one instance of a broader lifetime bug in
> NFSD's state-revocation machinery. This series fixes the reported
> crash and the sibling races found by auditing the same pattern, then
> consolidates the fixes.
>=20
> A stateid, and a bare lock owner reachable through the client's owner
> hash, hold only a raw pointer to the owning nfs4_client; a reference
> on the stateid or owner does not keep the client alive. The client
> outlives its state solely because __destroy_client() drains that state
> before free_client() runs. Several paths break that invariant. The
> laundromat unhashes an expired delegation before revoke_delegation()
> re-links it, leaving it momentarily on no client-reachable list
> (patch 2). nfsd4_revoke_states() and its export and NFSv4.0
> admin-revoke siblings drop nn->client_lock and then dereference the
> client again (patches 3-5). __destroy_client() walks the owner hash
> and frees blocked locks with no reference held (patch 1).

Apart from one issue already mentioned in the first patch - which maybe
should be fixed with a separate patch - these all look good.  Thanks,

Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown


>=20
> ---
> Changes since v1:
> - Add matching UAF fixes in several other paths
>=20
> ---
> Chuck Lever (6):
>       NFSD: Prevent lock owner use-after-free during client teardown
>       NFSD: Prevent client use-after-free during delegation revoke
>       NFSD: Prevent client use-after-free during admin state revocation
>       NFSD: Prevent client use-after-free during export state revocation
>       NFSD: Prevent client use-after-free during NFSv4.0 revoked-state clea=
nup
>       NFSD: Consolidate the revocation-path client unpin
>=20
>  fs/nfsd/netns.h     |   6 ++-
>  fs/nfsd/nfs4state.c | 108 +++++++++++++++++++++++++++++++++++++++++++-----=
----
>  2 files changed, 94 insertions(+), 20 deletions(-)
> ---
> base-commit: ee6ae4a6bf3565b880dfb420017337475dfbc9ea
> change-id: 20260705-cel-61c1c70caa03
>=20
> Best regards,
> -- =20
> Chuck Lever
>=20
>=20



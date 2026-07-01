Return-Path: <linux-nfs+bounces-22902-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UoDFBVpyRGrJuwoAu9opvQ
	(envelope-from <linux-nfs+bounces-22902-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 03:50:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D856E91A6
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Jul 2026 03:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=flM3lVcp;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="f Jd+cGy";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22902-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22902-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB09B3022A80
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559993612E0;
	Wed,  1 Jul 2026 01:50:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23000360EF6;
	Wed,  1 Jul 2026 01:50:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870614; cv=none; b=FE90CeiObyNUg6nRQeKrkylbG2H8LVyQuMhUGSb0PUMCtfK0n1JWsdzjC+MgdwK8ZyMk7crnnbjWLhaPNMlPZ0fNhL1cz/CkxtLDm9c5uxwkyt6fN50Y9LFMkBg6D0K/SYCw8auoemVJGSUA2q1Q+TLyxxj4r8JQuImFHF7VNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870614; c=relaxed/simple;
	bh=e47uxe1VS+QU2FqDn25QPxOPingmUkGhEqRcNz+fN3U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iAv7GgVcTlzJ1/cfIZ0PUEAiBTnUTUoUcmkbwLjKl/eRkVHmGi60QOTDDgVFBqqNphtbKUSNVQ/Awc08OBK5aeHYwcdQ+I0DOwtkMlt3xuBajS2R9Q1xUnMi4k3AyOveMNbSJ2mGRdzbOs7BMNkNIFZ/arvBE7tvJ6zm8nJrwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=flM3lVcp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJd+cGyQ; arc=none smtp.client-ip=103.168.172.145
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 47B84EC016D;
	Tue, 30 Jun 2026 21:50:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 30 Jun 2026 21:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782870611; x=1782957011; bh=wNJAVsfjqK1239R++sn9/FcHKTjkjKyLGT0
	e94Ytsfs=; b=flM3lVcpZdTuw3KU97tYxCZ8FvyUgOI1YL2xwX3MpfisFF0w6yc
	HZgSsg5DVVBbGkc9aO7pm2dxvz1Tl9uDK72ToSJZBVi8pLX4VKUVFW7CpjFH3+iO
	UgAxS2/LHgQ4wynzCpIz3w0dmWSb7pkO378achJd0ABiuAeYJoNBsfzSmg9cevMu
	sTakXvnSuhitzlOV88DF9e/vKVzeISvnPPQEx/Na+snvB2HsNVCwBpPogznAN+zq
	J4zk2TjgXadACK0nih4njTdlCTKaPBn06186O9QqFMMCKpBaT0AYc5yPVyaz8KKZ
	xoZKT1iUlwZWzD2HNKkTDD3Vllq1J2lHmkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782870611; x=
	1782957011; bh=wNJAVsfjqK1239R++sn9/FcHKTjkjKyLGT0e94Ytsfs=; b=f
	Jd+cGyQAcZnSpY1/YUNzNCgjOIZO7ajstaDvCsdxGEy/PT5qKwpFTeqaTzQhghKO
	wkslJk5Lo+PuWk2mgYSSwe6VpBXwg9sLk1tHYZDsHJ2NI/Tcpwnzf1A563JhjDgX
	3AucHjMN3uLupoZ52lRixUkUXWV/uOBf1DcXxhEwLjbdH18EfOW3oRooCtdLrRiW
	d09oQTXizSk9ft4vGrTH4+ZE7MTpgztMoF0GQq5TKJZF8G4n5V2OHPb5bQRWAMRK
	0CR73WMSsVQNln2d95tfBqa4JZxWCVlV6hLHPRVzbyWYCo0DneYj/lepCcviq8LF
	fJepvHoAPPL8qdhXHOnWw==
X-ME-Sender: <xms:UnJEaoWx0iFoM4xDYyT2IQ25xg0-ihaZ_Tc97HejtEAZ8aRLpA8dWA>
    <xme:UnJEahjJW7z5ZfbKXksep7vfE1eih5iSuyNbP1Y3StgHsTV0TN-lLiTsk_MBg-WSm
    31Lnn44JtjJI6Pzery3ZdDjordJINNsVVzB3cg9daLkQAg>
X-ME-Received: <xmr:UnJEagpfYF18KjTJI-ANLnqn91taNsWtuhx7HaQTkAi3s7xlTsL3dCdcbOhNv8SXJg>
X-ME-Proxy-Cause: dmFkZTGNb6u9hkoRKrj4F0VMWONjQGQ0sMqfG8jqo0midHUNrLKBvLazrGc4JjSPiJb0og
    EkiUOt4+kuX6ZXtdexf5/bDeErt0YmrasvHAneid0CeBLFm07lY3AdmDw9hlaydLds8wqn
    RdWN5L2A0olRXrMfsmON0e0w29GCIKjeg03l+7eu9mWLxzmSneix964hbKetmfRoKetb5V
    9RdrY77VnmefgAOQdNz8xgFn5KHJhA4CbHRR+ZzudsH2T+HDWcMBi98FkIxZZkNmQzm03O
    7swE9SWvRGhsw46MHO+lXRCNaGerdVSWsM3O/k88OrS0qUMSdMAU9LsxKYmQ2L8w/n+SD8
    MYKxmgJk3NRCXy5192iGBWhb95jF/uaNYH+wgkQjQVW5knHDi6iKTCi0/MbJGyiMlSnQrr
    CenC1Wx+I/0K4rV/ZrqSf0VvdcATHacrTRMD7zHAe4uN7aXU04tIURdhPgDCdG5d4v/GYF
    JSqV5//CYcM/mwUrFRz/NMciSkBKNt1GMPsh8FBjCz6asPSAaEYDZ7hBSfe023XlIxeu4c
    XqnhrPWtX6OhWuvdwvDwJM3y+KmNotBbIpAdPXwH+i1rgYrLli5/jgRNTny2amEfZt+wpx
    U+z2e3PaEU0GYxz8ST9MpLe3WvsOtLYZVRila+H+UkLMBEwPjsxBYnPsEqIA
X-ME-Proxy: <xmx:UnJEanEpRbLohyaWz0NQWhKeHrMxoeRYS7K2IndozZTn0-_OkmOezg>
    <xmx:UnJEal4n4QULiH2f_CbP8Ysc3oCBEvy9zVehOIAkqz_hUT0Af8HPkg>
    <xmx:UnJEavcdsBDx8I8SbeB4BpXZ69bsPkWvL0STwav2b4dQPPsq06lpCg>
    <xmx:UnJEag7lQpuFHrXU06E1UqKjmcvOzF7Pn_sCUWH6vJ7Zdm2GHGNRhw>
    <xmx:U3JEajlupWSUJ9pq7Fjqqe84bUJoH3GH58Z0sUzMxVnwsHyhJYii0rRN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 21:50:08 -0400 (EDT)
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
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <cel@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH 5/4] sunrpc: protect the svc_pool_map pool_to[] array with RCU
In-reply-to: <20260630124847.289974-1-jlayton@kernel.org>
References: <20260629-sunrpc-pool-mode-v3-0-d92676606dfd@kernel.org>
  <20260630124847.289974-1-jlayton@kernel.org>
Date: Wed, 01 Jul 2026 11:50:01 +1000
Message-id: <178287060141.27465.14090245730909314119@noble.neil.brown.name>
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
	TAGGED_FROM(0.00)[bounces-22902-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,ownmail.net:dkim,ownmail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06D856E91A6

On Tue, 30 Jun 2026, Jeff Layton wrote:
> svc_pool_map_get_node() reads the global svc_pool_map without holding
> svc_pool_map_mutex and dereferences m->pool_to[]. The array was both
> published and torn down without any synchronisation against that
> lockless reader:
>=20
>  - svc_pool_map_get() incremented m->count to one before
>    svc_pool_map_init_pernode() allocated and filled the arrays, so a
>    reader observing the map as "in use" could see a NULL (or partially
>    built) pool_to[] and oops.
>=20
>  - svc_pool_map_put() freed the arrays as soon as the last reference
>    went away, so a reader that had already started dereferencing
>    pool_to[] could use it after free.
>=20
> svc_new_thread() takes this lockless path for every service, including
> unpooled ones that hold no map reference, so the reader genuinely can
> run concurrently with another service's startup or shutdown.
>=20
> Publish pool_to[] with rcu_assign_pointer() only after it is fully
> built in a private allocation, and have svc_pool_map_get_node()
> dereference it under rcu_read_lock(). On teardown, clear the pointer
> and defer the free past a grace period with kfree_rcu_mightsleep().
>=20
> svc_pool_map_set_cpumask() also reads pool_to[], but its caller holds a
> map reference (it checks sv_nrpools > 1) so the array is stable; it uses
> rcu_dereference_protected() rather than taking the read lock.
>=20
> to_pool[] needs no such treatment: it is only read by services that
> hold a map reference, so it cannot be freed under a reader.

I don't think this is the best approach.
The problem only occurs when svc_create() is used as when
svc_create_pooled() is used, svc_pool_map_get() is called early so a
reference is held to svc_pool_map.

svc_new_thread() is the only caller of svc_pool_map_get_node(), and it
can easily check pool->sv_is_pooled and only call
svc_pool_map_get_node() is sv_is_pooled is true.  When false it should
probably use NUMA_NO_NODE.
e.g.

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ae9ec4bf34f7..063826702f46 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -800,7 +800,10 @@ int svc_new_thread(struct svc_serv *serv, struct svc_poo=
l *pool)
 	int node;
 	int err =3D 0;
=20
-	node =3D svc_pool_map_get_node(pool->sp_id);
+	if (serv->sv_is_pooled)
+		node =3D svc_pool_map_get_node(pool->sp_id);
+	else
+		node =3D NUMA_NO_NODE;
=20
 	rqstp =3D svc_prepare_thread(serv, pool, node);
 	if (!rqstp)


NeilBrown


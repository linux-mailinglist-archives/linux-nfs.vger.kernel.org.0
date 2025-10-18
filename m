Return-Path: <linux-nfs+bounces-15358-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D510CBEC268
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0E2746A21
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8D1388;
	Sat, 18 Oct 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="aYoDlHZQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TRXg0TEv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970E4C6D
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746289; cv=none; b=afarfDQhcMKDPKDsvEaWtZzac2JWlMeP01O7U8eHLt2GurCSnxmlxr2PjDmXti0koeKBvWPJJo8KAT65YtBhruLG8l+ptc5mguUGyUYavHEFUjYR8gRO3asVtjiNLq9br7nN3Nusu3Q50jmrdiaY/LlLxxeZW22kcWpYPfSEjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746289; c=relaxed/simple;
	bh=A5Dq6OZppJaxkQxRr/Hv746eLVRh7cc4NIq4ZEUe6CQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=nzY2JNOjttZMrOAPAi+ugiqCx9qpOBomY5+bd1aaW3oI6FmrI3q2JV4+XNcN4zAIbqueuNlqk+Qry3wJgclBLrGKSCZFLWoDAyO1JZVUBfrz8dgpvr+BO/vi5wKdUkZdlSPGB7hHzHIrab5stfCtIAOQU2f3933OjWiL9zfKcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=aYoDlHZQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TRXg0TEv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38F407A009B;
	Fri, 17 Oct 2025 20:11:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 17 Oct 2025 20:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm2; t=1760746287; x=
	1760832687; bh=gCxaGx4DeGGMuhxUObCSK4deBcjdDzeMqfHNUfUZklQ=; b=a
	YoDlHZQqq2SK8nsLB53IT5WEBRPVr/ZXEtAfseh7mqFkNUlNA6ZxOAFau6NgKvHj
	32jqVX3eKUj3vdA+Lpyi+Q4I+eWAxTY3xaVuh+d8gobPAZvhDJwChO8gK06bDYdG
	i+78hzTvUQQbhulTynrbsVgrdJkgd3lFp3K+pKlgIzg2uhSefgwnG+LP5r5yZwbP
	Gv/jS/6GK3zg8oPWZMJNAaqJBcVax3q57vIaheyH19bzTLrhtbIBzfKs++AISGNs
	ELPXdHzmdV6nFPOhj6iMg/pjAZH4Pmo9RkKDdL7wZiH1D5w+3XtHsD/ET1w6EoGA
	Dw6AghngVtQr/SdcPGQNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1760746287; x=1760832687; bh=gCxaGx4DeGGMu
	hxUObCSK4deBcjdDzeMqfHNUfUZklQ=; b=TRXg0TEv6NcGGlRFDq0hGhodtSPxs
	KfEv88pous6lGczCK2M044zG6aXZfyxIYSxcQEP6M8UnNU4mIbRSpQGjlykj/L5+
	3DrlGxw5+KsfKFzkOLwWaCc7JbV/1Z6N/wPPu9nUIV7JtRhpv6DrLllu0Kz8CZxB
	k4TbcVLshh0koYbaCAUWcwGRELrPLr0hCAWTlp0Brm9JQZnXaK+Th+9C4DD3BC9l
	0esgK/xiLJqmmFyfeulOxott/+smuRx3DOPX6RXKaciC8hqUE5NmbvUxKDAyqzht
	YVumaClY7CN4IgAvNShensk/qRJJhzsQsGPTyznxhKQMD+puSad0KxFJQ==
X-ME-Sender: <xms:LtvyaJG2Iqc6ck7j2Zqet40-yanKNscBQFvaF3vLl1KogNHaOVRAGw>
    <xme:LtvyaCBD61wa3WzrZOPUUuaZZSghilN-s3VWHX3IZAXd8aO0tl-6VB1r63sLTK9wU
    c8GUbeSLL1LmLJGfM046l53iqD0uel0Yw8wQmuOvRF-_QgnTA>
X-ME-Received: <xmr:LtvyaE-vvdgrW0di33s5fUKOT7BHgU0FaUglpSMUR_jPOc_6egqWW7qz0KumaGasrf1oc5eQDxlboE-CitYiz2DQyTGENeP0KN_LKdmzYVQV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepff
    ehfeettedtieetuedtgeevfffhffdtheelleffffeujedvleevgfdvgfelleeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhnihgv
    vhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrg
    gtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LtvyaGAOBrflP-3vfQtC23VS2VJdhAdcngTv4jS3ElUPTGnMx8tCWw>
    <xmx:LtvyaBQudEV6rZUrzFvp3PPbeYhSQmviiUO0jq9YPLlVebouj0WIQQ>
    <xmx:LtvyaFu1fVWw87vgDeGCFTUc2P1Ff0tgpW7pXi8E9X8bsoUj6qskFw>
    <xmx:LtvyaF1wYn8cdDyRrAoWI_lfFgynpm2VOREqIuS-KQMQVF7Mw9BnJw>
    <xmx:L9vyaOkGaRVbwjDFDRAF2dg1ONa4ebcASr47YcaftYhps-YOWC4V42Za>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 20:11:24 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc/cache: improve RCU safety in cache_list walking.
Date: Sat, 18 Oct 2025 11:11:23 +1100
Message-id: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

1/ consistently use hlist_add_head_rcu() when adding to
  the cachelist to reflect that fact that is can be concurrently
  walked using RCU.  In fact hlist_add_head() has all the needed
  barriers so this is no safety issue, primarily a clarity issue.

2/ call cache_get() *before* adding the list with hlist_add_head_rcu().
  It is generally safest to inc the refcount before publishing a
  reference.  In this case it doesn't have any behavioural effect
  as code which does an RCU walk does not depend on precision of
  the refcount, and it will always be at least one.  But it look
  more correct to use this order.

3/ avoid possible races between NULL tests and hlist_entry_safe()
   calls.  It is possible that a test will find that .next or .head
   is not NULL, but hlist_entry_safe() will find that it is NULL.
   This can lead to incorrect behaviour with the list-walk terminating
   early.
   It is safest to always call hlist_entry_safe() and test the result.

   Also simplify the *ppos calculation be simply assigning the hash
   shifted 32, rather than masking out low bits and incrementing high
   bits.

Signed-off-by: NeilBrown <neil@brown.name>
---

I was looking at this code a while back while hunting for a bug that
turned out to be somewhere else.
I notice point 1 and 2 above and thought that while of little
significance, I may as well fix them.  While examining the code more
closely as part of preparing the patch I noticed point 3 which is a
little more significant - clearly a bug but not particularly serious (I
think).

NeilBrown


 net/sunrpc/cache.c | 61 ++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 131090f31e6a..1dc84522de45 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -133,11 +133,11 @@ static struct cache_head *sunrpc_cache_add_entry(struct=
 cache_detail *detail,
 		return tmp;
 	}
=20
+	cache_get(new);
 	hlist_add_head_rcu(&new->cache_list, head);
 	detail->entries++;
 	if (detail->nextcheck > new->expiry_time)
 		detail->nextcheck =3D new->expiry_time + 1;
-	cache_get(new);
 	spin_unlock(&detail->hash_lock);
=20
 	if (freeme)
@@ -232,9 +232,9 @@ struct cache_head *sunrpc_cache_update(struct cache_detai=
l *detail,
=20
 	spin_lock(&detail->hash_lock);
 	cache_entry_update(detail, tmp, new);
-	hlist_add_head(&tmp->cache_list, &detail->hash_table[hash]);
-	detail->entries++;
 	cache_get(tmp);
+	hlist_add_head_rcu(&tmp->cache_list, &detail->hash_table[hash]);
+	detail->entries++;
 	cache_fresh_locked(tmp, new->expiry_time, detail);
 	cache_fresh_locked(old, 0, detail);
 	spin_unlock(&detail->hash_lock);
@@ -1361,18 +1361,14 @@ static void *__cache_seq_start(struct seq_file *m, lo=
ff_t *pos)
 	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
 		if (!entry--)
 			return ch;
-	n &=3D ~((1LL<<32) - 1);
-	do {
-		hash++;
-		n +=3D 1LL<<32;
-	} while(hash < cd->hash_size &&
-		hlist_empty(&cd->hash_table[hash]));
-	if (hash >=3D cd->hash_size)
-		return NULL;
-	*pos =3D n+1;
-	return hlist_entry_safe(rcu_dereference_raw(
+	ch =3D NULL;
+	while (!ch && ++hash < cd->hash_size)
+		ch =3D hlist_entry_safe(rcu_dereference(
 				hlist_first_rcu(&cd->hash_table[hash])),
 				struct cache_head, cache_list);
+
+	*pos =3D ((long long)hash << 32) + 1;
+	return ch;
 }
=20
 static void *cache_seq_next(struct seq_file *m, void *p, loff_t *pos)
@@ -1381,29 +1377,30 @@ static void *cache_seq_next(struct seq_file *m, void =
*p, loff_t *pos)
 	int hash =3D (*pos >> 32);
 	struct cache_detail *cd =3D m->private;
=20
-	if (p =3D=3D SEQ_START_TOKEN)
+	if (p =3D=3D SEQ_START_TOKEN) {
 		hash =3D 0;
-	else if (ch->cache_list.next =3D=3D NULL) {
-		hash++;
-		*pos +=3D 1LL<<32;
-	} else {
-		++*pos;
-		return hlist_entry_safe(rcu_dereference_raw(
-					hlist_next_rcu(&ch->cache_list)),
-					struct cache_head, cache_list);
+		ch =3D NULL;
 	}
-	*pos &=3D ~((1LL<<32) - 1);
-	while (hash < cd->hash_size &&
-	       hlist_empty(&cd->hash_table[hash])) {
+	while (hash < cd->hash_size) {
+		if (ch)
+			ch =3D hlist_entry_safe(
+				rcu_dereference(
+					hlist_next_rcu(&ch->cache_list)),
+				struct cache_head, cache_list);
+		else
+
+			ch =3D hlist_entry_safe(
+				rcu_dereference(
+					hlist_first_rcu(&cd->hash_table[hash])),
+				struct cache_head, cache_list);
+		if (ch) {
+			++*pos;
+			return ch;
+		}
 		hash++;
-		*pos +=3D 1LL<<32;
+		*pos =3D (long long)hash << 32;
 	}
-	if (hash >=3D cd->hash_size)
-		return NULL;
-	++*pos;
-	return hlist_entry_safe(rcu_dereference_raw(
-				hlist_first_rcu(&cd->hash_table[hash])),
-				struct cache_head, cache_list);
+	return NULL;
 }
=20
 void *cache_seq_start_rcu(struct seq_file *m, loff_t *pos)
--=20
2.50.0.107.gf914562f5916.dirty



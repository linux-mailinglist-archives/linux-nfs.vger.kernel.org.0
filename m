Return-Path: <linux-nfs+bounces-11651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D87AB2100
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 05:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9915C4E0063
	for <lists+linux-nfs@lfdr.de>; Sat, 10 May 2025 03:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B74846F;
	Sat, 10 May 2025 03:02:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B0259C
	for <linux-nfs@vger.kernel.org>; Sat, 10 May 2025 03:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746846121; cv=none; b=VyWerfR0ydgsmRoR7X4GeNI8kpvbImAI54gieBA5n0t3y+k6YfgZVm9TYqHR/qm43jMcvX+m6cBoc2Hx4fPm6K/3ByW8oZdIlbC7We76mY5LoSHxWh574R0oTZCwR91WoVBSz4IB11n4XuMRAG15DTN4cpC5P7ENGIJvQsBKJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746846121; c=relaxed/simple;
	bh=XAv5m324M98wzikAq0f6eHnJQpBR/WBVRJLJ33dl6GQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bqQR20TcZ/QFI5Oh/RqsWa3Uo7bm0luLahPOh4Fv4NOISB/MVer/Dit8s80VF5ztRrbHSGIyb/ukpp5ATJlSiGPdn0uyfV81CpGKb4QjGzB5G+Tnqr2O8CZKmXhZ406P2Lfw6vcyQwsT2g/mh2RUtOsAn+sKdjyRb8qJOhtQr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uDaTL-000crr-O8;
	Sat, 10 May 2025 03:01:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Mike Snitzer" <snitzer@kernel.org>,
 Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 paulmck@kernel.org
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from older
 compilers
In-reply-to: <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>
References: <20250509004852.3272120-1-neil@brown.name>,
 <f540ef6a-705a-4987-87b5-fd6753174289@oracle.com>
Date: Sat, 10 May 2025 13:01:55 +1000
Message-id: <174684611546.78981.17530209113609371873@noble.neil.brown.name>

On Sat, 10 May 2025, Chuck Lever wrote:
> [ adding Paul McK ]
>=20
> On 5/8/25 8:46 PM, NeilBrown wrote:
> > This is a revised version a the earlier series.  I've actually tested
> > this time and fixed a few issues including the one that Mike found.
>=20
> As Mike mentioned in a previous thread, at this point, any fix for this
> issue will need to be applied to recent stable kernels as well. This
> series looks a bit too complicated for that.
>=20
> I expect that other subsystems will encounter this issue eventually,
> so it would be beneficial to address the root cause. For that purpose, I
> think I like Vincent's proposal the best:
>=20
> https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62@wana=
doo.fr/raw
>=20
> None of this is to say that Neil's patches shouldn't be applied. But
> perhaps these are not a broad solution to the RCU compilation issue.

Do we need a "broad solution to the RCU compilation issue"?
Does it ever make sense to "dereference" a pointer to a structure that is
not fully specified?  What does that even mean?

I find it harder to argue against use of rcu_access_pointer() in that
context, at least for test-against-NULL, but sparse doesn't complain
about a bare test of an __rcu pointer against NULL, so maybe there is no
need for rcu_access_pointer() for simple tests - in which case the
documentation should be updated.


(of course rcu_dereference() doesn't actually dereference the pointer,
 despite its name.  It just declared that there is an imminent intention
 to dereference the pointer.....)

NeilBrown


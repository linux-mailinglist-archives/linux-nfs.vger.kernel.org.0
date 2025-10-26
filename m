Return-Path: <linux-nfs+bounces-15642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FF8C0B67A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 00:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 991FD4E1343
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Oct 2025 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2BA4502F;
	Sun, 26 Oct 2025 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XgtjPS1Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAwUikuL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD45EEAB
	for <linux-nfs@vger.kernel.org>; Sun, 26 Oct 2025 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519680; cv=none; b=s6dI1m+Q7w5mxgXQRO+hh3Ta0AKvBAs1MYS5CBWUPwaGIaClgG0dYoUMl76Y1YHRy97pvdTqXXsKWd/wnhzJnlf7TZHFxhJI3noCX4/2Xqa9ieGy4Z6+iqjOj7hf8O9VKOAGg3rpBsNjB8xMACiPgb6W/X0b3VztVzRe88EmJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519680; c=relaxed/simple;
	bh=BayWPvRBdSJQWzjKLv7DczfsfzmClE9y39ucIfE45xQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ncTRdmE2njVuwDA4Wv6FUZI8TLkirUYkWUiv/+bURTK5qwt7+cPCri8DjwNVgqGBRgz2OOe+h48geWnEEGZspJSvvAxar5QqrqUlPqdi6t8162sGhE4tmJwW4d9NBPRqoUa24PC3nF/t61EjbVN5ltu03v+RLsZW7fk1T2shguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XgtjPS1Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAwUikuL; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 191F37A014B;
	Sun, 26 Oct 2025 19:01:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Oct 2025 19:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761519676; x=1761606076; bh=DH/w8S4kOOHZslXxE8V6Ab5ys24pkI+MwsM
	NlBndG0s=; b=XgtjPS1YK1m547vpM3vGkaV4VH+RSa7MdQReR79YUsq5anqPVJJ
	deG+iAGIV2/64XZQVykqRbCygbwdW6W/nUIYnqAXjI54907MQdwdToIeK5p7q6dc
	ISemXRuyRLOz9VlgIWTL8SHhBQGTLyqEtaVhZEN4msEkRpuK9LNddt1DRpwRpxpU
	h/GPqDMiMEOH3uEgHclqS8KIBThAkuFhcEEJcsA6AbN+YNVKIuvyDHoRsNoDZVt/
	UZ94gaFLwYgeeVbTrf2QpzFbKcx6qFGNsOExq5RnXvzCsoRe2EJ1zm61cWK6GZrZ
	kDhi+psMaHz/NV6YjOWNA5mEHpJ0WZikA/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761519676; x=
	1761606076; bh=DH/w8S4kOOHZslXxE8V6Ab5ys24pkI+MwsMNlBndG0s=; b=Y
	AwUikuLaa8y4tkM0jMvMbNZVnOLbAEw2fSv5Qo60/8nXmEG1oDsRaDUTP6jp6hLY
	KEFm+qt9tY6jmMGB8l1nfiluB0JA3as8eCzi6AuUgMVlOx9A+CI2SN+9AcRJ+hs3
	a/pd3wV0+Hf3B8b9IhlChZaKJ1TQILc0a345tscVjLxvSh/yjsDhB4JkDIY7jGJb
	xBZKBxIRtGbyWtMB4zugbzpTMZRFSdyQn1GltoHvF0XngELWjQWv92AEDxpeSvwt
	2Lpp3MXJ3NrCJ5vofCPCpXW/xyd/Y/7xHgouo3fUDjEVbr7ibY/N+OvahbX9wkCv
	Aysb/HSjm5B0rhlLYxLvg==
X-ME-Sender: <xms:PKj-aLKv3bHYJdESRwZHNwaGJIWRoLpBbzrsRqVhOs1Kd-P6XLFSog>
    <xme:PKj-aC38xjJrUNdQdq009NlmfZ6Vjoi-qa5Me2dv2OgkkDjKcbYe-iDcvja5KPi_d
    e6RwiDK2dfLEm50_SeBvptHpEF6rfHHEzTGeGCALAd0oDBNhg>
X-ME-Received: <xmr:PKj-aNgniS2JaqWAiYHHIV0q7G7x7I6epiifx9O_zeYbudRSkpj9Edug7syAv2cvCHQ9FotGZn4H8MjMI1vv-_ZNDcyFVvBWvt3FdHGX5u1F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleehueeggfegteduieeggeetvedvheegvefhgffhgeejgeekffehgfevvdfhledvnecu
    ffhomhgrihhnpehophgrqhhuvgdrshhonecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgv
    hidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    uggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PKj-aLV2P4yqfkBPsptTgy7Z-7cXOhoRaRzDbQauVr_IhQosp8sWcg>
    <xmx:PKj-aEX4_YaO81WJSOeG0nAboEMNKurO40mJEqe1R-_08wdkkLYgHg>
    <xmx:PKj-aDjS_OuzEPowrJ2T02F94T9VTPwWC6xvthxPmhhJmApEgzo0gQ>
    <xmx:PKj-aHZILAlRP2Qbc0vlZBn13pbgYpjAXcv54t2z3pkMvzyB37wFoA>
    <xmx:PKj-aEpTaWr3oZyoYd7C6OHPkMKob5GdI32kbt3sGp6YutWuFnz_BbQu>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 19:01:14 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v3a 02/10] nfsd: drop explicit tests for special stateids
 which would be invalid.
In-reply-to: <20251026222655.3617028-3-neilb@ownmail.net>
References: <20251026222655.3617028-1-neilb@ownmail.net>,
 <20251026222655.3617028-3-neilb@ownmail.net>
Date: Mon, 27 Oct 2025 10:01:12 +1100
Message-id: <176151967298.1793333.13856723160983723087@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


In two places nfsd has code to test for special stateids and to report
nfserr_bad_stateid if they are found.
One is for handling TEST_STATEID ops which always forbid these stateids,
and one is for all other places that a stateid is used, and the code is
*after* any checks for special stateids which might be permitted.

These tests add no value.  In each each there is a subsequent lookup for
the stateid which will return the same error code if the stateid is not
found, and special stateids never will be found.

Special stateid have a si.opaque.so_id which is either 0 or UINT_MAX.
Stateids stored in the idr only have so_id ranging from 1 or INT_MAX.
So there is no possibility of a special stateid being found.

Having the explicit test optimised the unexpected case where a special
stateid is incorrectly given, and add unnecessary comparisons to the
common case of a non-special stateid being given.

In nfsd4_lookup_stateid(), simply removing the test would mean that
a special stateid could result in the incorrect nfserr_stale_stateid
error, as the validity of so_clid is checked before so_id.  So we
add extra checks to only return nfserr_stale_stateid if the stateid
looks like it might have been locally generated - so_id not
all zeroes or all ones.

Signed-off-by: NeilBrown <neil@brown.name>
---

Sorry - shortly after posting I realised that the change to prevent
nfserr_stale_stateid being reported incorrectly could mean it was not
reported when it should have been.  So I added back a simple test for
"might this be special" in the error path to ensure the correct error.

 fs/nfsd/nfs4state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e1c11996c358..a800fde0db21 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7129,9 +7129,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client=
 *cl, stateid_t *stateid)
 	struct nfs4_stid *s;
 	__be32 status =3D nfserr_bad_stateid;
=20
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s =3D find_stateid_locked(cl, stateid);
 	if (!s)
@@ -7186,13 +7183,16 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cst=
ate,
=20
 	statusmask |=3D SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
=20
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
-		return nfserr_bad_stateid;
 	status =3D set_client(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status =3D=3D nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
+		if (stateid->si_opaque.so_id + 1 <=3D 1)
+			/* so_id is zeroes or ones so most likely a
+			 * special stateid, certainly not one locally
+			 * generated.
+			 */
+			return nfserr_bad_stateid;
 		return nfserr_stale_stateid;
 	}
 	if (status)
--=20
2.50.0.107.gf914562f5916.dirty



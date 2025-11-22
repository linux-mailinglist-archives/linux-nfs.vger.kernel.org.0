Return-Path: <linux-nfs+bounces-16653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944BC7C091
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387544E0318
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660A7201004;
	Sat, 22 Nov 2025 00:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="NBtUCQh2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lV3THl6E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A9239E80
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772786; cv=none; b=jc2amR8UhZaSiF/haENkcOFS2NShdTyhuXQ3U3QPYo1FzE8QKKDLZ7sWaPgmD0rrqpUeBStajfzNrDStahOlcFXM8Oip1AmF9XESc4JScEXE4ZtiSY2j9/4JpxDuQfvXI3PH+NaWyZckkK4V5MJMY+zZCSfEljDvtO6A+poLjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772786; c=relaxed/simple;
	bh=aKwACQvOWzsZquIrNdJAdD6Cjtac0mG+ZlrGpFB3fNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fc6n+to3isanag9glCFqQmWJDdFqo0l5R815fGtOjaYor3sj/DeOTM64Xvpqhc+o0goaXNYI5PnCAJr7tAJzmxIvmgz79COqFkzehroKr4MUWzsdDBBANdxWqHDIjppEw8v5wXsZBSA1TBBW3VyABZWYOvLCT2zj7FdI3PF4O+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=NBtUCQh2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lV3THl6E; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D449414000CE;
	Fri, 21 Nov 2025 19:53:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 19:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772783;
	 x=1763859183; bh=pOtGzmF4SIe6MtBgkZrF8l6vPs1qrsELj9DKAUa5z80=; b=
	NBtUCQh2xW7e2lAXcfcQcXTq0d8nXUpnadFyRVGSi9c0UaqmAilCxjQtv9GM1h5Z
	H7NceczDyovEJROLgMGLv/svLP1i5xGiBwyqPUE8YDmgcpLqPMDJ/9Ell6bWUZiA
	yUcZ9X5flO5y0yBnq9TFKNOtIJeCo32+tdXy9EzJq5G5x9CewbV9LwBel3BdvbUZ
	oi1i44BRKeqdjoxxjpGGH5/REvbiJ895rHhd6tQ7SP+Kx9O75HUvvXTi6eVQ7hsS
	mzOpkCeCRYFSa1J+uqYb74lA+BCi4QCyng1dzvVXA5A6F954azgJAlDwIC/uUNXn
	mWIkGWWLTH/aU4PjkjZD6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772783; x=1763859183; bh=p
	OtGzmF4SIe6MtBgkZrF8l6vPs1qrsELj9DKAUa5z80=; b=lV3THl6EjbpFf/LGp
	Yz8nAaAVfStm6ekm57YXU0q9AAfT8h9xpFHwgUq7gUPiKdVfVwj3knpa0T6rmHuD
	v0A/AHshCVXonTpacZWidOp0CRyir8ri5qnpQKVPdWWouFIDON3pDEbKQ2XOgRu5
	Y3UcrViMHZhtQDqCKTpZ/gnY1edHQXLxPkEp9ghGSu5+B2Hk4cidDbGbGFSlgdAb
	9frnSUxzPjdtDHql6oiDOrChUZ4VduUTeCYnykeXNSU5hmhd9LKpMj4WBuRNSgXZ
	Y4aHmE7b6/ljnmnvEJMiomoY529LhJF77MbYtMeBxf8MeoNVXmM7V8bpLCCIZxVD
	5er9Q==
X-ME-Sender: <xms:bwkhaWjoj744o-aeePcLI1g8zQTM2yEsVw34_h6sjrxw_0n9SiOebg>
    <xme:bwkhaaulZNVlTR5Xuuork3vTzwgmInwBFbVFdJAgGkXq-BvMn_7Ip0_MbuMBxSIP4
    q_QRp5ST7Fs29Q_L7odvum0CiPHnIhdDf8oiKAN8kruU8sCpg>
X-ME-Received: <xmr:bwkhaX6GGZUpu-XYVrRBEnsv8FZOmrjeWTvuFDJJIjBpmQ87xIN2DNFdN9ZoRq8qOx99JDuissu8RuMkJIn0RAtuRVKPh1OKteIs7phZlobX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:bwkhaWPnyI78p8biqpcByUd313ScG8RWm99l2seO9YjCqol1gM2SAg>
    <xmx:bwkhaVtGJ9t3rtmke-_Dyrg7fbyWnAEVmxSJX6RFR84vriWKhLDRmQ>
    <xmx:bwkhaZbVAu5EyDdSdsC7oWIl8iltQLhzBkLCCxZfqHcL5_zsE_r48w>
    <xmx:bwkhaXwrautg3vLeZHn23OlXznPm-ub4K1Y2kNm3_XIhlyamjJQ9GQ>
    <xmx:bwkhaYBLXyAfnqxNmeIdsJINvJzaR3_dQyyr09UcaZdk-cxRHmXxZPt4>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:01 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 04/14] nfsd: allow unrecognisable filehandle for foreign servers in COPY
Date: Sat, 22 Nov 2025 11:47:02 +1100
Message-ID: <20251122005236.3440177-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122005236.3440177-1-neilb@ownmail.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

RFC-7862 acknowledges that a filehandle provided as the source of an
inter-server copy might result in NFS4ERR_STALE when given to PUTFH, and
gives guidance on how this error can be ignored (section 15.2.3).

NFS4ERR_BADHANDLE is also a possible error in this circumstance if the
foreign server is running a different implementation of NFS than the
current one.  This appears to be a simple omission in the RFC.

There can be no harm in delaying a BADHANDLE error in the same situation
where we already delay STALE errors, and no harm in sending a locally
"bad" handle to a foreign server to request a COPY.

So extend the test in nfsd4_putfh to also check for nfserr_badhandle.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 112e62b6b9c6..ae34b816371c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -693,7 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	       putfh->pf_fhlen);
 	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
-	if (ret == nfserr_stale && inter_copy_offload_enable) {
+	if ((ret == nfserr_badhandle || ret == nfserr_stale) &&
+	    inter_copy_offload_enable) {
 		struct nfsd4_compoundargs *args = rqstp->rq_argp;
 		struct nfsd4_compoundres *resp = rqstp->rq_resp;
 
@@ -713,7 +714,11 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			 *  NOT return NFS4ERR_STALE for either
 			 *  operation.
 			 * We limit this to when there is a COPY
-			 * in the COMPOUND.
+			 * in the COMPOUND, and extend it to
+			 * also ignore NFS4ERR_BADHANDLE despite the
+			 * RFC not requiring this.  If the remote
+			 * server is running a different NFS implementation,
+			 * NFS4ERR_BADHANDLE is a likely error.
 			 */
 			ret = 0;
 		}
-- 
2.50.0.107.gf914562f5916.dirty



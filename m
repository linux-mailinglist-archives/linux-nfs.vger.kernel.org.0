Return-Path: <linux-nfs+bounces-16509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 754BAC6CA00
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 04:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB3234E857E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 03:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65D2D8396;
	Wed, 19 Nov 2025 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eb5KNyYB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tb3Bg9T/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B32EC579
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 03:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523147; cv=none; b=eFy+D10Xxc9JzQR4aPvw7gWVxpQdozp6atk8nGy5Px8Z4X/nloEoHul+y+4BCfrsqAmVsPAoCCpSNKoc6pmlmbvdw3jLb4pYD2oPOlNsgK78NUtsFJBybaaYkbYm+TOL0nuxG5sH0bpr3QGbJtAjdT4rEEJNbb7kLpHTyHDSTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523147; c=relaxed/simple;
	bh=Ntu6LwxkgEWyHvnxMKIkkE+U+dRlAessRru3QKACZUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pkt2VFR1sEwBOUa2CZbpl+Zi3xnKveafoiGKnr3niBuBxy3d0kWGwLzjn4Qiyw0M+tH4uKBmlsEwE3QSc+iqr2V5U28wfQrYW3BkUJDXeB0k9XMlaVz9IAqTPi4LbyyO89UcEQXVym+xc1McI10dl0OWFWE1vLTZwlOFRQ4MRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eb5KNyYB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tb3Bg9T/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F9741D00151;
	Tue, 18 Nov 2025 22:32:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 22:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763523144;
	 x=1763609544; bh=1N+HM5w6IA0rYmDE5/bcQB2qMf8Htzm/XsQmC5cw7GE=; b=
	eb5KNyYBPcNmIUYqUvd2iCqUzUDClL1xyZsyyQXvX7ObzYP0VqMJLvdEu6+YvZfU
	wmfHTVQs+7MdpBrQw31CslW5cfVuotVFJFrL1lOptliPGCwxemZLNN1m0ptAeDhV
	8vUEWntzruDkgAu8qu3/POn4HO+45ou4ySYf8CftSf1n9Cv0SaWltUbaBOjt4+jX
	QN/PR++Jqnt+c1DLbZZJ/LfLI9pJw7xLmcSEo1V5wI5DwqPdPYcR3esMYLUj6INr
	VGJ5w2Imm1j+N+IcTUv7+DWK5f2l6ZIA8wQoocKSANYvpIdRoMHj3bAa1/4qshVa
	/L6Q8xpJji7QqRfl9sD93Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763523144; x=1763609544; bh=1
	N+HM5w6IA0rYmDE5/bcQB2qMf8Htzm/XsQmC5cw7GE=; b=tb3Bg9T/yX7aJ4JDZ
	j5GY0Jr9D2R91wFqG4YV/boXFJgg1TI94Y8YX7ZdL2eM0slSrNbpsr2mUuXniHRb
	2ukOHbmdX1Py66SlPcc1dZMPIWQgPm9R4q7A6ytLwXYcFnKno8n6VGMn3NdDaHtm
	VjyIQkT/AXyg3JB/EYf37VnJ5M1XK/60IZDT2hYXT5NM9NWAIEypmgs2Go9etAH9
	CbxbpucA4V1yWZ6ovImfRD+bJRoiKt+U0elM81GPKrxE3iHHND1MCc2yLMA+FsRA
	rhCXcNrqirMi5kvfDIbkJxhiod6L+XXTLBACX/3+H4fgegL9EUV8vUa3h7UIUdaN
	uFhgw==
X-ME-Sender: <xms:SDodae3PjkxdET3v-moaFk4_h_hz3YYpsGLvjq9Iaz6v1mheQgLY5A>
    <xme:SDodaUy3ihO076DumWaj3QABboRe3qb8XXS-L6BRmJVMBoFaGweuUcWOX-w9FH5o_
    xEpym5VpCy_KWLsB5JOzWcZgiifq3gLvmdem3bo2ldJUcSIZw>
X-ME-Received: <xmr:SDodaQuukR06DF0xkSslt7450p20w59p22-Dw4Gq524tEVNNjXW439rRdi0Vzq2ZwyvISTra_jkLR6O6hp0mvc_KH30UCEHVLil5dCALJDvT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefudefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SDodaWxsdllEbYl3WbcovXJJ0vj6dL675EZSO5Rd5lmwFYPPDmOqoQ>
    <xmx:SDodaTAB23593tAp2dXdQPhMYWRRpvDElvKW2rp6gGgux9cpYZSSvg>
    <xmx:SDodaUfAwA0veEkSuUKD7CPziPMzMK36B8QJ1T4jwzDT92i-1OQ7Vg>
    <xmx:SDodadkeTunvDnupDe0Uh6z_SKMdxQffdooo26wTD8EDJbzI6qp4Xg>
    <xmx:SDodaUXrkwbvua5bXUgbHRsNJXprHe7DYSphkoTlZfOuRdulSMXQW8_T>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 22:32:22 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 02/11] nfsd: discard NFSD4_FH_FOREIGN
Date: Wed, 19 Nov 2025 14:28:48 +1100
Message-ID: <20251119033204.360415-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251119033204.360415-1-neilb@ownmail.net>
References: <20251119033204.360415-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

NFSD4_FH_FOREIGN is not needed as the same information is elsewhere.

If fh_handle.fh_len is 0 then there is no filehandle
else if fh_dentry is NULL then the filehandle is foreign
else the filehandle is local.

So we can discard NFSD4_FH_FOREIGN and the related struct field,
and code.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 7 ++-----
 fs/nfsd/nfsfh.h    | 4 ----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e5871e861dce..3160e899a5da 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -693,10 +693,8 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	       putfh->pf_fhlen);
 	ret = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
-	if (ret == nfserr_stale && putfh->no_verify) {
-		SET_FH_FLAG(&cstate->current_fh, NFSD4_FH_FOREIGN);
+	if (ret == nfserr_stale && putfh->no_verify)
 		ret = 0;
-	}
 #endif
 	return ret;
 }
@@ -734,8 +732,7 @@ nfsd4_savefh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * is not required, but fh_handle *is*.  Thus a foreign fh
 	 * can be saved as needed for inter-server COPY.
 	 */
-	if (!current_fh->fh_dentry &&
-	    !HAS_FH_FLAG(current_fh, NFSD4_FH_FOREIGN))
+	if (cstate->current_fh.fh_handle.fh_size == 0)
 		return nfserr_nofilehandle;
 
 	fh_dup2(&cstate->save_fh, &cstate->current_fh);
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 5ef7191f8ad8..43fcc1dcf69a 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -93,7 +93,6 @@ typedef struct svc_fh {
 						 */
 	bool			fh_use_wgather;	/* NFSv2 wgather option */
 	bool			fh_64bit_cookies;/* readdir cookie size */
-	int			fh_flags;	/* FH flags */
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
@@ -111,9 +110,6 @@ typedef struct svc_fh {
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
 } svc_fh;
-#define NFSD4_FH_FOREIGN (1<<0)
-#define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
-#define HAS_FH_FLAG(c, f) ((c)->fh_flags & (f))
 
 enum nfsd_fsid {
 	FSID_DEV = 0,
-- 
2.50.0.107.gf914562f5916.dirty



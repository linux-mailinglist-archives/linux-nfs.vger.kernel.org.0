Return-Path: <linux-nfs+bounces-15825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D4C23299
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 04:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 018994EAC6D
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 03:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC99E26AA94;
	Fri, 31 Oct 2025 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LmNE9GO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vDrLyntE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1D228E5
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 03:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881146; cv=none; b=XnnqqUfSJYxaLpqixLMZhtL4I/LCEqgPMCQLmYqRCW4AanXBE44v4CNqS86/T9mjk2lN0pTXwCYXlFeLuhLgZd8Gb8dkJmprhSPVOMEJzhO1NdNtMWKfnPFLJS02VuMpdATuUP1AbyUe8qYBwX0pkHS92blYKyvUqd3Zz3Sk4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881146; c=relaxed/simple;
	bh=Dgv1egH+m1ssTE1XjaSwbeN9PDyEWTmYo5rFP/SMFhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT0wVbfm2E3NBkzHSqEgcBHYjXSZHXzYxJvr9ApPxHusb7SGBleq9qiZYk5IfK8o6uRK4DWTSKrgMcIjmZptKEXD2MXIQ87LJPogyBN4qnR3QviAjAbAb8Ud5Z2JZH1G17OsAvS47bm3QV1TjAULOhGz+DVS0HnCbWhJ5rGAFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LmNE9GO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vDrLyntE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD00F7A016A;
	Thu, 30 Oct 2025 23:25:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 23:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1761881143;
	 x=1761967543; bh=+deriuU6KpxunaeCrD03ffRfXWZY0sCymvKq8BvXfU4=; b=
	LmNE9GO+HvXIHf1UnltUq5H9CJdZOXQQJ4ubh9vCcvdrMs4hofJ+PfWiXqTdRlK6
	LMsP0mCqhTBcPHLUwrLAuULcdZJyCVPv9y53/F/XWgSn+OHCxpYnWM+hh1h7oJyg
	j1o9te/I7APPbnWct4dUXqEMTFGfH6ezbPLUlp6J3+kyrAbn+0q/n0uS9/QZXo4x
	4GZecfyBzf2T9SH+vmAZI6ZmvlKRiJtaxhxZq4944ZXqUG2AoGj4xGPAt1JmM0+E
	lbZq8IaHGTjP0lpaCRJY1cYdPmvhyphNyb7+uUgufKDchf83lPKasrGd1qBwmuGJ
	V+JvlOW6IZXZryBmMTHI5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761881143; x=1761967543; bh=+
	deriuU6KpxunaeCrD03ffRfXWZY0sCymvKq8BvXfU4=; b=vDrLyntE0DB1aCm4l
	8lPryyUajZ49f4U2NAgchZKredPjjGpK0JMdm5AT0byh2YuuwprOJfhZ1sHjQs4c
	wDTZ++mtjT7I2YVDObrS+I70jKFM018ZSAxcuaZIWCLtAG4G3J66utnYrW5hYEON
	44Qke0EphZc2gqD74fA63LKkxq2zWpoF9G8vBQyQDRdbFmNbjPp0GRYm9oxIiShT
	cxigwczVUsa0nOcqmcMZnhnbMGjqlBZruNwtHEuewLOgi26hp61bKdspDt/jitpD
	QoqPR6/4NjwuGPNlbom7Xe1GpIvi5bB2DDe2HMOBYu3//OqLbZQBbg0HLi8bxApZ
	IcyAg==
X-ME-Sender: <xms:NywEaeDM1Uh_CIE3UEf_dnOqEnm5a2HS_gP8vyx0p0TsXJJeV-2D8Q>
    <xme:NywEacO8Ci8_6Kw1-MUOeBif47_nAI47BiHn33nQMazNQZmUEWIC0ktKb4lfUitxV
    nMsraCx05lWpa5IgDT1mbRenwyi0wAiTYcNWOaa1hEXkJ8Q>
X-ME-Received: <xmr:NywEabbrsBOXbv2hovowdZ7gNXMStBA6cElstjc_J4UMf_socbggBfVhrVkiVa_50TqrsXCIf7musHLI7GZb-gEyQWAoWDcdt_lqujCWaM64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epheegleegleefhfdvffdvheehfeejudeugfefleeigefffffhgeevgefhteeikefgnecu
    ffhomhgrihhnpehophgrqhhuvgdrshhonecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmsehtrghlphgv
    hidrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    uggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NywEaTtQz1kWoNy51iDX5CGwY-_GQOKzCBsDfpdjE4I4npVmIubRqQ>
    <xmx:NywEaVP6MwYH1gi-fKu6A1zZd1AUwnJTL12-xHsTSMhrEZ3bhtW4Yg>
    <xmx:NywEaS5GvKRXs7zWB1KBGxsxYIqJEh1ER8CnWHAOrrJ5S7jq2Tiiuw>
    <xmx:NywEaTSsp-8nPYPYPO9MnTUHtQLxFvgAkPc4l8uPc4Jmn33VrShTlw>
    <xmx:NywEafh1ymee_budKfue3AuqB3jCBAN-MkexlhTM9PzIIOGyO5eYTPOz>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 23:25:41 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 01/10] nfsd: drop explicit tests for special stateids which would be invalid.
Date: Fri, 31 Oct 2025 14:16:08 +1100
Message-ID: <20251031032524.2141840-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251031032524.2141840-1-neilb@ownmail.net>
References: <20251031032524.2141840-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

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
 fs/nfsd/nfs4state.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..83f8e8b40f34 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7129,9 +7129,6 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
-		return status;
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
 	if (!s)
@@ -7186,13 +7183,16 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 
 	statusmask |= SC_STATUS_ADMIN_REVOKED | SC_STATUS_FREEABLE;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
-		CLOSE_STATEID(stateid))
-		return nfserr_bad_stateid;
 	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
+		if (stateid->si_opaque.so_id + 1 <= 1)
+			/* so_id is zeroes or ones so most likely a
+			 * special stateid, certainly not one locally
+			 * generated.
+			 */
+			return nfserr_bad_stateid;
 		return nfserr_stale_stateid;
 	}
 	if (status)
-- 
2.50.0.107.gf914562f5916.dirty



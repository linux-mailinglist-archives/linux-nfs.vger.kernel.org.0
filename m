Return-Path: <linux-nfs+bounces-23284-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Z0pLlqEVGpimwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23284-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F2747808
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b="nN/0Anu9";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=RkLV9410;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23284-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23284-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F392300C031
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E08343D7B;
	Mon, 13 Jul 2026 06:22:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D32D29C8
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:22:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923762; cv=none; b=gScYXeVSdPF+UwU/6RXunY10QUihZp8WU66S7HuOYNe9uIyCNFhhJS21P0yCf1XcaSn0XlAWN+EAfTbPtWdc3weLJlGHdwooBuLOCkCGwGkl7q+cl7h7dHjy/dOpZj/0+303Au+wU5HwaXpeEtq7VFYp1RzLUlMmTiH7wslsqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923762; c=relaxed/simple;
	bh=zdoszbvaqb15HmyU3X8GvNrCk0s9HFGthNILWOCvqN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqAP0QYCliR28yW4r+Prt3QmgtSKrhQV2QYnZpaRfN3Do7D4Tcqb12JEjCSKC7BPd37Cvtg/qmdB1M2w7dpru2DlM+4UlmXpjZCOOmi0oA8NHQdN7gOVm1oq3H4Tg0tH5yCFpSyxcqu37W8AlxKFDDzAUFrSP2tzFYdebhxzaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nN/0Anu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RkLV9410; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 91FC01D00056;
	Mon, 13 Jul 2026 02:22:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 02:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1783923760;
	 x=1784010160; bh=PoFRyznXthzskdT/+0xnQf+OqwzBjgQPvZ7okyFUP3s=; b=
	nN/0Anu9Xg1NiXGFP//rMut5+2DUlD3zSJ4bDfaiC7aCuEWlRQwKpl5XuUlLtpAZ
	ZepfaUHl+bFJHH8DvWndViYXzSgu8FJm/lkDMXZ+1z8lGLKwn8Ry9KCOD94Z2BbO
	UoQuN6WGr5otJS9CORpZTdDeiGNsTIQoorDz1J37a0zAEsXJhmOoRcKVqcmCUOSW
	MkVb+DI7dp1jim3z5dMIqtgmZq27v84qogCxGwn6ZlZdsM04G56GldkBWWcN9/kF
	EHRG8PIiaop/WdGUNxlx/zSab4q4Mwk6IpuUSNgNm0+DTgnRzv5H1u0ryIOfM/Z4
	SufhlHr0jFVi8STquoIkyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783923760; x=1784010160; bh=P
	oFRyznXthzskdT/+0xnQf+OqwzBjgQPvZ7okyFUP3s=; b=RkLV9410jj4EQtbjW
	uZlqsZvkqEPCPMdsSo3HS1OEl29vnN218uafmp0ALJIiIJuWUS/7y+uAo5hlKhZw
	XZpHCoJe7w0zT/IsQxyvelxXiieV/iZ2Q/VXuHbMhAgyYj6cmZDYRSmz3vZHi0B/
	jIWePzttGalyoa3FzM31LlNdteYssHCfNFcqssrp71WaOHiKY19So3xnxvZZZ4rr
	+YngaKFNxqRuFPdW+Vt+EVKE+38UdWGep4QivFNSdkm5xIF5ucVIIk/SFg08WiYY
	Jr5onvT0JhSvgk8WKy/iBHZKCjYUAexuuhXyTuKDmBYzzVrUin/6WnDapGkrfB6p
	lGYHw==
X-ME-Sender: <xms:MIRUalzaGiiFkKS4vSYH2lqz-HX9UTrTKpwfpfCK94V9hactaAU6KQ>
    <xme:MIRUao_i3j-Z7ohA8icnEJ1xqFeukvDi50fUfHzP14EDspz5HVQkRwN5WkUYYLaHz
    _liV7Xk3NomhUv7fE-tiF0FSuoRtOj9lqSGWg0orVgUpe7glg>
X-ME-Received: <xmr:MIRUapJLCpjMsPW7P8d-itV0VczHbVKlfHMQ_WLcqIigK3Idi1EwvoVswrlo5CP41D1Q20xyr7fVGQAOBLsvNSRR5v5cL0U>
X-ME-Proxy-Cause: dmFkZTGCQLlV7rkBD/d/I31+FnWtoJqihf/xdHHsD1TT1SXgkZmv6s4HWqyOhFnVY9n5MU
    BOJtfUQyVpUKpBykWA7VcVygcWfF57rWMRxVOWH1WLSaRWqIdVkOkFztYwGNBEJqYCGdER
    lIjYSwxT52xjXFVZpJf8rJpvaK2n+rZveXXBjrP8wYzN/FLD3xS33T1EHtom553cqC8fjn
    PrLIVOrVJtl+mjvVoS1EqhD6Dvk80GmCtdpbSpYdhpfrTqNe15e9hEbxs6wUV0rVyj4+GV
    nLsskUnL0p4PWJePiP27X7oGhT/Dg2xDgvflUJ5tmToCi4jiK9SzoT7k7idnqqIq2oUzNf
    1fuohAV9HNT79WI/R8a+SzUyi7ZPbG0d+oMYOa3kob8xR+Z4gMT/1gSyZsidB6LLLdfAAj
    vQAJfuZkD6+mx9T4UqdtgoqVFGUCmDy1dJ+XKc0Xo8vYo4ao3QAy1c++4fpQ2gqXcCloRt
    JwBAzo7feRJdj/eqx/LfTQpauAhP1DrVQrDqXexpsGkOxxirEtp45IQ5gZ0BokwzCrwvIo
    +KVn/YZrw+tIAr5kyjWmJdXUuOeg1fBQ2GbpuSaTS4SygbdCQyM61pT+79nNJf2/NWMhFs
    +FH8zP6itmWV2g2xVT/+8TLO4BT99Q/qrn14y3f20QutGpWlo712wzXBRqZA
X-ME-Proxy: <xmx:MIRUaufIzCbHEBtuumYieQ8nKhoNL9FSM0l9OHlqbjXeqthFdvV-ig>
    <xmx:MIRUao_jGm93HuxZwa0BekIj3ESAgxYorZ7M_5Z8ukasvtORQTSnnw>
    <xmx:MIRUarp86c8uETEVCK4GOxfFQjesbVa9Acq3_rr2djOqAGBd-UJ_nw>
    <xmx:MIRUatCt-aHD_Gfh7SmsA5yTa721g6T-UymAw1NNyaZ0CbTTqesHrQ>
    <xmx:MIRUanS23Df_qZzqHaUvxjoMGKtBpqa8otMVci_zqEnRA80GX5UBuGge>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:22:38 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 01/17] nfsd: honour client-provided attributes for NFS4_CREATE_EXCLUSIVE4_1
Date: Mon, 13 Jul 2026 16:15:24 +1000
Message-ID: <20260713062219.6399-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260713062219.6399-1-neilb@ownmail.net>
References: <20260713062219.6399-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23284-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D80F2747808

From: NeilBrown <neil@brown.name>

When a file is created with a v4.1 OPEN which requests
NFS4_CREATE_EXCLUSIVE4_1, the request can include attributes to be set.
However when the mtime/atime are set to hold the verifier, the other
ia_valid flags are cleared, so no attributes requested by the client are
used.

This code was originally written for NFSv3 where NFS3_CREATE_EXCLUSIVE
never includes attributes.  When it was updated for v4.1, the fact that an
exclusive create CAN include attributes was not handled properly.

Fixes: ac6721a13e5b ("nfsd41: make sure nfs server process OPEN with EXCLUSIVE4_1 correctly")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 935408252ace..ca9460e97e2b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -393,8 +393,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
 		iap->ia_valid &= ~ATTR_SIZE;
 	if (nfsd4_create_is_exclusive(open->op_createmode)) {
-		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
-				ATTR_MTIME_SET|ATTR_ATIME_SET;
+		iap->ia_valid |= ATTR_MTIME | ATTR_ATIME |
+				 ATTR_MTIME_SET|ATTR_ATIME_SET;
 		iap->ia_mtime.tv_sec = v_mtime;
 		iap->ia_atime.tv_sec = v_atime;
 		iap->ia_mtime.tv_nsec = 0;
-- 
2.50.0.107.gf914562f5916.dirty



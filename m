Return-Path: <linux-nfs+bounces-22868-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2mKdA5RbP2o8SAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22868-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2026 07:11:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9746D1277
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2026 07:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.org header.s=fm1 header.b=nm9ZQbNf;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="i eqWb76";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22868-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22868-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF9B302B09B
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2026 05:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438912F4A14;
	Sat, 27 Jun 2026 05:11:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16878F26;
	Sat, 27 Jun 2026 05:11:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782537104; cv=none; b=Pr05YahcNS/AGrcrMfezcwRdPsbAFv3YqM5Eb52762kO/R/6uBujjz/M/OnVsIYocBQzBXBEhRtBMtrTsS7BJ5Fne5caPnOmQW6YjdMhG9RFcnRwHj15Weva7fTbe3T1wUIa7fPhH+4N0qSgWTtoI1aWkDWDwAfMiSl9Ye3V/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782537104; c=relaxed/simple;
	bh=/VsB74zwCXVnz/0VFCi/dUI3gIBJbC3fxzQsz0T8RbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iaKtbEyZQMXuuHASTb4leBJuTqAQFd1k9vuttRpIU4NJrUNzMzowCHCtjQUWNIS65e8jslr50Z6pDrf+XXi1D3YuWqAgea/t3WuR+R+6NgNyk/WQNLK+kWrcFtHBLrqvMqx7dGDCkeZO2qtTvg9jFgdz0QMY9eVnuO+dHKU7m/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=nm9ZQbNf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ieqWb76Z; arc=none smtp.client-ip=202.12.124.143
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 41786130024B;
	Sat, 27 Jun 2026 01:11:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 27 Jun 2026 01:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1782537101; x=1782540701; bh=Yawowe8zx5C7uDvQPKakOCXbHdKhV7R9
	9P2QeR1rAS8=; b=nm9ZQbNfHNYkv8cdFpySG0htUn3UCNbtS/+tFfURRLH2epJa
	D8HjhJi2+zQzPPtGTp5nNEMYwskgo9t6QjWspNz9bFEzOJGKndw339qVspvaWXHi
	l+mH96g+w0VFnrk/jiNulSOqY8tx4OEWBYfqMtQGhBVmMCM+WAgGHiBkRXrbqHfa
	D1VbAIclGnixLA1v/6S8c4eHEghMxem4SB1dInEVzLcU4BG96MlSKe+fsWXCIFLW
	bXxVnChg2II4VqLsb98Z5UTXoI5JozlrJGSJlNxNCX4r4iJB4Y109TnZifld51Y/
	i8fPA+iz7SdXqGV3VYfjGfy91ugfo4Z1KQ2XNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782537101; x=
	1782540701; bh=Yawowe8zx5C7uDvQPKakOCXbHdKhV7R99P2QeR1rAS8=; b=i
	eqWb76Z0YIJk5JqS+Sorj115qkFVnzZkwiEvqjjRMl1AX4+V9Agb9tJliqXVwZ0f
	ZndsFhvkJ/aqpekwv1SCDyAJqY6QSrrEd1otJfAj0ZYFlCtlC7J4KWG3zLjkXLfU
	OR3NLClJf/CMfGiBF3IFixmvGtFyKvduUKj9l0x2DTYgSa5loJ6FLePDj/FW4Wbz
	HwQlx+4NNUY8Lmn3E7v0NPGwrD9Jk00EvLNyH1nAwivKPz0kaTChziS9Nx8Q2ecB
	jReYP2YwRmFQi2g6+BKsCO4RkyD4YLtLctqej17FHQ4B3JxsnP4kOdS970/FbmDd
	r91NJ5iPyEWm9JOzX/3Uw==
X-ME-Sender: <xms:jFs_avHKXgTEIwS8b64GJMLPODF4IKHCf2Tfa3kUtVKbfr048gTTuA>
    <xme:jFs_alRI2R4TeT1aAvFwTCBGvCud5CcgFqapaCTXObB3tnVpZCWB_wTqPzKTIWB1b
    -cmdB2NuHbluaSgUBAfmskODSfFRAfjDe_Sj-hpfqigyZzX0nTfuQo>
X-ME-Received: <xmr:jFs_asuLKDV0IZnHJonUf5NFOsX-Hg0U1Fm_lCcKo61O58dgDRmLO5buFm4>
X-ME-Proxy-Cause: dmFkZTEEJGas0eal+haqiznubm05y0BHQqqdCWlV5MG4ed30bCnDNmZnYMoGVqATwByXQ6
    62jw/wpBiAVlhnZdzI8HoTE5bi+hevsp/u9zJ0oU5IglqMHIf8+isdmzspda8CkFRN0L5E
    RWIIOx+csNFY6hhAFCY1ilJo9VRvWdX7ksW7rcUSTy7enVhf+UqqVtDjkP2AE9NzXuuzPd
    NYyVzry+AlVHzQyFi7Ion7i/0ez3GQXUe/mfKlbIbvqd6ovxb2QKrh2kSKjpOZ5Vob7ica
    nVYyrny7nVBo34xbtlnSZUINwmAGdm2SAzfUClMB/O1IBG1k79l2D6swXv+NJBB0SXLNfl
    1T9Qk/zyIz1rqLoqTyW6afxPNLRwtoXbNv3iFWpvECmWfvCDCtNHnaf8gf9CwHkqCwdTCN
    ur73CruIY+oA53abIUd4yyljMMzKll6R5R0HvDze0/Ze0MqeIGD3PkJwIaO9dx9mKX9lye
    c+9BNbWrg4cnT7ZOWcY+bNkhebh5pYjqXSJwL0rcAXK6zBYKttGZJ2Vxjr2zhFtFzKG9Xn
    2nTm7KTnK4aNBG1WG8IBO/Soinow03DlWUdV+otnK0VxDX/YG82WNeQcsu6Qo6opqSEbmg
    NpYb0YlP2WVzeffweojx+5ZSd4yHzK3k/Bh1jZNQ5iB9hXhsCGtn07uFQWmw
X-ME-Proxy: <xmx:jFs_atIocfDxU9qUuiMeMg4i-t6hEubvXDSxixRZjvyBhPcbQTci8Q>
    <xmx:jFs_ahloNhEcXa_qMI-rbvbCasKi2DUl134z1ZanqEnHqcDS-pNNQw>
    <xmx:jFs_amI4qr5wtbNR4HoHzqxybSbrjgsIj0A0-do9-dTC-obtGNmatw>
    <xmx:jFs_au7c73mBp-BAkkO-b7mTWramchj1_rSx8DXrHuxKdDKqV-cqaw>
    <xmx:jFs_apgmrl4lWEpPjQyoN_N9Ci6b9OXilQnDCWvaJicBN9xuSqSGqtIi>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 01:11:40 -0400 (EDT)
Date: Sat, 27 Jun 2026 00:11:37 -0500
From: Ian Bridges <icb@fastmail.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] SUNRPC: Replace strlcat() with snprintf() in
 rpc_sockaddr2uaddr()
Message-ID: <aj9bie25tpHnz7_G@dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[fastmail.org:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22868-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[icb@fastmail.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[fastmail.org:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[icb@fastmail.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fastmail.org:dkim,fastmail.org:email,fastmail.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD9746D1277

In preparation for removing the deprecated strlcat() API[1], replace the
snprintf()/strlcat() pair in rpc_sockaddr2uaddr() with a single snprintf()
that appends the port suffix directly to the address buffer.

rpc_ntop4() and rpc_ntop6_noscopeid() leave a NUL-terminated presentation
address in addrbuf; the port is then formatted as ".p1.p2" and appended.
Writing that suffix at addrbuf + strlen(addrbuf) with snprintf() yields the
same universal address string as the separate portbuf/strlcat() step it
replaces, so the intermediate portbuf is no longer needed.

snprintf() returns the length it would have written excluding the NUL, so
comparing it against the remaining buffer space preserves the existing
truncation check that returns NULL.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
 net/sunrpc/addr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 97ff11973c49..c164ea214e6a 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -264,9 +264,9 @@ EXPORT_SYMBOL_GPL(rpc_pton);
  */
 char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
 {
-	char portbuf[RPCBIND_MAXUADDRPLEN];
 	char addrbuf[RPCBIND_MAXUADDRLEN];
 	unsigned short port;
+	size_t len, avail;
 
 	switch (sap->sa_family) {
 	case AF_INET:
@@ -283,11 +283,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
 		return NULL;
 	}
 
-	if (snprintf(portbuf, sizeof(portbuf),
-		     ".%u.%u", port >> 8, port & 0xff) >= (int)sizeof(portbuf))
-		return NULL;
-
-	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) >= sizeof(addrbuf))
+	len = strlen(addrbuf);
+	avail = sizeof(addrbuf) - len;
+	if (snprintf(addrbuf + len, avail, ".%u.%u",
+		     port >> 8, port & 0xff) >= avail)
 		return NULL;
 
 	return kstrdup(addrbuf, gfp_flags);
-- 
2.47.3



Return-Path: <linux-nfs+bounces-22859-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QxbbODt8PmqNGwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22859-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 15:18:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592E6CD5CE
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 15:18:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="dN/9ewM3";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22859-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22859-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AAD3300D603
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8513EB816;
	Fri, 26 Jun 2026 13:18:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6073E3C48
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 13:18:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479907; cv=none; b=oFzFS4MN8+pHe7yfYYlburIndGIHJP2knv91q4CXpe+rJDbwY6GPPeMzRIhDzxUJqM+OQzt+d4nDVt9fDb8Cgq7rWX4M3x65XMddkd4StVemxQj6gZwlmllGq3ylcSs74Duke5D4WAve/VqkZmrR4alav1Ht0Ku0/CY++EjWJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479907; c=relaxed/simple;
	bh=luFSe4CihzgmHXEB76fiyz43LqRoclEJTrdqRo1H0bo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HIuiGgUEqrz+6BHNzXxamnECfQvUrEnD4lVTdPMgw/mZw5UU+LGJDEn4SuE6u73Y+rKZ5vt18lnMBtTpYBH//Q5wiRvHO6e7YrO8VBgZ1BG+N4B7a/S0HMCb8X4jFhhKCPLBEs+wKbXgsoZq3BMr/j7CNxuPcSbyp/hX+SmUz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN/9ewM3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322C41F00A3D;
	Fri, 26 Jun 2026 13:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782479906;
	bh=G4OSa/okgMjoo+tWfOyar7hk9voOfYv3Bc8E3yII4Mc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dN/9ewM32z3d/xYCItTiutRoyJk/a10iJYi9WDvGtfGtkjldku7Ibj8gtXACXFCmB
	 GjgsnjCVOmQGQeMXw0he+PqzfCRCuZ2xIvRdP/2GWfWx6L6IcSq9L/DvPjcckEdaoK
	 7M4ScKsydGOdwUOkqIAPV7k0cFAnP87BsM6+uu04+EVWoJfUVoA7Eb0iE2vXZRUHyc
	 ILYWnuwvW93+QekEFmAcf9lyhtJATaJLlDIWOqcAqM+eBB8+dwb6S8dOQT8qxrjS70
	 o7MDtL8kX0Gti+xOUhyutLqkJ3PQq1y9j0QuYBf04DAWMrumgqVAlEIZkoyWLj4xXk
	 WJqc9VO8W101A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 66116F40071;
	Fri, 26 Jun 2026 09:18:25 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 26 Jun 2026 09:18:25 -0400
X-ME-Sender: <xms:IXw-atf9TFIXMy2_XAg0UQ31TS9HkZi19FJMVUc5yIBTDsR2QozLiA>
    <xme:IXw-amASmobBYI8FslI9cSCReTuwV-wD9oUzNd9pGmeiw6i4Vl_7-ps1cCa0LULzO
    bDnsVlILNm3bNQArNbmHLwhPq1VAHgzCeKD30MCd86m9mDcBRxPXdE>
X-ME-Proxy-Cause: dmFkZTF5v+TUHaIkGi0xqpxXPosQLM2NTeWcTJYhrXqmwCg4V3Zuf26yLWa5BU/VueGPTr
    ienX/2WpuDeQGOACdqNfD2Smv4crIqGIP5X+2G9CK2sxAi2c67soXjJKGi+i0JHODHQY0z
    wAEcnJCyPR/B7UFdvv+AquXXXvB5QnqVAfLUTJPikd8cwLjUAlahJScLtLGzKM436AzkEu
    ti4ez0H4ffVXxO6BduCWTJLwDgSIk9w6XquocMQIo4SAjHUIG2MvhZR/1lLAcqYJ+CMg/1
    9/anw+8BVNdMsWzYusLNArEvoIlDeMDTdXa7tCEQBkqPtnTbua7qogGUdSQO2qL/cj+KGJ
    LKX6JN/YuJQLO4JLF3706AJc0pQdugnxCPG110UYLWsu/wopvORVd3AFAsSetvNsUy6CtS
    BewxMNMNE62kvJsRAFRS9OE/6iH+DOX0K9QUe1sgig9PcsV4CzCeGmjSrdY7s9oHwzKBJE
    xLaXTA5vcN5PWbsQ87kpDRXZwIGCx3QLm4VgVXeLSStuI3J8j+Mq+x0qs6U0gBZTCsIQPu
    MX40GcRgZ76MonohZdtu6FrPMcejeIXGpXIw2/SwcpkIu+RO3R1SICHlF6DfLe8gRZ8UnL
    8I92rQQEhaZX+uC2KnZ+vPQKt7iOXNa2XdYSP+30wLTHsgGpsc0hXqUdHiUQ
X-ME-Proxy: <xmx:IXw-anuErKTddRBVOhZDulH3bej2_HlNGzsSlqYh87WK0upH4ytmiA>
    <xmx:IXw-ao6ggPmV_3s86z0Wgkd8amIWaAm875Z0JQQtxIrsLaTunlRPbA>
    <xmx:IXw-arfs8rtqO0HOOHtbyJ3OL60JuURxxSGb3YatZF23PMwJL_wrRA>
    <xmx:IXw-atwam6nO18_2metSFdn-dMOngER1Pn-y-nsOaXw-UmyN61Br2g>
    <xmx:IXw-ao9Qoo8xNXlHwhmSucfIGMkwbngtB6xxPcKMukB1cVV7sc0PdEAR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 46B15780AB9; Fri, 26 Jun 2026 09:18:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWid7F4iEUkZ
Date: Fri, 26 Jun 2026 09:18:05 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <ac1f3b39-1541-4861-a5b1-3babbc9c1cc7@app.fastmail.com>
In-Reply-To: <178244005168.27465.2587255049421564152@noble.neil.brown.name>
References: <20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org>
 <178244005168.27465.2587255049421564152@noble.neil.brown.name>
Subject: Re: [PATCH v2] sunrpc: hardcode pool_mode to pernode, remove other modes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22859-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6592E6CD5CE


On Thu, Jun 25, 2026, at 10:14 PM, NeilBrown wrote:
> Regarding Chucks comments, I think a minimum of one thread per node,
> rather than a minimum of one thread total, is the sensible approach.
> Of course if there exist memory-only nodes, they wouldn't need a thread.

What happens when transport work is scheduled on a memory-only
pool? Obviously there's no execution engine there, even if we
do provide one or more threads.


-- 
Chuck Lever


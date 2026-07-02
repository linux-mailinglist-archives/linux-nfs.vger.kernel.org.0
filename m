Return-Path: <linux-nfs+bounces-22945-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rKwlEb94RmqkWgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22945-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 16:42:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC36F8F91
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 16:42:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dzzMeylU;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22945-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22945-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDC73030EA6
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DD30568C;
	Thu,  2 Jul 2026 14:37:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DAF372052
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 14:37:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003044; cv=none; b=L1bobFNOruiijtF+YBXIQR9BLVbtM/ad1GXF79FuaXiiqCe1poQU/0bzKJJdYrXq2r21adhI6vuRdh4zwipqxBy+77ItPQx7l+ofXJ3hYUXRqA3jvJi0xaQa5VLZKk5MflJNGnzDlJDPhtIx8ggc7lxKX8O6gr/pKbH3Z8CbRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003044; c=relaxed/simple;
	bh=ZUJDqqRAv+TN0K6kb/W1oE1MHfWwS5Iu0ip057M02+c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hoqzS7I7lNak3LQ53NCCgoQF+g78avs3n26QdgzZhqR3+MhL2OfCP259ge9IIVAiABy9/S7gjvaBxQRKHneNdTJMjPW/Un98YKMh7TcZd1VDskyYHNRFc0kD2lK3dCprzIfyhyMjmlfKNeW2f15yCa00adHtCsR7CRjaHp8nATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzzMeylU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0761F00A3A;
	Thu,  2 Jul 2026 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003043;
	bh=/fM3qtMnG2JkIZXV74v8TZoh+PUFWPysM9nHK/tEOR4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dzzMeylUhIwG6jNo05o82BKgjG2FhgIm3hu7oVqbso+JC0vegjcjg33SNOoekui71
	 OfnXGEnMV2iJKtHNr4js3G6aRSO6LP/987OQyvl55EKqvkWTrLY8uSg+PSaG0zs38c
	 JILiE+vc/hUJenFpW3oInxn5Hoav6bd+x2JS2bT6VbrSnfUW1U/GyusXH+KEap1qA2
	 DKc7mXA5DwjprpX5U7e1l5e18BA672krRchnfgs7iaLFTm2RNWT9nwJb+r/Iop00gF
	 4D5veyJ06q4T1okcYbMCRqP8swHcMLBHIzEY6g79R7NG75j3BG7PlKDjIxIVyYYLcR
	 ylrwhwDMhxjlQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1C82DF40068;
	Thu,  2 Jul 2026 10:37:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 02 Jul 2026 10:37:22 -0400
X-ME-Sender: <xms:ondGanw1gbKcu7S0oZO0lfntErYrxGdSVynLmhmzX24t5zOcJQzhbA>
    <xme:ondGaqEB8Mi6lP2b9r2yWWMQ9-CaLDK8GKsRSn26BEYB-Oy40sB5YWmX78vgX7a4d
    Zr0fjRMUWBQDjMHnrG-gLJNbJgZa50hT0TH_IfJKQByaz7T_Q3erg>
X-ME-Proxy-Cause: dmFkZTGolg5tcBHpXEpnVgb5zKOZbzwVPqh9XaTnnNf9anAdn0tCgDIvo4SMHzais5c36s
    K3lpnTM3CFmr25awqxV4vTOWvpY2UyaB/cI6wrlL6M/9Eust5Y48l688DVDZegOB7XGX/+
    JKU6feAFoDJfne576EawrxHBPGT0YUrqGEr4GqE6yz2uFpt09DCQ1X+psOvDKOGMNBIO6B
    /euoozMTFMBNK702IqeiGtylwL0AZ6s23Tm5vUSkc2wYmnbDMbi3+BcbOF2kwa5GdsFkCt
    VrJXp+tXM4bgQTODqWMce4qiFbmF1dXQWCpoBbwvcLIRTC6xUBAfp5UjlQEGMMjlNFDXKQ
    qGOpTkmpfWi5z1yt5q+sf8P0uim/Ft61bqnCU0Herr6Kd8qkOavtvYtTM1WRkltG7dsTL7
    /G14naZrCOQSU4Nk0D89+0B9ftct1MulJTSED+GD23j/jQGO/XF+oQaBm8SOke4QgdIQw1
    dTM3sTwDl2hqn5Erpbgjsd93NTIdgMKL2p4+Ab5iHq3uuyO6qBvnZ9+82G13EAOa6ytqpy
    Jc6LYz1QFOMLO8TDnYCsY7ttpxHWjoFlUi8EuYYPOvpSKEDdp7pzqYSaWBFc0apR7NK0Xd
    lLSMR3z0JsbQrFQPO/gD8m7b6hFBafL6bGARuFDWkykzuqWnXf8S1b9KkjpQ
X-ME-Proxy: <xmx:ondGaqqZBZlKdcIPpoAqYYTtMY5RTTHntANjPCZnPSv_SULbesPDjA>
    <xmx:ondGapWX2NLlwyNURZOwPEPFVfW2-Ljauq_0yaImQ7qnrU3AxPJbGA>
    <xmx:ondGatY8eZkoXO6WV5TPtHcxhSQ1Yz8XBtU_JpYOgGXXWd_Rnte3-Q>
    <xmx:ondGaueK3ECrtR52qyV1JHfqCS0lkMb-AlfrVAQadFByDt3t3EQjfA>
    <xmx:ondGav0JgZXb8IWgxx3VSef0F4jZJEOlinRIrbNJ9c9aquZVDmOO3vm9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E69D9780AB5; Thu,  2 Jul 2026 10:37:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKOMlOMxHTvB
Date: Thu, 02 Jul 2026 10:37:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Message-Id: <7ef0e102-19d4-49a1-bf9b-5191177c2b93@app.fastmail.com>
In-Reply-To: <20260702014000.3397240-1-neilb@ownmail.net>
References: <20260702014000.3397240-1-neilb@ownmail.net>
Subject: Re: [PATCH 00/10] nfsd:refactor nfsd4_create_file()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22945-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EAC36F8F91


On Wed, Jul 1, 2026, at 9:34 PM, NeilBrown wrote:
> nfs4_create_file() duplicates knowledge about opening a file which
> exists in the VFS, mostly in lookup_open().  It does use dentry_create()
> which shares some code, but there is more code that could be shared.
>
> The nfsd code doesn't get some details quite right, particularly patch
> 05 shows this.
>
> I hope to introduce a new VFS interface which encapulates more of what
> nfsd needs and shares more code with lookup_open().  I particularly want
> this as it will simplify some changes to locking rules that I am working
> on.
>
> This series re-arranges the nfsd code to get it ready for switching to
> the new interface.  Once that interface lands we can then switch over
> fairly easily.  Hopefully the series helps clarity even before that
> happens.

A couple of high-level remarks (and full disclosure, I haven't looked
closely at these yet):

- Sashiko found something remarkable in 9 of the 10 patches in this
  series: https://sashiko.dev/#/patchset/20260702014000.3397240-1-neilb%40ownmail.net

  Which I commend to you for study ;-)

- We'll need to decide how to merge these given the other related
  series you have in flight that targets VFS code that NFSD consumes.
  Are these two series truly independent?


-- 
Chuck Lever


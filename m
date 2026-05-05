Return-Path: <linux-nfs+bounces-21387-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJntLdGn+WnF+gIAu9opvQ
	(envelope-from <linux-nfs+bounces-21387-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 10:18:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E754C88CC
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 10:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52EB8301A934
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 08:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71B3EAC8D;
	Tue,  5 May 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+ueopS4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3243EAC8B
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968970; cv=none; b=kXaomf0Xxypwlirg0nrlLA04WhZLoaOblfKHuGpFSpfQuRVnEIfNB1d1oZlWQvbiAzXdoyQkemluZV/ue8SGwGNLhYGQIQQtJo9Idrmfoa4J7q5Jomo2NjEonax7ePStQG98uIZxhE1GVTiHaBzpx2h+9dMDN6yb7vasSIiYJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968970; c=relaxed/simple;
	bh=iZjLEaVYOGNfiw6+ZITdYPUtOq2jyt4Nbckk5ZpL+20=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hjotz9uCMjVfzZdowgOEE1YydmcTpuR6g7wpZ/CcuIDKGZVBcTCDl05m1mg7x2Z0yWGaJnnOKe86FY1Rcj9/7ly5o2r8fWVi4wzlYkIRGt2ENMh3ZJ1zDvDYj00n23R8rsy2qqOrimWBWHCw90Hgdn2Fh5+tGIfuMzYL/mdAZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+ueopS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4CFC4AF09;
	Tue,  5 May 2026 08:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777968969;
	bh=iZjLEaVYOGNfiw6+ZITdYPUtOq2jyt4Nbckk5ZpL+20=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U+ueopS4woIo3raPyV32JXX7OvBY6TGnUySxMrR5dld9qk4ucyqRF854UD+OWeXTw
	 WD1ewRSkdyPpzQbs+HgWz8RVVvgF0ZNu1+7h84T6ZGhx2afv9381G0GcGSEgUyNhd1
	 Dnu83GxH06xXxcd3ENtNKOI1vitHYX7eRu540Q64NUjMZimyBJIyZTDoL4y5hpNU+t
	 +zTCUvwaUQZeCgk2d5x+keYgwofdZnpkmeIC/iXd3szuLU9x5n6ydonoS2laAdTEmq
	 P8inaIbnMSCwM6A18Lz2VN74uONfBHSOtnJGjOlTPILkpAPl9jqPytanDcmm81lAcg
	 qGz9bLdszkgCA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6D5F7F4006C;
	Tue,  5 May 2026 04:16:08 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 05 May 2026 04:16:08 -0400
X-ME-Sender: <xms:SKf5abVfz6YQ-9Cnttjw7o9t61qlexixXSOC0ZvFxUVauWx7ZFQGyQ>
    <xme:SKf5aeYxs2LwQES5Wq9vrdmewiuoqTfAwXzseUEgEkk4zReqiyfq0T3YPAQcAsvq3
    fscyz8jsvbbLBOMobO5Q_yXp-ZN6CLT9a1R01vg33CxwWTqll2bNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshgrghhisehgrhhimhgsvghrghdrmhgvpdhrtghpthhtohepkhgvrhhnvghlqd
    htlhhsqdhhrghnughshhgrkhgvsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthht
    oheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshhmrg
    ihhhgvfiesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SKf5afhNuvpuPD0RC48ZEFuGYk3LaQqZHOd8SyKVgHhzx_LXtaIPmA>
    <xmx:SKf5aU9c_BfpnCnOBlGcU2h6F_1PRqjP7ded36HZW8MozfbT7Soy-Q>
    <xmx:SKf5aaqPb-LpJBC51qrJogs449jegFMcL-xd6qLT5_VdSzgE6SuoYg>
    <xmx:SKf5acUovHi6wgkYor77KLXf6BiCiK0JVu3mGLnXc2Q9-0xgYaReFQ>
    <xmx:SKf5aZC0HSl3C5PmMUO3Ze8vSrxyoYF-thwIHBkOdSWtZozco6eLjaHw>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48BFC780070; Tue,  5 May 2026 04:16:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak5ktnwSWV1c
Date: Tue, 05 May 2026 10:15:48 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Scott Mayhew" <smayhew@redhat.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
Message-Id: <4797a5a7-ac88-48a5-8707-b9e33a899da6@app.fastmail.com>
In-Reply-To: <ce60fc54-5082-44a4-99ae-dccbbb25eb88@app.fastmail.com>
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
 <afUKzeUYPhb97DX4@aion>
 <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
 <e55cd958-6d86-4c6b-abc6-5be83fc53b0b@grimberg.me>
 <98a865cb-94e3-4f57-8b9e-0634c43098b9@app.fastmail.com>
 <2330c9c6-de7e-4cac-b991-3ffcfdc23858@grimberg.me>
 <ce60fc54-5082-44a4-99ae-dccbbb25eb88@app.fastmail.com>
Subject: Re: Breakage in ktls-utils with nfs keyring?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B4E754C88CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21387-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, May 4, 2026, at 8:44 AM, Chuck Lever wrote:
> What you are asking for, then, is a 1.3.0 dot release for this fix. I
> still don't feel there is a strong requirement for that, given that
> distributions apply fixes to packages all the time. But I haven't made
> a final call on that.

After auditing the commit history between ktls-utils-1.3.0 and 1.4.0,
there are enough fixes to bundle together and release a 1.3.1 that
includes the fix for the keyring-based NFS mount failure. I've created
a branch ktls-utils-1.3-fixes that can be tagged and released once the
keyring fix is merged into main.


-- 
Chuck Lever


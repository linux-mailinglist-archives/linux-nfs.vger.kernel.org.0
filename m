Return-Path: <linux-nfs+bounces-20478-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPGKOerfxmnAPgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20478-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:52:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2EE34A784
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 20:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE88F3095610
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 19:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B72D1936;
	Fri, 27 Mar 2026 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQXqNvmc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7A381C4
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640745; cv=none; b=h1opQfghsbA/THjF5wS+xvJRwBobY0mphT0375oDEErFLO3TpsV/djLYRncdsO8f+QwmOSLW9VOUfIVn+VGIP5qdjF/2bTWq4FHsPqtDyIWM6Fo5viGJPoGWTTFeGDdNZWihaPWi2K2daJ2YLupO67dFnIf2wLSppdfgiPKqaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640745; c=relaxed/simple;
	bh=pDnx80eSfOubTFsjwpsDZzPakXCPtkEkGYZpUQlc7w4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C3v7KCytpV6DFxte3k7iUIXXeiq0RgOjKHUu+dUvELKJmHhLZdTmIh8POKO5juCHRpHVN1C+7gSL9/N1sYcn+NWh6XcL+R1SKptp46x0nsbyYQbW/pr0Ji1VkwjGj5lo2fPmdTBr1/YFH6fTHICozl5QguDaHZv1sdspqdM6vU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQXqNvmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09A9C2BC86
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774640744;
	bh=pDnx80eSfOubTFsjwpsDZzPakXCPtkEkGYZpUQlc7w4=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=ZQXqNvmcKSIJ31XsgvMX2oNS0XimPwjVzoNnyEMrOd6Z2ROwwZvYBck49MppVbyID
	 Gi9cGLMutj/oRpdsRXyS3LYpCvncp+AHnwvUc8JXLlZPd2eAz2U0KZdjf4BD+bGJT3
	 5mjunTh/U2z/sYMpNitN+6NPUw+NslrtGLQqqsJxToMYO27EaVZRpcLJU+KgRnP9sa
	 4Ds/EeOnmAs7gW+1Tuu2zH/W0c9omSYM5suO98copps1HL+vG3gL9jiy61e9iVfx78
	 n3qv6lDbVecm9JdnGBQVf84x3OzOZFRR6E2jweGiPebWNf7oJQ2KuvOwEnTrCbHyy8
	 LtImEkNCKt0dQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 961ABF40082;
	Fri, 27 Mar 2026 15:45:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 27 Mar 2026 15:45:43 -0400
X-ME-Sender: <xms:Z97GabPbfwMYJ005TbaAsRcjb_gvJ4JA7qEIFHQne5CL2qfsdvA9-g>
    <xme:Z97GaQwxZvsN8WQThCTFD0tVe0W1TRShSknA3P7yGsGmtu9UQPVYFm-LufYNN75gP
    wwr65rUUYIy3a3pB0RjP6r9eh4o5BN00YXCRtqBHaxUBggZQCmViA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfvehhuhgtkhcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpeehheejleegffffiefhudduvedugefhheehfe
    fhgfeuleeuudefteejudfhudekleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpeepkhgv
    rhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesshhtfihmrdguvgdprhgt
    phhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Z97GaZ6VlIuNJMlvMqBSSHbRi-Sl_tL0zilrQVAG-MIqIF1K-oFl6w>
    <xmx:Z97GaU3xMQYqLjklRini1w0bPClDvHFl6AknPnXXwlTDgyk3s3zCUw>
    <xmx:Z97GaYBp0aTtZqjEeEvs34nM6ift4KKc842TkCKOXeh-dPWIuOA3dg>
    <xmx:Z97Gae3WijHYFd-0MVp_Ub5q-ATXei_NVR4xgz7EiskZKkeDW1einQ>
    <xmx:Z97GaasjR1lDS33rw7AiGBz6gciZ6S14HBohxen41FPphL6MYZkac33D>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 73EE1780076; Fri, 27 Mar 2026 15:45:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Abx4mXQXfoag
Date: Fri, 27 Mar 2026 15:45:23 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Wolfgang Walter" <linux@stwm.de>, linux-nfs@vger.kernel.org
Message-Id: <d9a63d25-2cec-4dbc-af0e-6b1ae46266d8@app.fastmail.com>
In-Reply-To: <aa45976e7e85e06a426765c5a17865c1@stwm.de>
References: <aa45976e7e85e06a426765c5a17865c1@stwm.de>
Subject: Re: 6.18.19 (and probably earlier): get BUG nfsd_file (Not tainted): Objects
 remaining on __kmem_cache_shutdown()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20478-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6D2EE34A784
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Wolfgang -

On Fri, Mar 27, 2026, at 2:37 PM, Wolfgang Walter wrote:
> Hello,
>
> wenn rebooting our nfs-server I get almost always the following BUG:
>
> Mar 27 18:27:40 rummelplatz kernel: BUG nfsd_file (Not tainted): Objects 
> remaining on __kmem_cache_shutdown()
> Mar 27 18:27:40 rummelplatz kernel: 
> -----------------------------------------------------------------------------
> Mar 27 18:27:40 rummelplatz kernel: Object 0x000000004cc0c6e6 
> @offset=144
> Mar 27 18:27:40 rummelplatz kernel: Slab 0x00000000e17f7a52 objects=28 
> used=1 fp=0x00000000988570d2 
> flags=0x57ffffc0000200(workingset|node=1|zone=2|lastcpupid=0x1fffff)
> Mar 27 18:27:40 rummelplatz kernel: Disabling lock debugging due to 
> kernel taint

> The kernel is vanilla stable 6.18.19. I built it myself.

Perhaps your kernel is missing commit 8072e34e1387 ("nfsd: fix
nfsd_file reference leak in nfsd4_add_rdaccess_to_wrdeleg()").


-- 
Chuck Lever


Return-Path: <linux-nfs+bounces-21755-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JCzCRoLD2omEgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21755-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:39:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A685A6104
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC3332DAE14
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E2B3DD86D;
	Thu, 21 May 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxeAVwuN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D13E00B6
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369454; cv=none; b=e8lJBMuMurrVyhbaC4rN+igwEchgyyc3Ou9uC1jSI7/XvaxOy9IbEJQppT9ty/kzjM8MrVgdRYswHv73Ucca8YN2U+jmNer1UhH2KvZbGPk3Hob5vPc8AHSyy89Q8FJGtOTvAl6mSb0zDwJ4vz/oCkBh4M2jHhQJz7i3ie4MHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369454; c=relaxed/simple;
	bh=3A4ABUogWXqUcH2XBB4fGHk+veTGMhPfo2q3xnNiFTo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=le7uTh7YYK9fbDStF/oFUVxBQM9LyHT66vMnaOhHqAXhz45vOsOqWL6tbBvME8dGBIKKWpGv7sS4uCaeeVbUMULuBZ3uupNzrmqmiwr+2cOroMZ84rAuxzjqAqLiHXu51BlLYBqNSScJXB+boGItTgu7L3IrElr8+YnCqqoL1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxeAVwuN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BD1F00A3C
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369452;
	bh=TjsIhqznH5Eg/ytgWgZLUovvtKjrZtwQr/6hUFjE45A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jxeAVwuNgJNAsg5sB23UQXStMAxC3y8+64oqITzNct8FaBPxDv2jFlPa6h6KIPmjo
	 bS11P1TQHkjiP+NoLcMaYCgzu7Ynj+XDrpYvx5P0/TPqx0a8/0AX7SzjZEWzje8QzA
	 L39k2BVlOUdLUTBgyUwAveDK8QbUrR/QsQqGw0usH2sJ56ib7wRr5KunYJM8SX4eE1
	 ebCpqFbXHUsABsMAzfeyZnr7b0ObnGiKJRHFC17ZgpEYjTqnESoVevUVrDs0HgY9lZ
	 imbEyTp68jiPFG+y5HOTp5ao/FTrlVoIuo6SJT5ZaeE9NlqF+XdbdzxZcYzy35Zp+Y
	 zjsuheDUvD4rA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D16D2F4006B;
	Thu, 21 May 2026 09:17:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 21 May 2026 09:17:31 -0400
X-ME-Sender: <xms:6wUPanlI4wA_Y9CPu6JNugAN0uG1hXuQcXWqgX5OtZt2FZEV44wq5A>
    <xme:6wUPalpl_SxBLk6k9HSrDziGulIeRxVwHh0z_vhIWCDK6Kk0_nq96cigAnPS6r50J
    0UUar_8hJtnA0tiLzVLUSxwEz9agqtC_UpzkvyjxlM_hpiZqnIrxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvg
    hvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6wUPakhopt3fkVxp4jxXfXYK8HS0i-MkUbCSM1AUgeK3Epedsou-Ig>
    <xmx:6wUPakyatVxU14DbofxGBoYXc85wnh_Jvi8FWiJKQpE-tAjr32kOcg>
    <xmx:6wUPavJ1ZDJTE5B0vKQ7B-rjjpCZ2csCPUwluLncMbC8l_GH134LFw>
    <xmx:6wUPajQlZ1j3jFUWDpYJ0MAjB5S3HkTphXD3Y-QlnVaxGCZeazNIHw>
    <xmx:6wUPavqYGiHgNlw5kziBI0LwLceJfd0WnoWrfTK82kZwYoG9dA-3lND5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB8F1780070; Thu, 21 May 2026 09:17:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ac7J1ywJZZbJ
Date: Thu, 21 May 2026 09:17:11 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <0fc28e0d-423c-47c3-a7b0-d5c668e9796f@app.fastmail.com>
In-Reply-To: <20260520175016.29480-1-cel@kernel.org>
References: <20260520175016.29480-1-cel@kernel.org>
Subject: Re: [PATCH] xprtrdma: Decouple RPC completion from Send completion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21755-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 72A685A6104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, May 20, 2026, at 1:50 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> rl_kref currently coordinates RPC completion with both the Send
> carrying an RPC Call and the Receive carrying its reply. The
> kref_get in the marshal path is conditional on sc_unmap_count, so
> a Send carrying only pre-registered buffers takes no Send-side
> reference. When the Reply then arrives before the Send completes,
> rpcrdma_reply_handler() drops the kref from 1 to 0, freeing the
> req for reuse while the HCA may still be DMA-reading from its
> send buffer. A retransmission can put different data on the wire.

Bots and LLM review have found issues with this patch, so expect a v2.


-- 
Chuck Lever


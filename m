Return-Path: <linux-nfs+bounces-21865-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OR/IoDFEWr9pgYAu9opvQ
	(envelope-from <linux-nfs+bounces-21865-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:19:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C1F5BF9DC
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3B1C300B1F7
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085412EC086;
	Sat, 23 May 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxuinIub"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B003148D0;
	Sat, 23 May 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779549553; cv=none; b=rNr7Wwt07Ap6SxSZQpq0LVtIqB5SliQ2z7DQRmfuapoVSFu2qRVCuHmpXY957J6iTyPoumyr9AkxifLxv3XF8qL9zGsF/rNfsYZiBo0ok9+eL8CaSQmAx1eNhjxhHogGJrL44wTw/oWqrbTzGbqMScwyelOEHvVr+5ESQbaOY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779549553; c=relaxed/simple;
	bh=YRTG21GI4m2CSPoH8FM2gzejZFpAVHP5T1mPf6nD3kM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Kno9IeoTCrQYPOY+NvpeHMkRH4JIkhhLphZm3W/ms0Zh0489BVHz//JbnSptp/iixnCzrFwZuIvzh3rFpha3Zy2DDPevKc3JjhHBzCVQbWBaoMJpxGla0BZBQKP/kWxGLP45ztIVeaLuVngOCunnK+iap1R43BvKzcu3MbquwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxuinIub; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C2B1F000E9;
	Sat, 23 May 2026 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779549552;
	bh=HJt78pQpuXULMhmMcMQqTQKCMAMbZwy3Z+DlN9t0D54=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=FxuinIubUwzq0ttGy77kJ4CJjcKawjEY0UaP3e65FN9HNMEgb1vQ9c9pLFUbKSSNQ
	 oKHSSwSxbFHIhTyJX8/l5QEjfNrADhXXAvGiJZ1D14WN8JnhyailYol7BVLTJ5GPHm
	 K1BlAat7cyWMVZFAO9lMx4Un2MF7uT8kuh1gco1uvmezWDBK6H4eYVP1IFte4ucEWE
	 kpBlm+MnYG1Am37ZqTAQXEmWVRHLi6ENvXYzAmjuOcFY1CQAGJIMQ6w7a9oEOGCquL
	 fH47YSwHzzitW3eLjJTrw/v4dm+amafaaj+GjHKyCSfYLA9xU76TQrGKKaVa6nkyGF
	 FaOpxkqZOnWLQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68BDAF4008A;
	Sat, 23 May 2026 11:19:11 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 23 May 2026 11:19:11 -0400
X-ME-Sender: <xms:b8URagpX7I4xPO-ukJ7DD_7MXeYETqgORCuUQA_bgi8ZeV3xS_5Cuw>
    <xme:b8URahffmvXvVszQHXkrJlKw8g2XKXfIMMJ47SVFOgMdUpqaauhE9REnAqLsJs53e
    OSEQhIt_QHLdlv6sYdu8GeVJxaQ7PqQtBIuccWeSfswsHuBifTNj5MM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepmhhitghhrggvlh
    drsghomhhmrghrihhtohesghhmrghilhdrtghomhdprhgtphhtthhopehjlhgrhihtohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtg
    homhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgt
    phhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomh
    esthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:b8URauP3Uf7PxHEXDu311tnjCYdR75bqs5VQcxp_xoZbjceFLVyVWg>
    <xmx:b8URalKOUg99RsRGNcuqKt9-JVKrJLh8iNpcYMUgJ3u4nKxRQ6kxHw>
    <xmx:b8URag0HF4uZy-V1TyqotpxMD6TUCMVf3IEcgmmnBPSncw4NBZ9k6g>
    <xmx:b8URapU0mBHrjVlVbccOxis552RdP1uIxX9apnFP9zNxWElAdomb1g>
    <xmx:b8URaiOFtuMqk3cBfZSf69SuJ0dsRxDR5lY9MOHPShkI0GjzgkNVxwin>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 46C11780070; Sat, 23 May 2026 11:19:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AClLEs7g1A-c
Date: Sat, 23 May 2026 11:18:50 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Michael Bommarito" <michael.bommarito@gmail.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <1bdc4121-71a9-4f01-8a12-d6f86b28b4f1@app.fastmail.com>
In-Reply-To: <20260523014107.2460863-1-michael.bommarito@gmail.com>
References: <20260523014107.2460863-1-michael.bommarito@gmail.com>
Subject: Re: [PATCH] NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21865-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 32C1F5BF9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, May 22, 2026, at 9:41 PM, Michael Bommarito wrote:

> -			/* wakeup ssc_connect waiters */
> -			do_wakeup = true;
> -			continue;
> -		}
> -		break;
> +		/* wakeup ssc_connect waiters */
> +		do_wakeup = true;
> +		/*
> +		 * The list_for_each_entry_safe() saved-next pointer was
> +		 * not pinned across the spin_unlock() above: a concurrent
> +		 * nfsd4_ssc_cancel_dul() can free the next item under the
> +		 * same spinlock while mntput() runs.  Restart the walk
> +		 * from the head so no stale next is dereferenced.
> +		 */

Same observation as Jeff's:

The comment references list_for_each_entry_safe(), but the patched code
uses plain list_for_each_entry(). A reader looking only at the post-patch
source sees no _safe iterator anywhere in the function and has to
reconstruct the bug history to make sense of the comment.

The past-tense framing ("was not pinned") reinforces this: it describes a
removed code state rather than the current one.

Please send a v2 with this comment corrected.


> +		spin_unlock(&nn->nfsd_ssc_lock);
> +		goto restart;
>  	}
>  	if (do_wakeup)
>  		wake_up_all(&nn->nfsd_ssc_waitq);
> -- 
> 2.53.0

-- 
Chuck Lever


Return-Path: <linux-nfs+bounces-21173-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APJeNkFc72m3AgEAu9opvQ
	(envelope-from <linux-nfs+bounces-21173-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:53:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF1472D8B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 14:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 079853033ECA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0363BAD90;
	Mon, 27 Apr 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjjq6alC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA6377EA5
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294120; cv=none; b=SX3K1+sZS0pZpNDOAMHkB7J/C13bk9SG5rzsraLsL6EXDuGEhD6zKLcaFP2Uqmbzud+DLBahlhCohfaNdvaCqhprkz7FvTSSIRUz36h9xsbz1dUA2EOuxsiYQiA3C4WpEl1blym+HgdmBqM86Gs0cY71yKuXdI9udfNExSJVF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294120; c=relaxed/simple;
	bh=S3qwtNv8NvdH8AHLfj//6YE5o/GvcpTEps1bmt+LgpM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rPbxAIT2HiloFadtynoufTre7Ka4725aumPbPyBzR3sTn/q/LkURAiOmvS0VTl+s8XNBQHa3HwEE5NbxkOepQP3LPw56lM9hjLdtRuj29Vaz3dOLxxuvU3QoF9XwTf2QO4woYisJ/ScRT6b+BSAvZXQ9V3Vsn8judg/K1IQKkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjjq6alC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D071FC19425;
	Mon, 27 Apr 2026 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777294120;
	bh=S3qwtNv8NvdH8AHLfj//6YE5o/GvcpTEps1bmt+LgpM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tjjq6alC9xZpv6dnxcRKUqsy9xw6fUliQ/lkt8kZ/aW3PMrlkA8Ad/QwxipONu46a
	 Kk9MwxMMfbHAoYgBZA3X2pt50KayFRef2qlKrcSS36zAM0h4auOEx8zwB7pbGXLdqO
	 HzyZsX63+Jzpe/WucDBfHj1pAKfreDWh5VmITErxiQa9Es/n2exxJZy6wKXL6MrJcZ
	 CApaz1vGz46e9b+DX8RFa7AOoYO6yLLz6IIcYuaqXDLClq1PbjhmcuuYz8IgCMd3RF
	 K91w4OixUrZR324d8nG1g32T8fQ0tW6ZdvbHQJrEdRa+WgCZjy8sBcyHByDt7nS35q
	 j3W4vOSJZyDzA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB501F40069;
	Mon, 27 Apr 2026 08:48:38 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 27 Apr 2026 08:48:38 -0400
X-ME-Sender: <xms:Jlvvac234afOvjvObiFhfTvcUXrMyrAAo3YRuRU8vdLWzQna-6WK3g>
    <xme:JlvvaR5EyFifMhIDV1yABxi4tI8GSjO-t_jPxUWO2ggPgK2plR6c4I3EI9FA3_FGk
    D_0WLrivB9SqtyNKAd29DGJIsGNNDh3e1AYEdrTxGN4Mifexf1Yz7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthigsvgihohhnugesfhhogihmrghilhdrtghomhdprhgtphhtthhopegrnhhnrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephihinhhlvghivdeslhgvnhhovhhordgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JlvvaZWg5LliuGYHrcM-8EKvBtAkCRIaMjX5Al72z19NBvWO3Jv61g>
    <xmx:JlvvaUhcKl1WoifSx74SVK9VNzJwK0RRArkl2jHpqUZAqNQy_8O1Wg>
    <xmx:JlvvaUZxWkr5Nv0clrGHfh7M110pUKaRqv5pftlX_SkZ5mYzG8aDzg>
    <xmx:JlvvaRojnQmC8RQTiJXVa8_SKAJW8fr5rKrj2ftmUBIO00ZX5ks-sA>
    <xmx:JlvvaRMqrRi0ejqhwcdj8unpasJQAx7d6pSrISesy0S5h18yDolD4yDY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A2C1780070; Mon, 27 Apr 2026 08:48:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALn38cAhjhoR
Date: Mon, 27 Apr 2026 08:48:18 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Lei Yin" <cybeyond@foxmail.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yinlei2@lenovo.com
Message-Id: <4bae2fbf-68d3-4585-8d2f-9b7081b619fe@app.fastmail.com>
In-Reply-To: <tencent_C198D1548F26ACCF529CC312888839694E05@qq.com>
References: <tencent_BF5118C8B480E6BFEF401CC2B287682FC905@qq.com>
 <tencent_C198D1548F26ACCF529CC312888839694E05@qq.com>
Subject: Re: Question about "Not Applicable" status for [PATCH v2] NFSv4.1/pNFS: fix
 LAYOUTCOMMIT retry loop on OLD_STATEID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E2AF1472D8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21173-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, Apr 27, 2026, at 12:52 AM, Lei Yin wrote:

> Could you please let me know whether the Not Applicable status means:
>
> 1. an equivalent fix is already present in the target tree,
> 2. the patch was sent against the wrong tree or branch, or
> 3. there is some issue with the problem analysis or the proposed fix?
>
> If needed, I can resend the patch against the appropriate branch or adjust
> the description accordingly.

The linux-nfs patchworks is for NFSD only. "Not Applicable" means the
patch is not an NFSD patch.


-- 
Chuck Lever


Return-Path: <linux-nfs+bounces-22436-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +qINKaNxKWr4WwMAu9opvQ
	(envelope-from <linux-nfs+bounces-22436-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 16:16:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9CC66A27A
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 16:16:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LuaMemb5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22436-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22436-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 469E031BCCED
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jun 2026 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B833F7AAD;
	Wed, 10 Jun 2026 14:08:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5540B37A
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jun 2026 14:08:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100507; cv=none; b=L8aM1sf+lNs0LTlrLo0H/oS0ToVB/8MTIZqbQJurE9KN7KolI12CGZqvlfVc1Hz+JtCXH51REB01RCc72hX53XUO/XY92YqP5nArCH2OKAU8elvml8arG4ctYlx2HL492F4esIkOmrc0jgCu15jQW0g6QFmD1HEy6G7nFYjYzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100507; c=relaxed/simple;
	bh=9toiMLDA5d+fprtpuBfAahdQb6LfLIb9bccSR8YA4xE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GA8pqRmaT9cTwWmaOHsljIBhvvL19muUSiHIyTIzXkhvGJM1aQOoJCysSCwVPGlZKH2ClZdGs3Z8010ZPK9yC7nT0/zto2/cHBRbS05IiBhCf0tNnPtnIvfWCS3qYXnoWKcXqxWzIelWqS7rxhL4JZedREmO2JslPZRMw98/q3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuaMemb5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C561F00899;
	Wed, 10 Jun 2026 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781100506;
	bh=wlJepTMXxVGdUPwubiend17nN3n03yoXyODcG74aaUI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=LuaMemb52P/VkJuWuu0AXmK8iDG7ZxGmNooW0F085l7nrb93976AnjrZexoOUKLpA
	 ynaDHGV2fJvDUvJmEZTJm/vkuR2h0109soy5AFcCygd5FvlSwziDQ9xjh8/Bbkp9/o
	 Fpv7rCN38bkCyFvvPu6dA5KIW2x/7z9DqT5MuB93t5Ji7OdZv9ZFCSBs0iWotlIPgp
	 Pk5Dg/Qm66g2tMEu9bZcpBNcV+QnGibGUeCxM0Q77JqILrWPbk+z00dwTibUlEEveB
	 abPvFCmTVsIftrmapLwHt6CdFlV8EGXNPDnsyrm0dMqSe1yL2hEcm0/8QcoYYGHH/1
	 YPPvFxJ/4gJiQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CF91BF40076;
	Wed, 10 Jun 2026 10:08:24 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 10:08:24 -0400
X-ME-Sender: <xms:2G8pait6N9gU0AatSPT1lIOuX3Gjror0nt3Px7RmQzrNZhsyH-jL5w>
    <xme:2G8paiR6lKzpK7bsQluRBaedcBgT3mS-rkDMqUjBM6802bOT3Ddb2nF2kVGumX1eu
    udDO1oh2kkguxvkrySvNtfvn62JdptN99YJSvrZ_u7tjLLyRiAVIeU>
X-ME-Proxy-Cause: dmFkZTGKTTPl9q19VuDJCVgUBF1IhaND5ruh5rp6Algr1bM5QYhq9by4/DIwWsRW2bq1Qn
    9fQucwKmEtZtaEZ7jywE3N9VQSBHR2khAG8Yv/46riOkN7YlxaCDl6arO3UJ85YSXk2bEt
    a5eFyojjsMsC19KtSDVfyRH5dgZ4khKHC3OlHhV+MixRRWerswcpaWyeW2IJuRYJjfOe4r
    l3b+R1cZJ8jn38+DL1eUOIbpxs4OCHswxXHLEPjaXC8MXCp738JHMTtZWSQckUk6MHm7EP
    vreQCfS2f+j3mUVX2kDVUu54DMo7lKBSyDGYD1YDbFte2qhpRLGOxt0+KwpMZ4MS43JIYF
    G0UwxMcUF8fjSGL5q91cq39GPrJko5UOnuFoAo8XUmn01LPWBcVqHMeUEGkJQw5OamYWJK
    Hp0mCBKC+Wo4LrBdQ+dnsH04i2bSB7pk1V6Hq7vpNr1E6F5u7qQyheU9gsePQop1tK+/iY
    eqogvKP5zn/8b+eHjX4qQ6VHbqjPqqoI4OPFzNup+c0y/0G0T60Jj+k9WsNTHEyWpIuGl5
    HeTQ88G7Kfsz3Jgs4pSjxehcKybw6fZVf7gMOACHIaTnK4Zf4mMw3X6e3Xl2bUIJfvJRQx
    8Z5bOmEqUyvZyRG1e45PyzcOBlAHix3C9/Ay16EtOzsH+wK31mcTA2ybU1LQ
X-ME-Proxy: <xmx:2G8pavLHE8WSHKW-WQCTkSeAGC_kY9ePspcs__okdcDCs4-QQiKP2g>
    <xmx:2G8paus0OaQ8TjkoDp9Rv_G_6SCGyAnrUcUQoaJIEAuyEYfwPt0BSA>
    <xmx:2G8pantGhbJyaUSiv5OqdGPTvCg6MWxVdc1G3-sZZlf3IYs-oxQD_A>
    <xmx:2G8patV3xmUrAhtBOkpSv6C8IxYouhueT9U-4nL4TUni-sFM54dayg>
    <xmx:2G8paoV0siuEmlhW3IWj8AaNl-5tvNVKLNyWjk6sqcJvf9j5D9jMLUn5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A4923780070; Wed, 10 Jun 2026 10:08:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AurzjksMev5R
Date: Wed, 10 Jun 2026 10:08:04 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Benjamin Coddington" <bcodding@redhat.com>,
 "Donald Hunter" <donald.hunter@gmail.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, "Qi Zheng" <qi.zheng@linux.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Muchun Song" <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Message-Id: <e2c27654-4344-46cd-8bab-dfe0af6e0db0@app.fastmail.com>
In-Reply-To: <20260609-nfsd-testing-v1-1-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
 <20260609-nfsd-testing-v1-1-e83acead2ae8@kernel.org>
Subject: Re: [PATCH 01/19] nfs/localio: fix nfsd_file ref leak on nfs_local_doio() init
 failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.65 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22436-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F9CC66A27A


On Tue, Jun 9, 2026, at 1:47 PM, Jeff Layton wrote:
> Two early return paths in nfs_local_doio() fail to release the localio
> (nfsd_file) reference passed in by the caller:
>
> - When hdr->args.count is zero, the function returns 0 without calling
>   nfs_local_file_put().
>
> - When nfs_local_iocb_init() fails (e.g. -ENOMEM from allocation or
>   -EOPNOTSUPP if the file lacks read_iter/write_iter), the function
>   returns the error without releasing localio or completing the hdr
>   lifecycle.
>
> A leaked nfsd_file pins the associated net namespace reference,
> blocking network namespace teardown, and holds a reference on the
> exported filesystem, preventing unmount.
>
> Fix the zero-count path by adding the missing nfs_local_file_put()
> call. Fix the iocb init failure path by jumping to a new cleanup label
> that releases localio, sets hdr->task.tk_status, and calls
> nfs_local_hdr_release() -- matching the existing error handling pattern
> for the post-iocb error path.
>
> Fixes: e77c464c31b3 ("nfs/nfsd: add "local io" support")

I don't seem to have commit e77c464c31b3 in my tree. Should this be

  Fixes: 70ba381e1a43 ("nfs: add LOCALIO support")

?

> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/localio.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

This updates only a client-side source file. Should it go through
Anna/Trond's trees? Or were you thinking that, since the leak
impacts only NFS server behavior, I should take it?


-- 
Chuck Lever


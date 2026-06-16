Return-Path: <linux-nfs+bounces-22649-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /GsCKnziMWp0rQUAu9opvQ
	(envelope-from <linux-nfs+bounces-22649-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 01:55:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B78695CC8
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 01:55:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NzMoLksD;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22649-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22649-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F11FD31484C3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 23:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9268D4014AD;
	Tue, 16 Jun 2026 23:55:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393721D596;
	Tue, 16 Jun 2026 23:55:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781654132; cv=none; b=tkCnqxeERatMrmUO101zeH0VkRJERUMV9+KI4IyNDzug54zJ/jp+wQKHrWJrVKmkry0AjGvTt39Uj3s22am1lFDeRhkMYGKmG2G+jFK184TkTT1Ou25hCXQh43gG4YqCWUFHfPZIenB9KsdKArNUqeSgwAQlefO49oW8953CsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781654132; c=relaxed/simple;
	bh=SDmIBId0ITXPr94PESh2YNLWgSq9W6bRB7Yfjw907W8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gMwS8ZzSrVB5VXA/k8YK8vmQVyit4FrYiy6/EVzvntdA1ZBCqBwloTbaD/gT7qmOCp9Dp+pzQxTGwuGzTTzitpY9s8T+93P+VWtA6aKZP6a5xf/xVBtoEZolIjSLhV4oeCEWRZwG/A6SSzbXIkN/fLKzkxNJdlWMI3lYa7S9OLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzMoLksD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829AF1F00A3D;
	Tue, 16 Jun 2026 23:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781654131;
	bh=zLdTwqbeehqCKRrfdVRiWtHbT6AUgFS6H0xX4wk3A/s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=NzMoLksDjPU/zEUY0Zn/wo9MAcUsn3b9WTU/Cboa6COYZCkc41QFHCs5AAuE6oZCB
	 l1VVSO8LjKEz672Y15JIiT+fyGvdKCBTmzNkCsSmq71mwwWGcilUVZNlMP/5CT3qiR
	 9UsKFOha1BEvWTd/0iHsrMWSLrtV65b5YUo9NdCUhnXGCWMPc3XbMcVHbqAPbk4Eo+
	 LRD46vfz0LoqQYTe4ofOcMiyrPMEmm6+Qmv8jcOrMB6VzVXCt2ZF7SjrXSuUQNpKZ3
	 +DKBAk+rDlCR/maj68rA3DgRh2WxUvh763FGlK+e93NLsqlpB/FoutQT7btKiv4RHn
	 Me/V+dk0gYRtg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AA092F40082;
	Tue, 16 Jun 2026 19:55:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 16 Jun 2026 19:55:29 -0400
X-ME-Sender: <xms:ceIxav2pzg_6w4XGz02JjoBqeLHc7y7dIW5R9Fdfuvoq5o2eqpSAyg>
    <xme:ceIxao6Cgl6dJGE_jEB0b2ribwAkhZgWpwHnKcm3EIv87msB0JkljAd3e83kqhSXY
    FwRBTvNHx-2Wjzh3-re0EBv_deFTU7BLJEx19PGL70QhieV6-9NOQ>
X-ME-Proxy-Cause: dmFkZTGKv/73K9Q/iMN9KBKYeOGfzfcyLZdCGUapQlr+Y5h7YvHT0jFxaXZed4fWbzf1N0
    zCPy49rpMyyycy/kF6HkmuKbN3eVydqcEO5uXv+ISGsBkFQhlGANbHdrtXF+19wIxCJh87
    ZLQ6tirMyJgHXFAkO/SdZt2njPyPEReNhTPtZ0qUGsKuVUgBBh5dryY/8gtycof1YrddSD
    8Ltc59R1mvifod6oPfNE4pJz7wwSOoC6cT8+Z02hTyfdfR44Sl6VB7l7D0d3VLlDywv+DC
    57hEiRYB0w9/MA/f1txn1QrHcNdMGchuaovR1j4Epm7pKO9dLeyNnUMCdrDOUyHk4ydoME
    uxb6LxIFO3Ix4HGiyDUSVo3gUz/RReJePNIayhzCzfW4u5rQYCbgAi8/SaDjc7L/HlAENt
    YOW/KDkj0XB15sSS9EK8szczYt1hdjLo89BjDFUv+NSeYypcNF7KZJxFM9rU3w67I+vHNR
    /QKmJO2bDqiHEF9ZyEcE3ddHJ4sNd8KxpqgONUzkc5i75O/7Q5CmLA1u0DTC+gV9m9Xol0
    yjgKDkrrIak3albCJPjihUt3PqnhJ1C+fVEyoGLL6QH+TA03Q4ezCAOHKxLQ4a8xVWcBWW
    JOPDL6gHfNcxADCbEVMfSzh+QUnI4HrBJbk8ljZiN/wD5nsWr9Y48CHBAxbQ
X-ME-Proxy: <xmx:ceIxaiCfMxuULjeB_-bhxYOBRmPXSjt2mni0BoFhbKfbwb3zW4m2kA>
    <xmx:ceIxaij4c0BJFwNnCMVf8ysHNj90ccP4_6EnYHt-Vz39AXNGHeH_mA>
    <xmx:ceIxagYC9apkdGNetH8zvA4bnG7IVgvGZCyk3d-jOEVJDXOVOWxkew>
    <xmx:ceIxajlRHb52IjHDCamNwWqtggr5CY8xXVqNF9zxD5kHNAydH4YaXA>
    <xmx:ceIxamiNeyH0_APP1FyWZUzz3u7PJepumy6CCDo3R78Ui0hIsDHZodp4>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87A4E780070; Tue, 16 Jun 2026 19:55:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Jun 2026 19:55:08 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <d29b710e-2771-4e5d-8765-1de806a9aa72@app.fastmail.com>
In-Reply-To: <20260616-exportd-netlink-v4-1-03505aee3883@kernel.org>
References: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
 <20260616-exportd-netlink-v4-1-03505aee3883@kernel.org>
Subject: Re: [PATCH v4 1/4] sunrpc: add per-netns per-procedure call counts to svc_stat
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
	TAGGED_FROM(0.00)[bounces-22649-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09B78695CC8

Hey Jeff -

On Tue, Jun 16, 2026, at 8:45 AM, Jeff Layton wrote:
> The existing per-procedure call counts live in global
> svc_version->vs_count[] arrays which are not network-namespace-aware.
> Add per-netns equivalents in struct svc_stat so the upcoming netlink
> stats interface can return namespace-scoped statistics.
>
> Add a vs_count pointer array to struct svc_stat, along with
> svc_stat_alloc_counts() and svc_stat_free_counts() helpers to manage
> per-version percpu call count arrays.

This patch appears to break the build for an NFSv3-only server
configured with CONFIG_PROC_FS=n.

svc_stat_alloc_counts() and svc_stat_free_counts() are defined in
net/sunrpc/stats.c, which the Makefile builds only under PROC_FS:

       sunrpc-$(CONFIG_PROC_FS) += stats.o

nfsd_net_init()/nfsd_net_exit() call both helpers unconditionally,
and the declarations in <linux/sunrpc/stats.h> sit outside the
#ifdef CONFIG_PROC_FS block with no !PROC_FS stubs. CONFIG_NFSD does
not depend on PROC_FS -- only NFSD_V4 does -- so NFSD=y with
NFSD_V2/V3 and PROC_FS=n is a valid Kconfig combination. The result
is an undefined reference to svc_stat_alloc_counts at vmlinux link
(NFSD=y), or a modpost failure for NFSD=m since both symbols are
EXPORT_SYMBOL_GPL.

net/sunrpc/svc.c is always built, and might be a more natural home
for the new functions.

-- 
Chuck Lever


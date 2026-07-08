Return-Path: <linux-nfs+bounces-23169-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L0ikGBtKTmoPKQIAu9opvQ
	(envelope-from <linux-nfs+bounces-23169-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 15:01:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 493CA7268E1
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Jul 2026 15:01:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hJ3SD2b/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23169-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23169-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D31DA306A7E9
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C246AEE8;
	Wed,  8 Jul 2026 12:58:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5947A0B7;
	Wed,  8 Jul 2026 12:58:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515506; cv=none; b=EmSF0e3XyEiItf+RMRZ7AjTHQLnT2acSOd5aFaKqXzIX5rpAaIuMlofg5cnEuESNognN+vGmX4HT6NyqLy9Yf//95tAkQGzjYKn6bVM/SoLsKj4Xj5iBhAAL94f7tTA6xSb6jz15KdghsN2/Yp69hvj61pxCWrsHlpZ1m0Qz6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515506; c=relaxed/simple;
	bh=YNlbfMe7IjLEtrnfl3yeMzxTsmPJmaEGZXA4hkPj/rI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gg/VmX/Vfa7n/JZao5y5DSgAGTmpnmQq4otKCd6fkoTuHx/I9s6rQf2O4WprKIuPMNvSxm6Yur8PquCL7VpcBlpLyCBc03P3p/0M/Vq1b9Hr52MLk1LtSY5yVVUF0ReS4Ts8PGP3+4xk2gx1F6MA1qLlBNlqs6+Y4IvQhkHaIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ3SD2b/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9451F00A3A;
	Wed,  8 Jul 2026 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783515505;
	bh=xm3xg4KWA1ldRv7EorYZDzsMgM35ZrzU+YdCvPgOFGY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=hJ3SD2b/zeZr/ealheQUI4XBstv9gf2KSjh64zYam7oKqcN64bn9MM1wxw0Qbqs6s
	 amDTANx5UKbbRcYKyUN5MVwUu+0iCz6Q/ezP2m4IV+IA+0+cMiVFuUZ/qfHVizY/py
	 Cj3uaiOFmpMA/nArfflCxH9m2KLLLJFTFGrPP+OW62n0/oO+NyGFEM8rRjKJgyrX+F
	 k8RUNPuBjMAtqezLtT7lEH61oOIwvoKBPdhZ2vOOO857Q6i3v6/K3WhV36ik0yzeJ+
	 OOByY9xmthR/MgisEV2VDbiAstIo5iNZ3EItGHYsRKOXTCSH3H2QYPnUL50/Ba2hbE
	 9LgXFqJFIPBXQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B2D93F40069;
	Wed,  8 Jul 2026 08:58:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Jul 2026 08:58:23 -0400
X-ME-Sender: <xms:b0lOaqHi9Lxe18lZ3VY_zh0u-EQypuOBTGdE3WqAorteygB9EZtF0g>
    <xme:b0lOamL4291PhJx4ihnf43pLgvftK-QIYeLHwXkZy2ODXwJBcPsp1sMUYmorv943X
    lAS7XCCmDVVV3iGqdoRqxN4z3H_IhghNurt_HnCaLUo19yQAJr1if_e>
X-ME-Proxy-Cause: dmFkZTEy4qbe4+qGdVa99u5/9ySaOJls65jRaaw5i3YdzHfiedbgOXMgxuAtiIHWZ+uqE2
    iUTXP/GHpOpKNAC6XbzoQKLcNxhFPOmDOMxDw6SyuEiIoFlDGHhfxiRJ63xiax/ODyZAfm
    XyuJUD6QugluSPJfky2aAfZqh5ti5PYmSiZ4WKwgJxrRLxw8OqLAXe6YZTZujQL/++o1f/
    p5WfNhaw33ZuNOYTQNWCNh8nCwv0S6/HqaITVynPZjwaiILlcmG5Xsao1LAFcEVePPq4wC
    MkyMmlEMKEF6LOxg+M+ArWQyDCX8513CVA2f+knpPfKIozzsLcAwpS1JvzYfKiKw7PR0jL
    w1uDA67H5WSQIoMPOaC3onOwTC993g4sBT70JTMJueARCknIS6uIDHHGuA1U9tik2wJgU4
    ISbNhVn2299qoOdVSb3IzrgSUoPmQfeYvMKpYkOtSaG0BUN5ewlqBO1CO+giqnbMW5qLNw
    rNjY+uddxk9SRTiiAH1glQW+lMlTdh7Q5JuM893ei9HQtD47LvUyZ/pcQk6JNmLjwwEm+S
    zHu7itczD4UPF2TkbjEjvDpN4haOJgO25QYcOmLJIIIFPJTEeaSe+t86Z9JAm4Yiq4qo/n
    DQDS1jZWak4FXVODLKQ+6k/JIGl0qL6PZ/JiuqKzu+OdAQESlXu61ksv27xg
X-ME-Proxy: <xmx:b0lOaqVKCdesnQ7-xXOz36Ht7Hr8-ylwY7VxDpy5-jHU6-8EKdprAQ>
    <xmx:b0lOanC8wt8povs8NMbbQL1KOI8cswZZ4PBoj4c587-MpYKbrLnBeA>
    <xmx:b0lOavHXfdtZ-8kcDLB8XJa9patJmln0BviMS0F-ZGsKr8g-lIe8eA>
    <xmx:b0lOao5ejwwoLtl8-zXsbPAJVeZuDKgvwPoT1wWtX5pjOXZcCAKKmA>
    <xmx:b0lOalkPjeryNxQwBxLhI2Kj7NAetKJE-inDRoS2eRUpEF0T8cI8SjzF>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8F88A780AB9; Wed,  8 Jul 2026 08:58:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-vGNRBYFzmF
Date: Wed, 08 Jul 2026 08:58:03 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <6e5e956d-4a6a-4548-8d9b-3ca3628a018c@app.fastmail.com>
In-Reply-To: <20260708-pool-mode-v1-1-98e9e106ebf3@kernel.org>
References: <20260708-pool-mode-v1-1-98e9e106ebf3@kernel.org>
Subject: Re: [PATCH] sunrpc: drop unneeded nrpools check in svc_pool_for_cpu()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-23169-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[neil.brown.name:query timed out];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 493CA7268E1



On Wed, Jul 8, 2026, at 8:00 AM, Jeff Layton wrote:
> As Neil pointed out in review:
>
> "The values stored in svc_pool_map.to_pool are all less than
>  svc_pool_map.npools.  So that if() condition cannot be true."
>
> Drop the useless check from this hotpath.
>
> Suggested-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Chuck, feel free to fold this into 5/5 of the pool_mode series.

Folded in to 5/5 and pushed out to nfsd-testing.

-- 
Chuck Lever


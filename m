Return-Path: <linux-nfs+bounces-22304-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6wVcDxXgImq2egEAu9opvQ
	(envelope-from <linux-nfs+bounces-22304-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 16:41:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69A648ECF
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 16:41:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Sya4zRwk;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22304-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22304-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 009C930BC292
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C62D8DC2;
	Fri,  5 Jun 2026 14:32:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802131DA62E
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 14:32:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669940; cv=none; b=lstemwVRvHHeeeFSpM7DX/f39T0laoQqU0bf5bI03gj5k9LJFdD9dhZd7RtLS2Bk+sEjED8QjK2I+43Q54SUsL165XCr+YP5Jtw/bXvao5dv80lqJJJ89HWye5QC0r6ohZgCcusEVoOr4ohaYKUi7TdYME59KOdJ7TPaAIyMjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669940; c=relaxed/simple;
	bh=2Ns+CiPrznH6P9iS+A2/n8agYz1n19MOBVuSKXaliM8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pUppVVtHgVVrq/7b1idSx9441w4hmYQ3HiSx1zkgcOd67NNIvz1rGY88IzLFkjdT4XZQL4+IW5VXhZ6wcbc2rxw+o4YvUi82Vv+9kgzZL20edRUtG4PVrYFvTaRf2ovfJXamIeCOu83gw02KQVQOjvkfuLdVYJ42CDZ2htRhPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sya4zRwk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D411F00893;
	Fri,  5 Jun 2026 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780669939;
	bh=F54BAFf3ksDGcR/ZTZE9IUI6VUBYdSZ5PkOxo1F4bAk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Sya4zRwkNZM8ltL3w2aUH8Ci97PpalYo0HsfyAYUibvF2PBENdpr3kClpkm7vAnM7
	 qfoO0kb+HEnteEnPcMar00gbWwjDeZczo/JZv+qN6Ko72KMRtAqUPRTd1YueCQotvk
	 WBBR0DDghB8wnOyKs5Q9n4Zup3VS31qmIGXEg9WFcz5vQuO4hAES0yjFh8OOcXaF55
	 52H5BNVqCR7bIh2gHrJgGJeOM67qAY1yzLjyVKHn4+LC9M3tXPjLrS3Li9HljGjCdT
	 d+mjCgSPB7pzb7wfZI1eugddwCoULgLvFhAz3aKNl+AwQBECn6LeE4wafybDf2C9aO
	 VBweWDW7hFBpQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 123F5F4006F;
	Fri,  5 Jun 2026 10:32:18 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 05 Jun 2026 10:32:18 -0400
X-ME-Sender: <xms:8d0iatwEw2C8E_MbEXafM07rThCGoJVIxhlvgbV9k3gwV1vZKUtgfA>
    <xme:8d0iaoGNxYcnkR66nnlUxu6rsyK7GKRxWTQjOtwHroAMlIkAH2GRuSUVwhMfXDetW
    XQoMctRD_Qdbxc45NXjzKyz6cLQKYG9gUbzP3vKjX_tpAmnSfYmGQw>
X-ME-Proxy-Cause: dmFkZTGttdxm5H0Y2lHRB9cAwy6Ftsdp9TpTqUpC5+Ic5UkdGSEOwnAQFKfUNQ5aDktWaN
    TTD4Em0FqU6AJ/Lf57YxpN6A08fwfKClj01MWd+DL1pCdn7I0zjpNE0tuC16DBK3y220F+
    UboPVA39JcnC8CZa89GOO2H/AvuOQqLpwDzqS6YaN18CHiwo5Lwadd2hyjBONNZaOXeSvM
    RR9NxaKpFhnrr0zKhFi8aDbC8EiAm9uRcvsNmip3lGJnBg9fGWLk0s0CliOTbGsQsrTp9n
    WRlY1yDh8jel5ACyplSXg3rI02Gs+zTGOYdE7C6KalxTjl32Zcr0UAewfOE4eOnA7WhEMs
    k7cWN7JidduRGJBJAny7i2nXEHf5jN1ISneyF2YFONP1oxCMAz6DcZ9kT3w2q4onIIOPIF
    IkVdVisIYS6x2Gz92bykKoLiYsngX4FFDmcYHmLYZe4gNZDSliljMoFVCW82STVX9N0uaq
    bBiZib5WMxnsCQlubFA0+46Wbv7Kr0XwCtGFZIQ/DVJrkTlWB1vS2YbuXOk1gwurhxpKEM
    c4oHiui2sLB53eKkrnG6X4GdfVrQyHgHNFQK6+JNYi9saY0d6++uiFoL/nvQmvHny1fO3A
    Eos5uDfnerGkfgODkHwChagxQAvZ8E5dIAT9Xu+xThVQcBwNGZSCngxkgnOA
X-ME-Proxy: <xmx:8t0iasZCIqq_-pUR32INBx5gmz77Ll55hoBWg_a2apGhwcWdNFDybw>
    <xmx:8t0ialNgPFQbqFe8q444M6JAk-_kKunMPW_25PsuY8DRPuq3duzNkQ>
    <xmx:8t0iahbLBJCqbH6Gf3xyS5dKIkDa0CXkoGi95tM0xMcgVASI1XvVsQ>
    <xmx:8t0iaj2KXjtqSl2bTWODIlcUiPmsXEnEH1eWCH4uPaJ9qZjJgW4qZg>
    <xmx:8t0iane9mhV_p6kHveZgSxwmlN_1wD-4ExCPeNwRXSNap53zV58gtzrY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4011780070; Fri,  5 Jun 2026 10:32:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABrU-SqmuE1V
Date: Fri, 05 Jun 2026 07:31:56 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 NeilBrown <neil@brown.name>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Message-Id: <a6225380-8520-4789-a64d-b8b94310dd67@app.fastmail.com>
In-Reply-To: <83C74302-2A2B-48B6-B0F0-D5E8CB487BBC@hammerspace.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
 <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
 <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
 <178044079821.2082204.6117918610145832039@noble.neil.brown.name>
 <561e9ac6-348f-4d6d-b896-38dbe5ede3bc@app.fastmail.com>
 <20555E8B-0E49-4328-8B31-0F73C3D286FE@hammerspace.com>
 <178060780940.3392745.3574880233025675236@noble.neil.brown.name>
 <83C74302-2A2B-48B6-B0F0-D5E8CB487BBC@hammerspace.com>
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22304-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:neil@brown.name,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A69A648ECF


On Fri, Jun 5, 2026, at 5:29 AM, Benjamin Coddington wrote:
> Also, because knfsd doesn't have different resource pools for each version
> we're going to want to continue to balance the pool for all versions
> exported.

At a higher altitude, I am treating this issue as a partial DoS surface,
so it does indeed have to be addressed for all NFS versions to eliminate
that surface.


-- 
Chuck Lever


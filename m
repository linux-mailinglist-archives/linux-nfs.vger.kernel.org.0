Return-Path: <linux-nfs+bounces-22666-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Tw2MRDyMmrN7wUAu9opvQ
	(envelope-from <linux-nfs+bounces-22666-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 21:14:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5269C194
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 21:14:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mz51qBF8;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22666-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22666-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3936B3142094
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157430EF94;
	Wed, 17 Jun 2026 19:14:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B7380FEE
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2026 19:14:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723662; cv=none; b=jZJh3TZyIIVT7feWKOgZ+qZ5jxln3yJZVHKYClK7Z04rlwTLut5cBtknxE7tqKXX/T/kgtEPxTTVdPvKOU2P9AdLoKXBKAlm4jfry8wJ9aT5U/B/pVsNcmxdaavdIAaJnQbp7QXVBhonXQFnzSy8OsZJQnc/elD4K4k/+8xdUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723662; c=relaxed/simple;
	bh=vGjbMdhvAAXjKtuxLI6jO5WxRN8IFhrExGr6HPwsEYE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EJ/jksXULYYtopiB7oSPvSm45mQCy0Xp7E/KbVyB/11Dh4cLB6VUlDB8pQBSCKjoTyATp+eBs+JA7t7JDxLI1P8s8IH0W1NMrZjWBHXoxwP/d/600jwapE08eIMn6KXXPP2S+8UJAULOtEh3IdXf9/Tp0Tv9K7CIuZNKFbg3j48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz51qBF8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EB71F00ACF
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2026 19:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723661;
	bh=pCTGNAzI9pRAcaCqy6m+sWOx72nHxk0B/5ECKk0rP8Q=;
	h=Date:From:To:In-Reply-To:References:Subject;
	b=mz51qBF8O0fzWcoEQ7b9xJLiUaSxP/KGHZFwd3ypbaXIVUJ74BRIg6OiTCCG+hmY4
	 yWbnf4gqP7OCVZ//9/jt8wR/As6KGBK/BdsBjHkAY8zVqvej1shf8XEpTKAzlH8MbK
	 ZTBJ6BL3qOGd18vwOuR6fgHdM+mE3SfxgQr8CAAnbkD9IcAcg3AYVxNz25lo5lbjyf
	 bZz01AzKsg1Ygt7Dr2J8ug0uspITQYnVWIG4uPKwJ9Pd4ezjAAelKvEjIktitNbWbQ
	 Tr3wxBeyeesopI+ooDSuvhWzBo2O+oojzFzwnYBDPQPWddptgIt4EMe1VHVWsmOL1F
	 2owrs7a1tV3Tg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DAB37F40068;
	Wed, 17 Jun 2026 15:14:20 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 15:14:20 -0400
X-ME-Sender: <xms:DPIyajFb896EZ8_sCAKyeTLd2_bbJduRzjgaM2qdz1XfIkkcxzNgPw>
    <xme:DPIyarKtRvx-d0abD2J0Oqrm5SiU0xdR4N-0ALWnoaookJmYqID1w8GchCMjZ_zCz
    jk5SxmDXY7esLOhgIVqoWfxMFGAWSJRV32uxlN_pImuDYrcij3ocQb5>
X-ME-Proxy-Cause: dmFkZTGhd3d9b7S1fjzzCfzHEf1zTSqmayIv7WC9Wf8iVoMNQA1pL9dLc+LTtksb7JTLh0
    VC7iDob6iR4PJcOgS4x/cvDsjlAlxq1zFS+aTO8lwk4r+NcASQfFYhwY6WGOjWh4TuW2eK
    7nVxVZ9wj/VmZjrM1atyjBU0GC4xnFI8P6Bh8Wpmelj58rv2d70o4jo6SU1zUrM5mSIMf3
    N3cqFwSYaMrN8rs3o1fv74dt85ksbROX7mP5EDqgcq2FsA+JK+PVEirKx7/jT/70TEDXW5
    VrK7j+lAukAhQQ96pjjpRtlb84T0dYU7YWOY8hQ7KYx4N//WD8ctNSvnY8cCEMHh3ODfLc
    SNbB0MULfnO4MlkEVaTfS07I3YihWOw59QsVOv8m+GXfJHKA4rF+0pdoKxHVvDFiSfrX2a
    wVEDuoozzMKskqElepIPXxrzrTW+sFQIAl0/s5qGYyYf1mFAR0ms5atdt248eBsF9WQDbf
    18jzE/3D72Dx9eH0fGMBz7xZLEZmDsMk9P8jDC+1gq6ljmz88arMf7TliPaSMiEbAQmr1O
    s2oJR4nQ/h6ItPJn52H8EYe57d41Ux67N9fCtJ3t3+gEU0NCFKkDpwIv3hfixgMyFy/28U
    xDCm3B4tU/8SgMR3TgtaFfGqv/Rs3zHDAsAaN2p4hn1KEDcmg0l103wiVIjg
X-ME-Proxy: <xmx:DPIyakDT34pqtwKipvKkqXX2av1jUnrpN_bwj5Nm_7Rt9SQ2HZ3auQ>
    <xmx:DPIyauT14mBW0edoYUdAv7E9MnL0fx63rWJ50PxvX81iIifTusJ_iw>
    <xmx:DPIyaqoFH_qhyXvrMT4g34bcOh6RQ-uBBjKvzrxFYCPXve8CbbCVZg>
    <xmx:DPIyaoymlQ1uockQViXE1K7DW9Nb30DHCt8PRKYitg4QhfPsrNGZQw>
    <xmx:DPIyanK7PJtmjH8d6A_GPRiogOoWTVzedZ92UUIFb45vqaVG9R9FfRzV>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B13D9B6006E; Wed, 17 Jun 2026 15:14:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Av0zoSso68Ek
Date: Wed, 17 Jun 2026 15:14:00 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Shyam Prasad N" <nspmangalore@gmail.com>, linux-nfs@vger.kernel.org,
 "Trond Myklebust" <trondmy@kernel.org>
Message-Id: <9ec7f349-c7f5-4936-9750-1f14dad394bd@app.fastmail.com>
In-Reply-To: 
 <CANT5p=py8E7Rnd4C-1vMHMw2_dMxS_Cshy3hcbOEXzaO1pVqLQ@mail.gmail.com>
References: 
 <CANT5p=py8E7Rnd4C-1vMHMw2_dMxS_Cshy3hcbOEXzaO1pVqLQ@mail.gmail.com>
Subject: Re: Status of delegations feature in NFSv4 client
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22666-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nspmangalore@gmail.com,m:linux-nfs@vger.kernel.org,m:trondmy@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35D5269C194

Hi Shyam,

On Mon, Jun 15, 2026, at 11:55 PM, Shyam Prasad N wrote:
> Hi Trond,
>
> I wanted to understand if the file delegations feature on the NFSv4
> client is stable enough on Linux to support it in production
> environments? It looks like this feature has been around on the client
> for a really long time now. We tried running some workloads and file
> delegations offer really good perf benefits.

Like you've said above, file delegations have been around for a long time
and I would expect them to be stable for production environments.

>
> At the same time, I'd like to understand about the stability of
> directory delegations feature on NFS (I understand that this is much
> newer and only a part of NFSv4.2?). If there are gaps that exist
> today, please let me know. I'd be interested to submit patches to fix
> those issues.

Directory delegations are still fairly new, and are used with NFS v4.1
and v4.2. We have recallable directory delegations as of Linux 6.19. Work
is underway for supporting the CB_NOTIFY callback, which will hopefully
be upstream soon (I have patches written for client support, but I need
to find time to clean them up a bit more before posting them).

I hope this helps!
Anna

>
> -- 
> Regards,
> Shyam


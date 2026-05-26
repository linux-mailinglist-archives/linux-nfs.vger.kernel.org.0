Return-Path: <linux-nfs+bounces-21978-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK5IG7DBFWqkaQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21978-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:52:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A045D9154
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB00530F0A66
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585953783A0;
	Tue, 26 May 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDG43kSr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41420378D87
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809855; cv=none; b=grSpjVrtktI+XeGn3hqRTwjgFifueAuswSlsGVlrw8J/T0/YC2QcXM/J1drXBaVwGsDB4unzj1vcVBpxDkoX+jbhu+SDinPHAPQEYsGud/Sd6dW4X34S5ruM7Yc8jewJDDNzSxWZO8cU50cZtQnT6ks0QbANva5CRx2TcXj2s3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809855; c=relaxed/simple;
	bh=e7Y7Pws88LWRCcsnVfoXZwfswVKY+7q4jhYMDNmA4hI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XTEuUeInD4Jm8gpcuYpO2ZnzVTGTvLUP9+FXD/cPtSBDKYfPKFBlD10d2xP8kbwSlguXmLKnyroDGeHGB5BUhu53/DrtR5InS/jV7tXPqNFQ30FzTVZGhsI/I6cu29sNrCJ83ryZ4ZMZW0zH2NLTXSSukMwhDbsO6iZ7XgUzFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDG43kSr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9251F00A3C
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809853;
	bh=L6tUc5KJw3xwaUHGg1rST6S7WKugcmkmvd4bfLMmdgM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=VDG43kSrwBnEYohIjpoD9IjMHDJVSSFQkRpLr14v62Sx9BN6bZyl0PB5cN6a80rw7
	 AU+jURIjRiE8fSez2l91aZv4iMPfLynugObDYKu0GzjgEUHIpdGCvcNhTtU1vQ+J08
	 SCQCBRoE6dK+7yOICeo0KAxI47YKq1mxQkTLH54I3PNvUcYuAOS33MDIZqPZW8F6jv
	 zpMQqAkIuMfH/GYpiTXaHq8z8bFGMTd50MZninDRdw1vZGucMJ7DPmCNk+Aq6unCqI
	 DigZA7Ribgpj0VfXKwZM5gdXVsNtM8GyJUWA9MBwCtVzyVVkESnwIF7c41UQxChUea
	 h9/M/dtH2ksZQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 14D0CF40068;
	Tue, 26 May 2026 11:37:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 26 May 2026 11:37:33 -0400
X-ME-Sender: <xms:Pb4VarmZXyE7THEgQftm3sIRJWaeEoHE9ClkFep6VCXICoRJeAxJLw>
    <xme:Pb4Vapp96xm2go6EhZAIeSbefAo53PyXlssi0fh7Bno8uhehLWQR624r9DSNLPK6a
    mOG3JEExHwAOzVQo01cFuEKfIFxYFKkP5jQEaqQsFsWtBFCYRemlw>
X-ME-Proxy-Cause: dmFkZTGB8vCFbqclNcyUn2DoezFWoTW+PUFs82WDCpJaVtlEguAL1sOnPZ0hbCHv61Qpgs
    y7bldPbW/yeVPPkIyQdonz8rge9y/grsbskzPgI1vuWFf5tu57+lbcGam4wJCrxQzlbHNH
    F7Lc4/gdi9TyJMrOXH1i1b+9dxdGO9cUr/43C2G8INkxepA8F3JNVLJ3CWl1RZ1OKp4ujF
    5SctnT0Xqhu27y18KlLLPDz8jrdXeBAoNV3LCrLRRkUBT421sHka72zODCqGH08leC8n/s
    KqLM68rwcmGxvR5FDiyRhEu8qlIJgXp85LCgN3f9vU15WjGrTGm4PrtvCM6IctDDkcAEj9
    A6SykL7gKp/Sw91kvacKQhDwcO8V+oXZVfvcX0XGuzz9o9vzeUAfLXdhkg/PX1pfSiaoSI
    8Mc4yCVRiFC1foVoy9zyFjXYyEJr9pIKsOfY5Vfi4eEwAAT2Qv0OYQBOnFbUB22/kvT9z1
    MqWODtus+dDK8S/be0IIOyFZ4WTixjLtstkC8AYVxVp8wAlcWBAAJnepxMgfuJ80a8zj46
    ff/RZELK2JWRtjgo1gJE+vt90WGUl6yPfcGt1Tzny02/louo1m2bCXzjbujQmyhwAQckHo
    UmgpHuotXqZjSKKwNKVyQj1expeTq8AwCZKd64BcrKKZ2C3N4npcFxnO/3WA
X-ME-Proxy: <xmx:Pb4VarLHcZmxuzLLwBs3vM-Icf79iAb8qZnFA5lM1ILAtu_dez2ylw>
    <xmx:Pb4VagodlYgJ4D9_EYLqlB5-4j6a0076l9BmDkxbmWdxOlENC2X-rQ>
    <xmx:Pb4VajwW4sVAt_3KewbkVRd_WIrFinTS4ibKxRNomD_bqMFHLAR3Nw>
    <xmx:Pb4VakO5iextErJMbPchkq0-zl89QWAipB8-DLyHUe33zuAhJ9Ontw>
    <xmx:Pb4Vao5bE60eiZ9B0I5couyF6yZWp8R5xvXVfipaCmfIg6zCBL9eITtY>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E76CA780078; Tue, 26 May 2026 11:37:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWi-yW1dnEww
Date: Tue, 26 May 2026 11:37:12 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Steve Dickson" <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>
Message-Id: <19045a48-ac02-4c05-be05-a88e7a129b6d@app.fastmail.com>
In-Reply-To: <cover.1779805943.git.bcodding@hammerspace.com>
References: <cover.1779805943.git.bcodding@hammerspace.com>
Subject: Re: [PATCH 0/1] nfs-utils: nfs-fh-verify signed filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21978-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37A045D9154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, May 26, 2026, at 10:40 AM, Benjamin Coddington wrote:
> We've had a lot of folks configure signed filehandles, and then wonder "Is
> this thing actually working?".

Do you know if wireshark might be able to handle this verification instead?
It might be quite useful to see a "FH Verified" on every RPC in a network
capture.


> Given the various filehandle lengths and
> types, it can be pretty difficult to know if the kernel is actually
> correctly signing its filehandles.  Claude and I wrote this tool that allows
> anyone to verify the correct functioning of filehandle signing given the
> original key and a list of filehandles.


-- 
Chuck Lever


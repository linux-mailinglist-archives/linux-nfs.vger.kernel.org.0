Return-Path: <linux-nfs+bounces-22860-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TiVdJ1Z+PmrvGwkAu9opvQ
	(envelope-from <linux-nfs+bounces-22860-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 15:27:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4196CD6DD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 15:27:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MgGvnqch;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22860-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22860-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7FE03014252
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229863F6C3A;
	Fri, 26 Jun 2026 13:27:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC93F65E6
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2026 13:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782480467; cv=none; b=KiaGh/MZnwykdV0y7rTmDZuEVNw7P7Wn1riBqO9myegKLVcSJKmt7kShgHq9aSftu0ruBD8jNzwM7ruVItYlRklVirSOmwWioHxDI6creBQ4pvKo3TSVvIiK9HBIN2yjVGVTDG0QIQ6RNASr5j1KGvRU/AoKIIyLQ1XY6IUvrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782480467; c=relaxed/simple;
	bh=wXDGLFM9wIRAMcNEkyaMhczR5gHYDeJ3ydTV3VS9A0k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KHvDNe+ZlsCw4FIYVx8P+YNTG1Uc/IEfIVdOk0XtNjI1NykJDwTkpL20AliD3kQGreKaswKz5WfYWkzdSD5h/n3OMSnUs3xJqtBKNnlM7Wiwo3iNb+EuINwCs4K0Dsop77514Gy+XRHXaUUdyfji9lMNu2lnuMTKZDXDtKR1OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgGvnqch; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF881F00A3D;
	Fri, 26 Jun 2026 13:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782480465;
	bh=ppFGNoVuk8pF2AJGfCbGCHJEWKHCLrsp8Mwv7I53U/g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=MgGvnqchUPfYB7X5jtYslVdm2X8JUrgVhtfHbaBdz9i7hpj4MYquwVmFRJPOQgFSC
	 CS83Hj4vovoXnJF77lEAWbcjDhEcg7Qk2zaKaQiRz/8cmeLjgzG3crbzQ7wLY3uX9Q
	 sEaLtiSIhFub9LDkmeZMnyBSIWGb27KpU7r3tznrpleolyW3JOgk8xuPukcAYbTh8c
	 +fxjDHlipk96dgR4VKRKPUSVS8D7bkdE+z7lpqtxzUByDZEcqJgFvab1T1ESVezOKW
	 9324ZMfc1Ja7/0A32kvfGEzxJeymHBAxcrCQsPYKVxeOyVffnO/uiqx2EpleYkNvXI
	 pT4BbQ69A73RA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0372BF4006B;
	Fri, 26 Jun 2026 09:27:44 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 26 Jun 2026 09:27:44 -0400
X-ME-Sender: <xms:T34-aoUejpLlSCLFWxA7ciGr0wDwDmJebBgr3PFxow3bC6QMiRPYZQ>
    <xme:T34-anZQGWrA75JrNJqk4z8sO3Y_EzAmUv6_m9mvtMJffdJoS4HCiFJzs6viq15xs
    92SY5CrSFUAX1R9YseJlzwwAv8-uV9HvHhKIzemddCrmHp86yEY_RQ>
X-ME-Proxy-Cause: dmFkZTEDJUWMtfmPUDWWY4PhR8B3OUr7MecnLJeMGrJkSJu5YLnr85JpeVJP6LPNYPpdA3
    EdqE2B4x0ybK0Za29z/Pp6LKfBjhlNjG4/gMhoL9IrCgH849iyrn3MhOP0N2AF6+ZDWu+v
    wpczUpt1VWzKnV1pmRU6KfMjCs3inB5x3r1aBUJKwdAPObnnO/cmTaRrQiCkiogb/D85HA
    WkIvJyDh7i4kO8LyEIXHXRwoqWJXxKQvgN+xOIJ6PQ5K6OynAc3PUV+fxNHJqMP1ZBQ8w6
    qLgOtT76Xkhn1yDGjlrs1Bo9Y33CCX1taqoRLqxwQQclnsWHpR4TvtGM1f1o2JWuHZnQGK
    P2uGGYbTHsK0GuOIv9/LQg+0EvJard41cx0l4NGV52fFIl4bgf6EcC4Q30P5GkZxy+XG99
    uAEVxzmeGxg/pI0asbwdKZjk/71W519fUGfU8ChT0S/wBBHVqZDXPUq4Or6UqWGZmA/SH5
    KiabKjNbLLVQcnNc1NXRfbV2riPIzEKXdNF6aqzT/2vQIdfH3uEI/AEt4XKptxJEoDVF4v
    oYb5Npba38QGjjuqttEQhf+zITAAlr/9rHLerwQ+XQBY1zSCuRj38IH5x5fvd5uOVtw9nW
    I57VPGImkpDJT5BZ2khIBGGz3mc07PqHAGPfmCNO1zN9ZBQMecUcR9tN6nag
X-ME-Proxy: <xmx:T34-agueGpHrtWWrPJInzJGBLgcSZu1JdxXtMQ14p5X_bVsFKeryiQ>
    <xmx:T34-auKaJn2nkDaxLcZ-yLn5hW9D7GpPRgw7GkZ-5G2mJcmicDSFLA>
    <xmx:T34-ap_SowT8-PxLTqwgBC3loVVwoz2n0H3k7ZLy2RgBtvEli7P8VQ>
    <xmx:T34-anzn3IdY1krTO7-upsYkpQbds0di4pLengzTNS3gdv_5eC2t2w>
    <xmx:T34-am5TMrOo2CzANg6zR1wJChvdIlXOwLIy1RN8IXVSOONl70UiIPBo>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D883F780ABA; Fri, 26 Jun 2026 09:27:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARGfjA5dPyBB
Date: Fri, 26 Jun 2026 09:27:23 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@brown.name,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <f911deb4-6476-4c8d-a22e-c61aedcab772@app.fastmail.com>
In-Reply-To: <20260625211852.31972-1-okorniev@redhat.com>
References: <20260625211852.31972-1-okorniev@redhat.com>
Subject: Re: [PATCH 1/1] lockd: fix GRANTED_MSG handling
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22860-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:okorniev@redhat.com,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:neilb@brown.name,m:Dai.Ngo@oracle.com,m:tom@talpey.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A4196CD6DD



On Thu, Jun 25, 2026, at 5:18 PM, Olga Kornievskaia wrote:
> GRANTED_MSG is a server-to-client callback, so it runs on the client,
> where nfsd never registers nlmsvc_ops. The nlm4svc_lookup_host()/
> nlm3svc_lookup_host() helpers are for the server-side request handlers
> (TEST/LOCK/CANCEL/UNLOCK), which reach nlmsvc_ops->fopen and must
> reject requests when nfsd isn't running. GRANTED_MSG only calls
> nlmclnt_grant(). Instead, of calling nlm4svc_lookup_host()/
> nlm3svc_lookup_host() (which results in a client failing a GRANTED_MSG
> call) call nlmsvc_lookup_host.
>
> Fixes: 62721885e861 ("lockd: Use xdrgen XDR functions for the NLMv4 
> GRANTED_MSG procedure")
> Fixes: 6c534ad999b6 ("lockd: Use xdrgen XDR functions for the NLMv3 
> GRANTED_MSG procedure")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>

The fix LGTM.

Looking at this now, I see the patch targets two distinct
stable kernels. Therefore IMO this does actually need to be
two separate patches. I will split the patch when I apply
it to nfsd-testing.


-- 
Chuck Lever


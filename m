Return-Path: <linux-nfs+bounces-21373-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ0LG0lA+Gm7rwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21373-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 08:44:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D54B8FAA
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 08:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DCA73004C6D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 06:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F994299929;
	Mon,  4 May 2026 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZU8Vy3S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A127380A
	for <linux-nfs@vger.kernel.org>; Mon,  4 May 2026 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877063; cv=none; b=bqsdF9vGtV3wFiSzErMZ3BAJ/UZrO9bmWN1wrN94w0S2CkVabb4Y1ECjgavv5XEZUETlTz0xv6pABhKQJXpu9G0/j5XMY8hhFoOCLShGR3i5fO3ulyHI0F93TWEE2y7xZdz7IE1huDvD70aOE5rJ+l2pG4ls3NqLKuT1w4uUHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877063; c=relaxed/simple;
	bh=iyQM35uKFrYPapU8XemEhAdRK6pQ3eo63yVB3VnVlC8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sFPgcmLbQJ0ordYKAIpGC4y2Mew4XRw4Pt+DK4dmdYjkCRgRrSX2F+tjYSK3i20FNY+KDaj6DWkX129gRt5bPtXbbIDWZQcWcGk5F6vZxyjGXOTWJyS8W6bHduitmdwM5ZNGygd7xWXkyEiUSa5JYUs8b/aoTUtm0Qo2O4eR0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZU8Vy3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889DBC2BCB8
	for <linux-nfs@vger.kernel.org>; Mon,  4 May 2026 06:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777877062;
	bh=iyQM35uKFrYPapU8XemEhAdRK6pQ3eo63yVB3VnVlC8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XZU8Vy3SAu+WaeHLwdUzODpa57VyOmZlCK7OSeOE7cIyx03maTmde1wEttAup/KU6
	 nUmjIk7b4tn/MKJfu4IMFthWJovsC+WhhQPNpepfwc40SkTj4xzwxHXuAXp+DD8dTY
	 Q1kgqizZ0rlqO4kofT81A94r7mlqQqj5dMifXvmG2OYgL3lH7yGce2XuJ4fkbJl7uC
	 /ohV+q1TkPRPmm1S3mnphRWInGY+ZOH4URxNF0PtPR61ay9FAxPY7fFq26EAniTjAw
	 FbN1fC4rZYlGRUNznPwJtS9CP2+1tATnc6rqpHF7Q/DHRQyxY9DPMLFxHO2l8N+jj5
	 KZ7E3s0GiHaEw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 781D9F4007B;
	Mon,  4 May 2026 02:44:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 04 May 2026 02:44:21 -0400
X-ME-Sender: <xms:RUD4aRq73pxse0miJjsJ7Cn9xKjV-CDwdDFB_wn9WM0SsvHkCzXyhA>
    <xme:RUD4aefZdcptsimZM-Hz6QEGzdlBWEb4d75zZFISLap9HK7Gk_lwl5rpeKuXLmOS9
    3UyHEYZz4wwaRiraB0bbDqkuRYcgP_uSW4Gq0XUhbpQhBs8GolxQFxS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehkvghrnhgvlhdqth
    hlshdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsmhgrhi
    hhvgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RUD4aS1ZW89jkXozVdmKjz010OEgJ2dnsKLtFN8VdXHiIW8tok8fDw>
    <xmx:RUD4aeC_e5uTU8GrqloZtUyG4uX_HvQcKKmvkWrjeiaxDc8gOMC0pQ>
    <xmx:RUD4aWc6zdreHjXJpgwTKIykxgTFfYyLEbw0fxDnVzC4EYC4vRRtoQ>
    <xmx:RUD4aT6pP6yekVdrdLf5BLOZDjJJ5Xj_b7-INNn4_LOeAT6UZvVCLA>
    <xmx:RUD4aRUeFJuIuXxR5Em7wS38k8J8lN6OCEyx9YUD3H__v_S7RNcWIo-T>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 58366780070; Mon,  4 May 2026 02:44:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ak5ktnwSWV1c
Date: Mon, 04 May 2026 08:44:01 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Scott Mayhew" <smayhew@redhat.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
Message-Id: <ce60fc54-5082-44a4-99ae-dccbbb25eb88@app.fastmail.com>
In-Reply-To: <2330c9c6-de7e-4cac-b991-3ffcfdc23858@grimberg.me>
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
 <afUKzeUYPhb97DX4@aion>
 <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
 <e55cd958-6d86-4c6b-abc6-5be83fc53b0b@grimberg.me>
 <98a865cb-94e3-4f57-8b9e-0634c43098b9@app.fastmail.com>
 <2330c9c6-de7e-4cac-b991-3ffcfdc23858@grimberg.me>
Subject: Re: Breakage in ktls-utils with nfs keyring?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C54D54B8FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21373-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]



On Sun, May 3, 2026, at 10:37 PM, Sagi Grimberg wrote:
> On 03/05/2026 22:11, Chuck Lever wrote:
>>
>> On Sun, May 3, 2026, at 9:48 AM, Sagi Grimberg wrote:
>>> On 02/05/2026 6:08, Chuck Lever wrote:
>>>> On Fri, May 1, 2026, at 4:19 PM, Scott Mayhew wrote:
>>>>> On Thu, 30 Apr 2026, Chuck Lever wrote:

>>>>>    It seems
>>>>> like a lot more work than just using the config file.
>>> Well in some cases, storing credentials on a persistent file is not a
>>> viable option.
>>> For nvme there is a userspace utility that helps with this to some extent.
>> This is because handling an NVMe PSK in the keyring is a first-class,
>> supported mechanism. Handling the x.509 certificate this way hasn't
>> really been thought through.
>
> What makes NVMe PSK more "supported" than x.509?

Hannes contributed NVMe PSK in the beginning. IIUC PSK was the first
authentication mode available for the NVMe/TCP protocol. I'm not sure
we can say that x.509 is supported for our NVMe/TCP implementation,
though that is something that should be made to work someday.

Likewise for NFS and x.509 -- that was the easier authentication
mode to implement for RPC-with-TLS. Eventually we want to support
both.

It's simply a matter of development resources and priorities, there
is really no spec reason it cannot be done.


> The way I see it, use of a keyring most likely mean users rely on some
> automation software to populate it anyways.

Sure, but that software does not exist right now for NFS.

And with containery deployments, everyone likes to write their own
special scripts. Hard to say what exactly the nfs-utils-provided
pieces will need to implement.


>> You are also building tlshd from scratch rather than using a distro-
>> packaged version of it. That's rare enough, but it also means you can
>> apply the patch that fixes the issue and build it yourself.
>
> This breakage was brought to my attention by a user working on
> Ubuntu24.04 ktls-utils (1.3.0). It'd be better if we'd caught it sooner...

Full CI is something that is still in the works.


>> I'm open to considering a dot-release, but you haven't convinced me yet.
>
> Ultimately it's your call Chuck. But IMO we shouldn't hold out a fix
> for this until we are happy with a nicer mount.nfs interface.

I have to stop you there: That's completely not what I'm saying. No
one is holding back a fix -- it will be merged into the main branch
in a few days.

The question is whether this issue merits fresh upstream releases. As
I said, the capability isn't advertised, so at this time anyone who is
using this capability is doing so at their own risk. Whoever told you
this was a production-ready feature of the NFS client was mistaken. Can
you provide a key serial number on the mount command line? Yes. Is it
something that is tested and is the interface unchanging for all time?
No.

It wasn't clear that 1.3.0 was the problem. 1.4.0 was released just
last week, so that's where my attention was focused.

What you are asking for, then, is a 1.3.0 dot release for this fix. I
still don't feel there is a strong requirement for that, given that
distributions apply fixes to packages all the time. But I haven't made
a final call on that.


> Anyways, would be happy to contribute to this (don't know anything
> about the pq stuff though)...

Patches are absolutely welcome: post to kernel-tls-handshake, or
open PRs on github.


-- 
Chuck Lever


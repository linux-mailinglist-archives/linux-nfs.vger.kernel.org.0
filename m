Return-Path: <linux-nfs+bounces-22665-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +oCYM7PrMmrX7gUAu9opvQ
	(envelope-from <linux-nfs+bounces-22665-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:47:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5010969BFEE
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 20:47:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M6aKhLb5;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22665-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22665-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96142301B31D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 18:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FE3624CC;
	Wed, 17 Jun 2026 18:47:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC053451CF
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2026 18:47:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722031; cv=none; b=jwRW8wUr5KAirkoH8Sq1ojRomcwn0EBGs+5dsj8aSqgj1bo+JMSQIXXlxeAQ6dMBsGWIo1YJ5kPoqCy/7kizlyWGUGtT9WIPHeTb8yTFhjo0crRWYoKHpsdbAUMG/tr0dVINu+oIEJKSrEILRbnwqHwGcIM0yT+1FtzWmcVpOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722031; c=relaxed/simple;
	bh=PP8KoQTpgxmowUBJ+NIkSj49CcDdySKw1lDKHiHOPKM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l9/4tS4RZkKuoxHuvKIDx6tzLNv/yJq9+lBCtMHol4f35iLAZoXVWKbcE8WWYql6Auf+1p8Ce8UQmOO7SfRcF/ZK3c2RvHAektySwzK6kV/UV4g3Ab0d//I6+OI/ahqpQr3TtVIVdntI2ysrjffX89a4UKyp9W8nva202V0m/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6aKhLb5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97161F00A3D;
	Wed, 17 Jun 2026 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781722030;
	bh=XzvctuRShEUD+kG3zmXGxFq6MBiVrnxW+93Ofokwq+I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=M6aKhLb5/KlR8MrCPPxRBzSPn6dFehGzb9PLajdkTTmWv58KZArXK8Wq2tLWRkmP/
	 fqmJYbyxsOO06yaFRfq6pjJVcV/HxR7dirVpIpASxRMVybXb7UzL0HKqBZgozqlFbI
	 R4aGkcdpid0dtKBENxCZN3+qQtHFqQhVv51h57ek3/8l2Bmobi1nnamDg2wKmqoOGV
	 vSWo6HgXJaTrVFmvYblqETzTXagJw5bpMgkiw+kXN9O+CJebppGBlJOsdhCrabTkcN
	 D25WBj5BDAaJ+BlIh6rD/Mf2MP83BHLZfwYJW5muWNI2DtlwQpaqev59DEZ3gdfkSJ
	 6t2XXZHMmujYA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id ECCA0F4006C;
	Wed, 17 Jun 2026 14:47:08 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-10.internal (MEProxy); Wed, 17 Jun 2026 14:47:08 -0400
X-ME-Sender: <xms:rOsyas23aKgrEbbOTIwMqRTWPIV6UzHDXRHy4ErZPHYDczJjnTLqTA>
    <xme:rOsyah5EQ9wIbGIiGYwnP22JHtbZSqGD-IsDWCLuzzOq9CsQMyk1FTUVrpZHCKQWd
    -TnvSdVBzVJUq5ACcUxAz8mqP-EDlkECVKxnrAFxK61-wJRCIE0Dg>
X-ME-Proxy-Cause: dmFkZTEyMvCwJ11JmY6T90rPtH5CjD/X/3KKZo9SNmF5W9eCNYghxSSjVP9N8jdZb3bMfn
    AawG0ME9hXeBGDocbbP7g3givRLpgMZ0U9C6bWqASTYO3sse5QdWU6uMi0CGSfkwLD9fV9
    HV2gM5wMEQb8QvFO3yyeeMwNSOEcXnBpJ7NaSGo4CTG4Wod7zrgSGr9ZiWxWLNEpp7poAi
    7Dix9FEz3m7g4hgCHRCueYnNFx9KqtWWjjX4+0UuSzxtWje30UnqIvt84ixVvj+XiPKk2X
    YbEoTnZvTEKV6cyU3XCbH4iobF9zxYClysT7HNfJ0f4akIxcGboa8zeHie1/7aIu8Lb1Y2
    Ae27xX97SsYVIYXdhfpKVBhhqMgR2yel5RdfOcD044khG+ak5LqTltlFsGrzC9oLeILNhz
    6Rd+Qt7+g1vfnYUTo0FWkpSTV2e3N37d7oLGeUL4BYfl0fUzjLvh6O0lKWoaIzJZ9KBPdD
    t0NyO/rAfPCcQN84KJX5zjKYHNxhwU0OH8QnJKinfqohyWqEjOLI5b+WcXyOjEhrguP63X
    5ThpploHmTYNPOgpYi2a3FdrGjs8qum7IQ8PNV+ymbhSmuApvDvdkFRUdZih9vSRu65BFg
    ZE64bi7mo2gKfHCdeTkIArVsAxxjLZ3Bgvl1DrBQ1sHu9iU2r8lTwb53qTSg
X-ME-Proxy: <xmx:rOsyanA5SKw8XJGdy9UUYMgW-rdt_41H-iDl3-gMMlzUCfLUGQzTPw>
    <xmx:rOsyajiMnSqzQ0gTihkJV-gvV_OiA-vC282n2NgluF5B1Btwl8dcQQ>
    <xmx:rOsyatZsbxh4w4k6O3nyrw5r8JZ9CLMMH5xCIfhXiLWCoP7LsqHRMg>
    <xmx:rOsyasmr8y46skeWndp-c_InNws7z5_piJLIh-WmENdRGOYAfKx-tg>
    <xmx:rOsyarh83R7qU2nR3zCJvWRAGgmggeTygVKwr9lsJdQkJgTGn7EpX2D7>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C917E15C008E; Wed, 17 Jun 2026 14:47:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX6cWk2i3Rrw
Date: Wed, 17 Jun 2026 14:46:48 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <728ef156-fd4c-4046-a4e3-cced09102db7@app.fastmail.com>
In-Reply-To: <9dc8568569c5f169f8cdf5fe379809fd94a154aa.camel@kernel.org>
References: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
 <20260616-exportd-netlink-v4-3-03505aee3883@kernel.org>
 <e55738ec-80a5-4e74-85e3-29c17d4f67c9@app.fastmail.com>
 <657f71a2c6dc1e817be57e40431a6578281ea823.camel@kernel.org>
 <c62cacac-dc7e-4203-b83e-000d04f797fb@app.fastmail.com>
 <ea1230d947d8bcdf5dc25f8f90fb46d4c0b155c5.camel@kernel.org>
 <9dc8568569c5f169f8cdf5fe379809fd94a154aa.camel@kernel.org>
Subject: Re: [PATCH v4 3/4] nfsd: implement server-stats-get netlink handler
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22665-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 5010969BFEE



On Wed, Jun 17, 2026, at 1:52 PM, Jeff Layton wrote:
> On Wed, 2026-06-17 at 11:25 -0400, Jeff Layton wrote:
>> On Wed, 2026-06-17 at 09:18 -0400, Chuck Lever wrote:
>> > 
>> > On Wed, Jun 17, 2026, at 7:07 AM, Jeff Layton wrote:

>> > > Is there something that accesses this today that I'm not aware of? If
>> > > not, is there some future intent to add this to nfsstat?
>> > 
>> > I think nfsstat should display the wdeleg-getattr field. It has simply
>> > been forgotten.
>> > 
>> 
>> Ok. I'll plan to add it to the interface and send it in v5. nfs-utils
>> will need a follow-on patch to display the value. No promises on when
>> I'll do that, but it shouldn't be too hard.
>
> I have a drafted patch, but I'm not thrilled with it. wdeleg_getattr is
> weird in that it's not a statistic about server-side protocol
> operations. So, it ends up sort of sitting off on its own in nfsstat.
>
> What would you (and Dai) think about instead keeping and exposing
> server-side callback call counts? Then we could just add a new section
> to nfsstat server-side output with all of the callback operation counts
> in it. wdeleg_getattr would just be the count for CB_GETATTRs.
>
> Thoughts?

That sounds ideal.


-- 
Chuck Lever


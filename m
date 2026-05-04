Return-Path: <linux-nfs+bounces-21374-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKCSGr9L+GmQsQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21374-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 09:33:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B44884B960D
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 09:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19E9E3034B38
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7292D877D;
	Mon,  4 May 2026 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="XDERyJ/7";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="14BpQ3mW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47D32857EA
	for <linux-nfs@vger.kernel.org>; Mon,  4 May 2026 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879824; cv=none; b=c69DKHhyj/qnz3UMBVQeE40cJciVERHxMmMEArNCjKxjCeDEuHpLaBicBLD/3efsIjQF+nt5j1I0OFWM6WDtHiv+725mE8JejUtCfBhUfCyz04CacizwRwcEVsEBm/BxvhPK0Zl5qU6Qw+Q2papvCBQ9XmxcDFipTcB8StQusYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879824; c=relaxed/simple;
	bh=CIbFx+z8Jo1o+D2N7yBg2gQiPve860VCiq85VhExqWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsJlNNniaXPS92II9zWrmow7v3Ase0jao+vMZ5tlVkPBj7RnNiUYS0hknpNLxusHAmOPGyYySpIz9OLsk4CbwJzFudhkmNoa+EZITqpvvmL9KExqR8sSlrA5s7u1PD4bCtceHHArp9LjctSiyNdmW+qCWMtQvQd9QoYwh9csrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=XDERyJ/7; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=14BpQ3mW; arc=none smtp.client-ip=134.58.240.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 807952006B.A7179
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:132::5e])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 807952006B;
	Mon,  4 May 2026 09:30:11 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1777879811;
	bh=J+qBBlaJdkdnW7fnfDdI/4l61etOkJsR+1wC2HS5kXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XDERyJ/7F5SPGOV7KH4EKKK5JO4oLjD690IjGbJDyhtTX3WHI1/4vU+CNM/vW9y+D
	 6BLG3+EA9Y6ZOTiHhczPSjT/kpiUCcrK58zEX17yOPqYRyNMNPNsPWSNOszt1PRdjW
	 mgxPyv2maUidFkhkMIhO2umsxiW6aUO/mbElBEBigkNsimeOWclPBRVUxN5nTfYIDG
	 J69QwWTqMB5Xh6+f3CLCGBK3G1gOufm/jD3ZIqc+c88do0baL1y1WL9M0kWITcFyPU
	 Zywbv53sQkCcJSmGtRD0DME5/Uxu4qOfLn971feYibbHfCypAPkMVvMgXMwhFN4HxI
	 D2RYjctt3VC6Q==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id 61C62D4C1A2BA;
	Mon, 04 May 2026 09:30:11 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1777879811;
	bh=J+qBBlaJdkdnW7fnfDdI/4l61etOkJsR+1wC2HS5kXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=14BpQ3mWvlpp6a4CIs7hGAr2xtGj1a8PQLn0pHA14YaP0ft2moZxvgw0qs+ptJZ9X
	 0uaqilSC8WSYIXt0CJjyBTmbWjLrCwMlV7C7rRGWgUcY14yLo10ShBqL3kLI9QNK14
	 eFOov6I5EReNJeg6QRN7oA+fVswczPh9N19Ma2E1AJ5Fzfv1Zl6HYQVi7xSGtP7l/Y
	 YXNuDjc0g24x0x/ep2QDpujCGEl7/5YK2Ef2Ht+K6TVH9fCE+fZUd+IbshGTOrz7BD
	 ZsctBlIwrQiKCYhgDDikQTAu7W9jEResRg1TV+2e3J1zT/bp0jLoBm6QU/6tNHn9fc
	 gRSrTo9KnpwPw==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [10.87.19.1] (lucifer.esat.kuleuven.be [10.87.19.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 54FD32000B;
	Mon,  4 May 2026 09:30:11 +0200 (CEST)
Message-ID: <1835f2f9-b21e-413b-acd4-a2b69d96627c@esat.kuleuven.be>
Date: Mon, 4 May 2026 09:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
Content-Language: en-US
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CAN-5tyGhC8q=iB_H6JaFZpwpWAqEz5NObVrzZ8m=3OzgLgJnpw@mail.gmail.com>
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
Organization: KU Leuven - ESAT
In-Reply-To: <CAN-5tyGhC8q=iB_H6JaFZpwpWAqEz5NObVrzZ8m=3OzgLgJnpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B44884B960D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[esat.kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=kuleuven-cav-1,esat.kuleuven.be:s=esat20220324];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-21374-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kuleuven.be:+,esat.kuleuven.be:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Rik.Theys@esat.kuleuven.be,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]

Hi,

On 4/30/26 7:29 PM, Olga Kornievskaia wrote:
> On Thu, Apr 30, 2026 at 2:54 AM Rik Theys <Rik.Theys@esat.kuleuven.be> wrote:
>> Hi,
>>
>> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo)
>> that is an NFS client to a RHEL10 server.
>>
>> Lately we've noticed that NFS performance is very poor for certain
>> workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and
>> now 7.0.2). For example cloning git repositories is extremely slow.
>>
>> Looking at the server side there don't seem to be any saturations of the
>> disk or network subsystems.
>>
>> I've taken a network dump between the client and server. In that dump I
>> see that the server frequently responds to requests from the client with
>> NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these
>> mismatches? Is this always a client issue, or can this be caused by the
>> server?
> This might have been fixed by mentioned patch below. This patch will
> be included in RHEL10.2 release.
>
> If you have the ability to change the kernel on your NFS server I
> would suggest trying some upstream version that has this patch
> included to see if the problem goes away or wait until when RHEL10.2
> comes out and test it.

We're now running 7.0.3 on the server. We will monitor if the 
performance issue returns.

Thanks everybody for your time and effort.

Regards,

Rik


-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>



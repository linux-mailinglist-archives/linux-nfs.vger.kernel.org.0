Return-Path: <linux-nfs+bounces-21303-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D3THDtn82ky2QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21303-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:29:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C84A413C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4CAE307213F
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E915342981A;
	Thu, 30 Apr 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="gkXRbhKd";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="Z45+xGS1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15A176FB1
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559179; cv=none; b=KUiOZPhJ1kVovochq5AhcKpbEf+nQ1Lth68ju4yCsg/czwWeyJV7MSkIaDsR6BCTS9GX7YUxQDbHiLoDAxpZ7hOFcJmQx2dkVy7yh9b0VpiKpq6z2JSocjUSQhStzSl0NNqSnhVWq+PHTvtq4IlgEUP0FzSwVpXh3OrEUnIKnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559179; c=relaxed/simple;
	bh=SsGO8L8p9xhm3DBEHlABAcgA6hVDiai2T+39T5GE/5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0wNhQc2+plQl6d7DDPSAFjORl/4xYhlOXprZ/gpCKPaqWdXQgSNiL4j89dCCb0p5Upra9oxsOS7SQHn8aLglvf09UmT7M6sRkLZBlt5FE3m26waypeXJ9rYZ9YGS9PlYQVWJN9r/EeQ620Sg6uG2XbQNdpcldXAd8SMADeR0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=gkXRbhKd; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=Z45+xGS1; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 69D4955B8
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 16:26:13 +0200 (CEST)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: C672C200DD.A583F
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:132::5e])
	by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id C672C200DD;
	Thu, 30 Apr 2026 16:26:05 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1777559165;
	bh=xQxx8MshufMF8zdXxV5/5urWkPm7Xm6mJeraAokzhlA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gkXRbhKdTxD8ta0aEUilEmAPhDzRbNmf9YpQPxci25KFS/NviOTO9PmZHjAld2e7/
	 UvfWe0o0PDg+XQrxFgNDV5JSY2Jt3J4SkSp3AC3pga8y9ivLS0R/pz85LfQ3v0JAza
	 w/3nc9+KuZ1o6VOoLes7pFY0qRtKuSS2OSDDfM6Q3duD7uglRBpM8aayOYFHE3DiaI
	 145XH0MenFtROnIaSsTexhkv3HZYI1Bnc3+lEu4J1dlmTDnhaYXOIT+eZ9TLuUMCnu
	 LneFRgCPZACMDAysinC9K+D7n9zTJhB/zth1i1Dh6mcq/mjnH/gTkieKUKNEr6M8jh
	 80BcxDncBFwEw==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id A0B39D4CAC8F8;
	Thu, 30 Apr 2026 16:26:05 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1777559165;
	bh=xQxx8MshufMF8zdXxV5/5urWkPm7Xm6mJeraAokzhlA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z45+xGS1A1G++pySIfp8VjnCrNj8EiITkOOKATpoDDif4asBzSWAG5GmG+5HGoRnU
	 4Rjwcjaef6IWaPOoNCm6pberdqRwdz48HIrkhWCMmhPw5A2fNWSFqDD7DdUFmS7Fjo
	 vXSXNlW7XqFaIJuIH64IX7gkPMU7RrZPi2U7+1R+9oLOyH1+QDI3UGcAhNfZpSOBPH
	 DkYqcPky5kBqry8s9HHMHHK2OSGRL1JGPBxnKuDmjBv+Wz29342wdx+af4zt8O9W+A
	 Kb8iU1KyUAQ8HT7hdWFLbwYtT0b0nm80HYHvZo+bqTX12RQ3EPQk9ytTluSKzasILE
	 kb/GzVVwYszWQ==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C377C4.access.telenet.be [84.195.119.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 84F722000B;
	Thu, 30 Apr 2026 16:26:05 +0200 (CEST)
Message-ID: <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
Date: Thu, 30 Apr 2026 16:26:05 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Benjamin Coddington <ben.coddington@hammerspace.com>
Cc: Linux Nfs <linux-nfs@vger.kernel.org>
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com>
Content-Language: en-US
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C39C84A413C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[esat.kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=kuleuven-cav-1,esat.kuleuven.be:s=esat20220324];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21303-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kuleuven.be:+,esat.kuleuven.be:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,esat.kuleuven.be:dkim,esat.kuleuven.be:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Rik.Theys@esat.kuleuven.be,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Benjamin,

On 4/30/26 3:27 PM, Benjamin Coddington wrote:
> On 30 Apr 2026, at 2:53, Rik Theys wrote:
>
>> Hi,
>>
>> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo) that is an NFS client to a RHEL10 server.
>>
>> Lately we've noticed that NFS performance is very poor for certain workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now 7.0.2). For example cloning git repositories is extremely slow.
>>
>> Looking at the server side there don't seem to be any saturations of the disk or network subsystems.
>>
>> I've taken a network dump between the client and server. In that dump I see that the server frequently responds to requests from the client with NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismatches? Is this always a client issue, or can this be caused by the server?
> This is something you shouldn't normally see and probably indicates a bug or
> serious problem.  From the client side you'd only expect this if you're
> doing a lot of task signaling so that the userland processes abandon RPCs.

Would there be any indications in the logs if this is the case?


>
> A packet capture is the best way to determine if the server is mis-reporting
> the sequencing problem, or if the client's sequencing is incorrect.  Given
> your description of the symptoms I'd also check to make sure your underlying
> network isn't doing something totally nuts like duplicating packets.

My previous capture was on the client, which is where I observed the 
NFS4ERR_SEQ_MISORDERED messages. I've now taken a capture on the server 
and there I do see some duplicate packets, but not a large percentage. 
Should the NFS server not notice this is a duplicate packet and ignore it?

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



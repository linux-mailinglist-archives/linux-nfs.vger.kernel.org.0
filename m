Return-Path: <linux-nfs+bounces-21295-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC9xBrH88mmIwQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21295-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 08:54:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748049E46D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09EF13012251
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FB378817;
	Thu, 30 Apr 2026 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="nc9pwu0s";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="dhTM/mSp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6E34750A
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532037; cv=none; b=dHBU3/HdQSPk48QiFdXq5K7omsoB398z8p7oDPOphRDHopWuPhNcN+HPaahGCg4ag2V68vwWKBHbdd2SWuEyt3t7n8xq7lbRf/d29W4gwo1dKSamSrz3ehilhhZTzvf0m9WH8/cuWdSLbaarOpj2zavNx4S4gdnMXS90hN1GFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532037; c=relaxed/simple;
	bh=2wdLqiw70XABHC2H8qCCbZmjzqLndr0ycB3VRsSxFZs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ufgTMQnqw6TcJ2Z7TUb5eGey7XAReqxqBxiLmUWw0cc8Cp57lCr65oLOsD6x6ktNXEeKwfSb/XrqsKRIiDo4UZw4MX+UDG5bLMrdV+BtkGy68BFvszm3r3IxDDzqchSzMGXpLYjW1QhDzqI+iaDyg1yBasjj92qDf/3YFdpcuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=nc9pwu0s; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=dhTM/mSp; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:132])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 435603E6C
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 08:53:45 +0200 (CEST)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: ACEF32012C.A482E
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:132::5e])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id ACEF32012C
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 08:53:36 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1777532016;
	bh=XZhftCCNmPKiDc5dPw2MJeNNv/vpzIao+tLjweqRMpY=;
	h=Date:To:From:Subject;
	b=nc9pwu0sGjsJAna6L6cFHzYZmvWU9GLwkiIjDoNfYHXwDlVvX9twnnRCejZJnTj4l
	 xWomZLpDMPn/KtwMIS2KD49Km6mqb+XCJ/FL3m7cOmVKQmYwCHRpLRa0ye8CM3tUZL
	 IqER/hAPtirpcuudHIeChJVZWmtEafSCY0jnyONJv8n9FzHQIjNbbhHC/r0+3He5IG
	 4aFfQLicGAjdNQNKylQ35LVb7sLzZj3bISw140Watq8zLQ3WbpFZavRZNJAnf+m9ma
	 8ZVw4Unnf7/fBU/Vpuu1839ipxVYLz2nwyTwJNkUrBaO28K93rx3Kc1zXup81JPhxE
	 Sg4nChFAI773A==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id 8A162D4CC97CD
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 08:53:36 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1777532016;
	bh=XZhftCCNmPKiDc5dPw2MJeNNv/vpzIao+tLjweqRMpY=;
	h=Date:To:From:Subject:From;
	b=dhTM/mSpFzQOVaSFeWuVz9gc7KqDqTN+MKPiegeNKX4VVaFu2PaoXxagY5fW80l1a
	 MrNfJTa+8xG5F3FNhTDH1L0wxdMS2+Jz3bKXFWWVYpVYYiN9MdT7zCYVuzBPgPVR55
	 s8IsQeMqSeZrX/0dL+bXxgZmc5B+tozF4tlY38C+ZEh4RTBZqZmErPzl2IYmLi5/R6
	 k1+CMC+N0WfqJR8OHzK+bzLg2rPgXtKlatdwilIRLryEx/fGk+GkejY58d3tytk3Qj
	 fjNEoFipDl0xkCkhLQkqtGo0OJO5TI+o1wojTtC2gIa3Z7X/EBfvyfGc07yB/2XtzS
	 fs4jURrdPMXRg==
Received: from [192.168.1.113] (d54C377C4.access.telenet.be [84.195.119.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 738332000B
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 08:53:36 +0200 (CEST)
Message-ID: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
Date: Thu, 30 Apr 2026 08:53:31 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Nfs <linux-nfs@vger.kernel.org>
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
Subject: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6748049E46D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[esat.kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=kuleuven-cav-1,esat.kuleuven.be:s=esat20220324];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21295-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kuleuven.be:+,esat.kuleuven.be:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kuleuven.be:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Rik.Theys@esat.kuleuven.be,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi,

We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo) 
that is an NFS client to a RHEL10 server.

Lately we've noticed that NFS performance is very poor for certain 
workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and 
now 7.0.2). For example cloning git repositories is extremely slow.

Looking at the server side there don't seem to be any saturations of the 
disk or network subsystems.

I've taken a network dump between the client and server. In that dump I 
see that the server frequently responds to requests from the client with 
NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these 
mismatches? Is this always a client issue, or can this be caused by the 
server?

Should the client not recover?

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



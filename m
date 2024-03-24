Return-Path: <linux-nfs+bounces-2450-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64076887E1D
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Mar 2024 18:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC80280AB1
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Mar 2024 17:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9818EB3;
	Sun, 24 Mar 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="KJ2mJllE";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="Nzst1C06"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38B19474
	for <linux-nfs@vger.kernel.org>; Sun, 24 Mar 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300748; cv=none; b=Ev2UskMg+aFZvAC9yv6yoN/dpXHYaIVieaOm7pLZlUHVHKXMFGOlOmCMgvh5Pps1jPzY+OKGenLbqWZ5LSP5A/Q2ZZ5sIRz45TWwWnWFQZ7/ywo3O4joOtqVb1dWFNLyTKyxyMw7fUO4dxRS3cLNpghbBazL/VCGS3lI6M92N7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300748; c=relaxed/simple;
	bh=sUnrNwau5KblQJOBJepd+oShJF8kI0bd3Cvjp4PERm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky4Ttfu5UDPsPWzAaKk6fvbIb4lXxQLueTq0zHPUIdCG1u6g3bVqL7qbZsntrvjXYiXaOUFOBiMtMVc4BGW27bCY4kXnaUS5sBk6Ji9H+s3ChmUd6YHZppUcYoY4YFdnJGjq/qhrWCBlwsNmlqkZpOwZGd7grBYdNBU0UUCxrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=KJ2mJllE; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=Nzst1C06; arc=none smtp.client-ip=134.58.240.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 42B5C20182.A33CB
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:133:242:ac11:1c])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 42B5C20182;
	Sun, 24 Mar 2024 18:18:51 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1711300731;
	bh=clvFUwHoFbO9i+Kp9lkdGN2d+IwctWtOHaNaAMZeAVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KJ2mJllEMcGA3Z/aeEEmV2fB8230t/fAi5pWg5QEpJDutZb6/R4GR4CZuH8coMXuc
	 Paz3s2ZbZVDK2n8UVQNpMt+BILQCQxowLy37Hn2Lnkt5ZnLb7fMRdttZbpnwIfqrYl
	 muvaesF9ZfXjcSe44cKpzfkLxyVahs7pBSs8KPeuEFF5hELAAmSDvv8gg8ji48HF6Q
	 tZpw+5petYpIPsWhlwd08iaN6jrwg0+FS4kWhSyVo6+Se4jTpOBGoNG2J2ViidkgaT
	 iwAjcw62zvOfGncz1AtIDkf6TlbgASyvzHXZ5uZs5HZm3Fwya8gk1uvvOSgm/E6WCU
	 Gnn5u0povV+lg==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 1FA26D4F4AFF4;
	Sun, 24 Mar 2024 18:18:51 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1711300731;
	bh=clvFUwHoFbO9i+Kp9lkdGN2d+IwctWtOHaNaAMZeAVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nzst1C066ycBhrC0TXEAetngBwbomBiAuLNqbFrJ1eSOtYxkq7vLLyGC9Ya1LBpEP
	 WTOWRBlTvnVPHCzYW73wBeEIqEztRKqVDOi7/uuT9JtQE06d92qoSxx1H8oppIFEA+
	 SRCV0yG+sqtQcoHz3xuJd65MGs3Un5dev6I1aSSC84rFTpPpt88UECZjFnL5K0bITa
	 CrUXRbMkyfEyot70P/YugN/5U9HfRSq7JG1kUcEoNSyKfv07Jhypc/A5uRviUMREvD
	 ZDuUEsnU1rNNZR7Fmxwdyboi7ViR5QistzwTpELju8rzY5Hg8xtMhGjJrlspVITA4V
	 EPzV8/OG6A2VA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.178] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id E80F96000E;
	Sun, 24 Mar 2024 18:18:50 +0100 (CET)
Message-ID: <ac7386ee-cf66-4438-963d-4a0de6c7f9f9@esat.kuleuven.be>
Date: Sun, 24 Mar 2024 18:18:50 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RPCSEC_GSS_KRB5_ENCTYPES backported to some older long-term
 kernels, but not 6.1?
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <ff131330-9f1c-493c-bfe2-8732a2730bf9@esat.kuleuven.be>
 <F2ED9EC7-3A5E-41B2-B225-FBF28C99132A@oracle.com>
 <1be78aa6-f8b6-45c5-a800-7af07ad532ef@esat.kuleuven.be>
 <BFD2D512-3B22-4586-BEB5-FBB7CB47E13C@oracle.com>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <BFD2D512-3B22-4586-BEB5-FBB7CB47E13C@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/22/24 20:06, Chuck Lever III wrote:
>
>> On Mar 22, 2024, at 5:53 AM, Rik Theys <Rik.Theys@esat.kuleuven.be> wrote:
>>
>> Hi,
>>
>> On 3/21/24 14:33, Chuck Lever III wrote:
>>
>>>> Looking at the net/sunrpc/Kconfig file, these entries don't exist yet in the 6.1 series, but according tohttps://www.kernelconfig.io/config_rpcsec_gss_krb5_enctypes_aes_sha2?q=&kernelversion=4.19.310&arch=x86  they do exist in some older long-term kernels?
>>>>
>>>> Looking at CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2, it seems it exists for 4.19.310, 5.4.272, 5.15.152, but not for 5.10.213 or 6.1.82.
>>>>
>>>> I assume it was backported to some older kernels, but not 6.1? Would it be possible to backport these config items to the 6.1 series?
>>> I don't understand why AES_SHA2 would have been backported to
>>> those earlier kernels in the first place. I'll have to look
>>> into it.
>> Thanks.
> I don't see those new enctypes in my copies of 6.1.82, 5.15.152,
> or 5.10.213, nor do I see those commits in the history of 5.4.y.
>
> Can you check again?

I came across this website where it indicated that the Kconfig option 
was available in those kernel versions:

https://www.kernelconfig.io/config_rpcsec_gss_krb5_enctypes_aes_sha2?q=&kernelversion=4.19.310&arch=x86

But I've now checked the actual source and it doesn't seem to be present 
in those versions.

Apologies, I should have checked the actual source first.

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



Return-Path: <linux-nfs+bounces-10972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B70A77AB8
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007613AB29C
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2795720103A;
	Tue,  1 Apr 2025 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="W6cy5Un0";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="oXr7v0ID"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95D202C38
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510024; cv=none; b=P6iuH+ma3iSftUr9kwkqXtSnmtufNizVn/EwppA1aMUzmn+0ULe/XlYUpfY10wmTFSEnX9K1RRrltuWbDdhAhScoQei+DVvMdbLU8ygMNdiZDuvjpJwXvl3RJ6vTwWDxij0YMEjff9mzJ5LOgeIHOoIZVlUfQNyFSzGxPVvQXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510024; c=relaxed/simple;
	bh=IrK5q3Gn+rmxdjmf2Ox6ptwRVpDBjWRkwHcTbG2haHk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ox4bk79CV3fkn4aMM4KBXsqXd+Ou3G+SkbO1wtQHthEz6FYADJYtfldLXhwqhk0LwCIcrIQzSxyR0pAafaVp0etee8rdxB5cyQ75VM9EVduV3s5Am2cwr8YRYglahh2DKEMzlX+XFWlg/MkbPkikGQ2FpRGoaZpGzaW4wN6pJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=W6cy5Un0; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=oXr7v0ID; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 6DC426B49
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 14:20:14 +0200 (CEST)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 47767200D9.A0B6A
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:133:242:ac11:25])
	by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 47767200D9;
	Tue,  1 Apr 2025 14:20:06 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1743510006;
	bh=YrTJZJXG13FMCHQ8HUEEzJkbizH/EhnXvuxa5yJab9s=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=W6cy5Un0IM5Rd2ylXwMasm3cSJrSilcNSyVntk6AkkTK3R8crjmxqqpQmOvZT4IaC
	 BB6GmABP+S2ED5hN1v6GwKlKOBCEUBHLpM86nu4+RmNYnquHvDp4gp+l+XcxU/yPkg
	 /dCymSa7jii6adm3NYRbyskSN9A5hldBB09otjGT36FpJGo/W4qzvQK0CHCbkMWhyN
	 ayoJRCuDD5Qr5woACj5E6Y5+Swc5v5PoflulXR1PC/aHdcrBwoV77tIUl2YgyczBH3
	 jpH3PAywU1fiffG+sUDLSnVM8utW7RqFzarCzrt3995IZd7O5wyJuE4m7FxFjpiB/2
	 9uMwVKW6IB3XA==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 19222D4EB972B;
	Tue,  1 Apr 2025 14:20:06 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1743510006;
	bh=YrTJZJXG13FMCHQ8HUEEzJkbizH/EhnXvuxa5yJab9s=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=oXr7v0ID4pDLQRRAjLB++vKZfbbFB3FrdsG1wsxlp9JhRmkppeaUAKHhELsnw/Ny6
	 Wnk+AfZJbCNhiZJA4DiGeLJ863QF0WtoLdJpUlICEIBtwpaNPe5b/jftmvRZHn6KHE
	 JL3iTyyLzNJQvzrEmY4sfd1a7/kNYKEeyQoP6QlK/aDRnbpXzv9DDvfPJT9vC/eusO
	 KSrT1CUSnY//XHUOYhigKvQKYmBVemJDos26WIBWHJqM7enYrEUNNqlk3E0y9XcJjF
	 JfsnFJk6oTZWEA/BzEFiST29Ms8TCv5HPmTu0TttkuN4Su0YuRleJ1wAcqWLBVk4yV
	 5fwi0M0EK7cXw==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [10.87.19.1] (lucifer.esat.kuleuven.be [10.87.19.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 07CFC6000E;
	Tue,  1 Apr 2025 14:20:06 +0200 (CEST)
Message-ID: <547c0dd0-21dc-4d60-80c6-d02c4ff4a97c@esat.kuleuven.be>
Date: Tue, 1 Apr 2025 14:20:05 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
To: Daniel Kobras <kobras@puzzle-itc.de>,
 Linux Nfs <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
Organization: KU Leuven - ESAT
In-Reply-To: <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/1/25 2:15 PM, Rik Theys wrote:
> Hi Daniel,
>
> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>> Hi Rik!
>>
>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>> Suddenly, a number of clients start to send an abnormal amount of 
>>> NFS traffic to the server that saturates their link and never seems 
>>> to stop. Running iotop on the clients shows 
>>> kworker-{rpciod,nfsiod,xprtiod} processes generating the write 
>>> traffic. On the server side, the system seems to process the traffic 
>>> as the disks are processing the write requests.
>>>
>>> This behavior continues even after stopping all user processes on 
>>> the clients and unmounting the NFS mount on the client. Is this 
>>> normal? I was under the impression that once the NFS mount is 
>>> unmounted no further traffic to the server should be visible?
>>
>> I'm currently looking at an issue that resembles your description 
>> above (excess traffic to the server for data that was already written 
>> and committed), and part of the packet capture also looks roughly 
>> similar to what you've sent in a followup. Before I dig any deeper: 
>> Did you manage to pinpoint or resolve the problem in the meantime?
>
> Our server is currently running the 6.12 LTS kernel and we haven't had 
> this specific issue any more. But we were never able to reproduce it, 
> so unfortunately I can't say for sure if it's fixed, or what fixed it 
> :-/.
>
>
If I remember correctly the issue came back almost immediately if we 
rebooted the server. Also rebooting the clients that seemed to take part 
in the flood was not sufficient. It would almost immediately start again.

In the end, I believe I:

1. stopped NFS on the server,

2. removed the state files from /var/lib/nfs on the server and

3. then rebooted the server. I waited 100s in the GRUB boot loader 
before starting the OS to make sure this was longer than the 90s lease 
delegation timeout.

Afterwards the issue stopped. But I'm not sure removing the state files 
has any impact.

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



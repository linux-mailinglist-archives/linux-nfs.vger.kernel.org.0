Return-Path: <linux-nfs+bounces-8570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D39F2C4D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 09:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15721188335F
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB29200111;
	Mon, 16 Dec 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="AS4PaWOt";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="4p2VOKnf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD220010C
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339000; cv=none; b=Dzx1UpGNdMByrj4dUb7tCSOvFgA/qNm9aBxhTmiG+91tpWSA95U6PF+5jgk/IndjMUjUdnC+c7wCyvUamKjJPN3cspH8PJbmIXYlYd49l3ZOaDO5C47VG/5ZpvCGMsdysfpHZRv/TDQeg9CQKTNpXSJj5Lq7sYJrtkI31Lbe4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339000; c=relaxed/simple;
	bh=8eZlJzTxOmGrtgk9erXcuDNILu12ivWGJaMoryJU77k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=awRUGgBbTGdqdrvOb03nMY9yEJuD31tBgn8S44qooMb6O/NpvYOPWWrbLSdAKOGtPIgCVDsATU+Am9kOljY+sNzS7i0gWMHYetjZjruj0llYEApvI00IkQeJNs8RGx8XyWjkKYMdyBy8rR1mhd3qOnf5uLLrvDjnsWzFd+iLOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=AS4PaWOt; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=4p2VOKnf; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 5A8A379CA
	for <linux-nfs@vger.kernel.org>; Mon, 16 Dec 2024 09:49:52 +0100 (CET)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 321F7106.A384E
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140:242:ac11:65])
	by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 321F7106;
	Mon, 16 Dec 2024 09:49:43 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1734338983;
	bh=a6VzMUT6mNgKmopDJZm7qfnwslPC0p8LaKvbhc4640c=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=AS4PaWOtykYbTqzeBb6gWbohHwZi2TPh1xTQa7otHG6sOGjORJljDP7sKYTM64FaK
	 yxTznvkG6WjCORZpJ38g0/swXiKIEPFTBYKyPAblwuHi0+D7YMosXqJG66jMeLsfvL
	 SSGIU+qKwVReYyemR0CZZErsFL3NN1FZ3pe7xSVQxlMfuXy1zzhyVscqz/wlla83E/
	 IaNOX9s4goVjGxwz08Xs1L8YHm4ILRM1G/268apSELSyGPuKknV2SU5hwqKbfqv5zg
	 2yJwG4Qzk0GT/BKp0VOH2wMpRilmOnySRxXb5oh/rUmMkR3Iw81A5mja1Mkca3sydA
	 y4yyLUyGBC5MQ==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id 09A15D4E88D2E;
	Mon, 16 Dec 2024 09:49:43 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1734338983;
	bh=a6VzMUT6mNgKmopDJZm7qfnwslPC0p8LaKvbhc4640c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=4p2VOKnfkWOTqGLPiX1F9U9bkCe76TXbJ9fpdWyLuotcnOnbfmV41v0+owwy9kJ6L
	 1OIgf/tV0HbwsZ0i3buoxPfkxmUwHKbwvEBxgH4k85VlkP1g07xtuLWEM5lPHsZA4q
	 1MEup9iz1OuemfMWCzput/a1ev4T05N5ICSPcq7cRWg0Ek55cgsbcfqTJuvgkve/B7
	 CH4kSuBzI0nXcKTy8jQjD2bDCPkeCmYNn+RDv6qsq+giStfFEnW/B2lb8/umvyytnI
	 EGIvtzH33/k1rPjjX6yLeBtIYiLlPSgmr7vhRWGvV89uQLICBuL50oZ3VdUCpnCHaz
	 snA0Kr/FNbu+Q==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [10.45.167.252] (unknown [10.45.167.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id EFC4D6000E;
	Mon, 16 Dec 2024 09:49:42 +0100 (CET)
Message-ID: <f2af89c1-e80c-44f3-8277-53ed6e6bf874@esat.kuleuven.be>
Date: Mon, 16 Dec 2024 09:49:42 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <87314e6d09a96a5cffc13dd1b9cb94da7d94e376.camel@hammerspace.com>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <87314e6d09a96a5cffc13dd1b9cb94da7d94e376.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/16/24 1:34 AM, Trond Myklebust wrote:
> On Sun, 2024-12-15 at 13:38 +0100, Rik Theys wrote:
>> Hi,
>>
>> We are experiencing an issue on our Rocky 9 NFS server and Rocky 8,
>> Rocky 9 and Fedora 41 clients.
>>
>> The server is (now) running upstream Linux 6.11.11 and the Fedora 41
>> clients are running the Fedora 6.11.11 kernel. The Rocky 8 and 9
>> machines are running the latest Rocky 8/9 kernels.
>>
>> Suddenly, a number of clients start to send an abnormal amount of NFS
>> traffic to the server that saturates their link and never seems to
>> stop.
>> Running iotop on the clients shows kworker-{rpciod,nfsiod,xprtiod}
>> processes generating the write traffic. On the server side, the
>> system
>> seems to process the traffic as the disks are processing the write
>> requests.
>>
>> This behavior continues even after stopping all user processes on the
>> clients and unmounting the NFS mount on the client. Is this normal? I
>> was under the impression that once the NFS mount is unmounted no
>> further
>> traffic to the server should be visible?
>>
>> Not all clients seem to trigger this issue. On a Fedora 41 client
>> that
>> (auto)mounts home directories from the NFS server the behavior seems
>> to
>> be triggered when I start Thunderbird and let it process a lot of new
>> mail (mail from the IMAP server is stored in the thunderbird cache
>> that's stored in the nfs-mounted home directory). This triggers the
>> high
>> write traffic of the kworker threads. At first, thunderbird behaves
>> normally but gets really slow over time. Stopping thunderbird does
>> not
>> stop the kworker threads and they keep sending a lot of traffic to
>> the
>> server.
>>
>> Can you point me to some steps to further diagnose this? Where can I
>> find what triggers the creation of these kworker threads? Why does
>> iotop
>> show the write traffic with these threads, and not the thunderbird
>> threads?
>>
>> There haven't been many changes to our kernels on the Rocky side
>> recently. Is it possible a Fedora 41 client running a more recent
>> kernel
>> somehow triggers a behavior on the server that results in Rocky
>> clients
>> to start to misbehave?
>>
> Which operations are the clients sending to the server? Ideally you'll
> want to look at a wireshark trace to see what is being send on the
> wire, but it might be sufficient to watch the 'nfsstat' output on both
> the clients and server to see what is anomalous or different about the
> traffic when the issue is occurring.

Looking at our collectd statistics from the time the issue happened, the 
operations where sequence, putfh and getattr. Not all clients have this 
behavior but the number of sequence and putfh requests the server 
receives is 3x higher than the typical average and the number of getattr 
requests is 6x.

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



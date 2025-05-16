Return-Path: <linux-nfs+bounces-11763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77170AB95BC
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 08:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DC5189F891
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 06:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27BF1D88AC;
	Fri, 16 May 2025 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="UJnPRMyq";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="GK3/qDiS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F9145323
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375322; cv=none; b=VacUyOhafjtKrwwDdogjfe+R23gWHxSbhWjGW9hHihc2LId7f2dIytR4oOufywhYcL3u/WKAZ8eP6Tcs7rOTNQ4LYMos3FH3KB7AUtgplKyx2IjM/oE7YKjijkp8z3dhXkOxM3q+OT5Tr+d5RYr5nAOBhU4rnSbA4uPzfrhrTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375322; c=relaxed/simple;
	bh=h5id8Qt2nXNPbPsOSjwfZjvme/vOm0NWly0KP6jJOJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZEndxazMoklmmXKAlZo38beo7zo7nnEFnA2yaqOL1IkH1OMIVYqLtblqXCQ8Z0iqtmhamHnohArBCntomVH1JnzdnbNm0C2z3772//EcWsyZk/TfRAIy7Tl0ahmScBJ6byp6BbLqVR1OyUR1sqYZFCtBvGPiZ3q01UM7wYniXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=UJnPRMyq; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=GK3/qDiS; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 001A06B28
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 07:51:57 +0200 (CEST)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D2B232005B.A771E
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:130:242:ac11:d])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id D2B232005B;
	Fri, 16 May 2025 07:51:47 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1747374707;
	bh=xPO5KLUlP7o9FSPaqF3Oh69Lr+1dgDfj25sbApEBnao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UJnPRMyqh8qI72alhTm+ighGftADSrvovfiQkG4B4L1Xw7crXjn1t+DibNARfiYNL
	 eSXCadL9Olzz8v1FxDzqJk3P2PXmud0DDa9xccOf6Logt3g10zK3Gk7YAtximnYxYJ
	 lFePj+ZFmhezOTuvGwt3YAlOcEufOwsKD0qt8Dr6X3tmR20Y9a3rUmrmOrbfxH0WES
	 jww9bPREYzOz477Y86hytfrqVEyj5vCgjMRU6O1rmrwHpSnXHnGHT/BplXlxaKiPmR
	 0roCgqboD57XOVAXck0HzV6sZYacCpNFcmFMkSRBcTSYW3isDqcaGaBGzkjH/kCBJl
	 qc+BMq+C0Q+Kg==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id A874AD4EEAA5A;
	Fri, 16 May 2025 07:51:47 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1747374707;
	bh=xPO5KLUlP7o9FSPaqF3Oh69Lr+1dgDfj25sbApEBnao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GK3/qDiS/a2YXD+ahENYMW78ld+gz+/3yq0zK/k9Xy3XeRclJgI8q+di6TODcteSL
	 ZL4di+K3kjcMvOBIBe4WzN/aqglSeHRdVWZonCV0GwLj55Ltz0eTbx9iLPdrjHDRiF
	 qn47ramCUpSgWbeQykYlsDIaIE7mq+idJp1oU6XbGzVSoIs6MBcCrk8lGkcHjHqsdd
	 kSXc3X/utq7CxbX29LWJpjnw57oPn0nWIv0Esu371KBd2cMwnlmNRBQF4zF7NIfaOC
	 iOCD8O+WeX7zmgJep97DuUNR8KWP8fMek8iMO10pusG+Ua38BEb1hOhwBBcQfp1r2v
	 gVOiCt/a9lKyA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 776086000E;
	Fri, 16 May 2025 07:51:47 +0200 (CEST)
Message-ID: <4d4f781a-d668-4f49-9cfd-2e9e94a8cb71@esat.kuleuven.be>
Date: Fri, 16 May 2025 07:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Linux Nfs <linux-nfs@vger.kernel.org>
Cc: Daniel Kobras <kobras@puzzle-itc.de>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
 <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/18/25 3:31 PM, Daniel Kobras wrote:
> Hi Rik!
>
> Am 01.04.25 um 14:15 schrieb Rik Theys:
>> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>>> Suddenly, a number of clients start to send an abnormal amount of 
>>>> NFS traffic to the server that saturates their link and never seems 
>>>> to stop. Running iotop on the clients shows kworker- 
>>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic. On 
>>>> the server side, the system seems to process the traffic as the 
>>>> disks are processing the write requests.
>>>>
>>>> This behavior continues even after stopping all user processes on 
>>>> the clients and unmounting the NFS mount on the client. Is this 
>>>> normal? I was under the impression that once the NFS mount is 
>>>> unmounted no further traffic to the server should be visible?
>>>
>>> I'm currently looking at an issue that resembles your description 
>>> above (excess traffic to the server for data that was already 
>>> written and committed), and part of the packet capture also looks 
>>> roughly similar to what you've sent in a followup. Before I dig any 
>>> deeper: Did you manage to pinpoint or resolve the problem in the 
>>> meantime?
>>
>> Our server is currently running the 6.12 LTS kernel and we haven't 
>> had this specific issue any more. But we were never able to reproduce 
>> it, so unfortunately I can't say for sure if it's fixed, or what 
>> fixed it :-/.
>
> Thanks for the update! Indeed, in the meantime the affected 
> environment here stopped showing the reported behavior as well after a 
> few days, and I don't have a clear indication what might have been the 
> fix, either.
>
> When the issue still occurred, it could (once) be provoked by dd'ing 
> 4GB of /dev/zero to a test file on an NFSv4.2 mount. The network trace 
> shows that the file is completely written at wire speed. But after a 
> five second pause, the client then starts sending the same file again 
> in smaller chunks of a few hundred MB at five second intervals. So it 
> appears that the file's pages are background-flushed to storage again, 
> even though they've already been written out. On the NFS layer, none 
> of the passes look conspicuous to me: WRITE and COMMIT operations all 
> get NFS4_OK'ed by the server.
>
>> Which kernel version(s) are your server and clients running?
>
> The systems in the affected environment run Debian-packaged kernels. 
> The servers are on Debian's 6.1.0-32 which corresponds to upstream's 
> 6.1.129. The issues was seen on clients running the same kernel 
> version, but also on older systems running Debian's 5.10.0-33, 
> corresponding to 5.10.226 upstream. I've skimmed the list of patches 
> that went into either of these kernel versions, but nothing stood out 
> as clearly related.
>
Our server and clients are currently showing the same behavior again: 
clients are sending abnormal amounts of write traffic to the NFS server 
and the server is actually processing it as the writes end up on the 
disk (which fills up our replication journals). iotop shows that the 
kworker-{rpciod,nfsiod,xprtiod} are responsible for this traffic. A 
reboot of the server does not solve the issue. Also rebooting individual 
clients that are participating in this does not help. After a few 
minutes of user traffic they show the same behavior again. We also see 
this on multiple clients at the same time.

The NFS operations that are being sent are mostly putfh, sequence and 
getattr.

The server is running upstream 6.12.25 and the clients are running Rocky 
8 (4.18.0-553.51.1.el8_10) and 9 (5.14.0-503.38.1.el9_5).

What are some of the steps we can take to debug the root cause of this? 
Any idea on how to stop this traffic flood?


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



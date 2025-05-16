Return-Path: <linux-nfs+bounces-11772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBFAB9C49
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 14:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DABA00D29
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C023F291;
	Fri, 16 May 2025 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="HWRBHUZ9";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="Ew4YRj4S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182324166F
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398978; cv=none; b=m8PuKzc2F6OZ1vmZSnLbBdw4O85XmpC5f0ZV/k3QgfT3RvFgBRh7iTKVCAvHc0b4Oa3ufkRa7qOdMjIYnPvnIiQfeZB7oZAAdyt+UqERw1MqH3JECol8AWyYdU00zTQSQ7Vo78iMXUxV6HBJVfOzFaYxebw2IisnJ6Mq3kq/gtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398978; c=relaxed/simple;
	bh=/Gj/m8q7pyKOXy8wG0qLbIFXEGfCIQznQ+6fP8Wa79o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHhmE00J/SMUog7QhoUus5PUOiX9M6OOowqjuDp7YPQfd7cOZ8TOghA/CZr6C0TB4MbCU7NVxstSlvj/6ka9zpmxBkRbG+uL35TGieul4rSDldzMX4LZAxejggxGpg0lXPf+ANx51hehbQOKMJ1Xvg02Ok/fZxWnTvsiKGcwgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=HWRBHUZ9; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=Ew4YRj4S; arc=none smtp.client-ip=134.58.240.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 5C87A200CF.A8A3D
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:130:242:ac11:d])
	by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 5C87A200CF;
	Fri, 16 May 2025 14:36:04 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1747398964;
	bh=yxKV7MppmmD2eW+RjvI7b+EMPlY1kJ4RUTlSjSAOeDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HWRBHUZ9RLjYJX+RCGloMaFy56i6+X489U+TnTb5awZ5bd41wNGZg4Gx78oapobLf
	 N4Wc7FDB3X1v63LYcVufxKiF8ivCs4SEEcYCXjJ7uFvNUq6AaewVlLZfLDnKHgdUad
	 7qGNMkLvl7DcukO3SViqhxqlPKrNdRbL1ZFqOWqGdZSto9t4M9r/zk8V6+zV3jx+ih
	 F4tyE+AFGvFCZ+XQqL+U3EC7oTKQTFsK1arb34qOm0kL2l3DZStHWlQh9t4tfy950U
	 1aY6WYflyfHrDpOPeqw2JXGRm/ISuiaDK3Vc5b0cm+aSBp0mbniWSak+H6Ccedkk0+
	 CvrWimP0BF/tg==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 19984D4EE2F8A;
	Fri, 16 May 2025 14:36:04 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1747398964;
	bh=yxKV7MppmmD2eW+RjvI7b+EMPlY1kJ4RUTlSjSAOeDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ew4YRj4SCl0bvPB8k3JcDFbtNBrXRoyjT8bQPzFWQ7I0p16KzJ7scpy4cAA/x7DXh
	 +Fcn7sSygy+depeoyIZ4wxR4PCSqS71FnRMSla5dGcEhYnfl5enQ0GOiEQrxmVeqn7
	 r7XohX9PF8b9lyzZUYye+7CZEbnzxbAW3l5MKBJn1shvLQLaRPSbC49wYc5HepVuBs
	 WI4VS8mRGEB3ZQvfMdEebgJzgCTRmJVKPq6QNJuOJgaOEIMwQn++qgQxUA2kjcUDAf
	 7NMYL578e8ILSK28HJ+zilS9u/dkhQ4HS4zsHSQEDhZ7xYzoupkI2LBahgNOloKrb4
	 BXQ+s727klCKQ==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id C96576000E;
	Fri, 16 May 2025 14:36:03 +0200 (CEST)
Message-ID: <547993bc-80ed-47ee-b1b7-cbe83da1eae3@esat.kuleuven.be>
Date: Fri, 16 May 2025 14:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Daniel Kobras <kobras@puzzle-itc.de>,
 Linux Nfs <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
 <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
 <4d4f781a-d668-4f49-9cfd-2e9e94a8cb71@esat.kuleuven.be>
 <b8f4f808-48df-4659-9afb-2f9994b22e7b@esat.kuleuven.be>
 <8abc8a16-cbdb-4285-a2da-62f57fbbb165@esat.kuleuven.be>
 <9c446dc2-fe2e-4bd2-9ad5-f4015b0e2ffa@esat.kuleuven.be>
 <3c1acadf-b2ed-42b8-926e-662df5a8aa4c@oracle.com>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <3c1acadf-b2ed-42b8-926e-662df5a8aa4c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/16/25 2:19 PM, Chuck Lever wrote:
> On 5/16/25 7:32 AM, Rik Theys wrote:
>> Hi,
>>
>> On 5/16/25 11:47 AM, Rik Theys wrote:
>>> Hi,
>>>
>>> On 5/16/25 8:17 AM, Rik Theys wrote:
>>>> Hi,
>>>>
>>>> On 5/16/25 7:51 AM, Rik Theys wrote:
>>>>> Hi,
>>>>>
>>>>> On 4/18/25 3:31 PM, Daniel Kobras wrote:
>>>>>> Hi Rik!
>>>>>>
>>>>>> Am 01.04.25 um 14:15 schrieb Rik Theys:
>>>>>>> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>>>>>>>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>>>>>>>> Suddenly, a number of clients start to send an abnormal amount
>>>>>>>>> of NFS traffic to the server that saturates their link and never
>>>>>>>>> seems to stop. Running iotop on the clients shows kworker-
>>>>>>>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic.
>>>>>>>>> On the server side, the system seems to process the traffic as
>>>>>>>>> the disks are processing the write requests.
>>>>>>>>>
>>>>>>>>> This behavior continues even after stopping all user processes
>>>>>>>>> on the clients and unmounting the NFS mount on the client. Is
>>>>>>>>> this normal? I was under the impression that once the NFS mount
>>>>>>>>> is unmounted no further traffic to the server should be visible?
>>>>>>>> I'm currently looking at an issue that resembles your description
>>>>>>>> above (excess traffic to the server for data that was already
>>>>>>>> written and committed), and part of the packet capture also looks
>>>>>>>> roughly similar to what you've sent in a followup. Before I dig
>>>>>>>> any deeper: Did you manage to pinpoint or resolve the problem in
>>>>>>>> the meantime?
>>>>>>> Our server is currently running the 6.12 LTS kernel and we haven't
>>>>>>> had this specific issue any more. But we were never able to
>>>>>>> reproduce it, so unfortunately I can't say for sure if it's fixed,
>>>>>>> or what fixed it :-/.
>>>>>> Thanks for the update! Indeed, in the meantime the affected
>>>>>> environment here stopped showing the reported behavior as well
>>>>>> after a few days, and I don't have a clear indication what might
>>>>>> have been the fix, either.
>>>>>>
>>>>>> When the issue still occurred, it could (once) be provoked by
>>>>>> dd'ing 4GB of /dev/zero to a test file on an NFSv4.2 mount. The
>>>>>> network trace shows that the file is completely written at wire
>>>>>> speed. But after a five second pause, the client then starts
>>>>>> sending the same file again in smaller chunks of a few hundred MB
>>>>>> at five second intervals. So it appears that the file's pages are
>>>>>> background-flushed to storage again, even though they've already
>>>>>> been written out. On the NFS layer, none of the passes look
>>>>>> conspicuous to me: WRITE and COMMIT operations all get NFS4_OK'ed
>>>>>> by the server.
>>>>>>
>>>>>>> Which kernel version(s) are your server and clients running?
>>>>>> The systems in the affected environment run Debian-packaged
>>>>>> kernels. The servers are on Debian's 6.1.0-32 which corresponds to
>>>>>> upstream's 6.1.129. The issues was seen on clients running the same
>>>>>> kernel version, but also on older systems running Debian's
>>>>>> 5.10.0-33, corresponding to 5.10.226 upstream. I've skimmed the
>>>>>> list of patches that went into either of these kernel versions, but
>>>>>> nothing stood out as clearly related.
>>>>>>
>>>>> Our server and clients are currently showing the same behavior
>>>>> again: clients are sending abnormal amounts of write traffic to the
>>>>> NFS server and the server is actually processing it as the writes
>>>>> end up on the disk (which fills up our replication journals). iotop
>>>>> shows that the kworker-{rpciod,nfsiod,xprtiod} are responsible for
>>>>> this traffic. A reboot of the server does not solve the issue. Also
>>>>> rebooting individual clients that are participating in this does not
>>>>> help. After a few minutes of user traffic they show the same
>>>>> behavior again. We also see this on multiple clients at the same time.
>>>>>
>>>>> The NFS operations that are being sent are mostly putfh, sequence
>>>>> and getattr.
>>>>>
>>>>> The server is running upstream 6.12.25 and the clients are running
>>>>> Rocky 8 (4.18.0-553.51.1.el8_10) and 9 (5.14.0-503.38.1.el9_5).
>>>>>
>>>>> What are some of the steps we can take to debug the root cause of
>>>>> this? Any idea on how to stop this traffic flood?
>>>>>
>>>> I took a tcpdump on one of the clients that was doing this. The pcap
>>>> was stored on the local disk of the server. When I tried to copy the
>>>> pcap to our management server over scp it now hangs at 95%. The
>>>> target disk on the management server is also an NFS mount of the
>>>> affected server. The scp had copied 565MB and our management server
>>>> has now also started to flood the server with non-stop traffic
>>>> (basically saturating its link).
>>>>
>>>> The management server is running Debian's 6.1.135 kernel.
>>>>
>>>> It seems that once a client has triggered some bad state in the
>>>> server, other clients that write a large file to the server also
>>>> start to participate in this behavior. Rebooting the server does not
>>>> seem to help as the same state is triggered almost immediately again
>>>> by some client.
>>>>
>>> Now that the server is in this state, I can very easily reproduce this
>>> on a client. I've installed the 6.14.6 kernel on a Rocky 9 client.
>>>
>>> 1. On a different machine, create an empty 3M file using "dd if=/dev/
>>> zero of=3M bs=3M count=1"
>>>
>>> 2. Reboot the Rocky 9 client and log in as root. Verify that there are
>>> no active NFS mounts to the server. Start dstat and watch the output.
>>>
>>> 3. From the machine where you created the 3M file, scp the 3M file to
>>> the Rocky 9 client in a location that is an NFS mount of the server.
>>> In this case it's my home directory which is automounted.
>> I've reproduced the issue with rpcdebug on for rpc and nfs calls (see
>> attachment).
>>> The file copies normally, but when you look at the amount of data
>>> transferred out of the client to the server it seems more than the 3M
>>> file size.
>> The client seems to copy the file twice in the initial copy. The first
>> line on line 13623, which results in a lot of commit mismatch error
>> messages.
>>
>> Then again on line 13842 which results in the same commit mismatch errors.
>>
>> These two attempts happen without any delay. This confirms my previous
>> observation that the outbound traffic to the server is twice the file size.
>>
>> Then there's an NFS release call on the file.
>>
>> 30s later on line 14106, there's another attempt to write the file. This
>> again results in the same commit mismatch errors.
>>
>> This process repeats itself every 30s.
>>
>> So it seems the server always returns a mismatch? Now, how can I solve
>> this situation? I've tried rebooting the server last night, but the
>> situation reappears as soon as clients start to perform writes.
> Usually the write verifier will mismatch only after a server restart.
>
> However, there are some other rare cases where NFSD will bump the
> write verifier. If an error occurs when the server tries to sync
> unstable NFS WRITEs to persistent storage, NFSD will change the
> write verifier to force the client to send the write payloads again.
>
> A writeback error might include a failing disk or a full file system,
> so that's the first place you should look.
>
>
> But why the clients don't switch to FILE_SYNC when retrying the
> writes is still a mystery. When they do that, the disk errors will
> be exposed to the client and application and you can figure out
> immediately what is going wrong.
>
There are no indications of a failing disk on the system (and the disks 
are FC attached SAN disks) and the file systems that have the high write 
I/O have sufficient free space available. Or can a "disk full" message 
also be caused by disk quota being exceeded? As we do use disk quotas.

Based on your last paragraph I conclude this is a client side issue? The 
client should switch to FILE_SYNC instead? We do export the NFS share 
"async". Does that make a difference? So it's a normal operation for the 
server to change the write verifier?

The clients that showed this behavior ran a lot of different kernel 
versions, from the RHEL 8/9 kernels, the Debian 12 (6.1 series), Fedora 
42 kernel and the 6.14.6 kernel on a Rocky 9 userland. So this must be 
an issue that is present in the client code for a very long time now.

Since approx 14:00 the issue has suddenly disappeared as suddenly as it 
started. I can no longer reproduce it now.

What steps can we take in the future if this issue happens again?

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



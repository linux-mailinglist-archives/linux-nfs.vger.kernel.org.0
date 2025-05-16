Return-Path: <linux-nfs+bounces-11774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4BAB9CEF
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 15:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8754A1886E9D
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2E5241667;
	Fri, 16 May 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="TZpPSoT6";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="q8KcEamd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0724166A
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747400957; cv=none; b=W2c6e0mMn9C/wHroOf6Grw/1saaUsGF3+HW0RtwX/ccF6Y1GDdkwm6bxmNin1HtpjuS9srg22Ie6a+oCCn+xj8qHuzF8bPe8bB6jBO8zj7oq6Sta4WQvMrI//YShTX4JP4EXM58qfhmr/6v635Tn/8iZkQqRJE56AZarQWJsUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747400957; c=relaxed/simple;
	bh=ED7pqmiGnz9Y32OcEHUYLY4PPBcIv1/ytnddOAbIWwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo0eQuqVg5YJCIjZnvH5gA7LGOTjSxQ0XrVSD+lH0wL7nFbzLTVmVn+54Te6Jz9y3RlxMYFmiaiWldKqRcPn8W0nI3oejtgOomiEGzPHyDneFJnAFH/5Jv3hm+xelLYsldqcN1/8j+aJ2uLcFKw5RCETl2unR+1CpddHmEaYSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=TZpPSoT6; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=q8KcEamd; arc=none smtp.client-ip=134.58.240.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: EF63820034.A82C6
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:130:242:ac11:d])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id EF63820034;
	Fri, 16 May 2025 15:09:09 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1747400949;
	bh=7MxfCVMycSt5f1eFOOIYPndo/WUSRBY1wajmoOCFsoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TZpPSoT6iM85JyyVfQuts3mRfgTPl62Ju3HBb33cYTXoHfdcJqeEcdqy4h8q0yIJO
	 xKrxvxmuxClxljwsuLWu3QNy2tmTA/y9JxuobfT3g+Gk3+PaZ7/cLvwityXUKCoVtu
	 zpB6u3zxvmEuBgstJU0PTvjVpEJZxyKjL+PK4xUXRa7jYuKOFCe3REYZxktcjQCIo0
	 xcFchKGfplfBC3X/qruWpzWqO9P4cPuN+J6pELKE9D0/lDN25d08su7p08pk9BmBDG
	 2v+ndow7nOqhDNtSzVSXXPNN+QYxXCoHFxA6WqBxYKnmStQtkRpxBGuLLzGzAcXbgM
	 xCyoLJU3xnA6w==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id A8FCDD4EE25B0;
	Fri, 16 May 2025 15:09:09 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1747400949;
	bh=7MxfCVMycSt5f1eFOOIYPndo/WUSRBY1wajmoOCFsoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q8KcEamdpWRkcApb//K04sHy0aan6wiqACmvytzqTvmxCPg5HLFQ+sKqqDsONCvJD
	 tP3cyc6ALX8w4jQwX0lF/CqC4+q+HwipgOpYQsliIzoXPTk8GvXjTGwlIznGAN/qfa
	 NmXw0dgnaDoZRDA2pECAjs354Rgr3IwOpCfd292NTX2r6Oc7ml2e3oUIajZhjRNomS
	 dQBUjhJ8GznY2EkCjLYdSFOR4u5n/5uTqFrjqEyFwDb7xSbdM+Q1jJoRIRNNfLLxzd
	 gSoGJxvY75fN97Bdti6CJkqfxdug3LWUkhXAV7WHcr0UcWZeK4VVNfzAF08vJWMuqJ
	 WOcA0UNIDKgNA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 8CFCC60011;
	Fri, 16 May 2025 15:09:09 +0200 (CEST)
Message-ID: <e37b3b0c-f9d0-40c7-b116-488fa93b68ca@esat.kuleuven.be>
Date: Fri, 16 May 2025 15:09:09 +0200
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
 <547993bc-80ed-47ee-b1b7-cbe83da1eae3@esat.kuleuven.be>
 <c8f5e130-f837-42d4-be8c-1b26eaec587b@oracle.com>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <c8f5e130-f837-42d4-be8c-1b26eaec587b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/16/25 2:59 PM, Chuck Lever wrote:
> On 5/16/25 8:36 AM, Rik Theys wrote:
>> Hi,
>>
>> On 5/16/25 2:19 PM, Chuck Lever wrote:
>>> On 5/16/25 7:32 AM, Rik Theys wrote:
>>>> Hi,
>>>>
>>>> On 5/16/25 11:47 AM, Rik Theys wrote:
>>>>> Hi,
>>>>>
>>>>> On 5/16/25 8:17 AM, Rik Theys wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 5/16/25 7:51 AM, Rik Theys wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 4/18/25 3:31 PM, Daniel Kobras wrote:
>>>>>>>> Hi Rik!
>>>>>>>>
>>>>>>>> Am 01.04.25 um 14:15 schrieb Rik Theys:
>>>>>>>>> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>>>>>>>>>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>>>>>>>>>> Suddenly, a number of clients start to send an abnormal amount
>>>>>>>>>>> of NFS traffic to the server that saturates their link and never
>>>>>>>>>>> seems to stop. Running iotop on the clients shows kworker-
>>>>>>>>>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic.
>>>>>>>>>>> On the server side, the system seems to process the traffic as
>>>>>>>>>>> the disks are processing the write requests.
>>>>>>>>>>>
>>>>>>>>>>> This behavior continues even after stopping all user processes
>>>>>>>>>>> on the clients and unmounting the NFS mount on the client. Is
>>>>>>>>>>> this normal? I was under the impression that once the NFS mount
>>>>>>>>>>> is unmounted no further traffic to the server should be visible?
>>>>>>>>>> I'm currently looking at an issue that resembles your description
>>>>>>>>>> above (excess traffic to the server for data that was already
>>>>>>>>>> written and committed), and part of the packet capture also looks
>>>>>>>>>> roughly similar to what you've sent in a followup. Before I dig
>>>>>>>>>> any deeper: Did you manage to pinpoint or resolve the problem in
>>>>>>>>>> the meantime?
>>>>>>>>> Our server is currently running the 6.12 LTS kernel and we haven't
>>>>>>>>> had this specific issue any more. But we were never able to
>>>>>>>>> reproduce it, so unfortunately I can't say for sure if it's fixed,
>>>>>>>>> or what fixed it :-/.
>>>>>>>> Thanks for the update! Indeed, in the meantime the affected
>>>>>>>> environment here stopped showing the reported behavior as well
>>>>>>>> after a few days, and I don't have a clear indication what might
>>>>>>>> have been the fix, either.
>>>>>>>>
>>>>>>>> When the issue still occurred, it could (once) be provoked by
>>>>>>>> dd'ing 4GB of /dev/zero to a test file on an NFSv4.2 mount. The
>>>>>>>> network trace shows that the file is completely written at wire
>>>>>>>> speed. But after a five second pause, the client then starts
>>>>>>>> sending the same file again in smaller chunks of a few hundred MB
>>>>>>>> at five second intervals. So it appears that the file's pages are
>>>>>>>> background-flushed to storage again, even though they've already
>>>>>>>> been written out. On the NFS layer, none of the passes look
>>>>>>>> conspicuous to me: WRITE and COMMIT operations all get NFS4_OK'ed
>>>>>>>> by the server.
>>>>>>>>
>>>>>>>>> Which kernel version(s) are your server and clients running?
>>>>>>>> The systems in the affected environment run Debian-packaged
>>>>>>>> kernels. The servers are on Debian's 6.1.0-32 which corresponds to
>>>>>>>> upstream's 6.1.129. The issues was seen on clients running the same
>>>>>>>> kernel version, but also on older systems running Debian's
>>>>>>>> 5.10.0-33, corresponding to 5.10.226 upstream. I've skimmed the
>>>>>>>> list of patches that went into either of these kernel versions, but
>>>>>>>> nothing stood out as clearly related.
>>>>>>>>
>>>>>>> Our server and clients are currently showing the same behavior
>>>>>>> again: clients are sending abnormal amounts of write traffic to the
>>>>>>> NFS server and the server is actually processing it as the writes
>>>>>>> end up on the disk (which fills up our replication journals). iotop
>>>>>>> shows that the kworker-{rpciod,nfsiod,xprtiod} are responsible for
>>>>>>> this traffic. A reboot of the server does not solve the issue. Also
>>>>>>> rebooting individual clients that are participating in this does not
>>>>>>> help. After a few minutes of user traffic they show the same
>>>>>>> behavior again. We also see this on multiple clients at the same
>>>>>>> time.
>>>>>>>
>>>>>>> The NFS operations that are being sent are mostly putfh, sequence
>>>>>>> and getattr.
>>>>>>>
>>>>>>> The server is running upstream 6.12.25 and the clients are running
>>>>>>> Rocky 8 (4.18.0-553.51.1.el8_10) and 9 (5.14.0-503.38.1.el9_5).
>>>>>>>
>>>>>>> What are some of the steps we can take to debug the root cause of
>>>>>>> this? Any idea on how to stop this traffic flood?
>>>>>>>
>>>>>> I took a tcpdump on one of the clients that was doing this. The pcap
>>>>>> was stored on the local disk of the server. When I tried to copy the
>>>>>> pcap to our management server over scp it now hangs at 95%. The
>>>>>> target disk on the management server is also an NFS mount of the
>>>>>> affected server. The scp had copied 565MB and our management server
>>>>>> has now also started to flood the server with non-stop traffic
>>>>>> (basically saturating its link).
>>>>>>
>>>>>> The management server is running Debian's 6.1.135 kernel.
>>>>>>
>>>>>> It seems that once a client has triggered some bad state in the
>>>>>> server, other clients that write a large file to the server also
>>>>>> start to participate in this behavior. Rebooting the server does not
>>>>>> seem to help as the same state is triggered almost immediately again
>>>>>> by some client.
>>>>>>
>>>>> Now that the server is in this state, I can very easily reproduce this
>>>>> on a client. I've installed the 6.14.6 kernel on a Rocky 9 client.
>>>>>
>>>>> 1. On a different machine, create an empty 3M file using "dd if=/dev/
>>>>> zero of=3M bs=3M count=1"
>>>>>
>>>>> 2. Reboot the Rocky 9 client and log in as root. Verify that there are
>>>>> no active NFS mounts to the server. Start dstat and watch the output.
>>>>>
>>>>> 3. From the machine where you created the 3M file, scp the 3M file to
>>>>> the Rocky 9 client in a location that is an NFS mount of the server.
>>>>> In this case it's my home directory which is automounted.
>>>> I've reproduced the issue with rpcdebug on for rpc and nfs calls (see
>>>> attachment).
>>>>> The file copies normally, but when you look at the amount of data
>>>>> transferred out of the client to the server it seems more than the 3M
>>>>> file size.
>>>> The client seems to copy the file twice in the initial copy. The first
>>>> line on line 13623, which results in a lot of commit mismatch error
>>>> messages.
>>>>
>>>> Then again on line 13842 which results in the same commit mismatch
>>>> errors.
>>>>
>>>> These two attempts happen without any delay. This confirms my previous
>>>> observation that the outbound traffic to the server is twice the file
>>>> size.
>>>>
>>>> Then there's an NFS release call on the file.
>>>>
>>>> 30s later on line 14106, there's another attempt to write the file. This
>>>> again results in the same commit mismatch errors.
>>>>
>>>> This process repeats itself every 30s.
>>>>
>>>> So it seems the server always returns a mismatch? Now, how can I solve
>>>> this situation? I've tried rebooting the server last night, but the
>>>> situation reappears as soon as clients start to perform writes.
>>> Usually the write verifier will mismatch only after a server restart.
>>>
>>> However, there are some other rare cases where NFSD will bump the
>>> write verifier. If an error occurs when the server tries to sync
>>> unstable NFS WRITEs to persistent storage, NFSD will change the
>>> write verifier to force the client to send the write payloads again.
>>>
>>> A writeback error might include a failing disk or a full file system,
>>> so that's the first place you should look.
>>>
>>>
>>> But why the clients don't switch to FILE_SYNC when retrying the
>>> writes is still a mystery. When they do that, the disk errors will
>>> be exposed to the client and application and you can figure out
>>> immediately what is going wrong.
>>>
>> There are no indications of a failing disk on the system (and the disks
>> are FC attached SAN disks) and the file systems that have the high write
>> I/O have sufficient free space available. Or can a "disk full" message
>> also be caused by disk quota being exceeded? As we do use disk quotas.
> That seems like something to explore.

It's also strange that this would affect clients that are writing to the 
same NFS filesystem but as a user that doesn't have any quota limits 
exceeded, no? Or does the server interpret the "quota exceeded" for one 
user on that filesystem as a global error for that filesystem?


>
> The problem is that the NFS protocol does not have a mechanism to expose
> write errors that occur on the server after it responds to an NFS
> UNSTABLE WRITE: NFS_OK, we received your data, but before the COMMIT
> occurs.
>
> When a COMMIT fails in this way, clients are supposed to change to
> FILE_SYNC and try the writes again. A FILE_SYNC WRITE flushes all the
> way to disk so any recurring error appears as part of the NFS
> operation's status code. The client is supposed to treat this as a
> permanent error and stop the loop.
>
Then there's probably a bug in the client code somewhere as the 
client(s) did not do that...
>> Based on your last paragraph I conclude this is a client side issue? The
>> client should switch to FILE_SYNC instead? We do export the NFS share
>> "async". Does that make a difference?
> I don't know, because anyone who uses async is asking for trouble
> so we don't test it as an option that should be deployed in a
> production environment. All I can say is "don't do that."
>
>
>> So it's a normal operation for the server to change the write verifier?
> It's not a protocol compliance issue, if that's what you mean. Clients
> are supposed to be prepared for a write verifier change on COMMIT, full
> stop. That's why the verifier is there in the protocol.
>
>
>> The clients that showed this behavior ran a lot of different kernel
>> versions, from the RHEL 8/9 kernels, the Debian 12 (6.1 series), Fedora
>> 42 kernel and the 6.14.6 kernel on a Rocky 9 userland. So this must be
>> an issue that is present in the client code for a very long time now.
>>
>> Since approx 14:00 the issue has suddenly disappeared as suddenly as it
>> started. I can no longer reproduce it now.
> Then hitting a capacity or metadata quota might be the proximate cause.
>
> If this is an NFSv4.2 mount, is it possible that the clients are
> trying to do a large COPY operation but falling back to read/write?
>
All mounts are indeed 4.2 mounts. It's possible that some clients were 
doing COPY operations, but when I reproduced the issue on my test client 
it did not perform a COPY operation (as far as I understand the 
pcap/rpcdebug output).

Are there any debugging steps we can take when this issue happens again?

Regards,

-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>



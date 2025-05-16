Return-Path: <linux-nfs+bounces-11764-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3EBAB95E1
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 08:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71FE3B9688
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 06:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139A220F43;
	Fri, 16 May 2025 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="jzf8Amz2";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="oxvtqcgM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE6149DF0
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747376247; cv=none; b=q4HaZWQSCZbbOAFQex6Jd2rvDvaJfgCstOoXSosyk2KIvh65keuO7n2m/emXjWW7WBrIkHg3/3oDNv4m0I3TJhuV0pKIOc3UtRGSwohCbeeXSZxBM/Lm21lmbBdxfKpBJXg+791KwURxGk7cqqifdmUA2l4da/My7RV9TQoMR4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747376247; c=relaxed/simple;
	bh=ovZghoFHIJcI1g807Z2UBjlS2n+4RSGvUPu5L8aHZyQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qTWYsqdLiJ950xh/A6eoknzo5ylKHe6JtkDJcW6UAGddu+2W+SpayEiQ+4ImZxrwJDIPLG4B1XlJSzgBVIQEz+qaYrTbJiAWDa90h8nWgSWlLQvheL400zthZsmyeqtZ1AWO0P+kpZgg6Cnk25o7wYFVuppjtW/tKvcYYVXJ5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=jzf8Amz2; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=oxvtqcgM; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 6734070D1
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 08:17:19 +0200 (CEST)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 4B45C200D1.A3985
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:208:242:ac11:c])
	by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 4B45C200D1;
	Fri, 16 May 2025 08:17:11 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1747376231;
	bh=zgN8qmP29UolzFe77BAp9iiccwtsJIOmQD/m0kUi+Ck=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=jzf8Amz2ddi0b/9BRY8YMXDDxwBHSLdTsD1JYYbxSfjjRGykp0W5DQZlPdOjL0eHk
	 KF74AeUSUtTJeSrMI2+XpacIJyf6zyQ/WY8n7erxwsMdFm2tpxvoFlRt5Tk4Xmuhnv
	 CznpALKpGxXnQ7bIlDqcyBFm0tQm3kw+9FYlwWGqLNSZMgh7jXrlub12g5UX2w3kJg
	 nGB+/9GLKI2tbvMRYgcyZFYYKxWN8HthVUq6O9j06Cq/BjObgrkzHHsQBaQNKfjm/U
	 /fMCJ+2SVuEMLp7go+7I8iA59+i/Baycqvy5PZqnWepWq9ynV7AXQ+JLTQe1r8kv+B
	 3cJjPuQ7NoIoA==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id 1DEC0D4F74F40;
	Fri, 16 May 2025 08:17:11 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1747376231;
	bh=zgN8qmP29UolzFe77BAp9iiccwtsJIOmQD/m0kUi+Ck=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oxvtqcgMHLNhIcYtWO5PeMcjYD6gxVoVRDtWVtzVJCAjy0c9QT6TUqHksu/9Dipvu
	 zAtA+mg4SK9gvDBfi5skPOV0Dc8etk23RgrWzwPOEXe75Eh11PSOnkT+4YiB2yPfC/
	 55ttOgobsvSTOBu/PB5XPXNWh0Vg54juk2jSt7N06YVo0Cm2+R0SwESJdK80yVzTGE
	 1vldPVVwpXK1Ssirc/MjCMAjbnho+YCHn8qmGlEPZzQkHndO6mMumhmke9HY247Q1o
	 Pa2wuXhoFOmBBN/fqGajAV65dBtFdC3QsDS8IOf5D0VKd59ONR6ts/Y79pBbM/evOa
	 OefBGMvwyIkIw==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id F33576000E;
	Fri, 16 May 2025 08:17:10 +0200 (CEST)
Message-ID: <b8f4f808-48df-4659-9afb-2f9994b22e7b@esat.kuleuven.be>
Date: Fri, 16 May 2025 08:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
To: Linux Nfs <linux-nfs@vger.kernel.org>
Cc: Daniel Kobras <kobras@puzzle-itc.de>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
 <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
 <62cb66ff-b718-4369-a7f1-fd3bb01a7b16@puzzle-itc.de>
 <4d4f781a-d668-4f49-9cfd-2e9e94a8cb71@esat.kuleuven.be>
Content-Language: en-US
In-Reply-To: <4d4f781a-d668-4f49-9cfd-2e9e94a8cb71@esat.kuleuven.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/16/25 7:51 AM, Rik Theys wrote:
> Hi,
>
> On 4/18/25 3:31 PM, Daniel Kobras wrote:
>> Hi Rik!
>>
>> Am 01.04.25 um 14:15 schrieb Rik Theys:
>>> On 4/1/25 2:05 PM, Daniel Kobras wrote:
>>>> Am 15.12.24 um 13:38 schrieb Rik Theys:
>>>>> Suddenly, a number of clients start to send an abnormal amount of 
>>>>> NFS traffic to the server that saturates their link and never 
>>>>> seems to stop. Running iotop on the clients shows kworker- 
>>>>> {rpciod,nfsiod,xprtiod} processes generating the write traffic. On 
>>>>> the server side, the system seems to process the traffic as the 
>>>>> disks are processing the write requests.
>>>>>
>>>>> This behavior continues even after stopping all user processes on 
>>>>> the clients and unmounting the NFS mount on the client. Is this 
>>>>> normal? I was under the impression that once the NFS mount is 
>>>>> unmounted no further traffic to the server should be visible?
>>>>
>>>> I'm currently looking at an issue that resembles your description 
>>>> above (excess traffic to the server for data that was already 
>>>> written and committed), and part of the packet capture also looks 
>>>> roughly similar to what you've sent in a followup. Before I dig any 
>>>> deeper: Did you manage to pinpoint or resolve the problem in the 
>>>> meantime?
>>>
>>> Our server is currently running the 6.12 LTS kernel and we haven't 
>>> had this specific issue any more. But we were never able to 
>>> reproduce it, so unfortunately I can't say for sure if it's fixed, 
>>> or what fixed it :-/.
>>
>> Thanks for the update! Indeed, in the meantime the affected 
>> environment here stopped showing the reported behavior as well after 
>> a few days, and I don't have a clear indication what might have been 
>> the fix, either.
>>
>> When the issue still occurred, it could (once) be provoked by dd'ing 
>> 4GB of /dev/zero to a test file on an NFSv4.2 mount. The network 
>> trace shows that the file is completely written at wire speed. But 
>> after a five second pause, the client then starts sending the same 
>> file again in smaller chunks of a few hundred MB at five second 
>> intervals. So it appears that the file's pages are background-flushed 
>> to storage again, even though they've already been written out. On 
>> the NFS layer, none of the passes look conspicuous to me: WRITE and 
>> COMMIT operations all get NFS4_OK'ed by the server.
>>
>>> Which kernel version(s) are your server and clients running?
>>
>> The systems in the affected environment run Debian-packaged kernels. 
>> The servers are on Debian's 6.1.0-32 which corresponds to upstream's 
>> 6.1.129. The issues was seen on clients running the same kernel 
>> version, but also on older systems running Debian's 5.10.0-33, 
>> corresponding to 5.10.226 upstream. I've skimmed the list of patches 
>> that went into either of these kernel versions, but nothing stood out 
>> as clearly related.
>>
> Our server and clients are currently showing the same behavior again: 
> clients are sending abnormal amounts of write traffic to the NFS 
> server and the server is actually processing it as the writes end up 
> on the disk (which fills up our replication journals). iotop shows 
> that the kworker-{rpciod,nfsiod,xprtiod} are responsible for this 
> traffic. A reboot of the server does not solve the issue. Also 
> rebooting individual clients that are participating in this does not 
> help. After a few minutes of user traffic they show the same behavior 
> again. We also see this on multiple clients at the same time.
>
> The NFS operations that are being sent are mostly putfh, sequence and 
> getattr.
>
> The server is running upstream 6.12.25 and the clients are running 
> Rocky 8 (4.18.0-553.51.1.el8_10) and 9 (5.14.0-503.38.1.el9_5).
>
> What are some of the steps we can take to debug the root cause of 
> this? Any idea on how to stop this traffic flood?
>
I took a tcpdump on one of the clients that was doing this. The pcap was 
stored on the local disk of the server. When I tried to copy the pcap to 
our management server over scp it now hangs at 95%. The target disk on 
the management server is also an NFS mount of the affected server. The 
scp had copied 565MB and our management server has now also started to 
flood the server with non-stop traffic (basically saturating its link).

The management server is running Debian's 6.1.135 kernel.

It seems that once a client has triggered some bad state in the server, 
other clients that write a large file to the server also start to 
participate in this behavior. Rebooting the server does not seem to help 
as the same state is triggered almost immediately again by some client.

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



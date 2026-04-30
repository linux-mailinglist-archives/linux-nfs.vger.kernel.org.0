Return-Path: <linux-nfs+bounces-21313-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJyqBKiL82md4wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21313-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 19:04:40 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA04A62B5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 19:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A07C3005EB2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AA30AD1C;
	Thu, 30 Apr 2026 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="RCRFZdv3";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="ju9DxkRa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFE298991
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568675; cv=none; b=BWSfI0byneSoxxhflQu5Uml7TllPBy+NIx9A3fZzYiPefpboA3UkOZ8v7pMhSCktbiLj8PrNn3Ac7lAeIOjC5wOsXcy4ua2iT8yKBH9OH+lSq4+NOAQqgVarmBYrgzsto9h5udrOYi80BHUcA5NcT9uVWc7oUBE9Aoi5+Uu1Zpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568675; c=relaxed/simple;
	bh=ziSV7FDXodfO+KKvQNyD3yleM6i6ZtQTMWsv96jMq0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyyV2Lq7EXpsfaOQ3ZpJz1+3whKA9Fc34PRFUvMw4TJi/vpXTnJOE0xKlkHyCZxB3vmwz90LxkMsOCyObmvo4x3cuwAWrEBKly013QgNOnCieTfX9s7JOb7j0Y7ciYVR68Ibx/jh1VKRO8etBdGaplNjf5ZX2LAGUtFEeeYYEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=RCRFZdv3; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=ju9DxkRa; arc=none smtp.client-ip=134.58.240.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 5A4FD200AB.ACEE4
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140::23])
	by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 5A4FD200AB;
	Thu, 30 Apr 2026 19:04:27 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1777568667;
	bh=ABaUZS2hF2AOjUKIuz4GDpNLPmiVDPpOU7alPZt2blA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RCRFZdv3dzu1GI9glfULQ/F2CEAgAZXcV0XLmkuqS9yVsRZeLhIJhoaFowsYm4vVF
	 f0QntO61b8cYVSK15gKPNWxLPYND/bJyxHVF6LrMPlfxKikv5dhZtjtxZZiS/gt58+
	 13VYAkCt6UpBF9X+rt/FRFOmvGUlMbUTxTurnsmlYBpq8AERVOx6oi+MSN9N65eWpz
	 mJdPUoiaB7Id9PWwtXO5xzTsyMlf1ZwHmTcR5//9Oji14G7S4yzxs2u+a10gIe8Llf
	 lEtTsUB1IT6dcbfAScqqJTiKJo9rTprNgH+72QzGS4TvRCbLonxBcZHr3ti1K0horE
	 7efL+jrwx/cCA==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 14FFDD4CACFEB;
	Thu, 30 Apr 2026 19:04:27 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1777568667;
	bh=ABaUZS2hF2AOjUKIuz4GDpNLPmiVDPpOU7alPZt2blA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ju9DxkRayEtKuWRtEeu2ZM0AymYoNVcV/eZO4+LdmOqqpkmuXg1xMSS3yJ193jHkT
	 NIqwbwYJoctPyH/sMNsPQp8KnZHj3ce5LwbfAyOhAOmftIGOSMrsZGZZIR/cOuuzZR
	 UYWWdegGV8nacuSWRO/f5Lu+xOnpIAK2iq67YINjFaOp6+L3Sy1x/IPl+Aub/wwWQ/
	 4tYV7ymXtmvuhIpW3QNnrual+Skc3IrxkDLGL8NeHOcUzd78uYASEZdd1R607jhJkr
	 EkhonOGgcTiSFmhFjMgwt9SOAis9agMiYYvAiGBPTyzimuDzSpfcNmT0UP9oQQSKMs
	 0sfKTXvpibATA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C377C4.access.telenet.be [84.195.119.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id EB03A2000B;
	Thu, 30 Apr 2026 19:04:26 +0200 (CEST)
Message-ID: <fe5d8251-f92d-4732-a19a-bf92c4ea0cb9@esat.kuleuven.be>
Date: Thu, 30 Apr 2026 19:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS4ERR_SEQ_MISORDERED errors and NFS client very slow
To: Rick Macklem <rick.macklem@gmail.com>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Linux Nfs <linux-nfs@vger.kernel.org>
References: <2cb85a89-f896-4504-b1cf-e4494d344ffe@esat.kuleuven.be>
 <CB5BA5C0-15AA-49D0-96B9-2017F6617903@hammerspace.com>
 <cf6fd710-e11b-425b-949a-d5acb509eec7@esat.kuleuven.be>
 <CAM5tNy6rbQE-QDGD9-YffYn0Z+MsaCNOOpHAetnBKbW7Pn0_dw@mail.gmail.com>
 <3bee225b-3a3f-47a0-a38e-ce08196595ab@esat.kuleuven.be>
 <CAM5tNy63vtAAh1DsBFgPMiXDZReUCimR8nii=WFiAUv8LsJctQ@mail.gmail.com>
Content-Language: en-US
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <CAM5tNy63vtAAh1DsBFgPMiXDZReUCimR8nii=WFiAUv8LsJctQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EEA04A62B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[esat.kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=kuleuven-cav-1,esat.kuleuven.be:s=esat20220324];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21313-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kuleuven.be:+,esat.kuleuven.be:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Rik.Theys@esat.kuleuven.be,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kuleuven.be:dkim,kuleuven.be:email,esat.kuleuven.be:dkim,esat.kuleuven.be:mid]

Hi,

On 4/30/26 5:35 PM, Rick Macklem wrote:
> On Thu, Apr 30, 2026 at 8:27 AM Rik Theys <Rik.Theys@esat.kuleuven.be> wrote:
>> Hi,
>>
>> On 4/30/26 5:02 PM, Rick Macklem wrote:
>>> On Thu, Apr 30, 2026 at 7:26 AM Rik Theys <Rik.Theys@esat.kuleuven.be> wrote:
>>>> Hi Benjamin,
>>>>
>>>> On 4/30/26 3:27 PM, Benjamin Coddington wrote:
>>>>> On 30 Apr 2026, at 2:53, Rik Theys wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo) that is an NFS client to a RHEL10 server.
>>>>>>
>>>>>> Lately we've noticed that NFS performance is very poor for certain workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now 7.0.2). For example cloning git repositories is extremely slow.
>>>>>>
>>>>>> Looking at the server side there don't seem to be any saturations of the disk or network subsystems.
>>>>>>
>>>>>> I've taken a network dump between the client and server. In that dump I see that the server frequently responds to requests from the client with NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismatches? Is this always a client issue, or can this be caused by the server?
>>>>> This is something you shouldn't normally see and probably indicates a bug or
>>>>> serious problem.  From the client side you'd only expect this if you're
>>>>> doing a lot of task signaling so that the userland processes abandon RPCs.
>>>> Would there be any indications in the logs if this is the case?
>>>>
>>>>
>>>>> A packet capture is the best way to determine if the server is mis-reporting
>>>>> the sequencing problem, or if the client's sequencing is incorrect.  Given
>>>>> your description of the symptoms I'd also check to make sure your underlying
>>>>> network isn't doing something totally nuts like duplicating packets.
>>>> My previous capture was on the client, which is where I observed the
>>>> NFS4ERR_SEQ_MISORDERED messages. I've now taken a capture on the server
>>>> and there I do see some duplicate packets, but not a large percentage.
>>>> Should the NFS server not notice this is a duplicate packet and ignore it?
>>> Maybe it would be helpful if I gave you an explanation of when the server
>>> should (probably a MUST in RFC terminology) reply NFS4ERR_SEQ_MISORDERED.
>>>
>>> The first operation in most RPCs (for NFSv4.1/4.2) is SEQUENCE.
>>> If you look in SEQUENCE, when the session and slot# are the same as a
>>> previous RPC, the seq# normally increases by 1.
>>>
>>> If it is exact the same seq#, that should be a duplicate RPC (rest of RPC
>>> should be identical) and it should have been sent on a different TCP connection.
>>> This should not generate a NFS4ERR_SEQ_MISORDERED error.
>>>
>>> If the seq# is any value other than the same as or one greater than
>>> the previous RPC with same session and slot#, the server should
>>> reply NFS4ERR_SEQ_MISORDERED.
>>> --> If this happens, the server is behaving correctly, afaik.
>>>         Then, is this a client bug or a client feature?
>>>         That is more difficult to answer and maybe the Linux client
>>>         specialists can comment?
>>>         (I'd say it's probably a bug if neither "intr" nor "soft" options
>>>           are on the mount.)
>>>
>> Looking at the capture it seems that for the requests that trigger this
>> NFS4ERR_SEQ_MISORDERED, the sessionid is always the same. The slot id
>> varies (maybe these are different mounts all using the same tcp
>> connection, or concurrent I/O?). The seqid always seems to be 1, which
>> seems odd?
> The seq# == 1 is correct if (and only if) that is the first use of that slot#.
>
> The snippet you posted does not help, because it does not go from the
> start of the capture (which probably needs to be when the mount operation
> is done).
>
> You have to wade through it from the beginning looking for any entry
> that has the same session and slot#. (Sorry, I don't know a clever way
> to do this, if the capture is large. And, no, I am not volunteering to do
> that for you;-)

Going from the beginning is not easy as the problem doesn't seem to 
always surface immediately. It can take from a few hours to a few days 
for it to trigger.

I went back to my original capture and applied the following tshark 
filter to show only some fields:

tshark -r kwak.pcap -T fields -E header=y -e ip.src -e ip.dst -e 
nfs.seqid -e nfs.slotid

 From that output I see that the seqid increments nicely with slotid=0 
and the same seqid used in both directions (once):

10.86.18.14     10.87.29.113    0x05b4f549      0
10.87.29.113    10.86.18.14     0x05b4f54a      0
10.86.18.14     10.87.29.113    0x05b4f54a      0
10.87.29.113    10.86.18.14     0x05b4f54b      0
10.86.18.14     10.87.29.113    0x05b4f54b      0
10.87.29.113    10.86.18.14     0x05b4f54c,0x00000000   0
10.86.18.14     10.87.29.113    0x05b4f54c      0
10.87.29.113    10.86.18.14     0x05b4f54d      0
10.86.18.14     10.87.29.113    0x05b4f54d      0
10.87.29.113    10.86.18.14     0x05b4f54e      0
10.86.18.14     10.87.29.113    0x05b4f54e      0
10.87.29.113    10.86.18.14     0x05b4f54f      0
10.86.18.14     10.87.29.113    0x05b4f54f      0
10.87.29.113    10.86.18.14     0x00000001      209
10.87.29.113    10.86.18.14     0x00000001      44
10.87.29.113    10.86.18.14     0x00000001      39
10.87.29.113    10.86.18.14     0x00000001      642
10.87.29.113    10.86.18.14     0x00000001      408
10.87.29.113    10.86.18.14     0x00000001      574
10.87.29.113    10.86.18.14     0x00000001      397
10.87.29.113    10.86.18.14     0x00000001      666
10.87.29.113    10.86.18.14     0x00000001      471
10.87.29.113    10.86.18.14     0x00000001      605
10.87.29.113    10.86.18.14     0x00000001      82
10.86.18.14     10.87.29.113
10.86.18.14     10.87.29.113
10.86.18.14     10.87.29.113
10.86.18.14     10.87.29.113
10.87.29.113    10.86.18.14 
  0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000000,0x00000001 
870,172,685,663,331,512,739,882,417,69,710,376,965,195,809,323,640,359,897,303,662,346,949,871,358,37,948,129,825,227,636,102,539,165,523,998,989,975
10.87.29.113    10.86.18.14 
  0x00000001,0x00000000,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001 
986,286,981,827,220,918,995,188,990,742,406,1009,805,302,706,1001,115,983,723,335,393,426,413,506,58,460
10.87.29.113    10.86.18.14 
  0x00000001,0x00000001,0x00000001,0x00000001,0x00000001 394,326,469,496,112
10.87.29.113    10.86.18.14     0x00000001      498
10.87.29.113    10.86.18.14     0x00000001      118
10.87.29.113    10.86.18.14     0x00000001      392
10.87.29.113    10.86.18.14     0x00000001      328

Then the seqid starts to become 0x00000001 with slotid numbers that are 
not sequential. Maybe that's not required.

I've written a small python script to parse this output to see if the 
src,dst,seqid,slotid is unique during the capture.

All the packets with 0x00000001 seem to exist exactly 3 times in the 
capture with the same slotid!?


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



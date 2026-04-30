Return-Path: <linux-nfs+bounces-21310-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INoACnV282mt4AEAu9opvQ
	(envelope-from <linux-nfs+bounces-21310-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:34:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE554A4D85
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5923A30515E8
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2026 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D972D595B;
	Thu, 30 Apr 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="ceBxzDS2";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="AiUyGuCa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415B2F5A13
	for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562878; cv=none; b=UGhQs4ehF0F9GqCv/Ps1msWFPH1xfuzuAVrqSpkSAVf0QH0rtOKEMTgJC+sF7w/xDiDG37Jb6W3taiRZHEwlh6TcY5WtKe1E5qhlezqXuFP7MIooC8OAqyM4dPW9KincYYDP/asM769pO+SntIG3yk8TEiiRFy3Aq1PHg7Texuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562878; c=relaxed/simple;
	bh=qvR/fCR0t+Hz1F111U5dyfZw7Ya2XCWyfUfO5DiUC0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfLwWNeriS+OUUz/wnZxnF5zLhQa5DFx1k6iAIp2QstEgZNXor4O/cbzgvO2M0+deuhj1Fbbaj/6ejpPR2wmgUbrSy+PgkWoh0QECvxKjJR1KvjgG3vFWmS8Vwk9aN4mQjzXu+Rb4xaR8T54nl87lP7c3z8NU5rwyK0dsRx8rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=ceBxzDS2; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=AiUyGuCa; arc=none smtp.client-ip=134.58.240.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 9C95F200DD.A5394
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:132::5e])
	by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 9C95F200DD;
	Thu, 30 Apr 2026 17:27:51 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1777562871;
	bh=CowwtdSe7t/F+gpWEzVrmNAEpJH6S0UrrP7vbacupF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ceBxzDS2PvpGKJ1zlbyGrvKZNo9n3kT4Y5iGJNiOrCp53Zr3T0exSKD1wlPl4Xl0X
	 jDiTwJrbfnGwlojOaVcEzDzyTTYhRhaWmJJ+LEhzG+fNpyBUcn0l6DkuDax8wBHlGe
	 RuyXP98B19qx6gi18nmgmkX5HGzlU6u9HBmonpC2zb+KX7sAMhJrvVGPq5ZCMZ35KQ
	 7fUb3Nuyehwf16tqC/URRCSp6o6I77KOQZtgHPvkuvARFQCLd1XifXeNiMabXmBZDD
	 6MaY4FY8ljbl0D3tzvS/Ar+iHNLbf+Ud9zyQ+0LcVbQE7KBqphys1WqlY4GC2bptg8
	 yE5XTqBoOiAbQ==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id 77977D4CC9A37;
	Thu, 30 Apr 2026 17:27:51 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1777562871;
	bh=CowwtdSe7t/F+gpWEzVrmNAEpJH6S0UrrP7vbacupF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AiUyGuCaVWyaL6E1Nk2pYsUitZLkUfdJZYFasMYEGrS+7xp4pdYintSsWt+db6+em
	 x8GbHDD4j27bY2AqDvJqy+ZuBqELXjKx4mMWRlb924a9gus12Hlq26kwFCIEGqVfJG
	 /MrCZa1S8mgTD0XWprbWteDXEx9YFiO4PfbPErG97/eoa8kcVNh21gyYx3ZOUtcX5W
	 CieFqkMOkn8Tzu0SSy7DCZwyaMi6o1tGEQpJNJOTSdIiA7Y8dBpVwogajKd50ZQLmq
	 sle19SxlNHfHGXkQ/bj4UrkhPLfnUpNV2CDY5sZbUbMZwu9vc8wbUfC3z68cODqxHl
	 9piZ1s2rrJ2ZQ==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54C377C4.access.telenet.be [84.195.119.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 57C2B2000B;
	Thu, 30 Apr 2026 17:27:51 +0200 (CEST)
Message-ID: <3bee225b-3a3f-47a0-a38e-ce08196595ab@esat.kuleuven.be>
Date: Thu, 30 Apr 2026 17:27:51 +0200
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
Content-Language: en-US
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <CAM5tNy6rbQE-QDGD9-YffYn0Z+MsaCNOOpHAetnBKbW7Pn0_dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AE554A4D85
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21310-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kuleuven.be:dkim,kuleuven.be:email,esat.kuleuven.be:dkim,esat.kuleuven.be:mid]

Hi,

On 4/30/26 5:02 PM, Rick Macklem wrote:
> On Thu, Apr 30, 2026 at 7:26 AM Rik Theys <Rik.Theys@esat.kuleuven.be> wrote:
>> Hi Benjamin,
>>
>> On 4/30/26 3:27 PM, Benjamin Coddington wrote:
>>> On 30 Apr 2026, at 2:53, Rik Theys wrote:
>>>
>>>> Hi,
>>>>
>>>> We have a Rocky 8 client running Linux 7.0.2 (kernel-ml from elrepo) that is an NFS client to a RHEL10 server.
>>>>
>>>> Lately we've noticed that NFS performance is very poor for certain workloads (We saw the same issue on the stock EL8 kernel, 6.18.20 and now 7.0.2). For example cloning git repositories is extremely slow.
>>>>
>>>> Looking at the server side there don't seem to be any saturations of the disk or network subsystems.
>>>>
>>>> I've taken a network dump between the client and server. In that dump I see that the server frequently responds to requests from the client with NFS4ERR_SEQ_MISORDERED (10063). What could be the cause of these mismatches? Is this always a client issue, or can this be caused by the server?
>>> This is something you shouldn't normally see and probably indicates a bug or
>>> serious problem.  From the client side you'd only expect this if you're
>>> doing a lot of task signaling so that the userland processes abandon RPCs.
>> Would there be any indications in the logs if this is the case?
>>
>>
>>> A packet capture is the best way to determine if the server is mis-reporting
>>> the sequencing problem, or if the client's sequencing is incorrect.  Given
>>> your description of the symptoms I'd also check to make sure your underlying
>>> network isn't doing something totally nuts like duplicating packets.
>> My previous capture was on the client, which is where I observed the
>> NFS4ERR_SEQ_MISORDERED messages. I've now taken a capture on the server
>> and there I do see some duplicate packets, but not a large percentage.
>> Should the NFS server not notice this is a duplicate packet and ignore it?
> Maybe it would be helpful if I gave you an explanation of when the server
> should (probably a MUST in RFC terminology) reply NFS4ERR_SEQ_MISORDERED.
>
> The first operation in most RPCs (for NFSv4.1/4.2) is SEQUENCE.
> If you look in SEQUENCE, when the session and slot# are the same as a
> previous RPC, the seq# normally increases by 1.
>
> If it is exact the same seq#, that should be a duplicate RPC (rest of RPC
> should be identical) and it should have been sent on a different TCP connection.
> This should not generate a NFS4ERR_SEQ_MISORDERED error.
>
> If the seq# is any value other than the same as or one greater than
> the previous RPC with same session and slot#, the server should
> reply NFS4ERR_SEQ_MISORDERED.
> --> If this happens, the server is behaving correctly, afaik.
>        Then, is this a client bug or a client feature?
>        That is more difficult to answer and maybe the Linux client
>        specialists can comment?
>        (I'd say it's probably a bug if neither "intr" nor "soft" options
>          are on the mount.)
>
Looking at the capture it seems that for the requests that trigger this 
NFS4ERR_SEQ_MISORDERED, the sessionid is always the same. The slot id 
varies (maybe these are different mounts all using the same tcp 
connection, or concurrent I/O?). The seqid always seems to be 1, which 
seems odd?

I've checked a few of them in the capture and it's always 1 for the seqid.

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



Return-Path: <linux-nfs+bounces-10973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC6A77ABE
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84050188D0E4
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888A202C38;
	Tue,  1 Apr 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="UXu07SL8";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="Eqpv9RwM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4C20103A
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510078; cv=none; b=FSs5wYX4NlkftA9tfZngx/oisulYRZYDfdz2ggLg4+4jlX37JyKiMiwHnnMmgh1bOposn7KwmIVhMzTDZdFJ8xUmtJ/GzN19NVvnn+mh+ODUYTsBKAUuxkb3GmZbEWywfk4CLWj7EdTWJb7GrDGNqGKC/UpRiZGyhO6RibNp/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510078; c=relaxed/simple;
	bh=hdeJtpjTZA4VG842l800rzXUREHRXscFOh7XF0TuiyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EYryRya/NjEXMCFbDqasdveLyLO4BhXbENLgWG+ZjyDs8pp2c8Z7mwiC6wyp7Q5voJAprn0QQV3JBn7zphd6crh/Ia654EFTweYNcWhjeUIU30kiv+jgumG1G3GqGBUJbVszYMmfrrbWgYnw1PHmXz92gI0mACNMdPlGTctf+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=UXu07SL8; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=Eqpv9RwM; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id C3B896A0F
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 14:15:40 +0200 (CEST)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D11903F.A4100
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:141:242:ac11:55])
	by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id D11903F;
	Tue,  1 Apr 2025 14:15:30 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1743509730;
	bh=tPdSxbHJfCSSV/ohDp39TY/EKumfOa4GDtnlq1zAKds=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=UXu07SL8rYEa7X6JU89pk9faRISGxT3DQbpYh/RCi5f2MgKlk0MN0rxoUo/5U1eIP
	 iQSg0wg0EeA7EQaOgNttYe3UNUjoClUBGtnN/MDIF8A85qMsHUjYWGCk67s06uW7VG
	 2uzSV1/L0UoM0Ms0EuJpYMuszN9qH5yF7FkCp9rvwi2E+CGTJUEJ8JvNxjSs6EeoeN
	 tRsckuKPbbs5oCQ35FwqdWkljxXpjZT4Hhze8CaarCJ88lXiQIM5PXBvEB8YggGUk8
	 Mc9MI2s8XtdE5YsLyLhGUIXETeJ4/vHpjTQ9Lag8FqJKWXkuSW4Xt0g1xQnjfe9HZ+
	 kcjjEgGTEU3cg==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id A9920D4ED424D;
	Tue,  1 Apr 2025 14:15:30 +0200 (CEST)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1743509730;
	bh=tPdSxbHJfCSSV/ohDp39TY/EKumfOa4GDtnlq1zAKds=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Eqpv9RwMh9FClBxQbdJAKfTXuEEn9G7/55gI8FpujP3bQ3iLMXvUzsBIYW1D7itEf
	 DptGoZvXy1ejAJoTmSxoDZNwMguN2XODF2id3ZElj5Mi4Mi0VFTEto6Ze/1Hr2xZOa
	 nA0fwyu4BskmDN8W8mxqHPZ1AMkAiX8ZbfQaJtyjjQ9UiLY8c/pUuy/Zcg1x1EJ3rZ
	 7S+FHbez7FUcB2kUSlMibfb1PpydycIF9Hddwc2CfQl31pbZ9cMSo8LvDjgKdjXKgt
	 cm+8ASt0hPy4Z+4rKlMtWzmDUAhIlqfXGie03jd6JIKJ1/r/U7EPoOXrTxFPhtfSp6
	 AGAOBxzRmyhOw==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [10.87.19.1] (lucifer.esat.kuleuven.be [10.87.19.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 9BB2D6000E;
	Tue,  1 Apr 2025 14:15:30 +0200 (CEST)
Message-ID: <42c84eb6-ede0-4e68-ae70-334365e2ae7f@esat.kuleuven.be>
Date: Tue, 1 Apr 2025 14:15:30 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: non-stop kworker NFS/RPC write traffic even after unmount
Content-Language: en-US
To: Daniel Kobras <kobras@puzzle-itc.de>,
 Linux Nfs <linux-nfs@vger.kernel.org>
References: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
 <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
Organization: KU Leuven - ESAT
In-Reply-To: <2c1a60a7-051f-4952-84fe-c3a4b6b0327e@puzzle-itc.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 4/1/25 2:05 PM, Daniel Kobras wrote:
> Hi Rik!
>
> Am 15.12.24 um 13:38 schrieb Rik Theys:
>> Suddenly, a number of clients start to send an abnormal amount of NFS 
>> traffic to the server that saturates their link and never seems to 
>> stop. Running iotop on the clients shows 
>> kworker-{rpciod,nfsiod,xprtiod} processes generating the write 
>> traffic. On the server side, the system seems to process the traffic 
>> as the disks are processing the write requests.
>>
>> This behavior continues even after stopping all user processes on the 
>> clients and unmounting the NFS mount on the client. Is this normal? I 
>> was under the impression that once the NFS mount is unmounted no 
>> further traffic to the server should be visible?
>
> I'm currently looking at an issue that resembles your description 
> above (excess traffic to the server for data that was already written 
> and committed), and part of the packet capture also looks roughly 
> similar to what you've sent in a followup. Before I dig any deeper: 
> Did you manage to pinpoint or resolve the problem in the meantime?

Our server is currently running the 6.12 LTS kernel and we haven't had 
this specific issue any more. But we were never able to reproduce it, so 
unfortunately I can't say for sure if it's fixed, or what fixed it :-/.

Which kernel version(s) are your server and clients running?

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



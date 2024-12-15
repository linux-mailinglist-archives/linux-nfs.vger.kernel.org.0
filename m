Return-Path: <linux-nfs+bounces-8564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFBA9F23E1
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Dec 2024 13:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129A51614F7
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Dec 2024 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92BD1494D9;
	Sun, 15 Dec 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="hpbpUvZ1";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="IrOJEBpd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409C1E871
	for <linux-nfs@vger.kernel.org>; Sun, 15 Dec 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266782; cv=none; b=eEMM/T79Pu86dfh5DqSe4NzqxQ0B/z9bClrTg+v9NdfiIHL1FRrtvDKRPIvJ4PisNaEsdpYiI0MHIVj77ZkP+4dWAEBBilH3OXf22VahNxObh10HUWJbYFn3FbyQsM0FTeJ5ZcA0KN6+QqIBR7MjvXgNuDIyASWMO5iRlgi7GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266782; c=relaxed/simple;
	bh=31TrkSWlYsAQlt7gY7PsqS5+tYnfgmLgj2eKD1U6QFw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=IznzYHGKLdBWPDRnOPo4eIAiX7pXR86X6hWSla3Ctb6FWBR/W1ZMWroIzaqJ9F/iKKMoGn4mHe+Vt+J9ore9Y6KjCWD2RraPWyRlQRZCB8+iKWVTRCzlwkSI32B83VZydpNa8D05jYa7VwYaFHG0c35UURFOsN6yIesudUJTPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=hpbpUvZ1; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=IrOJEBpd; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 508AB642A
	for <linux-nfs@vger.kernel.org>; Sun, 15 Dec 2024 13:38:27 +0100 (CET)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 572EE2005E.A3F05
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:130:242:ac11:21])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 572EE2005E
	for <linux-nfs@vger.kernel.org>; Sun, 15 Dec 2024 13:38:18 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1734266298;
	bh=9MCf5/e0kdRaUmqdX7VEfOcdYNrvwzMvM1/rTp6n8OY=;
	h=Date:To:From:Subject;
	b=hpbpUvZ1eImDFnZZp9iEBZbCQZ45EhDTqyvUz21i0XG3mCPh70q9zW6BC6OaXmW7P
	 4wshnxDIVmrAY8+EZGR+sQHw9421eo9N2UaZG02L1hp7RDX++50heG1VFYz4YwI/zK
	 q1KOqq0HyQlgmTFoqgc3NusD0uUSsbH5AGfDXLYZY4z0yv1MyAtjGK05v7DBck75M3
	 5gztY/7PiQx2Fa/Ab+p1F5h9XqY5bXrdB/L2jnM98Av8TzUAd8TDo1Wr9/OQmbw6rG
	 rJI8XvRT1Z/Nbohv3uhrTaaKanCX0wIBJDO7KS8sdTL1mNvpLzLexoq662In+D52Oz
	 gJN3HLfp5MOAQ==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 33BD1D4E80E77
	for <linux-nfs@vger.kernel.org>; Sun, 15 Dec 2024 13:38:18 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1734266298;
	bh=9MCf5/e0kdRaUmqdX7VEfOcdYNrvwzMvM1/rTp6n8OY=;
	h=Date:To:From:Subject:From;
	b=IrOJEBpdLS+wD397wEeB+sMxEIf9PRQcX7bWx5zWAOT0cZXGbgfOPe6oWXLzPrltz
	 uwdq4gTQ5vktVdRgC3HLy/cUlOCpZtPquNkxCZgGvUorROb0AaFSXA8JEkpGrY7Y50
	 mQSTg2kKUMyclEe8WrL4HLtxBKsAG5tsE39xPCmUJerIUI+d54u9kcBNwrRFWTx67c
	 qaN/4+yKTy/bm0DBr2peFBW2RAAU89TLtcGbxqtYmZUCYkEOZncxHc1l2S0izhHPlp
	 /iaxULZjHRqQEFbW0iNNq+4c+wf5j1/wnrD4yhsEFAzQfDvwDy+uV7CyqSVYvIvxE7
	 QuDdIJDlek1IA==
Received: from [192.168.1.159] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 1D9026000E
	for <linux-nfs@vger.kernel.org>; Sun, 15 Dec 2024 13:38:18 +0100 (CET)
Message-ID: <79767ded-466f-44a5-b15a-fde5af1b03c7@esat.kuleuven.be>
Date: Sun, 15 Dec 2024 13:38:17 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Nfs <linux-nfs@vger.kernel.org>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
Subject: non-stop kworker NFS/RPC write traffic even after unmount
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We are experiencing an issue on our Rocky 9 NFS server and Rocky 8, 
Rocky 9 and Fedora 41 clients.

The server is (now) running upstream Linux 6.11.11 and the Fedora 41 
clients are running the Fedora 6.11.11 kernel. The Rocky 8 and 9 
machines are running the latest Rocky 8/9 kernels.

Suddenly, a number of clients start to send an abnormal amount of NFS 
traffic to the server that saturates their link and never seems to stop. 
Running iotop on the clients shows kworker-{rpciod,nfsiod,xprtiod} 
processes generating the write traffic. On the server side, the system 
seems to process the traffic as the disks are processing the write requests.

This behavior continues even after stopping all user processes on the 
clients and unmounting the NFS mount on the client. Is this normal? I 
was under the impression that once the NFS mount is unmounted no further 
traffic to the server should be visible?

Not all clients seem to trigger this issue. On a Fedora 41 client that 
(auto)mounts home directories from the NFS server the behavior seems to 
be triggered when I start Thunderbird and let it process a lot of new 
mail (mail from the IMAP server is stored in the thunderbird cache 
that's stored in the nfs-mounted home directory). This triggers the high 
write traffic of the kworker threads. At first, thunderbird behaves 
normally but gets really slow over time. Stopping thunderbird does not 
stop the kworker threads and they keep sending a lot of traffic to the 
server.

Can you point me to some steps to further diagnose this? Where can I 
find what triggers the creation of these kworker threads? Why does iotop 
show the write traffic with these threads, and not the thunderbird threads?

There haven't been many changes to our kernels on the Rocky side 
recently. Is it possible a Fedora 41 client running a more recent kernel 
somehow triggers a behavior on the server that results in Rocky clients 
to start to misbehave?

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



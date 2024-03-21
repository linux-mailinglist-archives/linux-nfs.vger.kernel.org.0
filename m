Return-Path: <linux-nfs+bounces-2427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FE881C78
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 07:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D81F21912
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Mar 2024 06:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842223A1D3;
	Thu, 21 Mar 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="IuiTJ/JW";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="LrJHjjzm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65B31A8F
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002530; cv=none; b=oq4YQ3ZihsqmKqt4L+SkzmKdoI34PYkiQPDomQ1Juu07WzZUJpDC5Bm0RrFu2tDF/VXrwO17xbxg9vSKmWXlAYEBCNCSzl5LksR/jFOpJEWJ6Ai9bKz7JFWusUmlSyr+CISzXYz0X3VxzmbdRYSxydXupJ1kblmZ1kDpYTAPe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002530; c=relaxed/simple;
	bh=1mNhcLB9US68B1LfYFq79dyJQBoRyrxR4LLp0AQbVw4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XrcdrN6ytT6N7qA5tS8TguCVAS1PUezum4sgPz7zpo+fdHi0PgmERUVfGBApTpuaWZK5wzqDejdebzFAGGm5egGJYmSnTtVSFSCRLGajwm8VavOfFOAnv8dJAztQaIexGygneI6GN3FY5uo+qUE/G1x2igDlWL6CW08PoUc36EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=IuiTJ/JW; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=LrJHjjzm; arc=none smtp.client-ip=134.58.240.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: EF76320194.A2723
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:133:242:ac11:1c])
	by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id EF76320194
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 07:28:34 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1711002514;
	bh=tn1ICEOJPQPPHTwrNUxKTyFBE8W8z31X4dF9l5Ibkqs=;
	h=Date:To:From:Subject;
	b=IuiTJ/JWY0QFeeDmTugyhD6ac9gjUETDllp5SqP8dn4MMYWQmQju1om7le1NzPMAg
	 ZVWMxU2so/CGnuWeH+vQ8nkZe662c0oco4xN2Kvxgt6vQn4zVOi1kj5ixTQEy2mQlq
	 zlrlAOCn3P7ZtIh629oLq1JK4Bis3exbs+1cGWRn1nIHUTiyw2rQvn2hfeHrxF+Aml
	 94+LvbbiFMM5VyWvA/OM2X6rj7Gl3KJkd/5fi6fKo+EfQqabDsCG2N8Lobe7LDx8BL
	 kw0AlF35Kqso0TR7iw8E7gnBA80NEeaUOFjWCw9gNxG4ec/jU0S0I2c5rBuwflbp16
	 Yq4MIXOexW7mw==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id CC9D1D4F496FC
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 07:28:34 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1711002514;
	bh=tn1ICEOJPQPPHTwrNUxKTyFBE8W8z31X4dF9l5Ibkqs=;
	h=Date:To:From:Subject:From;
	b=LrJHjjzmwjB4L9jvHITF4CfuG98J5JM9vFl/07JhH+jNkBQg3mIc/i347bhE4ImC/
	 eaHA1fd/CYfjil17URA2S+Xp2WTQE0qZvVi7yVJlc4EISp9ttKdURrrbBAOBos8ham
	 Whgjt/Go0nLiqcNSyYRmt8Ot+es8wALwBibm/KjQiiUe2TudQBkX6lMyuiJ7YqCCEt
	 TZu6rXxxPSrO/ylM9aiKk8rfET1hEzQbRBJK+oImqO1HzMsfj9vrdfuWR6gwCXjFa9
	 OSawl6dBs8Mud1pbZ0HWR4uS67XJwKOLwWHBhztOFaPnF9wO7RF2HzXWlIxuIlyDBa
	 R+ueupeYL/XZQ==
Received: from [192.168.1.178] (d54c12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id AD0E26000E
	for <linux-nfs@vger.kernel.org>; Thu, 21 Mar 2024 07:28:34 +0100 (CET)
Message-ID: <ff131330-9f1c-493c-bfe2-8732a2730bf9@esat.kuleuven.be>
Date: Thu, 21 Mar 2024 07:28:30 +0100
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
Subject: RPCSEC_GSS_KRB5_ENCTYPES backported to some older long-term kernels,
 but not 6.1?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

When booting the 6.1.82 kernel on an EL9 system, the gssproxy daemon 
started to consume a lot of cpu, and clients using krb5 NFS could no 
longer connect. When comparing the kernel config between these two 
kernels, it seemed like the following config items were not set in the 
6.1 kernel:

CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y

I'm not 100% sure, but I assume this is why the clients can no longer 
connect.

Looking at the net/sunrpc/Kconfig file, these entries don't exist yet in 
the 6.1 series, but according to 
https://www.kernelconfig.io/config_rpcsec_gss_krb5_enctypes_aes_sha2?q=&kernelversion=4.19.310&arch=x86 
they do exist in some older long-term kernels?

Looking at CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2, it seems it exists 
for 4.19.310, 5.4.272, 5.15.152, but not for 5.10.213 or 6.1.82.

I assume it was backported to some older kernels, but not 6.1? Would it 
be possible to backport these config items to the 6.1 series?

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



Return-Path: <linux-nfs+bounces-6524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B116397A8E8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 23:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F101C26FDA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 21:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3909443;
	Mon, 16 Sep 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGvJc5cB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD36B241E7
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726523486; cv=none; b=pDMtkvIz4ibHEFZt1Tuh107nfKxI3/BwHb4XFFlacgAK5NFThbcTfvHI0J+72rGXwmcvk+CXJdFSDUFjzHueHdG1p/XQiPEAz+X1CQOORBfSD7HYFPhTGlTnbfF0h8Xlob6MoUW7NJODC4DBvAogmx+RwNLV58nbuUE/Peyw5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726523486; c=relaxed/simple;
	bh=n4NEAcS+QVLlW4odJIMBewTZR1JoEBwohAKiB2jUyjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKNhiGVCsGuQDV8v4wKD4F3xpLDBxJCND/m4deRvN+ph/8SQn0xenWFKvx7oUechpy5vJ+FlBDYnIL+41ChlvNcTX+mQcBAaWbb135HO1s2cTf6AjrvIbtQ5WzZj9A//qD1u0/7x8pZE/OKMsTaxO3GPFRlfHEHSj5PLYA90bmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGvJc5cB; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5dfaccba946so2658112eaf.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726523484; x=1727128284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwscasdXgG9xwOnxcoRMwcPvsRotj7DcI13eYmfAlgk=;
        b=eGvJc5cBYd0IpkX8XEXnBS5WUHHeohVE8SItP97/qplQhO9ia2ao5f4qITEv3SYpZ4
         sSM7kWSGayGnk3XNZ/5sSb6MqdpOjJchO+rZw3vEzSUN5x8cfoVQ35s5zi3fdgStSles
         elvlghevqrIfUOnjIQCm7VBFrvEeF3aY2/TY+BX/ZLa64lDG6y/KSM/cy40w+icWeYUN
         DH4FRc79cC8QEkx12pWlQufFALkeVcQMQOB9kngdpiaEDV0jU1fo4PV9a0ONamEFP3Ve
         q/3LuV2bvrz2NvGKDEY0UISxzN9WC+UUAJVShhF2CASBIcvTWFcpFFpAgb/sDVXPzdUX
         tCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726523484; x=1727128284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwscasdXgG9xwOnxcoRMwcPvsRotj7DcI13eYmfAlgk=;
        b=rU7ln3HPmKGCiF3swlikh7g36VFYuIxLit23lnQMU+SOHGxS/Ez6C0d5JCTpli/gwU
         a/ySS95h8Zq55PtWJ2Gc7bPOnJE/aJsOI+MPLpY6RZafiapUB/CslffVlym0Yf4MJXYI
         isso/q74gLWdlzc0PJJd+4C0GDStp57v7w3FJDeatn+Xxs1Evghgx80IgVRofVesVd1q
         01Hfq9TLiEN3uI2LZdH0DJRqlqGiBHLmzWIgIqgfI3RlWQ/U9YvlGTCzjPo23XlrMtFY
         2Bmtb73yGKRgsg4UI5fCm8AczQh620IJ063dvow1VWb/exAoLABYWDiU6KAPrBWM7bn2
         0DEw==
X-Gm-Message-State: AOJu0YwnZdfdOVj7Z9N5m4IOu4i61qMEZNIfbwIIHk5IcqZCE0lZc3sz
	xyAQnG14ZG+yaOh49KCXUOIrzBQzIhigS/befbxdaeDETdIOyxl3
X-Google-Smtp-Source: AGHT+IHGMrtLiUVAzKc9u22kvfEd8Tqhu6TQ12/2fVsNQVOACQb6dN3T+SVy5eFKiW8pmP3dYIXvmw==
X-Received: by 2002:a05:6820:2296:b0:5e1:f66b:d0b7 with SMTP id 006d021491bc7-5e20144fdd8mr8509288eaf.3.1726523483692;
        Mon, 16 Sep 2024 14:51:23 -0700 (PDT)
Received: from ?IPV6:2620:1f7:948:3000::5b3? ([2620:1f7:948:3000::5b3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0e299eesm1024583eaf.33.2024.09.16.14.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 14:51:23 -0700 (PDT)
Message-ID: <d0c6ed5f-d6d1-4fd9-935c-4e7b4fd8dedb@gmail.com>
Date: Mon, 16 Sep 2024 14:51:22 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: issues with Linux client pNFS
Content-Language: en-US
To: Anna Schumaker <anna.schumaker@oracle.com>,
 Olga Kornievskaia <aglo@umich.edu>, schumaker anna <schumaker.anna@gmail.com>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
References: <41ee5118-027b-4630-8f02-b3a67c61b328@gmail.com>
 <6880c031-3936-4ea1-86f2-5dc6050c9051@oracle.com>
From: marc eshel <eshel.marc@gmail.com>
In-Reply-To: <6880c031-3936-4ea1-86f2-5dc6050c9051@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Anna,

This trace on the client shows that it was requested to use *nfl_util 
0x400000*

filelayout_decode_layout: set_layout_map Begin

Sep 13 09:20:10 svl-marcrh-node-1 kernel: nfs4_print_deviceid: device 
id= [3000035a0b38c07df0465]

Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_decode_layout: 
*nfl_util 0x400000* num_fh 1 fsi 0 po 0

Sep 13 09:20:10 svl-marcrh-node-1 kernel: DEBUG: 
filelayout_decode_layout: fh len 61

Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_check_layout

Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_check_layout 
returns 0


This trace on the DS show that it reads 0x48000 before skipping to 0x880000
as you can see it reads 0x48000 from DS 10.11.56.194 before starting to 
read from 10.11.56.195
and I also show it on the server side that revived those reads.


Sep 13 09:20:10 svl-marcrh-node-1 kernel: 
pnfs_generic_layout_insert_lseg:Begin
Sep 13 09:20:10 svl-marcrh-node-1 kernel: 
pnfs_generic_layout_insert_lseg: inserted lseg 00000000867a0461 iomode 1 
offset 0 length 18446744073709551615 at tail
Sep 13 09:20:10 svl-marcrh-node-1 kernel: 
pnfs_generic_layout_insert_lseg:Return
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_update_layout: inode 
0:51/88064 pNFS layout segment found for (read-only, offset: 0, length: 
18446744073709551615)
Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_read_pagelist 
ino 88064 pgbase 0 req 1048576@0
Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_read_pagelist USE 
DS: {10.11.56.194:2049,} cl_count 2
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_update_layout: inode 
0:51/88064 pNFS layout segment found for (read-only, offset: 0, length: 
18446744073709551615)
Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_read_pagelist 
ino 88064 pgbase 0 req 524288@1048576
Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_read_pagelist USE 
DS: {10.11.56.194:2049,} cl_count 1
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_update_layout: inode 
0:51/88064 pNFS layout segment found for (read-only, offset: 0, length: 
18446744073709551615)
Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_read_pagelist 
ino 88064 pgbase 0 req 1048576@1572864
Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_read_pagelist USE 
DS: {10.11.56.194:2049,} cl_count 2
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_update_layout: inode 
0:51/88064 pNFS layout segment found for (read-only, offset: 0, length: 
18446744073709551615)
Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_read_pagelist 
ino 88064 pgbase 0 req 524288@2621440
Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_read_pagelist USE 
DS: {10.11.56.194:2049,} cl_count 1
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_update_layout: inode 
0:51/88064 pNFS layout segment found for (read-only, offset: 0, length: 
18446744073709551615)
Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_read_pagelist 
ino 88064 pgbase 0 req 524288@3145728
Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_read_pagelist USE 
DS: {10.11.56.194:2049,} cl_count 2
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_update_layout: inode 
0:51/88064 pNFS layout segment found for (read-only, offset: 0, length: 
18446744073709551615)
Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_read_pagelist 
ino 88064 pgbase 0 req 1048576@3670016
Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_read_pagelist USE 
DS: {10.11.56.194:2049,} cl_count 1
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_update_layout: inode 
0:51/88064 pNFS layout segment found for (read-only, offset: 0, length: 
18446744073709551615)
Sep 13 09:20:10 svl-marcrh-node-1 kernel: --> filelayout_read_pagelist 
ino 88064 pgbase 0 req 524288@4718592
Sep 13 09:20:10 svl-marcrh-node-1 kernel: filelayout_read_pagelist USE 
DS: {10.11.56.195:2049,} cl_count 2
Sep 13 09:20:10 svl-marcrh-node-1 kernel: pnfs_find_alloc_layout Begin 
ino=000000003c8009bb layout=00000000f5222588


So it is skipping *0x400000 *but why was the first chuck 0x48000

Also way some read are 1048576 and most are 524288

And this is on the server side.

gpfsRead enter: gnP 0xFFFF91F810942688 flags 0x1 uioP 0xFFFFAED0C47878B0 
vinfoP 0xFFFF91F81352FA30 off 0 len 1048576

gpfsRead enter: gnP 0xFFFF91F810942688 flags 0x1 uioP 0xFFFFAED0C47878B0 
vinfoP 0xFFFF91F81352FA30 off 1048576 len 524288

gpfsRead enter: gnP 0xFFFF91F810942688 flags 0x1 uioP 0xFFFFAED0CA01F8B0 
vinfoP 0xFFFF91F81352FA30 off 1572864 len 1048576

gpfsRead enter: gnP 0xFFFF91F810942688 flags 0x1 uioP 0xFFFFAED0CA5FB8B0 
vinfoP 0xFFFF91F81352FA30 off 2621440 len 524288

gpfsRead enter: gnP 0xFFFF91F810942688 flags 0x1 uioP 0xFFFFAED0CA01F8B0 
vinfoP 0xFFFF91F81352FA30 off 3145728 len 524288

gpfsRead enter: gnP 0xFFFF91F810942688 flags 0x1 uioP 0xFFFFAED0C47878B0 
vinfoP 0xFFFF91F81352FA30 off 3670016 len 1048576

gpfsRead enter: gnP 0xFFFF91F810942688 flags 0x1 uioP 0xFFFFAED0CA01F8B0 
vinfoP 0xFFFF91F81352FA30 off 8912896 len 524288


Thanks, Marc.


On 9/16/24 1:33 PM, Anna Schumaker wrote:
> Hi Marc,
>
> On 9/16/24 4:27 PM, marc eshel wrote:
>> Hi,
>>
>> Who is the current maintainer of the Linux NFS client?
> That would be me and Trond.
>
>> I have an issue with the way pNFS client is distributing the reads among the DSs and I can provide the traces if anyone cares.
> What is the problem? And sure, send along the traces! I'll try to take a look as soon as I can.
>
> Anna
>
>> Thanks, Marc.
>>


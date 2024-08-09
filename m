Return-Path: <linux-nfs+bounces-5276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D714794D4AB
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 18:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D827281067
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1CA182B3;
	Fri,  9 Aug 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+17kbU7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F368217ADE8
	for <linux-nfs@vger.kernel.org>; Fri,  9 Aug 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220823; cv=none; b=ulJnpfSCGCPvUewUBSGsPZbXZzhK5b5xy9YLF8HL1j/zzXH+2kfC/Frp/XoVMmfnzPzCEnvq08zsGPACU/SEDlZBHGEqo24MbYK4iLv+dn/EHhCcGiKYSfCoOFV06YU+j1Ra9dY/IvvumWGdregdr6gwcv8tS98S68BrIqs+AZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220823; c=relaxed/simple;
	bh=fIdJFldZvPHmxKZQM61RpXQ6EsuDyZ1gCRWkfzCF778=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0BrV9BVJJVkepV1FoQQkGHHVuPvBTwIsv0BcTp1Dlkr141ieEus7inVS3QaBp29xCkDTtUB/jjb865+SeLHibdu/yZ46CawA2yMJgUSc+/TIittccYV6V79hg3LGnkiHVUoUoa/4GTm3OPeYm3IUdFwkDHZJ8N4DOpskHBdJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+17kbU7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc5296e214so23102685ad.0
        for <linux-nfs@vger.kernel.org>; Fri, 09 Aug 2024 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723220821; x=1723825621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsG50onX1vjlSKKFDnq4ai6+NhN0VsRM7/xiC7es870=;
        b=U+17kbU7hyeUAqwL6eHeOlES+h9u2a/nWAKhY1bMX2HU69JX3PmyMIFEi3PUEm+ehG
         7O+HMsqrEpDQIopTDFAEDomzM0hSrT9tJ2WK3Wi1AfEKTJSZLCjgc75vK//ZpklQT2G2
         QlQrq0qMfBi3/3Vb45MIPiK+ZUqTIjcgDji3Z1uHdB7iwb+YimbhMPYxllRDf5Q3rEUg
         SsCvee6jk79Ot6e3N821nXFT5ufjj07AzY0f+vNTxSYnhM0PbzVac1zTsiQfkFayH3lA
         Xz8cCd362BYB+d0SaROuz+OSF62aPcaGjNRtMKOY7ELeVXALO0tsgl50YajIZE0qK9MI
         unOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220821; x=1723825621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsG50onX1vjlSKKFDnq4ai6+NhN0VsRM7/xiC7es870=;
        b=tIvsMksTomKwQzLYfoLOP7E6rt/Itrt5j9nwzCiaWfF0g1znBLrlvEoZJsSmzK9e7z
         YeYdAO21jMp9KkeFg7JgCF97P25LoMDaBItgl3F3pNZZl+5srSUvGLrYqBvzmwLD/h3x
         XsmDdIYi635cyYw7DwgNvqj9jKEWinX0UQBtxG8mDItNUUVBtVY1ZxjjLAlL20/tvN/e
         1vbho9V/NTm/Z2z2K2oFDPyZF/q0AVBzT/FXYAtOjNhrFY/qs4CmZ+Au7gTToHEIByQI
         yhxyNTGB18yUocTtfv4mMYNOGSt6teSuKHn6AlFfS7Zh4nBviLeY0bEmQ+nbPEy6FtYB
         OaPw==
X-Forwarded-Encrypted: i=1; AJvYcCUjaIBle/a8Qgv59dAoh/nRSiFAj7HBF+kDYvYygnDAjREBX0/fiF0eWFZZJWgQCi+CcxFnJHLB8LdyAjU+54G2smtKvxQyK58M
X-Gm-Message-State: AOJu0YxUCqg8YXmmdmTvf4uYe2gXD9AWZ6BbKjaaSDMiIVuQL2T5X8nT
	6uWZj54AbM48tLY9oDsdVgxTF+GTBjdOBiJ29Mj62L8y5wzQDltl
X-Google-Smtp-Source: AGHT+IEl9Yw7sW6HhTfrkQE0XUQYndgSHv6iLMfH69tYIyy1VXXoiea5FU93Wz1wlutqFLtRB6b1zQ==
X-Received: by 2002:a17:902:ccd2:b0:1fc:a869:7fb7 with SMTP id d9443c01a7336-200ae5f2f97mr20661155ad.54.1723220821118;
        Fri, 09 Aug 2024 09:27:01 -0700 (PDT)
Received: from [192.168.86.113] (syn-076-091-193-045.res.spectrum.com. [76.91.193.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f26f4bsm144443355ad.34.2024.08.09.09.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:27:00 -0700 (PDT)
Message-ID: <4851b332-b3d1-4f45-9fcf-5c42b8d5b483@gmail.com>
Date: Fri, 9 Aug 2024 09:26:59 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS client to pNFS DS
Content-Language: en-US
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Anna Schumaker <schumaker.anna@gmail.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>
References: <c4f1d8bf-745b-4a98-9d38-2da4c355d691@gmail.com>
 <66be75a6-2d3f-4f5b-96da-327556170c4a@gmail.com>
 <e39131ce-1816-49e1-8319-820472892a38@gmail.com>
 <CAN-5tyEx=j2OiRZVd+18x-2Y36SGGsJxAVApudT+mWjiNGDyxA@mail.gmail.com>
 <CAFX2Jf=k0SC4iFzj+24HbR-4MPkk0bkGCvnnOiv0OYgqO4QOBw@mail.gmail.com>
 <8ab0fd49-0c90-42bd-a34e-9dcf63a99bd5@gmail.com>
 <CAN-5tyHMAWmnwgfR7ih_7ygUUfOdGfE7ntf2nxRTFY+USy2HYQ@mail.gmail.com>
From: marc eshel <eshel.marc@gmail.com>
In-Reply-To: <CAN-5tyHMAWmnwgfR7ih_7ygUUfOdGfE7ntf2nxRTFY+USy2HYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/9/24 8:15 AM, Olga Kornievskaia wrote:
> On Fri, Aug 9, 2024 at 10:09 AM marc eshel <eshel.marc@gmail.com> wrote:
>> Thanks for the replies, I am a little rusty with debugging NFS but this what I see when the NFS client tried to create a session with the DS.
>>
>> Ganesha was configured for sec=sys and the client mount had the option sec=sys, I assume flavor 390004 means it was trying to use krb5i.
> For 4.1, the client will always try to do state operations with krb5i
> even when sec=sys when the client detects that it's configured to do
> Kerberos (ie., gssd is running). This context creation is triggered
> regardless of whether the rpc client is used for MDS or DS.
>
> My question to you: is the MDS configured with Kerberos but the DS
> isn't? And also, does this lead to a failure?
Both MDS DS are configured for sec=sys and it is leading to client 
switching from DS to MDS so yes, it is pNFS failure. What I see on the 
DS is the client creating a session and than imminently destroying it 
before committing it. If the is something else that I can debug I will 
be happy to.

Marc.

>
>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
>> auth handle (flavor 390004)
>>
>> Marc.
>>
>> On 8/9/24 6:06 AM, Anna Schumaker wrote:
>>
>> On Thu, Aug 8, 2024 at 6:07 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>
>> On Mon, Aug 5, 2024 at 5:51 PM marc eshel <eshel.marc@gmail.com> wrote:
>>
>> Hi Trond,
>>
>> Will the Linux NFS client try to us krb5i regardless of the MDS
>> configuration?
>>
>> Is there any option to avoid it?
>>
>> I was under the impression the linux client has no way of choosing a
>> different auth_gss security flavor for the DS than the MDS. Meaning
>>
>> That's a good point, I completely missed that this is specifically for the DS.
>>
>> that if mount command has say sec=krb5i then both MDS and DS
>> connections have to do krb5i and if say the DS isn't configured for
>> Kerberos, then IO would fallback to MDS. I no longer have a pnfs
>>
>> That's what I would expect, too.
>>
>> server to verify whether or not what I say is true but that is what my
>> memory tells me is the case.
>>
>>
>> Thanks, Marc.
>>
>> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>> stripe count  1
>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>> ds_num 1
>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC:       Couldn't create
>> auth handle (flavor 390004)
>>
>>


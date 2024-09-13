Return-Path: <linux-nfs+bounces-6459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA848978614
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7750B285E94
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794C6F31E;
	Fri, 13 Sep 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTUfcXtB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C061FEA
	for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246005; cv=none; b=ePpaK8ZFMCZrRIAOH1BitfX283OBOHwOFrNC86V5NuzYqjObdvSbKBcI5f0R9MreyZL3oUdSQS0xwDC/lapYnDI4mCJUy1XPwwumc6oRlZVeaeMym86zCORGvYlcBTnAObsghdfLZLVBFLDqj04pbsCfdqEjIYE8wIpQ336zHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246005; c=relaxed/simple;
	bh=OJKqARipj/oxwvrTvmkFqz+PdjfqjhkPfWpLDGOGSjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjF0ErXjc+XxrJzm/eHIeZP0qUgLuZfjUqjEfjHxVXq5N41Si2eBHF38YW6BCKW9ipsc+7R3cvVopIzwzqMz3eSnoH/v518rIpxvkyiJ5984MpHh0Xmoesiuttn7WUQ6U7YjrCeedANq2lzES559TGnU6qVRc+ZqOdhnyoFQiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTUfcXtB; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27051f63018so544791fac.3
        for <linux-nfs@vger.kernel.org>; Fri, 13 Sep 2024 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726246003; x=1726850803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IU4O8I2n6kotUzY6WTsG20TZvv1d/Kh+LUWKJV0igEk=;
        b=nTUfcXtBewU/PRDodarTnVBrUXHH6xop6CoU6zelo/Jv+5+vbBYCtYq5he7uTiGd4r
         ABJEB91ta/Jxj//IJQLm9krmdNT8hMkGWNICQOeyo+qAbKpvFeUE389AQx114+gnyzfc
         zELCSulliAXenvj2nogz2nOdu0zBqe+DgA+arZvY/LWM/dkxyJfNZooyaSVN/LWSHMsy
         W7K1bz24AQLdjK/pU5DU5AKHXrvNPkprn6Qo3ntL/Qf0ANAzi1Mj4pMFdFyOJh300omU
         BITcmMIykNQf29aUR7rb2OYJHpFZVVHFxzDh+7pKU6YfY2Phij6n7+gqCuNlu8Im0fWE
         RhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246003; x=1726850803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IU4O8I2n6kotUzY6WTsG20TZvv1d/Kh+LUWKJV0igEk=;
        b=kigfVohsl9PRmpm4aWEC8iB0hWewOZ73HdktBGTi082diWfYgjp4U5hyP7Fi+irz6y
         J4QWw99e9RRBT750EVUxXYspBN3+N3F7nNQCZPbw81Dh9Ce7XO669mMOxjAohEalLI7+
         R+eqCGBYYqUjPOOHBqo2ERrBShifcg3aHzPTHyBbCXLsyctI7zEjep1XINw3xmc3nYmk
         xrNlfHO+thI7HqS3T3VYRk6VVJHg9dXn7BRZy8S1TG1+Gp1Pb4o6eYiqu8PSrgjrc5Vv
         u5qiepN0xsH9UZcJwP1n+8+CqZYbOpDtx8GoLGhvn7uhRwtvJewH9EW4p0oKJPlc5PkH
         ePBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7IP99ob/rZDj/38gl6dEU5u5iW199SoKI2w7wDAQqPrNZsM15y2f+6XhiUrvDPfn4st66+QPRAOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpCrUc5w927s/i3tybfUHjTjeZsJXDv1iwA6qVcGDu5x58Etjm
	XpykT2qMiBKsV7n2T9pmKhgtGFlY7RWK4P61/cJlnDwBEwk9uVbi
X-Google-Smtp-Source: AGHT+IHQ4iNJ6k7MkuEuC8CpiOlMGzUf2j2BM301CdIubGsHsrIMcqjiDz3XS9wFva2dK4XU/mAgsg==
X-Received: by 2002:a05:687c:2c2a:b0:260:ebf7:d0e7 with SMTP id 586e51a60fabf-27c68955c20mr2425375fac.15.1726246002783;
        Fri, 13 Sep 2024 09:46:42 -0700 (PDT)
Received: from ?IPV6:2620:1f7:948:3000::df8? ([2620:1f7:948:3000::df8])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba410a0fbsm3690892fac.52.2024.09.13.09.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 09:46:42 -0700 (PDT)
Message-ID: <c40a1ed3-0989-44d8-ab3a-9c90f0a9dbad@gmail.com>
Date: Fri, 13 Sep 2024 09:46:40 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: pNFS client is not using the stripe value
Content-Language: en-US
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <aglo@umich.edu>,
 schumaker anna <schumaker.anna@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
 <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
 <b717d82f-7eb4-475b-bd7b-e376172a2b42@gmail.com>
 <2102290340.59910889.1725952999821.JavaMail.zimbra@desy.de>
From: marc eshel <eshel.marc@gmail.com>
In-Reply-To: <2102290340.59910889.1725952999821.JavaMail.zimbra@desy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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

So it is skipping *0x400000 *but way was the first chuck 0x48000

Also way some read are 1048576 and most are 524288

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



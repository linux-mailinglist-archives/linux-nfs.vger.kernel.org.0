Return-Path: <linux-nfs+bounces-7283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9C9A415F
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993391C22388
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE31F130B;
	Fri, 18 Oct 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1EVXqUb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB942A97
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262416; cv=none; b=KI5ue1xUudyBhQa0r22Cjg4tLjEOJRpr/SYWhcyIJbRru/F4pSFtO7Wr2XWKpBVf+7WoXaN8AhzyPqyGlSmvafATUAaJumt3PTF+vA2UTy4f+RPrgvkwdP54IGcaJonM2Pn+SLMo94sYeX0w5ZcP+yy+3ybNPZsztu5ZP+fvS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262416; c=relaxed/simple;
	bh=sEVKIYDgFITFwlOckpDyTadsSjv8OSHMx5ZiyZLXurg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1a3W8X0LINjdKbbdungz9QdNSEXVi6v5JG/pZjBJHvvzex28C3hAEOpkwRzHs9hLGWohsBFx1NQgPm6EVlLopbmZWB+LZ9X0Kazzt1/bPuYGBvlkPimQIX1VX+ld2iWbd+R0Jid8lw3758aqunaX6Hngk7nGBNUnCO3nIv6fA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1EVXqUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729262413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgjZmB5PmiSPdnNlNSN8TSE4Jg9mllBjR3pUvQyr7mM=;
	b=g1EVXqUb15mZWV/+Qc0jDk3A9nOF5ZP+izvMlkUiL5HoGLDupkKoH+x3CH0668LYejeL4I
	q/hhv5JJ+TQcDLvalmSARB78c0/bsribBqa+b2HAOsDx80JooC+P8X+cHlg974/eQj1dhf
	uFgXONpepr93P+cMjcfQXo0bW8GQsbw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-LssTrtpROPGJHAtKBqsU5w-1; Fri, 18 Oct 2024 10:40:12 -0400
X-MC-Unique: LssTrtpROPGJHAtKBqsU5w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbed928402so23395696d6.2
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 07:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262411; x=1729867211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgjZmB5PmiSPdnNlNSN8TSE4Jg9mllBjR3pUvQyr7mM=;
        b=L65xX0ucaY1s20LL2WuFmpY81mlbsaog8Dtn4+LJJSMo8yVXPImW+WO7vIR47c0yra
         /4PEAHRsCwYR6gwK/XLTBRpNRyuQQ+tVcvTgc8dHSo0F0AsiKDgoeQEQ/kRjYcv9futo
         m0lahJouLIIT8u82vTaFEiJDYf1+li5MX9eyqNqGhmtRYxyG5B4AJiMF5PDwaa4Hr/Rt
         3LxU8y6MfEk3va66S7uBXyPUuqwibHAUpni1DYHaZISV0hb4yus42XmBUgQCPM7aveQX
         Db5Mzow+BwNAaeSCxEqR3KfjoJBHR+3TLpNxRwTPKZjRAzgure4lOi7POX8tsjTRYRa1
         5jtg==
X-Gm-Message-State: AOJu0Yz2ZA2tJ1D7k9Nt4D+WUx3q7FxIwhxcZZ/NexMou2npIuR/NQgs
	UcLNY2d1c0TP7UcKp7fgQz8I5AtjXmP5LG7qXUOJcmlxnlPslkRYX1P+6FaTLws9ScGF0nF1/K+
	dRn4bOx5VDSnIH8yHgsr6GLIOkHbLJHg6+dwN0OEOCkJG7bLR+kdQJkcUGM75hAVpTw==
X-Received: by 2002:a05:6214:3c86:b0:6cb:c487:24b5 with SMTP id 6a1803df08f44-6cde15f1700mr39318166d6.32.1729262409593;
        Fri, 18 Oct 2024 07:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf156WI12f5achAtJ9o5ZSEUOAKl3FiCCd4dBQjC7/D3lvzk45YA2d/fnlR8f5Z0P3WjkF/Q==
X-Received: by 2002:a05:6214:3c86:b0:6cb:c487:24b5 with SMTP id 6a1803df08f44-6cde15f1700mr39316476d6.32.1729262407721;
        Fri, 18 Oct 2024 07:40:07 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.130.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde1366d96sm7551116d6.126.2024.10.18.07.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:40:07 -0700 (PDT)
Message-ID: <2cf925d9-3598-40f7-9492-644e56fc7f74@redhat.com>
Date: Fri, 18 Oct 2024 10:40:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /etc/exports refer= syntax for raw IPv6 addresse?
To: Benjamin Coddington <bcodding@redhat.com>,
 Cedric Blancher <cedric.blancher@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Chen Hanxiao <chenhx.fnst@fujitsu.com>
References: <CALXu0UdkaXPMWEe9amJ5Ugg0rw3CWnQMLDyhx6PtPc6oEKoPMg@mail.gmail.com>
 <DCF652DE-43AF-46B1-A9A0-CF2B488A49BE@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <DCF652DE-43AF-46B1-A9A0-CF2B488A49BE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/24 9:34 AM, Benjamin Coddington wrote:
> On 18 Oct 2024, at 9:06, Cedric Blancher wrote:
> 
>> Good afternoon!
>>
>> What is the /etc/exports refer= syntax to pass a raw IPv6 address?
>>
>> PS: No, nfsref is of no use, the target system does not support it. I
>> need the refer= syntax for exports(5)
> 
> 
> I believe we expect the use of '[' and ']' like this:
> 
> refer=[fd7a:115c:a1e0::36]
Yes... all IPv6 address need '[]' brackets.

Thanks Ben!

steved.




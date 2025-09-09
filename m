Return-Path: <linux-nfs+bounces-14137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA881B4A01C
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 05:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867034E6BF6
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Sep 2025 03:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B58A271A6D;
	Tue,  9 Sep 2025 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTnsehBA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C422571C2
	for <linux-nfs@vger.kernel.org>; Tue,  9 Sep 2025 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388934; cv=none; b=RcUagJU313GhleDPdDxpNxvbXV0BGV8iwn+YNg+PTDfXaWMIcrospcfd1suY8YLgmVX3N7JKi7rGiDZQnMFdTOtjNzYPvSsz3RoojzUWRYbISgeZoPSon8hHtv9Pu0pxcuSdgfvbIVhreQ0OUdIBw4z4AcVRZWNl7blPm6c4jLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388934; c=relaxed/simple;
	bh=8wXoholrPg4QqcihIHCLy5ZNMapgF/uRELn5a5DpsA8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GUJc1FgqiQ8PtRB8aF8ekKUXuBKs2AmgcqYhsitVwObJenVCqVm/+cliN35FaUmT+T1Cm9VdAxz1IdoqS6F+cwGLNZOb/XK65AwzmQSMj+mV9oymNRg+KVs4OhaO/SCnB9Z4kl1hBAnukn0ghI+peGXCPzi3r0VGxT2KU51hw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTnsehBA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7728815e639so2773852b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 08 Sep 2025 20:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757388932; x=1757993732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZkLaMiNl2RyYD/ViyJGzeHqYNdjoDBRetEdQJmftsQ=;
        b=FTnsehBAHG4sMpN53Hw4f2Q80KhPwi/GKnnCZv5SAWZVFQuSO7g1gMyQXB0fAirdF4
         ynCnZJFd64Aez2K5dKwBW2W5V9pfWyvPJpfEOL2RaMCDosXeMbAZkqsZw0FPaqsQ53sX
         PcUoaaVlSxJSElKIbahQjkaweMaluIil+AK/0Gh+nOldRTfZp85dVQofgH8mZSES5ncw
         eXZsYR0pNdgzuM8c8slQrunZibR6IihhVAQLdQeDhGYZNFb5u1lF+elqNCvZiW8CTeMB
         GDbs5UvHT+dZ5OjLwTBOdZcKo7pfgFWAZ9FdHclUnd7lzHSHQohJ1QEtkf679IieQpTr
         zJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757388932; x=1757993732;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZkLaMiNl2RyYD/ViyJGzeHqYNdjoDBRetEdQJmftsQ=;
        b=upzxdEvvdj05qH3u7QBRcOF/Des/57gg0fFAD7Ep5mfVTDrMydAP+j68TCgBKPooRd
         beI3//Hx18J4vAOdyBNV8fdfi1C5R/OduDHUWhQnPFaUnW1XdMAkSs7u+yQu5dRwJGIA
         ISQDc38BQ0a0lODaWkp4Ynq86vE8JQg468N/ACcvMR34dv+RiBvx3H6uRSvyLfMFlsSt
         GpS8MG3KrLtb1MAe/ma6XTdBU9JqyU21YLIHIMKr6huRQwSy870mmfPuzzrcua62BKGE
         QQAnaNw/m05nUHGfeTxh+1qmRC1cxXnuMonkVnAdYyQpBXCXjG7ou6jFIbrv9MGVheQS
         P6Og==
X-Gm-Message-State: AOJu0YySzaBjSmm9EmjVDfQ2AmjYqoOqDRVgkzLoXkO1BQS/VcoXXvSC
	JkQW+XVANo/m0809mzq0I/pO8/+CIsZ/lFsNwRLVG39N3aiNiP67Zf6T
X-Gm-Gg: ASbGnctk8lItHZB8xedus/nz7YZt98bpnXkavxXqLinrKRSZpCgFrremDR3XctPYLfL
	D0Z6rZcA+HAgHwW79Xsa0n9VsTh6t7WLpk9I5IaddRnAnTan1pP+KThWrEBCZASe0Z0DdnJQH3e
	u9jCwM3VyhYn+DVrZU+HvkX99ZL2b4qAw7wfCtnlbBSfm5V31Atdz5bbtlWxVnFQU5osmW37Ofr
	j7wyIM8CBRwfWBRA2yTteBgso4CNyEGZegihESQ/nkK5+tuWpjdEBOX+ER5J+hlC68EELzWUbXl
	WKdgMTjo18N3cZcKg++TY863KlM+f9jDRiVgUojOYbRIS8P7mToo4+phncr8StKrZt6+BwibJQl
	XY53xVUQu1z++f7bZoRNzbWkALSz9xNf8CiLQ7Ovw7AoFjDdV
X-Google-Smtp-Source: AGHT+IEDoEb+aA5/NMiSX4rlM/SyxLKRlJeefUkVSdJm4xx9QyrPQPA8tj2fVnUgMsCCVoB8it9WnA==
X-Received: by 2002:a05:6a20:748c:b0:251:2a11:e62 with SMTP id adf61e73a8af0-2533e94d7d6mr15580052637.14.1757388932227;
        Mon, 08 Sep 2025 20:35:32 -0700 (PDT)
Received: from ?IPV6:2601:647:4d82:2ae4::d83? ([2601:647:4d82:2ae4::d83])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4e673ad423sm24469086a12.50.2025.09.08.20.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 20:35:31 -0700 (PDT)
Message-ID: <f8437b42-63b4-4f8d-b82e-0ff8cc540fb0@gmail.com>
Date: Mon, 8 Sep 2025 20:35:31 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: scott.b.haiden@gmail.com
Cc: linux-nfs@vger.kernel.org, trondmy@kernel.org
References: <3e19b7e9-c3d2-43b5-96ea-c5cf7904e8a3@gmail.com>
Subject: Re: [PATCH 0/4] More server capability fixes
Content-Language: en-US
From: Scott Haiden <scott.b.haiden@gmail.com>
In-Reply-To: <3e19b7e9-c3d2-43b5-96ea-c5cf7904e8a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello again,

I saw that these patches were marked in patchwork 
(https://patchwork.kernel.org/project/linux-nfs/list/?series=996999&state=*) 
as "handled elsewhere"; could I ask for a link to where they're handled? 
I tried looking at a few other patchsets in the nfs mailing list but I'm 
not that familiar with the NFS source and didn't see any that jumped out 
at me.

I'm hoping to follow the patch so I know when it's safe for me to update 
my kernel again.

Thanks!
--Scott



Return-Path: <linux-nfs+bounces-9606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE81A1C45D
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15621686BB
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2025 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECAF3595F;
	Sat, 25 Jan 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnclmNQO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772018E2A
	for <linux-nfs@vger.kernel.org>; Sat, 25 Jan 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737822819; cv=none; b=SCKf64kOalVER2mGggiJi3tKUZtEOKxHodlyGG33X53pHeZOxr/+xguhf0pBohRHyNuH1N/Uy/7MgNNKnqlhhZzQCaW0Pqu4YTSWcTspTqnegntlSbVEXPRTR2SKfhnw2nEwz/I7b4oXGBsUxraXtewf3BrxZbDtQdlWa2b7kMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737822819; c=relaxed/simple;
	bh=tSsrxMLTOxwP2Hjm7kxxbNOGyOEEjJxOtf8MRbk2HYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aFjRcnSfUTTYJCRO7Hlk0R9JbCM8pfKUIeqDWDVeTNpAUklkcaa5rc49e0/WaXAvTu49fhuNR4YMRFxweFJ6CgNAzxaXXPXPTHK7iVcUYfWfVvymWLbZ/KtL7Vkte6yR1TiFDDv2PA6JaCOK7US8JryMMPWNxmAvzZfDrcbPFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnclmNQO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737822816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jd1ArQEeAhgz0wTwpfi9Lt9GxJ2QkLgY2aY+vGiSFZ4=;
	b=FnclmNQOr+c8/ysJ0T7csjMaf9OPgTtuWldB7SAZIk2IzbS9EkKD3qrs1cKXspx+oVZWII
	/W8EDw/SKc0fXgWPAMXM8WEWtLoDeC4Samqg4JNBqolWtXXffvOyxZVBcF0BnfHmGUxoMl
	qTdDy21OmpQjUB25tCGfj8CLNDxwMyM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-f_ql735INHis5QYSKpzfNQ-1; Sat, 25 Jan 2025 11:33:34 -0500
X-MC-Unique: f_ql735INHis5QYSKpzfNQ-1
X-Mimecast-MFC-AGG-ID: f_ql735INHis5QYSKpzfNQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b864496708so802371885a.2
        for <linux-nfs@vger.kernel.org>; Sat, 25 Jan 2025 08:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737822812; x=1738427612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jd1ArQEeAhgz0wTwpfi9Lt9GxJ2QkLgY2aY+vGiSFZ4=;
        b=oOIyxsKlAstgPOEV6hm5Yzj6YU421MxXq8kNvoaVS6zjCRQknbQdfRi6jLn2y3Tc4F
         0NjVhKOeksgM0Xkp1J9mKmUrQwtsZzl/mPg0SH6v8GnZ8J917SUOb9U08Yb6zgZxey3N
         kmmmkpanGhQ1xHnWxS/dZ40DolllpN1ffD6j8kDpMDxpbwwxkshP9YJLl1HqX48cCrOy
         5hd9SuY3CsTJxI0zb7dC399tPBUQ9ZePLFR4XjW4i76G0JPG+Ubtt21nhgrIPRyochft
         IZgI+5ThNlx0Ddgxkc9p/85jBhINxqwzhTsIN7pOWTz7kpweMj4JbHbsV+6nUYkSjZSg
         8s/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA8L/tx4hXXtbgXmKOadiA2I2wIdj/a/K5NKjUZ3k9i8MMiOuxWdiL2ewMtryhpNpWdE0h/iNpW5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVPH9ScW93zRjw7xJlo5QlK10RMbKi/0Hh5Zhgt9jyVYx0SGJ
	deDRmDc+ISef+AVIUS5eB20DwkMDeZII1DVts9u/4rnNOz5w9VqsW6OPBvxqkEVUr8LLvFKOwKA
	29hl+o2P1rld+4I1NcxEeyPsnSF6GVR7R2uYqnl4GF9h/xg+jJ4vbGgZeIPL7D5oHlQ==
X-Gm-Gg: ASbGncuJgM+TRWNSiNiJq0IR+nsKx5Xx9XN5l6mwfQ0xaHQoGtOdaBSkcP7EB/xnWiW
	oAS1DDIzbPWxc+SS1sNtLAhcrDWuXMlVA3GvXXHe9c0FXlxPgWtzqOXT3R3hUppc0+CxruNymP2
	ogQTV4cD5QTwWCjZqURtYWPL2D0ncs6ZF2/7VvA+38khyK7pwU6JfwDZjyK6UQuLpaOv+8em+Na
	g/QSiU+9BtVl2Ah+jdnH+ZCx2scqu0WlSRJt/174npFU2htOFusJEy2UbBHfzaJystZPolTW1yJ
	gCql
X-Received: by 2002:a05:620a:1a03:b0:7b7:142d:53c9 with SMTP id af79cd13be357-7be6325de33mr4766934785a.53.1737822812732;
        Sat, 25 Jan 2025 08:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqLK68KmZfWYEdxHtlOhTAQmnCYwSRB1t6tlcqjc1QYtlO6nx4HdI0VR1mZEE+XZ3q9kfevA==
X-Received: by 2002:a05:620a:1a03:b0:7b7:142d:53c9 with SMTP id af79cd13be357-7be6325de33mr4766932585a.53.1737822812441;
        Sat, 25 Jan 2025 08:33:32 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8be35sm209589085a.46.2025.01.25.08.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 08:33:31 -0800 (PST)
Message-ID: <1f15ce79-acd7-4bb1-9982-2da66fab18a0@redhat.com>
Date: Sat, 25 Jan 2025 11:33:30 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v3 0/7] rpcctl: Flake8 cleanups
To: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250115202957.113352-1-anna@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250115202957.113352-1-anna@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/25 3:29 PM, Anna Schumaker wrote:
> From: Anna Schumaker <anna.schumaker@oracle.com>
> 
> Apologies for the noise. I just realized I gave the wrong range to `git
> format-patch`, and accidentally resent somebody else's patch that has
> already been merged.
> 
> This is a series of cleanups for rpcctl.py to fix up various style
> issues after running `flake8` on the code.
> 
> Thoughts?
> Anna
> 
> 
> Anna Schumaker (7):
>    rpcctl: Fix flake8 whitespace errors
>    rpcctl: Fix flake8 line-too-long errors
>    rpcctl: Fix flake8 bare exception error
>    rpcctl: Fix flake8 ambiguous-variable-name error
>    rpcctl: Add missing docstrings to the Xprt class
>    rpcctl: Add missing docstrings to the XprtSwitch class
>    rpcctl: Add remaining missing docstrings
> 
>   tools/rpcctl/rpcctl.py | 107 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 80 insertions(+), 27 deletions(-)
> 
Committed... (tag: nfs-utils-2-8-3-rc4)

steved.



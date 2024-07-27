Return-Path: <linux-nfs+bounces-5087-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247BC93E00A
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45A928237E
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A29183081;
	Sat, 27 Jul 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMr+r+Pp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03C18306E
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095986; cv=none; b=UYl1ZtRIiqzD/ixIOD3udBm7cKOzVPVwoDh0VEWWRp40eZsaJIO0wqUIH5GTgTwY2bxUjbdy9VfcHd/iC34EF1Xo8wQWKmFDEJo+ygdX3SKRzZf7VzTvJVYudnP5exNlHST77k+ADcEH+a+GdpEn4FLsqi0sIsfAaoXhQNzhKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095986; c=relaxed/simple;
	bh=xLrx1OJ1lgcWq7GAnUR39PxILn/dm4AHOVjXUlJ7eKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XtPRWZommR/MhBiL8YUZNw1la4EaoQgp0PbACwqRIu3utG0wPgnW2EuGQavc8YE/gzmPJJjNPqIZCM1Wlw1TJa/+uHZiRPKa89B1fLNKf83//REV9bk6wBsbaxWa4/RQE7YehvLpof4Li/FGr3Ca6+K5d6zTTWrVyo3pI0RZG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMr+r+Pp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722095983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENAHWpImkf9AdX6AhPCf0Z2e9wi8xThW6/MDd3tw3I=;
	b=LMr+r+Pp034oVI7XvvaejqWJzNU4ghrYxEA2LaK8OTa53v88YJlA+eoIsa2dnBOqI+kTN4
	kqBGlvytpAxOzxzUOGSrifbcDqvKR1BBzZBZLQ3+5qPY5pqvgpElBumkPLc0gIYr+l/6EI
	jzqnt0hiTzUCdeWv+gTUhQq8BUX0GHc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-X3YAcpHCNii3HnDNPEzmRw-1; Sat, 27 Jul 2024 11:59:41 -0400
X-MC-Unique: X3YAcpHCNii3HnDNPEzmRw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-45009e27b83so1855981cf.1
        for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 08:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722095980; x=1722700780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ENAHWpImkf9AdX6AhPCf0Z2e9wi8xThW6/MDd3tw3I=;
        b=wSv/uKhDYR6ScY/Z1ELER/Ft06pKwrrxHrovvzLv+SK2POB6t+OZGg/S0SIDZ5cEgB
         IDTlZj15q8Qv3tuoSUF9Y69q0gwElGJ5Q2BK5m24xxOA8TO8adOKd7qmQON9diYgXxu4
         E1zdlfE0slCW62KIhqWIbiI0dF4WoIDJQUzRZnTOYeTNiYnAO4t5xcexSmoz1KB2Rhes
         jDNScCKFKn02sK4rfAegVsEuN7Vs2jn92R06lezlFoPm3K+5Bt5dENP3WZ8h0OeKlCX4
         lo27MCbfML0uFlaAT22MkX4yB94byf/uszfoaLhw8YXMPf/2u2vNUXVK2YVHFS33p4gE
         XnKA==
X-Forwarded-Encrypted: i=1; AJvYcCWd/HgTttFzZBV+lrpBpHc3w2B9XHEXZSnhkNO0rrY83Z63QmiLvkkwImYOTXHoWH6Sv/e9A7BQ8EtZ8gqUwbfbIB0fRm9J1yvR
X-Gm-Message-State: AOJu0YyyZdwfj8Nb6lamCs9aUkaYYlxq/11ReGEcXwlivGgelfUepnFu
	JsVEd+gHZaUY+MrqfOR1fcTk3Ok+UZ5bqWK1sPh8Grf91ON43b+YYrf0N3pDXNo4F7RCG9vYVCa
	Ohkf6drXSf8lrlrcwFTH35QGS5izcz2M8G8YTqx0YP+xATTxKCtBCbK9Glntbcn3ztw==
X-Received: by 2002:a05:620a:44d0:b0:79f:44d:2b8a with SMTP id af79cd13be357-7a1d696513emr696293285a.5.1722095980155;
        Sat, 27 Jul 2024 08:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRE1OORygI0Gjf8ocdNrH8RrMCaCr5nMyqL3cKKsV0wrJHGh+nfht6geyL6SK7XAWuxovMcg==
X-Received: by 2002:a05:620a:44d0:b0:79f:44d:2b8a with SMTP id af79cd13be357-7a1d696513emr696292485a.5.1722095979777;
        Sat, 27 Jul 2024 08:59:39 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ed3bcsm314457685a.66.2024.07.27.08.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 08:59:39 -0700 (PDT)
Message-ID: <fbee4a4d-fb1f-4dc6-a5d1-bb2d476a22a7@redhat.com>
Date: Sat, 27 Jul 2024 11:59:38 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch for small typo in nfsmount.conf
To: Matthew Comben <matthew@dockstudios.co.uk>, linux-nfs@vger.kernel.org
References: <CAJw_U8fKkq25Ft_82MasFA2WQLHh4Vv+8af7DfHFbH6R0KmF1w@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAJw_U8fKkq25Ft_82MasFA2WQLHh4Vv+8af7DfHFbH6R0KmF1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/24 5:14 AM, Matthew Comben wrote:
> Dear NFS maintainers,
> 
> I found this small typo (and appreciate it may seem like a waste of your 
> time). But I've prepared a patch to correct (as I currently interpret 
> the comment), if you are interested in it :)
> 
> Apologies in advance if I have prepared this patch incorrectly - I did 
> no see any specific information in the "about" of 
> https://git.kernel.org/pub/scm/linux/kernel/git/rw/nfs-utils.git/about 
> <https://git.kernel.org/pub/scm/linux/kernel/git/rw/nfs-utils.git/about>
> 
> Many thanks
> Matt
Committed...

steved.



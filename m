Return-Path: <linux-nfs+bounces-9889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEECEA29CF0
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B1E3A861C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F6321772B;
	Wed,  5 Feb 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7IJhA7I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A01DD526
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796009; cv=none; b=gZWS0LeIsUTDwcmb/wQcsI6+E+EwFa0ifEOinHx+8tdIwtNsokAd68md9MbPWCNheu97YhTcWLyL0xSQJiBANixD4hIux+SeyytI0+s42KUoVAggmCpBjLfUkOPKfKvuKLz6C+xlW8gWsosWSeqEoEJLMJaQUE1+n3Bp3ixmyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796009; c=relaxed/simple;
	bh=mtDpfiVo4tTjylot6OS7Ks/3ddPyFsUwYn/UAEx63vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/nuOh/cOcENkExj5jEGrwbXuCSb00lb4Oc+V/gRKjwVP/26d8JzR9G2tqC+FUdqpv+temDclmwGkjepIS0kHclXGJOB12s7Ijbw3p+DZuFbJijqEVe3VCBMgmC00HcRWdef8kQV+6oGr4TpZzj0u88QkS9HZ2nYeZmjV5BY4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7IJhA7I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738796006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okf+fjYrtjoS/qwV6U7aSDZ7id+MsBcC+hJk5BMNvuQ=;
	b=N7IJhA7IVEYUdi9plDalTBeb3k6hu9K/hwMddt33zRApoWH8wU/PeAHIWo03+IC2+cDxbN
	kxMcscHyRPIAZjAXj9aNnLZUrQmoDMnlh9b2pQStwq9GTEMEzpQ+2TIQKQMGSrWCJjgxYm
	4VZ8SxR9rI7vE75fPVeV+p94KvQvF/k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-NQFv1m9CPxOtoc18njUrIQ-1; Wed, 05 Feb 2025 17:53:25 -0500
X-MC-Unique: NQFv1m9CPxOtoc18njUrIQ-1
X-Mimecast-MFC-AGG-ID: NQFv1m9CPxOtoc18njUrIQ
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e7f0735aso45064685a.1
        for <linux-nfs@vger.kernel.org>; Wed, 05 Feb 2025 14:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738796005; x=1739400805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okf+fjYrtjoS/qwV6U7aSDZ7id+MsBcC+hJk5BMNvuQ=;
        b=itnCIPAzV5AH6q6xlHmpZZd6AiuXUhIYQ/ysSa4g2hAVzAfTZtwjcj6IpV1d3qbXU7
         eQ8PwewA6DyI0dbgXy1lO7SqkSL/RSeks9i/6G4Ma6bUidenidvevcdJk+fTBoXtWHoO
         fjvKcrZGF7nfas+RZ1Kyvx9q3jJWR5QSK+eBUElGdux29TA0ZGIvPY2VFTDXe8pwgfgw
         +P4raimz3EEJ8OgfpPna4tuN7cPjl3jrT5XT+SIpmki3Z/XdS+iNQx5d1YTZhVYLZsyB
         yczl8WEDMbWzniH8Gl1ctQZK6kssnPHJWwYs+S9QpVhMOSSuSBHXxNxd5JcIMpuSv4vG
         DqOA==
X-Forwarded-Encrypted: i=1; AJvYcCVCvEZjl6NbtN+0PydLOotfmDYuWpRutdg3yKga7cCPHKs6OisZo0g2FCHU8oVzbG710fE8TPCth7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEE/3BmYSivbcHxu2G9+bIEUp5wpAzlR99ZcW6Nlsil98gsqmb
	VLjS1SFubafXYaEiSxR7ePTFxkF6AplyVtOdleHYX6pPdpLbnATWnorPskhbsxYBG3AWQrwddFi
	nkTbDNHxkFcl0UPItaa6OXO2XxsnLMgu+L4kplg0dfx2BmcijvLkyzL7ZyA==
X-Gm-Gg: ASbGncttCHu1+b8h4JqtzOzqSYYLr0dItzNd+popuvFV6wJNQ3tFyiuqc9MG+uuqNMT
	XhMRc3B+Dvvf8dVryNYfmLSr/KyJhQTgnANzc1BgmTirFyAyx0xtvr7WlRHJxIh9Deo0XmUDNcd
	ykAM/s7Uwh6lguTL+CWX5IicHI0qoNhVoA/qnExRmZWZGhoe2Ag7ZfnHVFOb1fCx5GkMl9g5Xfx
	BZWh48vMscwJCOgrdt+gd9EUswlz2Y+892KqzBEkQPMeoEDzAS37bP4pDqzCtgBj6J5eTx7dql9
	zOTA2g==
X-Received: by 2002:a05:620a:278e:b0:7b6:e8c3:4b60 with SMTP id af79cd13be357-7c039fc3ef0mr576874485a.28.1738796004838;
        Wed, 05 Feb 2025 14:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEubxBAgIdalzdDotzSe6k/lUZIsr3AB9y5F9NG+G0glWQCXjp7meSligR2YJMTh7oe15jb0w==
X-Received: by 2002:a05:620a:278e:b0:7b6:e8c3:4b60 with SMTP id af79cd13be357-7c039fc3ef0mr576872785a.28.1738796004544;
        Wed, 05 Feb 2025 14:53:24 -0800 (PST)
Received: from [172.31.1.150] ([70.105.251.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d05ddsm797018885a.39.2025.02.05.14.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:53:23 -0800 (PST)
Message-ID: <00dac34a-5123-4d65-ba4c-c5df481b69ef@redhat.com>
Date: Wed, 5 Feb 2025 17:53:23 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH 0/8] mountstats/nfsiostat: bugfixes for iostat
To: Frank Sorenson <sorenson@redhat.com>, linux-nfs@vger.kernel.org
Cc: chuck.lever@oracle.com
References: <20250130142008.3600334-1-sorenson@redhat.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20250130142008.3600334-1-sorenson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/30/25 9:19 AM, Frank Sorenson wrote:
> This patchset is intended to fix several bugs in nfsiostat and
> 'mountstats iostat', in particular when an <interval> is specified.
> 
> Specifically, the patches address the following issues when printing
> multiple times:
> 
> * both nfsiostat and 'mountstats iostat':
>     - if <count> is also specified, the scripts sleep an additional
>       <interval> after printing <count> times, and parse mountstats
>       unnecessarily before checking the <count>
> 
>     - if no nfs mounts are present when printing, the scripts output
>       a message that there are no nfs mounts, and exit immediately.
> 
>       However, if multiple intervals are indicated, it makes more sense
>       to output the message and sleep until the next iteration; there
>       may be nfs mounts the next time through.
> 
>     - if mountpoints are specified on the command-line, but are not
>       present during an iteration, the scripts crash.
> 
> 
>   * 'mountstats iostat':
>     - if an nfs filesystem is unmounted between iterations, the
>       script will crash attempting to reference the non-existent
>       mountpoint in the new mountstats file (or if another filesystem
>       type is mounted at that location, will instead crash while
>       comparing old and new stats)
> 
>     - new nfs mounts are not detected
> 
> 
>   * nfsiostat:
>     - if a new nfs filesystem is mounted between iterations, the
>       script will crash attempting to reference the non-existent
>       mountpoint in the old mountstats file
> 
>     - if a mountpoint is specified on the command-line, but topmost
>       mount there is not nfs, the script crashes while trying to
>       compare old and new stats
> 
> 
> To address these issues, the patches do the following:
>   * when printing diff stats from previous iteration:
>     - verify that a device exists in the old mountstats before referencing it
>     - verify that both old and new fstypes are the same
> 
>   * when filtering the current mountstats file:
>     - verify the device exists in the mountstats file before referencing it
>     - filter the list of nfs mountpoints each iostat iteration
> 
>   * check for empty device list and output the 'No NFS mount points found'
>      message, but don't immediately exit the script
> 
>   * merge the infinite loop and counted loop, and (for the counted loop)
>      decrement and check the count before sleeping and parsing the mountstats
>      file
> 
> 
> Frank Sorenson (8):
>    mountstats/nfsiostat: add a function to return the fstype
>    mountstats: when printing iostats, verify that old and new types are
>      the same
>    nfsiostat: mirror how mountstats iostat prints the stats
>    nfsiostat: fix crash when filtering mountstats after unmount
>    nfsiostat: make comment explain mount/unmount more broadly
>    mountstats: filter for nfs mounts in a function, each iostat iteration
>    mountstats/nfsiostat: Move the checks for empty mountpoint list into
>      the print function
>    mountstats/nfsiostat: merge and rework the infinite and counted loops
> 
>   tools/mountstats/mountstats.py | 102 ++++++++++++++++--------------
>   tools/nfs-iostat/nfs-iostat.py | 110 +++++++++++++--------------------
>   2 files changed, 100 insertions(+), 112 deletions(-)
> 
Frank... nice work... but I hate to break the news... with all
these changes... You now own these commands! :-) Just ask mrchuck ;-)

Committed... (tag nfs-utils-2-8-3-rc5)

steved.



Return-Path: <linux-nfs+bounces-11495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C16AAC6D4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07CF16842A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB01A08DB;
	Tue,  6 May 2025 13:45:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95AF208CA
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539133; cv=none; b=KNbGOf0cReoMsLv9wubjsNv90nn91GRBbAHwtnLByqCgwpsfaGBaWmUHOpdDBTZiOh8VpqDfjkuAINBrD0eZdCVeymSwGHN5d39zMDe0yL5+Ld4iUDPFay1R4wGKhnFyEl5E0UxFCs4MurGXfkgCE3Bqiu5w4pjG322nbGnlGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539133; c=relaxed/simple;
	bh=5d91hPFNOGQ9r9iAnKQeabWsS9zjnW2tGW2Ihj55CTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiqiudB7q+YAAPPDLgDfrSsCLtU05zfL5egwHfrj9fXIRrw0qNb1B5mPUnxExv0FaIAAW/2p8WTLRdCvDEvAxGtbRvigJs00QcqoKTdJAREJA9XUptKbm8jHNlujKmsMWFh5bivQ/x6ZtWt+ut2k1/cYn9EPT0WNkZWPPzoVjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso5294735e9.0
        for <linux-nfs@vger.kernel.org>; Tue, 06 May 2025 06:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539130; x=1747143930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5d91hPFNOGQ9r9iAnKQeabWsS9zjnW2tGW2Ihj55CTs=;
        b=dOQjG4uo+tnkQ11kRNvMt3Ywjvb3KH/UcF5Y2Wzw3NnLqipunguKw07B3hVB11glfK
         r/SUf8bsd/WUuvApJI78AFmJSIXC8p2GREM6N8BUWnuNn8O1vthgb6obueNkltzgCM67
         BHDQYCLIJI7LWWA6QGPXf8NvsL6aQqszVvunlkA6l0A0GK4HA+GF/CFzn9H2oFP74bOS
         cIfg9J5SK7B4ss9bk6AOTMlhk/M6I5rymchqeRLvdxOW1cfRIokzrPBMJ0Uu85ytK+2o
         GNaJz4/YKidMuUlWNIRtDDjnzTAXqBrdJ5hdy5yWZDn5XYtLMmxRGhE9GpnGUi2WKJ8j
         oqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfUhqSZQgWq3UcdW7luT9bdMypnXJcq/0monaeKT8hEqcIO3u4ltlrx1QcfK4+WDbisPye15hJoWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iO1n6SPLBxfOgiIchgDW7x4czQbaJZWxJrOkBH5mOqI+9/Xu
	V5IvyL/hdMI7PMfvvY2ul0klWh3JFn8AzN8wPxBgk0WXVsT/Ksjn
X-Gm-Gg: ASbGncu/2IHjuaVtgi2e3xdPQFyhO6/dvipJNrTep1GQ5tZ2Wc+MFAPAGDscCTJKpjG
	jD4kqmwI7vwCBFQCOHnnkCPkJpc66f8Gc+dgBYXsMPEKgUq4gvVmR0VhCvrak1GQcbNrMnWgiha
	0jgcv0Swdy+5mBrZhypZl2ayOzQAuomwhh7gGK9pY+6iWNMOr6bcPA+WxxnfuDdlndwM+Ee0Y2m
	3Ub4W5msFFMaXrcbCs7wGEX9BHeMW+49XZzZLyVKr5ORl8t3kJ+L7T29K+UEE91HU5LkwvG4K1J
	P4weO42HVNpH8XnBY+4uDuQKeFP++77fC/uZhrWapHxetLwSD/kFJ5S0S1yfN2SCK50VmgWlLWC
	w+fL0nw==
X-Google-Smtp-Source: AGHT+IFWFNz94/g/IqRmYhuxXU/E8msUnuYc44Mq6FgL0Dxma10PdhwnRIkc1hlloboDn1Z/xlLEDQ==
X-Received: by 2002:a05:600c:1d1f:b0:43d:fa59:af98 with SMTP id 5b1f17b1804b1-441d10155b7mr22628835e9.33.1746539129655;
        Tue, 06 May 2025 06:45:29 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af32a0sm219928115e9.23.2025.05.06.06.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:45:29 -0700 (PDT)
Message-ID: <b4e7bbbb-0ea2-4fda-890a-e0ba0ec48d2d@grimberg.me>
Date: Tue, 6 May 2025 16:45:28 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET
 when timestamps are delegated
To: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Anna Schumaker <Anna.Schumaker@netapp.com>
References: <20250425124919.1727838-1-sagi@grimberg.me>
 <9489779a-e094-48fe-860f-7181f5d41223@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9489779a-e094-48fe-860f-7181f5d41223@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/05/2025 16:25, Chuck Lever wrote:
> On 4/25/25 8:49 AM, Sagi Grimberg wrote:
>> nfs_setattr will flush all pending writes before updating a file time
>> attributes. However when the client holds delegated timestamps, it can
>> update its timestamps locally as it is the authority for the file
>> times attributes. The client will later set the file attributes by
>> adding a setattr to the delegreturn compound updating the server time
>> attributes.
>>
>> Fix nfs_setattr to avoid flushing pending writes when the file time
>> attributes are delegated and the mtime/atime are set to a fixed
>> timestamp (ATTR_[MODIFY|ACCESS]_SET. Also, when sending the setattr
>> procedure over the wire, we need to clear the correct attribute bits
>> from the bitmask.
>>
>> I was able to measure a noticable speedup when measuring untar performance.
>> Test: $ time tar xzf ~/dir.tgz
>> Baseline: 1m13.072s
>> Patched: 0m49.038s
>>
>> Which is more than 30% latency improvement.
> That's significant. Next step is to ensure this doesn't cause any
> functional regressions. Have you run fstests ?

I have not. But I will. Please note the comment under the '---' separator.
This only make a difference if nfsd grants the client a space_limit with
the write deleg. Without it, untar is still very much synchronous.

>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Tested this on a vm in my laptop against chuck nfsd-testing which
>> grants write delegs for write-only opens, plus another small modparam
>> that also adds a space_limit to the delegation.




Return-Path: <linux-nfs+bounces-17794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A827AD19527
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 15:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840A53032721
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C68E34575A;
	Tue, 13 Jan 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7mdN2zO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37A18B0A
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313313; cv=none; b=PCx0OBe9TwVnMRIqyIGH0q4RzJda74Pj3Byno4iOL99lgABlbSCeL8YwOkUp4akzBenHY0Fls76Q5AUho+UWFCLI44Yf6UzDwFtCQ55+CU9ytFBSBGg5eSlYF/DhmnAfUOwBC/+w+e5EROmrY1vqHfFeFxuOeyGxqpN7p55zreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313313; c=relaxed/simple;
	bh=VRAEU4jmPpdQ/OyJ3JcgE27wHzo6eVHdO+9pCMdE5ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ia3f+9qLvUqOvPFI2ULrxduf9Hmgk2StPEsoTZzUsqs0TcIl508arEYZyTORfO+T1Ku0iFebRs+Fv5V4Mu2xjE2fe+de2ahFywqItL7UGtR8UAFEmIqO5OGacy8JsuX8OuU+O4oW9JmRfJ8G/03x77mKPGJUAm7QDec4TtdPaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7mdN2zO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182E9C116C6;
	Tue, 13 Jan 2026 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768313312;
	bh=VRAEU4jmPpdQ/OyJ3JcgE27wHzo6eVHdO+9pCMdE5ZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L7mdN2zOGe0UK9VZqSrCaXc/C6qkpUZC27kZsv3kxvBLMNVc4adhUK4nQBbiotEQq
	 gMa0IibslG0YBL18Wippf5Ar4Dq/bTSw7Obx/ZsCRNpJKsaL1ZOeuXf+a1NoLxRsZW
	 G72kfUOsIwGu5Ap76P6B6BZsEdkMTLjbZnSstha3xJctU/XICybVLrIeT+63qAjMaQ
	 h9XcsRB61Nj0/kD5MRtuGQALRT/hul2nbw27u0nxZftY21FKRwa1FejTz4erH+Q2tg
	 8L4HAfX2jze2ay4jqUfpuyjl5C7h1loNcei4c8tJ1RR7xWrCKNbxC/HRtBy6l2K9RI
	 tvTl6jgk8Igiw==
Message-ID: <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
Date: Tue, 13 Jan 2026 09:08:25 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 6:51 AM, Benjamin Coddington wrote:
> Hi Chuck - I'm back working on this, hoping you'll advise:
> 
> On 29 Dec 2025, at 8:23, Benjamin Coddington wrote:
> 
>> On 28 Dec 2025, at 12:09, Chuck Lever wrote:
>>
>>> Hi Ben -
>>>
>>> Thanks for getting this started.
>>
>> Hi Chuck,
>>
>> Thanks for all the advice here - I'll do my best to fix things up in the
>> next version, and I'll respond to a few things inline here:
>>
> ...
> 
>>> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
>>> is really an RPC layer object. I know we still have some NFSD-specific
>>> fields in there, but those are really technical debt.
>>
>> Doh, ok - good to know.  How would you recommend I approach creating
>> per-thread objects?
> 
> Though the svc_rqst is an RPC object, it's really the only place for
> marshaling per-thread objects.  I coould use a static xarray for the buffers,
> but freeing them still needs some connection to the RPC layer.  Would you
> object to adding a function pointer to svc_rqst that can be called from
> svc_exit_thread?
Forgive me, but at this point I don't recall what you're tracking per
thread and whether it makes sense to do per-thread tracking. Can you
summarize? What problem are you trying to solve?


-- 
Chuck Lever


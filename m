Return-Path: <linux-nfs+bounces-17614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A64D03CB8
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40D45306BC96
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFA4508342;
	Thu,  8 Jan 2026 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTaUP8Az"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7A50833A;
	Thu,  8 Jan 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882358; cv=none; b=uPoZiomsEZDajo0suye3kRjZKptPKozKuYfDs8O+58o9f6ATFjjjoZ0YFLsNxcA/lu4WrYDU4veMj3m0/PVY6I9gxwxwDf3y3XWzcpKBgzmo6SCaNpDp8GGfADjl3POmhVq2mCAY/vLHKwK9fLiRxVgrOVJZfoT08c34Ru7C09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882358; c=relaxed/simple;
	bh=NRKSjfeKxnpLmERNVN4nrPDXNns3sLlBpJndOnpYE9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQqgI1b/5RdngOfp1q1x/lLWDkI7IbbtMC+1G/jPZhwE/fCMihdSkcTv4k/kD86V+I0AkpmZptxfWi9dbnZelArMWHAijTNVgLhVg0xlFYJe/SLCoXU0/c2xN3lApIJ6UzWiLZtmTycHaEjDsfDhotvFgVJrn5GZ4KLgRTVDrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTaUP8Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04410C116C6;
	Thu,  8 Jan 2026 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767882358;
	bh=NRKSjfeKxnpLmERNVN4nrPDXNns3sLlBpJndOnpYE9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pTaUP8Az8/EIcpthQlP6N7+Tx5crWVO8KQ1mCD/wRQeDQ/JfIrazkNdJlWe0F1J/j
	 sZLzd4n8+KjUo/dDUFkJSVBRsWWJsA/oC5MQzjoXhIEB0Cvv08d5E+EtReRajuuxdv
	 ZhurRSk3/Mdg/KOdG0nzLXntADgBIE4ZarnO7rtjvXh6U/6XFRbXIUOLfJIbDWcPXo
	 Jg4ezniSL5nxt/lYR2vty8PJqYmY+5c+K3oZyZSPryIuUHfJgETTpUsGDbLMf1yZNl
	 tN+jPOwVzHdXfjyEYgEUwPbkD4z3VS4CIDDekxOPhJpj2EK9+Hk6lUZaAOEMS0E9A+
	 IZPT1KYt6muyA==
Message-ID: <ff54b6fb-6c82-4994-b9ff-715f9645d75c@kernel.org>
Date: Thu, 8 Jan 2026 09:25:57 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 1/4] nfsd: convert to new timestamp accessors
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-nfs@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20260103193854.2954342-1-cel@kernel.org>
 <20260103193854.2954342-2-cel@kernel.org>
 <2026010808-subwoofer-diabetic-e54e@gregkh>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <2026010808-subwoofer-diabetic-e54e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/26 6:03 AM, Greg Kroah-Hartman wrote:
> On Sat, Jan 03, 2026 at 02:38:51PM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> [ Upstream commit 335a7be84b526861f3deb4fdd5d5c2a48cf1feef ]
> 
> I don't see this git id anywhere in Linus's tree, are you sure it is
> correct?
> 
> thanks,
> 
> greg k-h

If I start from the current upstream master, I find this instead:

commit 11fec9b9fb04fd1b3330a3b91ab9dcfa81ad5ad3
Author:     Jeff Layton <jlayton@kernel.org>
AuthorDate: Wed Oct 4 14:52:37 2023 -0400
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Wed Oct 18 14:08:24 2023 +0200

    nfsd: convert to new timestamp accessors

    Convert to using the new inode timestamp accessor functions.

    Signed-off-by: Jeff Layton <jlayton@kernel.org>
    Link:
https://lore.kernel.org/r/20231004185347.80880-50-jlayton@kernel.org
    Signed-off-by: Christian Brauner <brauner@kernel.org>

I picked up 335a7be84b526861f3deb4fdd5d5c2a48cf1feef from an
nfsd-related tag by mistake. Do you want to drop this series and I can
rework it properly?


-- 
Chuck Lever


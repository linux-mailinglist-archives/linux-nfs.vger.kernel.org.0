Return-Path: <linux-nfs+bounces-15566-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49237C01335
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 14:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 311FF4E51DD
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 12:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A2219E8;
	Thu, 23 Oct 2025 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGBMDCNe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402CDF76
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223565; cv=none; b=kgqaamCRl0ZEWtNPNzx+fSwsXh/jyZPit5v37e818PE200X2C8/7OuCoDDEAhK6Fhp9BXTNwTO/5/0N2d6jjKBMD9glwKnABRRjCtjJrVl29ofldZqCsxX7b6Og6Rjl/qCndjzPD28yjPHJCe4k2coM7zr4fc2gdTM8HL5fBX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223565; c=relaxed/simple;
	bh=EJ5Lz6onz47/eyzUTFabrhxDRQOGLqtxG2DqkbPA5lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqpLXWkFYvoKGZcFPFgINZFEVYy6GXh6HSzov2NZeELzLklxArQXdkEtRv1nmD17ohZLLmdXYuqHlUXS9+FGdmBh/w4OlaZ54Jm8uMTarjY2zKHj7f0bt9USQJjYM8rbE3CYuwrwQj+1yxiQ2LtIQMlJP/HwJQSxG8p7+H624Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGBMDCNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95397C4CEF7;
	Thu, 23 Oct 2025 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761223564;
	bh=EJ5Lz6onz47/eyzUTFabrhxDRQOGLqtxG2DqkbPA5lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VGBMDCNea4MqCwKHNcI6SY8S7F9rpAjbb6FdNO+T7RWVtZj+MQFSwcbj+N6EoAS6C
	 ChOHTwtJeEF+ZtaVMpIsiWBgjJFfsVR7PBtigtZtwnXMnnl8fkjaOvOv8rtGZoQjKg
	 4AEFSbqQBu4JbAHZBv92mwcPSLja+9kBp+dEbe67X/O1Prc5NQ8v07E0sjehc/+e9H
	 B4j/LjkOC9soKk2Fp4R1H5F5VH8qo+9leyRjeDhFigTXP050XqsAYDTEXSpvofgiuZ
	 TDSCMPABkSFnQoqkCv5jFj15DGBQudOa1h44/GOjVN9QNk+GCi718CWtVwH80PTE3h
	 6mlKiQ4+/E1fw==
Message-ID: <4a5f32c7-7369-414e-b93f-70804aecc157@kernel.org>
Date: Thu, 23 Oct 2025 08:46:02 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
References: <20251022162237.26727-1-cel@kernel.org>
 <aPnNdLg-tSIH0r5E@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPnNdLg-tSIH0r5E@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:38 AM, Christoph Hellwig wrote:
> On Wed, Oct 22, 2025 at 12:22:37PM -0400, Chuck Lever wrote:
>> -		kiocb.ki_flags |= IOCB_DSYNC;
>> +		kiocb.ki_flags |=
>> +			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
> 
> IOCB_SYNC without IOCB_DSYNC is always wrong, see my reply to the
> previous thread.
> 

I see only one API consumer that sets both: NFS LOCALIO. There are not
enough examples for me to draw any kind of conclusion, and I haven't
found documentation for these flags, fwiw.

But I'll fix this up in the next revision.


-- 
Chuck Lever


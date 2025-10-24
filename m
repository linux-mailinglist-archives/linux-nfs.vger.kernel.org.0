Return-Path: <linux-nfs+bounces-15617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA74C0786F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 19:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41CB14E7AB4
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 17:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166431A9FAC;
	Fri, 24 Oct 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3iiRulA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BB11990A7
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326642; cv=none; b=TvQT3+8356HadpxD5/SaBFl1Al1UgE6sCBrCLvas732eTtKkBw2ZKuEM4FU076/TG0BrA5dprNWub4+9+4d1B5+FHQEHNgiW/TwYHlgrdFB4pglBk8VsZhunqPkv130ponZbF4UiRRTBIkYqbF3PIy6OUicrYw7CE5/wRJKkPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326642; c=relaxed/simple;
	bh=SvEQdU2jSzVE0U5hw2+IuBpjhl5eAN+67daJdCVwPxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4Y3U4t4qoVOp9wFb8ciXUdPzaVdsf1o9o1E3IPyMAKthMy125Lvf12G/KCZxEwrMyNPUhEb+32Nu7QsrUBfxq9hrSU3k3L4JZxUhG43XgWsv19L4w2JpCjF1TOpwhU6hSvdltiMOhD/eHAz2+ELeMB3JEMRaDyuZLL5FiCwIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3iiRulA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04455C4CEF1;
	Fri, 24 Oct 2025 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761326641;
	bh=SvEQdU2jSzVE0U5hw2+IuBpjhl5eAN+67daJdCVwPxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h3iiRulAgr0LvSfL7lgZhX0QJFazO+aSKQuy81xQWnAYjVRm4lDpgJJ2G60LxIiJh
	 Tg8arAygqQZaZ/WqgvcjSmB3qVlwoFdYQrPdKB8Tdwn0lV24K1H6wfqnsUge8lF6Ni
	 /dxMaRGlCBq52rznUMAv0tVMKpUd7q3BSrZWsley3+gYmDSEOtV4z10dqZqV0Q9r0U
	 T3zk6pYm1I2cUQ9j3rCGDrZo7Wif5qLeK/GU2lY5QECeKZFymmfy8QhoXpyjDK2FBr
	 CnD3qf5gkhc2NJpWaxZ/k/ycVUhzmn6b8C3ZOFcun/C81YusTL+LIWPj4nVVRY93fZ
	 vtTTGSeJw5okw==
Message-ID: <711777f3-e3df-426f-a48c-f65b2c6d5aec@kernel.org>
Date: Fri, 24 Oct 2025 13:24:00 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/14] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-5-cel@kernel.org> <aPuzke8ZSpJxHm3v@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPuzke8ZSpJxHm3v@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 1:12 PM, Mike Snitzer wrote:
>> +	/*
>> +	 * Any buffered IO issued here will be misaligned, use
>> +	 * sync IO to ensure it has completed before returning.
>> +	 * Also update @stable_how to avoid need for COMMIT.
>> +	 */
>> +	kiocb->ki_flags |= IOCB_DSYNC;
>> +	*stable_how = NFS_FILE_SYNC;
> Patch 6 really should be folded into this patch, I originally
> submitted my v3 (and you carried it in v4) with both
> IOCB_DSYNC|IOCB_SSYNC being set, see:
> https://lore.kernel.org/linux-nfs/aPAci7O_XK1ljaum@kernel.org/
> 
> If you'd like your comment change and removal of parenthesis factored
> out (to patch 6 or whatever) that's up to you.

I'm thinking of rebasing the series on your v3. I'll figure something
out.


-- 
Chuck Lever


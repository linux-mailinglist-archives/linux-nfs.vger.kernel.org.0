Return-Path: <linux-nfs+bounces-15688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B3C0ED24
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F40F19C45C4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979AA2C0265;
	Mon, 27 Oct 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKTgvQ/q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737142877DE
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577489; cv=none; b=kauIYBHhK7RGwK4KIEuqnP73cl46fjd2L2sHhAiNVAz79mftSN6Qoa6kPokdQ+SOtzPfRz6HjYNUx84wI8jzTOii/c3YheeU1qBcUSfxtcHrf/bieEK9UVO4kQsCfcGXwHjfYWt3VW8gDKiUoHbOWHnyuMxtyd23MQEs96uTJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577489; c=relaxed/simple;
	bh=8e8z5WZvasntUMG4r9AZq2/GYZypyz5m+oe2ELhm1Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GukoIzU6CY8P4a3Y4UhaCR+0HEJCUlXrIfpIwJHUPfVrhldUeGjJHMMzO2zdUEnx480iyr57zr3vJGaOpjeGV7yVpyhjBHQecGtHMjfOAMEMT6xf+w9E81dgJs4CuJ+oPWYOthNhymjt32V2IwbonJLMx+jkSg60j8mHy/vb4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKTgvQ/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FF4C4CEF1;
	Mon, 27 Oct 2025 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761577488;
	bh=8e8z5WZvasntUMG4r9AZq2/GYZypyz5m+oe2ELhm1Ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CKTgvQ/qnTtkkWErGd+G7Z9zkdL1YQuf1NJmHK5K4824zchD6f/v421jU8t1JKX4V
	 FWTUvH3boLp0gIgQVGW1Lxe7F+6N0eKtPWsMcLvy12lCf44S3uwycQkcBvOkxHTU/C
	 wVercQQ0XT53PT5OzqFt6Eww+PIMYhZkTCOzTKT+nsMusJMTxANrNPgW2GVcGBKFhk
	 MPUKPCfUwIbx6oWSbQm4GxlqdfSoDvoOQxGzftbKnnsmgsJqWmKAmbrsDohzHFNIBo
	 crmV/X99uWek/LbiSTJLHUfJJNKo3udApsn5j5rbNs+lWbxs5MyxNO6QF7g6wSi+Tl
	 tnFLqklmecAaw==
Message-ID: <7093445f-604a-4bfd-9104-b9f70138ed07@kernel.org>
Date: Mon, 27 Oct 2025 11:04:47 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
To: Mike Snitzer <snitzer@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org> <aP8n4iqMPie83nYy@infradead.org>
 <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
 <aP9zU_9e2VDw4G7I@infradead.org> <aP-CW5_egXzHS1jz@kernel.org>
 <aP-DYgcrcd2zSzrI@infradead.org> <aP-Ii3DgzEaI5Bw4@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aP-Ii3DgzEaI5Bw4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 10:58 AM, Mike Snitzer wrote:
>>> The current approach of using IOCB_DSYNC|IOCB_SYNC have performed
>>> really well on modern NVMe servers.
>> NVMe does not implement a concept called servers.
> But you're aware that servers have NVMe devices in them.. that's all I
> meant.  All of these NFSD_IO_DIRECT changes have been developed and
> tested in modern servers with 8 NVMe, see:
> https://www.youtube.com/watch?v=tpPFDu9Nuuw
> 
> (NOTE: results covered in this session did _not_ have the benefit
> of NFSD responding to client with NFS_FILE_SYNC to avoid COMMIT, the
> ability to do so was discussed at Bakeathon and was acted on with
> these latest NFSD Direct patchsets).

This is why I suspect that leaving direct writes as UNSTABLE, rather
than promoting them to FILE_SYNC, is probably not going to make much
difference to Jonathan's benchmark results. That's just a guess though.

IOW the memory costs of sticking with UNSTABLE + COMMIT have already
been demonstrated, and it's low.

The v8 of this series will go back to that idea, and if you want, you
can benchmark it again. If it regresses, we can stick with FILE_SYNC.
It's just ones and zeroes, as they say.


-- 
Chuck Lever


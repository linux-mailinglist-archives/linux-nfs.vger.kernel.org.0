Return-Path: <linux-nfs+bounces-15668-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B01C0DFD0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3044F3A3962
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9E2641CA;
	Mon, 27 Oct 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6GFoxEv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9B260585
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571409; cv=none; b=hmCACgfJZ6Pp9ORX5hAgN4pbv94BnuWO+BC3VJ79+psMYgNjxAZ7X3hKZmruBAMHrcFMojVieAiAyz52hsp0bbwPeVwc1ZBOZM00lBjaWxh0BYS3dhD0t3g+7EoufnocyPclGw6BNvyKPWXlSzOzLcDq4HzlSj3W7vnf0CEL7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571409; c=relaxed/simple;
	bh=zf967Hol2zkejukQSjNZdW3pWshfiQNEAeCeaU8a0QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeVYtmpluJGXg4gk7xdLUGWVqitrW7I6916hOwTva8imMiN+Ipeh8I8wyKRwlSK77IOZPkfKReUDxs3q7KHsUP3WGtbc0up+EFGAN9gFAIbNy2cmid+xZwGiax2Y2tP92fvOxmGX/xz9cGKpwjVccVeLpnGv/JAD14B2VgQB1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6GFoxEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FCCC4CEF1;
	Mon, 27 Oct 2025 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761571409;
	bh=zf967Hol2zkejukQSjNZdW3pWshfiQNEAeCeaU8a0QQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W6GFoxEv66VH50SeewNfDMhe3AoitYA3v77gv7D/J6OckKMPH62Z2/a4/F6L2+nSK
	 9yRzfwd44G6vm43wDho9LAWL63itZMIkhtGzvFgxva7435W2cCYJq1rsvnEsyNurx1
	 YiDjmjejkUgu5tTsj6zNMbknoOVes7T+uDh26Tc5fv0FdswBZh8SjmlDuKzhwG64mo
	 ITAyWm32CR8rh1GXYXtsQnhyfvmyRVWSRXF9ybUB9+VAscU0GMvGUVAKqP/GDNzIJj
	 o3rOqOJiXIe6uKOuemFzin26I3ft5xxgn5CylVbbtD24631+/rcwi1V9c0xgvIJP47
	 5xQZ86zQpMe+w==
Message-ID: <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
Date: Mon, 27 Oct 2025 09:23:27 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org> <aP8n4iqMPie83nYy@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aP8n4iqMPie83nYy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 4:05 AM, Christoph Hellwig wrote:
> On Fri, Oct 24, 2025 at 10:42:57AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Clean up: The helpers in the nfsd_direct_write() code path don't set
>> stable_how to anything else but NFS_FILE_SYNC. All data writes in
>> this code path result in immediately durability.
> 
> No doubting the statement of fact for the current patch set, but this
> is probably a bad idea.  Direct I/O still has to flush caches on devices
> with a volatile write cache (aka consumer grade SSDs), and it still has
> to commit a transaction to record metadata changes for most writes.
> Being able to batch these in a commit is a good idea even for direct
> I/O.
> 

Promoting all NFSD_IO_DIRECT writes to FILE_SYNC was my idea, based on
the assumption that IOCB_DIRECT writes to local file systems left
nothing to be done by a later commit. My assumption is based on the
behavior of O_DIRECT on NFS files.

If that assumption is not true, then I agree there is no technical
reason to promote NFSD_IO_DIRECT writes to FILE_SYNC, and I can remove
that built-in assumption for v8 of this series.


-- 
Chuck Lever


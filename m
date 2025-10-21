Return-Path: <linux-nfs+bounces-15461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1232BF6EB9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1493A9716
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26733337BB1;
	Tue, 21 Oct 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR4QFUmQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1C2877C3
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054792; cv=none; b=I0rN5A9BIlEWkxrdFMrCcUkImpuvy+ydospEb1kwITTTdI0amshk0Bz6/4xwsR/53rP/QtVOOgvptsr/1oXLPiTvPaQ7pIqdN6HTRRIV843Cd3r+79LjXAOIvFshiYvMKSa0XbPsI4dfbG3y0NG9OGAfGdYIY1iA6OQBSMtCYeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054792; c=relaxed/simple;
	bh=0EUZvL5TAI9HLTX4btbNzBgj2ufF8wvSF3oKyp51WWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2IHS9xIv9okc9GJHcAfkzxbkEOmCw64TjpMdYnGwt57WsX1HfuoD+YUC3H5gt7TaHGg+GxrCKR+QqUsz9y1Xnfxta5A8ljterB6mxwfi8MQovBvcjOBVyMM/zre9U5wtzlg/zb+/HW1tGCE0ii44ZI5nzB9tlI5iS6u5nBLRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR4QFUmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1267C4CEF5;
	Tue, 21 Oct 2025 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761054791;
	bh=0EUZvL5TAI9HLTX4btbNzBgj2ufF8wvSF3oKyp51WWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fR4QFUmQEKY4JBgKRy7q4wBQU3mLd2OPHvLWn0zefkkktx9AAl2lA8L+4lyygiWy7
	 R8YBuhadVs6NP2KRcavTS/J/osE3V2fjIk1spgjjane4qt5bmPES63HQ5rCxgf9jYv
	 NYFJO5txMbGKYKwjCsoh+/bUHTK1vx8g8h10Cq5bpA9MJrj7cC721KaHlUhMpavboH
	 Q6DWq0l6i84YgfSKh3jDq2R6u2XhcYZyItqTSTeOM1yKgo9bO4/V5qL7tFyaXsQnSu
	 gfADFd/4JaeByNRAt2xzKADCjIm4yYY3jq79DeSuSMhzjiuMGm5+ctNNHyDdYthdGE
	 iewqn6YWJjCBQ==
Message-ID: <4037c7c7-8613-4cbb-b54f-a4b4defb75dd@kernel.org>
Date: Tue, 21 Oct 2025 09:53:10 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20251020162546.5066-1-cel@kernel.org>
 <aPZkYqyFZ4SGnMbF@kernel.org>
 <c5e0409a-5fce-4adc-bdd4-584a7c384c95@kernel.org>
 <1ddb2a85a04320f6b8db6b2436ff63852dcfbbc9.camel@kernel.org>
 <4a2ab6a7-9af5-4d86-9b54-34a4f4a9682d@kernel.org>
 <69a5c24ebe6ce9eab9fb5f6f3a6b4d74fc6597d1.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <69a5c24ebe6ce9eab9fb5f6f3a6b4d74fc6597d1.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 9:45 AM, Jeff Layton wrote:
> On Tue, 2025-10-21 at 09:35 -0400, Chuck Lever wrote:
>> On 10/21/25 7:12 AM, Jeff Layton wrote:
>>> On Mon, 2025-10-20 at 12:44 -0400, Chuck Lever wrote:
>>>> On 10/20/25 12:33 PM, Mike Snitzer wrote:
>>>>> On Mon, Oct 20, 2025 at 12:25:42PM -0400, Chuck Lever wrote:
>>>>> Just a bit concerned about removing IOCB_SYNC in that
>>>>> we're altering stable_how to be NFS_FILE_SYNC.
>>>> Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") introduces
>>>> the first use of IOCB_ flags in NFSD's write path, and it uses
>>>> IOCB_DSYNC. The patch has Reviewed-by's from Christoph, Neil, and
>>>> Jeff.
>>>>
>>>> Should we be concerned that IOCB_DSYNC does not persist time stamp
>>>> changes that might be lost during an unplanned server boot?
>>>>
>>>> As a reminder to the thread, Section 3.3.7 of RFC 1813 says:
>>>>
>>>>          If stable is FILE_SYNC, the server must commit the data
>>>>          written plus all file system metadata to stable storage
>>>>          before returning results.
>>>>
>>>> The text is a bit blurry about whether "file system metadata" means
>>>> all of the outstanding metadata changes for every file, or just the
>>>> metadata changes for the target file handle.
>>>>
>>>> NFSD has historically treated DATA_SYNC and FILE_SYNC identically,
>>>> as the Linux NFS client does not use DATA_SYNC (IIRC).
>>>>
>>>
>>> Surely it just meant for the one file.
>>
>> Well yes that is the traditional understanding. I'm merely pointing out
>> that the actual text is not quite as specific as what we've come to
>> understand.
>>
>>
>>> FILE_SYNC is only applicable to
>>> WRITE/COMMIT operations and those only deal with a single file at a
>>> time.
>>
>> True but you may recall that NFSD's COMMIT used to ignore the range
>> arguments and flush the whole file. Some file systems used to flush
>> all dirty data in this case, IIRC.
>>
>> There's always been a bit of a mismatch between the spec and what NFSD
>> has implemented.
>>
>>
>>> If the client gets back FILE_SYNC on a write, it should _not_
>>> assume that all outstanding dirty data to all files has been sync'ed.
>>
>> Agreed.
>>
>> But back to Mike's point.
>>
>> - The spec says NFS_DATA_SYNC means persist file data.
>>
>> - The spec says NFS_FILE_SYNC means persist file data and file
>>   attributes.
>>
>> - After consulting with the section describing COMMIT, I think that
>>   COMMIT is supposed to persist both file data and attributes.
>>
>> And my reading of the code in fs/nfsd/vfs.c is that NFSD does the
>> equivalent of NFS_DATA_SYNC in all of these cases, and has done for
>> as long as I cared to chase the commit log.
>>
>> Moveover, commit 3f3503adb332 did not introduce this behavior.
>>
>> Previous to that commit, nfsd_vfs_write() passed RWF_SYNC to
>> vfs_iter_write(). This API uses kiocb_set_rw_flags() to convert the RWF
>> flag into an IOCB flag. kiocb_set_rw_flags does this:
>>
>>         kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
>>         if (flags & RWF_SYNC)
>>                 kiocb_flags |= IOCB_DSYNC;
>>
>> And that's where I copied IOCB_DSYNC from. The use of RWF_SYNC was
>> introduced in 2016 by commit 24368aad47dc ("nfsd: use RWF_SYNC").
>>
>> So we've tacitly agreed to let NFSD fall short of the specs in this
>> regard for some time. However I don't believe this is documented
>> anywhere.
>>
>> Based on this reasoning, IOCB_DSYNC is historically correct for the
>> DIRECT WRITE path and its fallbacks. I'm guessing that an O_DIRECT WRITE
>> is going to persist the written data but won't persist file attribute
>> changes either.
>>
> 
> I think that's the case, generally.
> 
>> I'm open to making NFSD adhere more strictly to the spec language, but
>> I bet there will be a performance impact. Maybe that impact will be
>> unnoticeable on modern storage devices.
>>
> 
> Ok, I had missed the context that we had been doing this all along
> anyway. In that case, IOCB_DSYNC seems like it's probably acceptable.
> We likely have bigger cache coherency problems outstanding than
> potential timestamp rollbacks anyway.
> 
> Alternately, we could just return NFS_DATA_SYNC, but then we'd have to
> deal with follow-on commits.

But what's the point of asking the client to send us a COMMIT if we're
still not going to sync the file attributes? ;-)


-- 
Chuck Lever


Return-Path: <linux-nfs+bounces-15458-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9027BBF6D43
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563F7506373
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953FF33891A;
	Tue, 21 Oct 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgDFDv7G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068F3385AD
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053734; cv=none; b=KduDo5vx8e92fiNaRCWKI8ZCDeJS8f37i2hC0IjPkmhGPEs+MLBKLODG/hublyJFkrpWm7EuByr1Q4PK59NsKTu6d+jV5MNboSDYxeLKKV5zbaI1fQD0ygky1WCLpXr/yzYLxwMonM4nUvxvVubS8qItEG82ovHmlcI+9qFqTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053734; c=relaxed/simple;
	bh=1toW8aZKj6BD+/97lzfulHDKaIcq8cLpxpe/IrKV/Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjw35cKExO4hG26C9cu87eW4rr0FLqKJoMJLX9vsUayD+tR0fYSx8D5EOrUzc35a4OC3I7kcy12nEfgBv+Q+yZPafE5GPGLSMP9UKgrzOEB1T6CdqSYkdaqN4q5zmK62c5gxLEpRxh701coFBV7PYZHW17t0mHsmCXIiVP7bUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgDFDv7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B652C4CEF1;
	Tue, 21 Oct 2025 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053734;
	bh=1toW8aZKj6BD+/97lzfulHDKaIcq8cLpxpe/IrKV/Ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GgDFDv7G8bAl2V0K0RpYjd083pNu3Eg8/40mjLlA10zb8eNgYqUtG5tfTZL9UIG3B
	 u6dV1surEGacAjWy/esK3nOcxXrnMfHuuid4W/h9YtsXVIWfGidD8h0+nyYAHXKP+p
	 lwuCJqVgYsqrY4UJk4CQSON4WDhVjocu3eIykPH5oLGTUd5bleQDReLqN51h0+kVYb
	 y5ikpwdssh/APyrC9xFvfrVziv/p/HtW0TOh9FIk+OdRKRdHQCO4wad2q+FHLM9yUw
	 JgW93yab+Vi+M3dDL5HWj/duehnEcCxSAZ/8dWXbkaQwZD1/xCIV15z0hWlJi3OH/d
	 xn6UDInjuQ+HQ==
Message-ID: <4a2ab6a7-9af5-4d86-9b54-34a4f4a9682d@kernel.org>
Date: Tue, 21 Oct 2025 09:35:32 -0400
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
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <1ddb2a85a04320f6b8db6b2436ff63852dcfbbc9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 7:12 AM, Jeff Layton wrote:
> On Mon, 2025-10-20 at 12:44 -0400, Chuck Lever wrote:
>> On 10/20/25 12:33 PM, Mike Snitzer wrote:
>>> On Mon, Oct 20, 2025 at 12:25:42PM -0400, Chuck Lever wrote:
>>> Just a bit concerned about removing IOCB_SYNC in that
>>> we're altering stable_how to be NFS_FILE_SYNC.
>> Commit 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()") introduces
>> the first use of IOCB_ flags in NFSD's write path, and it uses
>> IOCB_DSYNC. The patch has Reviewed-by's from Christoph, Neil, and
>> Jeff.
>>
>> Should we be concerned that IOCB_DSYNC does not persist time stamp
>> changes that might be lost during an unplanned server boot?
>>
>> As a reminder to the thread, Section 3.3.7 of RFC 1813 says:
>>
>>          If stable is FILE_SYNC, the server must commit the data
>>          written plus all file system metadata to stable storage
>>          before returning results.
>>
>> The text is a bit blurry about whether "file system metadata" means
>> all of the outstanding metadata changes for every file, or just the
>> metadata changes for the target file handle.
>>
>> NFSD has historically treated DATA_SYNC and FILE_SYNC identically,
>> as the Linux NFS client does not use DATA_SYNC (IIRC).
>>
> 
> Surely it just meant for the one file.

Well yes that is the traditional understanding. I'm merely pointing out
that the actual text is not quite as specific as what we've come to
understand.


> FILE_SYNC is only applicable to
> WRITE/COMMIT operations and those only deal with a single file at a
> time.

True but you may recall that NFSD's COMMIT used to ignore the range
arguments and flush the whole file. Some file systems used to flush
all dirty data in this case, IIRC.

There's always been a bit of a mismatch between the spec and what NFSD
has implemented.


> If the client gets back FILE_SYNC on a write, it should _not_
> assume that all outstanding dirty data to all files has been sync'ed.

Agreed.

But back to Mike's point.

- The spec says NFS_DATA_SYNC means persist file data.

- The spec says NFS_FILE_SYNC means persist file data and file
  attributes.

- After consulting with the section describing COMMIT, I think that
  COMMIT is supposed to persist both file data and attributes.

And my reading of the code in fs/nfsd/vfs.c is that NFSD does the
equivalent of NFS_DATA_SYNC in all of these cases, and has done for
as long as I cared to chase the commit log.

Moveover, commit 3f3503adb332 did not introduce this behavior.

Previous to that commit, nfsd_vfs_write() passed RWF_SYNC to
vfs_iter_write(). This API uses kiocb_set_rw_flags() to convert the RWF
flag into an IOCB flag. kiocb_set_rw_flags does this:

        kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
        if (flags & RWF_SYNC)
                kiocb_flags |= IOCB_DSYNC;

And that's where I copied IOCB_DSYNC from. The use of RWF_SYNC was
introduced in 2016 by commit 24368aad47dc ("nfsd: use RWF_SYNC").

So we've tacitly agreed to let NFSD fall short of the specs in this
regard for some time. However I don't believe this is documented
anywhere.

Based on this reasoning, IOCB_DSYNC is historically correct for the
DIRECT WRITE path and its fallbacks. I'm guessing that an O_DIRECT WRITE
is going to persist the written data but won't persist file attribute
changes either.

I'm open to making NFSD adhere more strictly to the spec language, but
I bet there will be a performance impact. Maybe that impact will be
unnoticeable on modern storage devices.


-- 
Chuck Lever


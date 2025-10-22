Return-Path: <linux-nfs+bounces-15516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F9BFC981
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 16:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EF464F70A0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378C35BDCF;
	Wed, 22 Oct 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0KfhrU7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25D35BDC1
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143857; cv=none; b=ttRhzxY7W4Yzyd/ysBq09u0RxdXontE33FM1prWAmI7R+wkk6L/b0BBMJ6BuOlNmubQ2Zp2BbRxnF8+TsE4RTxJyEUhuKnb0TO0mcq1jB/ZJVoedTDjAF2CsD2A9ifRNs4RM0dfIJ1gNgwA/ZAhWAUN2v5RblBeXaYHHCANAyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143857; c=relaxed/simple;
	bh=Q8dGzKkAEEQHzU1kCpB+USiR+ZALqgqVGA9zzKZf6Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lN83YRv4l7txQCJcJLxGoMeWraWOsEZIVzFyvjzznPzUEFKQX0zvhdPVbtSHsz2tDXksU6kU/AXImRTJn6PslGMqZyS9XlZOo47gcjb1lx0CriAROVfdtjBShorZ73OyozNb5q08Qc1t0APndyohejQyzF1vEW/kKjq1jS3PAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0KfhrU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D876C4CEE7;
	Wed, 22 Oct 2025 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143856;
	bh=Q8dGzKkAEEQHzU1kCpB+USiR+ZALqgqVGA9zzKZf6Nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0KfhrU7zVrL/XpcMOXCVe+ZAUU0AzZOH80Mw8DWzEJFp6InNfTMjfMTKsoyQpi6K
	 2jHM0wC3XA+9x+qgODHk7SWFji2Qb4rBckKZuXU4oVTNRBqthZpOzz7Ei8AtVfqgwp
	 kqgNLU1hUtwq0CL00d3aHk5/yaurGlGKLSV/rC51QmhYIRAIfRJXE5hdmlSbH5RdR+
	 iFVN1gup0yxF2fBewtKl88Nb/GWICz86qsZKmoWoSNv14Q0gnYGM9LR59htoYOqjg1
	 +EX6CvUUasHVcvRoEFF5TGtK+qTk7rE+kpck3PQjAEs8yIsqNcEMiKAi9N453lFC5g
	 9vbbvzynwp+xQ==
Message-ID: <ee1eba86-a5ce-4cb8-9124-78a53eae6fc8@kernel.org>
Date: Wed, 22 Oct 2025 10:37:35 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org> <aPXihwGTiA7bqTsN@infradead.org>
 <aPZi2DXtdELwjTu2@kernel.org> <aPhoQtHH8iscmmKJ@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPhoQtHH8iscmmKJ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 1:14 AM, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 12:27:04PM -0400, Mike Snitzer wrote:
>>> Can you define synchronous better here?  The term is unfortunately
>>> overloaded between synchronous syscalls vs aio/io_uring and O_(D)SYNC
>>> style I/O.  As of now I don't understand which one you mean, especially
>>> with the DONTCACHE reference thrown in, but I guess I'll figure it out
>>> reading the patch.
>>
>> It clearly talks about synchronous IO.  DONTCACHE just happens to be
>> the buffered IO that'll be used if supported.
>>
>> I don't see anything that needs changing here.
> 
> Again, what synchronous?  O_(D)SYNC, or !async?
> 
>>
>>>> If vfs_iocb_iter_write() returns -ENOTBLK, due to its inability to
>>>> invalidate the page cache on behalf of the DIO WRITE, then
>>>> nfsd_issue_write_dio() will fall back to using buffered IO.
>>>
>>> Did you see -ENOTBLK leaking out of the file systems?  Because at
>>> least for iomap it is supposed to be an indication that the
>>> file system ->write_iter handler needs to retry using buffered
>>> I/O and never leak to the caller.
>>
>> fs/iomap/direct-io.c:__iomap_dio_rw() will return -ENOTBLK on its own.
> 
> Yes, and the callers in the file system methods are supposed to handle
> that and fall back to buffered I/O.  Take a look at xfs_file_write_iter.
> 
> If this leaks out of ->write_iter we have a problem that needs fixing
> in the affected file system.

What I'm hearing is that nfsd_vfs_write() should never see -ENOTBLK, so
this check is essentially dead code.


>>>> These changes served as the original starting point for the NFS
>>>> client's misaligned O_DIRECT support that landed with
>>>> commit c817248fc831 ("nfs/localio: add proper O_DIRECT support for
>>>> READ and WRITE"). But NFSD's support is simpler because it currently
>>>> doesn't use AIO completion.
>>>
>>> I don't understand this paragraph.  What does starting point mean
>>> here?  How does it matter for the patch description?
>>
>> This patch's NFSD changes were starting point for NFS commit
>> c817248fc831
> 
> But that commit is already in?  This sentence really confuses me.

I'm not convinced this paragraph in the patch description is needed.
Can it be removed?


>> Would prefer that cleanup, if done, to happen with an incremental
>> follow-up patch.

I'm not following. What clean-up? And why push it out to a later
merge?


> Starting out with well structured code is generally a good idea :(

That is my preference as well, though I recognize that some subsystems
do not mind merging incomplete features and moving forward from there.

Let's remember, upstream does not target specific kernel releases when
developing new features. You might want your feature to hit the next LTS
kernel, and even that is frowned upon. Let's focus on getting this as
right as we know how to, rather than hitting a delivery date.


>>>> +static bool
>>>> +nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask,
>>>> +                        unsigned int len_mask)
>>>
>>> Wouldn't it make sense to track the alignment when building the bio_vec
>>> array instead of doing another walk here touching all cache lines?
>>
>> Yes, that is the conventional wisdom that justified Keith removing
>> iov_iter_aligned.  But for NFSD's WRITE payload the bio_vec is built
>> outside of the fs/nfsd/vfs.c code.  Could be there is a natural way to
>> clean this up (to make the sunrpc layer to conditionally care about
>> alignment) but I didn't confront that yet.
> 
> Well, for the block code it's also build outside the layer consuming it.
> But Keith showed that you can easily communicate that information and
> avoid extra loops touching the cache lines.

Again, is there a reason to push this suggestion out to a later merge
window? It seems reasonable to tackle it now.

(Perhaps to get us started, Christoph, do you know of specific code that
shows how this code could be reorganized?)


>> Room for follow-on improvement to be sure.
>>
>>>> +	if (unlikely(dio_blocksize > PAGE_SIZE))
>>>> +		return false;
>>>
>>> Why does this matter?  Can you add a comment explaining it?
>>
>> I did/do have concerns that a bug in the storage driver could expose
>> dio_offset_align that is far too large and so bounded dio_blocksize to
>> a conservative size.  What is a better constant to check?
> 
> I don't think there is a good upper limit, we not do supper LBA sizes
> larger than PAGE_SIZE, although I don't think there's any shipping
> devices that do that.  But the most important thing is to always add
> a comment with the rationale for such non-obvious checks so that someone
> who has to lift it later can understand why it is done.
> 
>>>> +	 * Also update @stable_how to avoid need for COMMIT.
>>>> +	 */
>>>> +	kiocb->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
>>>
>>> What do you mean with completed before returning?  I guess you
>>> mean writeback actually happening, right?  Why do you need that,
>>> why do you also force it for the direct I/O?
>>
>> The IO needs to have reached stable storage.
> 
> Please spell that out.  Because that's different from how completed
> is generally used in file systems and storage protocols.

It's sensible to add a comment that cites the NFS protocol compliance
mandate that states a data durability requirement.


>>> Also IOCB_SYNC is wrong here, as the only thing it does over
>>> IOCB_DSYNC is also forcing back of metadata not needed to find
>>> data (aka timestamps), which I can't see any need for here.
>>
>> Well, we're eliding any followup SYNC from the NFS client by setting
>> stable_how to NFS_FILE_SYNC, so I made sure to use SYNC:
> 
> Why do you care about timestamps reaching stable storage?  Which is the
> only practical extra thing IOCB_SYNC will give you.  If there is a good
> reason for that, add a comment because that's a bit unexpected (and
> in general IOCB_SYNC / O_SYNC is just a sign that someone does not know
> about SYNC vs DSYNC semantics).

If NFSD responds with NFS_FILE_SYNC here, then timestamps need to be
persisted as well as data. As discussed in other threads, currently
nfsd_vfs_write() seems to miss that mark.

So either: return NFS_DATA_SYNC (which means we've persisted only the
data) or make this path persist the timestamps too.

I haven't seen any existing code that convinces me that setting both
IOCB_SYNC and IOCB_DSYNC is necessary.


>>> The VFS certainly does not, and if it leaks out of a specific file
>>> system we need to fix that.
>>
>> As I said above, fs/iomap/direct-io.c:__iomap_dio_rw() does.
> 
> As stated above that's an internal helper and the code is supposed to
> be handled by the file system and never leak out.
> 
>> Regardless, the most likely outcome from issing what should be aligned
>> DIO only to get -EINVAL is exactly what is addressed with this
>> _unlikely_ error handling: misaligned IO..
> 
> No.  There is no reason why this is any more likely than any of the
> other -EINVAL cases.

Agreed, the likelihood of getting an -EINVAL here due to a block
alignment issue is much lower than getting -EINVAL due to other
problems.


-- 
Chuck Lever


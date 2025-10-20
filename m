Return-Path: <linux-nfs+bounces-15407-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1DBF1AA8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 15:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EA8189F42B
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283031E0EF;
	Mon, 20 Oct 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk2j/2KV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9693164DC
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968565; cv=none; b=PXNAKQa6OGfvUEnTAHB9h+2EUxh+G73Y48RA5Gy/6Y0pG4MlMDkHd7jk/fEKvwWqfYw2TiS6TkTa67j4BJZT8e13+L/V8SLnUmGxpzgx1FljPFSDl1REnKYSiKx26uxJQFrRp7s/2W9GhzZUT6/B9QkAfaAuTkU2MIjOPjMQkN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968565; c=relaxed/simple;
	bh=Q3utQyW/9W64IGo8ZE/0OLSZpMpSjhH6ayaNzEI8yNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8mY2kOyxmgglkOD168rhWGj9miJisB3KlS4/KEsbnahEZ6JQlcjXP+jzn9WxrYP4LrspDqDJEfbsmdMk9B5nFg/PFUzakClK5imXqOMbBPjsPkG56A4+XO5UAB29zHwNZEXG96W7TnQSbuLkaHe+/kv2Tuq9ryzrXYOpNFjzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk2j/2KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE86C113D0;
	Mon, 20 Oct 2025 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760968563;
	bh=Q3utQyW/9W64IGo8ZE/0OLSZpMpSjhH6ayaNzEI8yNc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qk2j/2KVHRBD1mT3rmjMUkRHFIWe0vP22FImPtHsgsX2JXyDXSv3frIwNH9b8ND1X
	 0Wi5+IZgAPVkiuE630FbO9QOGMjvsfGt5eecirG/RxTaSV2NkYQNRncmrYhYIl0Il3
	 Plz040bcCSxggGn+9oKzHmaDXlfDcFkDCXEc5h3Y6eNuSX5oPBvTNZdsx3a6diOLlc
	 j0W4MkHbWUcmaVG/gtgoH8EVWshOXVsSXjnlQoqlFqJesQ8fjm5iYi0RZEqtxbWsw2
	 arbr5+ce1m5PK5fpiefOUfF3UVwo8IR+wPP8ZeGzE0m4IUC84wsoL/RiMY76A7umQP
	 6ol+UvvmBUBJA==
Message-ID: <67e3763c-d20c-4e1c-b7ff-62b59c385210@kernel.org>
Date: Mon, 20 Oct 2025 09:56:02 -0400
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
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPXihwGTiA7bqTsN@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 3:19 AM, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:54:30PM -0400, Chuck Lever wrote:
>> From: Mike Snitzer <snitzer@kernel.org>

>> +static int
>> +nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
>> +		    unsigned int nvecs, unsigned long *cnt,
>> +		    struct kiocb *kiocb)
>> +{
>> +	struct iov_iter iter;
>> +	int host_err;
>> +
>> +	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
>> +	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
>> +	if (host_err < 0)
>> +		return host_err;
>> +	*cnt = host_err;
>> +
>> +	return 0;
> 
> 
> Nothing really buffered here per se, it's just a small wrapper
> around vfs_iocb_iter_write.

This is the original NFSD_IO_BUFFERED code, refactored out of
nfsd_vfs_write(). IMO it might be more clear what's going on if the
refactoring was done in a separate prerequisite patch.


>> +			} else if (unlikely(host_err == -EINVAL)) {
>> +				struct inode *inode = d_inode(fhp->fh_dentry);
>> +
>> +				pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
>> +						    inode->i_sb->s_id, inode->i_ino);
>> +				host_err = -ESERVERFAULT;
> 
> -EINVAL can be lot more things than alignment failure.   And more
> importantly alignment failures should not happen with the proper
> checks in place.
I tend to agree that I expect an alignment failure will rarely if ever
happen if we've done our job well.


-- 
Chuck Lever


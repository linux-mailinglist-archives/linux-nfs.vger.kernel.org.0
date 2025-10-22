Return-Path: <linux-nfs+bounces-15513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6775BFC375
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 15:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A75E8114
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 13:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7CC345CD7;
	Wed, 22 Oct 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLCK0yKa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC8345752
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139915; cv=none; b=ScKxgYVSOPRy03XNOijAMVo4ePPzJlLTkwriYGFqbwOgNQGi4aydgLxrH197SaxzfcRwmrHBADBWOYjddIf6dSkHebrb0RXLVynCURrdE/6Cr1eWR1BrAaPydOvF8Sx9GiZ0OAW5bUgcQ27ZSlVOKLsZtEYrV8t6XmwKD5sy7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139915; c=relaxed/simple;
	bh=paw6IXG/hYOCyMp4sWeVGIe/kX5dAOa5/0Lvsc1g2F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRyD+wWO25Nk9gJ+hTf9593Bmc2nhnHHbyGCDdsacuUlobveZGUMiitqoQc1Vzh2gygV4JBIQYb+K+GIs3z/mBLX4pvWoUqn/Clnp6pPQzgdliqgU6zm4vulZNuubVSBsXNrWxSSi8bWguI+DD/mkgJQLkYSJlqyTF/MQrRGdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLCK0yKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E18C4CEE7;
	Wed, 22 Oct 2025 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761139914;
	bh=paw6IXG/hYOCyMp4sWeVGIe/kX5dAOa5/0Lvsc1g2F4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oLCK0yKaZtcbRCcjCtcjV4KzqMJNUCIBSOnSRIYQ1e7Hv0Iz+maanufY+TKTgnBMd
	 9yshU0ZdqhrExQi67OjZ7NzcvyLxZlaZdEl5AVtcFYAu9zXs/e9YyanwI/SCd7TvQm
	 xQTxMfnaAuqDCV2EupBhDfFXKU5wlVIzKRm/g4dpJMBwvq/6p+4vUTi6ebIQVeZrfW
	 omMPVVt4uX9Ybpy9iXQylOL0rE4HfYfyD/RwpfbyhNMe9JQAUz7RxEZnaIHZKJaWIH
	 Uv1hzjdnmJB/n+Jiiat6nxGljOsUvyGHVU8xOv5TfzrLCWeHU/+SRS4aWMdpMjT6L4
	 kb8NqbWjWJdmQ==
Message-ID: <98ecbd75-0a34-4358-843f-58f8e6afedb9@kernel.org>
Date: Wed, 22 Oct 2025 09:31:53 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
To: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
References: <20251018005431.3403-1-cel@kernel.org>
 <20251018005431.3403-3-cel@kernel.org> <aPXihwGTiA7bqTsN@infradead.org>
 <a5f3911ae6b65c70e1fd897bdd4f3e651decb196.camel@kernel.org>
 <aPhoow9Z-r94b5AL@infradead.org>
 <63a440d869e3f8a9ecf13537e2da6c6439933ed1.camel@kernel.org>
 <aPi9ZE96CYQFk5qC@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPi9ZE96CYQFk5qC@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 7:17 AM, Christoph Hellwig wrote:
> On Wed, Oct 22, 2025 at 06:15:44AM -0400, Jeff Layton wrote:
>> Cache coherency. If the timestamps roll back, some clients may not
>> notice that data has changed after a write.
>>
>> It's not the end of the world -- non-evident timestamp changes were
>> typical prior to the multigrain timestamp patches going in, but it's
>> not ideal.
> 
> Well, in that case nfsd_vfs_write needs to use IOCB_SYNC as well.
> And both that and this code need a big fat comment about it.
NFSD's historical behavior doesn't match the spec, so yes, I'd like a
comment or two that calls this out if we agree that's something we
do not want to change.

Otherwise, I'm not opposed to bringing NFSD into compliance. But that
might need patches that can be backported. Not technically difficult,
but some planning is necessary.

-- 
Chuck Lever


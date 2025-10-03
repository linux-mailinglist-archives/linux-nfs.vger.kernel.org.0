Return-Path: <linux-nfs+bounces-14960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EEBBB728D
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1194E1B8D
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E6113E41A;
	Fri,  3 Oct 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEgsH+3F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123011CA9
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501113; cv=none; b=Nq9/60eusoAm80QpeaWzy8+m3fCEvmnfM82AF7/6CQquPF9jBvnO7vJfYgztaAYAAY/0D4rut9JCOKvev5Jx0fSFD+NqGvDxPvoRnpMKfCvD4A8lienUzwNAja48Mf4H66LdfoVSBqY2vUhthMDhZ3uovInuTR/KlHzQBy2PJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501113; c=relaxed/simple;
	bh=ScyP/89ig08wbOrgaOLy9p2ptxVqK17cE+czvRj4JkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpPUplGqQlLk84XwcwpOeQe7tXhZa0l6khiA7ZJPfbjW13AWTLzXxOQuTA7+RcBVk5tPUO0F1P4rlP5qUA/222GDLoqo6oss/59Psnt+lhKTtp+4TU0dgiqfsIohIChZHwKtKqOE5VJbdgYty38ocN22IkBZnUcxXbGtyQzulW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEgsH+3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7D5C4CEF5;
	Fri,  3 Oct 2025 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759501112;
	bh=ScyP/89ig08wbOrgaOLy9p2ptxVqK17cE+czvRj4JkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NEgsH+3F+txIgra7LaEMkYDDlShSwWAHEBkmAzOTcOuZBzPrJz3MkvnkNA/aRpT2m
	 PiE+ZJmKN2EJhLqXq+SnlwUssYUTXVVZZOnOEwBl18xaW9cQzMyXuMRh0O3eCeMU5R
	 RuWd+Q6KUffithPEnWKeQX2Ksw0Tuhn7kNZUMKBd+QHO/1EAgvTDxAS1X+5RcepeAJ
	 koVQhLrDWui7n4hmrZOo9MqiNkYItYMnrctFKfFAUwVP8doC1XhFq+dhQjw/N9ezqf
	 +fxfBoz4n6UL0voztllFmhq0cY8W3rHlMtyAgPsYjF5ZFF5vgukP4ANxwBLAVtoubo
	 2xJlUaDRiOwbQ==
Message-ID: <6656c056-1acb-40de-96ea-0a50f741b0a9@kernel.org>
Date: Fri, 3 Oct 2025 10:18:30 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] NFSD: Prevent a NULL pointer dereference in
 fh_getattr()
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-6-cel@kernel.org> <aN93CyFBPTnmAePM@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aN93CyFBPTnmAePM@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 3:11 AM, Christoph Hellwig wrote:
> On Mon, Sep 29, 2025 at 11:56:45AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> In general, fh_getattr() can be called after the target dentry has
>> gone negative. For a negative dentry, d_inode(p.dentry) will return
>> NULL. S_ISREG() will dereference that pointer.
>>
>> Avoid this potential regression by using the d_is_reg() helper
>> instead.
>>
>> Suggested-by: NeilBrown <neil@brown.name>
>> Fixes: bc70aaeba7df ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
> 
> Fixed for existing bugs should usually go first and/or be split into a
> separate prep series.
> 
> Otherwise:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Additional context: bc70aaeba7df is the first commit in this series.

These fixes are split out because bc70aaeba7df is going through Anna's
tree for v6.18, so it's already "committed". However I can move them
to patch 2 and 3 of this series.


-- 
Chuck Lever


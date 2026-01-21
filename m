Return-Path: <linux-nfs+bounces-18250-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BVjFCDmcGk+awAAu9opvQ
	(envelope-from <linux-nfs+bounces-18250-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 15:43:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB13B5893E
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 15:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0264EA299EF
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70D53002BB;
	Wed, 21 Jan 2026 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDrX2387"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1102DECCC;
	Wed, 21 Jan 2026 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004879; cv=none; b=hV0sJPYV8OhnsImLsY9YDlHDj8PHubj1ftPVJ92NmhCzuru1IXlfhwotkvCsOBrNp8Zc7CMyZZsmvvqAgOkfKuZKDrHSk4SbwsAIiNCvx6kOXskTVekJCKDHzKeBsnydh/xun1JczBEgNhZi7iuI99ichLfW0USVieUxbOYgKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004879; c=relaxed/simple;
	bh=ZSIa9oi5DcWZsu908TKULsi4N4pbs3uuKg/9b/8WOok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzM6Dru7ods0a/2VaC/gkb9Giv4zUODyG7360aveIRz5A6upASYZPJ3U1+hdXgqMHlJsF1Q0aOLXtRfUzNrds8HRlpNLQ/aRMsMPES8muvp9fHzDGC7bBiwQbgV7Wno1mi9T0HvGjsbbH8cGrpB/rdZcShmQGfEjKWZObdqr2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDrX2387; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485F8C4CEF1;
	Wed, 21 Jan 2026 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769004879;
	bh=ZSIa9oi5DcWZsu908TKULsi4N4pbs3uuKg/9b/8WOok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EDrX2387jt2zy9qDnYtcY+/nBJzA3u7kNEb91ygo1UB8ZQO4hydc+dfOKRKT6971r
	 im293MKyicfyZVpzXkF6cAbt42SZ+BUKtqcZZ/vhhfKp15veF3EA3G0E8xb8O70OfR
	 IwI0DQHTLNZpLJIZ18G4Z746V3ysZ2vderAOoB8PFOj/EuSlPwD8aQYRt8AAAtox1z
	 mz+fYu/rgOznHEJHnhw7mo/OEX7Vcngl9WeLg7XZjeCITcDliza2EYrLDA9FsAyTAC
	 N6TtL8ANwbIU2qFiZNc+DdxS+n/qyAbwHZ98mRore8cli5fDj1c0AJOWYFFkktP/Hi
	 FG/OfoS4OldXQ==
Message-ID: <9bfdde0e-efe5-4e23-b95d-6f70836ed59c@kernel.org>
Date: Wed, 21 Jan 2026 09:14:36 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] RDMA/core: add bio_vec based RDMA read/write API
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260120143124.1822121-1-cel@kernel.org>
 <20260120143124.1822121-2-cel@kernel.org> <20260121085641.GC16458@lst.de>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20260121085641.GC16458@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18250-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EB13B5893E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 3:56 AM, Christoph Hellwig wrote:
> Another reply, sorry.  I noticed I skipped over the end while reviewing
> the 3rd patch.
> 
>> +	u32 i, total_len = 0;
>> +
>> +	if (nr_bvec == 0 || offset >= bvec[0].bv_len)
>> +		return -EINVAL;
>> +
>> +		if (check_add_overflow(total_len, bvec[i].bv_len, &total_len))
>> +			return -EINVAL;
>> +	}
>> +	total_len -= offset;
>> +
>> +	iter.bi_sector = 0;
>> +	iter.bi_size = total_len;
>> +	iter.bi_idx = 0;
>> +	iter.bi_bvec_done = offset;
> 
> I'd much rather have the callers pass in the bvec_iter, as that's
> more useful.

"The callers" -- Can you clarify whether you mean that the API
consumers would pass in a bvec_iter, or whether the iter is
entirely internal to rw.c ?


> We can probably look into factoring the quoted code
> into a helper if that's useful.
> 


-- 
Chuck Lever


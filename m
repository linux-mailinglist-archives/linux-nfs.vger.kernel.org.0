Return-Path: <linux-nfs+bounces-18350-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B38BiWCc2n2wwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18350-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 15:13:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5520B76CEF
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 15:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1989301BEE4
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7655319601;
	Fri, 23 Jan 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Osvzvb7m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4323274641;
	Fri, 23 Jan 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177633; cv=none; b=QKfQrN6nZGjEC/4m0gIvWpq0eHmkiHndgXf9aQNSlQyCIGwSnzc1wbGJXmAremoC6cNapOFmAixH8HQPe26yob3OraU6124QYLlt4Z9Yjutv4r/jqL05ReKMBF+/RuykRc9H8x3aI+kcG+UV8Ojq538ERRRLyw1x9faIjfsD10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177633; c=relaxed/simple;
	bh=5Jq9ngGjUGPz3WSIUdzUhPNpP4sVGNNZMaI7LmtLhXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHbqR8U4vYLt1o8Xy+k/i4vr4aRLtyERGcWpLbYzAq3+D/B6SWhms8d5+IZXafdUuhRA7tyj3lzxBnoBr9TvpYV8dFViBlydHd4rj23e+GrhL+uE09npitN3cLSb0uKkKc08jHwTkY1wNdTvYXORGTjZt/ku7zxLkSEmMkh5Ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Osvzvb7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D649C4CEF1;
	Fri, 23 Jan 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769177633;
	bh=5Jq9ngGjUGPz3WSIUdzUhPNpP4sVGNNZMaI7LmtLhXw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Osvzvb7mXtQRETaJ+y19L7kDJM4Fdt1GDi0Cs6mpN0kbOhtdHNiBlgRjZoIz5jUny
	 z7jmW3yA2zg/NW8qlchp1geoP3Hp5HrZ8iBjg4xaV6Pi8ngYrCnQ2g3Ode/m0RDiFB
	 1dtN+6jnXSpti49F/Dw5BGXd+6ByQwUkyd2vJglgZlhDjboLoiiDmOG5Se9FXLo3+Y
	 utAHxgzs7NkQZAox1/pjyq/J3a/rBEVsYtpD4JTaD/YAN1j9znbGNilye8172qJJhF
	 H4XrDs5tMpHfTWbejkkY1500s8Xy1UT/xHtIWwh0j+WPI0K0OHm6zbuNeVQVNyn4Nd
	 ow/cWOF2/lEWg==
Message-ID: <d67a30a0-5ff1-4e31-a168-81f8b7bee97f@kernel.org>
Date: Fri, 23 Jan 2026 09:13:47 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add a bio_vec based API to core/rw.c
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: NeilBrown <neilb@ownmail.net>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org,
 linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260122220401.1143331-1-cel@kernel.org>
 <c02ab348-5243-4e97-b916-6bd59ffe769a@linux.dev>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <c02ab348-5243-4e97-b916-6bd59ffe769a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18350-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Queue-Id: 5520B76CEF
X-Rspamd-Action: no action

On 1/23/26 1:04 AM, Zhu Yanjun wrote:
> 在 2026/1/22 14:03, Chuck Lever 写道:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> This series introduces a bio_vec based API for RDMA read and write
>> operations in the RDMA core, eliminating unnecessary scatterlist
>> conversions for callers that already work with bvecs.
>>
>> Current users of rdma_rw_ctx_init() must convert their native data
>> structures into scatterlists. For subsystems like svcrdma that
>> maintain data in bvec format, this conversion adds overhead both in
>> CPU cycles and memory footprint. The new API accepts bvec arrays
>> directly.
>>
>> For hardware RDMA devices, the implementation uses the IOVA-based
>> DMA mapping API to reduce IOTLB synchronization overhead from O(n)
>> per-page syncs to a single O(1) sync after all mappings complete.
>> Software RDMA devices (rxe, siw) continue using virtual addressing.
>>
>> The series includes MR registration support for bvec arrays,
>> enabling iWARP devices and the force_mr debug parameter. The MR
>> path reuses existing ib_map_mr_sg() infrastructure by constructing
>> a synthetic scatterlist from the bvec DMA addresses.
> 
> Hi, Chuck Lever
> 
> I’ve read through the patch series. As I understand it, the new bio_vec–
> based RDMA read/write API allows callers that already operate on bvecs
> (for example, svcrdma and potentially NVMe-oF) to avoid converting their
> data into scatterlists, which should reduce CPU overhead and memory
> usage in the data path.
> 
> For hardware RDMA devices, the use of the IOVA-based DMA mapping API
> also seems likely to reduce IOTLB synchronization overhead compared to
> the existing per-page approach, while software devices (rxe, siw) retain
> the current virtual-addressing model.
> 
> Do you happen to have any performance or functional test results you
> could share for this series, in particular:
> 
> Hardware RDMA devices (e.g., latency, bandwidth, or CPU utilization
> changes), and/or

Functional tests with CX-5 Infiniband and NFS/RDMA show no regression.

Performance tests are difficult to evaluate because I don't have a
multi-client set-up here to drive a heavy workload, plus filesystems
bottleneck long before the network transport does. The changes are
designed to improve scalability (eg lower CPU utilization for the same
workload and less interaction between host and RNIC) more than improve
raw throughput. So far I have seen no throughput regression and perhaps
a bit of improvement for tail latencies.

The main purpose of the series, however, is part of an effort to enable
kernel-wide replacement of the use of scatter-gather lists, which are
technical debt. Socket APIs already support struct bio_vec.


> Software RDMA devices such as rxe or siw?

Software providers are not likely to see much change. However, you will
need to test the series with your own preferred configuration and
workload to assess performance and scalability delta.


-- 
Chuck Lever


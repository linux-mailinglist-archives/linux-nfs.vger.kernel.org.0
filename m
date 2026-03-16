Return-Path: <linux-nfs+bounces-20224-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB1SAjRnuGlOdQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20224-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 21:25:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72D2A02AF
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D66B23028B26
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBE3EE1E1;
	Mon, 16 Mar 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTo+N87m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF233EDABE
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692721; cv=none; b=rPqQYPz7k7raZB4TiBtO5022kaAB56qdsebnPKvSw8GcB3VX2U494/uHpYB5Cx2q2z/m+8NDON3K7zokhdaVLKJHdp9qJJuvBijSvwZgetdhUTVPKnA+9gAjVJVVUUs6owrNJBy0RbZTUCEGJebFKEfTgcWRhNWnAYGr4cg/98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692721; c=relaxed/simple;
	bh=9ZGH5oQMnbc7/pwZMzocx1eA3lbSRQ5KxKCyk8Lsnxk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RP8YRt+E3YWCf70Lul80WRV7w33ynNJts8Lcbl6/J053TsM5PmOQvpox6JAJESn4RQ3jFR+rILE5VqN6jM0ZzpvGb1X/FCDpzRV7ameEa3KG64OGixMdyWxn3hfnlQktebbfgwjShF5v9yHrGvx4StLlL/d50dmYIKVkjw6EVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTo+N87m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305D5C19421;
	Mon, 16 Mar 2026 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773692721;
	bh=9ZGH5oQMnbc7/pwZMzocx1eA3lbSRQ5KxKCyk8Lsnxk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QTo+N87mGdxwJY+/OE6YaVicKuJKBMT9HePsF/DV+HZO8/+lsAqztDNLzPreO87j9
	 yrAWW7JebOVY+UYb/2NhEerm4tXYSL3TDKRPxr3roFUTAb2pPxSoGJpk4nA8vFNy+L
	 aBN/wdOV+cfo6qFpG5dFv/YA5qBLtJxDwm0qW1UtsFg4jYRhuon0qt6+ptKxrUQMgc
	 QfZK4UcmFC605w8QZSF1D3S+FZ02goXjHO04xtgYS6wkfozymKWVYFl2vJ498gsI5v
	 Fz2ZydS5ah3sLy55ARdyndMIVMzOx5vzs7IYQYjVH1+STs8ZLLvy2SY+in5UYrRefG
	 R2K6FNXL9mKVw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1C0F1F40078;
	Mon, 16 Mar 2026 16:25:20 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 16 Mar 2026 16:25:20 -0400
X-ME-Sender: <xms:MGe4ad0Qvi27CgFm63xloWZXqFQd-phWimr4HKBFjFfX_mE0xn_bZA>
    <xme:MGe4ae6PXkqtRgMm7HoYD5wEzBik1mruHN_hwXaH-BHcNxPbHUANni-YsTRZZPf9Q
    mnf8cuqxalvTeCCIYjo-I7RomS9o4j6hLwadQuhF6hP-IBZV1z5Fdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthht
    oheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrih
    drnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhgvihhlsgesohifnhhmrghi
    lhdrnhgvthdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MGe4aQBx3nyj032nAXH05-YfaQtJMLW_zXvL_6x3d6jOauWwS9s5_g>
    <xmx:MGe4aYiUPgnbsQGPjN7eoNIJ5tqx2iyhiipDGCn7NHvW_h_qozKrFQ>
    <xmx:MGe4aebWN5qmjkGCmRPm7k7VEkRSSQdLP5ho7p70K8V8OofKFv217A>
    <xmx:MGe4aZk0UycNbkvv7JALcZNM7snU-MTQ-NdoTVEp9GWdK-zLdM_SZw>
    <xmx:MGe4aUidNTTa9pAr7Dmr_N3U1vhyeK6eN3Jpmlsx8eXewKKLc97gr1-b>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E64AF780075; Mon, 16 Mar 2026 16:25:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwRJL3W4sQr7
Date: Mon, 16 Mar 2026 16:24:59 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <5b64e7d8-58fa-482a-9b9c-88eb203b3b9e@app.fastmail.com>
In-Reply-To: <20260316201558.GM61385@unreal>
References: <20260313194201.5818-1-cel@kernel.org>
 <20260316201558.GM61385@unreal>
Subject: Re: [PATCH v3 0/4] RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lst.de,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20224-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9A72D2A02AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, Mar 16, 2026, at 4:15 PM, Leon Romanovsky wrote:
> On Fri, Mar 13, 2026 at 03:41:57PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> This series now carries two MR exhaustion fixes and a proposal for
>> using contiguous pages for RDMA Read sink buffers in svcrdma.
>> 
>> Fixes for the MR exhaustion issues should go into 7.0-rc and stable,
>> and the contiguous page patches can wait for the next merge window.
>> 
>> Base commit: v7.0-rc3
>> ---
>> Changes since v2:
>> - Fix similar exhaustion issue for SGL
>> - Add patch that introduces svc_rqst_page_release
>> 
>> Changes since v1:
>> - Clarify code comments
>> - Allocate contiguous pages for RDMA Read sink buffers
>> 
>> Chuck Lever (4):
>>   RDMA/rw: Fall back to direct SGE on MR pool exhaustion
>>   RDMA/rw: Fix MR pool exhaustion in bvec RDMA READ path
>
> I applied these two to wip/leon-for-rc.
>
> Thanks

Thanks, Leon. I will apply the other two to nfsd-testing.


>>   SUNRPC: Add svc_rqst_page_release() helper
>>   svcrdma: Use contiguous pages for RDMA Read sink buffers
>> 
>>  drivers/infiniband/core/rw.c      |  43 ++++--
>>  include/linux/sunrpc/svc.h        |  15 ++
>>  net/sunrpc/svc.c                  |   7 +-
>>  net/sunrpc/svcsock.c              |   2 +-
>>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 220 ++++++++++++++++++++++++++++++
>>  5 files changed, 268 insertions(+), 19 deletions(-)
>> 
>> -- 
>> 2.53.0
>>

-- 
Chuck Lever


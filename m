Return-Path: <linux-nfs+bounces-20844-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nhG4Nsjg3mklMAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20844-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 02:50:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351CE3FF609
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 02:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB0143028EDA
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A050263C9F;
	Wed, 15 Apr 2026 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wt9j8PlX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAD266B46
	for <linux-nfs@vger.kernel.org>; Wed, 15 Apr 2026 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214128; cv=none; b=e+C4toQpwVLYQjjk3Adwu9oPJXBDlamN6oECL4hETfhpvr/FV9Xzuod1UU8YeCCTHxvMghZXpwy/p9zHgqo2r2KJowtfowa++PGrHYAFoNUFsKFbZobHqyqZ23ShROI0a2FUdV+FznkG+M/9A9+kgAopx2fIxuPKP/+gb+55q4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214128; c=relaxed/simple;
	bh=/9OMEHbVj5Watn1GKdn2+Z3KYWZeTuxWsegikZA1a/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToJlZEOAVi30Rd98AifQ6SyUJlscUxsss8HnOdbKApw4Btoh+DiiZdVUJtI/QBUb20Lvdu3Cf6QKLpdhInLKfa+KiAbCxWHF7drSXveSa8I2DH1Bhn3ZqQTbLsnpx+RIU2QN72x18Vwng2+4LXZeeohSY2cu8cKPT70w2/r1aVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wt9j8PlX; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7388e265-ccb3-4938-90d0-4b503198ddd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776214124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dOLQgMFIc5WUqLkqCJZGmnuCCvn5m/W7yOiMCxXGac=;
	b=Wt9j8PlXjKFscfm8IaE/7fE32DTbPJEridqhLxVM6uhZW+xqalaHoT9Tt8/Vfn23ji9k45
	CBYPlUoobc9vIvtFyDSUZ995PPzra2KnDqphha67t9ihj9dhj9KvKloVCF2praJbRY++id
	XxDS1vNDRy1nl3tFSewQ91fuGreoRaA=
Date: Wed, 15 Apr 2026 08:48:30 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm/vmstat: use node_stat_add_folio/sub_folio for
 folio_nr_pages operations
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Chris Li
 <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Cc: Ye Liu <liuye@kylinos.cn>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Kemeng Shi
 <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Youngjun Park <youngjun.park@lge.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20260414091527.2970844-1-ye.liu@linux.dev>
 <20260414091527.2970844-2-ye.liu@linux.dev>
 <fa26f2c4-a755-4ed7-b835-465c8c5fe0e2@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <fa26f2c4-a755-4ed7-b835-465c8c5fe0e2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kylinos.cn,google.com,suse.com,cmpxchg.org,nvidia.com,ziepe.ca,redhat.com,linux.alibaba.com,oracle.com,arm.com,kernel.org,linux.dev,intel.com,gmail.com,sk.com,gourry.net,huaweicloud.com,lge.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-20844-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ye.liu@linux.dev,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_TWELVE(0.00)[40];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 351CE3FF609
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/15 01:52, David Hildenbrand (Arm) 写道:
> On 4/14/26 11:15, Ye Liu wrote:
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Replace node_stat_mod_folio() calls that pass folio_nr_pages(folio) or
>> -folio_nr_pages(folio) as the third argument with the more concise
>> node_stat_add_folio() and node_stat_sub_folio() functions respectively.
>>
>> This makes the code more readable and reduces the number of arguments
>> passed to these functions.
> 
> Also, that makes it clearer that we always account the full folio, never
> parts of it.
> 

Thank you, David, for your support. I agree that the new functions make
the intent more explicit.

-- 
Thanks,
Ye Liu



Return-Path: <linux-nfs+bounces-14619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B78B91B75
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477711903C9B
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C92512EE;
	Mon, 22 Sep 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+XvDHM8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295E2512DE
	for <linux-nfs@vger.kernel.org>; Mon, 22 Sep 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551353; cv=none; b=Tb4iCff/W1XaBLXv9SIo+gxOKvO/GYmQ54/afV6OuaddPbplMH+tJFgy9yhwXWpZMghpi7cyzUKyt0cUvJKJsVf257MDw2BE2+h4Ymady2QSd4n+CMHffMV51cdBDGBoae6J9ilW5CwdG9z/xtmDiESl4qyHS26SHDgTUCGBOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551353; c=relaxed/simple;
	bh=MX0KHwtf7jW2JZ70ZmW7pDV6LzTq4KVTfuMog0f/j2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRqPZuBQ5zYygzFzcAw+q8+D0WRNoE5ZG73vbDGXcbe5sBYHgw9vHB+T0f/G65HYZVu/XlK3+fYSXev9ocUJlUj1Up5lMMb+JeSyt+ErUmc3grTAMRy5aaHHL2JEk6MjVzJunBnaHZWRzmr12eTqBuNHCseiB1t+Rq1d1LV4fEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+XvDHM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C8AC4CEF0;
	Mon, 22 Sep 2025 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758551353;
	bh=MX0KHwtf7jW2JZ70ZmW7pDV6LzTq4KVTfuMog0f/j2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d+XvDHM8Q9YaaiyUriM/wbTolEbpl6C7sk+olpV+PHY4bAb8Zt+5cQDEP1AS+Ykxx
	 yc/yYDRmepPQOR7pCfp2KIbvZaxAVW/yE0/tVuVGwky5FkdmJ4mYECdPnZHeZT9FkD
	 2PT//UYKYwztqbnjaTbJtnq/QAVqBZ21KQrBJ2NA9ZbbOvwIaJEZSC56M7rE7u8DVw
	 Ou1nDwukrw07RZ2On8c6Ef2Op9DN6w5Gq0+sDX6opuzd780RfEDNCOlmOaPIo+WvSs
	 zj9+wCxHf3s/faWawJ8CrrWMvNY0lvYKv1iZ/yStqt/zSRooMdgubKmVJXWVUpWscI
	 ckZRvB2qzogRA==
Message-ID: <0fbaef6f-80ad-4885-ba2b-6a9567f01042@kernel.org>
Date: Mon, 22 Sep 2025 10:29:11 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>
 <175851511014.1696783.3027085648108996983@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175851511014.1696783.3027085648108996983@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Neil -

On 9/21/25 9:25 PM, NeilBrown wrote:
>> +Patch preparation
>> +~~~~~~~~~~~~~~~~~
>> +Like all kernel submissions, please use tagging to identify all
>> +patch authors. Reviewers and testers can be added by replying to
>> +the email patch submission. Email is extensively used in order to
>> +publicly archive review and testing attributions, and will be
>> +automatically inserted into your patches when they are applied.
>> +
>> +The patch description must contain information that does not appear
>> +in the body of the diff. The code should be good enough to tell a
>> +story -- self-documenting -- but the patch description needs to
>> +provide rationale ("why does NFSD benefit from this change?") or
>> +a clear problem statement ("what is this patch trying to fix?").

> These paras look to be completely generic - not at all nfsd-specific.
> Do they belong here?

Can you clarify which paragraphs you mean, exactly? Maybe the whole
section?

For context:

IMHO these comments aren't necessarily generic because I haven't seen
them in other documents, and we seem to get a lot of patches where the
description is just "Make this change".

The comments about tagging: I think other subsystems might not mind
seeing Cc: stable in the initial submission. NFS maintainers (even on
the client side) like to add those themselves.

I'd like to encourage contributors to get the Fixes: tag right before
submitting, too. It saves me a little incremental time per patch.

And, some of this text was cribbed from netdev's policy document, not
from a generic document, suggesting these are subsystem addendums.


> I expect more of a patch description than is given here.  I agree that
> "code should be good enough to tell a store" but I don't think that a
> patch can by itself be good enough.
> So I think that a patch description should describe the patch -
> particularly how the various changes in the patch relate.
> 
> With a good patch description, I should be able to then read the patch
> and every change will make sense in the context provided by the
> description.  It isn't just "Why", it is also "how".

I can add these remarks.


-- 
Chuck Lever


Return-Path: <linux-nfs+bounces-14614-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD8B9187E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F04C1620BD
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D626FDB6;
	Mon, 22 Sep 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnHBKhax"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C3191493
	for <linux-nfs@vger.kernel.org>; Mon, 22 Sep 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549389; cv=none; b=hU/28zO3K+iXY62kDZeNaYZ4p1CBdi1uWDqtCBXUzkn5maLPah+mEFH6IhNcu/CDXvvIObm876gzoQTX2QRuV3tqUjk3GT1sb1dyYXjWkbR0K+JJs5XN1jsmbacCpqUjHgiLiMdkGIl1TKeZ1ZKaeFutOaj+aGkCAqZgC5n0Wnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549389; c=relaxed/simple;
	bh=gXUXnVhaFPOYjDlNr86M3wRlQKZVPhTDAhFEXex64qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qp2evvwLjblf66N/Wofx58UGn3DLPa12BatZTInDtvhN/svBW1X0OchkxIuf3rAqVhqpgPjoq5MBQLEoWBos+o3FuXSfL7tkazIrg0iCS+vghxPWFNFWBgXNHtN62NZIXDDy6qwrc6gTKqpLSu1CCcuusyniS8LTl4TsqgqKHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnHBKhax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC10C4CEF0;
	Mon, 22 Sep 2025 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758549387;
	bh=gXUXnVhaFPOYjDlNr86M3wRlQKZVPhTDAhFEXex64qM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GnHBKhaxa+Pq9ADzR9oCWhZunYqPgK6SJ5v3MHMe9sGV1WjnFXeJDfou8pqLuws6Z
	 APNtrH4uBeJcNXyR4nkWgH5yTIPt9Wd/SJVZ66OSSxW6DvvXGQBi3n7uCLSOJHcD76
	 Xt/oD50naVc20mzaz+x5g7kPZn/9N0H5mapjmjEFSx9/hKDZztEUbLHpHFFVl2ZjlG
	 WhL9K1hT9O8mrueoUQD0t91+/rw/uuu6qI8D4JOQEjtP7pxko5pPqbYtaK2bdykQXs
	 GsMKxE7TtoBMgxA9b8d6KVlKVRWsXognyCyB2WX9QmBOuGIn6Lxdl3YXnKtvc187FC
	 CQBASOk2oykUA==
Message-ID: <499430de-c15a-480c-a946-84cbf21d4682@kernel.org>
Date: Mon, 22 Sep 2025 09:56:25 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>
 <cde46e50575ba2e7578d3cb25d77bb7bb3405405.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <cde46e50575ba2e7578d3cb25d77bb7bb3405405.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/25 3:25 AM, Jeff Layton wrote:
>> +Community roles and their authority
>> +-----------------------------------
>> +The purpose of Linux subsystem communities is to provide active
>> +stewardship of a narrow set of source files in the Linux kernel.
>> +This can include managing user space tooling as well.
>> +
>> +To contextualize the structure of the Linux NFS community that
>> +is responsible for stewardship of the NFS server code base, we
>> +define the community roles here.
>> +
>> +One person often takes on more than one of these roles. One role
>> +can be filled by multiple people. The roles and the people filling
>> +them are often fluid. Sometimes a person will say "Wearing my XYZ
>> +hat" -- which means, roughly, "speaking as the person filling the
>> +XYZ role."
>> +
> For completeness, I'd add a "**Maintainer**" section below too.

Thanks for your comments.

The role list below actually contains all of the maintainer's tasks,
so IMHO the list isn't lacking completeness. The list could include a
"Maintainer" role in the list simply because it's a term we refer
to in every day conversation... or... I could add a paragraph up front
that explains that the term "Maintainer" is a combination of these
roles.

(And above, snipped out, the "Key Cycle Dates" section title comes
from Documentation/maintainer/maintainer-entry-profile.rst. I'll
think of a more accurate section title).


>> +- **Contributor** : Anyone who submits a code change, bug fix,
>> +  recommendation, documentation fix, and so on. A contributor can
>> +  submit regularly or infrequently.
>> +
>> +- **Outside Contributor** : A contributor who is not a regular actor
>> +  in the Linux NFS community. This can mean someone who contributes
>> +  to other parts of the kernel, or someone who just noticed a
>> +  mis-spelling in a comment and sent a patch.
>> +
>> +- **Reviewer** : Someone who is named in the MAINTAINERS file as a
>> +  reviewer is an area expert who can request changes to contributed
>> +  code, and expects that contributors will address the request.
>> +
>> +- **Upstream Release Manager** : This role is responsible for
>> +  curating contributions into a branch, reviewing test results, and
>> +  then sending a pull request during merge windows. There is a
>> +  trust relationship between the release manager and Linus.
>> +
>> +- **Bug Triager** : Someone who is a first responder to bug reports
>> +  submitted to the linux-nfs mailing list or the bugzilla and helps
>> +  troubleshoot and identify next steps.
>> +
>> +- **Testing Lead** : The testing lead builds and runs the test
>> +  infrastructure for the subsystem. The testing lead can ask for
>> +  patches to be dropped because of ongoing high defect rates.
>> +
>> +- **LTS Maintainer** : The LTS maintainer is responsible for managing
>> +  the Fixes: and Cc: stable annotations on patches, and seeing that
>> +  patches that cannot be automatically applied to LTS kernels get
>> +  proper backports as necessary.
>> +
>> +- **Community Manager** : This umpire role can be asked to call balls
>> +  and strikes during conflicts, but is also responsible for ensuring
>> +  the health of the relationships within the community and
>> +  facilitating discussions on long-term topics such as how to manage
>> +  growing technical debt.


-- 
Chuck Lever


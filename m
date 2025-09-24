Return-Path: <linux-nfs+bounces-14636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE9B97EFD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 02:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66E31894BC7
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 00:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1EB1B4231;
	Wed, 24 Sep 2025 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUi+JMJb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845A18B0A
	for <linux-nfs@vger.kernel.org>; Wed, 24 Sep 2025 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674691; cv=none; b=Y7d38Zru2hz2JNUYDYtdrXXUXdmOnEa2qyorjxG9OlttjfL7I/LI1ocp5xkCvGtgd5N983N4qLt/7z21VVd1m4xmeWdmK92I1xIi5q7wvcQaBpXskt2LBeM/wYviatE8VvIIVo3yob9uGBCuX8zyUPpscOt5dl30ukxhNo4P+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674691; c=relaxed/simple;
	bh=0ZSyyoYApH8/Z0IZeHIxEyfX2B+LTjQ2+CUXOOs/5Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npSQkCFGbvWZ84a4j7u0WKMYY6lrshg2/yh7jXHGT9Sd1z9rg0Uw2OkC3SoDgiUdZNYwYJM/q10ZARxF+MHVwOZLpt7yBK/V7R2AW8ad0v7hzomQpYtrGyJax4uZD4CR2KYeV4OuaGpNQ/dCTI4m6oqLtsK3LHLgARM8gEKOsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUi+JMJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BA1C4CEF5;
	Wed, 24 Sep 2025 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758674690;
	bh=0ZSyyoYApH8/Z0IZeHIxEyfX2B+LTjQ2+CUXOOs/5Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUi+JMJbcrqTRo2mAAo8cnw8dLwuTJVqmzq2wp4b5vk3/eNskgMKakzfcLse6sifo
	 4zLaE5ZqsPQ9d28sC2xU4kMq88y+bvwO27UjKllgj2xeUT7PbR+rXHb1KWMXn/Gjla
	 tp3dyX0kpVUvVi7BrZ1cLP+r4rkEuLl4wIdepufBcJIh91gV9pQxE6BQuFJgQEpi5V
	 OXB2wcLEN1Vsb1EVxjiowCS+QkzIKpsUI4L7A4kMF1XzgNc527m8baR/degv4ij1am
	 AkmBXB/uVQcxtzRA0YKIQ3a2eb06e7ZsVttjG+OIuG+jYPyd5H0GDPwz0nJ8F2mpVI
	 T2b5JM5SvZ2kQ==
Date: Tue, 23 Sep 2025 17:44:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
Message-ID: <20250924004450.GK8117@frogsfrogsfrogs>
References: <20250921194353.66095-1-cel@kernel.org>
 <cde46e50575ba2e7578d3cb25d77bb7bb3405405.camel@kernel.org>
 <499430de-c15a-480c-a946-84cbf21d4682@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499430de-c15a-480c-a946-84cbf21d4682@kernel.org>

On Mon, Sep 22, 2025 at 09:56:25AM -0400, Chuck Lever wrote:
> On 9/22/25 3:25 AM, Jeff Layton wrote:
> >> +Community roles and their authority
> >> +-----------------------------------
> >> +The purpose of Linux subsystem communities is to provide active
> >> +stewardship of a narrow set of source files in the Linux kernel.
> >> +This can include managing user space tooling as well.
> >> +
> >> +To contextualize the structure of the Linux NFS community that
> >> +is responsible for stewardship of the NFS server code base, we
> >> +define the community roles here.
> >> +
> >> +One person often takes on more than one of these roles. One role
> >> +can be filled by multiple people. The roles and the people filling
> >> +them are often fluid. Sometimes a person will say "Wearing my XYZ
> >> +hat" -- which means, roughly, "speaking as the person filling the
> >> +XYZ role."
> >> +
> > For completeness, I'd add a "**Maintainer**" section below too.
> 
> Thanks for your comments.
> 
> The role list below actually contains all of the maintainer's tasks,
> so IMHO the list isn't lacking completeness. The list could include a
> "Maintainer" role in the list simply because it's a term we refer
> to in every day conversation... or... I could add a paragraph up front
> that explains that the term "Maintainer" is a combination of these
> roles.

I'm not an nfsd person, but speaking as an ex-maintainer who wrote a
maintainer entry profile doc for xfs, I think what Chuck is trying to do
here is to break up the maintainer duties into well defined roles and
then to encourage *separate* people to own these roles.  Ideally this
will give nfsd participants a sense of shared ownership of the whole
project, and solve some scaling/burnout problems.

The hard part ofc is actually getting companies to encourage their
people to step up, and making it stick.

> (And above, snipped out, the "Key Cycle Dates" section title comes
> from Documentation/maintainer/maintainer-entry-profile.rst. I'll
> think of a more accurate section title).

<shrug> Or you could define some key cycle dates.  Do you want to
require that new feature patchsets must be in the review pipeline before
-rc2 so that you can put whatever passes review into for-next just after
-rc4?  Or specify that bugfixes completing review after -rc6 will just
get rolled into the next merge window?

> >> +- **Contributor** : Anyone who submits a code change, bug fix,
> >> +  recommendation, documentation fix, and so on. A contributor can
> >> +  submit regularly or infrequently.
> >> +
> >> +- **Outside Contributor** : A contributor who is not a regular actor
> >> +  in the Linux NFS community. This can mean someone who contributes
> >> +  to other parts of the kernel, or someone who just noticed a
> >> +  mis-spelling in a comment and sent a patch.
> >> +
> >> +- **Reviewer** : Someone who is named in the MAINTAINERS file as a
> >> +  reviewer is an area expert who can request changes to contributed
> >> +  code, and expects that contributors will address the request.
> >> +
> >> +- **Upstream Release Manager** : This role is responsible for
> >> +  curating contributions into a branch, reviewing test results, and
> >> +  then sending a pull request during merge windows. There is a
> >> +  trust relationship between the release manager and Linus.
> >> +
> >> +- **Bug Triager** : Someone who is a first responder to bug reports
> >> +  submitted to the linux-nfs mailing list or the bugzilla and helps
> >> +  troubleshoot and identify next steps.
> >> +
> >> +- **Testing Lead** : The testing lead builds and runs the test
> >> +  infrastructure for the subsystem. The testing lead can ask for
> >> +  patches to be dropped because of ongoing high defect rates.
> >> +
> >> +- **LTS Maintainer** : The LTS maintainer is responsible for managing
> >> +  the Fixes: and Cc: stable annotations on patches, and seeing that
> >> +  patches that cannot be automatically applied to LTS kernels get
> >> +  proper backports as necessary.
> >> +
> >> +- **Community Manager** : This umpire role can be asked to call balls
> >> +  and strikes during conflicts, but is also responsible for ensuring
> >> +  the health of the relationships within the community and
> >> +  facilitating discussions on long-term topics such as how to manage
> >> +  growing technical debt.
> 
> 
> -- 
> Chuck Lever


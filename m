Return-Path: <linux-nfs+bounces-14612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2CCB8EEEF
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 06:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782D2171D2E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 04:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A54259CA0;
	Mon, 22 Sep 2025 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ApGzHCcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDS2ZSuw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779721519AC
	for <linux-nfs@vger.kernel.org>; Mon, 22 Sep 2025 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758515120; cv=none; b=FnMuOlSJr5K69RkYcIxQFs4GH/9YzUeyzqK/LDDPrhd01ijGUWhrg/NR4u1tln53raUT35DGZppf5ltXBKjrfeSiboBvTrsMIIG8xMglEfCTqpQ9rqXAFLGqobYEwrFlPSdmIfGbzWX3rI8LdcIFmalbAU6gUPU3yWmwJjH+LiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758515120; c=relaxed/simple;
	bh=NRVKEPqzNSlZkLAmC6dSnypVVk0yTvcoww2MVKDFi0U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Q61qH8w2qdYjYWldA0WJcz4SClQNZNwtB3TKF9FLYN+tAosEvX1oqed6lyB5frrtIPqUbJOYGssLYQbfVlCVHyOisu6+Z64b/3fK2aSKsCfK74lGX5KFn9uhbsd2Tm75wkFL8LMm/fphHH18VY08tRgGUuzQr1O4K8Bfaq4vH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ApGzHCcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDS2ZSuw; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74EFF1400065;
	Mon, 22 Sep 2025 00:25:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Sep 2025 00:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758515116; x=1758601516; bh=4Dv76T4BKI4i2wcRM3Uozzgfdnz9zB3gUg+
	AYcuXTOA=; b=ApGzHCcdPOpAe1J/4dMq7ZsVtkTz8wVWF3HcKyt3lY9TsOEwtPR
	cPB2taMGEwCo8jDrxohXMuwODRTOCJ3cSVmg9GWiSmpmKMTkx/h7ns2KVSS5r1b8
	8p+T0fFSrVwu9zLKPIipJsDmwu0ezdOSPzcTcCEnREuBiL77oFjqU5o4GAjQ/D3G
	Yg6z7HHOvcFXmHTxHjs6Yhb4zTv0iFbXLX/9PcPgEgI/8gmSHdBcJRq0FORasKUa
	m0npfIWv2IpykBmVRSQ21IDCJG0HlhqR/KHgJH1DweZo92YBIKTMXdnZzNuSUNYH
	oT+ZkZA0oxetrgO3+10tIkwCApgmVYVAYZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758515116; x=
	1758601516; bh=4Dv76T4BKI4i2wcRM3Uozzgfdnz9zB3gUg+AYcuXTOA=; b=j
	DS2ZSuw1Xo92ZqGz+LjKOstm6DZVk1XvmlNNYRWZX6UyasQLoaL4rsM61toT/6cA
	uB8XxAPsaj5nrdaQ6JqrjzLSaCdXAdYnIsDuoQV4JDP73j13a9Mc+gbe2CaNuzwA
	uj0tsJ67Z+T5a+HWVrNEoRHgFMblOXk0+ZZ1QuGOUqRC5w9ZwpO5gpPyv66N/V7U
	hpLaT9KqRspS+DBLml8V6YBjBuze/V14EqEoYwn+SJO7sYAikwi6SenUANXE5vAp
	wme5egXMxYmL9KquIJ2tmlHWuw1ersc+yKjUaSASli3OfAxOQq4BSww3MIZAtgGL
	vdrBlCNiFBzU9D9C0h1EA==
X-ME-Sender: <xms:rM_QaGxu231BC5zxH7E61xF_HTNLR0m-J0zqJCoDt9xP9cPU_1WvJA>
    <xme:rM_QaPLgULb9-BYvgbRu7X9AYkFeWoKwmTjSjA-j6ygmd_k5naqDAT55J9C2ifuYN
    -qjYhpkhu0r6g>
X-ME-Received: <xmr:rM_QaIHoLZOg9iPAz472eKtiZcmVgiwDzOqKXDdpgX-ahrncl_rxpjRciTgMcULCA3yOMqq5Fu5XuDxkkaLIZq73_CHuKSq70w9JLgj5P9Ob>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ehgfekkeeitdegfeetudekvdelleeiffduueegheeigefhteeuveefieefueegveenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgr
    ihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehmtghgrhhofheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rM_QaL8U3J-W4BDVKgBStAAgegbwaGd8ZHIpL3GdKubYntQIVRB0YA>
    <xmx:rM_QaIIlDp_wXD2cZbvw1OvmboJEvQnbnlLk5RsCymAFy6MeQ3N_5A>
    <xmx:rM_QaJvAl4dcblsL8IMVZDWrl6udvcy5Dvlgu67iWDV9x8ASnKVqUQ>
    <xmx:rM_QaPAqWINVZkGLfSGQ9XGKzb4s0AfYiG7A4bNmvpTQPiJGSyqb7g>
    <xmx:rM_QaOeu7FdkGRAyPLvgjnfz-aVQ0OmzczO_V2F6feFkbb-JKoxv5gMn>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:25:13 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
In-reply-to: <20250921194353.66095-1-cel@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>
Date: Mon, 22 Sep 2025 14:25:10 +1000
Message-id: <175851511014.1696783.3027085648108996983@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 22 Sep 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Steer contributors to NFSD's patchworks instance, list our patch
> submission preferences, and more.
>=20
> The new document is based on the existing netdev and xfs subsystem
> policy documents.
>=20
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  .../nfs/nfsd-maintainer-entry-profile.rst     | 396 ++++++++++++++++++
>  .../maintainer/maintainer-entry-profile.rst   |   1 +
>  MAINTAINERS                                   |   1 +
>  3 files changed, 398 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/nfsd-maintainer-entry-pro=
file.rst
>=20
> diff --git a/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rs=
t b/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
> new file mode 100644
> index 000000000000..1f284587ad72
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
> @@ -0,0 +1,396 @@
> +NFSD Maintainer Entry Profile
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +A Maintainer Entry Profile supplements the top-level process
> +documents (submitting-patches, submitting drivers...) with customs
> +that are specific to a subsystem and its maintainers. A contributor
> +uses this document to set their expectations and avoid common
> +mistakes. A maintainer may use these profiles to look across
> +subsystems for opportunities to converge on best common practices.
> +
> +Overview
> +--------
> +The Network File System (NFS) is a standardized family of network
> +protocols that enable access to files across a set of network-
> +connected peer hosts. Applications on NFS clients access files that
> +reside on file systems that are shared by NFS servers. A single
> +network peer can act as both an NFS client and an NFS server.
> +
> +NFSD refers to the NFS server implementation included in the Linux
> +kernel. An in-kernel NFS server has faster access to files stored
> +in file systems local to that server.

"faster" than what?

>                                          NFSD can share files stored
> +on most of the file system types native to Linux, including xfs,
> +ext4, btrfs, and tmpfs.

In general any filesystem which supports export_operations...

> +
> +Mailing list
> +------------
> +The linux-nfs@vger.kernel.org mailing list is a public list. Its
> +purpose is to enable collaboration among developers working on the
> +Linux NFS stack, both client and server. It is not a place for
> +conversations that are not related directly to the Linux NFS stack.
> +
> +The linux-nfs mailing list is archived on lore.kernel.org.
> +
> +The Linux NFS community does not have a chat room.
> +
> +Reporting bugs
> +--------------
> +If you experience an NFSD-related bug on a distribution-built
> +kernel, please start by working with your Linux distributor.
> +
> +Bug reports against upstream Linux code bases are welcome on the
> +linux-nfs@vger.kernel.org mailing list, where some active triage
> +can be done. NFSD bugs may also be reported in the Linux kernel
> +community's bugzilla at:
> +
> +  https://bugzilla.kernel.org
> +
> +Please file NFSD-related bugs under the "Filesystems/NFSD"
> +component. In general, including as much detail as possible is a
> +good start.
> +
> +For user space software related to NFSD, such as mountd or the
> +exportfs command, report problems on linux-nfs@vger.kernel.org.
> +You might be asked to move the report to a specific bug tracker.
> +
> +Contributor's Guide
> +-------------------
> +
> +Standards compliance
> +~~~~~~~~~~~~~~~~~~~~
> +The NFSD community strives to provide an NFS server implementation
> +that interoperates with standards-compliant NFS client
> +implementations. This is done by staying close to the normative
> +mandates in IETF's NFS standards documents.
> +
> +It is always useful to provide an RFC and section citation in a
> +code comment where behavior deviates from the standard (and even
> +when the behavior is compliant but the implementation is curious).
> +
> +On the rare occasion when deviation from standards are needed,
> +clear documentation of the use case or deficiencies in the
> +standard is a required part of code documentation.
> +
> +Note that care must always be taken to avoid leaking local error
> +codes (ie, errnos) to clients of NFSD. A proper NFS status code
> +is always required.
> +
> +Testing
> +~~~~~~~
> +The kdevops project
> +
> +  https://github.com/linux-kdevops/kdevops
> +
> +contains several NFS-specific workflows, as well as the community
> +standard fstests suite. These workflows are based on open source
> +testing tools such as ltp and fio. Contributors are encouraged to
> +use these tools without kdevops, or contributors should install and
> +use kdevops themselves to verify their patches before submission.
> +
> +Patch preparation
> +~~~~~~~~~~~~~~~~~
> +Like all kernel submissions, please use tagging to identify all
> +patch authors. Reviewers and testers can be added by replying to
> +the email patch submission. Email is extensively used in order to
> +publicly archive review and testing attributions, and will be
> +automatically inserted into your patches when they are applied.
> +
> +The patch description must contain information that does not appear
> +in the body of the diff. The code should be good enough to tell a
> +story -- self-documenting -- but the patch description needs to
> +provide rationale ("why does NFSD benefit from this change?") or
> +a clear problem statement ("what is this patch trying to fix?").

These paras look to be completely generic - not at all nfsd-specific.
Do they belong here?

I expect more of a patch description than is given here.  I agree that
"code should be good enough to tell a store" but I don't think that a
patch can by itself be good enough.
So I think that a patch description should describe the patch -
particularly how the various changes in the patch relate.

With a good patch description, I should be able to then read the patch
and every change will make sense in the context provided by the
description.  It isn't just "Why", it is also "how".

> +
> +Brief benchmarking results and stack traces are also welcome
> +sources of context. And, functioal test results should be included
                            functional

> +in patch descriptions.
> +
> +Identify the point in history that the issue being addressed was
> +introduced by using a Fixes: tag.
> +
> +Note in the patch description if that point in history cannot be
> +determined -- that is, no Fixes: tag can be provided. In this case,
> +please make it clear to maintainers that an LTS backport is needed
> +even though there is no Fixes: tag.
> +
> +The NFSD maintainers prefer to add stable tagging themselves, after
> +public discussion in response to the patch submission. Contributors
> +can suggest stable tagging, but be aware that most tools will add
> +the stable Cc's when you post the submission, which is generally
> +a nuisance but can also result in outing an embargoed security
> +issue accidentally. So don't add "Cc: stable" unless you are
> +absolutely sure the patch needs to go to stable during the initial
> +submission process.
> +
> +If your change is a bug fix, make sure your patch description
> +indicates the end-user visible symptom, the underlying reason as to
> +why it happens, and then, if necessary, explain why the fix proposed
> +is the best way to get things done.
> +
> +Break your work into incremental changes that each look "obviously
> +correct". Scrub out any incidental clean-ups that are not necessary
> +to the purpose of your patches -- those should be included as
> +separate patches.

I often include near-by white-space cleanup in a patch.  This suggests I
shouldn't, but could have an introductory white-space cleanup - yes?


> +
> +A patch series must be fully bisectable. The kernel needs to fully
> +compile after each patch. A series should not break some function
> +in one patch then fix it in a later patch.
> +
> +Don't mangle white space, and as is common, don't mis-indent
> +function arguments that span multiple lines. Add local variables in
> +reverse Christmas tree order.
> +
> +Put yourself in the shoes of the reviewers. Each patch is read
> +separately and therefore should constitute a comprehensible step
> +towards your stated goal.
> +
> +Avoid frequently reposting large series with only small changes. As
> +a rule of thumb, posting substantial changes more than once a week
> +will result in reviewer overload.
> +
> +Post changes to kernel source code and user space source code as
> +separate series. You can connect the two series with comments in
> +your cover letters.
> +
> +Patch submission
> +~~~~~~~~~~~~~~~~
> +Patches to NFSD are accepted only via the kernel's email-based
> +review process.
> +
> +Just before each submission, rebase your patch or series on the
> +nfsd-testing branch at
> +
> +  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> +
> +The NFSD subsystem is maintained separately from the Linux in-kernel
> +NFS client. The NFSD maintainers do not normally take submissions
> +for client changes, nor can they respond authoritatively to bug and
> +feature requests for NFS client code.
> +
> +This means that contributors might be asked to resubmit patches if
> +they were emailed to the incorrect set of maintainers and reviewers.
> +This is not a rejection, but simply a correction of the submission
> +process.
> +
> +The proper set of email addresses for NFSD patches are:
> +
> +To: the NFSD maintainers and reviewers listed in MAINTAINERS
> +Cc: linux-nfs@vger.kernel.org and optionally linux-kernel@
> +
> +If there are other subsystems involved in the patches (for example
> +MM or RDMA) their primary mailing list address can be included in
> +the Cc: field. Other contributors and interested parties may be
> +included there as well.
> +
> +In general we prefer that contributors use common patch email tools
> +such as "git send-email" or "stg email format/send", which tend to
> +get the details right without a lot of fuss.
> +
> +A series consisting of a single patch is not required to have a
> +cover letter. However, a cover letter can be included if there is
> +substantial context that is not appropriate to include in the
> +patch description.
> +
> +Please note that cover letters are not part of the work that is
> +committed to the kernel source code base or its commit history.
> +Therefore always try to keep the most pertinent information in the
> +patch descriptions.
> +
> +Design documentation is welcome, but as cover letters are not
> +preserved, a perhaps better option is to include a patch that adds
> +such documentation under Documentation/filesystems/nfs/.
> +
> +Reviewers will ask about test coverage and what use cases the
> +patches are expected to address. Please be prepared to answer these
> +questions.
> +
> +Review requests from maintainers might be politely stated, but in
> +general, these are not optional to address when they are actionable.
> +If necessary, the maintainers retain the right to not apply patches
> +when contributors refuse to address reasonable requests.
> +
> +Generally the NFSD maintainers ask for a reposts even for simple
> +modifications in order to publicly archive the request and the
> +resulting repost before it is pulled into the NFSD trees. This
> +also enables us to rebuild a patch series quickly without missing
> +changes that might have been discussed via email.
> +
> +Remember, there are only a handful of subsystem maintainers and
> +reviewers, but potentially many sources of contributions. The
> +maintainer, therefore, is always the less scalable resource. Be
> +kind to your friendly neighborhood maintainer.
> +
> +Key Cycle Dates

"Dates" doesn't seems to related the the content.
This is more about process, or sequencing or timing.

> +~~~~~~~~~~~~~~~
> +Currently the NFSD patch queues are maintained in branches here:
> +
> +  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> +
> +The NFSD maintainers apply patches initially to nfsd-testing, and
> +often do so while review is ongoing. nfsd-testing is a topic
> +branch, so it can change frequently, it will be rebased, and your
> +patch might get dropped if there is a problem with it.
> +
> +Generally a script-generated "thank you" email will indicate when
> +your patch has been added to the nfsd-testing branch in the repo
> +mentioned above. You can track the progress of your patch using the
> +linux-nfs patchworks instance:
> +
> +  https://patchworks.kernel.org/linux-nfs/
> +
> +While your patch is in nfsd-testing, it is exposed to a variety
> +of test environments, including community zero-day bots, static
> +analysis tools, and NFSD continuous integration testing. The soak
> +period is typically three to four weeks.
> +
> +Once that period is up, surviving patches are moved to nfsd-next.
> +That branch is merged into linux-next and fs-next on a nightly
> +basis.
> +
> +All patches that survive in nfsd-next are included in the next NFSD
> +merge window pull request. These windows occur once every eight
> +weeks.
> +
> +In some circumstances, a fix might be needed in the stable or LTS
> +kernels on short notice. Please make it clear when submitting a
> +patch that immediate action is needed. Otherwise, we prefer that
> +/all/ patches go through the long cycle described above to avoid
> +introducing regressions.
> +
> +Sensitive patch submissions and bug reports
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +CVEs are generated by specific members of the Linux kernel community
> +and several external entities. The Linux NFS community does not emit
> +or assign CVEs. CVEs are assigned after an issue and its fix are
> +known.
> +
> +However, the NFSD maintainers sometimes receive sensitive security
> +reports, and at times these are significant enough to need to be
> +embargoed. In such rare cases, fixes can be developed and reviewed
> +out of the public eye.
> +
> +LLM-generated submissions
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +The Linux kernel community as a whole is still exploring the new
> +world of LLM-generated code. The NFSD maintainers will entertain
> +submission of patches that are partially or wholy generated by
> +LLM-based development tools. Such submissions are held to the
> +same standards as submissions created entirely by human authors.
> +
> +Therefore:
> +
> +- The human contributor identifies themselves via a Signed-off-by:
> +  tag. This tag counts as a DoC.
> +
> +- The human contributor is solely responsible for code provenance
> +  and any contamination by inadvertently-included code with a
> +  conflicting license, as usual.
> +
> +- The human contributor must be able to answer and address review
> +  questions. A patch description such as "This fixed my problem
> +  but I don't know why" is not acceptable.
> +
> +- The contribution is subjected to the same test regimen as all
> +  other submissions.
> +
> +- An indication (via a Generated-by: tag or otherwise) that the
> +  contribution is LLM-generated is not required.
> +
> +It is easy to address review comments and fix requests in LLM
> +generated code. So easy, in fact, that it becomes tempting to repost
> +refreshed code immediately. Please resist that temptation.
> +
> +As always, please do not repost patches frequently.
> +
> +Clean-up patches
> +~~~~~~~~~~~~~~~~
> +The NFSD maintainers discourage patches which perform simple clean-
> +ups, which are not in the context of other work. For example:
> +
> +* Addressing ``checkpatch.pl`` warnings after merge
> +* Addressing :ref:`Local variable ordering<rcs>` issues
> +* Addressing long-standing whitespace damage
> +
> +This is because it is felt that the churn that such changes produce
> +comes at a greater cost than the value of such clean-ups.
> +
> +Conversely, spelling and grammar fixes are encouraged.
> +
> +Stable and LTS support
> +----------------------
> +Upstream NFSD continuous integration testing runs against LTS trees
> +whenever they are updated.
> +
> +Please indicate when a patch containing a fix needs to be considered
> +for LTS kernels, either via a Fixes: tag or explicit mention.
> +
> +Feature requests
> +----------------
> +Feature requests can sometimes be nebulous. A requester might not
> +understand what a "use case" or "user story" is. These are
> +descriptive paradigms that developers and architects use to
> +understand what is required of a design.
> +
> +In order to prevent contributors and maintainers from becoming
> +overwhelmed, we won't be afraid of saying "no" politely. However
> +we can take nebulous requests and add them to our NFSD project
> +Kanban board, to be fleshed in over time into an actionable
> +plan for building a new feature.
> +
> +There is no one way to make an official feature request, but
> +discussion about the request should eventually make its way to
> +the linux-nfs@vger.kernel.org mailing list for public review by
> +the community.
> +
> +Community roles and their authority
> +-----------------------------------
> +The purpose of Linux subsystem communities is to provide active
> +stewardship of a narrow set of source files in the Linux kernel.
> +This can include managing user space tooling as well.
> +
> +To contextualize the structure of the Linux NFS community that
> +is responsible for stewardship of the NFS server code base, we
> +define the community roles here.
> +
> +One person often takes on more than one of these roles. One role
> +can be filled by multiple people. The roles and the people filling
> +them are often fluid. Sometimes a person will say "Wearing my XYZ
> +hat" -- which means, roughly, "speaking as the person filling the
> +XYZ role."
> +
> +- **Contributor** : Anyone who submits a code change, bug fix,
> +  recommendation, documentation fix, and so on. A contributor can
> +  submit regularly or infrequently.
> +
> +- **Outside Contributor** : A contributor who is not a regular actor
> +  in the Linux NFS community. This can mean someone who contributes
> +  to other parts of the kernel, or someone who just noticed a
> +  mis-spelling in a comment and sent a patch.
> +
> +- **Reviewer** : Someone who is named in the MAINTAINERS file as a
> +  reviewer is an area expert who can request changes to contributed
> +  code, and expects that contributors will address the request.
> +
> +- **Upstream Release Manager** : This role is responsible for
> +  curating contributions into a branch, reviewing test results, and
> +  then sending a pull request during merge windows. There is a
> +  trust relationship between the release manager and Linus.
> +
> +- **Bug Triager** : Someone who is a first responder to bug reports
> +  submitted to the linux-nfs mailing list or the bugzilla and helps
> +  troubleshoot and identify next steps.
> +
> +- **Testing Lead** : The testing lead builds and runs the test
> +  infrastructure for the subsystem. The testing lead can ask for
> +  patches to be dropped because of ongoing high defect rates.
> +
> +- **LTS Maintainer** : The LTS maintainer is responsible for managing
> +  the Fixes: and Cc: stable annotations on patches, and seeing that
> +  patches that cannot be automatically applied to LTS kernels get
> +  proper backports as necessary.
> +
> +- **Community Manager** : This umpire role can be asked to call balls
> +  and strikes during conflicts, but is also responsible for ensuring
> +  the health of the relationships within the community and
> +  facilitating discussions on long-term topics such as how to manage
> +  growing technical debt.
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Docume=
ntation/maintainer/maintainer-entry-profile.rst
> index cda5d691e967..f185a5c86eef 100644
> --- a/Documentation/maintainer/maintainer-entry-profile.rst
> +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -108,5 +108,6 @@ to do something different in the near future.
>     ../process/maintainer-netdev
>     ../driver-api/vfio-pci-device-specific-driver-acceptance
>     ../nvme/feature-and-quirk-policy
> +   ../filesystems/nfs/nfsd-maintainer-entry-profile
>     ../filesystems/xfs/xfs-maintainer-entry-profile
>     ../mm/damon/maintainer-profile
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6206963efbf..b943cf6a6573 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13319,6 +13319,7 @@ R:	Dai Ngo <Dai.Ngo@oracle.com>
>  R:	Tom Talpey <tom@talpey.com>
>  L:	linux-nfs@vger.kernel.org
>  S:	Supported
> +P:	Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
>  B:	https://bugzilla.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>  F:	Documentation/filesystems/nfs/
> --=20
> 2.51.0
>=20
>=20

Very thorough, and mostly good.
Thanks for this,
NeilBrown


Return-Path: <linux-nfs+bounces-14613-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF7B8FFED
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73E5188C9AC
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Sep 2025 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A93267AF2;
	Mon, 22 Sep 2025 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UezQ6koZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131013EA8D
	for <linux-nfs@vger.kernel.org>; Mon, 22 Sep 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536728; cv=none; b=WgEyK27u8Pjk0oRUOY8eGAb3AVAhP0mBUt9EOtbXHeTEjtqS6JBST2gxaM5vAbUiuwJ3L4tS7cbk8gQ0Ldo9OdWcKJ522JBDLfDW+viRHoW8jEiR52H6wuRhVIU081wKeMrdJet/u4faGdJkaKKL+d5ekPCzilo5SI8dgPgHyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536728; c=relaxed/simple;
	bh=YASylBkjGabVP4HGjr25+gkAJ+x3Egeor5EjewJH1mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etc7SX4/beWFE3d2PTPZU7iGnUt0qy0nqpzc1M4w1EyVbhHOgLB0opMsnlBag1oCN1tjAhg4xAIvsscZJs/e1EFFwuD1FkmZGen7AbwA8tRo4Nko6VSa/EFgWYL9t5ajXppS8vSgJxJp6VuBSGSg6EosLyDWA1SldZ3OrKlTjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UezQ6koZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D44C4CEF0;
	Mon, 22 Sep 2025 10:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758536727;
	bh=YASylBkjGabVP4HGjr25+gkAJ+x3Egeor5EjewJH1mo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UezQ6koZ5nyJ3E3KNVrQ1wf0683wEzz2BXkezhRYydq37YlHA//e38d4o+VCiXC0F
	 UNYlsVublyzWY8127pv1kM5/9uvTu91EsVNZmaj+y+X0NobmybQGTlmPuvM1H7jimZ
	 k/DKG1rnCSWLFDMMYIyVqIc1svP4ZZOW7cz19L6nmt77MoUTP/dcfYU6JjUqUN3DDd
	 +jLJ61TfaPeuCD+YZOyIMIV6FFTxn/AD3sSsIfkmhEAja/X7iEoNnG7JO6a5XmiHDN
	 RUdf17Q1Sey/cHPB1x8KPj319LO6WnZ0pQPv6LZ5Zxo5yXuLBJK1FVu6b1vbeQCaIi
	 mwjeymjgxHFlg==
Message-ID: <cde46e50575ba2e7578d3cb25d77bb7bb3405405.camel@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Add a subsystem policy document
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 "Darrick J. Wong"
	 <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>
Date: Mon, 22 Sep 2025 06:25:25 -0400
In-Reply-To: <20250921194353.66095-1-cel@kernel.org>
References: <20250921194353.66095-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-09-21 at 15:43 -0400, Chuck Lever wrote:
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
>  create mode 100644 Documentation/filesystems/nfs/nfsd-maintainer-entry-p=
rofile.rst
>=20
> diff --git a/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.=
rst b/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
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
> +in file systems local to that server. NFSD can share files stored
> +on most of the file system types native to Linux, including xfs,
> +ext4, btrfs, and tmpfs.
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
> +
> +Brief benchmarking results and stack traces are also welcome
> +sources of context. And, functioal test results should be included
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
> +~~~~~~~~~~~~~~~

Agree with Neil here that this doesn't mention calendar dates. Maybe
call this section "NFSD Development Cycle" ?

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

Having done this recently, maybe a reminder not to Cc "stable@" when
sending security-sensitive patches would be good here.

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

For completeness, I'd add a "**Maintainer**" section below too.

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
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Docu=
mentation/maintainer/maintainer-entry-profile.rst
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

--=20
Jeff Layton <jlayton@kernel.org>


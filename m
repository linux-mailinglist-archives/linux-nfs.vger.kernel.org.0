Return-Path: <linux-nfs+bounces-17296-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3BACDCA8D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 16:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B42330142C2
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Dec 2025 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7C3274FCB;
	Wed, 24 Dec 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKEqHXrN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AB523EA97;
	Wed, 24 Dec 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766589517; cv=none; b=TJKxTdGifw7TgMw78pVkye2YPFvL/jiHTx5RGkHvmNPwbpNlYXKR9t4M/jBFZuEnsKttcHQELiwKk0/0ivfh4H7WYn6tIci96BI5Of33/yt56lWBiFuNbqg2bpue5D2B37/k5iqxF/6uNROnPliYyro2B+2aZQPzsSsIv1tVBFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766589517; c=relaxed/simple;
	bh=AA4+GcUPZa+VjYKwNGrzqEzsqgbWjmqgz8ZbUPLnpy0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I8ThUFeni/1EiDGWe1d98ToX6o0/PMVd09/IRRdJkJvR2zXeH9zl8vCkpjo2LR84432wISH2mWnrbARIbyW1t/vgrhUwV7iudcz/mRa0T6D153jT4iXsRsSq3v0VrM0aAlSk2nf+6bsYbNWfy11HEbFD/Pq9J76pDQ0ejei8s6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKEqHXrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652A8C4CEFB;
	Wed, 24 Dec 2025 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766589516;
	bh=AA4+GcUPZa+VjYKwNGrzqEzsqgbWjmqgz8ZbUPLnpy0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VKEqHXrNU1LI+ulmB+2gNUOK8QOsQS8b1crmavu/xsm0Aaz9zrvzyueVbSYCoUSy1
	 XatkKgX2jrLCCxW4yfksOUGilQNf6fyzumEiGHH58mShvVnGIQItMXQbo1Zh0tdT3x
	 FwM93AgfVx/+MU86uMkkWbA6vX6eHxXI1A4l0k9PhQZXFjRQm6qqmyIDxgHDDxCsDR
	 ciQrJuVbrcu9yllYYTALb6j3cCf5FAQ+riOTrLLJFujP+ugQ/EL/URtTZeM8jPcDhW
	 hbUFbaQAfmLogJht+w7ihvW2pmkHdEq/cj0xZ+/RKQKppil9DKdlivpZuNylQsn+oV
	 gXD/2JHp0rbOA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 81FE8F4006A;
	Wed, 24 Dec 2025 10:18:35 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 24 Dec 2025 10:18:35 -0500
X-ME-Sender: <xms:SwRMaSDhpIkFtEHl0sGaB-zXqOCj_F6kYQ-UUcvsLY7sQcMyNFHqsw>
    <xme:SwRMaXVuheKFgldBgltLD1lFJsE03FCCCCCSWQkCFql_W1N3fT7fRS45sxSzd6Uwc
    62ORefszS86wPv5WtCDwxx8sPVkHPS1ijYxViQqcLnF4oaXlAh7Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeifedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeiihhgrnhhgjhhirghngeelieeshhhurgifvghirdgtohhmpdhrtghpthhtohepsh
    htfhhrvghntghhsehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdr
    lhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SwRMaZNEfiNZOwI_VfVwlKeT-XW59rmhV4LkKwLyA8EnvQUSoJqgdA>
    <xmx:SwRMaU6e30OjH3bZbsKYeDcSM-krD8fjzZXqWqv41a6fVHaRRCHeCw>
    <xmx:SwRMaT3Dkbj8-5TR200Bmy-PHbefn_aa83k9b7F_zR7WtAZisKwE2Q>
    <xmx:SwRMaVwwJmXW37-h-KyxrniPhPrVzfr9guVbkhwidaZJ5_otQgEJrg>
    <xmx:SwRMaduZSAbuk6X86VCpHJE3Ip1aH2k9bAB3JcyiSL3hL91V3zIz2azw>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 61961780054; Wed, 24 Dec 2025 10:18:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6_whY5CRqgs
Date: Wed, 24 Dec 2025 10:18:07 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "zhangjian (CG)" <zhangjian496@huawei.com>, stfrench@microsoft.com,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <8e49b767-f2c7-4cba-8477-d3b329ad9d18@app.fastmail.com>
In-Reply-To: <b3ef1024-bc81-4436-ae65-f1bdaf07efe8@huawei.com>
References: <32686cd5-f149-4ea4-a13f-8b1fbb2cca44@huawei.com>
 <a4435153-eb55-4160-9b46-aa937cffa575@huawei.com>
 <b3ef1024-bc81-4436-ae65-f1bdaf07efe8@huawei.com>
Subject: Re: [Question] nfsacl: why deny owner mode when deny user
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

[ bfields@redhat.com dropped because it's a dead address ]

On Mon, Dec 8, 2025, at 4:56 AM, zhangjian (CG) wrote:
> When user read bit is denied by nfs4_setfacl, owner read bit is also
> denied.
> Example:
>
> [root@localhost ~]# nfs4_getfacl test/a
> # file: test/a
> A::OWNER@:rwatTcCy
> A::1000:rwatcy
> A::GROUP@:rtcy
> A::EVERYONE@:rtcy
>
> [root@localhost ~]# nfs4_setfacl -a D::1000:r test/a
> [root@localhost ~]# nfs4_getfacl test/a
> # file: test/a
> D::OWNER@:r
> A::OWNER@:watTcCy
> D::1000:r
> A::1000:watcy
> A::GROUP@:rtcy
> A::EVERYONE@:rtcy
>
> In function process_one_v4_ace, I see read bit is denied for owner:
> case ACL_USER:
> 	i = find_uid(state, state->users, ace->who);
> 	if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE) {
> 		allow_bits(&state->users->aces[i].perms, mask);
> 	} else {
> 		deny_bits(&state->users->aces[i].perms, mask);
> 		mask = state->users->aces[i].perms.deny;
> 		deny_bits(&state->owner, mask);
> 	}
> This change is commit in 09229ed. But I wonder why it is implemented
> like this.

I'm not an ACL expert. But here's a stab at an answer.

NFSD must translate incoming NFSv4 ACLs to POSIX ACLs before
they can be stored by local POSIX file systems. The root issue
is the semantic mismatch between NFSv4 ACLs and POSIX ACLs. 

In particular, NFSv4 ACL evaluation is strictly ordered
top-to-bottom. A DENY ACE early in the list blocks access even
if a later ALLOW would grant it.

However, POSIX ACL evaluation uses a fixed priority:
1. If user is the file owner -> use ACL_USER_OBJ entry
2. Else if user matches a named user -> use that ACL_USER
   entry (masked)
3. Else if user's groups match -> use group entries (masked)
4. Else -> use ACL_OTHER

For example:
  DENY uid=1000: READ
  ALLOW OWNER@: READ

Under NFSv4 semantics, if the file owner IS uid=1000, they are
denied READ (the DENY comes first in the ordered evaluation).

But in POSIX ACL semantics, the owner entry (ACL_USER_OBJ) is
checked before any named user entries. If the code only denied
READ to the named user entry without also denying it to the
owner entry, then when uid=1000 owns the file, they would get
READ through the owner check -- bypassing the intended denial.

Commit 09229edb68a3 explicitly states:
> errs on the side of restricting permissions...the posix acl
> produced should be the most permissive acl that is not more
> permissive than the given nfsv4 acl.

The algorithm doesn't know at ACL-setting time whether the
owner might match a named user (or might later via chown), so
it defensively denies to both. This guarantees the POSIX ACL
is never more permissive than the NFSv4 ACL was intended to be.

The downside is that when the owner is NOT the named user, the
owner's permissions are unnecessarily restricted. This is the
cost of the conservative approach: it may deny more than
strictly necessary, but it will never allow more than intended.

A "perfect" translation isn't possible because the semantic
models differ fundamentally. The algorithm  chose correctness
over permissiveness.


-- 
Chuck Lever


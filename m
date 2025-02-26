Return-Path: <linux-nfs+bounces-10362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05284A45948
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 10:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EDF189735F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA1224E00A;
	Wed, 26 Feb 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHZjOEdI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C424E008
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560399; cv=none; b=ug44Ll7owCyj2YOm5/iPOYGVShg0DNkDBZuPf6RORi7m2EyF71K+nBGIZ4zGnjT6ywuyl6fXoI6TfKlMqExsBmQnruooKd0nuh8AsUQaGSAcADSxXx0I4+vIQeSoUPK5leKrYDmpcEtm7Yjjzx7dceu0RhI2Eyu3Jw1AK/DXeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560399; c=relaxed/simple;
	bh=U25D+KyMlVh10lj6zpjTTF2GDpp51u+6PnX1T/m90rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgUggAVsxZnDZKBRdyrMb68mordc1FlmREQ0z3jfK/MfrCeZzvcZiQJ+NL2ymsodie+BdOxHQJBpwGf8PtKq+NuSLMWxCG1mk9ruylZ2FlZfViZXS8g+lMJuMe/xtziUPUWtGMR6fnH3HVRYbaDbkoEYsUxg/icykPp7ZdAbiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHZjOEdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDA8C4CED6;
	Wed, 26 Feb 2025 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740560398;
	bh=U25D+KyMlVh10lj6zpjTTF2GDpp51u+6PnX1T/m90rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHZjOEdIty7sfi54SNhdJA3Ri4SJ0xEK6hx2lTon6CjZ+03W25znxwAP83kp04bxn
	 yYtcueSVoaCPWE0wB260wOUBbTSNvN2MdIDOUjMeJZMeAtdQcsmh6Ncu/XfIJlG2fs
	 911cQJGJEqTkzjveA+i7tnW3+h/G4GxyeGv/k6zSANH1AL9wVzvSyuqq1fT49wvk2e
	 o+/V+635wiIccGSqdqoP5G7ZQResIibyH3A64Y0yjaJTLE21xTFXnBdsSomvFBsEL3
	 xqvHFysa3CVW52uSkM7oJLKVeRZkmriT3vUSYaz8+JW/MG6SxOXWlEX7Xpnt7CuFK5
	 caA+BQL2MSJ+Q==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/2] prep patches for my mkdir series
Date: Wed, 26 Feb 2025 09:59:18 +0100
Message-ID: <20250226-entfuhr-zugkraft-3aeac22a63ab@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226062135.2043651-1-neilb@suse.de>
References: <20250226062135.2043651-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=brauner@kernel.org; h=from:subject:message-id; bh=U25D+KyMlVh10lj6zpjTTF2GDpp51u+6PnX1T/m90rs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvu8F+/eCB4/lS3G5q36uM84JrD/qv7Wqumimy0KztZ N6am3ZfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbypZ+RYcvNjXebz85g8W87 lKfoemum89tPe48m6yyTyv5w1qlAawMjw8X9B8Q3XOIvr9J6X8S+O8PKSU31349JgT4PN72RTRe XYwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 17:18:30 +1100, NeilBrown wrote:
> These two patches are cleanup are dependencies for my mkdir changes and
> subsequence directory locking changes.  Both have been discussed with
> the maintainers.  I would like these to land via the VFS tree to smooth
> the way for landing the mkdir series which I plan to repost after these
> are in vfs.all.
> 
> The patches are against 6.14-rc4
> 
> [...]

Put onto the same stable branch as your other preparatory changes.

---

Applied to the vfs-6.15.async.dir branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.async.dir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.async.dir

[1/2] nfs/vfs: discard d_exact_alias()
      https://git.kernel.org/vfs/vfs/c/3ff6c8707c9a
[2/2] nfsd: drop fh_update() from S_IFDIR branch of nfsd_create_locked()
      https://git.kernel.org/vfs/vfs/c/4cf006b73995


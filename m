Return-Path: <linux-nfs+bounces-16446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E650C647B0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D16804E2CA7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443833342A;
	Mon, 17 Nov 2025 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd/xpAel"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530F1C5D57;
	Mon, 17 Nov 2025 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387227; cv=none; b=htpZIQhz4a8V3i1iHAdOIIH/C0I8Dh3BiVQdGs+tVhALPITPTCJLbMnUs0oikqx9XsUzJ4RQWocOVuXbZGaVUaD6r9z4v0ta2hU7iYlLiSHg4l/Krh2xhawH/B1WEi8VhsNkBKAkU8DTQMXXpqJG1kvXbcIUjur/F/GlVueiyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387227; c=relaxed/simple;
	bh=vls2ejkvSJ6++A9tTd2/eGm0picoKzyHbpZf1kfIEYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efBLZx6HaYPHKaZycmhTaxQNt1fkUAQ+4wkCE9Ll8Qc7rPe3zscglEX+UAUW08SJDQL2TQBjI5Xbjp+bjjv7E+BPK9Q0S6rKCV2jNZ1S4JgCZmb2Jdb7Rmc66tfZMpQz2zFGTeHm2j8r58gp7vXilJHN9SU2mcX1pUcwQt3nePg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd/xpAel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBC1C2BC87;
	Mon, 17 Nov 2025 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763387227;
	bh=vls2ejkvSJ6++A9tTd2/eGm0picoKzyHbpZf1kfIEYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xd/xpAelgyJrgXHZV1aaBux5cuVjmBfmC6lWHIl/y3GSttIQsyc4qX7CxvKA77Zf0
	 6/yFfEcj9RaDH+cW0fvcTcxPswajJUf2XLGBagxIsbos9KyYNDNiHtVa3ZSI9xz86r
	 8FLliyMdZsxijcJND4PWebr5q3ckJv7PkJh64ofws5eXoBFs/GNkJu+q4BBFvZGjdg
	 PhCrIbjDJ3gMWa4TbgwqrJ91bSphwIx6B5APEQyJq+OSI43fWuco34R+0jPFeFSMOJ
	 AgIWPtsl81errOVadV5mT85pj6gSnKA58MSEhsX6+XUhA892RP7kXiXp8BCwsO+whr
	 Zz/DcwzIWeUog==
From: Chuck Lever <cel@kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux NFS <linux-nfs@vger.kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] NFS: nfsd-maintainer-entry-profile: Inline function name prefixes
Date: Mon, 17 Nov 2025 08:47:02 -0500
Message-ID: <176338718978.3874.9958892877184025153.b4-ty@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117102416.12418-2-bagasdotme@gmail.com>
References: <20251117102416.12418-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 17 Nov 2025 17:24:17 +0700, Bagas Sanjaya wrote:
> Sphinx reports htmldocs warnings:
> 
> Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst:185: ERROR: Unknown target name: "nfsd". [docutils]
> Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst:188: ERROR: Unknown target name: "nfsdn". [docutils]
> Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst:192: ERROR: Unknown target name: "nfsd4m". [docutils]
> 
> These are due to Sphinx confusing function name prefixes for external
> link syntax. Fix the warnings by inlining the prefixes.
> 
> [...]

Applied to nfsd-next, thanks!

[1/1] NFS: nfsd-maintainer-entry-profile: Inline function name prefixes
      commit: 8320b75b2b8bf94d4d4f1b59f75ec8dd7188dc76

--
Chuck Lever



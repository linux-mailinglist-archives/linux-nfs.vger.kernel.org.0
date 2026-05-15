Return-Path: <linux-nfs+bounces-21638-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGBDAktfB2pa0QIAu9opvQ
	(envelope-from <linux-nfs+bounces-21638-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 20:00:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE8555C6A
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 20:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B02A324CFE1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763993DBD5A;
	Fri, 15 May 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4S5BGfG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE43DB633;
	Fri, 15 May 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866111; cv=none; b=SJJSIduqsV9jzFPfDWULgn+Z+kP/jhpVJP3sWX6ZU2aA2LiRiB9/hiR22Q0e40pQiPhlOoHImpReR8xMuSt9xTlxxwNzNvcm8qtNLRyZEY+o0kk9dF6PPy0a1GbG4DIN2G+kqj8/fju7jVzzpjnVOjHHMme37wGk7lDJyAyPebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866111; c=relaxed/simple;
	bh=PvUD325b83v1aoZjyXLETyi/+y+Vj2YZBqPuYxgSsog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq8Vx5zhnpA+cpjeMx2rrYhd5Z4+cEgJZ5xl+S+fGBV+QXA6cQRCze+Aa6nskwiRrksb4Ri2nW2amGFDtqbOJyyIQBNtdcHjajzOr9tJo5SBrNHs4gFZ1hnbaa05qxGfnONyW/cPeULJeaOOak4KeUIBk3TUbxYq3jSmjjk/3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4S5BGfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B301C2BCB3;
	Fri, 15 May 2026 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778866111;
	bh=PvUD325b83v1aoZjyXLETyi/+y+Vj2YZBqPuYxgSsog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4S5BGfGV7mF3EIDJqFVfk94MakVX0AwugNb0q3/oGoth3vtcR7pWTRYVgx3d0yP9
	 5M4Frvkz0unHa+uXgYucqPkKEqQI6I4clyT74STQYalT2HH9rB2URJssdCGbGfkIaK
	 1bUvTduab+MPdMMd1ledWI9GjvhlmIHyqf/c8/c6z87ie+pFMQH0RlGMHAwTEhccV9
	 0Cgw0KXczy8aSYYR4Fov/HbjEfaOF0eGw+cnxPlaUrCRFtkTX7+Y6LBf8DKDjlJWNy
	 fns+LrexF1eJQ9Ua8H0R6QpTQh0xxHhPApx1OYVEdElP4mGrE5XH+IVjYwEdDYV51k
	 b72j2nuombsxg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Calum Mackay <calum.mackay@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/28] vfs/nfsd: add support for CB_NOTIFY callbacks in directory delegations
Date: Fri, 15 May 2026 19:26:19 +0200
Message-ID: <20260515-weltschmerz-folgen-68ca0db1ef84@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=brauner@kernel.org; h=from:subject:message-id; bh=PvUD325b83v1aoZjyXLETyi/+y+Vj2YZBqPuYxgSsog=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSxh2/rvV30XP8k/4WyL9XyVztMAzhc1rn5ab7aEnxde XXB46XaHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ9Z+R4f2SI19eTWPu+PQo ++pV5uNMG5PynwtxFX4OPTf/HlOkjw3D/wJ3sxAx1bfnbLikdqjf57MInRG8OC0kZl2e+rRD2aH M3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AABE8555C6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21638-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 28 Apr 2026 08:09:44 +0100, Jeff Layton wrote:
> Re-posting the set per Christian's request. The only difference in this
> version is a small error handling fix in alloc_init_dir_deleg(). The old
> version could crash since release_pages() can't handle an array with
> NULL pointers in it.
> 
> ---------------------------------8<------------------------------------
> 
> [...]

@Chuck, @Jeff, I've only merged the vfs specific changes into a stable branch.
You can pull it I won't touch it again. You can pull the nfsd work in in
whatever form you like. Same procedure I use with io_uring et al.

Let me know if that work for you.

---

Applied to the vfs-7.2.directory.delegations branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.directory.delegations branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.directory.delegations

[01/28] filelock: pass current blocking lease to trace_break_lease_block() rather than "new_fl"
        https://git.kernel.org/vfs/vfs/c/89330d3a60f7
[02/28] filelock: add support for ignoring deleg breaks for dir change events
        https://git.kernel.org/vfs/vfs/c/24cbf43337f4
[03/28] filelock: add a tracepoint to start of break_lease()
        https://git.kernel.org/vfs/vfs/c/e39026a86b48
[04/28] filelock: add an inode_lease_ignore_mask helper
        https://git.kernel.org/vfs/vfs/c/95825fdcc0b0
[05/28] fsnotify: new tracepoint in fsnotify()
        https://git.kernel.org/vfs/vfs/c/ad4489dcd08d
[06/28] fsnotify: add fsnotify_modify_mark_mask()
        https://git.kernel.org/vfs/vfs/c/12ffbb117b64
[07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
        https://git.kernel.org/vfs/vfs/c/010043003c0c


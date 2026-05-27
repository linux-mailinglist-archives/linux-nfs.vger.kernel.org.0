Return-Path: <linux-nfs+bounces-22004-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDwsKRDeFmo9uQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22004-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:05:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3305E3CEE
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 14:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53D46300469A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB8302742;
	Wed, 27 May 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEBSWLta"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616233B8D40;
	Wed, 27 May 2026 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883514; cv=none; b=C7vUTB7gOf5tVn7hYfULaQY6MDZvVgUFdxK8DM11064V0UZeTk+Abq/AIF+rqP1NRwv/2Bo7cSav1uXgTTU+DZllA26MxcdBCkPs2hNQCB/gYgdSmtGW7rwqAyMx5WVXM+YtxMqeLUA0ti3ppmXBRagdAksUMLUaomZt33b2q9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883514; c=relaxed/simple;
	bh=7rQ2H903AAvQ6IZQAXl+cCdxot1XbPFMx/ZvOX+8vrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b08oOtZSnAGlRh+ymnFK7H7biESKw/7XmqlJ9gvk+zCh+KQAJzlM78wytOMyOJ+PkQ+hEKXlbtqGGecql7QE0Yh7gPeZjQCr3vdziSLUSIXgjbLOPwmvGTlqkdZCtOHWgAOSJ0OiMVUgR+hZY149g4m0ZQP8C8WQnOZVbynjyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEBSWLta; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDD71F000E9;
	Wed, 27 May 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779883513;
	bh=dSe/p8m92m4kv6gkSLjHZwhNrgydZHmT4N7lsMHBvQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QEBSWLtaZIuoMiK58mLh0h3+0FMG9IjpSp3cijZXDpJUAI2yAuoxrOkYksYtwqUoV
	 ayrNBjVdYBsJ4uUBTaqARidUay+v6Iy/CXc5HwTbfTj+cZz3gpJNfCh6IVruk0zHYF
	 ZMntdi8fdcDrJhOFuIWjUHPPknUkGwpcLFAsmm4+YXJKKnMKVMpMTi2stdGvqVafTj
	 pgTEobe+ZtvrgggQFNadI7tE88JKdrrWmLHG+tdQ4E1+eKi6k1MUT6QXDFhBYz1O0h
	 fWBhWkWeVexTDXhD9chgA9VhUR8xEY5v3IqDHj0K+ZGhAakGALO0saJdKMeDQz9zTW
	 cTIuDPpg54pAA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kees Cook <kees@kernel.org>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/17] fs: replace __get_free_pages() call with kmalloc()
Date: Wed, 27 May 2026 14:05:00 +0200
Message-ID: <20260527-anachronismus-waagrecht-abgibt-77744a201ada@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952; i=brauner@kernel.org; h=from:subject:message-id; bh=7rQ2H903AAvQ6IZQAXl+cCdxot1XbPFMx/ZvOX+8vrc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSJ3X1n8TZN9+8lI6kCEx+Ra2rJdjqm/rwVB6c+tFmke vLSg57+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkUzGL4H/Wc/8X5Rv71Hhe/ LJ41e+PUnsiQ20n3F3Eov1G/e8HpkTgjw6ra1Vf7Iu73sXftPit++IHYnemLJ5iqnCmtzdAtv8p owwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,fasheh.com,evilplan.org,linux.alibaba.com,gmail.com,dubeyko.com,kernel.org,oracle.com,brown.name,redhat.com,talpey.com,zeniv.linux.org.uk,suse.cz,mit.edu,szeredi.hu,debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22004-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.771];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA3305E3CEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 20:54:12 +0300, Mike Rapoport (Microsoft) wrote:
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/fs
> 
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[01/17] quota: allocate dquot_hash with kmalloc()
        https://git.kernel.org/vfs/vfs/c/c94d1fa0af45
[02/17] proc: replace __get_free_page() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/3c849e5fe1db
[03/17] ocfs2/dlm: replace __get_free_page() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/40b7e5db6a25
[04/17] nilfs2: replace get_zeroed_page() with kzalloc()
        https://git.kernel.org/vfs/vfs/c/2abe95d9f56d
[05/17] NFS: replace __get_free_page() with kmalloc() in nfs_show_devname()
        https://git.kernel.org/vfs/vfs/c/75805c8f6d43
[06/17] NFS: remove unused page and page2 in nfs4_replace_transport()
        https://git.kernel.org/vfs/vfs/c/0d77bacd0eab
[07/17] NFSD: replace __get_free_page() with kmalloc() in nfsd_buffered_readdir()
        https://git.kernel.org/vfs/vfs/c/64f162f93a81
[08/17] libfs: simple_transaction_get(): replace get_zeroed_page() with kzalloc()
        https://git.kernel.org/vfs/vfs/c/5a3763a94e95
[09/17] jfs: replace __get_free_page() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/d50250728dc1
[10/17] jbd2: replace __get_free_pages() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/75c9377833a1
[11/17] isofs: replace __get_free_page() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/95f2509040ac
[12/17] fuse: replace __get_free_page() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/c78262429022
[13/17] fs/select: replace __get_free_page() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/ac6aa4672cef
[14/17] fs/namespace: use __getname() to allocate mntpath buffer
        https://git.kernel.org/vfs/vfs/c/bd822134dcaf
[15/17] configfs: replace __get_free_pages() with kzalloc()
        https://git.kernel.org/vfs/vfs/c/32466534cba7
[16/17] binfmt_misc: replace __get_free_page() with kmalloc()
        https://git.kernel.org/vfs/vfs/c/df5f3ac3e999
[17/17] bfs: replace get_zeroed_page() with kzalloc()
        https://git.kernel.org/vfs/vfs/c/0a994e1ab090


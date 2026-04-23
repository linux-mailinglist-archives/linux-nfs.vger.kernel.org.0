Return-Path: <linux-nfs+bounces-21024-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA8wHToI6mk/rQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21024-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:53:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B438451833
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2721D3008D25
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 11:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C7D3EAC6D;
	Thu, 23 Apr 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6p905u8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0B3E9F8C;
	Thu, 23 Apr 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945202; cv=none; b=RVg4D6gVlKzxEU5SqvGjCIynreygk98gykV7WR/RsBwjd8xD1DJeAzrEoQe175ljCphi7mEXlnDQxxYHR+pGmdTqJrCuGvLpUTS4BzzTI3RGpqEDs3lahb8Vf+E4OEDod5cRt8Gneae2Zpl+o9XfMF4UMYrKpbKiaPouj6bQoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945202; c=relaxed/simple;
	bh=cHE9hrag1OMIex+WXfpjDqBpsMmIUcQJHMPd4Y7yd1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkH0lrMQ/TNGycozH0QwASwP/85ogKDrj9EEWkdgogtKkbHY5eqSOKbT5+HS1806WbjDXGOlhMXYt2Yx3bA8S8n5iXDAaDEkKv+AKd7vKmtB7YIMfa7H6CjE19asJvkVdyCqbiTqzQEstj2hkFfzB9O5rM1Xh6ZsRhOaVtsdMP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6p905u8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20254C2BCB5;
	Thu, 23 Apr 2026 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776945202;
	bh=cHE9hrag1OMIex+WXfpjDqBpsMmIUcQJHMPd4Y7yd1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6p905u8w5riLWLBL7tRdD5S09cDEbJnPwWB5RVXAG2eZ8l9DVcz9BdD1snxlZ2Zl
	 DQHKLZweSXptmoepemPcv3MQMKXrko/qLSf8d9gekZ9FC9npj1Rl5+g83VEnO+lLev
	 xBFP7nCswuXz722eHK8fJ8BLo5Gk/F0+fuLGkDdxYxjQkDltUnC+j+R3mwxhrUbqzi
	 NJO+IaFgHoRmOtUENV0fUO142ajvIUPYaRG9OYAFDVcHCovlg6DI0cyER+NKMDRgNh
	 vxODO9xb+7N3kQKZvCTki45OQYoSORg/oovwJEvPkMCBEsAvK4tl5B50itIMRurf/p
	 QTWH9qc+XS8KQ==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v9 00/17] Exposing case folding behavior
Date: Thu, 23 Apr 2026 13:52:39 +0200
Message-ID: <20260423-notorisch-marmorieren-3b1376711a8f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3216; i=brauner@kernel.org; h=from:subject:message-id; bh=cHE9hrag1OMIex+WXfpjDqBpsMmIUcQJHMPd4Y7yd1s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+4pDrrGXLlji/IJ4rYraNoNkSc4YNzkphLnvaDBjuH ZDgN+7oKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIiFB8M/i54I8d9+l7+JLPRe ZprEUqdyJzW9MtJsd1YHj5vI9ksXGH6zpfMemLRMIbdowdo3hucvvTqjdGrTptvGfolrD63muVD ACAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21024-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B438451833
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 19:29:54 -0400, Chuck Lever wrote:
> Following on from
> 
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> 
> I'm attempting to implement enough support in the Linux VFS to
> enable file services like NFSD and ksmbd (and user space
> equivalents) to provide the actual status of case folding support
> in local file systems. The default behavior for local file systems
> not explicitly supported in this series is to reflect the usual
> POSIX behaviors:
> 
> [...]

Applied to the vfs-7.2.casefold branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.casefold branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: master

[01/17] fs: Move file_kattr initialization to callers
        https://git.kernel.org/vfs/vfs/c/a46401c7dc2f
[02/17] fs: Add case sensitivity flags to file_kattr
        https://git.kernel.org/vfs/vfs/c/1dd697879cf2
[03/17] fat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/2b124bb86cdb
[04/17] exfat: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/9b8b66549c8e
[05/17] ntfs3: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/7d0fbb53b0c2
[06/17] hfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/024b4a69abaf
[07/17] hfsplus: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/22a319bfe8b8
[08/17] ext4: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/75fd84cb0922
[09/17] xfs: Report case sensitivity in fileattr_get
        https://git.kernel.org/vfs/vfs/c/29323822bece
[10/17] cifs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/4444c82e69a6
[11/17] nfs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/6f3f50885bd9
[12/17] f2fs: Add case sensitivity reporting to fileattr_get
        https://git.kernel.org/vfs/vfs/c/e8d671306a8f
[13/17] vboxsf: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/f5e334b94179
[14/17] isofs: Implement fileattr_get for case sensitivity
        https://git.kernel.org/vfs/vfs/c/764609f76826
[15/17] nfsd: Report export case-folding via NFSv3 PATHCONF
        https://git.kernel.org/vfs/vfs/c/06726ac88bb5
[16/17] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
        https://git.kernel.org/vfs/vfs/c/d129f0419eb3
[17/17] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
        https://git.kernel.org/vfs/vfs/c/8179d08606e8


Return-Path: <linux-nfs+bounces-18956-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GsgJm1elGnODAIAu9opvQ
	(envelope-from <linux-nfs+bounces-18956-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 13:26:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB5614BEB7
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 13:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7890B300462A
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E183396E8;
	Tue, 17 Feb 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct8kGGic"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BC2EACF9;
	Tue, 17 Feb 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331176; cv=none; b=QcyiyZPo/CRtwkWU5gIJEL+61ZYNJ7Ma7niKvvBUHWfn1aubBHWB72A402g4m4kIEjy3zt3dtxdlsoxdKq1mvCc3k2+YJdFFoOsupOZX8iwWW8YmN1sNM7Z2OfeQu36Ook+tE8e5fF64OIntZkvtNSnj4gX1nTLAN3Ft79+HyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331176; c=relaxed/simple;
	bh=T0L8Hm85DweBO5FE6HwA1Kx5ApHoeds8vAJGxZQRbWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4+53zE++0lmOWAbtAOwXoNlQZ8LSg5P1sw/tLBTndyCVtRPoCBPxhKpuwixJUH3D3iefCBIJf/tXBAW56yRSkXTIVY5dJMrj9AQq6NVEieOOHggWkT7Q15xTkM9tUHX3CAi3dL/GbsQefMt22vVdD0JDh+ptzELXRrIBQkqbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct8kGGic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA2BC4CEF7;
	Tue, 17 Feb 2026 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771331176;
	bh=T0L8Hm85DweBO5FE6HwA1Kx5ApHoeds8vAJGxZQRbWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ct8kGGic4pTwYeSCcRCaAAts9KnujAI12ci5w9gsJRqn0RYFQVdsfsWvHSlMwdCAf
	 NwJ0JlISR/R4ZFVuJfcYKj/LcKcBtGxi/hz76FQ8HXt9O+rI7AZWQVrapT9+YMoj20
	 AVv7xJYn45uidLdiJ/XqJf2ul7NLQAzp5ZUsOZySDUQnMbQZwjUeMp7BNKhrY+MvoQ
	 bge/3Sje8r1ZsHKsfbA5kWZb7SYvwrXw7fJLEIn+dWncoCvkE2LG0iNQIoq9JFAUKG
	 y27cXr0K7vM0ShgTZ31Su5h1fjT4/PFQ8og0GcPyDvNru139zhsWxLD1MlqwSQo8dk
	 lZlLHSBYNxWPQ==
From: Christian Brauner <brauner@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	gost.dev@samsung.com,
	anuj20.g@samsung.com,
	vishak.g@samsung.com,
	joshi.k@samsung.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	hch@lst.de,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	jlayton@kernel.org
Subject: Re: [PATCH v2 0/4] Avoid filesystem references to writeback internals
Date: Tue, 17 Feb 2026 13:26:02 +0100
Message-ID: <20260217-rosig-hausdach-fcba09a3c371@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213054634.79785-1-kundan.kumar@samsung.com>
References: <20260213054634.79785-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=brauner@kernel.org; h=from:subject:message-id; bh=T0L8Hm85DweBO5FE6HwA1Kx5ApHoeds8vAJGxZQRbWI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROiUtcnj+rL/CFuo7v7iTuU9YF5eyPNp61t5kW7W4bn KqmJdrdUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGl/YwMyw+LNjSq6u999WH1 WSffYF0Wlsal5x+nXTp18hzj7N+PTzL8T/gVKhU0lZ3t2yz1ZOUrEhujnnX/bnliceJRWMgylY+ eHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-18956-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEB5614BEB7
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 11:16:30 +0530, Kundan Kumar wrote:
> The series introduces writeback helper APIs and converts f2fs, gfs2
> and nfs to stop accessing writeback internals directly.
> 
> As suggested by Christoph [1], filesystem code that directly accesses
> writeback internals is split out:
> [1] https://lore.kernel.org/all/20251015072912.GA11294@lst.de/
> 
> [...]

Applied to the master branch of the vfs/vfs.git tree.
Patches in the master branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: master

[1/4] writeback: prep helpers for dirty-limit and writeback accounting
      https://git.kernel.org/vfs/vfs/c/a235d3bcd28b
[2/4] f2fs: stop using writeback internals for dirty_exceeded checks
      https://git.kernel.org/vfs/vfs/c/07043a6ebeb2
[3/4] gfs2: stop using writeback internals for dirty_exceeded check
      https://git.kernel.org/vfs/vfs/c/8cab8dc0e141
[4/4] nfs: stop using writeback internals for WB_WRITEBACK accounting
      https://git.kernel.org/vfs/vfs/c/fd15b9c6ec8a


Return-Path: <linux-nfs+bounces-22032-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNdqHNQyGGpwfggAu9opvQ
	(envelope-from <linux-nfs+bounces-22032-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 14:19:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6555F1F9D
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 14:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40B7731C1EEF
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0478F3E717A;
	Thu, 28 May 2026 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF1sHgW/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6C3E63B0;
	Thu, 28 May 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970466; cv=none; b=VWPV2qZo3Bm7fYtAfHETGJHeYygOdSoh4dCtvQnNcUh1Rzv4wGPEI3IGX/Lb7ei1ru0pBk6JGX7LIYKWXaDFqff9WsWfQAvHZQDMo7D2eXMRoh6uCRUtwhV8tJOw1lX6QhbXx+PYALAe/ypBckhowa8BJCGTiVp2AXzgpwQHpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970466; c=relaxed/simple;
	bh=jEY91prdNj5/iND48zGZuNVQzdnoeMiZIX0RcrWDIBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AckjlEOB2MJ23MgSE111eA2HOAgLidc5tg8ZeUG/L4M6ehDzsc+elz8v9n4XFw2iYmJIPWC4YROIBCrMqYhntg5+3umiU9VQYh8Go4wjmH7b+5Utr4BjN1TWf32NxzMOesMF0aRmv7kdfCnnWwAhJ7T3bgOlcK6az+VY9vOr0mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF1sHgW/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C391F000E9;
	Thu, 28 May 2026 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779970465;
	bh=Y1ecP6OwkS6zlOFme2GkALWt8vFnlY97qvgOKCFaMgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UF1sHgW/OsJ3HjUE9OBEWWUuiQBsblHxJcCsbenKUtI01X2nQH/YnZomuocAcCeGs
	 vDgfj+gaLjyNZR0CI4GlIgDZg2VHXw7Hx3KuaSFf/wfOtn1OkkY0gw4zXa+eH6jMpW
	 96omcg9DjBruQLTAqqJvxI7cW41pU2INfxS2tkLFmsUViQMROj7MC1N7Kqr4w8eOza
	 WkcFkpknqlhw9WEFpF4lZCN+3imTNmuOOPFEzzo6AubKMDhLxL6HrlhAGyA2iG32YH
	 w142iIvkCI9GnzYF8tA393BE+QSt63WMLHEWKXwmrg0ag1SW7E3+w5JJU/GxZb2w/0
	 e0NOquxb1xbuQ==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: fix possible failure to unlock in nfsd4_create_file()
Date: Thu, 28 May 2026 14:14:13 +0200
Message-ID: <20260528-pritsche-verknallen-frisieren-5c6ea172ecb5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=brauner@kernel.org; h=from:subject:message-id; bh=jEY91prdNj5/iND48zGZuNVQzdnoeMiZIX0RcrWDIBI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRJGM45FaVzt/964OP7nKarXepSlyxw1xSSPT3/1tTmp YmSD7JcO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay7xgjw4/zhsU7vR5d+7el eK7GCc3M5w3vPkYzJbIaLt2yizfj33qG36w/auaKpL178aLkdkPGAc3LWtvN9dNC+VY9jxZ4lrO Igw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net];
	TAGGED_FROM(0.00)[bounces-22032-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE6555F1F9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 16:23:45 +1000, NeilBrown wrote:
> atomic_create() in fs/namei.c drops the reference to the dentry
> when it returns an error.
> This behaviour was imported into dentry_create() so that it
> will drop the reference if an error is returned from atomic_create(),
> though not if vfs_create() returns an error (in the case where
> ->atomic_create is not supported).
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] VFS: fix possible failure to unlock in nfsd4_create_file()
      https://git.kernel.org/vfs/vfs/c/e824bbd4d224


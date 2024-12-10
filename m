Return-Path: <linux-nfs+bounces-8510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54A9EB433
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B535E160FA7
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2024 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390CA1BAEF8;
	Tue, 10 Dec 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8bff1iQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD52594
	for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842877; cv=none; b=gtd9YYVNwZC8z9rI90TM7mjluJK+govd20pRzch3z/+iDfAEB5TWp0MFhEbTCZof0oLCDhjHx2mhmFt2ONyW8oG7UtshOmacDN/UUOluRid8/zOp8TCDEjjcw1jkp2iRYmn/g6vT+SMGf5X+02QGpdhQW8cZr6mmPY9/rw0WTUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842877; c=relaxed/simple;
	bh=y+FqjtDETZAxZBh3dGtCp6PPNFVdLjXcjoSo0n6qkZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irnLJsZVoBWXvWuxTJlbcCUHw6w7MXvngOLpiV9JzV9qwKIRtD6WIowfemdMrRYtNbSKjHyLNsRm/J5FHZtvyGWpahYRnt6i5T41V2jDqoKadKfyVhukSnEgrUVj4BTRppCKgsHSrzaPje7fcARpJLoGScqG9zrirrdNfC0zo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8bff1iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A221C4CED6;
	Tue, 10 Dec 2024 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842876;
	bh=y+FqjtDETZAxZBh3dGtCp6PPNFVdLjXcjoSo0n6qkZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8bff1iQ1WkYJXhgoeeR9fT6NI8dFEhb//rS5kwZCb5f9LsH2b2GUO3QxWxuF8L7Z
	 t9kOfyVaWStvhLYVG3CSI04LMNvb5X0xOg5XykEaMupbHkl+UPVhngFoM1+TSMd/7G
	 TkjypPE/YybxtOIoVnCQwpSChoIzXVFj1AIzNuTQ8XB4NyC+28d0maIAJkB66mxuSl
	 JEC3GZomCKC/lAefsSOB8iyePrL1TXPzQGqKJKnyFUpo139haK86ETb6iaxYn77/ou
	 tYcRyLG1LRIK0irSvx7xbxNkEcu/TZnl3xuvJZyEdWhox/lnLBiB8GQagjC/QoiK59
	 +Q97rkTIndSWg==
From: cel@kernel.org
To: jlayton@kernel.org,
	Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	jur@avtware.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix legacy client tracking initialization
Date: Tue, 10 Dec 2024 10:01:11 -0500
Message-ID: <173384286249.1845724.12639817715084811205.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210122554.133412-1-smayhew@redhat.com>
References: <20241210122554.133412-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Tue, 10 Dec 2024 07:25:54 -0500, Scott Mayhew wrote:
> Get rid of the nfsd4_legacy_tracking_ops->init() call in
> check_for_legacy_methods().  That will be handled in the caller
> (nfsd4_client_tracking_init()).  Otherwise, we'll wind up calling
> nfsd4_legacy_tracking_ops->init() twice, and the second time we'll
> trigger the BUG_ON() in nfsd4_init_recdir().
> 
> 
> [...]

Applied to nfsd-testing for v6.14, thanks!

[1/1] nfsd: fix legacy client tracking initialization
      commit: 0f0f93d93be82021f30c23eeca6aaf8e59a276d0

--
Chuck Lever



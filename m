Return-Path: <linux-nfs+bounces-11758-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861BAB903C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 21:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB4418978B4
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32DA22A7F8;
	Thu, 15 May 2025 19:54:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2F1E480
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338880; cv=none; b=gLtN4KSJ+oRgROf1CghTowFUponhR4DiFeNixcaaAkDDoEVqqDS1KJeFUtO9udTnJwyLfKKbV8/UeKs4kB1r9RFDOksK+tVLCAomqXSSzecuOXvtoOt/rbPTvaSA9k0PDdd5qs+jWxGAeo7xmrDknoerLLcvwM/wV25bJ7PxCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338880; c=relaxed/simple;
	bh=5mOj077tmC8MJq9DY+IsXHSgLEdXlu4HPzavombQNTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TecAqjQrFPpSdhWdvi3t6rah6Wi/GXAWQqwL2pcOkikHIRiXIPRCs1lvjkqnY6BpPjzLvyHor+zuqVhYp4hXKdmzbcjrJ0pX7lqegkpkz0N0+coiWgoAP4FYy/BfgkkpoL7W1f+gx5GZoRBvFlmgrRUg/kZ5JGLJEwj7tCJZrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8CDC4CEED;
	Thu, 15 May 2025 19:54:39 +0000 (UTC)
From: Chuck Lever <chuck.lever@oracle.com>
To: jlayton@kernel.org,
	okorniev@redhat.com,
	tom@talpey.com,
	NeilBrown <neil@brown.name>,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCH 1/1] NFSD: release read access of nfs4_file when a write delegation is returned
Date: Thu, 15 May 2025 15:54:33 -0400
Message-ID: <174733874583.5411.256713895672732356.b4-ty@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <1747152651-23087-1-git-send-email-dai.ngo@oracle.com>
References: <1747152651-23087-1-git-send-email-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 09:10:51 -0700, Dai Ngo wrote:
> When a write delegation is returned, check if read access was added
> to nfs4_file when client opens file with WRONLY, and release it.
> 

Applied to nfsd-testing, thanks!

The extra nfsd_file pointers in struct nfs4_file are confusing, and
have been noted for future clean-up.

[1/1] NFSD: release read access of nfs4_file when a write delegation is returned
      commit: 65de35b2b4b5cff421f48e638010a2f8cecbc62e

--
Chuck Lever <chuck.lever@oracle.com>


Return-Path: <linux-nfs+bounces-9783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732CEA22EB4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7737A1CFA
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D341E3775;
	Thu, 30 Jan 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7lDEbrK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805FD1E2853
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246181; cv=none; b=aXXxJJiXKOSQfUxTO59SaRyhj8pJhKvxFRQngwpyzL7d0CX1PEZ/2ze24esCKnWr4Rjtk3xqjBsrfZKaorZfuXOv4aDf9mP7gTSmFFEoCi9Sgshm8fIB9YmXshcCDn4z+4/WoNfYXMfAHOy1SyGkpVEUsWOaLs35QxmkJLPFkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246181; c=relaxed/simple;
	bh=oDKYR/KGaUWLIbTOveDX+Y8A9F1le4+a0IvbgvLeqy8=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=FMMY+mocfQC+206foLl0WbwCdkDcY4t+zy4GX3J88LVDdMlVn8+IGb28SMAdErueGrZnZM17ryrH1Af2eJRpw3DvEHOMxwYvrSV9yqttnROqrU7fiTFC+lOSfMDMHgVEFwd5G9n3xjN7G+JksiajX5OVLLOj3RYZmKAJg0FnVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7lDEbrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E978FC4CED2;
	Thu, 30 Jan 2025 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738246181;
	bh=oDKYR/KGaUWLIbTOveDX+Y8A9F1le4+a0IvbgvLeqy8=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=T7lDEbrKRxmgxBmjk35goKtpCtOByKawsv/h1FcCa0RJYOy3k/fSNxM6Umnl2kfCa
	 xbGYE0cpC+cWZ71Okx9uxz+wrjbciya4LuGWIHS7UMukiZPA6bL5MAi1qCHM1P+hPP
	 JpUyhtz8IcvTsvdxF0IDP9200Fal6EVr3h9f6H+cWk4EhbQizrHF21YfI/V/9x9CSE
	 y8p5ffxy9htlN0cT8nsTUtzc4PP8WWKgNUyc4zEM2y2ri/OqHt7K42m+5tGad6Em6y
	 0ilxdVdV3YyuY1mLSoOadt6L/EtHKWJm7uq/D+phqw75RjLVwKN+O02lVWifffIbEm
	 eaSJO/1EYkNHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B751380AA66;
	Thu, 30 Jan 2025 14:10:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 30 Jan 2025 14:10:05 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, trondmy@kernel.org, cel@kernel.org, anna@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20250130-b219737c1-e23b3cbd7a5d@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

I recommended a separate bug because this looks to me like the CB_GETATTR reply handling path needs some attention. I'm not sure the problems here will result in the hanging symptoms seen in Bug #218735.

First issue is the explicit use of NFS4ERR_BAD_XDR in the CB_GETATTR reply decoder. Should be EIO instead.

Second issue is the CB_GETATTR reply decoder does not seem capable of handling a non-zero status code in the reply.

Third issue is whether NFS4ERR_BADHANDLE means the server requested a CB_GETATTR for the wrong file, or if it is an expected situation.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



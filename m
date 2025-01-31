Return-Path: <linux-nfs+bounces-9815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0189A2444F
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 22:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B83161ADA
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA634158535;
	Fri, 31 Jan 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU7+8qG6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0C14B092
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738357481; cv=none; b=ednuBKDcBeD2rY0/iMv+CrGV1fzPAUg2T1tfFQ3U062XoRYc3pOk0nkhtRII4F3rXZ+XpJ5Jy3mq+Ma67TnPybxULcSS7uElZi0Wh67PrGLGqNnpxShCALe6Q6BQZhSuefqebQz6HrcEkJsdTbjNnw/yECFXgPZSYwDHndVssq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738357481; c=relaxed/simple;
	bh=nrZPQVBdtXm9KYXvbqXxJLoQtx3UnIoTM02TVhZR/gE=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Y+zhpb9y9hv0SCtRy+k/bY+ZSfEpVBYg9qH7Y5ZwZBfdF8xNlumj3lHdVooOYOFh2kGUjVtORMp5GnjW1BFCLjVSut5B3/Dhw4txGE70nJb5H05m0OqGsrofMWWMzCZ4/5eqZqe6Fk4jR8ci1tQrugPDq8l69TxWmGNHojUMJo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU7+8qG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E5AC4CED1;
	Fri, 31 Jan 2025 21:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738357481;
	bh=nrZPQVBdtXm9KYXvbqXxJLoQtx3UnIoTM02TVhZR/gE=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=LU7+8qG645LYNtFM1dwfE1SosTaMmOHIbleOp5WOtiuqQx86RSOD74sXRKxveE/m6
	 IyW8PY7QQmKm6eq2FTC9qjKy4h/X8zyNKw5hh40GfuhuV4wVoQUuAgXuUT5I7LaSmp
	 8yrUwae272KcYD9e6u5y6SRdqZYkDi64DpN1cnQ/ol2Lw0alGNBwNQM0Z+iAEeM14N
	 Ly21L7/BF0JZOoVD28iTkfAr56X0viCuUBXgwRjtIny9Dh0i4l3eB/5sLU1VW+NKLO
	 Qdz9I9Bixun+x5pPccOKla1s8YH+NaGFzYUTX0LP1RcgXfo+EgdYbBz4xIbWXf4yk1
	 Ypblr9+MPjrZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2156380AA7D;
	Fri, 31 Jan 2025 21:05:08 +0000 (UTC)
From: Rin Cat via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 31 Jan 2025 21:05:09 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, anna@kernel.org, cel@kernel.org, 
 trondmy@kernel.org, jlayton@kernel.org
Message-ID: <20250131-b217973c5-818f16cddd6d@bugzilla.kernel.org>
In-Reply-To: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
References: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
Subject: Re: CFI failure at nfsd4_encode_operation+0xa2/0x210 [nfsd]
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Rin Cat writes via Kernel.org Bugzilla:

OK, I will check v6.1.127 and see if I can reproduce it.

View: https://bugzilla.kernel.org/show_bug.cgi?id=217973#c5
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



Return-Path: <linux-nfs+bounces-10019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B750A2F3E6
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 17:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B1F188682E
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84F1F4638;
	Mon, 10 Feb 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhbviyfJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967811F4632
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205878; cv=none; b=Id030vtpDl9FP9LgGtqNTL3rrokeRSML23deTdowwETqUblvaIlifY4Y+o1B3EZGTY20kw5Zk7119MtOg15eGQsfuBn9QQAkvLVjNa8qcnuXYwiIdwdhDMj4bclrKFv8KnJOx6fxxLqwltxYYVwqUZZByDXE0AvLv5z9jZ9nrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205878; c=relaxed/simple;
	bh=3FvoMTUgn2OfvqQGFEV/Ko8QaF/3bAF5McwVRlu5GWg=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=FtIpVYnbqKh3lJVJTxffFSUGgQaU9OuDagQB0LJvtfqXHZ8y6LShGudDrfNx1Flv3Dm1GpvLHY41peHsR7T1SkD0I/UYOVw28IYNji9Hh8pgVdUg0RqU8t5pNgyfYcQQwyDI8v9bUBtxzY270ICRHUw3iZgNbf+dys74TJTVzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhbviyfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA9FC4CED1;
	Mon, 10 Feb 2025 16:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205878;
	bh=3FvoMTUgn2OfvqQGFEV/Ko8QaF/3bAF5McwVRlu5GWg=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=WhbviyfJ+3emaEjf8Q02c9CeKWxS+52+yacbQ2IL2Onl5MlsPb1TH303RRgHuphiw
	 3QCJ5FxjXWKrcaFNOPprwGRMqcI4pEDBsaV3S/TCmfCwPxE4ClCqm6rNLvEH/cv3v6
	 8Hc4b0eKziNu3+NaENNiFjM6k6iS69DZnwVsLRaQ7FJV0EMNMnimH5P41tKYCrVqSr
	 /08nnHPRmbURoBxksrkBu3fS5JjL8QQG+Ls+Ieo1YwChBCHnYbI1MqqhrEWIshwKtR
	 zKjA+GPCFo0Qnffrz6HLqSUregm0pQcarHUdfkCqN+HMKOflI49d6qzCBqm8sNL8ei
	 c4qETjVOvgyng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2453380AA66;
	Mon, 10 Feb 2025 16:45:07 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 10 Feb 2025 16:45:14 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: aglo@umich.edu, trondmy@kernel.org, jlayton@kernel.org, anna@kernel.org, 
 linux-nfs@vger.kernel.org, cel@kernel.org
Message-ID: <20250210-b219737c11-dbc204642093@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

Also, -NFS4ERR_BADXDR is the wrong status code to use here. The correct code to use is -EIO. We're decoding the callback server's response, not a call (where BADXDR would indeed be appropriate).

For comparison, see how the NFS client handles a server response it cannot decode.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c11
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



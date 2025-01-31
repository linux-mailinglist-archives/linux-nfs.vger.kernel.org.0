Return-Path: <linux-nfs+bounces-9810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04857A23F7D
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B27D168F11
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01AA1C5F30;
	Fri, 31 Jan 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT54utD4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0211C5D77
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738336486; cv=none; b=ZtJhBcvx1QIFlvmkUzCIcGvWRezmq7UjjJpf5lXd1Ifh2W9v1D+wkRJYHdD8rGQdImMaDfDgtbFh94KrMmatnfnusfUCFMHg7aDdiUOLAEoOV3z2I4O+ehQZtvvEag56oIO2JcwOK7UOhnhE8dIhJjQtM9xwGNVdRHpCjbR1ITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738336486; c=relaxed/simple;
	bh=HFJEqcbHh6nN//hEe6b45/lt3KjEVBO29OS4cNyNQqs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=MKK5kBxhC4jxsanknFAWFxr+BkNqxrCuRQpxzP3ECLPUFxvhFb7K2wqJuozHJKjpXWy0i4yzZW6u+NNpeGxoSorJ19BmhdLJspxP1rEVF9pJMx+1qywsIainY4YTvdbq4smWrE2jtqCDOsbAKlWevNuyaC3QsbQBxYnLc35pifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT54utD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0F5C4CED3;
	Fri, 31 Jan 2025 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738336486;
	bh=HFJEqcbHh6nN//hEe6b45/lt3KjEVBO29OS4cNyNQqs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=VT54utD4EgpXuOYCTY9vzP84RZRyscOraXH9nw3jrKAKzum72XA81NYbuy9Itel7h
	 fZ9LNKyN4zyBZ5q1OYEBhL8LdA/RCm7vRCzT8vGPV1xhsaxq/h47wSO/GInmPvDQ1e
	 wRi/xRm3DRE4OtATlYwcF5DZjaUw6NWzIEIdrARSXi4sEpTYImA13+eE8bqCAxORCt
	 GdzNdE0/qQwDn2JGDf6bHZtUWYol2CxINjxh0wMIYeLNWV/7rA/U9rFl1ZuQhlRjAV
	 x3nTD8h2UFJhzM6b0jxqVJxQImtmofI87ZXAjX1veQDDLIkw3Bt/jtdRvnyvcgOs2S
	 7EepOVUoX/2ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF8380AA7D;
	Fri, 31 Jan 2025 15:15:13 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 31 Jan 2025 15:15:09 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trondmy@kernel.org, linux-nfs@vger.kernel.org, cel@kernel.org, 
 jlayton@kernel.org, anna@kernel.org
Message-ID: <20250131-b217973c1-867760bbc511@bugzilla.kernel.org>
In-Reply-To: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
References: <20250131-b217973c0-a2ac608a1bf9@bugzilla.kernel.org>
Subject: Re: CFI failure at nfsd4_encode_operation+0xa2/0x210 [nfsd]
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

Can nfsd4_encode_operation+0xa2 be resolved to a source line number in v6.1.55 ?

View: https://bugzilla.kernel.org/show_bug.cgi?id=217973#c1
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



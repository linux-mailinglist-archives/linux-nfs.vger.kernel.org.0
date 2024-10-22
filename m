Return-Path: <linux-nfs+bounces-7366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADAB9AB55B
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 19:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0B31C236F4
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Oct 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86D1C0DCC;
	Tue, 22 Oct 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB9Ar6OI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805A1BFDFE
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619029; cv=none; b=NqYdsI6ZKMXYfXHq2qOSgx+LzpuWIB7zCBrCe1ln8NWisMZlAr19rsZX7zSAoCfVWjCDkewcjTjeW6A3tcjFNDCdM4hdUAwsCSG6tS1WLOW7179VcsdrIj2oZdEUvjU8CIIMyUhY2wsyeoKkp9cpQCWc4ttMD9J1sQSL7QkPJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619029; c=relaxed/simple;
	bh=TXkL/1RLW7pJ6i3xjmqnn7KAfpy70CSEA79MV6XcBCU=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=ExCDF9obvRLjj1kUSkcIvWhcA0HbuRlkzeHhzuJ3lRARfPb+My9/7u9ghSxgDg7yh6CEddNovZ4txm7ujGANOFdNTrJnKLrONB6KAWSwv4PMniIkFkjLMA8zHdyuIRTXEjQgFGGqmrzIhf1TUHCLkvkO2kYOrwguH+NkcLYArMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB9Ar6OI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32587C4CEC3
	for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619029;
	bh=TXkL/1RLW7pJ6i3xjmqnn7KAfpy70CSEA79MV6XcBCU=;
	h=Subject:From:To:Date:From;
	b=IB9Ar6OIZlkZczIV54uX5DU29eawy8AqeTVIti6I9upvd8UuPyOMGoZJiGQULt+8b
	 6uoiWBGH+zkHWfyY1+xiMsjFSAQH2zh7Ty0jQTO/nOOAjJuoad87f+oaw5obZOVlQg
	 CzH/SEFfuGFtZGHMeDWwT6ndJnjuZeLV0b786iJAzOL04vxYowqC+OwGTAF/2rduR0
	 0WcH6gEgJXwgdwGZzIhqBy++YyPlEQuD4MmGpiVeSfgzdYH82ivXYD/kgAgNI1iC8y
	 GOyggqzdBNDqltR7BE+j+fCzHu+sHkLgydwfThdDY40jwiIoKw+tg5n7vgw7T52B+g
	 OXQH8qYrp4rZQ==
Subject: [PATCH 0/4] More xdrgen fixes
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Tue, 22 Oct 2024 13:43:47 -0400
Message-ID: 
 <172961889678.5686.2180145399460027810.stgit@oracle-102.chuck.lever.oracle.com.nfsv4.dev>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch series presents a few minor xdrgen clean-ups related to
the generation of client-side source code. Client-side code is not
yet used.

---

Chuck Lever (4):
      xdrgen: Remove tracepoint call site
      xdrgen: Remove check for "nfs_ok" in C templates
      xdrgen: Update the files included in client-side source code
      xdrgen: Remove program_stat_to_errno() call sites


 .../sunrpc/xdrgen/templates/C/program/decoder/result.j2  | 4 ----
 tools/net/sunrpc/xdrgen/templates/C/source_top/client.j2 | 9 +++++++--
 2 files changed, 7 insertions(+), 6 deletions(-)

--
Chuck Lever



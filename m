Return-Path: <linux-nfs+bounces-9565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62383A1AC08
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 22:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505F91886EB7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C041CAA61;
	Thu, 23 Jan 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWO1xJZ/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD41B21AD
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668683; cv=none; b=phNb/kgvpYyyr9wbHCPmhvGvR90T86napsaOM4AzHTUcGK/qLzxzlrDm8qkVyYyNxCu10l6CNaWHzUWNip3yJINg/evYFJtjdwoLaPflnrznOg8UYUnb5qm3RzYtvlbDvE73l7yUqaAI3yeoGxAAc5rMaTMKDixShVnFmYAAxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668683; c=relaxed/simple;
	bh=gW5e4UUKkFvDixTeMsmDyRw03WV0ZOSyoerB3KXte8w=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=os/U6D9K4S8BXvGaGd/lsOGY+o1WqTnFdtn8lREg0587+KDCRhMABJxTITDxe84BVj07b3JXygIhxVZqU1cKrhs+qHMt68LM6ARfSYgKUL0YSy5nilawYbSZIL4q+XJjeEmrJCcgrKwrG5DK62phQ4Y+9XMhEYLB5aMbtZE/xQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWO1xJZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3852C4CED3;
	Thu, 23 Jan 2025 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737668682;
	bh=gW5e4UUKkFvDixTeMsmDyRw03WV0ZOSyoerB3KXte8w=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=HWO1xJZ/hnv71a5Qw+dycZXT9KLEl2sVTYPi7H72hCf07v44eaw207mu8JT450jwF
	 D5V/gXec776rbhvy0c79R5G+zifuf85G9SiWQt+YEJrZIkx5kK9086a+S5qGmVcwcL
	 4Z9vxZ87A+GkTAzCY1d5noORnme3jFBvsvPh/FrpeQJcKEemCrgPNbIfxu4aKmz8tN
	 nixn7FB1vWulcuZ3TWOjir8z5rE0ust3YIAfl3RDPBFUf/lnnnjEg8HHM5J5pFQto3
	 wRTC+4KsTSPSH9H6Bkz2l5f+aj7kURLx9XbFqDP9nTbP+nG8V7YBC0jdLsFOn8TJHf
	 WsfkPw2mMhLWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3F2F380AA79;
	Thu, 23 Jan 2025 21:45:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 23 Jan 2025 21:45:25 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: carnil@debian.org, benoit.gschwind@minesparis.psl.eu, 
 chuck.lever@oracle.com, jlayton@kernel.org, herzog@phys.ethz.ch, 
 baptiste.pellegrin@ac-grenoble.fr, anna@kernel.org, trondmy@kernel.org, 
 harald.dunkel@aixigo.com, linux-nfs@vger.kernel.org, cel@kernel.org, 
 tom@talpey.com
Message-ID: <20250123-b219710c21-b291a88da6a9@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

An RPC task has shown up in the "rpcdebug" output this time:

kernel: [262696.214194] -pid- flgs status -client- --rqstp- -timeout ---ops--
kernel: [262696.214199]   112 2281      0 a6ceb575        0      357 83bde67e nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:delayq

Here is a CB_RECALL_ANY operation that is waiting to start. It's in the RPC client's delay_queue, so this looks like it came through the NFS4ERR_DELAY arm of nfsd4_cb_sequence_done(): the RPC was reset to the beginning of the FSM, and rpc_delay was called.

There is a commit missing from origin/linux-6.1.y:

961b4b5e86bf ("NFSD: Reset cb_seq_status after NFS4ERR_DELAY")

Without this commit, the server will continue rescheduling this RPC forever. That could be what is blocking rpc_shutdown_client9).

This commit is applied to the nfsd-6.1.y branch of:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Can anyone on a v6.1-based kernel pull this branch and try it?

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c21
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



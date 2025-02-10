Return-Path: <linux-nfs+bounces-10013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD856A2F1FD
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA2C16226F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1B241C8C;
	Mon, 10 Feb 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdulBHRc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47024BD0E
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739202279; cv=none; b=L9dQBdmGatz7gDPrlLcjcLp6kAyxmEysDDEibpKIrSTGNKfvbLJKfyxzaa2zQSR08U1v17uhb0FNAJCihyItylWAnifbtd35tcrywOKsRRH2Mtc6aZ4EGqHyFyR8Lu3a/iX00NEHRglXDi9+rf+npdgLZ6N+/TDHEmOST4yIu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739202279; c=relaxed/simple;
	bh=Nk+1AvcpuFmMAkvHsD/vvFtuJ3akSup76josOKuADaY=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=uFHeO+BqZ3PoQD5hjKKS9Hlsb1JdBRTf/1jcwlqqpFadJBtUVb5NYQ98Qff4WJqHpu8qW3cPdoaQOgvJ0E02QNwkppI5fI3mG57zWT4U9gKIqH2f/zVtAzfKsgfwXeVwxr28PXFj2XsR6w5JLgVugk8ZAVPUw5v63xTzRMiI+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdulBHRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC097C4CEDF;
	Mon, 10 Feb 2025 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739202278;
	bh=Nk+1AvcpuFmMAkvHsD/vvFtuJ3akSup76josOKuADaY=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=cdulBHRcJXyNAKvnSzgTSIfisfT0uCVbkigr+k/uqO8asxzz26LejSZd9eGufOPZ5
	 dZtSnGoTNe13drSPbZKfIUv/QiKyZx8pWIs8Jrbmhu4E/UhKVR6Y7PMHXbakj/yIBm
	 rOlHHikhriE/hwmA673Am2d/qEec0evaX5s0Mjow64zLj+y10njl/M+oz1w2Ewfd1W
	 C7dWOnPzOlHWgGKwM9xm2Owx4FGp7NvpyZA8QaFgBskChXo3Kr72lWb0w4iJNGCkNO
	 qkjcVvASqdNVy1/WkK5JACt8454xrHq4A4WstOtpbARI+GjYnRDRoOotwCQN0EyLUt
	 D4Eect3YmnlnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 748AB380AA66;
	Mon, 10 Feb 2025 15:45:08 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 10 Feb 2025 15:45:13 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, aglo@umich.edu, linux-nfs@vger.kernel.org, 
 trondmy@kernel.org, anna@kernel.org, cel@kernel.org
Message-ID: <20250210-b219737c9-d71d16c944ba@bugzilla.kernel.org>
In-Reply-To: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
References: <20250130-b219737c0-091f27de8b7a@bugzilla.kernel.org>
Subject: Re: warning in nfsd4_cb_done
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

FYI:

521 == EBADHANDLE
10036 == NFS4ERR_BADXDR
3 == CB_GETATTR

The cb_status gets set via decode_cb_op_status() during the decode phase and is not cleared in nfsd4_cb_prepare.

Note that the code will call rpc_restart_call() in the NFS4ERR_DELAY case, which skips the  rpc_call_prepare phase when the task is restarted. So, I think this may go something like this:

Get a NFS4ERR_DELAY in a callback operation, that restarts the call but doesn't clear cb_status. Then on the next attempt, it gets a non-zero tk_status (and probably skips the decode phase). That would cause this warning to pop, I think.

In practice, I'm warming up to the idea that this entire if statement is just bogus:

        if (cb->cb_status) {
                WARN_ONCE(task->tk_status,
                          "cb_status=%d tk_status=%d cb_opcode=%d",
                          cb->cb_status, task->tk_status, cb->cb_ops->opcode);
                task->tk_status = cb->cb_status;
        }

Consider the case where we successfully decode a cb_status value but then some later field in the reply was corrupt. We will have set the cb_status, but the decode will fail which will cause the tk_status to be non-zero, and this warning will pop.

I think we should probably just remove the entire if statement above.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219737#c9
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



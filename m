Return-Path: <linux-nfs+bounces-9532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687F6A1A539
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8C73A8407
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB020F081;
	Thu, 23 Jan 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGLCFwhq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C41C6F70
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640183; cv=none; b=hUgjBBWEioo5aWs+DNn039q2MlYFeFUlkf6BfX9U5iPgI26XjYpO7uiPdAcgARo20CuTW1/z63ISU0IyZ34S/f4D2c19KlDcs6yk/cKphYy3eP/E+R4rcnD+zxvJLdAl1jYSfp9Iyfzix9eLJ5YAmYr1d/sqrIqkTSicAZJQBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640183; c=relaxed/simple;
	bh=7PwjEGy4eO4r9n7zeC0LHQvd03M8uT8bc9RuQmChip8=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=g0R2uIXNcFPQT4bKbVRmwJxlEdRdiSJYK8GvpczMAkvtjVy5ZZhxDe6Q0/StRtFKz8uULXPXHnNDxh3xR9maDTOm1UQ4gwqm3CPte1Hoyk6YGugzct8Xd+8BQ4Y1h1g4qvFxOphL/6GYmWpJBw4OCHr2ot6f9JppQOdAd66PFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGLCFwhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC56C4CED3;
	Thu, 23 Jan 2025 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737640182;
	bh=7PwjEGy4eO4r9n7zeC0LHQvd03M8uT8bc9RuQmChip8=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=oGLCFwhqh8Bc0P6wnt7epMdXnTwmVN9ca0Umv8IjIUHHaB0U9MpBYxS2TlCbKeuki
	 iauMxRQelAynToN6Eq58PjQ1kk/ajIhqtsxrfrpiCkBC2mmF6VQ6FcPd/1SlOqxuJC
	 kIDtfp5a1FeOpRBBs6Ee3bRKlvItEcIGhF9WOhsHsYHVT62GSzfQ2J+yhAEFQDpBoC
	 LvbG6mmQ560QM+V17Q/3gqpO8bd7R+7Z2NQ/72fwUX9wjshnkpm8RDplvqTk/npq/x
	 HVBP6RvGWR2MnW9jKROISwRVmTD+Y+l3l+rZ2LxtkXEeOTmNSR5FzGDiSkpEmhMQD2
	 3K2cjJYy8cMNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B76E380AA79;
	Thu, 23 Jan 2025 13:50:08 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 23 Jan 2025 13:50:22 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-nfs@vger.kernel.org, jlayton@kernel.org, chuck.lever@oracle.com, 
 herzog@phys.ethz.ch, tom@talpey.com, carnil@debian.org, anna@kernel.org, 
 benoit.gschwind@minesparis.psl.eu, trondmy@kernel.org, 
 harald.dunkel@aixigo.com, cel@kernel.org, baptiste.pellegrin@ac-grenoble.fr
Message-ID: <20250123-b219710c18-e354a69e709a@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

There is another scenario that could explain a hang here. From nfsd4_cb_sequence_done():

------------------8<---------------------
        case -NFS4ERR_BADSLOT:
                goto retry_nowait;
        case -NFS4ERR_SEQ_MISORDERED:        
                if (session->se_cb_seq_nr[cb->cb_held_slot] != 1) {
                        session->se_cb_seq_nr[cb->cb_held_slot] = 1;
                        goto retry_nowait;     
                }      
                break;
        default:                          
                nfsd4_mark_cb_fault(cb->cb_clp);
        }                       
        trace_nfsd_cb_free_slot(task, cb);
        nfsd41_cb_release_slot(cb);             
                 
        if (RPC_SIGNALLED(task))
                goto need_restart;
out:                  
        return ret;
retry_nowait:
        if (rpc_restart_call_prepare(task))
                ret = false;                
        goto out;
------------------8<---------------------

Since it doesn't check RPC_SIGNALLED in the v4.1+ case until very late in the function, it's possible to get a BADSLOT or SEQ_MISORDERED error that causes the callback client to immediately resubmit the rpc_task to the RPC engine without resubmitting to the callback workqueue.

I think that we should assume that when RPC_SIGNALLED returns true that the result is suspect, and that we should halt further processing into the CB_SEQUENCE response and restart the callback.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c18
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



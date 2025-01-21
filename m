Return-Path: <linux-nfs+bounces-9428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF0A18025
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 15:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72847A49EF
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852681F471D;
	Tue, 21 Jan 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dckduYVG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5861F1508
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470386; cv=none; b=p429OtNwpgGhdEQYp+HaYUmWYACIPsvszmSAtmimzclLt9Xsn18Ue8OuW2tHYHuRHkRX44RZGmlFBFJMdZ5EngY5BkQTttuiqmConSrO+s3Sj/JFeLgdGGd6gFne1qbtvM9OGTi2LDQZ6U5VBPVYyrJTFgWnW72AKtUq7shMfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470386; c=relaxed/simple;
	bh=JwvDXxeovGirpBz0WpceY0kV3joJ8eTldyOvGwuA/yg=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=F1Ntdbb5HzDmOcKVegZOOHbQsDbpWOFag7PuWDi7ilyWbBuRhM8fBcWeeJbPC285f491NY0uYgMvafYjwdpkdUqmIWEmGRO5NX4RRd/ItDzKbkZgCwvyCYse/hjoTn+wobcF6D6WI0kvRNQChAgQWG5tn0kjHMgm8VpenJVx7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dckduYVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44BDC4CEDF;
	Tue, 21 Jan 2025 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737470382;
	bh=JwvDXxeovGirpBz0WpceY0kV3joJ8eTldyOvGwuA/yg=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=dckduYVGMPIbLCeRraaJBrQ3u0mmyc7BdVAr+xxid5cDj4h/WNg6Va8GI2NUmMwv5
	 ZEHEVHPWNiZJ34BgWKn9XzIbGFUpyuwDFUCWayTSJub+omWVBf4Vn98jMSYaDWX+2P
	 wEcnEUIrvAdcLLiH8KYviNR0SU4KfbOKR99FkAi6BcmsPdlyFUZ+zN+sJqmVQIz73R
	 Ohx+IfsDVxGDkOBzo8lSOj18Ox+ofyKVeV1OcRz42lBC74WQzcz1xe5+60QaInmUlE
	 sbWJFMJijGrvmrcpRhomFMxhwxhAypXcpgZ/rY59C6hCJJeMTZR60r6H99FCICGBjY
	 OEpxVaJ/bmgkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EA268380AA75;
	Tue, 21 Jan 2025 14:40:07 +0000 (UTC)
From: Jeff Layton via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 21 Jan 2025 14:40:10 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: baptiste.pellegrin@ac-grenoble.fr, harald.dunkel@aixigo.com, 
 linux-nfs@vger.kernel.org, carnil@debian.org, 
 benoit.gschwind@minesparis.psl.eu, herzog@phys.ethz.ch, anna@kernel.org, 
 chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org, 
 cel@kernel.org
Message-ID: <20250121-b219710c6-6f1a22cc3afd@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Jeff Layton writes via Kernel.org Bugzilla:

I looked at this with Chuck the other day. As far as wait_var_event() getting stuck, I think all that would take is for nfsd4_cb_sequence_done() to continually set cb_need_restart on every call. That would cause the callback to not be destroyed and to never call nfsd41_cb_inflight_end().

That happens in the need_restart: label in nfsd4_cb_sequence_done. These two cases goto that:

        if (!clp->cl_minorversion) {
                /*
                 * If the backchannel connection was shut down while this
                 * task was queued, we need to resubmit it after setting up
                 * a new backchannel connection.
                 *
                 * Note that if we lost our callback connection permanently
                 * the submission code will error out, so we don't need to
                 * handle that case here.
                 */
                if (RPC_SIGNALLED(task))
                        goto need_restart;

                return true;
        }

        if (cb->cb_held_slot < 0)
                goto need_restart;

It doesn't seem likely that it somehow lost the slot, so my guess is that the RPC task is continually returning with RPC_SIGNALLED() set.

Question for Baptiste -- what NFS versions are your clients using?

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c6
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



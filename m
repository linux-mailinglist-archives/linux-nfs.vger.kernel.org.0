Return-Path: <linux-nfs+bounces-9396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FEA16F2E
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35F116A143
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2025 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274701E3DE4;
	Mon, 20 Jan 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNH912In"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240817E015
	for <linux-nfs@vger.kernel.org>; Mon, 20 Jan 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386684; cv=none; b=GFTQCC59NWfy5abA0kATmBZ52sZ9yKMZ87t57j5jY7o9iNm/uzeE0jdoFbruZ/kjz3RXDxLKGVzbHH7Mu9Xfbs1P2/tKwTwsaKJLxHhVJHHOeWuar5zgfSDhIzxYi7ZT8r4i0kgxuGMfqHkc5u9sjpPopfjX/5DN05ZUGEvk1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386684; c=relaxed/simple;
	bh=dK4qV4W9gOH29KL//sZ+UMppTMgLT+VKNL2wmGghNDs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=H/OFIfjWRdZUhWeSz4NPFqDre+dx+w4J6svXGpAZM8a32EiqfhuX3nafxMYU4uhZJxmPjWD2qqJKVZbHy79QneMmZEWyhaw77VQuJ0F48M4mjoCdr7KNLz5Mwe/8jf/wo4aHy6TTF9PVrIluLl3yrjgjaHFNcURcmrgqwxkZcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNH912In; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3C0C4CEDD;
	Mon, 20 Jan 2025 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737386683;
	bh=dK4qV4W9gOH29KL//sZ+UMppTMgLT+VKNL2wmGghNDs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=bNH912IngdPmABI1c6odIGgT+zCJJSVDOipoTnBC+zdz5BKuOCv6iSswCWQSF4ArP
	 8vLXqtunNQ6JxRlKkf22iR3FJByJcx17TvvIlGYZZxhaVW0WfLr/MyoK5elHEZNaV4
	 zXp0yNeiqD/NlsC58hDHDAc4sTIEbyoSPq5n78E5NldlgqGovX/OdHQORIZkDIcJ0j
	 gQ240UUZV7OfbzWD19yR8JrzHJux5XJ0lF0pHtUc4/ZBMombn2vqtWsaBl0c2ST+Sq
	 1IfbzOrdjgwtKjaf3WB8GdeRe1zlC/yNJCK1fcGllScfFugC80u/YS3xL29gmUhfCs
	 ACzYep3AG6v6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77F71380AA62;
	Mon, 20 Jan 2025 15:25:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 20 Jan 2025 15:25:06 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cel@kernel.org, chuck.lever@oracle.com, harald.dunkel@aixigo.com, 
 jlayton@kernel.org, baptiste.pellegrin@ac-grenoble.fr, 
 benoit.gschwind@minesparis.psl.eu, carnil@debian.org, 
 linux-nfs@vger.kernel.org, anna@kernel.org, trondmy@kernel.org, 
 herzog@phys.ethz.ch
Message-ID: <20250120-b219710c2-686c14fdd419@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

During server operation, you can capture trace events that might lead up to the hang with this command:

# trace-cmd record -e nfsd:nfsd_cb_\* -e sunrpc:svc_xprt_detach -p function -l nfsd4_destroy_session

These events are infrequent and tracing is lightweight, so this capture won't be a burden.

When a server hang is observed, typically, "INFO: task has been blocked for 120 seconds" appears in the server's system journal. Basic collection instructions are:

# rpcdebug -m rpc -c && echo t > /proc/sysrq-trigger

Then stop the trace and package trace.dat and the system journal and attach them to this bug.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



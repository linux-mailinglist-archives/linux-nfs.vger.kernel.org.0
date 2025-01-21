Return-Path: <linux-nfs+bounces-9432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7CA1820A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 17:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D5B1887CAD
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jan 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F21F3FFD;
	Tue, 21 Jan 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRhr4DkN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83B1741D2
	for <linux-nfs@vger.kernel.org>; Tue, 21 Jan 2025 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477284; cv=none; b=U3VTL9iJkBNU4lNhuwrVi12lO/RslIPO2nBPeLv2O9vNrJD1KzLSPekE9n0A99XbgU3PcLWNICUXeIrAe8btJcPLokfPHpIYTVARBYOAb5fhETYvJURD9HPxeHeLW0mLttyLQYBMH/KBd/HdNwRO03CPeeDraxr1r7es4gZNX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477284; c=relaxed/simple;
	bh=JrzQkYl/etU/3TTDjECDZjOn2xoAFQjTMR7ctCNjaFo=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=L6X36aIt5uomC653NkAus1/vpEJdwX2+Rs8VIbIei9I1mWJ11tteU30psfI7mc/kg1bJKLr8XMm+22TN15ssC1CzqbTThoOp/dYLPYne+ztz36lmu5iPr5MfEBbecGqB7FjNWV/my5M5tbs2wvMwG5pc29ME3TLB2/CC9Pa3ZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRhr4DkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB449C4CEDF;
	Tue, 21 Jan 2025 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477283;
	bh=JrzQkYl/etU/3TTDjECDZjOn2xoAFQjTMR7ctCNjaFo=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=HRhr4DkNTPL8EMIDiIr8e8xIQqrTVSwozoQuEP5Eb/l3+hGbkSQYDHKT+pbS68I0a
	 gPNgJbP4mVaSywTyEa4/0nir2r9jv4d+OJ+hNF18ZQgc2I3rTlHlL0kn2UcIzcVqpa
	 WJYJw6GCNfuyGxke/8dVEYjvRT1sbcbw9cAqGcPucLjyuuYughn9C3i8xXxxtXquoD
	 N3wCNGWxLIJVUN2ivl70Oz/hsdJnCQ99pPuoGan8sUFJuuXeYXd+KZfq1fdVZz0iFw
	 RV1FIcotS17NE3ZRW7K4RCUq8ebvO411dqvnLg7sS3kU+FalZQ7XLhUnzEaqlCGtQ6
	 iM8zvFv6CqLkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F03F0380AA75;
	Tue, 21 Jan 2025 16:35:08 +0000 (UTC)
From: Chuck Lever via Bugspray Bot <bugbot@kernel.org>
Date: Tue, 21 Jan 2025 16:35:13 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: herzog@phys.ethz.ch, linux-nfs@vger.kernel.org, 
 baptiste.pellegrin@ac-grenoble.fr, anna@kernel.org, 
 benoit.gschwind@minesparis.psl.eu, carnil@debian.org, 
 chuck.lever@oracle.com, jlayton@kernel.org, trondmy@kernel.org, 
 cel@kernel.org, harald.dunkel@aixigo.com
Message-ID: <20250121-b219710c9-24c03eb0cb57@bugzilla.kernel.org>
In-Reply-To: <20250121-b219710c8-a588c580949d@bugzilla.kernel.org>
References: <20250121-b219710c8-a588c580949d@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Chuck Lever writes via Kernel.org Bugzilla:

(In reply to Baptiste PELLEGRIN from comment #8)
> I always see one or two "unrecognized reply" message around 120 seconds
> before the hang message.
> 
> So it may something that happen on client or server weekly jobs ?
> Or maybe some memory leak or cache corruption ?
> Or something related to expired Kerberos cache file ?
> Or expired NFS session ?
> ...
> 
> It seems also that the number of nfsd_cb_recall_any callback message
> increase with the server uptime. This seems in favor of the memory leak
> hypothesis.

The server generates a CB_RECALL_ANY message for each active client. If the number of active clients increases from zero at server boot time to a few dozen, that would also explain why you see more of these over time.

If your NFS server does not also have NFS mount points, a few client-side trace points can be enabled to capture more details about NFSv4 callback activity.

"-e sunrpc:xprt_reserve" for example would help us match the XIDs in the callback operations to the messages you see in the server's system journal.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c9
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



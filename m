Return-Path: <linux-nfs+bounces-9619-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE43A1C726
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EDE1886FC5
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408DAB663;
	Sun, 26 Jan 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SORcp+Nc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B926AD39
	for <linux-nfs@vger.kernel.org>; Sun, 26 Jan 2025 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883483; cv=none; b=fr+1fHt3Y0p5Q+dOZv1cMIuvGdu+/eMceh0yyZEE5keuIAYae7Syi8pL9OILQ1fzoK5/IiaiLrYtH1/CfT1Cj4rbPyRiNkLBVgkO+KoHuouJUh+zRTuc/O/YfuGyol/TyreQk7SGrwx7/lvT4Z4sqWruwn7bv2y8FeQ3HBm+QyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883483; c=relaxed/simple;
	bh=HYe/yY5JXQwVmI3Nr6aCyC678vykJ5/ywOeA/zU/dkU=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=KFaIV1HoLRhfGM8CDn4SPtOeQaD9ILeTg8kmNCbKh7adD35TiE4jtQ5F59+gTIqiQotGyXJMkLtFQn3RasBD2EskXoUd1Ri9X/8dffwK+zbC8qX4aGHj2B6OZQQseOJKA29YrFB2r+/9nZSLfKIRZ++DRie++bOdcVAoQ5SpaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SORcp+Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969D4C4CED3;
	Sun, 26 Jan 2025 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737883482;
	bh=HYe/yY5JXQwVmI3Nr6aCyC678vykJ5/ywOeA/zU/dkU=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=SORcp+Nc5SJD7A6AO5j7WPdkR1TowNz5Ir5idxf2KfRE3K/QpzgWiWqIbdiH385X2
	 TzZHrX2ne9buWVqXxrEiPzanyqOH5TDVZ8QxqbGirdsFRFgUJOWcMTCaHHp3G1B9PA
	 L2P8IS4G6pcOZMNuQpZXOKur/QZAQWs0uckf+So/heTUrVXVdLjMEq1rTFkbj+WR0N
	 D1yKpZNTJTSThGV4x+nZwHdbJ8H/cOvYYTEOzlin4Z3ASvpGfbuyTuiPA7fheUmLu4
	 BFlojljEFH2yUdHyl3PK9MTgGKTv+ZpQnyFX/Dd2f+3VD4ZbW7ebiv4+PRHuIepy+s
	 BXI5TrDX4DQGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F235D380AA79;
	Sun, 26 Jan 2025 09:25:08 +0000 (UTC)
From: Baptiste PELLEGRIN via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 26 Jan 2025 09:25:26 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
 harald.dunkel@aixigo.com, herzog@phys.ethz.ch, carnil@debian.org, 
 tom@talpey.com, trondmy@kernel.org, jlayton@kernel.org, cel@kernel.org, 
 anna@kernel.org, baptiste.pellegrin@ac-grenoble.fr, 
 benoit.gschwind@minesparis.psl.eu
Message-ID: <20250126-b219710c22-172df050e851@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Baptiste PELLEGRIN writes via Kernel.org Bugzilla:

I patched the current Debian stable kernels :

Debian Linux 6.1.0-29-amd64 (= 6.1.123-1) Based on Linux 6.1.120
Debian Linux 6.1.0-30-amd64 (= 6.1.124-1) Based on Linux 6.1.124

with there two commits :

8626664c87ee NFSD: Replace dprintks in nfsd4_cb_sequence_done()
961b4b5e86bf NFSD: Reset cb_seq_status after NFS4ERR_DELAY

Now my two NFS servers are running these patched kernel. I need to wait one week to see If the crash still occur.

Chuck, does this patch may remove the "unrecognized reply" messages from my syslog ?

I see you have improved the backchannel session logging. Did I need to change my trace-record command ?

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c22
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)



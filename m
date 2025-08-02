Return-Path: <linux-nfs+bounces-13392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0709B18FDF
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Aug 2025 22:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BEB17C1F4
	for <lists+linux-nfs@lfdr.de>; Sat,  2 Aug 2025 20:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9C51DF270;
	Sat,  2 Aug 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HaoGMeQ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81822AD11
	for <linux-nfs@vger.kernel.org>; Sat,  2 Aug 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754165223; cv=none; b=Ts+Sb4nbqjcZ7PJP8XEnMdcGOyga/yd6v+haaInSH6KSb/5qQ3+krKUsV2A1HEikZ3PoUGCaJB/xPWEn2JJz8Q0SEpR/i8BPVs02zC0lQIf77W2Cu4un5VJOq1KQG5Y2PfBj2yFpXueybQ0gBF/vvthamC6wsUk5BITfjpNp8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754165223; c=relaxed/simple;
	bh=/fpSIJZiKBG8PFtdr1EYbaj+owOIrcy2b0pF5ObT7FU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TmgF6rZvaEbGSSv5vWQRcqm4QkIKc4CgRIht0KhF+ernVz41i+ZheHZgvzJMELrJahBNY8nNplt36vm1WF1+aS4TsBBCDkUxkqLeBTokwPNSrEOIMbi6Hsf0B7KdeJwzLKg8h7z80Kj4g8YesKXhLRyn+xcfnwjhttmDLutMrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HaoGMeQ6; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1754165204; x=1754424404;
	bh=/fpSIJZiKBG8PFtdr1EYbaj+owOIrcy2b0pF5ObT7FU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HaoGMeQ6DBbaL8ZqNG+63StKIFy2Ke+0Z62zO/lXQ4DulTCHF7J1brJtpPi1+UG9D
	 mGooH7WXqnlAAVEJYGgLw8hLEzOnqBm3ohMxGw9PDdk5D0qEdkrJKlYoEjUZGJzEqg
	 sCsChe8cN+LCbqV5+k4Tm5IM9BKMZJKnHvtcqnabD+4U3new3LeLoPwFQLQQmmb3GT
	 8PsSyUbqVSOOb3QKRc2bt3UTjleEnQigvI5hRtK8CGubXn3DP0v+uOX05t2s/OVqx2
	 A6aTzcz7fgpseNcRMWBeZtSKcSm8fq4voqpIqytu6aPVC1Zk18iSRecAicSO4k5ftK
	 kRIXboWrJPFww==
Date: Sat, 02 Aug 2025 20:06:40 +0000
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
From: John <therealgraysky@proton.me>
Cc: John <therealgraysky@proton.me>
Subject: Missing pipe /var/lib/nfs/rpc_pipefs/nfsd/cld on OpenWrt
Message-ID: <Pm2hmCTqzxzgnGtJpzqYHI5uV7Z7oQjykswavqCewEF_9wqXOJo3_EXS76gIzkpfu9eJLSDlKgNwJrNmTWgD2vKSEr3kLyDsr_Fzzj6jRYs=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 584caf9f40a396c5a686816b4ee7a7466d108f20
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I want to modify the nfs-kernel-server package to use nfsdcld for client tr=
acking, but am hitting a snag: I can't figure out why the pipe /var/lib/nfs=
/rpc_pipefs/nfsd/cld is missing or what creates it.

Here is my current version: https://github.com/graysky2/packages/commit/c68=
d0ca16b3b69a0ffcad3dbb20bad58ee49a638

I have the lines in the init script to start /usr/sbin/nfsdcld commented ou=
t so it can be run manually with the debug option on the shell to see why i=
t fails. What creates the pipe /var/lib/nfs/rpc_pipefs/nfsd/cld and why is =
it not doing so is the questions I cannot answer. Any insights are apprecia=
ted.

# nfsdcld -F -d
nfsdcld: sqlite_startup_query_grace: current_epoch=3D1 recovery_epoch=3D0
nfsdcld: sqlite_check_db_health: returning 0
nfsdcld: sqlite_copy_cltrack_records: returning -1
nfsdcld: sqlite_prepare_dbh: num_cltrack_records =3D 0

nfsdcld: sqlite_prepare_dbh: num_legacy_records =3D 0

nfsdcld: cld_pipe_init: init pipe handlers
nfsdcld: cld_pipe_open: opening upcall pipe /var/lib/nfs/rpc_pipefs/nfsd/cl=
d
nfsdcld: cld_pipe_open: open of /var/lib/nfs/rpc_pipefs/nfsd/cld failed: No=
 such file or directory
nfsdcld: main: Starting event dispatch handler.


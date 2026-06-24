Return-Path: <linux-nfs+bounces-22799-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nJY4B4qdO2qhaQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22799-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 11:04:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36C26BCCA6
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 11:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Td6fOIN3;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22799-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22799-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A8B531080C1
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343A39EF2C;
	Wed, 24 Jun 2026 08:59:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760943932C9;
	Wed, 24 Jun 2026 08:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291583; cv=none; b=DPtTFj/49FB8vimbyqkAOQJ5cy8/9LS9hAVNLDpAto2TsPj4z/llkKRehM3viFGNQ8os/+vGu4ZNOjtrcaAgjyGW/6HEmdq7dM6BsbTJhOaT4bQcXgsD5g81XnnA58OoTXna7X7Ktq70rPmndSow2HimFeQ90kKH/O2Ic4lr5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291583; c=relaxed/simple;
	bh=4e2lvbGRAzSrAQ17eFCaDg3KhOLO9JpUk9tU+XsYGgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VW/QTNDDROlc4Z++sRTN85FUy0nIyQhZ/lttrKsYqBk80TdoX2EowLJk0hdvMCnIuw7RbLkMEo/xQFPINn7n8e5gFs3VxOxhWv31cyCbzAVGg2PyIzAbqqYJ16xJyiVGWYBhJWsgNAsbpEqdSZx24thT16GkTCvxGi5oP7szJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td6fOIN3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76401F000E9;
	Wed, 24 Jun 2026 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782291581;
	bh=TM6/7W5L0lECPXJpPRC/prv4vynbdZprP5beN/B/udw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Td6fOIN3/f0VBzergs0drcUYmXQQAsvO4StGVdMIjfzMrq302z0CgE5PZLuvuGTgu
	 y6OwsR7LXPEEFrY7QrkK2hSlHI12MXhmVem1daB0+ozFWkUYEuEItyZJ7vx5MyaS+t
	 Oc1WA2rvp0/OSZzW0f3+n0kg+mE0TC3Ab6FQDwqtxJv9M6iyI463PwXDsZeJtaXgH8
	 cA97HZbh6WLwIiL86WWHqng6yP/LFC+v3mboYn4sGQCZ08gXpiYOtiLe5h2IPQIEJa
	 sokPZW3EP5W8SOl4LwWjYysGGnj4trZOS4gry4rVwbkUraPobHITXsNO5d1m/HquOK
	 yCniGim9xfQ2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A4A39EF964;
	Wed, 24 Jun 2026 08:59:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v14 00/15] Exposing case folding behavior
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178229156954.2577930.8082691450605559803.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 08:59:29 +0000
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 roland.mainz@nrubsig.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, sfrench@samba.org,
 slava@dubeyko.com, djwong@kernel.org, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, stfrench@microsoft.com, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, chuck.lever@oracle.com, hansg@kernel.org,
 anna@kernel.org, linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com,
 trondmy@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,manguebit.org,sony.com,nrubsig.org,paragon-software.com,dilger.ca,vger.kernel.org,samba.org,dubeyko.com,microsoft.com,vivo.com,gmail.com,physik.fu-berlin.de,mail.parknet.co.jp,mit.edu,lists.sourceforge.net,chromium.org,oracle.com,samsung.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22799-lists,linux-nfs=lfdr.de,f2fs];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:pc@manguebit.org,m:yuezhang.mo@sony.com,m:cem@kernel.org,m:roland.mainz@nrubsig.org,m:almaz.alexandrovich@paragon-software.com,m:adilger.kernel@dilger.ca,m:linux-cifs@vger.kernel.org,m:sfrench@samba.org,m:slava@dubeyko.com,m:djwong@kernel.org,m:linux-ext4@vger.kernel.org,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:sprasad@microsoft.com,m:frank.li@vivo.com,m:ronniesahlberg@gmail.com,m:glaubitz@physik.fu-berlin.de,m:jaegeuk@kernel.org,m:hirofumi@mail.parknet.co.jp,m:linux-nfs@vger.kernel.org,m:tytso@mit.edu,m:linux-api@vger.kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-xfs@vger.kernel.org,m:senozhatsky@chromium.org,m:chuck.lever@oracle.com,m:hansg@kernel.org,m:anna@kernel.org,m:linux-fsdevel@vger.kernel.org,m:sj1557.seo@samsung.com,m:trondmy@kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B36C26BCCA6

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu, 07 May 2026 04:52:53 -0400 you wrote:
> Christian, let's lock this one in. I will post subsequent changes
> as delta patches.
> 
> Following on from:
> 
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v14,01/15] fs: Move file_kattr initialization to callers
    https://git.kernel.org/jaegeuk/f2fs/c/14c3197ecf07
  - [f2fs-dev,v14,02/15] fs: Add case sensitivity flags to file_kattr
    https://git.kernel.org/jaegeuk/f2fs/c/3035e4454142
  - [f2fs-dev,v14,03/15] fat: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/c92db2ca726f
  - [f2fs-dev,v14,04/15] exfat: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/27e0b573dd4a
  - [f2fs-dev,v14,05/15] ntfs3: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/eeb7b37b9700
  - [f2fs-dev,v14,06/15] hfs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/b6fe046c3023
  - [f2fs-dev,v14,07/15] hfsplus: Report case sensitivity in fileattr_get
    https://git.kernel.org/jaegeuk/f2fs/c/a6469a15eefe
  - [f2fs-dev,v14,08/15] xfs: Report case sensitivity in fileattr_get
    https://git.kernel.org/jaegeuk/f2fs/c/c9da43e4e5c3
  - [f2fs-dev,v14,09/15] cifs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/e50bc12f5a36
  - [f2fs-dev,v14,10/15] nfs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/92d67628a1a9
  - [f2fs-dev,v14,11/15] vboxsf: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/ef14aa143f1d
  - [f2fs-dev,v14,12/15] isofs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/7bbd51b1d748
  - [f2fs-dev,v14,13/15] nfsd: Report export case-folding via NFSv3 PATHCONF
    https://git.kernel.org/jaegeuk/f2fs/c/211cb2ba4877
  - [f2fs-dev,v14,14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
    https://git.kernel.org/jaegeuk/f2fs/c/01ee7c3d2e23
  - [f2fs-dev,v14,15/15] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
    https://git.kernel.org/jaegeuk/f2fs/c/0164df1d1de7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




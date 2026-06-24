Return-Path: <linux-nfs+bounces-22800-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OLWcFMycO2p+aQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22800-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 11:01:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056E6BCC2D
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 11:00:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cmfji3PW;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22800-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22800-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81417304C346
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5808D39D3FD;
	Wed, 24 Jun 2026 08:59:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0033A1A2D;
	Wed, 24 Jun 2026 08:59:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291590; cv=none; b=Bc55lRkgWEC+2MKFqS1/SdHVIa+piWj6SWtj0wuOsDrdznck9xlFC5vmCiaz+/Dmr/lpw1QNXe1OdAdFl1rjqv1UDdN9ghkw4R3orlttR/QRbYEsYUtpqXbp+QD479pTbsD9wafOaxnKNubgjkw3BQAH3/QT8I5lMJdrpNApXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291590; c=relaxed/simple;
	bh=ETK/3fIWVJgZ66RkvKFMZ1xoiAvUnqVHg8A9UlR6oO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hHLdk0ycu2OHmAfj13QPiVL5MhORtVtnq3dBCY6ji4ISmSakj7PCEVyY8Nif+7DfaYYQaVMqYSjff0wJ84dQqkDNWUT9JD+XE2BdN8/Eq8Epctp4lfSvKxSnP+FJ6IvFPg7s9x8yxiTuNPkmKGj7I1pDWHkYKIfsq3vGn7t6N5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmfji3PW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E931F00A3D;
	Wed, 24 Jun 2026 08:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782291587;
	bh=DCKt4O2HlnFxHy8Mhm2C2zuPcXHOFrNOinuxD1UUcRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cmfji3PW0AVDGKQ4BufZEBDJWiQm1o8/rQsb7n4IPtwL2Bri4DpGeykggivNXbeKl
	 bstR8Aj141x+SXVVytHk70wMVpKQ2bDQeC4RGdfuf925UT+hEoMCDYVxscMlqcrn3d
	 6xnEmkWJdCUcpVMSWDpNGerH9VyGcglmIk/mUCMD0BiEP0cv0fwfWo3JgHR5YPVrnL
	 Jte9tPT/yzkvqV00w5paETjF56VjF6ALEXGUBYhw0wOJsEeEWA+2CMVQPU75HFlWVo
	 MQXB30pU37MXc/fscX12cEexVJBV1ND0Xny4mZBk5+ARKMHfjuwtW9baGkR7d+IuXL
	 XUjSsQ4FUeCjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196D839EF964;
	Wed, 24 Jun 2026 08:59:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v8 00/17] Subject: Exposing case folding
 behavior
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <178229157577.2577930.354083176752004996.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 08:59:35 +0000
References: <20260217214741.1928576-1-cel@kernel.org>
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,manguebit.org,sony.com,paragon-software.com,dilger.ca,vger.kernel.org,samba.org,dubeyko.com,microsoft.com,vivo.com,gmail.com,physik.fu-berlin.de,mail.parknet.co.jp,mit.edu,lists.sourceforge.net,chromium.org,oracle.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-22800-lists,linux-nfs=lfdr.de,f2fs];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:pc@manguebit.org,m:yuezhang.mo@sony.com,m:cem@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:adilger.kernel@dilger.ca,m:linux-cifs@vger.kernel.org,m:sfrench@samba.org,m:slava@dubeyko.com,m:linux-ext4@vger.kernel.org,m:linkinjeon@kernel.org,m:sprasad@microsoft.com,m:frank.li@vivo.com,m:ronniesahlberg@gmail.com,m:glaubitz@physik.fu-berlin.de,m:jaegeuk@kernel.org,m:hirofumi@mail.parknet.co.jp,m:linux-nfs@vger.kernel.org,m:tytso@mit.edu,m:linux-api@vger.kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-xfs@vger.kernel.org,m:senozhatsky@chromium.org,m:chuck.lever@oracle.com,m:hansg@kernel.org,m:anna@kernel.org,m:linux-fsdevel@vger.kernel.org,m:sj1557.seo@samsung.com,m:trondmy@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-nfs@vger.kernel.org:query timed out];
	TAGGED_RCPT(0.00)[linux-nfs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1056E6BCC2D

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Tue, 17 Feb 2026 16:47:24 -0500 you wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following on from
> 
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> 
> I'm attempting to implement enough support in the Linux VFS to
> enable file services like NFSD and ksmbd (and user space
> equivalents) to provide the actual status of case folding support
> in local file systems. The default behavior for local file systems
> not explicitly supported in this series is to reflect the usual
> POSIX behaviors:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v8,01/17] fs: Move file_kattr initialization to callers
    (no matching commit)
  - [f2fs-dev,v8,02/17] fs: Add case sensitivity flags to file_kattr
    https://git.kernel.org/jaegeuk/f2fs/c/3035e4454142
  - [f2fs-dev,v8,03/17] fat: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,04/17] exfat: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,05/17] ntfs3: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,06/17] hfs: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,07/17] hfsplus: Report case sensitivity in fileattr_get
    (no matching commit)
  - [f2fs-dev,v8,08/17] ext4: Report case sensitivity in fileattr_get
    (no matching commit)
  - [f2fs-dev,v8,09/17] xfs: Report case sensitivity in fileattr_get
    (no matching commit)
  - [f2fs-dev,v8,10/17] cifs: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,11/17] nfs: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,12/17] f2fs: Add case sensitivity reporting to fileattr_get
    (no matching commit)
  - [f2fs-dev,v8,13/17] vboxsf: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,14/17] isofs: Implement fileattr_get for case sensitivity
    (no matching commit)
  - [f2fs-dev,v8,15/17] nfsd: Report export case-folding via NFSv3 PATHCONF
    (no matching commit)
  - [f2fs-dev,v8,16/17] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
    (no matching commit)
  - [f2fs-dev,v8,17/17] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




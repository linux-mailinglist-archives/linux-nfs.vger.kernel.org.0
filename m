Return-Path: <linux-nfs+bounces-21654-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDLPBSUSCGqUXwMAu9opvQ
	(envelope-from <linux-nfs+bounces-21654-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 08:43:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A968555A82E
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 08:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A179D30180BD
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5407B3603C2;
	Sat, 16 May 2026 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lte6xRJp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5173305672
	for <linux-nfs@vger.kernel.org>; Sat, 16 May 2026 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778913821; cv=pass; b=O7s/mjnXKQxVVKyr9obHNUP1uhC98Dh+b6bHS7RHmQWPB2bG9V+R43frP+LxqgLPr5o1lZ+jWafjpSZpNHIGc0pEFdWMc9AZhOpm5P0XsxdUCLyQHmOVhlT3tETV0thqJ2fkPBFBpZ/qVkYsAp+7KFfeQk2ugRnw4wPtg9cimSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778913821; c=relaxed/simple;
	bh=BOu7AkGfzBlU/bzal5lpBXqw/o4zx+y8OCCvr0FI1sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1arXFUwPUjb9kRyZYFqhLrYJcTkWqOjfPVXwVuJCHl/+dNSaVEzZ2EhinddvbJCt1QaFUbF9pjORyniIoC8sB3ZKNXeIffO+RmDQ2YaAavSSAbggS9nVyAuUUDDaCqOMvpP0tybf39tZK1XDXGmqNr6vPnqrXDEyLQRwKIQYIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lte6xRJp; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479f7e75a6bso213913b6e.2
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 23:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778913819; cv=none;
        d=google.com; s=arc-20240605;
        b=XsKo5eADcqzFFXYZDZmxZu1QfBVZTQVkZ7AHPrGDNTN642I3TeJR0yAaKAUMTAv9l2
         O0AtN6gYN3WP6kmGA7+JI7xBgk0gJTzNDmVFbfHUdcbEuk2o2CUdL+wN5R/U+VjiGmfG
         hb3CiDRtiyPDPT5tdUUiDk0WSE24XIz3EXzyOOuaO56xRMGaNbjHdpIHS0zhfWUw624G
         bWnvDy71fvuqIloDTBV2zlL5RwR2i3x8JbTuS497MrhGNYXC10rkDl+NpF/7AESvyC/N
         sVVVpxkhjRqWpKpWOi9pVN2D24tpvf/FerPXIe692nSri4WcZZ01K8Z7Z9pjEPAE5BVz
         s+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        fh=Nr4WKA/bobcohexTtJiGllKD0BTz6oZ9c9RQCZKmv2A=;
        b=KvPHrU8+U1GfF1BhKF9Cqu1x/PxUx/oq1Ik33gtBeXlSMnY+w7CrNhH4LRspU23SsK
         p579kVBWJ27il6n3GaFAyU4ofijCrqNije46Nc4SOxnSDcdiudefl1J5/C3eAnESRmLb
         Iz436SVK1CRKqrbQTmOViFE4Nr0mRGzzDMDt1fFgIPmqHpGca6sUDqL+GRXo5mgYsmK9
         DZ12m32ph2ck2kbWv2arJMU0brIB/jo3diAdARHDdVfOmuBhB5Ea9kyI37RULq3HL/0a
         iKxvnlgVusPZP/yBQK/pH1gpPoR8xEkq+cytso7n/YpLMUhTIhgLUenoaEFXPo0t5n92
         QI7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778913819; x=1779518619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        b=lte6xRJplRGmp/PSskcPRMRcmRHxp/3AN6A1XynLI6uXZlluhAn8u2h7mZQg7APZLK
         oAbu6jVFzk3P9a62b4PsoqoTNSJkE7FzjLFpOPv5Z+lsxgwuhtlVTrcbfv9MbnmVX5Py
         k/kzYjGMlhm8+gRGJfuzaDpFjgrS5WI83cFpH15WHsjn/iy/5C/Ve0iDz9Octg/QEDrA
         DhdqK6z9WrgQK213b5HL2plz3FNcI+orhuzLw1gTevyVgHFRj7CbGxDhPlje1LF0RZp7
         KU79gd97VCPt1LjtMq72jZt/AsJhd9asWIZ2PtbrgPLo+/sBoYkMDD8j7+KHYkro1zzO
         kN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778913819; x=1779518619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mxy2GpAHGinIR1PnXVMvug0ztGXvMspUp7huk1TMZs=;
        b=PgH9R0tuZcieC52BjOmM3OQLUgDmd3ViYHOCve93TyI6Y5I1Us3uaSoviGkHwhe8xb
         8b/bjpDFKrL9HUZk6KunvzbLsl0TOi3k19B2GzSBnPC5OITIY72keUgLbdqOvtM37LpL
         xiUwp7Mx01lupK0GW/kBvtJLOpcYPLj62ggdYfc8JbU20HtBrf84Fpsc2m+T5ylGc0Vb
         rH37V1S5yNyXbZV5sWJTMVTO3cjKg9s/ZoHoxslItoYeuGnpICLW7Jr/11iaY1aeXi/j
         rOfo8opSi5vrc+9C0YI8CB1OlzmAG/T8OU9RGQdoo0Y5hKf4eswKwJUfisuAX/jo9VVZ
         rfWg==
X-Forwarded-Encrypted: i=1; AFNElJ/aDNgvZkMYRliJa25be6rneMwmysWSn5i/tm++XK5WsumWSwi37hVnRPREEKjb2d06JKAg7Aghxsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIdJY2g1+8YxTh++rRWkTVHo8m80GlYKR+zYA/no3g0CMKs6k
	jWHfGH4rFupwBnl85/zTfA65cWtOsI3twU29uUuDSLlvGVsrNBLPnywEKLXM4qlzvjyaHTnh+di
	U+OwaqvqZfVoEuNzLctHlxNA2v9fXuWY=
X-Gm-Gg: Acq92OFvyTXlJewWFNN1FL+77DacwYnF9VaJ9yjMHPpcqjIdmrQUoBbj10+2T3gHmwg
	FCmpBbzZ1hhy0wKdRCvtivv+kp/YOK0AOR19TAhV+ur9pkn9gu2ZjsY9lB+tLm8cbkt78uHM23A
	uIQyE/D/YTcKKmi1xcXCs/FVgaeV8Xj80jUWyEj3GxBoT/vnlgHBFG4Xf6zeZDHjESk3I0GFtHM
	mfkMdWRdzCx+6BZTmuG7oCA6iI6tLp+jA3NLE84IoTKAQ5+ET/O8CvUc/3MDcHPe1VPYdXVoAeT
	CY/flGqROdfcD2My4A==
X-Received: by 2002:a54:4e88:0:b0:46c:e542:cc3e with SMTP id
 5614622812f47-482e55e65a9mr3386045b6e.6.1778913818672; Fri, 15 May 2026
 23:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com> <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
In-Reply-To: <20260511-wertverlust-vorbringen-070f016f3bd4@brauner>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Sat, 16 May 2026 08:43:00 +0200
X-Gm-Features: AVHnY4LulXSgBXmlt-XknhPT4FGQR5_lEWwUy9GN7jO6BYSv7kvOdT0vcpcWCyI
Message-ID: <CALXu0UdsurG-ayuYViqs0HXOfgyDw8gpNC+f=5y59cuuSPUbBA@mail.gmail.com>
Subject: Re: [PATCH v14 00/15] Exposing case folding behavior
To: Christian Brauner <brauner@kernel.org>, Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	yuezhang.mo@sony.com, almaz.alexandrovich@paragon-software.com, 
	slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
	pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
	hansg@kernel.org, senozhatsky@chromium.org, 
	"Darrick J. Wong" <djwong@kernel.org>, Roland Mainz <roland.mainz@nrubsig.org>, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A968555A82E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21654-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,nrubsig.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricblancher@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 at 16:11, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, 07 May 2026 04:52:53 -0400, Chuck Lever wrote:
> > Christian, let's lock this one in. I will post subsequent changes
> > as delta patches.
> >
> > Following on from:
> >
> > https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> >
> > [...]
>
> Applied to the vfs-7.2.exportfs branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.exportfs branch should appear in linux-next soon.

@Chuck Lever Thank you!

Does that mean the support for case-insensitive filesystems will work
with Linux 7.2?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur


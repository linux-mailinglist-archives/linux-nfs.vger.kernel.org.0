Return-Path: <linux-nfs+bounces-609-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BBC813ABC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Dec 2023 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654B61C20ADA
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Dec 2023 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F76978D;
	Thu, 14 Dec 2023 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbISaxUb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B869790
	for <linux-nfs@vger.kernel.org>; Thu, 14 Dec 2023 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ca02def690so108928731fa.3
        for <linux-nfs@vger.kernel.org>; Thu, 14 Dec 2023 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702582150; x=1703186950; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mQMVfirIwB5s1e6tfL6qzf0pPConlkHBcQMnQGMTGOc=;
        b=AbISaxUb4CXJIJt4ImCWWqlspvNtCFG64SCTqVL5A8ph6dzWFDdeWKJZamo7c7/C9U
         O/3DfStN1lcvIb6MCmtxlDMrA7wHRZnk52l937F49g+RQsixZmRwkSbLUuwHX6sQ6i9u
         8m29ndRCezp7KQgJAR8c8ySuQdKxVPgaam1RW+6L8X5BSjwonbvByPxCeJE4lNl86xn2
         pbIDz5OhcL6tvDx8WzkibUeacBg0onkCALDACC2kzgTBc2fceKejO00EqRQGnM2+BL3c
         Az1HOwn5Oh3KiAYNsBRZtFv5Mv7P7o2ONsKMYbcPbhDuju316maUFYhSK3LBsPRcXgcQ
         byEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582150; x=1703186950;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQMVfirIwB5s1e6tfL6qzf0pPConlkHBcQMnQGMTGOc=;
        b=Ufk+NbJnH8ZNHMMlRtR1Lihx8+mF0m9aDe5sEhyk/5okMhVgDRFj0kyowYa17hsGpA
         e//PpDL/iC6KhSt/Q2wpIx3E1OnzZcyp7TIs7wpD9yTnfi/hfZk33t+vsvI6O1u8ADBz
         3RwwC1VkicQ4dMcWa0Q5lBIIy5nlieQw/Dli69IoIQCjkAzI8d4ovy+YkplFdRGmqmPf
         7w9OTwRGuZosrMniIryDbp1PgDUy/wrfM0peKIR7SuhvEyqwjIDy9yYA8m9+ecYtUbb+
         +HxDg+RcYUAUPWknxOrpgrXZYEP4jJaJ+atJ9lvAulfCImiaT2aZzLIah93FU//cC1YH
         W1ZQ==
X-Gm-Message-State: AOJu0YyOghv5CegmJjFI6YArcT5pXvvizdZ2Ap7QJxDWOa1KU3lTnCxt
	dR9FTJ9iy+FRUKSCn13FQPSKY7shtB0bhkDYt3ue2nv6miA=
X-Google-Smtp-Source: AGHT+IES5BeT/1mG2LEESpZ58TWAQkrVvXyDGEyjRWWvWX6PsPJewj6jqOHYTZpxb4dCuZJiYQJHok7IF0LRCdOUmuk=
X-Received: by 2002:a05:651c:1a06:b0:2cb:2cae:2cc1 with SMTP id
 by6-20020a05651c1a0600b002cb2cae2cc1mr5697701ljb.3.1702582150070; Thu, 14 Dec
 2023 11:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeff Hunter <wjhunter3@gmail.com>
Date: Thu, 14 Dec 2023 14:28:58 -0500
Message-ID: <CAAcGnnaatt0HAMFosw2PjF7+5ERHRD5XBMg6+cz1WRNm0MOcFg@mail.gmail.com>
Subject: IMA over NFS
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My apologies if this isn't the correct forum for this . . .

Our customer desires to have Integrity Measurement Architecture (IMA)
values follow across NFS mounts.  The linux kernel now supports xattr,
but only for user.* attributes.  We've modified this to support
security.ima, but in doing so we've noticed that the xattr support in
NFS is very specific to user.* attributes.  Was this done for a
reason?  Is there a reason security.ima wasn't included?

Please advise . . .

Regards,
Jeff Hunter


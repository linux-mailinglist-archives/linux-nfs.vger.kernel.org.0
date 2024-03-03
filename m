Return-Path: <linux-nfs+bounces-2146-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225CB86F523
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 14:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A922850E6
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Mar 2024 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8355DDD2;
	Sun,  3 Mar 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrFsXShH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01110D51B
	for <linux-nfs@vger.kernel.org>; Sun,  3 Mar 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472712; cv=none; b=KLbG/0ddme5r/3px4fpTERqgFhssJsj0n0hSEvF9CkJOPG3XKH69M2lzyZsppA+MJfnz0EPCk9VH1v1ZnE9UDzbH/i68jXv/Wj45fnyVfKIx+d5/DFVxuG8Up1ylVgkqhKszy5K7E18eZ4IBZ68lChWTnx+W6Fnokv4qfBzMi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472712; c=relaxed/simple;
	bh=vSc5YFk4Zn/W8aXMt+TmfJub4ribcZRUWL5F996e7Vc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=egiUUfgj+9bN21E2VycaUq7DMDO8Mgmt3wryz/GspMLJ7ZD+8n+lWJ9k0dvRocNHYe02A8hE028j5PzT/IMWh9Hsop2yaC2PNjqK7TrGHMgYFGpehyNOhv6Vw6R3YwBI3iMsynBlSVd+1hUC1dychZcWdowf5RnvwWGKrjdDV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrFsXShH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d382a78c38so8753101fa.1
        for <linux-nfs@vger.kernel.org>; Sun, 03 Mar 2024 05:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709472709; x=1710077509; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vSc5YFk4Zn/W8aXMt+TmfJub4ribcZRUWL5F996e7Vc=;
        b=DrFsXShHc9ZzmTrEcj4RwYr/qIH/3v6w/3eF38nVkkA28eOMmlk8+/E9IQOEJWp7fH
         XwwiCXfI3yapY5tqFhhb1PkZSWWJ6nskm1hNvMgBJUgqNB45SBuKaYo3+YODMz6Bm+7S
         qTQToTjO9nGud8AghFDAAomwdCUPL7hBsOp6ekw34EBBxXs0+k36Dr/Y/YJSG6E77pg0
         7uvKligymzZsgHR7Cx4uTXmo5XpNCX7qmmAwBQxG+kUqgI+UeuY0zYytiWbogQBDlfma
         Ft0sv4e49U25bm0kCRLR0S10TR+souQcobs0RhzhmS1B5TkkzjXAi1KXdXKklgcVknzJ
         KssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709472709; x=1710077509;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSc5YFk4Zn/W8aXMt+TmfJub4ribcZRUWL5F996e7Vc=;
        b=VvCMTbjc2bBMlUBfgut1GQrYM26fntIXqlhI8tUf3tiSvO5QWFybuHkhHAA1U5dMze
         c2pshonaz0XsTtqaJR/hXME0HX8D056soxhrFE7FEcFnzFcUMknOe0gyw4i3fKaWhtqx
         FnA8gSS3zWRbavbJou0QBZy45jY83VXoe4NIGfp5IEcjs2+ocS65xuFbf6WLG66Vkohh
         8HYrrV/ifisH/O89iJLKa79zeXm/h13uQOE1LahWYECnjyncqNUlKFHZwP05CUG2P5wh
         J2gTVnReUNeMIgPrr/syFt8cVKruO7J0kwgRErEAI9fov1g43N/MNHmASkC3ZuFdCZEx
         24QQ==
X-Gm-Message-State: AOJu0Yy0sOvG1oIEDFktVUtmxqfhRHiJ+ISkT1YmhReS0ozPxfV9zbuA
	+Pw/+QfR5Lq2P5jruNPNKnz+TLykECS1kI/12X26lOtty5PQ5AgEUNJixZKhj5nYjZmLR+IyjVX
	vZUkR5UIwE9VBJ4ZIATTbVREHrKqBLJEi
X-Google-Smtp-Source: AGHT+IGilmgeH13/UwHWRn3e2Qhg62RJsvmsBKoDt0F/97Z2JXRavVfH3H4Yd+hSyG8iU/w7CDzRQz6SOqQ1GlOMDz8=
X-Received: by 2002:ac2:5387:0:b0:512:aad5:bd18 with SMTP id
 g7-20020ac25387000000b00512aad5bd18mr3996731lfh.17.1709472708706; Sun, 03 Mar
 2024 05:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Sun, 3 Mar 2024 14:31:37 +0100
Message-ID: <CANH4o6OxmxNXNhbZ6THwPVAtfkbkdYyQUMRGCX_=Ssb1gTUXJg@mail.gmail.com>
Subject: export(5) all_squash, only new files squashed, or all uid/gids?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

How does the export(5) option all_squash export option work? Does it
only squash the uid/gid of new files to nobody/nogroup, or will it
turn the uid/gids of all existing files in the exported tree to
nobody/nogroup?

Thanks,
Martin


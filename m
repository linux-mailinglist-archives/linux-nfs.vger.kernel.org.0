Return-Path: <linux-nfs+bounces-2025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF74859AA6
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 03:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F0E28115F
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Feb 2024 02:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759301FA3;
	Mon, 19 Feb 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTRNHVNN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F71C3E
	for <linux-nfs@vger.kernel.org>; Mon, 19 Feb 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308923; cv=none; b=VDsK2e7NI60pVW9zqgkjWLmcJxNdczwgSFbA9crzXNkQHPi4d/gZ0OSNvpzXNKBc0NOgq3IQ1Z6tNpZZ68kJl9cW1gAQRLfPHpUCZ5AoWu3FfMuDhAQWEXYwP9gQZ62sMulDvsXkQWdrsmo+sayJjsmEvBDFlOSh4K5PM3xpOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308923; c=relaxed/simple;
	bh=qE2LVQppFVHjCZ4B52Ey0fXUTTHvri8tsY6Wlpfa4sE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GKZp1qggdWbcdebuQOhruvuvIcc5RcdHzUu4u32C1cGn8Up97qa4ot7TElf1x8seIQOPtXbdJBNcrvCH6gkD7JguqQgmfF4l4n/YIV3X0/g7/cbxtnfn+qkCqfhi4fjSLcEwsXCvsJTxGqfOpJre4IyzoDu9FGRfb9Hs+hGVb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTRNHVNN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512ab55fde6so1208882e87.2
        for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708308919; x=1708913719; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XTtc8XVGVwemE3uIcJCnr9pvOZ89304GHth4O+3NZA=;
        b=gTRNHVNNjKth3Cll65invpmyentegn4DUvd/EKnJm/B0QSRw+bY5BVvxLWRRx2hZQ2
         EkiqP1FSvdjEYz5yOY3Lq/8H3Z5DLcnV5I+YoYdAAjN0En6Eck12uMIU3MwMtMuumezP
         T0rJ9xiOqE6Azs89eWvLW3Le9C96kajG5wTaZ68+2NEkAY3BUg1ZnhuajLKOJrgv+8sV
         Vm3TN+hlWrDYHyDbVpaV5nYDbBId77Emb2+KgmGpUWa1GWeNOkehebULkhKAjVKmvFBy
         D0J/hByx33sCxhiUt1OlYF1tycVF5TKGpc1hWaF82QztnQyYaz1uHK5BcttKqtO3hIZ0
         q7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708308919; x=1708913719;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XTtc8XVGVwemE3uIcJCnr9pvOZ89304GHth4O+3NZA=;
        b=GP0E9qwPIW0XPQIQ/AJWKDOx/uhzMNn4UyKkIK3JsbHcGPvSVM/Ecx/9DWlccK9SGl
         9yFJxDIco74Q68XntpNwqnpXQOz6VRdcYYkFAusL8G9DIrdRpCs8BgdBV455xa9pLria
         ugngSrAVzmW1/UP9OA/1e9RZeebk2SOdC6NkzB+VOdCfxQIHhq7gnVQ6KvjXb76Mh2xo
         T4Y/JWHD95OVIvRrnX9KdOq07B2JIVEpC/ZQjmmA4q+g+vJiUDwjn//mUxbWgktyRXAl
         YB9uG2GAx5xxylsCi3E7wLhov9p+o8KBl9JZ5z4vOtD4a5KcErojMOuHgHDHSK5DdqGJ
         8gZA==
X-Gm-Message-State: AOJu0YxkmUcZjue0FhD5+7C4HMIJ8DvR+KLA9qr3meXD/kgk0OmubiYh
	MKlQFbnupQM1P4Z2XcE001OjWrErfFXyFW7X+wuHI/v253pj4l1udAWYcUk801gyx6yne4vYHoU
	OLBJLIv95LHnaEh5rFrVy1DVmcIPFodG9sZR1Fg==
X-Google-Smtp-Source: AGHT+IEib4ZMuZDY+M/1DuPICditLbhFkHLKFTdc6DQ7vhUAkbk9oycs+9xW8teDj4ArT59zExrL4M43LRyuiIdce4w=
X-Received: by 2002:ac2:51aa:0:b0:512:9dc9:d9ae with SMTP id
 f10-20020ac251aa000000b005129dc9d9aemr3397051lfk.64.1708308919024; Sun, 18
 Feb 2024 18:15:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Mon, 19 Feb 2024 03:14:52 +0100
Message-ID: <CAAvCNcACKjaSnnWj71y8GkHN25G=vmDAgif83eaP+d_XF6pBpg@mail.gmail.com>
Subject: Understanding NFSv4 client attribute caching
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

I just try to understand NFSv4 client-side attribute caching, if I do
a nfs4client_setattr(), which attribute values can be updated in the
clients cache, and which should be invalidated, and then reloaded from
the server?

For example if I do a nfs4client_setattr(FATTR4_WORD1_OWNER, "myusr1@mydom"):

Can I cache  "myusr1@mydom" as the new user on the client side on
success, or should I invalidate the cache, because maybe the idmapd on
the server changed the user name, or exports all_squash option
squashed the user name to nobody?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd


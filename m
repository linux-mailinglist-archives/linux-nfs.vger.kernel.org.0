Return-Path: <linux-nfs+bounces-12066-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74FDACC271
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 10:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40799188DB37
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762EC4F5E0;
	Tue,  3 Jun 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDGyqHs3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03649659
	for <linux-nfs@vger.kernel.org>; Tue,  3 Jun 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748940664; cv=none; b=GMKfM4/9aLQu48lD/n8zvf0z+nR/Ql6nD59xsg0pxGx0Ho0uJSgfN2RvlA9l+/444EbTb/q08ruElxr6CGF6NmBffwBOY7BU/dCDYhiAv9pQo3DyYjfVM19gzN0YjGwWUdPHeKyv1LJ4Ug9MlF9bIMOmuL90vj9XKgP/iBZK7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748940664; c=relaxed/simple;
	bh=JyfxNziPTThoLKKBL+fNNJu7axKq7McYISLTnyD4gTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=H87beeWaDqUMKWFE2HKkwWRSSdFa3h12VdIvPZ0ZenskR0A0alHAKQ5UxQXq097647sJKiKj5AMaKMhxdmfwp2TireElmPiP8FuoFt5GS7j40zvMvK3Q+e40FT8BVWEKS+kWwgNkFWFK1mEGdeF/klXLV5jKT65xPz/z6hAwUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDGyqHs3; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2e8f394bb75so3061355fac.3
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jun 2025 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748940661; x=1749545461; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Xq8p3BW2w5f33zifnkVRw0RRjEAlsO/SCzImKDemC0=;
        b=PDGyqHs3qYuiBpHBUxJhx40X6Rs5CHM8sU/kejbuOXjBco5gqWUTKPEXlsrRztR5pP
         VhLGz9Dd40M/Vb2sAucuHp1xJ/e5NvTMf/RmA0+2ISx1GfdrGvMgqAAOPUUrcNB2emeq
         srZdGqAdhVfgU3AoxVuUWOdJ7ZhZO1YMXVCltQtaq9CJckeAs4lIHB+roUgM/8oVJ3Kb
         YOeNDYW/t9/n0fhw5SXArgDELQ5mztzFbH+uPGzeWWnlY6cpmLK2rgzH+iqM5ZLw6LT6
         P2JyC9oOC69SrTBc6n3z+EUQFT0l+LKbyPW69dVlE5k2pKD8C8XDR31COPVgqxYF3Ndi
         cxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748940661; x=1749545461;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Xq8p3BW2w5f33zifnkVRw0RRjEAlsO/SCzImKDemC0=;
        b=qbBEFKVrxQl6Cki8F7zmBk+J7lkp1v1cl7P29iyqddV+edVmzOsN0T4JKQaN/f6rU7
         etQcyUtNGdvDYpYdtexoY36vVbu8ywd7SjJdeKVi+s1gLxweDfr7xpqbBRG6oWMs0fBu
         Kun/Y9kC8kUF6EGtxbec3Vhj0kRggIS1hWpmvd4uUsV3B7bF1bMHXO0UvwoIreiDfqvT
         cx2/GxlLv/TXZPyIALnvOiuXW3nUjqIZvW8a8bCLDuolTP6cUn3vDXXOjw5ebDBfkBXT
         jsN7U2VftkfmiyxXGOcduoMGG9ypGOh6GmzNzdtRgWVvmoJZ+ObH7zz9xDpELEYeRO9p
         tLxQ==
X-Gm-Message-State: AOJu0Yz9++w9q07pdrUPzGFXpavxTcs4r36NXObMbEitZrpxPKWNkch3
	sPo4W/TAdnScrSnHtKFZfivT+weBYDRjf6an05qD9MnBtqr8Tgi3Ar4TTQjGNKnpNQD/VtASvp4
	RgKCYLuFpV+lpVPkZolRZqb84QToDadOcf/ZDZiQ=
X-Gm-Gg: ASbGncvZrIMyzW0SjXQXt9XYCttzh0K69EboUGZQ72PV42+X39VyHprqhN7X9xIwdoe
	OokKFrwjuAfyUdm3K8Fv/v4GPLzs4Pq2Jhp0kDiWhl5JCHiGbsYu+3zGoI+nrBNqsTGCng2/roq
	MTa/RqnfCQPhbGdnLTnUqQ+tY8UAsxImoAPw==
X-Google-Smtp-Source: AGHT+IEXjxdpi7um3NdaGdaRdYFQy8qB6lVJTPUfT0GMreC3nwQ2uRa4QVr1bnbdou/MhrKFZx//0AU+xVtnQ7dEscM=
X-Received: by 2002:a05:6870:e40b:b0:2bc:883f:3dc8 with SMTP id
 586e51a60fabf-2e948d42d30mr7443986fac.34.1748940661562; Tue, 03 Jun 2025
 01:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: gaurav gangalwar <gaurav.gangalwar@gmail.com>
Date: Tue, 3 Jun 2025 14:20:49 +0530
X-Gm-Features: AX0GCFuV7Ugyfws5BG0V4mQruo9SY_pYG4NkRCFSH68tJ2Gdsq4v9_EC52my93I
Message-ID: <CAJiE4Om31BQoqQko3bh1cUG7SgUtM7jAd6p7pQvP23E8c97jDw@mail.gmail.com>
Subject: RDMA and TCP mount
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Chuck Lever III <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Hi,
While doing some NFSoRDMA validation using rocky8.10  as NFS client
with kernel version 4.18.0-553.47.1.el8_10.x86_64
We are facing some issues.
We mounted NFS with RDMA and NFS vers=4.0 from server ip y on client ip x.
Mounted NFS with TCP and VFS vers=4.0 from the same server ip y on client ip x.
We face some intermittent issues like touch failing on mount point.

Strace shows this failure

write(2, "touch: ", 7touch: )                  = 7
write(2, "setting times of 'ggfile5'", 26setting times of 'ggfile5') = 26
write(2, ": No such file or directory", 27: No such file or directory) = 27
write(2, "\n", 1
)                       = 1

From client syslog, there is nothing after lookup failure

[Thu May 29 06:01:22 2025] NFS: lookup(/ggfile5)
[Thu May 29 06:01:22 2025] NFS call  lookup /ggfile5
[Thu May 29 06:01:22 2025] --> nfs4_alloc_slot used_slots=0000
highest_used=4294967295 max_slots=1024
[Thu May 29 06:01:22 2025] <-- nfs4_alloc_slot used_slots=0001
highest_used=0 slotid=0
[Thu May 29 06:01:23 2025] nfs4_free_slot: slotid 0
highest_used_slotid 4294967295
[Thu May 29 06:01:23 2025] NFS reply lookup: -2
[Thu May 29 06:01:23 2025] NFS: dentry_delete(/ggfile5, 80c)
[Thu May 29 06:01:26 2025] NFS: flush(/run.log)
[Thu May 29 06:01:26 2025] NFS: flush(/run.log)
[Thu May 29 06:01:26 2025] NFS: flush(/run.log)



When we try TCP mount with NFS4.1/4.2 with the same combination, it works fine.

Is there any known issue with NFSv4.0 when we mount both TCP and RDMA
from the same server ip on the same client?

Regards,
Gaurav Gangalwar


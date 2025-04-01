Return-Path: <linux-nfs+bounces-10976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2252A77E33
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E183ADA19
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E42054E3;
	Tue,  1 Apr 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbkg4//1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D11E47B3
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519008; cv=none; b=oYgCicTpRqidZK/EyOGz54zdw34KMsypfeoY6wqmQYydHArEiLHaT3FaQB1X97sOaBKzgGLwPVFILH1bA0CUYvsGIiZWK7R7GDY7uRFSVfQe9q2kPKOX7M8udoJeQamYtBt7zHGqmBNiwBfU0QeSSMCI0Q3WoiBL+umEdd+YAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519008; c=relaxed/simple;
	bh=W62jtRlVslrX5x+mGDWAaw8lOHQPBvZQ0s14+XvMXBw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EAZ0LxUFBHtnDgMl7OeD7ehnBJ6Sj4Z5efCeGELOcsYJ6gqkRLOJqL4eIQj00MQAwvyfU7o1AHB/8lFPE7Fua1oS23a8ugiK+qJNURjkX938B1eb4pUa00FH9O5Dch3tyuK4F/hE7jUYVNVIgtrqDBcw+3nHEU1jXw38odLIOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbkg4//1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so4860977276.3
        for <linux-nfs@vger.kernel.org>; Tue, 01 Apr 2025 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743519005; x=1744123805; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhE0zR6QqDUHio64ZtqkrCx1HFmTzbjGWRcMBkTHsPQ=;
        b=gbkg4//1rY4YKRj4GzH2O4mnYjGGmTXxR/8bW9mK9tPlEIcqRkcfJeZL7lE6eB6WbY
         3jpwmFeWuNflhE/islMF4t1hgDLAUJ5x+uJWWa3MO6DOWRFz6M/tJu1xP3m57cgjwhoe
         9JRMv1RBN/SDCAJ1ft9R1/h6ZDxl1plBLQca6N0ii/iILLZaUed3XMT7iOkrEHNXR3Y8
         ifj8Cjjdu7IvAoML1JWfrESkzD9BbnmKD8Orh+3dAMiCalh0ru8ZGyF+BX/qhYuLs0dE
         C5sGt5kZaLDnmsStowAw4MYFNUXrT6s+cDFNmjLPfIoRuWhVHwJZDk+/8ZCwXvEKff4l
         r3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519005; x=1744123805;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhE0zR6QqDUHio64ZtqkrCx1HFmTzbjGWRcMBkTHsPQ=;
        b=XlQ0eakFPnvYFQqMOa3u1K4Wkfbt0nK9OKB/AdPz8nUTl9vUk4m4VwRkMkez8NOcj8
         eZUJaswpyml3mesxwyVEI4PNR8u7sidpA49/p7vRB44beZrgrmbopSyyuEjH+zmUxrOH
         PNbndKwMYWGNFfTixlPl6uM6XGT9c6gJ8drKXVRxExDIFLkAGS03XzcEmXLXgARforn4
         R2PbhWf15SRjOva07Gly+on7l3witdzmrb0/21bzHOr+B7+yk5un4i4/CbWs3RR5FcF5
         cXHXo4zN+eZKhzxLlTWpSLJkzr40OE7aCN6K+NMHBOpw97g1fecqU8NeGoflqp32C2cX
         +NCw==
X-Gm-Message-State: AOJu0YylPm0oZMUnqJXZxwTtHzpOfDPE1H9JkNhBtpmyzV/hLMVRikqN
	+e9EtJi5kLWY3JzPIIraGuJzRoOnGIkVUhxjLvsy+eiiYSHUntdaoXJpRYFORx/OPEui3y1llxI
	XurGfhthc3IUXnQBkOozWjEd2PFOoNlEB
X-Gm-Gg: ASbGncvKyuBmffVwONv1lQk2wCedSRCp8qxOviXmzi8R1I4vZmrhi3i/TWjVQjbiXJn
	PWQUMqofUaxZApdF9DAYUg8CMJCp8oMoMiJL+Q3NBh2n0fTfHA2IDr9WwMpdz1c2yEGDZnWHeRi
	UykDk4GJ6RuYxNKpkhsMPQ3B4OsqUa
X-Google-Smtp-Source: AGHT+IHeNg6w0lJEpQSUf5KlWNaU+W0g6y11vP/BlYIpi28a4ZAl39vXDGBIbDoEhC2JQZk9zwXS0nHEJHe90G3varU=
X-Received: by 2002:a05:6902:e0d:b0:e6d:e3f8:5167 with SMTP id
 3f1490d57ef6-e6de3f8647emr2029521276.39.1743519005307; Tue, 01 Apr 2025
 07:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: mvogt1@gmail.com
From: Martin Vogt <mvogt1@gmail.com>
Date: Tue, 1 Apr 2025 16:49:54 +0200
X-Gm-Features: AQ5f1Jqx4IyxwUWYiyJlrmPsWiXtL3oL1Wj1WOI8WUnLJpCy8Ywhiv2EmFJpeys
Message-ID: <CAOE8yMCHGQ682xnzVq4DuJ_-AVfJ=jYvgpaTThvXK-XDs2TGKQ@mail.gmail.com>
Subject: vers=4.1 in nfsmount.conf.d with Server
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


I have a netapp NFS server, from which I need to mount the NFS export
with the client option:
vers=4.1.

The reason is, that the server exports 4.2, but this has some issue
with SSC therefore we need  to downgrade the client, which uses
userspace copy in 4.1

For example, the fs5 export should be mounted like this:

fs5.domain.de:/vol/fs5_m_scratch on /m/scratch/space type nfs4
(rw,nosuid,nodev,relatime,vers=4.1,rsize=65536,wsize=65536,..)

My idea was to use ("man nfsmount.conf")

[root@v110it01 nfsmount.conf.d]# pwd
/etc/nfsmount.conf.d
[root@v110it01 nfsmount.conf.d]# cat netapp.conf


[ NFSMount_Global_Options ]
Defaultvers=4.2

[ Server "fs5.domain.de" ]
rsize=32768
vers=4.1

[ Server "fs6.domain.de" ]
vers=4.1


This does not work, it uses vers=4.2.
The only thing which seems to work reliably is to use the
NFSMount_Global_Options.
If it works, I can reverse the entries and then it does not work anymore.
This is a bit strange, but its harder to reproduce a working mount,
than a non working.

I monitor the mount with and then edit the file in another terminal

while true ; do

   mount fs5.domain.de:/vol/fs5_m_scratch /mnt/
   mount | grep /mnt
   sleep 4
   umount /mnt
   sleep 1
done

If I add rsize, for fs5 this is used, but not the vers=4.1.
If I change the name from fs6 to fs5 and have two fs5 entries it works too,
as soon I change it back to fs6 the mount is vers=4.2.

This is verified for :

- nfs-utils-2.5.4-27.el9.x86_64 (el9)
- bookworm (debian)

best regards,

Martin


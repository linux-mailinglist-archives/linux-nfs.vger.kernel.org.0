Return-Path: <linux-nfs+bounces-6661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D88986C98
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 08:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EC8280FB7
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328CD44C86;
	Thu, 26 Sep 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/0Sc5/l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC5F178CDF
	for <linux-nfs@vger.kernel.org>; Thu, 26 Sep 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332541; cv=none; b=Jecv1YoCxucg965ueJbQv/mdmrH9T7dgSEz9EZfQMg044n4eoXOtG4BE+rEBn0XEacUZIhwtJiFcn6TRXZpm09ky7OkKXMD4VqtbxAv0nIe6BWS7D9OWrxRM55uH+5kjCBhArTFNVnz+Ofnk2gZ0VPS9SJkT2FHlXz71pSSeZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332541; c=relaxed/simple;
	bh=IXq2IW0fqdNVTIXqel4Udf1sjh/oRL8g9+RA8AzoBAM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DAIQKqYZ23BxlRwngR2fpO80AwFX5m6WtMze9nvkR5pZijf39jZWXvHrFISYPlomzr6+mCNVKfHjlbRdKiQTYJtrXiZOUzSscOBnS07dRregvxJVGB+vbeLlTbvb5pcU+qtAOLKPeK0DyOr2KSxY6cmGO0WCLNIjhDbdZLISWas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/0Sc5/l; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2326896cbso2738717b3.3
        for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727332538; x=1727937338; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LF19cPIZP41eJLcRVe5Hhg/AULNMVQ6WXx/B/CiOZgc=;
        b=J/0Sc5/lh6/7T88gOkkpucMeU44G08ecWm1f997a2BQg+CTHRnZFd/0xAK5Z094zbJ
         7QHiMmfJ0xO8jSPkjmk+RhpC/L9l2fds6hTBkb73ZzeEfg6TMknCBF7dpc+CxB3cD8DF
         clJ2vbeWP9x2YTch7SkeIKBXwL5NOqx5U41JMpuEfl+XEr+ECpZ5qnlZ6TY4ttpHEhXn
         xDfNklgz2/e2GqG2tzy3ArP4OLqbbPbSwwFht1zR9aO7wNaHCQyhUT6Inv3zUYVJp1Nt
         CGBkm7c9fmGZOphRoIdZ/uUL9+5VDFYpMEv8kHmEickc0rn0Ba7d8w7B2BqjYtN5RrBv
         FmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727332538; x=1727937338;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LF19cPIZP41eJLcRVe5Hhg/AULNMVQ6WXx/B/CiOZgc=;
        b=d1wUaH6l5dv02BEMzhnVDko1+8/4Yv0yNcmGf5IkTgyeP88nCR38GmPgK53EwI4GZY
         kZJ83qm6B1Zwf83VIuge0ACCijQadB4g9Ymwm8/z0IwNkUY4Zzh/yCNAQMBaqWXt7+e7
         3zYzHzSBTAxC37EpHnQ8LKtzmW4ZgY6QNO5aDKpPcfyJ7mP2ALBW/YugymdsIjYIPHo0
         TSNkVr+sW89YmNHqHT9u3J8VSEQLWPGLHO/zFA6ifYIuuudCENTWE9RoAd43hLBCPhWg
         OeJzcJS4gQTySfeRoC9veeMeBkTpQ8OJzhBJF9AL3SCEii3UMOlFKjyQLPQsht/zf8cX
         LhWg==
X-Gm-Message-State: AOJu0YzedM81IYNFfzwuJSMkTuH2WNTg6t3VwUu2ydf/nQjOtCN+qX+T
	XABSDHV+tPWKVbLar90TM+b3s08YFeFJiNLZ1BDLcj6UsJdYSgye1R3mR4n5bP6QZutlRUsgM58
	3bIJZqx6usk8I/8kweEc3C5edwF+Kjz1B
X-Google-Smtp-Source: AGHT+IHNfiz9byIhNt6RN/i7Tz75DoiyUbHUTS7w9naVsRAOwH+6RtHH5KpCKfTXhPONQJNqBkNn+pbqBT6zla3HKHk=
X-Received: by 2002:a05:690c:f05:b0:6e2:1545:730 with SMTP id
 00721157ae682-6e21d6e1c0cmr47515887b3.2.1727332537872; Wed, 25 Sep 2024
 23:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Herman Shmulyan <danielhsh@gmail.com>
Date: Thu, 26 Sep 2024 09:35:27 +0300
Message-ID: <CAF+Si_qgqccM-BNKhya=_1G0dOb0YZc-94+OLWD3Z1D9kBJ8rQ@mail.gmail.com>
Subject: 2 bugs in blkmap service
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello and Good day
My name is Daniel, I was experimenting with pNFS block layout, and
found 2 bugs  in blkmap utility.
The source is here: https://git.linux-nfs.org/?p=steved/nfs-utils.git;

I am not related to linux development community, so I am sending the
email directly, hopefully it reaches the right people

Bug1:
Some block devices attach not directly under /dev/ but under sub dir
like /dev/nvmesh/
Example: /dev/nvmesh/disk00
under /proc/partitions: this disk appears as nvmesh/disk00, but under
/sys/block it appears as nvmesh!disk00. See Kernel function
kobject_set_name_vargs().
blkmapd does not call it and fails to detect block devices under
subdir of /dev/ (because string matching of / and ! fails).
Result: pNFS cannot detect and do IO to disks which with 'lsblk'
appear under subdir.

Bug2:
Due to support for old kernels blockmapd incorrectly detects the minor
version of a block device. It uses only 8 smallest bits for the minor
version.
This actually caused data corruption.
I have two block devices (major:minor) of 252:257 and 252:1,
The pNFS signature is found by blkmapd on disk 252:257 but pnfs IO
actually goes to disk 252:1

This is disastrous as some block device drivers deliberately reserve
lower bits for partitions of disks, Which causes this issue to be
critical.
one vendor actually used 8 lowest bits to support 256 partitions,
which means that his virtual disks are attached as (major:minor):
252:0
252:256
252:512 ...

And pNFS IO always goes to only to the first disk

Thanks

I am not familiar with the procedure of opening a bug report to the
kernel community, and I am very sorry if my direct Email is rude
etiquette.
I had the best intentions.

Daniel Herman-Shmulyan


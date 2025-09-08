Return-Path: <linux-nfs+bounces-14128-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0975B4973E
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 19:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7EF1C25693
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Sep 2025 17:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90D1E1DE7;
	Mon,  8 Sep 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b0JSJu2O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA91F0E58
	for <linux-nfs@vger.kernel.org>; Mon,  8 Sep 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352922; cv=none; b=NqJ+fZ/kAuhSr6//tgKUU62HXa7H1seWAiRfMlsDjICwupTlY7tf47mGqi5q+aB3F5qIOcXXupmpTdqQZjd1leMXfoY3gKO4hNltQPRN4SF7VVwsACdGERSRRlp347Ph6p1YYm071ur2ATxZLk0Ct1gGDi22ibhm7uhEH8bs/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352922; c=relaxed/simple;
	bh=w/y8I9/ofWPg5Qm/9RHUoSVOpn2DIJQbZhCtZl/SiWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJ1jsUHAL2n7fNe32tfGtcJtdqzXp4aH9vuqbiEUmDX2meS9iynQHfezO5FjbLL2+aHn9K6bGsvV4KUwB5iwfnensOxM31sq8mQPyS/faCVHv5uCQFcR01KmLnFX2tj46uA0gcDbyQXreh7Pd++wK99eJVF8MCZCifngckGm73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b0JSJu2O; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6263d0e4b94so4395588a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 08 Sep 2025 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757352919; x=1757957719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2TrN6my2ZYVliufyzoTZtYl+pyBDOUBleWjncixMA0=;
        b=b0JSJu2OnqJdKapO2vJxIe3MLnEBhuftfVXEpw5s3h+75omUNIAoPzwsQNKZgKmwbf
         Bb+WrOYikFl/eNtqNzD8fvBPQIFAVzxmMMpidlieFUHolu0btGmPdfYie1Kj1eZdVfou
         nf54Si4U6osffozgqDYg71HcxOTl5W3rtL/VyxVlHsErUCprZlCOi4Ir37TrAsDEe+2Z
         3cdMtO432EQi64wFlp4BHNhS37gXZuXbjnHBjQEhutv2MeyVo5BkPOxABOmnNhZHKdQC
         u76cSsUFieslqKq4+FdsWrlCbUBuim8ebIpIFFYKZyzm7fVPXkrA6EYcC1SSXYW33XJ3
         Om/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352919; x=1757957719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2TrN6my2ZYVliufyzoTZtYl+pyBDOUBleWjncixMA0=;
        b=WgKVlXx5+pkmyjUL42Ge4u0RhpjPLLvHSrQyPOcmZ9dbMxQWeKG3sfRdSK7eAWhvYi
         B7zDr3+0AYWq76Uk1WwRE/HP6SH/kjTKIt52I6kvbpQQRA6+uq+0RU3+lt7kZuTKVFDC
         VeWJDrSW0kAu5NB8/FPN033C2OfOMXmC52rICD1CrSDYHWfyaWk+xQ4sMacQq0w3g1mK
         hiMRHTEacdfoZm4N3q86VK+Qk3fLtcUYZU2Qqy+WPgPiZKr6KwU7AmhgQSppZ/f8T6Ke
         QPEOesy5RaGodoaGr4C8e9Sb7IhSUBrb3mYgyd1PfHo8zqa99cPMGx3bM5cxeiSfIUUF
         fXeg==
X-Forwarded-Encrypted: i=1; AJvYcCVPVfxb94H3/ZIaZzggNyVX/P/4+0rCv2tUDBfZTGUH+UNb+LIDHsgvw8Ri2IyVD/JhAqllKtItWjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9yLa7ECIHrl/JV1NhaSHOkhadK9TqbAGfWYUsvUTDoedlJqme
	tSlqF4RJi/0Mut8GQEvzGjTtobNipgjZ+TH3BruAXX4SecREWdXykbN37MWiHT0dAV0=
X-Gm-Gg: ASbGncvfnd54j4/ivFmmO23eRY5ASIXZs7lr4VkpjuU7nJQArb0CS2CTWXnXo+zl9KH
	5sbTUyweGJiEgteXNO12jiHkZyCgHkh3rf1SrFsNLAaseDmPGrY/zbqKZWUfFNwPO+ip3cUbCm0
	MLVLNpfjHrUFaoG96AhHxVc7RLbwiCP18SSYBGxSojrerL9ksmQFdO1wO7lBoVSEmaEu5uaCBHz
	T5JQ/QGKWjaaUYH320nSD8QfWdwk/0mzda7Wy9oAqEcvr7DkdF+ii8QB4UBCnns/6DYqcvEsWTM
	NXKurBcohJnX7TudH8zxQ6t6pmB132k0HqEMi5+UjyglHUZP1GITGuN2x/2e+E/xdBS6xhAkKwC
	CK6IfmiC5C3M1G0kXEj5EicPZITpbdrz9eDvagg==
X-Google-Smtp-Source: AGHT+IEJgaP4ERdA3Z80Zns0frIwy6B6xKWg1SeMKjzcSVo4fB8Tz82moM6TeUbStyJJLSwpQeQCyA==
X-Received: by 2002:a05:6402:5214:b0:628:8ee8:5807 with SMTP id 4fb4d7f45d1cf-6288ee85c62mr4133501a12.35.1757352918737;
        Mon, 08 Sep 2025 10:35:18 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm23670941a12.2.2025.09.08.10.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 10:35:18 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/1]  NFSv4/flexfiles: Fix layout merge mirror check.
Date: Mon,  8 Sep 2025 17:35:15 +0000
Message-Id: <20250908173516.1178411-1-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I believe this diff solves a number of EAGAIN, disconnect and livelock
issues in cases where the layout needs to be refreshed due to the
mirror state changing. ff_lseg_match_mirrors will always return true
which means we aggressively merge lsegs in a variety of cases.

The problematic interaction happens in pnfs_generic_layout_insert_lseg:

if (do_merge(lseg, lp)) {
    mark_lseg_invalid(lp, free_me);
    continue;
}

My reading of this code is if we decide that the new lseg that we are
inserting is mergeable with the existing lseg, we mutate the state of
the lseg that we are inserting and then we mark the existing cached
lseg invalid.

In the stress test results that I've reviewed, marking the lseg
invalid causes a large number of undesirable side effects. This is
because there can be large number of parallel syscalls that currently
hold a reference to that lseg.

Marking the lseg invalid generally causes the syscall to return EAGAIN
when it wakes up. I also see code paths where we RESET_TO_PNFS. I also
see lots of disconnects which I believe are coming from
ff_layout_cancel_io. One way I believe we can make it to that path is
if parallel IO calls pnfs_update_layout in the race between when we
mark_lseg_invalid after we've decided to merge but before we actually
insert it.

I think this code path could be further improved by inventing another
way of marking merged layouts. I don't think they need to be
invalidated, perhaps a less destructive state like "stale" could be
invented that lets existing IO finish before cleaning up the lseg.


Jonathan Curley (1):
  NFSv4/flexfiles: Fix layout merge mirror check.

 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1



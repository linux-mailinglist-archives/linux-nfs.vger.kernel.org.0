Return-Path: <linux-nfs+bounces-13888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC564B34E02
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 23:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896201625A8
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 21:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF63277C8D;
	Mon, 25 Aug 2025 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HHz1LM9C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D691991D2
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157255; cv=none; b=U7LMaZhwsOsAgovnDIuw3WgwFuG0iKd2ogeWN2CbilCAoQiraVfcmPkvN26EShW0cb/ChMxPbt+xSXYITjw00+98cvL1HnllHU/4ZszmLd47gK/PAIdp6Hj6walUC/DS8xwfC3dqEI7qQ/n9TWLL9WRmUxEuMnAfkva+AiGFGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157255; c=relaxed/simple;
	bh=J8f90DzPyfqSwSIrFrsIeFRq/1KP3faDzWZ2hhoG9DI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKnRXJmQhi9WZ0bqHkizr2cLnI2TGugy+wy4YBGYacfM8Hb/UwAuaIEAlV5SwKuFn604ckpSUBtwULxcM7AkvfdC/f56E7XUb5mlmp8yWj0Dxl/R7x6QG2840t+zsddFJOYl0J0T63lIA9tdAI+aw+7hLRhBcVGzDF6oxs9f0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HHz1LM9C; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61c91956560so186361a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756157252; x=1756762052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+j2O6he1PjD7I9YmDKkZ11v3wqnwwyek886COCDfzc=;
        b=HHz1LM9CfT2tlyUOgsjUnvJgWM267SO+KEHH9hE6CB3TNhE7+TahoPf9LVbcCOp3qp
         nyVWEpGdypw1tRO1+R2GepVO9zIhr4fykGOLrkApPG+g3izISNZHu4ZopDP/3d/Wrd46
         pGPWvC9macjEVUbFq27rLUHthniRd82iy5baO7mcnnedY4GkWB5haJnYT0xmNDIyjmoM
         mXdkIG6km+LtYyGfWbn8NL+2J0Wnc7ZjpihBfbdUlEf+7+tQv0FAypF2fUx1qxKx+uf5
         CRaZjdzlrb+4fZl/+FTe0k+I9u/Fd/FNYpbdPO5EMGlU29UiWUtquOjZ3qNtW+b8juOt
         CeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756157252; x=1756762052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+j2O6he1PjD7I9YmDKkZ11v3wqnwwyek886COCDfzc=;
        b=nsFZKEZmq2KvEZ3qlGfRb8GV5QAdPs8y1OdbphMwcntWfBJA/2bgBWh3ieboDjll9G
         EgsGQ959a4XIZq1fJB5GGsMqGOyh8aRt9praii/WtkU+j/jxa/aKlKdcqAn3AXotpiRm
         SMCQnBAfhopezjePIwN1Chducj/j3FI0/SY/J/HFNPXMca3iyTwyQthoQwURsmxI86ih
         Is1bk2RQniQioNA8CNkHuDLtNyYav+vBMqtd3s/L0cdJ2YQEba7VPCZFyrfAkgNu08Oj
         JhWpVWbLldzQp2PFSJRFpxMZ2DJT4jzSH3kn1HAGP0hGxB3TiGDDzEc1rGz2m8U68giq
         6oPA==
X-Forwarded-Encrypted: i=1; AJvYcCW8snjM4T8WrdP5wv3dZurN0ZLWs/7T4lSIXCdk2SY6NflgM1QRCnd8sDd/zDAnhkCGe5gq+ZXJF4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDJcrPiano2xkghQ7rDBfWiFSYQcKSytbk7+xO1+WcBkXqOSU
	rrC8gxNOtrJAnq2UjWfr8+ESxEcTn0ZBBAFWQ4Ga7ZHdAOyJHA6IgqL5tcbly5qmLrk=
X-Gm-Gg: ASbGncvoroF4X0bmwSJqQ7KytP6ad6n1TR5v1lxczkxrhp/Fb9YKKDVTGgtQSt6xguD
	1P5WvmKXDy/Fao65tZcxccI6wXJx9VyCrRNfXtimHHcUHEY4sGxCdJmU9dKuS0UppG7fOO3N6hh
	rvRN7zfcPLDM4qTKp5i59K0iUQ6vTFeleY6LjXlLJctNZJVrVIn83/6+mSuTuwB8JLAtzlqAX/R
	nLl4HCrLiDSq+dWSQ+RVfjtv9RkZNN3NWelO3mBI/aAKr0AdLoSg+E4us+YHi/JZFsDbSSOLpRj
	lBJDh6IDaCmULuxtQLZcuLjvM8nKihbLOGskZZLOrJ9HG23soWDwipMpOlIQbViOnOViZjJLbTR
	03z/kqyM+R8O+M36RapT550I=
X-Google-Smtp-Source: AGHT+IEHj6IrKgBSQVpqLyg2IfBX9O25g8UNpR8mWQ6tuuOEW6eToE9sRe6YPCBhdH+fVqnDz8wjTw==
X-Received: by 2002:a05:6402:84f:b0:618:38d6:7819 with SMTP id 4fb4d7f45d1cf-61c1b6f2a1fmr11234319a12.21.1756157251722;
        Mon, 25 Aug 2025 14:27:31 -0700 (PDT)
Received: from localhost ([208.88.158.128])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61c3119f876sm5598950a12.12.2025.08.25.14.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:27:31 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH v1 0/9] NFSv4/flexfiles: Add support for striped layouts
Date: Mon, 25 Aug 2025 21:27:20 +0000
Message-Id: <20250825212729.4833-1-jcurley@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for striped layouts:

The first 2 patches are simple preparation changes. There should be
no logical impact to the code.

The 3rd patch refactors the nfs4_ff_layout_mirror struct to have an
array of a new nfs4_ff_layout_ds_stripe type. The
nfs4_ff_layout_ds_stripe has all the contents of ff_data_server4 per
the flexfile rfc. I called it ds_stripe because ds was already taken
by the deviceid side of the code.

The patches 4-8 update various paths to be dss_id aware. Most of this
consists of either adding a new parameter to the function or adding a
loop. Depending on which is appropriate.

The final patch 9 updates the layout creation path to populate the
array and turns the feature on.

v1:
 - Fixes function parameter 'dss_id' not described in 'nfs4_ff_layout_prepare_ds'

Jonathan Curley (9):
  NFSv4/flexfiles: Remove cred local variable dependency
  NFSv4/flexfiles: Use ds_commit_idx when marking a write commit
  NFSv4/flexfiles: Add data structure support for striped layouts
  NFSv4/flexfiles: Update low level helper functions to be DS stripe
    aware.
  NFSv4/flexfiles: Read path updates for striped layouts
  NFSv4/flexfiles: Commit path updates for striped layouts
  NFSv4/flexfiles: Write path updates for striped layouts
  NFSv4/flexfiles: Update layout stats & error paths for striped layouts
  NFSv4/flexfiles: Add support for striped layouts

 fs/nfs/flexfilelayout/flexfilelayout.c    | 774 +++++++++++++++-------
 fs/nfs/flexfilelayout/flexfilelayout.h    |  64 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 111 ++--
 fs/nfs/write.c                            |   2 +-
 4 files changed, 637 insertions(+), 314 deletions(-)

-- 
2.34.1



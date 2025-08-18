Return-Path: <linux-nfs+bounces-13753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1632B2B3EC
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 00:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F09B1B22CBC
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA61E5205;
	Mon, 18 Aug 2025 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZarYClGO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77BE1E25F2
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554884; cv=none; b=uLcoEtoWE3gfiqSaOMF3nuMHev0xutjnr3uzzbja9PWO0VvigsICIMfYot6WtHDni0gysx1ilvrFrCl46ZkpBnE8WAPE/bUHOj1wz3wWDotoyqWbD1DNjPcj4D29DWJtcovFP4J+G4xxGJOnQsZ2yOMocqTRlKbBNpJi09GZVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554884; c=relaxed/simple;
	bh=bQpmH9vNMThoeRyHxx/lA4kjKbzEcKD3MHcqd5HKoYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k052gj6D0ee6Hbnvc2HA15E2YYcNOpoYW7jVHX9a57wd2bi+ZDeZs+MZNFyRaFDQykqKqHkahHcOI42FNHxJdqmLHX7Pkm1GlLtwEhyhfX43MmMAXzWCmnMVQBrI62OLcbRW0C1OWMN2MBUCE3o+inhEw6PUK0UH4eWS1uFpM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZarYClGO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so7083176a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755554881; x=1756159681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0d+gBhBJj7Gyfb/2eDwGw6uu9T7brqZRN32+gbwitE=;
        b=ZarYClGOp9BtC9/+R1Mu0tf/uXHhu53R/xrc8Npz7lQDDsgGirvJdlTHjO7eccWOm0
         BWfBOOG5Qu2r/0oFYGH3ktvJ+VzzOkR7NT8Dp4xcDRzm7YFdFVsu6LA9G5CmmHkG0JR/
         Ue8/Uuq3uA9Ptd725/wJ7vIeOalGF6cQCywU0DV3Q/04ga45B4vdF8YB/xnq2xf7eymi
         D7DgAmfdUPMkYCXKrVW1615yVMLPzxYOYHWRmmjVItKwFcv7z7XC6h/N2hs3i3Lff1/2
         G5/4bG4GWfurRY3MOejU0BvBvWLU7Rs87MX356f+2jePausKj01iKOMj+iubE/6o2Uia
         ABsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755554881; x=1756159681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0d+gBhBJj7Gyfb/2eDwGw6uu9T7brqZRN32+gbwitE=;
        b=shKdepCkAbE7ern8vN+TtRLkj5pbYk19LeXfg489wKG739QDYPfIxNUTceWyoiKjso
         7el/wcHfp5VWgO1aqQa2TMWQfc2inqLfyRS1h8fShES5G17fjX9xVtFzp/uhyIePKYv9
         FCtI9Wth4pxbCFjdvkSTCKoASB6cXvnqqvdamTFr6qdV+F/1ciOgU6BEOJ6qGq/XHOkc
         me39ki+qiTxHcbZzwZBlBuZFXOqZ6IdlkBBOTrKGTosSOhEf8M8ZIWzu09qtvlXG6A1f
         KLo4u89H+ePkEozfIZ3DZZolpU+BKaxdbvKHr1OGmkIK2VphWw5Qwa6lSNNGVkKde5X1
         1wvg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYGqiPH857UtMSRXj3tsfZiiMDzAk4KfN9kU4AR/kNtkri+XUn3SFCcxisLsMkCYQ/5PusjqAmkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzraFu01ovowuos8OqCoKu4G8UGe+ZeLHzaQMftt3l9GueSTyem
	+pw4+SzY8gzQAoGOEmApslvf3pxV2ITKwoOBjW6FUu/tGZKdM/yBOa5eOWLE9ud2f3s=
X-Gm-Gg: ASbGnctGZ1fomBneGacAczh8BFj3Iy1TYt85c06tVO0rOeRMqjGGVKCpmFZxKJhtV5v
	Nh1YMI0OKhCiKaeNHwQl4g4AwJJBhRDVSSlSpxM8rg4lHAJ0ithnRnEkf4o58DJVPA3zJluuPtl
	0ajGtrFdbCKpiNUvzUuWtTzCkSIloXxbVh4YfHuKeDlo7fkq0fffUCVqPqZt6dL+RwOyKod6P9G
	vEsPfJz3h27Lxi4DbP8Hc69sK0ZIqlk/WJQpGol7sRNWiRd8QFnvQis7gn7sd5XpBp9FWabqR2e
	+wrsx7uJ0kRwuJ8Sj+1EXCwpJivhvE/+J6DOQIDgZIfSpqKZ9hVLY0zrRI3Z6UIqv8mW4bRRfWL
	9YBIUa/LfaJ+vyS2VvdW7k2U=
X-Google-Smtp-Source: AGHT+IF2vMSLlrPe7DkSEplhOtvR5lA+DveYM/ehtUdKZMiRSWeuOvauNm68bep9PjSdCTeF4KpYUA==
X-Received: by 2002:a05:6402:1d4f:b0:618:1d7d:b967 with SMTP id 4fb4d7f45d1cf-61a7e6ddfd3mr124027a12.12.1755554880925;
        Mon, 18 Aug 2025 15:08:00 -0700 (PDT)
Received: from localhost ([208.88.158.129])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a755d9b2csm546008a12.2.2025.08.18.15.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 15:08:00 -0700 (PDT)
From: Jonathan Curley <jcurley@purestorage.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jonathan Curley <jcurley@purestorage.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 0/9] NFSv4/flexfiles: Add support for striped layouts
Date: Mon, 18 Aug 2025 22:07:41 +0000
Message-Id: <20250818220750.47085-1-jcurley@purestorage.com>
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
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 110 +--
 fs/nfs/write.c                            |   2 +-
 4 files changed, 636 insertions(+), 314 deletions(-)

-- 
2.34.1



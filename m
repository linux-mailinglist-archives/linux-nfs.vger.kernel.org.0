Return-Path: <linux-nfs+bounces-975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9278827746
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 19:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E5284B12
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5514E54FB6;
	Mon,  8 Jan 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bllMikhw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699F54FA5
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jan 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d40eec5e12so17014825ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jan 2024 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704738014; x=1705342814; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqDz4oNfh2B5BR/R2EPy7vlFbl/dDn7Jawuse3WFwvo=;
        b=bllMikhwnjXw9qktxz4YuUWo3qwbDoFs3t/lVGHkqklTFIEYTaKxD0GCcAyAoOu3T2
         4uuWz54cSyrNUbwSeBB5Un/TSUcBOa4oSuN6ljO0ydDWyJmnlgCUXioFJfFh0eE0f1ye
         FQJrShhwQFaBJJjVFL3EbvMeGVbWXHBA+Bth4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704738014; x=1705342814;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqDz4oNfh2B5BR/R2EPy7vlFbl/dDn7Jawuse3WFwvo=;
        b=pr1bVPRuoR8p952zDP/VLU20jojzqNnyo0fd33wZYkZJa4+nPZ3O02X/Fn2OfH7Dq2
         O4yqr2ONJTePYKwBIuKG8WeNYG3D4406C2X8YQpxNMoyXJnnJ3ckOpIxeWFHPw4+R//k
         mRc57TlmXMICMwS/qMtuUW150vkaKJgfIE0xxWxvYDzInbECapAXUZIo7O3vuR1P0Ksz
         zts3xlyUELA3C3rF46E0rp4O30UtAUnMT0LpemjOGyMJwuqI9gbtws92gaJVo6UaC1vW
         qXBNjz43Q0qH+KqBReIkkwscAplmxqLTpYIuFChNVAT8iFg2QY3SY5jlEBwBXcvjC8V7
         ZV8Q==
X-Gm-Message-State: AOJu0Yw2btC2mOb60jnfL9qTldjjoRKuzP6C7UiyFYPMKrC6P5A9E7iq
	9ff8thWHc1WL+OCML0/QFv2IRb3ReXgT
X-Google-Smtp-Source: AGHT+IFxNO0lEcwVoYJ2PS0WIsN/wyi14uuN4veTMd6NRnkjGW0P6RQp8XvrWrO8PioGVkNCuYdP4A==
X-Received: by 2002:a17:902:684f:b0:1d5:4dbf:6045 with SMTP id f15-20020a170902684f00b001d54dbf6045mr517599pln.86.1704738014214;
        Mon, 08 Jan 2024 10:20:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902729700b001d54b86774dsm205146pll.67.2024.01.08.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:20:13 -0800 (PST)
Date: Mon, 8 Jan 2024 10:20:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
	Anders Larsen <al@alarsen.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anna Schumaker <anna@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Geliang Tang <geliang.tang@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gurucharan G <gurucharanx.g@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Justin Stitt <justinstitt@google.com>, kasan-dev@googlegroups.com,
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Marco Elver <elver@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Neil Brown <neilb@suse.de>, netdev@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ronald Monthero <debug.penguin32@gmail.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, Tom Talpey <tom@talpey.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Xu Panda <xu.panda@zte.com.cn>
Subject: [GIT PULL] hardening updates for v6.8-rc1
Message-ID: <202401081012.7571CBB@keescook>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening updates for v6.8-rc1. There will be a second
pull request coming at the end of the rc1 window, as we can now finally
remove the "strlcpy" API entirely from the kernel. However, that depends
on other trees landing first. As always, my tree has been in -next the
whole time, and anything touching other subsystems was either explicitly
Acked by those maintainers or they were sufficiently trivial and went
ignored so I picked them up.

Thanks!

-Kees

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.8-rc1

for you to fetch changes up to a75b3809dce2ad006ebf7fa641f49881fa0d79d7:

  qnx4: Use get_directory_fname() in qnx4_match() (2023-12-13 11:19:18 -0800)

----------------------------------------------------------------
hardening updates for v6.8-rc1

- Introduce the param_unknown_fn type and other clean ups (Andy Shevchenko)

- Various __counted_by annotations (Christophe JAILLET, Gustavo A. R. Silva,
  Kees Cook)

- Add KFENCE test to LKDTM (Stephen Boyd)

- Various strncpy() refactorings (Justin Stitt)

- Fix qnx4 to avoid writing into the smaller of two overlapping buffers

- Various strlcpy() refactorings

----------------------------------------------------------------
Andy Shevchenko (5):
      params: Introduce the param_unknown_fn type
      params: Do not go over the limit when getting the string length
      params: Use size_add() for kmalloc()
      params: Sort headers
      params: Fix multi-line comment style

Christophe JAILLET (1):
      VMCI: Annotate struct vmci_handle_arr with __counted_by

Gustavo A. R. Silva (2):
      afs: Add __counted_by for struct afs_acl and use struct_size()
      atags_proc: Add __counted_by for struct buffer and use struct_size()

Justin Stitt (5):
      HID: uhid: replace deprecated strncpy with strscpy
      drm/modes: replace deprecated strncpy with strscpy_pad
      nvme-fabrics: replace deprecated strncpy with strscpy
      nvdimm/btt: replace deprecated strncpy with strscpy
      nvme-fc: replace deprecated strncpy with strscpy

Kees Cook (6):
      SUNRPC: Replace strlcpy() with strscpy()
      samples: Replace strlcpy() with strscpy()
      i40e: Annotate struct i40e_qvlist_info with __counted_by
      tracing/uprobe: Replace strlcpy() with strscpy()
      qnx4: Extract dir entry filename processing into helper
      qnx4: Use get_directory_fname() in qnx4_match()

Stephen Boyd (1):
      lkdtm: Add kfence read after free crash type

 arch/arm/kernel/atags_proc.c               |  4 +-
 drivers/gpu/drm/drm_modes.c                |  6 +--
 drivers/hid/uhid.c                         | 15 ++++----
 drivers/misc/lkdtm/heap.c                  | 60 ++++++++++++++++++++++++++++++
 drivers/misc/vmw_vmci/vmci_handle_array.h  |  2 +-
 drivers/nvdimm/btt.c                       |  2 +-
 drivers/nvme/host/fabrics.c                |  4 +-
 drivers/nvme/host/fc.c                     |  8 ++--
 fs/afs/internal.h                          |  2 +-
 fs/afs/xattr.c                             |  2 +-
 fs/qnx4/dir.c                              | 52 ++++----------------------
 fs/qnx4/namei.c                            | 29 ++++++---------
 fs/qnx4/qnx4.h                             | 60 ++++++++++++++++++++++++++++++
 include/linux/kfence.h                     |  2 +
 include/linux/moduleparam.h                |  6 +--
 include/linux/net/intel/i40e_client.h      |  2 +-
 kernel/params.c                            | 52 ++++++++++++++------------
 kernel/trace/trace_uprobe.c                |  2 +-
 net/sunrpc/clnt.c                          | 10 ++++-
 samples/trace_events/trace-events-sample.h |  2 +-
 samples/v4l/v4l2-pci-skeleton.c            | 10 ++---
 21 files changed, 208 insertions(+), 124 deletions(-)

-- 
Kees Cook


Return-Path: <linux-nfs+bounces-4590-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4D926322
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 16:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9551C22461
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A917B432;
	Wed,  3 Jul 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8g8eLQg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E8177980
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015967; cv=none; b=s2TkJ8Rr2iDTSDjELINsFHRouVgpE+TiVaKuDOj2InK6WB87BSwFZ1wV6eQBdequi7w1Hs76qalWf5C8xCH67l1RqyRCRaHvn1+6uRDdSEDLUioP59FOtxu2IervHOI2wu5Kn1YbBrLxN0xo34LQnZG0pJjRoNTFzerIONd9RJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015967; c=relaxed/simple;
	bh=iRY5mqMEwTFhbgA1mqfRPlMEVBpeNCPMJBq8B2OFdqE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N7YgzGjZaXOwDaAmGOliXqDKY7vhW/a6tR/lluzuapzw2VM2gnmthrYW0WG920d+c9p+BfFEOEd4xs7AEKeerIwEVWp8fyTLA6/L3OPSjhDBMf0PdQ0U/N60YQSh3KKGprtRrUSLsA31KfBS/lY6XxzhdBSKe5H4mGzDSkP7nJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8g8eLQg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b3655297aso49371487b3.1
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jul 2024 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015965; x=1720620765; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SHZorDvLSpRaHOzjP785Ss+aorW87jy++3fHxaONvG0=;
        b=W8g8eLQgSu1BoA7WC0x7W7kulyHF5Dxp19Ler/qnwX5n4rGAuen5Vp3mPiU9gkKou9
         kedp08tW0if4aQgtawrthfTvswCGJDdv5ejZibLdI6rvhU092ZsNKK5VS03/2qsdBReU
         uh6X+L13O5Hc07YZMGtz+azDkBz1WEipz4slh5uvW+ExPCWel4jkKqigbxvuMYB1uAm0
         JqDyFCQGu3Fo4KU9G20BRVZxJGowDY6gsmJ43HYVwKHCzKJSfbFoiixyGEPrXJ8tWb1n
         m91ZxoUbvflmFWbDdyvVLcGOKDQvBoxSrbZF48lw+Vg7YJWEK0sXX6T/wBfrvzG4FGLx
         kisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015965; x=1720620765;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHZorDvLSpRaHOzjP785Ss+aorW87jy++3fHxaONvG0=;
        b=HEU0jRmfqMwSV/9vM85rcSauCysKlOzLmxMh176t/WL37tAj9udH/RVAzed0gmNGL4
         njNAOXKUKjrqc6f83F5f5jtbJriYJkV44vlYdaHHrh4l+zXyOM4I9CiOckqAXwrRmwkG
         ws7AEvejQG1Z/YjAuqwCSoK+aJqf+Uwy5CgFrsVnqOmNhWdE4J7DUxuCKe6xNo9TgIHT
         2DYlXFIAVqVmWkyddHY5WtNpJS+vnrdG+H2Af9GeGEzGBoUMpMOVSLue3LnWOI+hdEbi
         0kxKdFXkut81agGwkjYLyfWX4ynttKjC91neLwWS/FWyglP0tZ6+PJ5ro618Q//2qwJo
         WM0Q==
X-Gm-Message-State: AOJu0YzyNUK1GiCUS6ztgE2FewkZ6UQv9KRd8N+k5+U183DrLeD36xI6
	nRbfwrNmXdsbTO+KRitqUMYqigQcxcDZ/jfwl20BL9LD4XIc0MFOW2oIDq4pHqSPYRM6AetzwKd
	6pYTdXfxrSps2AqP/GQ2xGg4B/axg2QlF
X-Google-Smtp-Source: AGHT+IFf40S/aaztLaYO++mXpnPo/l6Q/ZxYatchJoWDpDnNr2tdu7eMy1LTu932pIUmGOz2Wq+HsBwoct8IQBlEUZE=
X-Received: by 2002:a05:690c:6f0b:b0:650:859b:ec8d with SMTP id
 00721157ae682-650859bed2bmr52104207b3.10.1720015964629; Wed, 03 Jul 2024
 07:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Youzhong Yang <youzhong@gmail.com>
Date: Wed, 3 Jul 2024 10:12:33 -0400
Message-ID: <CADpNCvYGqA3a51OH=AcqmKyAmnx3yoZjYPo7US+qk-OMX789vA@mail.gmail.com>
Subject: Leaked nfsd_file due to race condition and early unhash (fs/nfsd/filecache.c)
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'd like to report a nfsd_file leaking issue and propose a fix for it.

When I tested Linux kernel 6.8 and 6.6, I noticed nfsd_file leaks
which led to undestroyable file systems (zfs), here are some examples:

crash> struct nfsd_file -x ffff88e160db0460
struct nfsd_file {
  nf_rlist = {
    rhead = {
      next = 0xffff8921fa2392f1
    },
    next = 0x0
  },
  nf_inode = 0xffff8882bc312ef8,
  nf_file = 0xffff88e2015b1500,
  nf_cred = 0xffff88e3ab0e7800,
  nf_net = 0xffffffff83d41600 <init_net>,
  nf_flags = 0x8,
  nf_ref = {
    refs = {
      counter = 0xc0000000
    }
  },
  nf_may = 0x4,
  nf_mark = 0xffff88e1bddfb320,
  nf_lru = {
    next = 0xffff88e160db04a8,
    prev = 0xffff88e160db04a8
  },
  nf_rcu = {
    next = 0x10000000000,
    func = 0x0
  },
  nf_birthtime = 0x73d22fc1728
}

crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
ffff88839a53d850
  nf_flags = 0x8,
  nf_ref.refs.counter = 0x0
  nf_lru = {
    next = 0xffff88839a53d898,
    prev = 0xffff88839a53d898
  },
  nf_file = 0xffff88810ede8700,

crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
ffff88c32b11e850
  nf_flags = 0x8,
  nf_ref.refs.counter = 0x0
  nf_lru = {
    next = 0xffff88c32b11e898,
    prev = 0xffff88c32b11e898
  },
  nf_file = 0xffff88c20a701c00,

crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
ffff88e372709700
  nf_flags = 0xc,
  nf_ref.refs.counter = 0x0
  nf_lru = {
    next = 0xffff88e372709748,
    prev = 0xffff88e372709748
  },
  nf_file = 0xffff88e0725e6400,

crash> struct nfsd_file.nf_flags,nf_ref.refs.counter,nf_lru,nf_file -x
ffff8982864944d0
  nf_flags = 0xc,
  nf_ref.refs.counter = 0x0
  nf_lru = {
    next = 0xffff898286494518,
    prev = 0xffff898286494518
  },
  nf_file = 0xffff89803c0ff700,

The leak occurs when nfsd_file_put() races with nfsd_file_cond_queue()
or nfsd_file_lru_cb(). With the following patch, I haven't observed
any leak after a few days heavy nfs load:

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1a6d5d000b85..2323829f7208 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -389,6 +389,17 @@ nfsd_file_put(struct nfsd_file *nf)
  if (!nfsd_file_lru_remove(nf))
  return;
  }
+ /*
+ * Racing with nfsd_file_cond_queue() or nfsd_file_lru_cb(),
+ * it's unhashed but then removed from the dispose list,
+ * so we need to free it.
+ */
+ if (refcount_read(&nf->nf_ref) == 0 &&
+     !test_bit(NFSD_FILE_HASHED, &nf->nf_flags) &&
+     list_empty(&nf->nf_lru)) {
+ nfsd_file_free(nf);
+ return;
+ }
  }
  if (refcount_dec_and_test(&nf->nf_ref))
  nfsd_file_free(nf);
@@ -576,7 +587,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
list_head *dispose)
  int decrement = 1;

  /* If we raced with someone else unhashing, ignore it */
- if (!nfsd_file_unhash(nf))
+ if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
  return;

  /* If we can't get a reference, ignore it */
@@ -590,6 +601,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct
list_head *dispose)
  /* If refcount goes to 0, then put on the dispose list */
  if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
  list_add(&nf->nf_lru, dispose);
+ nfsd_file_unhash(nf);
  trace_nfsd_file_closing(nf);
  }
 }

Please kindly review the patch and let me know if it makes sense.

Thanks,

-Youzhong


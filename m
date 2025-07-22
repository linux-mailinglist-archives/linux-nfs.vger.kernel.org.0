Return-Path: <linux-nfs+bounces-13187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D0B0E33E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 20:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913636C8447
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B027F013;
	Tue, 22 Jul 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuZUrMK+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0020B81D
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207833; cv=none; b=BiB0vBLvIrO791MO/x8PfKyYPj54nnphnEwTCH2epSpBqX3V3yFsVBO012ZYA59dwAHHa9HYPhSBrnbKDLkP2AhmpmHxfTNa5KyIXsCMcSvcPXOKkkUDiqGom3Ck5tdU2k9CxQwtm8tVoxBjZmioFkK9IL/RW9JgqsUt+lxur/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207833; c=relaxed/simple;
	bh=/V+8AgzyFtPcgd3ejolzX0QCQ4x/1yBfNYiSu+S8qxY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KJwQvSlXMTonpjZjb8DqtSwMDh3tp9HhBF90U2ZfH858dBtIOPFNzdF5VQfPmnN9yPS+R9iLsf/8YMSwIm7yKXoChFgXQAFqbFbE5Fc+NFphVkIira50CnzdxvgHHVrAMRDst+Mpfmu+7WdGj2t84K5GxrRZbHaB2R7Xz4cu9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuZUrMK+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-710e344bbf9so55153377b3.2
        for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753207831; x=1753812631; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2RMt+SPTAnpJMGnKE0xIax7ZRKTDI5WBsyO7kOs5fGY=;
        b=OuZUrMK+7UOEJPEh14Wf68K6iwCNFSKYaqRwGAWIDCsSewBSej7rri8dyeVJ85T/Im
         Rkwxof/8iK03lRGTS/mUOEb26JT3c3Tp7LtbnRUsK4XXFu4ILPix6UH8UWdvoO4pSHh5
         0NbGQMhOdcAJUt2IwWrRBUo+fcx14eGUDEBOLOQwKSoMb/8kHLv36euGw2LlehthkVnf
         jZtkgZjqlt3NgYqwcBCYH3kIK/XG00ROBFuuncqtDK2IS6c5CWUJjfTwxNM+3EHIKX2C
         W2PsHntDo2hJSZYQkbaEwTqEI8N9j24oyWWPMqGgPqCPb9GYVHOrk1Bb04zFNHnFiYKO
         GsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753207831; x=1753812631;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RMt+SPTAnpJMGnKE0xIax7ZRKTDI5WBsyO7kOs5fGY=;
        b=G/g5BRbfzYrjgV9Ae5k/Tp5UjfTFypr94Y2ga4oHu91Fy5vrHhsCbPSLY605j1Zod0
         2VOqcYVVL7+6H4u2VVodf3DhUKVRMjIgpbO53RzAaFfxHYRm5fxUFfvpseQLf5uk+hkX
         ZJAYfeImb3P7wZvny/DrbLUMjWMsSvuIcRJk/oeEEfDFzoay7oWumtL9EHTOSZkfzga7
         FRkwcn12Pv0uvPd2+DQ6WbjuXOeKJvmaYPVEaNTqgl9T9E8xcjqnX1rJ9sJFmlmb+nc8
         cdLt+GekF2kY6mY+uDXu5Gi3RPlRpDzawiCZU07uOcTGPnv76HQJlRRE+RZJlliosqom
         kxUQ==
X-Gm-Message-State: AOJu0YwtzDKhBy7vHWZkEudeY3ihI6hvg9hP8VAUXsVtOu38xZ7J6Yws
	r5PuD6NOwPvWylkpxAbREgeBjJQgypkV7gbsW3s5XOrWWc8Pj1OsKc6QP6DaZA8r3f0iwySFP0m
	mWFTfcHU39jiqWNkSjQd6lmGfnxc3Ce5prv6N
X-Gm-Gg: ASbGncuPjsD6P5XONbYqjZrAa4pBncehn6bUKT3wNkTvciqn2w9uiP4yalhvMs4V8xr
	LIvI78xMFIr67BWODgu7KduOkPIqWxVGwnrzS1RgtfDNRjp7NjfSMqQIsp9OXV47/gSgFwgtMQ+
	i9XCDOXc3NKk2wzi37hCjpUWIIUP/+GpXg+AY/3+F036IZbJXW56x7Gz3PlxE31puR3TwQcBNZO
	8pxgkFLafuDdS2gwTM=
X-Google-Smtp-Source: AGHT+IH1GXG2zMu7HO+AoiiSpE+GpyckOc4uZIe/UCy1PkDN6ZdnvR+p2VMt6V0JNpe4EnDuFB1Ke13sNbSC78lzLeg=
X-Received: by 2002:a05:690c:6a07:b0:70d:f15d:b18f with SMTP id
 00721157ae682-719b422710emr1285427b3.26.1753207831206; Tue, 22 Jul 2025
 11:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 22 Jul 2025 21:10:21 +0300
X-Gm-Features: Ac12FXwsUe5f7C2qY6x0T0uzrB6X0b-rWlI9Q-AZfyjkHsN8-OEgm5SxU3uXenc
Message-ID: <CAAiJnjqvKAE_dUiCTr8D5UShNK5fxJuUHpP=nDFadF-OYhYbfw@mail.gmail.com>
Subject: nfs client and io_uring zero copy receive
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I am trying to exceed 20 GB/s doing sequential read from a single file
on the nfs client.

perf top shows excessive memcpy usage:

Samples: 237K of event 'cycles:P', 4000 Hz, Event count (approx.):
120872739112 lost: 0/0 drop: 0/0
Overhead  Shared Object                      Symbol
  20,54%  [kernel]                           [k] memcpy
   6,52%  [nfs]                              [k] nfs_generic_pg_test
   5,12%  [nfs]                              [k] nfs_page_group_lock
   4,92%  [kernel]                           [k] _copy_to_iter
   4,79%  [kernel]                           [k] gro_list_prepare
   2,77%  [nfs]                              [k] nfs_clear_request
   2,10%  [nfs]                              [k] __nfs_pageio_add_request
   2,07%  [kernel]                           [k] check_heap_object
   2,00%  [kernel]                           [k] __slab_free

Can nfs client be adopted to use zero copy ?, for example by using
io_uring zero copy rx.

Anton


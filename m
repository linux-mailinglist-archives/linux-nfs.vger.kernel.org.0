Return-Path: <linux-nfs+bounces-9993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F1A2E0E2
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 22:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF847A288D
	for <lists+linux-nfs@lfdr.de>; Sun,  9 Feb 2025 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1FB1E283C;
	Sun,  9 Feb 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF5CkRo7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD51DF25E
	for <linux-nfs@vger.kernel.org>; Sun,  9 Feb 2025 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739137201; cv=none; b=qtj40mvPLCPLhArfABUFnM7hXAVbbchew57L3MHA7+PuVdaIngTNzKqMl2+6nRA8YSOSa6LqIpUviWci/hjknh6um1hu2MU3QDLDYvnD4R/nvcCnvJtdlbZo6b56inSwOQEMu7o/gA+u+HlWwdGLhzt0mJfoz5ZJMxHk9ehjsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739137201; c=relaxed/simple;
	bh=7FWzyl/gWumm7tNQqqVhVQQGpOxsL4iF+ojeWHjg+U8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=s7nK46/yebkUVyJvZps5sAGpcBaLdx7Qu86NMNL6umCgmhONXdTPHvr20P6GUuFQj7yIQLm7VE64rjMKJD+X46VGvSeVB+swb1hCYy2uTkIkBjmYiWp0wmIVQ4za3GEgKPPrBdajd6q0kVFoYdxF2TDFIRBZGoBfoEcUVgEcpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF5CkRo7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de51a735acso4115194a12.0
        for <linux-nfs@vger.kernel.org>; Sun, 09 Feb 2025 13:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739137198; x=1739741998; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oeiy1D49Jj5fHtMalE2J4KoUiyPGeOJCp7iqs+NPDH0=;
        b=fF5CkRo7Y9HYDRexnnQaR+cM5HQRINDuv0UhEZ6ulXiCeTDSzzpWzA/aicIHpQ8cgu
         +WNNTMr0N0HKvWKBZnXnVlgMT1YTa1ChEMmsZIfghb+3RpuKCWZIq65KplSh0n8tVxyF
         34MJMym35cOMkspzWs54sZ8m3a5TX4O/4VrhJTtcQ2duCTst7ZWQT1PT/ciKgKNdzVWI
         KpolBoQuuiZb/8B8MvYlnhyormtDlrEjXnIulQPEYppl3TLJyT6JnmKx0mlaHmJTFymf
         JCk6JA5cjpOFRtiiulSzzA+T1FUXtU0C7tkZMZBu7GEVw3mKpen/RK6fOiZbYHaIInrI
         H9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739137198; x=1739741998;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeiy1D49Jj5fHtMalE2J4KoUiyPGeOJCp7iqs+NPDH0=;
        b=bkMJiY7OePFtywrn9wSI9tMLIHCHmlpMUGO2nMBJ9LDo1YT0RLG0j3EvegAlzlkFNB
         rG42iV5Fvb5G2ZQPzU5Dl6Ha2ueq/Np8nskEaYP0KLIPovLadRCZjdZOE/tgMeZhEAP9
         l7o2x9h6sMpFMhnU9qJ1AaiUGzrFnMNmDZgF2azHi1RdHJ4bAORXuwixbe05gTzKwAZA
         W2onXBScaykQbvSqdw6OhNNgFRXa3x07YRrsS3X/qR4p6xKanRpJx3+7CWvQm7dH46S3
         OJoIsa2TeJE+gzRoUM4z/VPuv3qREQ1Asius4DqhbZyX9zWXPB9jpEd5hIrB8UI3ut0I
         9t9g==
X-Gm-Message-State: AOJu0Ywg0kQ+K2x3H//0kAUsN4IFq+YtBnEw0fPny6vOIws3iBilN17V
	EkUXXUKmQKn9qF5k+Z+Ah333Q99FZPGbey+S+DrkUAOFisq8MculQ56gw59KckXQHwMWfKFS23X
	3oRMJWEMQzY8UO8eJAHXKbSYWNl+p
X-Gm-Gg: ASbGncszPWyoh0pug7iEg6bc4tvRisvo2Yqj5VQpBpum0UXHDcKStrbTJX5JMVZuF6w
	JyTp2KMa0AmHv03HN538T0QZIYUt/HLEidqNCO2Fz77hl6WgJwYWSwWGdX//kiR+MAfF4uuSZPi
	7FqYARM2luEn8L1PcslaVnriXtef3VQw==
X-Google-Smtp-Source: AGHT+IFIVZR4C23DpzLz6I+hv6e9tpWBqzcmdwGxc6Vqj1Di23nWGQo2SX2c3b9XSZQTnmTRm0kpXMhun7X0Hy+ggyc=
X-Received: by 2002:a05:6402:13c5:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5de45005a3bmr12451035a12.10.1739137198231; Sun, 09 Feb 2025
 13:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 9 Feb 2025 13:39:46 -0800
X-Gm-Features: AWEUYZnzye4adG_f18x5kc9NPOc9_wX11BeU0N1-1Wat261r9mTquq3ELmaK_a4
Message-ID: <CAM5tNy4f9YyMhYRydudNkCqzVp5f8Np6N25NOT=-+TjJN2ewqg@mail.gmail.com>
Subject: resizing slot tables for sessions
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I thought I'd post here instead of nfsv4@ietf.org since I
think the Linux server has been implementing this recently.

I am not interested in making the FreeBSD NFSv4.1/4.2
server dynamically resize slot tables in sessions, but I do
want to make sure the FreeBSD handles this case correctly.

Here is what I believe is supposed to be done:
For growing the slot table...
- Server/replier sends SEQUENCE replies with both
   sr_highest_slot and sr_target_highest_slot set to a larger value.
--> The client can then use those slots with
      sa_sequenceid set to 1 for the first SEQUENCE operation on
      each of them.

For shrinking the slot table...
- Server/replier sends SEQUENCE replies with a smaller
  value for sr_target_highest_slot.
  - The server/replier waits for the client to do a SEQUENCE
     operation on one of the slot(s) where the server has replied
     with the smaller value for sr_target_highest_slot with a
     sa_highest_slot value <= to the new smaller
      sr_target_highest_slot
     - Once this happens, the server/replier can set sr_highest_slot
        to the lower value of sr_target_highest_slot and throw the
         slot table entries above that value away.
--> Once the client sees a reply with sr_target_highest_slot set
      to the lower value, it should not do any additional SEQUENCE
      operations with a sa_slotid > sr_target_highest_slot

Does the above sound correct?

Thanks for any information, rick


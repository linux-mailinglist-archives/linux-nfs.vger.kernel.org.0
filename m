Return-Path: <linux-nfs+bounces-6332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92AF970AB3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 02:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55900281AD2
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2024 00:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8EEC5;
	Mon,  9 Sep 2024 00:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSaiU2i1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42D193
	for <linux-nfs@vger.kernel.org>; Mon,  9 Sep 2024 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725840384; cv=none; b=ZeIvcMes+eE+0eoijs4S7VgYr5/Zp+4wgGEho2LXyHyJnVbz/zW3CDjxC4DXSPqqYd13JJNxzFzB98Qx4Vi31vJnkpCySf6XGOP+EUGYLTyC/jRNVXGHqZ/ho6t+FuWvXP0MhTKeL4svYwy1tAa3coGlxvmdVAgysp0HfZYbUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725840384; c=relaxed/simple;
	bh=V4aEihyEjkMrqyFJWgGuBgYsWCjcshXB316rVglkoHI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=W6Sv3vos0QHYEEekLUD+hn5uULk6tBiyye7EO/I/MpxyPcYRoNJEmRaEy9GPrdCiwKuV/s/guZfQCM+P25ovz3WGyaraDDD6QXqb+DseYEcBPAJu+BORHFP9Adiyagnpem2S+E52nVw9v5UXOctmtMaqgOqS1kCMuR5L/nQ/hTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSaiU2i1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso3975599a12.3
        for <linux-nfs@vger.kernel.org>; Sun, 08 Sep 2024 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725840381; x=1726445181; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V4aEihyEjkMrqyFJWgGuBgYsWCjcshXB316rVglkoHI=;
        b=fSaiU2i1xDO9jdLS5xSe5V8S7Qhpl4pSoet8h9MJxY6cUT9EtJJBWAIuHEInxLnTQx
         PmuGhiLrEmWYeV/J1UjRE7u5uwU/3qXGCj6yC8eixpGgomOdTxjdo5LRoQehgil6eEVu
         Del/vPE4DHUOrpQFdvU8ouEszyzlVpeggvlHXYRlviROjLqFCflder446F0vOjVyrxkA
         8eubqRca+d3eLhY/z/tdBePdGd/7iXduJIeEdXfe2XNndGrOacKJGXB4wDKm98D94jR+
         yA0sS/czet0yyQmNV9OFh0g6NluXV4pR7lA1yrhL5VV1mxbvkftIcoOLKiX2Q0AJ72fc
         aM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725840381; x=1726445181;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4aEihyEjkMrqyFJWgGuBgYsWCjcshXB316rVglkoHI=;
        b=V52v+tRFJ9LI7GoDr0cFLY2byEwqXz3WhvyesHStryRfwN6kvbgMUQUoKy+RmSyamq
         4Ef+vlMyQlNRsB7BiW0ggWojAsf1f2LIsm/xzvpCv0fmLWIJtYO7cZhMr01mTO+HwiK1
         ZFjQ9aMQU9pRHX/GOSDbO3i2Cadxo9Hll2uHFl7c1swc+bPPI2arrxEOp4zN8AzsM4oP
         MqCS7d4A4WO+/OVn1GQvIkytBoaqjllMhiLQIOPbA8GvGvMHFCYfag/SDplClhSQBnm6
         IJu49QxvmtHwwr6ay0SnP7FPRJzDW5u0aixHa1tRrRlm6x0miMY/u/cENlbUN/CGPm01
         MvVQ==
X-Gm-Message-State: AOJu0YzqEwCZJ3u6jd593r2EPf/mnKHiToVL9eHH6nC0Aie+jG38N6iE
	4iKBHTZ0ErXL9ivATY1E4NqxPmRB0fCeItEj03KArLBC9zirPqtriqAhxC4rWr3bt7iIFUIap5I
	bkWUPjdLG7R+504u/qGyja09gHGBZ0Wc=
X-Google-Smtp-Source: AGHT+IGNGuCjUtLaqdB19cCFoOpKBIe8th45yxWMxKuriNPLS3Y5JGTgQVXnjmyfl9usRbsHAv+eBd7MKvec8nD2eiM=
X-Received: by 2002:a05:6402:3202:b0:5be:fbe7:11ac with SMTP id
 4fb4d7f45d1cf-5c3dc795f96mr6683042a12.20.1725840381297; Sun, 08 Sep 2024
 17:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Sun, 8 Sep 2024 17:06:10 -0700
Message-ID: <CAM5tNy7n8c-Lx4gL1MadXYJY-tL1oE9pp29UJ9Y736W62AFbPQ@mail.gmail.com>
Subject: client patch for NFSv4 POSIX draft ACL support updated
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Just fyi, I have updated the NFSv4 client patch for the POSIX draft ACL
extension and rebased it on linux-next. If you are interested, it can be
found here:
https://people.freebsd.org/~rmacklem/linux-next-posixacl.patch

I think the above should be sufficient for anyone interested in testing
during the Oct. bakeathon.

However, if you would like to see a patch set on this mailing list
before then, just let me know. (Be forewarned that I will probably
have more newbie questions related to the patch sets when I do it.)

Have a good week, rick
ps: Thanks go to those that helped with the newbie questions.


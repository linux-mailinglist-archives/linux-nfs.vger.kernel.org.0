Return-Path: <linux-nfs+bounces-6514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043E97A50C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 17:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BBF1C21D2E
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDE158D92;
	Mon, 16 Sep 2024 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9SSxcs0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99851156861
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499694; cv=none; b=SOdbUuncyKXr3U5qHsSKndglELw+h6Pe1HA786NqGWrmsOh/OP71CxaQImrKwvCKc081RwUUNmiJvCp+Afwm5XykUTtl9ebRoF+77bUehRKkD+5+tJZVnA1kVSOjLEAfztyvThQ5IhY9s8xGn46fjRvuBzeN1zYaRTPLjLadW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499694; c=relaxed/simple;
	bh=BI9POL4BferbBHkmPWeGtzwS4aVY8fCgP3Rdd2AZpZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u4o+kWj+qVnyOJSJ5ySJM3XzfoqRL+/MgerhceeWObV+c2za45VDKrcFbTyRmEKgChd07zhEsuHBI2RcBKCuSUDpB18V9MJXUm9fLy4jXpEi50sq18LdETergojqQ0gb8K8/RwasAk6Wdyci4zryhqfbfoR9j9nFofSJmr4AAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j9SSxcs0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so8369921a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726499691; x=1727104491; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQ7plyO1RRCUwyKbECTArAmBicdbcQgsTP8f26id730=;
        b=j9SSxcs01rJUDtgXyTGKpH2Z4jDEE3GStpsg3S9UyUrayYDSND6JUn4X4qeP37y+15
         WkXzVSLlVEsGJhVDwbBLlx/qUREC1fxMaZ8QWt5hN5LHZJXk/tGaHKMel48T8kjJj2Iy
         YQ5XO4tio2P2G34gH4Ww3zKU/BUZjyG0hfrWjfJJv+Us1Q7CkAsRvDW2lkBXOXAUYvVi
         eQNVRcLoF0dLdqF3qodW16lo/jI52W38TZPx06ICizbnUIG0aEWTKiaTCXewcOs/I7v8
         t0pHuqf12JyUQqd1oMuOTqWgxj4i5s4kgm03fyVX+Bk00XX2b2Av29UjTK8KA7GDbJ4H
         GeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726499691; x=1727104491;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ7plyO1RRCUwyKbECTArAmBicdbcQgsTP8f26id730=;
        b=quG2yUYzN92olCZDb9cFJaRfOViXGhdmicyl/zxG9uewI3R9qJXGMI4b1m08O5SiyN
         yzgPkoqlGFkbgBtLwcIVqbc3lVDGxZUhdF5vO3LCoJUeKwRVkQ3F6h+QAj0ww+FlwUaZ
         ZCRiaQ0xIgrJJ47Yzo8Y8caAkNFlygkqbe/0zKKqldCLuEfji4i16l8I9YAhArw8vfA4
         OPoxvLvWLeEMc4ZvF3H7Y5vVukpyrrIbq5KAxTuYJ3cHT0fnXYnnMLzRqcTx55Ew/Pzn
         tS63ZjW8/yii4TJxpjP7DG0LxFDlz5coRSaTqMvsaYblbcoU6INy7dZMLBf0oyI2wzYH
         8U3Q==
X-Gm-Message-State: AOJu0Yzv8rtt5n/f6YBb3gH6WdToU5I8ALvj4KgU+flVZYwYumscYjUl
	85dzzGBADGdV12fuUA5J3WVXdJjZtJLNlXLrYjm13EHi+fACW125AA+q7yE7ob/ikDUfqrG4oNO
	I
X-Google-Smtp-Source: AGHT+IEcz1gyhDu/Ok6p/3nEPlP5gznVXfeI+Yne09miSXJWB5dZr9A4kFzSe8S6UfE0JXyHTU2CKg==
X-Received: by 2002:a05:6402:51cc:b0:5be:d595:5413 with SMTP id 4fb4d7f45d1cf-5c41434e36fmr16109714a12.3.1726499690922;
        Mon, 16 Sep 2024 08:14:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb56b8bsm2729896a12.38.2024.09.16.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:14:50 -0700 (PDT)
Date: Mon, 16 Sep 2024 18:14:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] svcrdma: Add a "parsed chunk list" data structure
Message-ID: <afd3828c-a1d1-401c-bdd2-b1f634f44599@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chuck Lever,

Commit 78147ca8b4a9 ("svcrdma: Add a "parsed chunk list" data
structure") from Jun 22, 2020 (linux-next), leads to the following
Smatch static checker warning:

	net/sunrpc/xprtrdma/svc_rdma_recvfrom.c:498 xdr_check_write_chunk()
	warn: potential user controlled sizeof overflow 'segcount * 4 * 4'

net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
    488 static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
    489 {
    490         u32 segcount;
    491         __be32 *p;
    492 
    493         if (xdr_stream_decode_u32(&rctxt->rc_stream, &segcount))
                                                              ^^^^^^^^

    494                 return false;
    495 
    496         /* A bogus segcount causes this buffer overflow check to fail. */
    497         p = xdr_inline_decode(&rctxt->rc_stream,
--> 498                               segcount * rpcrdma_segment_maxsz * sizeof(*p));


segcount is an untrusted u32.  On 32bit systems anything >= SIZE_MAX / 16 will
have an integer overflow and some those values will be accepted by
xdr_inline_decode().

    499         return p != NULL;
    500 }

regards,
dan carpenter


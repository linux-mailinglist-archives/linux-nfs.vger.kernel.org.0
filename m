Return-Path: <linux-nfs+bounces-13886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EFB345CB
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B5C5E469A
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Aug 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D941C861D;
	Mon, 25 Aug 2025 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0LRu6IF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A4E70824
	for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135866; cv=none; b=u73JhK5JhJACupT80aIcgx83NOkERZ6MbmC4GaWhkKsbHooyKCZx7JmvJqkfBK4apwY/cQYErLGqgjKXbjp6zES8bdgHhHkKU0QUWHKD+K+vBEn6A5RpNwT7T419V/6kPat/agavDrgHc39oSUVBTyuI90mNUZIoBfLcnubHZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135866; c=relaxed/simple;
	bh=D9J/ZmzvIfIYjKwm3cTgAIH/DLhayRxRxasWZaiml3I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=K+WpjmQc1pzS+NpigpgnBDJ8Oam5DLrA8855BI8xRVoo2fBAle6NmSgnKe4ErCmZamhHbCRWqAz7bxaYXeBtnLhzazFg+tDOIeuDPVPO9dEtCKm9IHEbmxk6NQE9o82tRDAnB72IZqpS+4EdnUPHhjDdtauLgtZQiC+5EDx1khA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0LRu6IF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756135863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M7e+n4I2o4tQaMY75zKtGdj+bNHwhjJ7qTnpY0prqKc=;
	b=b0LRu6IFQ9g/KWpD6CwYAzryM8OVOdPQOa1k+V3EM/+qO3b6OQxsY0mc00R8jVHXa7VJPt
	h3mEfpNg+me+bWSPOOsGC11mc21stK/JFTOwlJgQi+yD3KDeiW0b2REGcYR/ypNq8E77y0
	BWHlBzTFFhuQldoOWNNCqsglHQA8daI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-nGcBENW3M16XW5fU37Gyaw-1; Mon, 25 Aug 2025 11:31:01 -0400
X-MC-Unique: nGcBENW3M16XW5fU37Gyaw-1
X-Mimecast-MFC-AGG-ID: nGcBENW3M16XW5fU37Gyaw_1756135860
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71ff59f2ac0so27274707b3.1
        for <linux-nfs@vger.kernel.org>; Mon, 25 Aug 2025 08:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135860; x=1756740660;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7e+n4I2o4tQaMY75zKtGdj+bNHwhjJ7qTnpY0prqKc=;
        b=fQNHSR1EI0ZjcjRbAnq4Tkayz28bEUJFCliFhRCmXHcd4l3JCGE4VQc1QvHLfI9iLX
         ddqXngzontFp2NHKBUfAOLtc/kdRhPZdBnRoSwaLUshrLzc1cXTIf+QXIF0FPu2aF7KQ
         HLLJDmZqlt2NZcilN2Yb5QukMi8vHNwmttTrnubGhrN8dESixysh7N7aWqElx9zZYO9r
         E8wCnDxifIvfjtVR+YrNlKjfPsEO7CfL/43h8g3iBfZLFzGsUx51PV5QUBe+jOhUbm8D
         F5f1vP19YV3YhPJWJ280bU7jEY51Khm+AQFZW72n3JSzeCqS0Rvk3L2oGYMbk6Vm9USv
         yIrQ==
X-Gm-Message-State: AOJu0YxpG48QcU1cY6ij/FpvlJJJxkkVsBIJXovI2/krX2G/ubP+95Ox
	YKYAP/zl8AnhIbaGCYNSQ3h2rapzYTxGWxZsBACheLGsKLUJBtir456D90S1TSLHWGKnJZQoENj
	kJifIZqCMySdtN4HJkFrGcS67cjzZQ1chrYBG4SvB5Ba4YB3ItveNNjpRP1nPwA==
X-Gm-Gg: ASbGncuB54RI1MC0jSq2DRJlpKyqB29fxwT5umNtfTx64brIpOUS5VFLncAdgQwAIRJ
	sdYDVKBTP5g+ErUf9vdO9mhDahkDG9c/cwn8qSNvp9JJhbqcB0JOPmrguP4LEn4qa/4Hf1IEO4L
	XckRUXYxecKJLx34mk5sfBeh14bZ2DOHEo93WoLn+s1grE076hYsGrQTe+4biIbwR/y22sxFN3W
	Gm6IIJVY9GCeInoOPGqm0qcZkIGAkQj3eal/MBF14P1fzxt0toJpCZZwI5nrd0/Yy+YcHKBQmLM
	DlQPs9QC5J5OBkSFPg4EdW3qWdo8owSlW2FL3TJl
X-Received: by 2002:a05:690c:2504:b0:71e:7f39:9baa with SMTP id 00721157ae682-71fdc2be2b1mr124374377b3.7.1756135860429;
        Mon, 25 Aug 2025 08:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvRcZL69iFpyKOKclsGudAZ+lok2kMuaHUTKL8hldI6oqhhSahLepPJ2VrQXh400rwzZMbCg==
X-Received: by 2002:a05:690c:2504:b0:71e:7f39:9baa with SMTP id 00721157ae682-71fdc2be2b1mr124373827b3.7.1756135859821;
        Mon, 25 Aug 2025 08:30:59 -0700 (PDT)
Received: from [172.31.1.136] ([70.105.241.207])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f657f58b61sm1702644d50.2.2025.08.25.08.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 08:30:59 -0700 (PDT)
Message-ID: <bfd46880-9150-4ba8-a2fb-bcb2b58c311c@redhat.com>
Date: Mon, 25 Aug 2025 11:30:58 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: libtirpc-1.2.7 released.
To: libtirpc <libtirpc-devel@lists.sourceforge.net>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The 1.2.7 version of libtirpc has just been release.

Mostly cosmetic changes to remove warnings that
come with newer compilers

A memory bug fix and version support updated

A new release just in time for the upcoming bakeathon.

The tarball:
  
https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.7/libtirpc-1.3.7.tar.bz2

Release notes:
  
https://sourceforge.net/projects/libtirpc/files/libtirpc/1.3.7/Release-1-3-7.txt

The git tree is at:
    git://linux-nfs.org/~steved/libtirpc

steved.



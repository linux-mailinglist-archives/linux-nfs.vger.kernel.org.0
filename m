Return-Path: <linux-nfs+bounces-2592-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA48894734
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Apr 2024 00:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1DE1C210C1
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 22:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F92A1BF;
	Mon,  1 Apr 2024 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="libgj9y9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF511EB37
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009973; cv=none; b=lGCuAIQmjlHkLWxl8308W+qxL87BFFoELTqGAWdIcdQbeIohNgBnQtNcmgKATqsUM8QK1+z/PkT4TVkgWmosujWQSwBiaitAX4BleINpZrrHYjdlR9sob1sCeFDtD2D46h/o2l1QI7lr78Ukj5PiAW0eJdgRdBf8zSPEkXrLzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009973; c=relaxed/simple;
	bh=ZPmrOzu8PIN7vUn/cUlzM89ZnKzEzEdSFBNJcVcoWlY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=atCSs8owTCaV6NOx3uOSE/He3RcgFCO+i958rxCqcgYcQYwuQm0OmyqRqG5aziKkqqsHwMDD8wSlRFfihodEVPd4Y9t6aXzSLFjl4defCkpnzUZ8x4Qb9JX/xiRhwnmAcK+pkggmuI3iOVvl1NWo36Yqy4SL0Ger/bf1nth9Iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=libgj9y9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so5404832a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 01 Apr 2024 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712009970; x=1712614770; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPmrOzu8PIN7vUn/cUlzM89ZnKzEzEdSFBNJcVcoWlY=;
        b=libgj9y9HXFKlL0ZmANdkPDJAsYQvikDq4JsxUTIHJ1RDsLPitfXc27Z0K68MvBLO+
         qWRnFvAZEYqrFfjfdIw4+l9/IGRPkuAF3iQUlU67rm2l/svgeYbNcXyn68EdFYOV+/r+
         Dhuv41xXZQGTbqXvQmgKyCKztD6vkUdURjQ0zDcIXWY/aQw9rTl/vHiITNVlQHJ9WBxR
         FdH0WW987K2xwCjg6cd2pMHmPtIqlpJIX5pZfVNp+JKpSODl7AmCwaeD1/OHmX+qtjji
         ChqI50eaAlt44WdATmA+f0Weg+KDaI3IHoXJjXB5w1CCtVwlFFYMNskqBR0arPNRpNRT
         vs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712009970; x=1712614770;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPmrOzu8PIN7vUn/cUlzM89ZnKzEzEdSFBNJcVcoWlY=;
        b=J9SWuC1NKdy+0YBeKMY2SC6JMjGPvXSMurdpK4lBtt86Z8X8W77BlUGu7Oad4WlUyo
         EtHgmfIi0tIUCykcXY2kKRpmbWdABmi9DytYBQMmZLM6KzKVC/Q8slpqLkYPpuIBmaQg
         Bp/oA+mNwsw1m8Qjr43S1Eirq2mHplWxSi8yVVL0An4wozxp3yRRR0pWUaHRX8FGkIi4
         Piagv7w795VonwyPiEJxNtv0qysTAAmFfgxmFK5i4I1MC9DwgM74Bhl/i6t0N4gGjHVI
         lvLBjUI4oS4pfOLlC8swstmhxOm8r/M75cPehmVD4YHOzkrilp/dYJ/U/Pn412Si/dVn
         HfeA==
X-Gm-Message-State: AOJu0YwP9J1CMuOWNdenrH6DGnKVcQrxTWIjKr1cEM0CdieNM0ij0Mfm
	pee7p0LCdJEYGUIdieL30NzY/A1MG/X0Z+O1X8oelFBERDDhRUAxqtRfgoB77rEmK7kpu6IWaCq
	5ZUsIgWQXsSxcs/l3STT0XpM1HtoTLTno
X-Google-Smtp-Source: AGHT+IHevwZ4ewHhIiwm2XYIS8GLv07XXb9egt3Z8LBtYdFGJ2t+k3IUIf4NfETxD59u0kJcOatmUnoExGloQhg+fjY=
X-Received: by 2002:a17:906:aa4a:b0:a4a:391c:7feb with SMTP id
 kn10-20020a170906aa4a00b00a4a391c7febmr6713455ejb.20.1712009969725; Mon, 01
 Apr 2024 15:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Tue, 2 Apr 2024 00:19:18 +0200
Message-ID: <CANH4o6OzeGwgT_QsJEiw=F1QO0w8ZYg30Pm-2b6NRTswxBLiwg@mail.gmail.com>
Subject: Linux nfs client and nfs server prefetch and readhead?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Is there any document which describes how nfs client prefetch and nfs
client readahead work, and which sizes are used (e.g. always read one
full page even if only 16 bytes are requested?).

Also, does the nfs server do any prefetch, or readahead? Which sizes
are used, page size, or something else?

Thanks,
Martin


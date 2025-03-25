Return-Path: <linux-nfs+bounces-10861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373A7A70A06
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF03218842BF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B792E337C;
	Tue, 25 Mar 2025 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHun/61M"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6231A83ED
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929579; cv=none; b=exO3r9VM7vWT/5gFiRqoFgPURkGDf5ab5yQq0ZQ7q3FnmK/l4cj/Qyc8U4XcrWNNSf78IcGBLywNxuEcwG3Ylzr9qJK7zR6Mt1nCTYprlTmmD3UcVaKC3BzNe1TKBV88gSkL0mXxYpP7twPfPsW9kJNKtemcaR1YAsf6OTLRPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929579; c=relaxed/simple;
	bh=btIFl36rYaaovwT2escYw/B+mywZkLVhZlASahpdXME=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=no6gsJTfBJb5rU4+1hRSSFI1Do+r2FR3ZhWEI+8oFNwaCXHpOjNOcwODbd2gnj9+wAQRO5N73dGNQGaIPEVJ1DZzAQtpGSHZjG4CnvfvHvWn9MS1MiJ92fdH0L5VtQJ74+4syHsMgKmIXsnNB6LoGVYFGK8b6gwlkV4FQnqHLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHun/61M; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab771575040so28251666b.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742929575; x=1743534375; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=btIFl36rYaaovwT2escYw/B+mywZkLVhZlASahpdXME=;
        b=gHun/61M5/tnpHtcZ1ZfSWL+I3gQLruoSn9LAmLFIouAsrfpprpZoQ2M5caSI5+Tok
         2WwO7Bzu2lqDckva7qiHCCI+L2A4aKZQnDRDnSRbOlljqCNXQwTMNS358fHJmKoApL55
         zh4YHTFgoB8yOjRcZkiwLJEA5OjQg+e+Fm6dInPU0rMOwgbPNvf3Cl0C8zfFcjpsXQwr
         97zxpq+zsSWzqV57oQq+drc7EgOlqq2R8jA/YfUEMWNLBMX72hmISAMCFWMRDOtfWJe5
         IAWGT92HLE0dNzCaJYDpC2q8PtWUWGAlQFzKJe601AH9IhaDS8PBH3A3iXceAI9bysen
         5X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929575; x=1743534375;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btIFl36rYaaovwT2escYw/B+mywZkLVhZlASahpdXME=;
        b=vtrUJlc4WX91sYwYZ8LGExWARnpYtm8KZnkAr11RKUM7acYxajxmU3KJqFjwT615Uu
         EPC382RAfUwyvSqm0UkYEEMrvDrqxGgyOxhCwIb0DHxz3wcVCbL531Qp14KRTRmCw1hD
         8NFo/hvoyRLb4wIoMS2r7F6ycRHRqymjdj5ucU7UDClHSbDxY3U1+nAuEBFZBsc7zxIy
         djj3oTsepfEjZPXKuzflIaJldcbMcrZhnLcnFivCj21KdQcWp8OwM83Bwt2hHR1tJ8/J
         94fe4dggjitC8H/AeR+sR9hjN8ua1hOUY9rg5FubU6rqOBAThKoSMa4+8LX2busdH85E
         LlRQ==
X-Gm-Message-State: AOJu0YwquqWEhonpcaMlwQ4gtflINYkw0bh//msiCuV8lPacN3BdepXT
	zptQI74nPrBy8mrgXnqumI53zwxoIH/adIoQKzm5eKYgh4obqlOBRfGeAe8wC7rVpqcTvc7YhID
	hm0hjwiGM/0I46ueU4xLdGfdXtuab+KuC
X-Gm-Gg: ASbGncvzMQVj0FtU6rYD0XbFDIyrh7fmRL7fAbEnW021e5K4jCsVH8BSwLS2WhiBw7F
	5ZGsffNYrjOV8jOOE/+tQ/n5jxLtWL6Gn1ExJxZxiU98rzHcCJ95a0wrhlqogZxRWn0cnu+6aE6
	ewXD67WUda9vHbcgKlqCXtqZVmLQ==
X-Google-Smtp-Source: AGHT+IGobMjx9fpgDMMsUPFNHU4PHv0xYzG7xeqZKpn8hiSPJ3IYjh9YlM/QD4xtMSZV0+se7jMbUU2kaLXjfjJ2uQg=
X-Received: by 2002:a17:907:1b1e:b0:abf:6ead:2e57 with SMTP id
 a640c23a62f3a-ac6e0da4e23mr90113066b.24.1742929574870; Tue, 25 Mar 2025
 12:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 25 Mar 2025 20:06:00 +0100
X-Gm-Features: AQ5f1Jr_T17O98tCYED0FdoqM-CeUOMfY-LRpHq0NSKb3b34jQtnyu_Mcu2d_3s
Message-ID: <CAPJSo4UW_vRbDgAyp5zdapxODvwrpJidZ55+MS+vfWv3cJdJ4w@mail.gmail.com>
Subject: Lookup all file names for a hardlink via NFSv4?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

What would be - using only the NFSv4 protocol level - the most
efficient way to lookup all file names which are hardlinks to the same
file?

Lionel


Return-Path: <linux-nfs+bounces-10858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F0A709DB
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 20:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC7719A38BF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Mar 2025 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3819ABC3;
	Tue, 25 Mar 2025 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8JZC2mm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E91CBA02
	for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928705; cv=none; b=kMzBtQZzSuw7F4fDBgUs+Hq5EiXZqJ55D/HVuRl+znoL637rlwnTeZha1maNovD6y4rmS2H9LwE9zP+lXkVloijQKQ1ajWug6VbNCwXN40atChzW8FOCZ6XYxpvx/wRPevzUSabYvvBTwRTfo0jGdCZLVyuXi89YZaKcK45SICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928705; c=relaxed/simple;
	bh=1Tuc/jhu8CA1COt2eLO6vDEtVaYyrxrF1txkG6M5V4g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fSfk7KjueGYennuvIF3opQjWsH5dl2WmsKvkKjaBzGchzH/9WmqulKjKfidPR/btFTB8qm9nRECt42dbGHekoAMVV8dzlb1fGK2GAZ2lA4BA5w94zVBlHLHwoegQjStfQKhl0AbT6JMytRJtx4h6wwxRWnRVRWylAqrRymrLlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8JZC2mm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so250194a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 25 Mar 2025 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742928700; x=1743533500; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Tuc/jhu8CA1COt2eLO6vDEtVaYyrxrF1txkG6M5V4g=;
        b=I8JZC2mmCutiFW0qiLeiyr7sGAGTS1io83HzW87M99OAZdphd1+TlTX33AOhEPnc9L
         +gKqfa34UwPONt+h67411FJNjG1VgvqANhS3B/P3tLxxCrv1l4nSUjYqFe5h771xzX42
         k9HrHDkhBvObEcZD5Jrf6cKWUKe1K966Af5TeidIgdHd420umvkWx8NSkbjk5i1++4Q0
         E00WhVcG4E6fvQ0wsfCs+VopCmA+HOHG4Eur1FWqi7Q2Rrs9qTGoPl8W4CjfPeuox5zX
         v1FftWXzczKIjt8s7qwwEtmfViPVtc3cF8P1XZZBm7Y+iRHSQp6kkbrLAqWb1wiQVXBG
         vItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928700; x=1743533500;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Tuc/jhu8CA1COt2eLO6vDEtVaYyrxrF1txkG6M5V4g=;
        b=ZsFVNk5S88GWJ5StCpf+SwcEgABqfgmYCQ5+fx7rH6R2m9zdwBIcDXnXj2BRkMplFM
         wLgxDpP6UfzHhnuI/sYMgZ9Lc8WLWZRMrieej8NZR2rnJkqAb87TDBr6SAr16FQpEXNv
         zTYZvRKPdEMZJdRM4Xn8/Aq746QP33LkLYuwMEUZ8EFknue/GvqXkaNXMNdNN6dg0JDC
         DxukQlJJEbRzXzfj7OsvmprVMrAs9ICYBe3bfdsb2wCFBqhKymixHEaNsNfPXe583/n2
         pQPXPwNKw1S2JMn+AsYsc8Y22EH62Nn8S2Bzkm10GA7nLp3UtIXUAEfzMUDOy2MJZ/gB
         wF8g==
X-Gm-Message-State: AOJu0YyjAm7l2FsaKfQyrRlJ0pxVA9CQaboX6gQaUqrR9rZhIQ3ej8NB
	36ZVXkyB6neYWvJUKhA+/035mHTsQmhabHBnnF6rCYPnvjc2jfZ51JEMwOQy6Xq+H55qRRWSbl0
	p49FFF7Qei5fC+F6rFdYPurnxzw7csXiI
X-Gm-Gg: ASbGnctDmoZHOP+0v5SxZzX57UCP6KDY9XzWbP2clV1G4Zb37tnsIrQRglwgjRipLif
	IHh1o4x3xVo2tNMu33oBnVwLGzVq1Jm6R/cYanaRwjKQ/Sj+5hzXGHB6Wj/CBzZQU1vE9/NmcoQ
	LAcR4l9gGAbCS1HyViw+QoIT5Bhw==
X-Google-Smtp-Source: AGHT+IGEVzRuhCYQXEFNIrfrOktT1RZJGJD8B1gCOe/rwulkOlmwQ2UtZLCqCv/rvUYbqLK64BNdaaCITxz7YpHD4rw=
X-Received: by 2002:a05:6402:1cc1:b0:5d3:e99c:6bda with SMTP id
 4fb4d7f45d1cf-5ed43cad1f0mr829138a12.16.1742928700265; Tue, 25 Mar 2025
 11:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Tue, 25 Mar 2025 19:50:00 +0100
X-Gm-Features: AQ5f1JqCV20n9JD6L01HIsxPZ-7CRWeDrjMxW5mOFV4PWAPtNMvV-vUacpIesM8
Message-ID: <CAPJSo4WFWkrv8u6FSEy0JWZ7nR-KAA1YeRkce8dFbXARSGdrEw@mail.gmail.com>
Subject: kernel.org CI NFSv4.1 RDMA testing / test coverage?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Does kernel.org have a bot (syzbot?) doing NFSv4.1 RDMA testing as part of CI?

My feeling is that the current NFSv4.1 RDMA support is under-tested,
and needs better test coverage.

Lionel


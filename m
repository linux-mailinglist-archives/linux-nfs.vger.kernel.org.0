Return-Path: <linux-nfs+bounces-10961-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6BA76683
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636B53A575E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Mar 2025 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE7210F44;
	Mon, 31 Mar 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he9QlTPA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A28136352
	for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426357; cv=none; b=l4Ae5Ju0qm41CKSxfS8o0CvZIO9zuq14WI/9sezBq1RZ2LkcZsUrDiuhu8ojOcRcOBhltSq49Z5g8ImAMfo/WnIV9dvQr+SNx5MmjoUDP7pMVBjoxz4T8164QIw1enboRvz0L4Vl7G8OVO0Bg6shz1a4Y27PdwJ0iwFJlkqgQfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426357; c=relaxed/simple;
	bh=jdPMUz5dz0Xl/NU6Uk7Pux/n2ybLRiPWKaIIlfdvyTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=R9qOXl50livYHlVauiuTvZKMeW4g5IeyO6aE2LyXwX6QZ/E9C6Jii7U/bnM0qtZMQ8jXbNSkuK91A3n4T96VIV2uDkUtWwY2aLqbCyziRzdOJ2dXyiPI9IPeQJhJGbAEUrzjfLojqKYGkl2dm+tfbcUqrSByUAqyTzpxwg1aQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he9QlTPA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso6958318a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 31 Mar 2025 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743426354; x=1744031154; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdPMUz5dz0Xl/NU6Uk7Pux/n2ybLRiPWKaIIlfdvyTA=;
        b=he9QlTPAqrysqqdTGXUQn5tGyn7iM+SnC3X9IAHHihubCSavFYr7pAmqxndBJm/Vv5
         9wZZunTaiAtsNBGG0ImSt+xB1GoRrfNun9ul6NmBzsVCR+hBCJtkBjgcSpJjeOr9ltew
         j2AeF+auWFzjvCXMopiSMckvMpLw9daUPq53LmT8GMjvaNAR3yDwBKh8pM45M+m3EXgk
         IHiKGrdDfSq9SL2I5OzJ1dDEzuKQQ70WQiijmNrupTgstFkvdcYufZje+UqFxNgBZCn6
         7OnswbYR1IT9ZLp8887O/RMkuiK6kPByyoRFACaL+GGbVj44uZ+KoZPsjoHchUFXn8oi
         RaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743426354; x=1744031154;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdPMUz5dz0Xl/NU6Uk7Pux/n2ybLRiPWKaIIlfdvyTA=;
        b=BV8YeemA+gqVHYmP0VnxbZMIfkiYWQogRkeMv/vEb1C7SqEsC2bKp5gVGyzFssYFMp
         +6SuJnEPN5XtayYbkzILZdfHDPbxMDiNNi2F8cRWSp2eE4bON4Y0zUFqcUst6MDortQ9
         fVMbGeJvvysByUzVCyJ9OOHK/LRnXfrNN/iOp2oaCwhWiozdrna5Htmo5LWKoV/L+xVh
         JJ1shzY69C4CVjDG2RUkxVOOSaVE6sQGIugyccftKi5/5NLZOaxt56gXIhbe+TcFwUvG
         9gKOlkyvvL8BmeqzZ9IHtEyy5wYWNyC90rIp6N+kuaZkyKQPllYMZ3uJm0rJgsAIZcYq
         XUog==
X-Gm-Message-State: AOJu0YyB05/hofDoUXcy7mN/BNAvVdApGYG+asQrNQeRcukZ2C/NHiNB
	CHTAlHU15RbaJyLynJ/+hyePxTxOXRuqE9rWObpwpCRFRc3HeD8fn42RiKnJbI+VmjkZSPT8fMI
	g7h7+1nsMn/9xENUh6oJAX1Q6hRmuxrv5
X-Gm-Gg: ASbGncuNqICDj9QxZYEf339QpWe/i5bcGDiFpyKTyFI0QWYcuoPOvjFhiS22yIqrMQ0
	avuUj/sqLFv5yWVx3WC+q5SPEWO8Bl7NuD7RM/xYM54OS4jFJXWWfiSwXH6+JJuUA8I2UyiBW46
	JMYjSOUYkra0OahDRNAxxDiP3QQuI=
X-Google-Smtp-Source: AGHT+IFiwB6kbRdo+lgQlDNFR12kS1C7IagOvAGBfNLA/wIADu+a3dxXmTATVAo6IGt66ySYwngXykdClJbrHR2s6QQ=
X-Received: by 2002:a05:6402:35cf:b0:5e5:d91c:4151 with SMTP id
 4fb4d7f45d1cf-5edfd0fd67emr7780728a12.16.1743426353846; Mon, 31 Mar 2025
 06:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPJSo4WFWkrv8u6FSEy0JWZ7nR-KAA1YeRkce8dFbXARSGdrEw@mail.gmail.com>
 <06f68f5b-a9e1-4fb9-acf0-43c11b14efd9@oracle.com>
In-Reply-To: <06f68f5b-a9e1-4fb9-acf0-43c11b14efd9@oracle.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 31 Mar 2025 15:05:00 +0200
X-Gm-Features: AQ5f1Jo4xOSsDoOXoqGOj05dxwK8zfxLz88pDFxXaxuP2mQIRksVgw5yUEhKfTY
Message-ID: <CAPJSo4Vn1WP__ihcxaDATn_z7EFdr1hPD54nZErY08_KO5sziQ@mail.gmail.com>
Subject: Re: kernel.org CI NFSv4.1 RDMA testing / test coverage?
To: linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 20:13, Chuck Lever <chuck.lever@oracle.com> wrote:
>
> On 3/25/25 2:50 PM, Lionel Cons wrote:
> > Does kernel.org have a bot (syzbot?) doing NFSv4.1 RDMA testing as part of CI?
> >
> > My feeling is that the current NFSv4.1 RDMA support is under-tested,
> > and needs better test coverage.
>
> I run tests nightly. What makes you think there are testing gaps?

Because we're stuck with a Linux 5.x kernel, and so far every
quick&dirty attempt to jump to Linux 6.6 LTS or 6.12 LTS resulted in a
half or non-functional RDMA or pNFS.

Lionel


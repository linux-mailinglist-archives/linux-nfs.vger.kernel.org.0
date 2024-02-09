Return-Path: <linux-nfs+bounces-1869-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49C84EE52
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 01:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF606B219D8
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Feb 2024 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863571366;
	Fri,  9 Feb 2024 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du5i+Haf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97EEA4
	for <linux-nfs@vger.kernel.org>; Fri,  9 Feb 2024 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437964; cv=none; b=O8V5zOWAAxTEjCEQyMnKwTV2RXXaVj/7VU5BvNU2ysui3SDewTtnoNwMyHA1bOrerqFxc1iG/Y/XzgXukIbc/oyBt9hy5KftoBIOt9mvxcV+c9x9Q8hW1K/r5bR0Z48RxVi1WAYPAg8oM4yljGfVX4dsh7xyc7FmrfWaci2gyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437964; c=relaxed/simple;
	bh=DEXGplt6dUJzBpZnCLQGg0Q8qK2LG2s/fhENSxopbI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p+VAaLazokbA/vft9P/JKnK8i/rqj1V3jkwz5TGQq/VW4s40HWgCkJJuKAQ288dMPmyHmCZ/TTmb1YS/Dm7CQW6VNqXNYEn/mlD2ugmAzvB4fP3iv3oxrgkqqI00T4hwKRp+NAR9RmIar/ueW45Ud5yON3GWdjkCWJgPmiAw8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du5i+Haf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5116930e92cso637819e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 08 Feb 2024 16:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707437960; x=1708042760; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klZ9cxxyo0vfjSpmwMuw+45wonCQjM296Zuagg82E90=;
        b=Du5i+HafmwqZvsnUSBoEELUlwKUqizq3NmNj/uzOpjPsftQnhAZyh9ifu2kZ7Tj0BN
         jLmA9BJQC2bijwtkerqTj3CSKBnTwFe93N91oC8IECTq+1sUnLv8d2E4jz9/krEAzlwz
         tPQZYKKLwlwH1T6UV0Xoy8cMpoEdsxTs4fJZSaSN5/Vl1RP6Zfm6Re1dIeV+GMQT4nry
         bjr/be+XqLyKvO47wOd5yxo1M32pZ76+FwRG3m7UGwtfdbjdmeAUfGYC6Kk31i91dIKB
         94xXAoDA0w/4xJ45O50n8aLDlUYbOH8RiS7iRFEUWpYhbiqQDCVhXJDWEHsi6yd1JomL
         KYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707437960; x=1708042760;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klZ9cxxyo0vfjSpmwMuw+45wonCQjM296Zuagg82E90=;
        b=v1DEQNxfdSh9PdUCVJ6Q8lnva7dFgmStn6vZWwZZN6E8NlmFVO1C0gZb8rEbKBRjre
         M6KRgnYc+9g4jpTjSO8Ji5x3r/03T4aIf5KmS9WAxvev2j6vA2g5O34uuCmYBoFIkahY
         GyMps4J2uTD65Ce7oiF3hlyaQDGNvkGeHkdanlZi0vXkLEBNic/Z8Aus7JGyot/jgFUn
         JlAqFCoTJwe5/jtUe6APu/z5YN+omfQkyWxUW+EuYC97xmjEOMzK1i4pnLZo8S6+/3Yp
         +SdBNMkKfMr2hVWOTcFAnR+UeGIdXLNlTmkqwbT/m83ewz2MdI8HGsyaJ2p9CDpTILko
         cx0w==
X-Gm-Message-State: AOJu0YzN9SlBLQDXGnjcDXVpnRa0/E5Tf/oYw7bcZCLiCUMQh58cchJp
	2JWfolaJcar5/wuK7q0Jr3BFcqei6o98YtDqBkQtJmrFFqnTlDY6IDQfcFDGuV5AWpRR6J+m2PD
	bxRRxpkK4J5a/nLxlTdCTXW3XG0rRW3wemJs=
X-Google-Smtp-Source: AGHT+IE5RS9L52shdGcwXsSQlrlx8l9fTM+CLldfiscr43n/69QdiTDHaEVjXLv60wn36JyzbfbDPDAYnehB2npC7/8=
X-Received: by 2002:ac2:592e:0:b0:511:729c:8aa9 with SMTP id
 v14-20020ac2592e000000b00511729c8aa9mr485774lfi.16.1707437960189; Thu, 08 Feb
 2024 16:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
In-Reply-To: <CAAvCNcBvWjt13mBGoNZf-BGwn18_R6KAeMmA7NZOTifORLEANg@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Fri, 9 Feb 2024 01:19:00 +0100
Message-ID: <CAAvCNcAkZFkLU-XtmJy30AT7ad_MvSzZTMEk86PiZXLdcMg4fA@mail.gmail.com>
Subject: Re: Public NFSv4 handle?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

?

On Thu, 25 Jan 2024 at 02:48, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> Hello!
>
> Do the Linux NFSv4 server and client support the NFS public handle?
>
> Dan
> --
> Dan Shelton - Cluster Specialist Win/Lin/Bsd



-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd


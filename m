Return-Path: <linux-nfs+bounces-13967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A23B3ED41
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC42B17ECB8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Sep 2025 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367832F76D;
	Mon,  1 Sep 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koMkO0Uw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD432F745
	for <linux-nfs@vger.kernel.org>; Mon,  1 Sep 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747129; cv=none; b=T25MA0TqVxoWX/BWmLnWzFKSkPLsQytH2QOTvGF0nxqpEDTRXglmnbVD6aShBD8UOFc9ChGXH/u+gVPddpZ5F1kcN5kwhl354jcxSVPOjKk3hI+dS87z6jbTzT5shOJdowK8HEXB98M0iYPKLdEcrbThq5d7Xh6O4aZTwESLneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747129; c=relaxed/simple;
	bh=4aLy9NmM92QOMrAyNVxyxUOp885GWPzGAoLvytOQfx0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kG5K1p2SJ1owkb9Mwzy37+1tEa02QZNfFYiJ89eqQGLQd2XVW4/FbAroQu7MFuIuSGRvHCP7RXIRk32ZIq2Wng/lI8hjVhfHXeNoAbsykC1v3hvF+rCLoWJ66lHB1LM7bfnn3ZA0qEFczHabIEhWG3lDggnX+0QtHYdFKgNxQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koMkO0Uw; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f6d8fcd106so618995885a.2
        for <linux-nfs@vger.kernel.org>; Mon, 01 Sep 2025 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756747126; x=1757351926; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9padO1BHOyIYINTdigO/tCSomOYvt1MiK5WtpSvI/Tc=;
        b=koMkO0UwfLW+vsnJlgqJePiQoZhu86utULo2ekrAtTThElQ6b2lZaoBH/IxRCRpxUz
         NSw8ygUFYjPbIQUJy3aU/inFWURN/CRDvkgPjyaRgNJy4EA3ubKRzlycZi1nzboOFKPv
         TCVxpKRhQ7aeHUCGoeVe0PORnDNLI1rzz43Yuxcy1PyForziDuCx0EuYy4RU2VZ8XHDD
         Nw4XYgNITNNdzquyoRmY5TW55e37d0fHrynfuZH8SqY9ROTp83834yg/JYLm7Crer1Q4
         JgwVz1bmoAd4WA2MNgDxbNCbxazlrS+hEISQ9fEE/fhwXH5qi/xgnv1qhpzGh4sTGj+u
         QDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756747126; x=1757351926;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9padO1BHOyIYINTdigO/tCSomOYvt1MiK5WtpSvI/Tc=;
        b=n3DxK/1XnBY4sITLTobnLa5RqdRTqMvKWa61EMr9pw3p6JWjStEMKM/+HATmZOZY0p
         943NYDeAY8nMKeBpxmx+e9EfUBleSG0pzx6pRG/0lEbcsCWd6guXbuN3e13iReM7kuda
         LLbkUdB8sQlH5ZX48VV7x6pUN/9QBBGIppNwOl+vrI2pXiUBm3t0MIMI8mFVtmBDSnJn
         9fLhN/Jjh9bHdJYpj04DqaPCM/Mn13b7+6/oyoVf0JIyzfa/SeVJB3iwjwwNId+yhKh4
         UyBk2fS9lUTwuSNgyTajCCpI1Xz0hWr02worPMJHuxrvMaSFDiYMkYsTdkAYeX+BXZue
         I+4g==
X-Gm-Message-State: AOJu0YyuU++zesZo6R1Fnktf926N4tGdw0k26gPe3CtOAD6TLcBS3S9i
	v2MxGcJY1e1/ET4P1GRSq/flzKrsIxZ+eXhsGopfpyPPqUQ3GrAhIHrjYbyM2w==
X-Gm-Gg: ASbGnctoXQEmSl/OUUyn0mc8ixuH02eDHoMYQRyB7k2EKEs/rXKX1GCtgvWOMZ/kJ9s
	qEEvqkHZHYUtsVkkXhf3F3ljNDgFF+edDhWEbLUqCVBWyzfJup23KAO38cqfWjyrvs9V7HRnUhF
	RS3/NdIf5mPL/QGKrLMn7DXbJDKG8sJVQsyuKK29/tBYhAopLTWQ8+hy8NaePHBFe9XB2gfr1xa
	wpTTUE31vAQjx+I1SFoXlzWnK2BWId3KHDDhjBPWY/g69G5dPI24wJwRSjqjW/69RHj0QawCU1L
	Ln4RzKagMjvlib5gs3yW8TAcrtmJZDqjxgOPP9aEoxYGYZarai6hP27RzriiDi60c4QQcmNOq6u
	TAH0dmq5dmwFZbKl3Rnx18Mxe2sed8g==
X-Google-Smtp-Source: AGHT+IEugsBBCc/gh6wSgV9Yxf+cqElQ2zHkulQVQme59srHtq3s6q8bnyNKNCy4XoJPmGIKp4/Igw==
X-Received: by 2002:a05:620a:28d2:b0:7e8:5f66:b2e0 with SMTP id af79cd13be357-7ff21c08827mr956965685a.0.1756747126213;
        Mon, 01 Sep 2025 10:18:46 -0700 (PDT)
Received: from [10.1.16.8] ([104.222.93.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6cf02asm65837051cf.43.2025.09.01.10.18.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 10:18:45 -0700 (PDT)
Message-ID: <c6ed030f-c4c6-40da-8d64-d81ba28e70a0@gmail.com>
Date: Mon, 1 Sep 2025 12:18:44 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org
From: Justin Worrell <jworrell@gmail.com>
Subject: Potential regression with "sunrpc: fix client side handling of tls
 alerts"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

With Kernel version 6.15.9, I am able to mount NFS shares exported from 
a FreeBSD (14.3-RELEASE-p2) host over ktls (using mtls).

In 6.15.10, 6.16.3 and 6.16.4, I am no longer able to do this.

Reverting the following patch restores this ability: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.15.10&id=3ee397eaaca4fa04db21bb98c8f1d0c6cc525368

I'm not sure if this is actually a Linux kernel regression, if FreeBSD 
makes incorrect assumptions, or if both are working as intended and just 
are not currently compatible.

I'm hoping for some guidance: does this makes sense to raise a bug for?

--
Thank you,
Justin Worrell


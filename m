Return-Path: <linux-nfs+bounces-13179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18A4B0D4F5
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 10:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E123F560BC0
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49FA2D662F;
	Tue, 22 Jul 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdOEfjgc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0162D8369
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174185; cv=none; b=YEpmdsbOuihkYlVe28KD52NGVpW+vAVNgIv47RI3tIGJOY474wbO0q+z59IpMNFPIDwDKWT8aN+9YRuaQux32oMPlJk6jKwEYia6wjuz9E9yMmP2Zt7MokJCkRjGKFz76AVnER6+wak+rMPkGoggnNRUYPxgbVIHHBM/9DVSBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174185; c=relaxed/simple;
	bh=mLxtu1W9y34x6VqH21KzJTmdNbkxZ1N2Ux2Sbj3Zd7k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VUCeBvW2TBAg5vY9/lAkhSE1OOqyaJHWRjvYruN1P17P7SYn+VyIMCXApyUcawH9ovulm7Z6+ASXFeyZuXKKwHy6VJTtiUyOH4rB/1wo2ApFonBFQkVS2Z66aeB12fYU0i9vFm5eUfL4Kkiswghc2eYzU3ja9tmzonW+IjzRLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdOEfjgc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so3735056f8f.3
        for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753174181; x=1753778981; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GipTkfrmNoAIdcVt5wUTI3EJqSfEKbfzh2zAkb/D45s=;
        b=TdOEfjgcjZwDZJG6LmwJ114vypd1NswqYqi9jU4MQ3ey0Az8oi8TonRSgtz2I08+LF
         pMT5oOIuEg7Kx3AppyQDfvxSc0BUCh5UdB47ep62eAfwX+hWp/Ym8hn0fqzNrzsEkZuG
         uBZChZW6LZIquzNeH5W6hPAbldGLKdkrC+H+3sa62uylPjCuFXIDNBK/PMrCFgLY32Jw
         Z9vVog8p8qNdY1CzQiuRj73d7Lsdf0A+Gey2tGNHOqv7Lmex6Twk3ou8moRNcfsHtZyu
         egvY/9QQBTMwCu61j1GjhQBg/HZxERDnwNCgOjLupEhhKmlq3r6WABLsAdmk459OcQVt
         Sc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753174181; x=1753778981;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GipTkfrmNoAIdcVt5wUTI3EJqSfEKbfzh2zAkb/D45s=;
        b=pGF7KnyZuM9l83u2xUkL3L0MJkNF5ztAuSUewtJekMKkcMT16Pd5U5cnVKOLLWxRS8
         Rdu6vy+lOqG61ZsZSLpaUGBH6GfEb5Cf/ICygkawZFc9xed/65toGaZwoxXrK6DN7OMM
         HaEP1K/RwLTWIiFmldQuyh4de/qF+ZZrJOY+xKGrGDZLUNOmF94pR3ZiZGma6C954rzx
         RjarbWoG2b7Xm5i1TNkExH+VHKzn1qb1RV7EIgfGUvn5EeaOL2y3ucM+BKO/CUsoYgtX
         5d/w9K+sgbhSbPIWPUIkNWny8gCnFNUZZSHCQpEJcPV8ygzLDLue/e+lWR8BE+coERBM
         8L9Q==
X-Gm-Message-State: AOJu0YwWQTwvNGd9wuS2PhlSa4e2AXjueZdAJVE37ld5o47CBFQ05u3Z
	STGqG+rVNggUIsMeRnn8pR6qS6sdhBcWKjeHWBbdxNaC+PO/lGwFZiZY8/BLmw==
X-Gm-Gg: ASbGncvaTAFVCO/V9Ep3Afa6CYV5q3eJfvXVK69sVi1ePxJB772kahMQeK2SA4xctz0
	0czlxo+MW8jq5tX5peP+Uxv0fQGh38vvjLLYZPQh6zgtHoiMr1uK7IMLd9NHgWViDKkB7UPRYJy
	k04twzgI3u/7n1+m1+mvCeNEu7d6SUyR6jSXLwx028u3OH9R6XVQcvKjDuWmQBNFBBxvT/tZmgO
	u7CcXe80BaIU1AlfudzSSmisnAf6lQVdIe6qMTgWx6psBAVw+SepOL7r6gBkSDlPvhrXBTBvTSN
	RtCoOBfKnKCbs766SJBA0MGS19woylB1bC7+UEi3fi9xQyEplczPgOTclnoR1Z0KQkH2L9Dr70s
	jZ5zxO/YtUM9c67Mvizw9RFOaMRzgf42w4bTtCMKFsdaNZLQm9AjQA2iJpPUp
X-Google-Smtp-Source: AGHT+IE2x4HyHjnH/ZeIJJeH+UMmHCSUVxdjs+F5FDHP+p0Oyx4UAXS76a2AoqrvQnpQxIT64HqvRQ==
X-Received: by 2002:a05:6000:4006:b0:3b6:2f9:42b1 with SMTP id ffacd0b85a97d-3b60e4d248bmr20218491f8f.13.1753174180802;
        Tue, 22 Jul 2025 01:49:40 -0700 (PDT)
Received: from [192.168.1.76] (44.248.7.51.dyn.plus.net. [51.7.248.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca487c1sm12841582f8f.41.2025.07.22.01.49.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 01:49:40 -0700 (PDT)
Message-ID: <054308ba-bad7-4e61-a11d-34f041399543@gmail.com>
Date: Tue, 22 Jul 2025 09:49:38 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: James Pearson <jcpearson@gmail.com>
Subject: Re-exporting NFS shares with a generated fsid as a UUID?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've been experimenting with re-exporting NFS shares and using the 
external fsidd service via the 'reexport' option - which all seems to 
work OK

As it is possible to use a UUID as a fsid for an export, would it 
possible to allow an automatically generated fsid as a UUID - i.e. 
instead of talking to an external service to provide a fsid, just 
generate a UUID which would be a hash (of some kind) of the exported 
path ? i.e. no need to use an external database to supply a consistent 
fsid ?

Thanks

James Pearson



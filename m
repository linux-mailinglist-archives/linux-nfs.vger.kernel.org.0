Return-Path: <linux-nfs+bounces-16968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48643CA9D9A
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 02:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 239F730268AB
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 01:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95523BD13;
	Sat,  6 Dec 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="COjg6Hlh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7292192590
	for <linux-nfs@vger.kernel.org>; Sat,  6 Dec 2025 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764984772; cv=none; b=Np5wra1mZUL5tmeFJewtWQ4TB5Y8Zfvq1Z2Enzhm0lYUfhzPzKOc05w8BTXcG+ckFLKLSm3jXBPbGzJubcEBFMQTk3ET2F0JbCoGJ4gowP2/uKQ5RNazmBK+fq+3D+kCJ7vnxv+YB5GVaNIKo2Rp+cIvomkXE/zGuqovZcmryVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764984772; c=relaxed/simple;
	bh=G3uWtlYMhc/P42nV1aFlBObMwMb7uHpwWh/Lw8T8hY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RomAAUzid/TlkEHQhTUByI2LPcLdrePOLTSxWtzTJLFcZmxhwmItIl/RIJfPy+8wNYRqRdM7m9gF6VB00jUh3BTYDzVCmZy5HV1nvfedNdoPOQDSR8m5t3jUewnsDAexWSV4ySOXa+uF2ot+RrAeGCIKzgtX0sLCtK6qI9zxXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=COjg6Hlh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso4697376a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 05 Dec 2025 17:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764984769; x=1765589569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hE0FG+S9Az3jU7SddvjaG88pIGPfxI7jbwuXxfqu+w4=;
        b=COjg6Hlh1G5IUpRRkWhBgjlhiKFihnytRebT7TBqQUnSD8K53+V3DRyOBfbOpKP5sP
         POVPkE/SpsTt4NDrTf/dMPeiHQj9Ph963sZKgeC5NNe7hQToS3qHlWglICE2vyahB00G
         /05f3I+SoTaM2i4+y6hKKI9biZ+CZjUp8Jfk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764984769; x=1765589569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hE0FG+S9Az3jU7SddvjaG88pIGPfxI7jbwuXxfqu+w4=;
        b=glNkk8+l7BU2eBhm7oMAYF2yFUvVm+8ItyWKpQy7QaVr+Kn3VwlZAuRKIc+6MO8Eg0
         MkI81gzI25vi5T1cNH5u7wStyROKgfS+IE2Bpl3Gn+kYN6fauWxKyrClDTvp2t4azlyi
         utDiVm/ZsFTOLAJthsNk2dDEJodZY9JpNsm5OiBzROM+KQPwfSuZkvdN8bVlGoOYTClz
         NK9NvBV1xjhK4dSVyfWg9EUPu+T5+xgFnNvKj2WUI6jnPzo4gnIMcagvU+DW4jZL9gdE
         sqD0Xv100LUBSG/WGtigR1wAcOY8WTZn/ouTCi8Eyr7iByv+Pce/0m6z9dvDYQauXHmN
         q1wg==
X-Forwarded-Encrypted: i=1; AJvYcCU3p9Ab/rpQDKlrqYasV25im8rUjVCiD6vNUm+3B2WbHan3Aq8a0vT5QvCmXzEAqYuT+f/Mqf5VEqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPnFFaVBu0KeHGQhqE8+sv9NLTv9Gc+cGubRwNXwnvOXj5JBeR
	Xh5QHufuUOou/IkKDwIOxpLWZBkaUzjU7lKm8UR89lNWyuW066hqDhlnmi8QzCon5c9eNgqfBK2
	59FurOBIWuQ==
X-Gm-Gg: ASbGncvDGhPEr0yXds7AyAuVj3AKibZX6MWfvGaiF54X28L5fJJPaMgPOywZrAmYbUY
	VTLX8jW0oVF9oVyFY0mYpAfKfdTsn+fOvc2Jc0HjOdWmH9tu2/R2Ktsf3pAhsIQzrx5mpRuv4Nf
	FhRQo5bEtuA1q6Hj3mT0kX3VI4UcE+va2ZLr1Sev6PE4bqvcHmrqmPf3qu1RwPXjER5nUeplz28
	O6NaQVgX0WyvKc2kxgxm/4vU7MOd0PN+/+aTOK9A5z0AYoRp1WkEpPPi0jS+WwxOFXTRJWu7DkQ
	oCfS9xCEcwIYbcM998okI3g5q2GjGmt6hro7lr+RmpGmGHCy9NPAZpN5+kqM4VDVXKXmdNmNk5v
	DV5TJa0QspWIrYqDsP01z3Q8dS+8RtGKXIH8UUYVMDEJJAY99bifzRPIYKXwLX11POvL3mV5wLY
	WaemPziO1IY1H9hygtGuxZ8SBNN0pwhfLvAxaHlZZIYZeUPNKbyqEtDxTHLYxx
X-Google-Smtp-Source: AGHT+IFuhNCWQxrcxiYYTqoou+Y6Pzlp0qERLBH25Wcpt21kqTBPY+dE1/gNZSBEs5cWdfnBeIobUw==
X-Received: by 2002:a17:907:98a:b0:b79:e99d:913b with SMTP id a640c23a62f3a-b7a247f96acmr111460766b.54.1764984768777;
        Fri, 05 Dec 2025 17:32:48 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f44d3db6sm501711266b.29.2025.12.05.17.32.48
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 17:32:48 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so4494112a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Dec 2025 17:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVs2D7kIahZtnK8Bp+81+dhDpfiKBVPjRL6/E3Vv3Y/R5aEIA/ZddKJ7iUvvnhY17Q0gd3P04NRr8g=@vger.kernel.org
X-Received: by 2002:a05:6402:2694:b0:63c:eb6:65e8 with SMTP id
 4fb4d7f45d1cf-6491ade9325mr748559a12.30.1764984767729; Fri, 05 Dec 2025
 17:32:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205111942.4150b06f@canb.auug.org.au> <aTIwhhOF847CcQGl@kernel.org>
 <64034c4b052649773272c6fa9c3c929e28ecd40d.camel@kernel.org> <aTN6d0Qkh3WKt796@kernel.org>
In-Reply-To: <aTN6d0Qkh3WKt796@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 17:32:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh58ZKQTC1iogoMy+Rj+gOuSQM_r2jT3NKD_jiiLyvU8Q@mail.gmail.com>
X-Gm-Features: AQt7F2pT-Vjocf-DHhK60Z-euiFVzVF-nK7kKTkBpeaXu3ebyxYzh2idgSlRfKU
Message-ID: <CAHk-=wh58ZKQTC1iogoMy+Rj+gOuSQM_r2jT3NKD_jiiLyvU8Q@mail.gmail.com>
Subject: Re: [6.19 PATCH] nfs/localio: fix regression due to out-of-order
 __put_cred [was: Re: linux-next: manual merge of the nfs tree with Linus' tree]
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 16:36, Mike Snitzer <snitzer@kernel.org> wrote:
>
> Or Linus picks up my patch directly but first adjusts its tags?

Let me do that once I finish my "merge various architecture updates".
I'm almost done with that side - just one more SoC pull to go, I htink
- and can go back to looking at filesystem changes.

             Linus


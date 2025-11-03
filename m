Return-Path: <linux-nfs+bounces-15983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7FC2E5DF
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 00:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96D9B34A3F8
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCDE2FABFF;
	Mon,  3 Nov 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YM/vBNLf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4082FC037
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211090; cv=none; b=SKP+wdTSAFt44SjCdMklwQ9tDD92APGQge5JSMRrhTnA72kRmVUcf2QTlyEW1tvw0RsWhZB9xJjNn92EW14yC4Dw6y+T0ftZXKVsM9zW/xoAvaW8i94SHNBbDGhG8KkcQf2r74vSKVd/PQaCrt9Oiug4XLUl7NLp/xRSIe+2yMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211090; c=relaxed/simple;
	bh=qFJb3QTz/3jg/L6x2lbG2psgJfjIQh5q1KW1+nPPaBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2QBXwAFfQCDt6nUR3Ttqhr7ijuK5cGdly/j3K4fQW/6RRwyBiAnoYqYuWEAhKAiKkRliXe96mHZ+lK1CcK1DX58hdaje+gbZHjJPNRQMke/rdL8pEuVpCwelRISK7PJkR8VV1buPzcJuqJWgW2/aE3+ijQmRhM68GUbQW0zXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YM/vBNLf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b70fb7b531cso232822066b.2
        for <linux-nfs@vger.kernel.org>; Mon, 03 Nov 2025 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762211086; x=1762815886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=YM/vBNLfGZhALocJlfoM6aqdmbn5u8aYcjTXacwZOFqpL3l5z8OuzQs6K2rZ842TQq
         JDUFj37ukjeLXKuhviMAaY+wo1sBiAhilUnarZzwRPT0jgmXXWP8ZMmsSwdqGyzz6RnZ
         yxZ7p0axNYKHN/OuxGRYqE0I0tFcS69gd7FaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211086; x=1762815886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=bpAV1QIGgKXfZ3OzS4WzWdmyXAcz6xceHBf6bBdwGoLKOtMEC6WlAxPP8BZdRrMzZU
         ccght06W6dQ8EQETgMFwEu93IHGo4Dsc9fsyZ7aIxdesv0WXJP9pyeMWx79vaWki1KM6
         4cxOi2smS//BNq5DukF7/qxtMxEVOKE11q02ILh3XKSzhuB+Qpaq9XWHOUgSFCtHF4R9
         OxegR7+6kbbc8tuZOYF51vuwX+zcx6gjDQF/lfFZ6/PTpbBqgzmdgg1qRUcHZ8eUOxVc
         7Z8KTW2Y519+UlmpYbFPWHshiuB7SqLUcTdGBn3HzDw+oQ4bF2Re+hgjhUCh1MxmCeNA
         WWrA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSqvJFhxQZiQIznoY7I2KiC+pPReaRBOGzli3wzPSh/45gMWJfYKwiQBqJ4IewTAIJrd+rcU3LTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTKE5Ln4PR741mQBJ9c4VMxYGXDLP0Vkftbi9wYL0do9FMnmE
	OrgHgUgAWYe0FqnwOQhzBZEyuzHrWB1xt53E+3BwrHO9KDHoxEq3ZZGCuqAc9PqL48XBLMmNlR/
	7k28JUIV0Cw==
X-Gm-Gg: ASbGncubRIlbir3n5/fR22x9YavT+lY9r8oHgaRGHyiYWxDtTTRI8EDHOMlQcqcapxu
	8t4E9wmDhyxnWkJDDhzBd8sIu6MxvvYne3EEA3MyAo1RGQPCtTk+BTnJEh2QC/1SEgtLnrLRCqE
	d6211DQ5fXrJOEgcWk+F01bmBayB/+QnOGxcQnbWvEi3X1FandMr7FkPOoJv8+qp/c88hMbAnAY
	9hPuCjHNnGM3FZMuPUXEJmj9nMPuizuYbs2752CdNzFp4ZrrBDi6GrEnT8aUbWD8Wnhvtpp4ozO
	NRW/btHuG4Vo81r2O666zrhP9QsqauDvn1zjxyJ4NLk8p39uSEDBGHL9nJJkhjYTaFRkET9yLev
	9eYmPvt7lMW37/G0QbEPezyhMApyStv3RURgPdHdTRxEPSXC21AqPuDkjTeGHiO/A9SgdP2BO7O
	OHyhk7Dv05FnecIZLLEy2ap1usY6rvlRaaOmSX7WANjf9rMuVtP0/RBzF8ihnI
X-Google-Smtp-Source: AGHT+IHPZYl2zXSHyYQo8bYZyt2i7tPMPyvO3iuF0+aBI15oBpZ5olZW2znbUgudQ468N7lszDa3Yw==
X-Received: by 2002:a17:906:6a21:b0:b6d:7d27:258b with SMTP id a640c23a62f3a-b70700d34b3mr1512652066b.12.1762211086400;
        Mon, 03 Nov 2025 15:04:46 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f9b7csm33491466b.21.2025.11.03.15.04.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:04:44 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4aed12cea3so892266466b.1
        for <linux-nfs@vger.kernel.org>; Mon, 03 Nov 2025 15:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWP9Ek8tGKhnRJgJu9U89vmF4JOqqCWo9d6HKoVa8PqsgiYc/aWJnZ3YPEWfO4kaK9zS+J3LpO+DiI=@vger.kernel.org
X-Received: by 2002:a17:907:1c28:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b710854688emr499540366b.56.1762211084280; Mon, 03 Nov 2025
 15:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 08:04:28 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
X-Gm-Features: AWmQ_bmQaBgs1Hs2Yx75LVx_L0plRwfdpBhmjm5wyWf-G7aoJOGX7gmwXWEf8f8
Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
>
>         /* Perform file operations on behalf of whoever enabled accounting */
> -       cred = override_creds(file->f_cred);
> -
> +       with_creds(file->f_cred);

I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
have this version at all.

Most of the cases want that anyway, and the couple of plain
"with_creds()" cases look like they would only be cleaned up by making
the cred scoping more explicit.

What do you think?

Anyway, I approve of the whole series, obviously, I just suspect we
could narrow down the new interface a bit more.

                Linus


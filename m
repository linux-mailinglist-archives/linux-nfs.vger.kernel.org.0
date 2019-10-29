Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7883DE8217
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2019 08:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfJ2HVA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Oct 2019 03:21:00 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54012 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbfJ2HVA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Oct 2019 03:21:00 -0400
Received: by mail-wm1-f51.google.com with SMTP id n7so1339506wmc.3
        for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2019 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wrfy7js4FwmYN6ZihrGV2KaC+O7OtZPGaMjEZ8LuzXg=;
        b=MfHxHShNsnjl642jTif3Mjn4v6qE1BLbZ0h1V1gDW4MvjktWrqxVq27I+koHKFI0pc
         IWH/HC7n2aZI2IJt9cgVr0OWsBYsXVWz3iYimxEx9PkfuWw7Cxi6aQ/MNzRKqnkvT4/6
         7ZJ9y6Bji1ME/PflVS140IUHdscrw+1z7Lrh8OEGuOMtyVZIqTsIKAv7L3EF8rZ/eoeV
         axv0gGaaHPqJ0W+mfj7lzgIO8FNXP3m2hz4sefPfKjeW1mzGPoh/LdLQ9pbOLyGXp+KN
         6oLmRSkHCC4gYkrwOGyLPgGmBsE29NVY/mxa5THGJBXp2RDACG/IHqey/dCW8D6zl2UC
         2XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wrfy7js4FwmYN6ZihrGV2KaC+O7OtZPGaMjEZ8LuzXg=;
        b=rdXxNAZU1OfZhlIcg5Esly66AIU1IJL6LwFquuZxG4eLOtQeojtgaPq9jCWuTJWLnT
         WoKDR+ymcqvG0J5e25NmWzRdkci5sAx1L9I80boJgWvtZ8FGoMf/zDosUa7i4q+We54l
         dH+jEOJ6Np2Wz1PESK5kzLWPns0bya3O2hkIWQo6vX8HGCA2kuFTB6lF7/mi/9pJfzjv
         uF4cOVnrrArSnlMg6C7cuHfQ92blc+smf3Jtdg62BR+qYFcm4yftFSN50/EiXhgGrWL2
         7G2OYrL2RB9ov4sX47ieak+bQdWNPXO5/6czIX+L6/qi0PfV3nn9PiNR8F3L66lcAnGW
         l/rQ==
X-Gm-Message-State: APjAAAU1AM19gA9cFUWeeyMujfDGljn25Q5hKr8vMU7usoYp8WrfG5c9
        Ju2DaoLEY7IdTYCHcnzyVTgAUpawq+1vcIhuvxfwKA==
X-Google-Smtp-Source: APXvYqzHocZL5dmbz3Yk7aoCoTDQgMETfbPUpOar3yRMQcYiUq0PnymllNHhFXFnzYz9YyaBUc2BIza4w5jymfywS0s=
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr2412902wml.110.1572333658079;
 Tue, 29 Oct 2019 00:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <CANpxKHHAngJWaW0uiOfUnBCi2Tv36h33dVg8pAuAmMcbnYzzJQ@mail.gmail.com>
 <1589957450.8701645.1572273893609.JavaMail.zimbra@desy.de>
In-Reply-To: <1589957450.8701645.1572273893609.JavaMail.zimbra@desy.de>
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Tue, 29 Oct 2019 14:19:28 +0700
Message-ID: <CANpxKHFXgM2nuZ9WEME_XA08U0xWDV5SQuS1Vy3cx4=_vS6oeQ@mail.gmail.com>
Subject: Re: NFS latency and throughput minimum requirement
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tigran,

Thanks a lot for your advice. I will try to find out the bottlenecks first.

Brs,
Naruto

On Mon, 28 Oct 2019 at 21:44, Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
> Hi Naruto,
>
> NFS performance is a function with multiple variables:
>
>   - CPU
>   - kernel
>   - TCP
>   - Networks
>   - Disk subsystem
>   - File system
>
> and every component has it's own set of knobs to turn...
>
> I will inter the question: What is expected latency and throughput
> of your applications? Can you identify the bottlenecks? At the best
> try to reproduce the load with application itself or fio and then
> go one-by-one and tweak the performance.
>
> Regards,
>    Tigran.
>
> ----- Original Message -----
> > From: "Naruto Nguyen" <narutonguyen2018@gmail.com>
> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Sent: Monday, October 28, 2019 6:25:24 AM
> > Subject: NFS latency and throughput minimum requirement
>
> > Hi everyone,
> >
> > Could you please advice me how to identify the minimum NFS requirement
> > of latency and throughput on a specific system? I have some test cases
> > to test performance of NFS and tune the system to have better NFS
> > performance but I do not know how good or bad with my
> > measurement/result.
> >
> > Thanks,
> > Brs,
> > Naruto

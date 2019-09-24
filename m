Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3BBCA4F
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2019 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbfIXOf6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Sep 2019 10:35:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389297AbfIXOf6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Sep 2019 10:35:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so2221655wrv.13
        for <linux-nfs@vger.kernel.org>; Tue, 24 Sep 2019 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=TAxv+F8ao5yasBXHfcdbM07jY5epeXu7cxiyNZY/at0=;
        b=bLT1uGBD7s7JmyEubuyThZTkl2TNDKTiUXiei7Gf5dCuTm4w2jH5Vql0ZQjRmD9wRC
         ZdL0lGl1BxAs6J7trXh3dIe79fIZpHvzNBnuFgggGn5cZ14GgNRO6s99k3ZY6UTOil41
         YAnwOGde0n6l9+vsLr8zZUnp8zrxZSOhrsiHdTdHeCPI+82yEqAOqvpJhjjO4S2WanfA
         /1p5YFvXK9gkQYgfPIrfvEsmVB1Anv+9v9pJ85q3lPVNj5mPcfjM82OUeo+ArJUXYUW5
         nFxv89rv7oACPaXjGTx7Oimh9wOPfkovK5Lx7gj1LGEItHciODWtgGHF5W4bWKD1jaTg
         9pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=TAxv+F8ao5yasBXHfcdbM07jY5epeXu7cxiyNZY/at0=;
        b=hXcMm9uBQ0U3YosBUI01lp0GpVNVr1p6FXRUf8zVYYRCCRzuy4ffbKhdbfn5JF9OXg
         k3yftkndFpWklNkzTdu/ggJ2NkaQPQ0QyaTBW92JtE68YZJpr3DLlrcSlpbbsZSa3LdU
         ucFLD7IHZ26M1+wflURdoq/iztMJ+yiplzad2N4opS7wRAXZiWViJDQnoTf22I7CRvyu
         sYIzeTWDjzJM1L0c69WuxiTpqtsk4gU4CEAIGPf0t6VH+0PaC7yfEUNv23XNQVlFL27w
         85IrpKhDXSstSwcNrO7l90xbRykO0wT5fZcyi/JuH8MxVeOi6GzuG8T0LeVnM66rJl4C
         QGnA==
X-Gm-Message-State: APjAAAUQNficuiymb9F4GtZMvCxJu7TnZy+T1S/Ea1oYnRCG4kZj86Kk
        zQDsqSJGl7jdNTkhhrDUDZz0Y3vnPz0=
X-Google-Smtp-Source: APXvYqxWPn3SuCeXfWU/N0EyY8ooXxbc5qZUohID/JPpRb+YP9RmsQcZ6dKptm9KSKPXFIlEheTFjg==
X-Received: by 2002:a5d:5290:: with SMTP id c16mr239757wrv.381.1569335756061;
        Tue, 24 Sep 2019 07:35:56 -0700 (PDT)
Received: from alyakaslap ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id f18sm1409654wrv.38.2019.09.24.07.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 07:35:55 -0700 (PDT)
Message-ID: <E56C54EA2A0F476298016AD6C5A77AF7@alyakaslap>
From:   "Alex Lyakas" <alex@zadara.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     <linux-nfs@vger.kernel.org>, "Shyam Kaushik" <shyam@zadara.com>
References: <1567518908-1720-1-git-send-email-alex@zadara.com> <20190906161236.GF17204@fieldses.org> <CAOcd+r0GRaXP3bes2xw6CFJmPJDTfAAMB7j6G3gzCVKDTC8Sgw@mail.gmail.com> <20190910202533.GC26695@fieldses.org> <8F0FAB980E6F4594A8C61D927FE022E5@alyakaslap> <20190923162539.GC1228@fieldses.org>
In-Reply-To: <20190923162539.GC1228@fieldses.org>
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of a particular local filesystem
Date:   Tue, 24 Sep 2019 17:35:53 +0300
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce,

All client mount points look like:
10.2.7.22:/export/s1 /mnt/s1 nfs4 
rw,noatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=10.2.7.102,local_lock=none,addr=10.2.7.22 
0 0

So I believe these are all 4.0. The client and the server are in the same 
subnet, without any NAT or firewalls.

Thanks,
Alex.


-----Original Message----- 
From: J. Bruce Fields
Sent: Monday, September 23, 2019 7:25 PM
To: Alex Lyakas
Cc: linux-nfs@vger.kernel.org ; Shyam Kaushik
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of 
a particular local filesystem

On Sun, Sep 22, 2019 at 09:52:36AM +0300, Alex Lyakas wrote:
> I do see in the code that a delegation stateid also holds an open
> file on the file system. In my experiments, however, the
> nfs4_client::cl_delegations list was always empty. I put an extra
> print to print a warning if it's not, but did not hit this.

Do you know what version of NFS the clients are using?  (4.0, 4.1, 4.2?)

--b.

>
> Thanks,
> Alex.
>
>
>
> -----Original Message----- From: J. Bruce Fields
> Sent: Tuesday, September 10, 2019 11:25 PM
> To: Alex Lyakas
> Cc: linux-nfs@vger.kernel.org ; Shyam Kaushik
> Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release
> stateids of a particular local filesystem
>
> On Tue, Sep 10, 2019 at 10:00:24PM +0300, Alex Lyakas wrote:
> >I addressed your comments, and ran the patch through checkpatch.pl.
> >Patch v2 is on its way.
>
> Thanks for the revision!  I need to spend the next week or so catching
> up on some other review and then I'll get back to this.
>
> For now:
>
> >On Fri, Sep 6, 2019 at 7:12 PM J. Bruce Fields
> ><bfields@fieldses.org> wrote:
> >> You'll want to cover delegations as well.  And probably pNFS layouts.
> >> It'd be OK to do that incrementally in followup patches.
> >Unfortunately, I don't have much understanding of what these are, and
> >how to cover them)
>
> Delegations are give the client the right to cache files across opens.
> I'm a little surprised your patches are working for you without handling
> delegations.  There may be something about your environment that's
> preventing delegations from being given out.  In the NFSv4.0 case they
> require the server to make a tcp connection back the client, which is
> easy blocked by firewalls or NAT.  Might be worth testing with v4.1 or
> 4.2.
>
> Anyway, so we probably also want to walk the client's dl_perclnt list
> and look for matching files.
>
> --b. 


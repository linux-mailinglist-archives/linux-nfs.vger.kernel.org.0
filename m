Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7711404B
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Dec 2019 12:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfLELrP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Dec 2019 06:47:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53464 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLELrP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Dec 2019 06:47:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id n9so2845869wmd.3
        for <linux-nfs@vger.kernel.org>; Thu, 05 Dec 2019 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:from:to:cc:references:in-reply-to:subject:date
         :mime-version:content-transfer-encoding:importance;
        bh=17f+avkYlvW1URy6TWVBmukX+4l49eIsdCm3AnMTr4Q=;
        b=EiNGF6/vpirF2kyGM9WGgCsCvVaVy7oSfBgjHC1dw0x+3zAH3lPGSOEv20oz2OOpGI
         0DHyQWhn9Auc2EmgvRYeor7D0gQ58OinSbmVp2b9INFXef+50mpLY1x1LUTK50WBlsAD
         bxkdi+3wY4+Lt3j3Lrmf2HpVwJSjbP/X4Si75uxf91UMdqkxSrhP7UycC4EgDZNa+/2Z
         epYT3UOdMu7tYel1e+8y5iPkbNESGHbmFxGXJUAMfZRk2Es6bzrPdPMre6gFcc8eAg7F
         E7cdJEvDzLGGOA2c9Djq/cMhl/gU64XUSBGKDngq/GdSHCsO9hescT9ldU/Sh/at83JN
         Xnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=17f+avkYlvW1URy6TWVBmukX+4l49eIsdCm3AnMTr4Q=;
        b=BLGAr9fyDMc7SQjAPbTjtC+roMsQJ3DGm/k+u9Pls33uKqxBfJHAGX7ZxbYX/lWXfq
         w97b9MbKQwlvjjCinlffuTx4NFvLjy66SDt8FgXvq+WrRDYCmmsDunRJJKlkyg3oSmMU
         2zMKdPOOeKt7IqyYJWcIRbtyJKjAfQLBeQhcJIGf6XLOHkNyuVG0n04NYSdR/FAXdUWR
         74mki9Kj2rPE/iSA37zBP57AjejRNnCnhccPvJgvdTzKJJ0blONkzwi40aSukC11eB5z
         qFDkzbvVyCz5gybK1oqBphVDowruPs49QS0++ylTYyhLswKHvWarKEMq8q2t9HPbzswD
         DAKw==
X-Gm-Message-State: APjAAAVQdKH2KwGYFovOjSUuMYiN08vtw4J10fmvGdJyDYDHLMouFold
        2YuONNsa0LCQmKJ4/8/Hl+tyPdKfCTE=
X-Google-Smtp-Source: APXvYqxvfuAxJwlwORWJ5mkYXTAJt2ELdJQnx3xLVq/vmxM95G9uze0jJloBKhCPYEgCPBpvAdpbcA==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr4639247wmi.118.1575546432573;
        Thu, 05 Dec 2019 03:47:12 -0800 (PST)
Received: from alyakaslap ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id t5sm12085848wrr.35.2019.12.05.03.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 03:47:11 -0800 (PST)
Message-ID: <1D90658865CE4379A951E464008D872E@alyakaslap>
From:   "Alex Lyakas" <alex@zadara.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     <linux-nfs@vger.kernel.org>
References: <1567518908-1720-1-git-send-email-alex@zadara.com> <20190906161236.GF17204@fieldses.org> <CAOcd+r0GRaXP3bes2xw6CFJmPJDTfAAMB7j6G3gzCVKDTC8Sgw@mail.gmail.com> <20190910202533.GC26695@fieldses.org>
In-Reply-To: <20190910202533.GC26695@fieldses.org>
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of a particular local filesystem
Date:   Thu, 5 Dec 2019 13:47:09 +0200
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

Have you had a chance to review the V2 of the patch?

Thanks,
Alex.


-----Original Message----- 
From: J. Bruce Fields
Sent: Tuesday, September 10, 2019 11:25 PM
To: Alex Lyakas
Cc: linux-nfs@vger.kernel.org ; Shyam Kaushik
Subject: Re: [RFC-PATCH] nfsd: provide a procfs entry to release stateids of 
a particular local filesystem

On Tue, Sep 10, 2019 at 10:00:24PM +0300, Alex Lyakas wrote:
> I addressed your comments, and ran the patch through checkpatch.pl.
> Patch v2 is on its way.

Thanks for the revision!  I need to spend the next week or so catching
up on some other review and then I'll get back to this.

For now:

> On Fri, Sep 6, 2019 at 7:12 PM J. Bruce Fields <bfields@fieldses.org> 
> wrote:
> > You'll want to cover delegations as well.  And probably pNFS layouts.
> > It'd be OK to do that incrementally in followup patches.
> Unfortunately, I don't have much understanding of what these are, and
> how to cover them)

Delegations are give the client the right to cache files across opens.
I'm a little surprised your patches are working for you without handling
delegations.  There may be something about your environment that's
preventing delegations from being given out.  In the NFSv4.0 case they
require the server to make a tcp connection back the client, which is
easy blocked by firewalls or NAT.  Might be worth testing with v4.1 or
4.2.

Anyway, so we probably also want to walk the client's dl_perclnt list
and look for matching files.

--b. 


Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B53B2192EEF
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 18:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCYRKo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 13:10:44 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45892 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYRKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 13:10:44 -0400
Received: by mail-lj1-f176.google.com with SMTP id t17so3277657ljc.12
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2020 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyOw/sVjEUWXD/Z3R8u4E7+CugSF36Fv91Xhco6mKWM=;
        b=i2rDc/hV3ghedWDs5eS2LGhwBDn9T/6TegHuPjJm8VqQ7Xsx0mHcNB/KybxbwrGOc8
         ZM7OgJGS0sFUL+DQPyaMxZO5hp2C9u0oU3ffcfFN2gWEbG6QA6SjEnZti9i2ZyOwFQbF
         297PftKboA3uSoqm85idku96YtuZ5xmfbtYxfGBzxX9Pn017t/rgiTFGA4fbU98BMUeH
         fEJ6eOV4a9ekhh2Qw/hXMG4KoZR4BRivsxYUGqlS0KcnGvpprBMWvmEvui4RbbmIBirz
         j+4w5gFUoYDwfdym6mdgFFIEHL5zdEl9qLoyrqLlRgV5mOwWYO0MofVweRCd3WZHpUsU
         U+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyOw/sVjEUWXD/Z3R8u4E7+CugSF36Fv91Xhco6mKWM=;
        b=PSW70PSHu4TgC1c+5gt+mbD5q+TDoO6J7+5Mf2OZcHNrs/1GzhXGrGNPsbl/Y/kudi
         fApZVWI7rx2T89XGe65YXeem0/RsCOmrBNgHhCAcju3GZFe152s4bCSHNhGJBeH/JpI4
         PMPyidq4r5p9kfqRuFG7Qx+OSWLhJVfuAsEDYekM3EnZAQKPYTldALQHWqmFH8kuQ8xh
         FhkTtOSM96dONNttJ7G5AdvD+05hfvR+jIBPsXst/FStmfuNXf4cY55hXLu30fqKkTjU
         JJCgPPFEoGgDnZ/GfHyVRu1AwV3jacVt6/I/aS1qZVwQYLC57XEyIuu1WTzzoiHLzdU7
         N1OA==
X-Gm-Message-State: AGi0PubLoyrqPkklBFHseJ+Jb6gcoG8OW4Gx4wO+aUoNw4855na8k32F
        aWKTs5lT5yX2g1CAXB9tTWKNK75VZpknOJkjrvNUg3BO
X-Google-Smtp-Source: APiQypKt+ObBTRuwOLCuK6yGUz7A8sXNK1tPL3EbvF2PMBMZDh+gsI5rsSWGzYUAlBFatQDxr8GZLoSCB1yc1NnAisE=
X-Received: by 2002:a2e:9053:: with SMTP id n19mr2644813ljg.68.1585156242468;
 Wed, 25 Mar 2020 10:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <9932cd04adc20b73040d82c605acb0b5a24e3855.camel@hammerspace.com>
 <8B8B914C-D741-42E0-BC0C-4850635B5551@gmail.com> <CAK3fRr_=e_JzBGPH-kWW6P8tQ-ZLhOpnFkd9kgGEmDxbHzJOhA@mail.gmail.com>
 <CAN-5tyH1TNrVoxPv0hcZ5gEpeHg6MOEjYhii+GCFM7urt_q1xQ@mail.gmail.com>
In-Reply-To: <CAN-5tyH1TNrVoxPv0hcZ5gEpeHg6MOEjYhii+GCFM7urt_q1xQ@mail.gmail.com>
From:   James Pearson <jcpearson@gmail.com>
Date:   Wed, 25 Mar 2020 17:10:31 +0000
Message-ID: <CAK3fRr-BeEYdQjA14Y8oqfjXw=kkVqf2pF0vvpVkqXDqGcAZ8g@mail.gmail.com>
Subject: Re: Stuck NFSv4 mounts of Isilon filer with repeated
 NFS4ERR_STALE_CLIENTID errors
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 25 Mar 2020 at 16:09, Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Hi James,
>
> What's in your /var/log/messages on the client that's looping?

Nothing but 'nfs:server isilon not responding, still trying'

> If your network traces had some interleaved SETCLIENTIDs I would have
> said that it's possible you are hitting this RHEL7.5 problem:  Bug
> 1592911 - Fix how client ID in SETCLIENTID is constructed to prevent
> lease tempering. https://bugzilla.redhat.com/show_bug.cgi?id=1592911
> but if the only thing that you see is RENEWs then it might not be it.

It is quite possible whatever the issue is has been fixed in a more
recent RHEL/CentOS 7 kernel - we haven't (yet?) seen the issue on
machines that have been upgraded to CentOS 7.7 ...

Thanks

James

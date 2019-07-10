Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038F2645FA
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 14:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfGJMDV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 10 Jul 2019 08:03:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45101 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJMDU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 10 Jul 2019 08:03:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so1592790qkj.12
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2019 05:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=za1TJJWHzEVfDP0ks9erSkJSB7Y1Y5hh3UydmGEbjlI=;
        b=M9nuwCdQp48Fj3n/hgu2p3nIe2c1hpEZDKwDKW/COIM/PPqXZBzk9mT9+oDRRnItwk
         oft4NVTBXshwnFDSfE1hp9abZzk5UvETk/lCjUpYJQGuKSukIlvrMAONYuSrGvaU4wDf
         SvrDMMcgU9ZCYHJJF6nWSHxEfqFyn0XD4OYrusPqKTVWJoqOSflnD4TiR7kwVof6A8XG
         EqQfGcjCnAmka5v2G7ozYEwtIp2pPbyaBe7dI8z7WjacdwTnuVVXpvggMyCOK+F2/Vju
         WfSwsh5e2lEeCN3ca38GVXaY2NWSjXiUp4qfwkFcjw0wGvT9scI9vo33cyfevl1PnR3e
         6/Cg==
X-Gm-Message-State: APjAAAX2yJG5FL4cZIPIl8cOvqREi2W0ZBnO6OLpLx8C0MRgWCf6mipZ
        64/6yntR8v3MFix/hfpWGFnHucyNhcyF8RFR9SiE7wea
X-Google-Smtp-Source: APXvYqxsESNnIUkZIG9ZH4t/pQaQk43s3NOFE+kjKh0FSuIYn1XMJbPRI8WXiAwceiKR+jWQMRlJXzvCVskHcFF/5dc=
X-Received: by 2002:a37:c247:: with SMTP id j7mr18680530qkm.94.1562760199950;
 Wed, 10 Jul 2019 05:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAMeeMh9xmfwo9gY_h_9DMQeobzjXOMnC9iH=Whz=UkJeUSVq6w@mail.gmail.com>
 <676688269.16845251.1562757649858.JavaMail.zimbra@desy.de>
In-Reply-To: <676688269.16845251.1562757649858.JavaMail.zimbra@desy.de>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Wed, 10 Jul 2019 08:03:08 -0400
Message-ID: <CAMeeMh9OgCKBiFRwxvG+nWW+k6_Pq-668ZtOSr9YsKw0EsAbdw@mail.gmail.com>
Subject: Re: Request for help debugging readdirplus malfunction on NFS v3
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ah! I apologize, I've been working off of gregkh/staging.git, I
haven't tried those very promising looking patches. I'll give em a
shot and report back. Thanks!

On Wed, Jul 10, 2019 at 7:20 AM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
> Hi Dorminy,
>
> there are fixes form Trond that possibly address your issues. Did you
> have tried them?
>
> https://www.spinics.net/lists/linux-nfs/msg73754.html
>
> Regards,
>    Tigran.
>
> ----- Original Message -----
> > From: "John Dorminy" <jdorminy@redhat.com>
> > To: "linux-nfs" <linux-nfs@vger.kernel.org>
> > Sent: Wednesday, July 10, 2019 12:11:46 PM
> > Subject: Request for help debugging readdirplus malfunction on NFS v3
>
> > Greetings;
> >
> > In the lab for the group I'm in, we have three NFS servers each
> > serving different parts of our shared filesystem. However, as of
> > kernel 5.1 or so on the clients, the clients have ceased working: a
> > 'ls' on any directory within one mountpoint (the only one hosted on
> > one server) fails to show any files.
> >
> > The mount is:
> > nfs-02:/nbu1 on /p/not-backed-up type nfs
> > (rw,noatime,vers=3,rsize=65536,wsize=65536,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.19.119.4,mountvers=3,mountport=4048,mountproto=udp,local_lock=none,addr=10.19.119.4)
> >
> > Bisection on the client side indicates
> > be4c2d4723a4a637f0d1b4f7c66447141a4b3564 is the commit at which this
> > mountpoint ceases to work. `rpcdebug -m nfs -s all` results in the
> > following going to dmesg:
> > [10146.723030] NFS call  readdirplus 162
> > [10146.724908] NFS reply readdirplus: -2
> > [10146.725429] NFS: readdir(/) returns -2
> >
> > I'm somewhat out of ideas; are there other tools I should be using to
> > hunt this down, short of adding print statements? and is this a known
> > bug already?
> >
> > Thanks in advance!
> >
> > John Dorminy

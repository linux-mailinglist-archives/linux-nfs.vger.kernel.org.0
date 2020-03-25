Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E8192A75
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 14:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCYNxk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 09:53:40 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39188 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYNxk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 09:53:40 -0400
Received: by mail-lf1-f43.google.com with SMTP id j15so1840965lfk.6
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2020 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NB8mKKU9C3LmxB4ig9kwuXrsgRjVmHirGlmLXUCg9sU=;
        b=uOxmiONwoAkccQoRYlVTZcOsX/T3O+5WG8rz5RZlkFHWww2zaesJ5H0QCNPrRX+/br
         Smp4hLN0X8iHkFcPib038whdnAFLB727J7aMieJRctJGYuql4PsYokNunN2ShBpGxcG7
         FIsitsrHZl+GE7pb4WVF24Jd8Ktos9DgdQokZ9haNhHIThuKW6/SK4tm1kCIAlSkXLYS
         8z/JiissGGEUsyR5RyxNRWEVWAk68E8P8eJ69uCGEblGZiMKQ8Mt3uxDMbzCkM1Ea6Kq
         Ai4AgCATgCUmsGBq2r0YYLg7miAOEWjV0vNEpxyLADbHJoaC87ysY6SzkLmDEG3BE9w9
         +MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NB8mKKU9C3LmxB4ig9kwuXrsgRjVmHirGlmLXUCg9sU=;
        b=DnyWNrZJ9wLQi738FkO22SeAvzaHPDlQcebab1elu7CS9TZ0RcOOm4qmdhgJsqO7su
         gUtdFd9mgLlKQxdMInSAW6VBevfG4gtIGMQ9cAtJPuo7t8dRvRGwMoseipnUNSbR+fsk
         DXIPFRuVKPUrZRNb58EIVZODg06pYHaS6Genwe1fSFsQgKlPrH4WIMXsR90hFSXwk1hl
         fkEOYJdU3Ga9506uoEp1GKwvg1fS3cr/f2CpFYaLbUVmJz9qwxn7ge4R3/FkdTIeLFGD
         siWdfN8MFqPQF6Kc1phNv4kjhKpRxSvR4LBDJmDnTnfOKURWBZpYTtqagCiYMvd+S5SV
         MQNA==
X-Gm-Message-State: ANhLgQ3DIRlUz9nR5JYfxsjfvHFNtACLKnL7OU7R355He6tz5Wbk6hQA
        KnQr0T/Qttg6csw8TXQfIN+4b8M0F//vmkmD4omJEhDu
X-Google-Smtp-Source: ADFU+vsZv9WHJcNRdYBqWGj3rYpYgrDd+6cZJWQm9EClpmBwuml5WzGy+xOFqDWYa4U6tV0bwDl0TlNn7hUmSREi4/0=
X-Received: by 2002:a19:a40f:: with SMTP id q15mr2400899lfc.104.1585144417619;
 Wed, 25 Mar 2020 06:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3fRr_Yh9Ko+E3-=z6g8p0vvUA9QW+PAoQ+ct3EWya9_oxZ3w@mail.gmail.com>
 <9932cd04adc20b73040d82c605acb0b5a24e3855.camel@hammerspace.com>
In-Reply-To: <9932cd04adc20b73040d82c605acb0b5a24e3855.camel@hammerspace.com>
From:   James Pearson <jcpearson@gmail.com>
Date:   Wed, 25 Mar 2020 13:53:26 +0000
Message-ID: <CAK3fRr9BcGbKRj4PcOdQVabPS2MkUzyEXyOq+XsTjGN4VxmaCA@mail.gmail.com>
Subject: Re: Stuck NFSv4 mounts of Isilon filer with repeated
 NFS4ERR_STALE_CLIENTID errors
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 25 Mar 2020 at 12:22, Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2020-03-25 at 10:30 +0000, James Pearson wrote:
> > We're seeing a number of Linux (CentOS 7.5) clients getting nfs:
> > server isilon not responding, still trying'  from various exports
> > from
> > a Isilon
> >
> > I appreciate we're using a vendor's Linux (out-of-date) kernel and a
> > third party filer, but if anyone can give me any pointers of how to
> > debug this issue, I would be grateful (we also have a support case
> > open with the Isilon vendor)
> >
> > Running tshark on a client when this issue happens (taken several
> > hours after the issue happened), we get repeating:
> >
> >   1   12:18:11 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW
> > CID: 0xde68
> >   2   12:18:11 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call
> > In
> > 1) RENEW Status: NFS4ERR_STALE_CLIENTID
> >   4   12:18:16 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW
> > CID: 0xde68
> >   5   12:18:16 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call
> > In
> > 4) RENEW Status: NFS4ERR_STALE_CLIENTID
> >   7   12:18:21 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW
> > CID: 0xde68
> >   8   12:18:21 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call
> > In
> > 7) RENEW Status: NFS4ERR_STALE_CLIENTID
> > ...
> >
> > My knowledge of NFSv4 is sketchy, but from my (partial) reading of
> > rfc7530 shouldn't the client be sending a SETCLIENTID in response to
> > a
> > NFS4ERR_STALE_CLIENTID - which doesn't appear to be happening here?
> >
> > Although the server hasn't rebooted since the client mounted the file
> > system - so not sure what might be going on ?
> >
> > We are upgrading clients to the latest CentOS (RHEL) 7.7 to see if
> > that 'fixes' the issue - but would appreciate any other pointers
> >
>
> WAG: the clients all have the default hostname 'localhost.localdomain'
> and are using that to identify themselves in the SETCLIENTID call? If
> so, that would cause them to cancel each other's leases by declaring
> client reboots of the client with name 'localhost.localdomain'.

All the the clients have their hostname set as something like
hostname.our.domain

The Isilon has the NFSv4 domain set as 'our.domain'

Is it possible to find out (after the fact) what the host/domain name
the client used to connect to the server?

Thanks

James Pearson

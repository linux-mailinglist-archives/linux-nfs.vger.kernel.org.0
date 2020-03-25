Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E7192991
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 14:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCYNZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 09:25:23 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43131 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgCYNZW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 09:25:22 -0400
Received: by mail-il1-f195.google.com with SMTP id g15so1777603ilj.10
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2020 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gS8suFn6gQ6qy5Rw5Ri1tb2OVsUq66dcfEd3avNN7S4=;
        b=WmgfBweFFHL0jquHYgE4wlezno/Q5HDbC+HhOBel/bpZsEiIF9ssZmOvqp9kQsnLjo
         Wjj40u5d08/VMLvfBOEoGMWPHnFe9AirCHIcr5hPNz9SZjMsw8/CFoXVotlPksU2XbPE
         AZacRwi3PXe6asvwiOIbs8j5dFFPBlvWAGbTx/xSwWg++nqrz7bf+OFl9K2oFdv1mUnH
         Nj4KOmhSVw88yemB2hyHqvU8qzvm71vImriMNWuYHIENa9uRphCoOhYQH+lcHrehNjgv
         FRady9WvkKlAr/X3bCSen52QZJjTuwpszwkrZAQhY+0YN7Cl/bFQlF9uyqc6WpciapqE
         nl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gS8suFn6gQ6qy5Rw5Ri1tb2OVsUq66dcfEd3avNN7S4=;
        b=C3O8cA1shfpJDkIcLDmrubXk1+zF8JNh0Q+u0lYz89GvbZ+HB40wCMOQjjnuwz+Sv+
         1NpSoQEl8OPRahE1Sk1kfinZu1NV+qIpWqby8ycY2r/hAYYA16k1yp8NR73D4fRmy9R+
         e6BX4YftxeTAt9Hu78mL5CbcNYSe23Oe7B5uC0HXdukfshPG0mkrFZzBAMPXvFe5cpHl
         M1i/jry+2fqzDy4kKZUQTVikVeblAaFf1OZCZlAWpxhXNXVoEvtxOTP6wpQHPkAfoWf5
         vzoiTbfv/4VewhQ0y9NOZIEA85LU2zEeOK88dODcy1A2bDWAEZY931on3QgzibSQVsuO
         ekQg==
X-Gm-Message-State: ANhLgQ3f1eltPiyxWwfDmvSR4x0Q8QHjHLNXl5TJXnceimwnfEXLgWM5
        rJN9ZofRvWDj/JBC6QTWPV2TGNqc96m+rOGOglg=
X-Google-Smtp-Source: ADFU+vuEl9GOL5dZYcHbzWcIshZftnyPBHAIxakeG5UZmnl7anmDy9xDMctHuGBoTWJYTIZWDuJTMeSUBBojeCKOq+M=
X-Received: by 2002:a92:ad02:: with SMTP id w2mr3392096ilh.55.1585142720104;
 Wed, 25 Mar 2020 06:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <9932cd04adc20b73040d82c605acb0b5a24e3855.camel@hammerspace.com> <8B8B914C-D741-42E0-BC0C-4850635B5551@gmail.com>
In-Reply-To: <8B8B914C-D741-42E0-BC0C-4850635B5551@gmail.com>
From:   Kevin Vasko <kvasko@gmail.com>
Date:   Wed, 25 Mar 2020 08:25:07 -0500
Message-ID: <CAMd28E8GW6QPZF2UJ0rC6GsQCiXZzKBG=Pd7xC2o7f4Am8MufA@mail.gmail.com>
Subject: Re: Stuck NFSv4 mounts of Isilon filer with repeated
 NFS4ERR_STALE_CLIENTID errors
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jcpearson@gmail.com" <jcpearson@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

James,

Just curious are your symptoms anything similar to mine where if you
transfer a file (200MB+) to the NFS server, the transfer will just
lock up and never complete? Are you using Kerberos as well? If so...

I had a problem on a Dell Unity box where on a transfer to the NFS
server the sequence number gets out of order and it would lock up the
Dell Unity box NFS and the transfer would never complete. Dell was not
aware of this bug and they had to have engineering look at the issue.
After about 3 months they got back with and had me change two
parameters.

scv_nas ALL -parma -facility nfs -modify rpcgss.discardReplay -value 0

scv_nas ALL -parma -facility nfs -modify rpcgss.discardOld -value 0

I=E2=80=99m doubtful that this would be the same way you would change these
settings on the Isilon but just figured if it=E2=80=99s related it might he=
lp.

-Kevin

On Wed, Mar 25, 2020 at 8:20 AM Kevin Vasko <kvasko@gmail.com> wrote:
>
> James,
>
> Just curious are your symptoms anything similar to mine where if you tran=
sfer a file (200MB+) to the NFS server, the transfer will just lock up and =
never complete? Are you using Kerberos as well? If so...
>
> I had a problem on a Dell Unity box where on a transfer to the NFS server=
 the sequence number gets out of order and it would lock up the Dell Unity =
box NFS and the transfer would never complete.
>
> Dell was not aware of this bug and they had to have engineering look at t=
he issue. After about 3 months they got back with and had me change two par=
ameters.
>
> scv_nas ALL -parma -facility nfs -modify rpcgss.discardReplay -value 0
>
> scv_nas ALL -parma -facility nfs -modify rpcgss.discardOld -value 0
>
> I=E2=80=99m doubtful that this would be the same way you would change the=
se settings on the Isilon but just figured if it=E2=80=99s related it might=
 help.
>
> -Kevin
>
> On Mar 25, 2020, at 7:23 AM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>
> =EF=BB=BFOn Wed, 2020-03-25 at 10:30 +0000, James Pearson wrote:
>
> We're seeing a number of Linux (CentOS 7.5) clients getting nfs:
>
> server isilon not responding, still trying'  from various exports
>
> from
>
> a Isilon
>
>
> I appreciate we're using a vendor's Linux (out-of-date) kernel and a
>
> third party filer, but if anyone can give me any pointers of how to
>
> debug this issue, I would be grateful (we also have a support case
>
> open with the Isilon vendor)
>
>
> Running tshark on a client when this issue happens (taken several
>
> hours after the issue happened), we get repeating:
>
>
>  1   12:18:11 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW
>
> CID: 0xde68
>
>  2   12:18:11 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call
>
> In
>
> 1) RENEW Status: NFS4ERR_STALE_CLIENTID
>
>  4   12:18:16 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW
>
> CID: 0xde68
>
>  5   12:18:16 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call
>
> In
>
> 4) RENEW Status: NFS4ERR_STALE_CLIENTID
>
>  7   12:18:21 10.78.201.95 -> 10.78.196.184 NFS 194 V4 Call RENEW
>
> CID: 0xde68
>
>  8   12:18:21 10.78.196.184 -> 10.78.201.95 NFS 114 V4 Reply (Call
>
> In
>
> 7) RENEW Status: NFS4ERR_STALE_CLIENTID
>
> ...
>
>
> My knowledge of NFSv4 is sketchy, but from my (partial) reading of
>
> rfc7530 shouldn't the client be sending a SETCLIENTID in response to
>
> a
>
> NFS4ERR_STALE_CLIENTID - which doesn't appear to be happening here?
>
>
> Although the server hasn't rebooted since the client mounted the file
>
> system - so not sure what might be going on ?
>
>
> We are upgrading clients to the latest CentOS (RHEL) 7.7 to see if
>
> that 'fixes' the issue - but would appreciate any other pointers
>
>
>
> WAG: the clients all have the default hostname 'localhost.localdomain'
> and are using that to identify themselves in the SETCLIENTID call? If
> so, that would cause them to cancel each other's leases by declaring
> client reboots of the client with name 'localhost.localdomain'.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

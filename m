Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5E13A1624
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhFINyL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 09:54:11 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:47032 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbhFINyF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 09:54:05 -0400
Received: by mail-ej1-f45.google.com with SMTP id he7so19195667ejc.13
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTiCwEade3jvJnDPL9O08ixFnt2F7hDoNfM6M1V1SkY=;
        b=AbJXXdmmdk9iBb/BQAaYUUXI5UXcOgNoZrguPxP16uUffFuDegjwiMXD369NZfIskL
         xuJs7A3c+wwB5UeOxB4V70YZPGFUcyCc3Dio74Y/MSGYY9C7TBUvbooaLbUYxpKGCvrF
         JloQUm7U2My9E7OlKSO3mff+W2/MFLY8rsnpHH49SYGoKFuUO8A/1Li7YNENGXV8KJY8
         SBr0j5Sy4NICAPNKaeHz1xIRvFTqQz9H6yi3QN8ULhP8x2fXSPM88dlnPaMziLNWlEFD
         8aCHioeet2yEzHhfy/FxeHfr0vD/7yZHRRDdtjQvzMoaKGZBsAPn352XyY3HJX7xjLcT
         raTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTiCwEade3jvJnDPL9O08ixFnt2F7hDoNfM6M1V1SkY=;
        b=q0ScXZ3VH9VhYOxxX32zypGAYZR33tGaHBOxXvPxn/1H6ScIi/abgGR64/8AnGk6Fp
         RozDAiCzObeWtrLCW3EbGZ77yWh1j+vIJTbhoj6VOKDYvHwQYZohi+AwiFl/coIvdzXf
         WDKUbJdwH6I3p0cyadL4ylhR+Emu1hdKNCaIFU9chTT/cUCo+pDV0nT6K+KiN8Dh9Vhc
         JvqZYb/L1+hhysa0l7wHrLLikZKfK1r1WVvBG5WKmvfNjHWg7ZQBzw2fE9anmqLwnEOa
         +2/d5zEy0hI/ycB6ww4JEzweyuWeTYZ1tLqTnrOYvcFySFRW0pTa6uyxGOiDzBnmeysJ
         3OkQ==
X-Gm-Message-State: AOAM533wmSdPZFEt60LDIp3wy+Ws7UPCIT3+h7aFWfo0TGnQFw4ho+5O
        /lUAkeaW/RYvetzTA42M+R6D4pGp7w09cg6GkruQqcb99eI=
X-Google-Smtp-Source: ABdhPJwhBedfqa+QvubbM9WwpkPftIe50qhB7luZjOtrnAfbvbCx8DIXM3m5ARA9U4co6i46LXA/ILdsg1+nNdAgdfM=
X-Received: by 2002:a17:906:f117:: with SMTP id gv23mr29210554ejb.432.1623246669818;
 Wed, 09 Jun 2021 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com> <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
 <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com> <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 9 Jun 2021 09:50:58 -0400
Message-ID: <CAN-5tyFZNzyr0FBUeuOc92xiaq+52G1uyfuP3mAZbGxR+v1Rfg@mail.gmail.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Michael Wakabayashi <mwakabayashi@vmware.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Mike,

Indeed we do have discrepancy in what we are seeing because I'm not
able to see what you see. This is the case of an unreachable host (in
my traces
      mount.nfs-3400    [001] ....  1662.882880: rpc_connect_status:
task:103@2 status=-113

you provided a short tracepoint file (where the return value was -115
and that ENOTCONN reflecting that a SYN was sent). But here's my run.
Trying to capture the timing of both mounts. I start the "unreachable"
mount first and then the mount that should succeed which does without
much wait. The unreachable case times out very fast and allows for
other mounts to proceed without issues.

[aglo@localhost ~]$ date
Wed Jun  9 09:33:48 EDT 2021
[aglo@localhost ~]$ time sudo mount -o vers=4.2,sec=sys
2.2.2.2:/fake_path /scratch
mount.nfs: No route to host

real 2m12.464s
user 0m0.014s
sys 0m0.108s
[aglo@localhost ~]$ date
Wed Jun  9 09:36:18 EDT 2021

[aglo@localhost ~]$ date
Wed Jun  9 09:33:51 EDT 2021
[aglo@localhost ~]$ time sudo mount -o vers=4.2 192.168.1.110:/ /mnt

real 0m0.126s
user 0m0.017s
sys 0m0.067s
[aglo@localhost ~]$ date
Wed Jun  9 09:33:56 EDT 2021

There are no SYNs to 2.2.2.2 in my traces. So something different
about network infrastructures where in your case for some reason you
are sending something to 2.2.2.2 and the only reason I can think of is
that you have something in the ARP cache and I don't. And Alex yes I
do have an ARP entry for my default gateway but no there is no SYN
sent to the server from a different subnet.

On Wed, Jun 9, 2021 at 1:31 AM Michael Wakabayashi
<mwakabayashi@vmware.com> wrote:
>
> Hi Olga,
>
> There seems to be a discrepancy between what you're seeing and what we're seeing.
>
> So we were wondering if you can you please run these commands in your Linux environment and paste the output of the mount command below?
>     $ sudo mkdir -p /tmp/mnt.dead
>     $ time sudo mount -o vers=4 -vvv 2.2.2.2:/fake_path /tmp/mnt.dead
>
> We'd like the mount command to specifically use "2.2.2.2:/fake_path" since we know it is unreachable and outside your subnet.
> We're hoping by mounting "2.2.2.2:/fake_path" you'll be able to reproduce the same behavior that we're seeing.
>
> Also, if possible, a packet trace would be helpful:
>     $ sudo tcpdump -s 0 -w /tmp/nfsv4.pcap port 2049
>
> On my Ubuntu VirtualMachine, I see this output:
>     ubuntu@mikes-ubuntu-21-04:~$ time sudo mount -o vers=4 -vvv 2.2.2.2:/fake_path /tmp/mnt.dead
>     mount.nfs: timeout set for Wed Jun  9 05:12:15 2021
>     mount.nfs: trying text-based options 'vers=4,addr=2.2.2.2,clientaddr=10.162.132.231'
>     mount.nfs: mount(2): Connection timed out
>     mount.nfs: Connection timed out
>     real  3m1.257s
>     user  0m0.006s
>     sys 0m0.007s
>
> Thanks, Mike

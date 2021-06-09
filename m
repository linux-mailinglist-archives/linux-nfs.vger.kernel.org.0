Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B53A179A
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhFIOod (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 10:44:33 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:40632 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbhFIOob (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Jun 2021 10:44:31 -0400
Received: by mail-ej1-f47.google.com with SMTP id my49so22174955ejc.7
        for <linux-nfs@vger.kernel.org>; Wed, 09 Jun 2021 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gA4XbJcxDVOgBDeUsfWpnjZgaRUDpA3N+dFe8vzSHjw=;
        b=rjfoXizrrGMD5JDn7mNyONZHXWX97aO2E/6EhoLlf9OrZEGb25AJK8/x5dBE5FNZRD
         R6XfmundiKNm2sdEE88xijcm41JZYfiM5MuD40wl2B+wI73jIULTqzaWk+NmsRtYpatU
         e+P7nhTLO8nDQiOA7kWDy7jS7Lk+vjCz3WZwGrHQZhFd/nJ3Ue7GRz/h3bbNj1nVt6DF
         hn1wFIY91oDQmiIZQHPl1pJwpGJKbBWsZiXqeOlZ2pnca/x6dJTPneADJFInHLecj8g3
         yn58I4KuXmt5RKLr3jPoyH7RVb5XTqyO5WHtbthh9sgAcoor5/+FctzOuLSotyBwOr2e
         ksKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA4XbJcxDVOgBDeUsfWpnjZgaRUDpA3N+dFe8vzSHjw=;
        b=aPCfmSTFeMVN7/Ag09vK4ShvbL7LmDeQoCHWJh/uenZZgBZl17pC/y2RkFGEb6Pmvm
         1CNGGrtnVDiXl/thLWmrZ7ppmgV4inx+rpaGLhnwF9AigQ1EbBNPpoP5dlSE1PqfZPlq
         UFQtCRxQtG6/ochqm9n9xZnRnHyyaDgWddy/A9OPbvp3Nv7QmkC9iTInpc9lQoAzPDAL
         wtLCz3vuQcaiIAqsZDP1xFMYZztOSsIPtNZB1O5ld4lR03wbm+hyH2HnKHMnm1pUVWVb
         HK9rjAveo89Z8yS2h1q8C6amnksJvPsuDK73oeNJJN/MlXX3iADjt+Yf9um6ZCoTlMMm
         hUCw==
X-Gm-Message-State: AOAM532ttyALlPprauIWG8JW+e+YerQ4oh/Vb2bfmAcqxaSXI3rxblFO
        jn4eOc7EFUj/3AxjXZl+56evjcDDO6J85XDLkyE=
X-Google-Smtp-Source: ABdhPJzvY/YEb0SGyDFl0JK0ncseT2uG581RvLDmrLvxY4KAVqki4x0YzryS+6rzEr17R0V7uQAUGnER0oAlJT1Fi9M=
X-Received: by 2002:a17:906:15c2:: with SMTP id l2mr222676ejd.348.1623249681487;
 Wed, 09 Jun 2021 07:41:21 -0700 (PDT)
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
 <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
 <CO1PR05MB81011A1297BCA22C772AF836B7369@CO1PR05MB8101.namprd05.prod.outlook.com>
 <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>
In-Reply-To: <FCDAEE4A-33CB-4939-8001-DAAFD7BC8638@redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 9 Jun 2021 10:41:10 -0400
Message-ID: <CAN-5tyF4fsfeuzcbXzyWNfQ3wSx2WDxMtyk+dPUdd7H4nJ8hug@mail.gmail.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Michael Wakabayashi <mwakabayashi@vmware.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Steve Dickson <SteveD@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 9, 2021 at 10:31 AM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> On 9 Jun 2021, at 1:31, Michael Wakabayashi wrote:
>
> > Hi Olga,
> >
> > There seems to be a discrepancy between what you're seeing and what
> > we're seeing.
> >
> > So we were wondering if you can you please run these commands in your
> > Linux environment and paste the output of the mount command below?
> >     $ sudo mkdir -p /tmp/mnt.dead
> >     $ time sudo mount -o vers=4 -vvv 2.2.2.2:/fake_path /tmp/mnt.dead
> >
> > We'd like the mount command to specifically use "2.2.2.2:/fake_path"
> > since we know it is unreachable and outside your subnet.
> > We're hoping by mounting "2.2.2.2:/fake_path" you'll be able to
> > reproduce the same behavior that we're seeing.
> >
> > Also, if possible, a packet trace would be helpful:
> >     $ sudo tcpdump -s 0 -w /tmp/nfsv4.pcap port 2049
> >
> > On my Ubuntu VirtualMachine, I see this output:
> >     ubuntu@mikes-ubuntu-21-04:~$ time sudo mount -o vers=4 -vvv
> > 2.2.2.2:/fake_path /tmp/mnt.dead
> >     mount.nfs: timeout set for Wed Jun  9 05:12:15 2021
> >     mount.nfs: trying text-based options
> > 'vers=4,addr=2.2.2.2,clientaddr=10.162.132.231'
> >     mount.nfs: mount(2): Connection timed out
> >     mount.nfs: Connection timed out
> >     real  3m1.257s
> >     user  0m0.006s
> >     sys 0m0.007s
> >
> > Thanks, Mike
>
> It looks to me like you and Olga are seeing the same thing, a wait
> through SYN retries scaling up from initial RTO for the number of
> tcp_syn_retries.

Ben, I disagree. Mike and I are seeing different things. Mike is
seeing SYNs being sent. I argue that SYNs should not be sent. I agree
if SYNs are sent then that would cause a problem

> It's not disputed that mounts waiting on the transport layer will block
> other mounts.
>
> It might be able to be changed:  there's this torch:
> https://lore.kernel.org/linux-nfs/87378omld4.fsf@notabene.neil.brown.name/

We already discussed that this is not a solution as the NFS layer has
to serialize the client creation attempts.

> ..or there may be another way we don't have to wait ..
>
> .. or tune tcp_syn_retries.. or RTO.. or something else (eBPF?).
>
> I think we're all strapped for time and problems like this usually get
> fixed by the folks feeling the most pain from them.

I think we are still not understanding what network setup that is
happening that leads to a client sending a SYN (which is incorrect) to
what is supposed to be an unreachable server instead of timing out
fast (because there shouldn't be an ARP entry).

Mike, can you show your arp cache info (arp -n) during your run?

>
> Ben
>

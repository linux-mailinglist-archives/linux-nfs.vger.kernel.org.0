Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B66BF64
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGQP6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 11:58:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37747 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfGQP6x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jul 2019 11:58:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so25573474otp.4
        for <linux-nfs@vger.kernel.org>; Wed, 17 Jul 2019 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=techterra-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haaTfVZICEqg58YpdqPhOsrfZkLz52t+gj2K7g+elW4=;
        b=13N+Q6Cj/zikyZEiRIFaKHnNGbpU36jSFLtvCQNR1ecGbOQ4YhCrkH1/rotLpJ+AwQ
         mz/KCWfN8kuNGfH5lM1OaCWJHCLCzlv1sfvmoSM4HbX3VjkFGCaHS5TDK6cZhq+AaHxk
         I6SmvoACwp+I9cB0pP0TxNsLIVt4hksDPADGUsAA4virEg0dIUWR5evc8ZHMCBYQlt5M
         fjEUKlelot5mx9jh6vTZR1MBbVAYgaa0zQzN17ImcRHt10TROTlZGDlmU2hte6uPHflf
         rHKGFZCTZZISQAPtL6oGevw1E/u2P6noNFBhla1vH8ATX1MelkWz+ieuMYCyFpoem51O
         QzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haaTfVZICEqg58YpdqPhOsrfZkLz52t+gj2K7g+elW4=;
        b=ONGPM2pkhBgDXDMaZjw5j2FP64q7B6IQ+RMCzB/B1FvwWpbFTOS74HWeb3NnpUjBdx
         1aK5/3HXb4sgnh5oXjcEVZnwcdO3rW69j3syxiZkG0AwkjnKyESvexpKjz6ADAA/V7qY
         lGcAU/JpJAe+vTaWtWu57q/vYA116QDaj788x9j5bGyqGmN8MvUyqQLO4mauWAZnm7+n
         utWJ85q1RhopDJtEHLXCVW49oAknp21h2Kg7RhFHQq0J5TPuhtM1w9yL8ll8B/Pj9q6Z
         fhPFjzX1UEM4X2RIUB2xPvz2nl3jsOhGwDir7cpK+tsdwTxVwJn51O8QdaRuGzuQZYCE
         FPDA==
X-Gm-Message-State: APjAAAX74DL+R1OCDV3sNDMro8PH5jIzosjvlE8cmEyKmtYQFFLJEPOt
        WGfsA24h0UhJ+5PdTNa2HUCSnK6KrxdmYYKLI14=
X-Google-Smtp-Source: APXvYqx76I6N88Gg46EQlT/Vwo7R5QA8OzvlPDP6AJIcO+HcMjDYBFcQT60LSL6v55XVgFOxtaU/d2wn5XoJ2/uzfO8=
X-Received: by 2002:a9d:3d8a:: with SMTP id l10mr28787067otc.343.1563379131191;
 Wed, 17 Jul 2019 08:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALuPYL1_rvyn9A6gZnMCE8p87WoYjsU4BuUKT2OuxXUDiumO2w@mail.gmail.com>
 <20190711164937.GA4131@coeurl.usersys.redhat.com> <CALuPYL0+VdUsjeFx70xJkJUxc8SOdsTzALeeHcfd33fx4E_iTg@mail.gmail.com>
 <20190712141657.GB4131@coeurl.usersys.redhat.com> <CALuPYL13mQDg_F4rTv2FK8SEgyS56aRnv2MgNu=KUL0W3BmhEQ@mail.gmail.com>
In-Reply-To: <CALuPYL13mQDg_F4rTv2FK8SEgyS56aRnv2MgNu=KUL0W3BmhEQ@mail.gmail.com>
From:   Indivar Nair <indivar.nair@techterra.in>
Date:   Wed, 17 Jul 2019 21:28:14 +0530
Message-ID: <CALuPYL18_n6R+_jC-DyqcP7EPRGNqSeLD8u0tcv6NNpDy5pM7Q@mail.gmail.com>
Subject: Re: rpc.statd dies because of pacemaker monitoring
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott,

Could you help me out with my query in the earlier email?
I would like to get to the root cause of the issue.
Since it is a storage system that is heavily used, I need to make sure
that the issue does not crop even after fixing the DNS.

Thanks.

Regards,


Indivar Nair

On Sat, Jul 13, 2019 at 8:31 PM Indivar Nair <indivar.nair@techterra.in> wrote:
>
> Thanks once again, Scott,
>
> The patch seems like a neat solution
> It will declare rpc.statd dead only after checking multiple times. Super.
> I will patch the nfsserver resource file.
> (It should probably be added to the original source code.)
>
> We have a proper entry for 127.0.0.1 in the hosts file and the
> nsswtich.conf file says, "files dns".
> So if it checks the /etc/hosts first, why would the pacemaker's check timeout?
> Shouldn't pacemaker get a quick response?
>
> Localhost entries in the /etc/hosts file -
> -------------------------------------------------------------------------------------------------------------------------------------
> 127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
> ::1 localhost localhost.localdomain localhost6 localhost6.localdomain6
> -------------------------------------------------------------------------------------------------------------------------------------
>
> Regards,
>
>
> Indivar Nair
>
>
>
>
>
>
> On Fri, Jul 12, 2019 at 7:47 PM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > On Fri, 12 Jul 2019, Indivar Nair wrote:
> >
> > > Hi Scott,
> > >
> > > Thanks a lot.
> > > Yes, it is a 10+ year old AD setup, which was migrated to Samba4AD
> > > (samba+named) a few years ago.
> > > It has lot of stale entries, and fwd - rev lookup mismatches.
> > >
> > > Will start cleaning up DNS right away.
> > >
> > > In the meantime, is there any way to increase the rpc ping timeout?
> >
> > You could build the rpcinfo.c program from source (it's in the rpcbind
> > git tree) with a longer timeout.
> >
> > > OR
> > > Is there any way to temporarily disable DNS lookups by lockd?
> >
> > rpc.statd is doing the DNS lookups, and no there's not a way to disable it.
> > Doing so would probably make the reboot notifications less reliable, and
> > clients wouldn't know to reclaim locks, and the risk of data corruption
> > goes up.
> >
> > You could prevent the DNS lookups from occurring by adding entries (properly
> > formatted... see the hosts(5) man page) for all your clients into the
> > /etc/hosts file on your NFS server nodes.  That's assuming that your nsswitch
> > configuration has "files" before "dns" for host lookups.  Depending on how
> > many clients you have, that might be the easiest option.
> >
> > Another option might be to try adding a simple retry mechanism to the part
> > of the nfsserver resource agent that checks rpc.statd, something like:
> >
> > diff --git a/heartbeat/nfsserver b/heartbeat/nfsserver
> > index bf59da98..c9dcc74e 100755
> > --- a/heartbeat/nfsserver
> > +++ b/heartbeat/nfsserver
> > @@ -334,8 +334,13 @@ nfsserver_systemd_monitor()
> >         fi
> >
> >         ocf_log debug "Status: rpc-statd"
> > -       rpcinfo -t localhost 100024 > /dev/null 2>&1
> > -       rc=$?
> > +       for i in `seq 1 3`; do
> > +               rpcinfo -t localhost 100024 >/dev/null 2>&1
> > +               rc=$?
> > +               if [ $rc -eq 0 ]; then
> > +                       break
> > +               fi
> > +       done
> >         if [ "$rc" -ne "0" ]; then
> >                 ocf_exit_reason "rpc-statd is not running"
> >                 return $OCF_NOT_RUNNING
> > >
> > > Regards,
> > >
> > >
> > > Indivar Nair
> > >
> > > On Thu, Jul 11, 2019 at 10:19 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > >
> > > > On Thu, 11 Jul 2019, Indivar Nair wrote:
> > > >
> > > > > Hi ...,
> > > > >
> > > > > I have a 2 node Pacemaker cluster built using CentOS 7.6.1810
> > > > > It serves files using NFS and Samba.
> > > > >
> > > > > Every 15 - 20 minutes, the rpc.statd service fails, and the whole NFS
> > > > > service is restarted.
> > > > > After investigation, it was found that the service fails after a few
> > > > > rounds of monitoring by Pacemaker.
> > > > > The Pacemaker's script runs the following command to check whether all
> > > > > the services are running -
> > > > > ---------------------------------------------------------------------------------------------------------------------------------------
> > > > >     rpcinfo > /dev/null 2>&1
> > > > >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> > > > >     nfs_exec status nfs-idmapd > $fn 2>&1
> > > > >     rpcinfo -t localhost 100024 > /dev/null 2>&1
> > > >
> > > > I would check to make sure your DNS setup is working properly.
> > > > rpc.statd uses the canonical hostnames for comparison purposes whenever
> > > > it gets an SM_MON or SM_UNMON request from lockd and when it gets an
> > > > SM_NOTIFY from a rebooted NFS client.  That involves calls to
> > > > getaddrinfo() and getnameinfo() which in turn could result in requests
> > > > to a DNS server.  rpc.statd is single-threaded, so if it's blocked
> > > > waiting for one of those requests, then it's unable to respond to the
> > > > RPC ping (which has a timeout of 10 seconds) generated by the rpcinfo
> > > > program.
> > > >
> > > > I ran into a similar scenario in the past where a client was launching
> > > > multiple instances of rpc.statd.  When the client does a v3 mount it
> > > > does a similar RPC ping (with a more aggressive timeout) to see if
> > > > rpc.statd is running... if not then it calls out to
> > > > /usr/sbin/start-statd (which in the past simply called 'exec rpc.statd
> > > > --no-notify' but now has additional checks).  Likewise rpc.statd does
> > > > it's own RPC ping to make sure there's not one already running.  It
> > > > wound up that the user had a flakey DNS server and requests were taking
> > > > over 30 seconds to time out, thus thwarting all those additional checks,
> > > > and they wound up with multiple copies of rpc.statd running.
> > > >
> > > > You could be running into a similar scenario here and pacemaker could be
> > > > deciding that rpc.statd's not running when it's actually fine.
> > > >
> > > > -Scott
> > > >
> > > > > ---------------------------------------------------------------------------------------------------------------------------------------
> > > > > The script is scheduled to check every 20 seconds.
> > > > >
> > > > > This is the message we get in the logs -
> > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > > > 127.0.0.1 ALLOWED
> > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > > > from 127.0.0.1
> > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > > > 127.0.0.1 ALLOWED (cached)
> > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > > > from 127.0.0.1
> > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > > > 127.0.0.1 ALLOWED (cached)
> > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > > > from 127.0.0.1
> > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > >
> > > > > After 10 seconds, we get his message -
> > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > > Jul 09 07:34:09 virat-nd01 nfsserver(virat-nfs-daemon)[54087]: ERROR:
> > > > > rpc-statd is not running
> > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > > Once we get this error, the NFS service is automatically restarted.
> > > > >
> > > > > "ERROR: rpc-statd is not running" message is from the pacemaker's
> > > > > monitoring script.
> > > > > I have pasted that part of the script below.
> > > > >
> > > > > I disabled monitoring and everything is working fine, since then.
> > > > >
> > > > > I cant keep the cluster monitoring disabled forever.
> > > > >
> > > > > Kindly help.
> > > > >
> > > > > Regards,
> > > > >
> > > > >
> > > > > Indivar Nair
> > > > >
> > > > > Part of the pacemaker script that does the monitoring
> > > > > (/usr/lib/ocf/resources.d/heartbeat/nfsserver)
> > > > > =======================================================================
> > > > > nfsserver_systemd_monitor()
> > > > > {
> > > > >     local threads_num
> > > > >     local rc
> > > > >     local fn
> > > > >
> > > > >     ocf_log debug "Status: rpcbind"
> > > > >     rpcinfo > /dev/null 2>&1
> > > > >     rc=$?
> > > > >     if [ "$rc" -ne "0" ]; then
> > > > >         ocf_exit_reason "rpcbind is not running"
> > > > >         return $OCF_NOT_RUNNING
> > > > >     fi
> > > > >
> > > > >     ocf_log debug "Status: nfs-mountd"
> > > > >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> > > > >     rc=$?
> > > > >     if [ "$rc" -ne "0" ]; then
> > > > >         ocf_exit_reason "nfs-mountd is not running"
> > > > >         return $OCF_NOT_RUNNING
> > > > >     fi
> > > > >
> > > > >     ocf_log debug "Status: nfs-idmapd"
> > > > >     fn=`mktemp`
> > > > >     nfs_exec status nfs-idmapd > $fn 2>&1
> > > > >     rc=$?
> > > > >     ocf_log debug "$(cat $fn)"
> > > > >     rm -f $fn
> > > > >     if [ "$rc" -ne "0" ]; then
> > > > >         ocf_exit_reason "nfs-idmapd is not running"
> > > > >         return $OCF_NOT_RUNNING
> > > > >     fi
> > > > >
> > > > >     ocf_log debug "Status: rpc-statd"
> > > > >     rpcinfo -t localhost 100024 > /dev/null 2>&1
> > > > >     rc=$?
> > > > >     if [ "$rc" -ne "0" ]; then
> > > > >         ocf_exit_reason "rpc-statd is not running"
> > > > >         return $OCF_NOT_RUNNING
> > > > >     fi
> > > > >
> > > > >     nfs_exec is-active nfs-server
> > > > >     rc=$?
> > > > >
> > > > >     # Now systemctl is-active can't detect the failure of kernel
> > > > > process like nfsd.
> > > > >     # So, if the return value of systemctl is-active is 0, check the
> > > > > threads number
> > > > >     # to make sure the process is running really.
> > > > >     # /proc/fs/nfsd/threads has the numbers of the nfsd threads.
> > > > >     if [ $rc -eq 0 ]; then
> > > > >         threads_num=`cat /proc/fs/nfsd/threads 2>/dev/null`
> > > > >         if [ $? -eq 0 ]; then
> > > > >             if [ $threads_num -gt 0 ]; then
> > > > >                 return $OCF_SUCCESS
> > > > >             else
> > > > >                 return 3
> > > > >             fi
> > > > >         else
> > > > >             return $OCF_ERR_GENERIC
> > > > >         fi
> > > > >     fi
> > > > >
> > > > >     return $rc
> > > > > }
> > > > > =======================================================================

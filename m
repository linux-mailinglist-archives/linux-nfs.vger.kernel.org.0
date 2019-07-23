Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD0F71A89
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfGWOgv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 10:36:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42457 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGWOgv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jul 2019 10:36:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so32452773oie.9
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2019 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=techterra-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5Ra7+zTIsCylSeUFj3lu6D4Y8Ah/V3ZQI5Fq0ojGm4=;
        b=FRxs2Gpa8HPdRRu5Oe+2Li2DgTk8z17azjl8ZAC4D+70s4Q5OqGM7azCIGU6kqIshb
         H/1vQH78ZyAxYpt8VIKFY1qG8d+sVO43n0mIF9b1vzCB2Xm+/GDs7SS8SzVTp3ADhgU3
         UxeMTWHU86wLKoX02B9sk2ACZb8xLwTrUSx/ueQBT+0+Vf/UKMZW4fDlbZF+5rqC69Ef
         ECj/zhzAtpUZ1QCqtcVDZcnMiw06n+hHtCg5ycr71Zg3Hftr3ZA+ObxHFTB3kSs11AiC
         wL3dMSRrBpjYMS9sMqQDAfPBDvkI47HYcsJIvefDxKMP+XfoX0g1lRjvavbV/52FDhPp
         2oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5Ra7+zTIsCylSeUFj3lu6D4Y8Ah/V3ZQI5Fq0ojGm4=;
        b=tBdIZpLx8/nb2YW1dmz+j3rbVnr+sPGzqnVEn6H82/hvWN6t4Ro2ajBE8QlZOfhasw
         gpVlrYSfUhZFpXK3ZoNyZq0eSd2rOE4wBlihTf0/brTSTZaoFgLjsk3yyU7qwHB6Ua/W
         ckYR1Y/4Q9gcXWx3GVt0udSu6Wyu01eGgymiiZ2ClIg8AvQ2Af0oS9uKxKUqUFJFq78x
         Cszl7ndZm0DGHj5Rkylx49zvnGRVKWJAKovyCt5bULf8eKl6FgleaHVhZL8IncdkQw9I
         waFDrsdfjaKYErpWjHz5+vurXmVTi5atASf/jsXxZXAV4gNKkA7QiuFUxu+uXNmYHRI9
         bRWg==
X-Gm-Message-State: APjAAAXYlNdvEQG2tAPF29xRqvsR0Eg30e+1fuZgDHYQRc0dG6vzFH01
        4eQ8G1GF5tnjoMCuVQsVRkyIPRfiZOwYnP0u59E=
X-Google-Smtp-Source: APXvYqzG2kQscLuLCyXm2Duj1mB/7xwJTXvmXpkGtGeIsiJD1UI6exWj6S747LhsU6ZcGe7VQIlPEF4mrdqn02pC6bk=
X-Received: by 2002:aca:574e:: with SMTP id l75mr36275695oib.2.1563892610011;
 Tue, 23 Jul 2019 07:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <CALuPYL1_rvyn9A6gZnMCE8p87WoYjsU4BuUKT2OuxXUDiumO2w@mail.gmail.com>
 <20190711164937.GA4131@coeurl.usersys.redhat.com> <CALuPYL0+VdUsjeFx70xJkJUxc8SOdsTzALeeHcfd33fx4E_iTg@mail.gmail.com>
 <20190712141657.GB4131@coeurl.usersys.redhat.com> <CALuPYL13mQDg_F4rTv2FK8SEgyS56aRnv2MgNu=KUL0W3BmhEQ@mail.gmail.com>
 <CALuPYL18_n6R+_jC-DyqcP7EPRGNqSeLD8u0tcv6NNpDy5pM7Q@mail.gmail.com> <20190718134341.GF4131@coeurl.usersys.redhat.com>
In-Reply-To: <20190718134341.GF4131@coeurl.usersys.redhat.com>
From:   Indivar Nair <indivar.nair@techterra.in>
Date:   Tue, 23 Jul 2019 20:06:12 +0530
Message-ID: <CALuPYL2v3eCc=99L3K7rovGOmzwvaqdmVg=xaFRhpR5=MZVtDw@mail.gmail.com>
Subject: Re: rpc.statd dies because of pacemaker monitoring
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott,

Like I mentioned last time, the storage is in production, so the scope
for experimenting is limited.
I was hoping that there would some kind of theoretical answer. :-)

We have cleaned up the DNS entries and made sure all of them have
proper reverse lookup entries.
We will be starting the monitoring service again soon.
I have also added the workaround patch you had given too.

I hope everything works out well this time.

Thanks a lot.

Regards,


Indivar Nair


On Thu, Jul 18, 2019 at 7:13 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> On Wed, 17 Jul 2019, Indivar Nair wrote:
>
> > Hi Scott,
> >
> > Could you help me out with my query in the earlier email?
> > I would like to get to the root cause of the issue.
> > Since it is a storage system that is heavily used, I need to make sure
> > that the issue does not crop even after fixing the DNS.
>
> If you want to verify the root cause of the issue, then before you start
> making any changes you probably want to collect some more data.  A good
> start would be using tcpdump or wireshark to get a binary packet capture
> on the NFS server filtering on port 53.  That way you can see if you
> have any DNS queries that are taking a long time.  If that doesn't pan
> out then you'll probably need to either run rpc.statd in the foreground
> with debug logging enabled (and hope that the logging sheds some light
> on the issue) or trace the rpc.statd process via strace.
>
> In regard to your question on the /etc/hosts file, if all you have in it
> are entries for localhost, then no that's not going to speed up
> anything.  Any name resolution queries are going to look in that file
> first, not find anything, and then try your DNS server.  If you want to
> cut the DNS server out of the picture then you'd need to add entries for
> all your NFS clients to the NFS server's /etc/hosts file.  Keep in mind
> that if you do go this route now you're stuck keeping your /etc/hosts
> files correct & in-sync on your NFS server nodes (i.e. you're losing out
> on the centralized management provided by DNS).
>
> -Scott
> >
> > Thanks.
> >
> > Regards,
> >
> >
> > Indivar Nair
> >
> > On Sat, Jul 13, 2019 at 8:31 PM Indivar Nair <indivar.nair@techterra.in> wrote:
> > >
> > > Thanks once again, Scott,
> > >
> > > The patch seems like a neat solution
> > > It will declare rpc.statd dead only after checking multiple times. Super.
> > > I will patch the nfsserver resource file.
> > > (It should probably be added to the original source code.)
> > >
> > > We have a proper entry for 127.0.0.1 in the hosts file and the
> > > nsswtich.conf file says, "files dns".
> > > So if it checks the /etc/hosts first, why would the pacemaker's check timeout?
> > > Shouldn't pacemaker get a quick response?
> > >
> > > Localhost entries in the /etc/hosts file -
> > > -------------------------------------------------------------------------------------------------------------------------------------
> > > 127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
> > > ::1 localhost localhost.localdomain localhost6 localhost6.localdomain6
> > > -------------------------------------------------------------------------------------------------------------------------------------
> > >
> > > Regards,
> > >
> > >
> > > Indivar Nair
> > >
> > >
> > >
> > >
> > >
> > >
> > > On Fri, Jul 12, 2019 at 7:47 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > >
> > > > On Fri, 12 Jul 2019, Indivar Nair wrote:
> > > >
> > > > > Hi Scott,
> > > > >
> > > > > Thanks a lot.
> > > > > Yes, it is a 10+ year old AD setup, which was migrated to Samba4AD
> > > > > (samba+named) a few years ago.
> > > > > It has lot of stale entries, and fwd - rev lookup mismatches.
> > > > >
> > > > > Will start cleaning up DNS right away.
> > > > >
> > > > > In the meantime, is there any way to increase the rpc ping timeout?
> > > >
> > > > You could build the rpcinfo.c program from source (it's in the rpcbind
> > > > git tree) with a longer timeout.
> > > >
> > > > > OR
> > > > > Is there any way to temporarily disable DNS lookups by lockd?
> > > >
> > > > rpc.statd is doing the DNS lookups, and no there's not a way to disable it.
> > > > Doing so would probably make the reboot notifications less reliable, and
> > > > clients wouldn't know to reclaim locks, and the risk of data corruption
> > > > goes up.
> > > >
> > > > You could prevent the DNS lookups from occurring by adding entries (properly
> > > > formatted... see the hosts(5) man page) for all your clients into the
> > > > /etc/hosts file on your NFS server nodes.  That's assuming that your nsswitch
> > > > configuration has "files" before "dns" for host lookups.  Depending on how
> > > > many clients you have, that might be the easiest option.
> > > >
> > > > Another option might be to try adding a simple retry mechanism to the part
> > > > of the nfsserver resource agent that checks rpc.statd, something like:
> > > >
> > > > diff --git a/heartbeat/nfsserver b/heartbeat/nfsserver
> > > > index bf59da98..c9dcc74e 100755
> > > > --- a/heartbeat/nfsserver
> > > > +++ b/heartbeat/nfsserver
> > > > @@ -334,8 +334,13 @@ nfsserver_systemd_monitor()
> > > >         fi
> > > >
> > > >         ocf_log debug "Status: rpc-statd"
> > > > -       rpcinfo -t localhost 100024 > /dev/null 2>&1
> > > > -       rc=$?
> > > > +       for i in `seq 1 3`; do
> > > > +               rpcinfo -t localhost 100024 >/dev/null 2>&1
> > > > +               rc=$?
> > > > +               if [ $rc -eq 0 ]; then
> > > > +                       break
> > > > +               fi
> > > > +       done
> > > >         if [ "$rc" -ne "0" ]; then
> > > >                 ocf_exit_reason "rpc-statd is not running"
> > > >                 return $OCF_NOT_RUNNING
> > > > >
> > > > > Regards,
> > > > >
> > > > >
> > > > > Indivar Nair
> > > > >
> > > > > On Thu, Jul 11, 2019 at 10:19 PM Scott Mayhew <smayhew@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, 11 Jul 2019, Indivar Nair wrote:
> > > > > >
> > > > > > > Hi ...,
> > > > > > >
> > > > > > > I have a 2 node Pacemaker cluster built using CentOS 7.6.1810
> > > > > > > It serves files using NFS and Samba.
> > > > > > >
> > > > > > > Every 15 - 20 minutes, the rpc.statd service fails, and the whole NFS
> > > > > > > service is restarted.
> > > > > > > After investigation, it was found that the service fails after a few
> > > > > > > rounds of monitoring by Pacemaker.
> > > > > > > The Pacemaker's script runs the following command to check whether all
> > > > > > > the services are running -
> > > > > > > ---------------------------------------------------------------------------------------------------------------------------------------
> > > > > > >     rpcinfo > /dev/null 2>&1
> > > > > > >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> > > > > > >     nfs_exec status nfs-idmapd > $fn 2>&1
> > > > > > >     rpcinfo -t localhost 100024 > /dev/null 2>&1
> > > > > >
> > > > > > I would check to make sure your DNS setup is working properly.
> > > > > > rpc.statd uses the canonical hostnames for comparison purposes whenever
> > > > > > it gets an SM_MON or SM_UNMON request from lockd and when it gets an
> > > > > > SM_NOTIFY from a rebooted NFS client.  That involves calls to
> > > > > > getaddrinfo() and getnameinfo() which in turn could result in requests
> > > > > > to a DNS server.  rpc.statd is single-threaded, so if it's blocked
> > > > > > waiting for one of those requests, then it's unable to respond to the
> > > > > > RPC ping (which has a timeout of 10 seconds) generated by the rpcinfo
> > > > > > program.
> > > > > >
> > > > > > I ran into a similar scenario in the past where a client was launching
> > > > > > multiple instances of rpc.statd.  When the client does a v3 mount it
> > > > > > does a similar RPC ping (with a more aggressive timeout) to see if
> > > > > > rpc.statd is running... if not then it calls out to
> > > > > > /usr/sbin/start-statd (which in the past simply called 'exec rpc.statd
> > > > > > --no-notify' but now has additional checks).  Likewise rpc.statd does
> > > > > > it's own RPC ping to make sure there's not one already running.  It
> > > > > > wound up that the user had a flakey DNS server and requests were taking
> > > > > > over 30 seconds to time out, thus thwarting all those additional checks,
> > > > > > and they wound up with multiple copies of rpc.statd running.
> > > > > >
> > > > > > You could be running into a similar scenario here and pacemaker could be
> > > > > > deciding that rpc.statd's not running when it's actually fine.
> > > > > >
> > > > > > -Scott
> > > > > >
> > > > > > > ---------------------------------------------------------------------------------------------------------------------------------------
> > > > > > > The script is scheduled to check every 20 seconds.
> > > > > > >
> > > > > > > This is the message we get in the logs -
> > > > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > > > > > 127.0.0.1 ALLOWED
> > > > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > > > > > from 127.0.0.1
> > > > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > > > > > 127.0.0.1 ALLOWED (cached)
> > > > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > > > > > from 127.0.0.1
> > > > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > > > > > 127.0.0.1 ALLOWED (cached)
> > > > > > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > > > > > from 127.0.0.1
> > > > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > > > >
> > > > > > > After 10 seconds, we get his message -
> > > > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > > > > Jul 09 07:34:09 virat-nd01 nfsserver(virat-nfs-daemon)[54087]: ERROR:
> > > > > > > rpc-statd is not running
> > > > > > > -------------------------------------------------------------------------------------------------------------------------------------
> > > > > > > Once we get this error, the NFS service is automatically restarted.
> > > > > > >
> > > > > > > "ERROR: rpc-statd is not running" message is from the pacemaker's
> > > > > > > monitoring script.
> > > > > > > I have pasted that part of the script below.
> > > > > > >
> > > > > > > I disabled monitoring and everything is working fine, since then.
> > > > > > >
> > > > > > > I cant keep the cluster monitoring disabled forever.
> > > > > > >
> > > > > > > Kindly help.
> > > > > > >
> > > > > > > Regards,
> > > > > > >
> > > > > > >
> > > > > > > Indivar Nair
> > > > > > >
> > > > > > > Part of the pacemaker script that does the monitoring
> > > > > > > (/usr/lib/ocf/resources.d/heartbeat/nfsserver)
> > > > > > > =======================================================================
> > > > > > > nfsserver_systemd_monitor()
> > > > > > > {
> > > > > > >     local threads_num
> > > > > > >     local rc
> > > > > > >     local fn
> > > > > > >
> > > > > > >     ocf_log debug "Status: rpcbind"
> > > > > > >     rpcinfo > /dev/null 2>&1
> > > > > > >     rc=$?
> > > > > > >     if [ "$rc" -ne "0" ]; then
> > > > > > >         ocf_exit_reason "rpcbind is not running"
> > > > > > >         return $OCF_NOT_RUNNING
> > > > > > >     fi
> > > > > > >
> > > > > > >     ocf_log debug "Status: nfs-mountd"
> > > > > > >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> > > > > > >     rc=$?
> > > > > > >     if [ "$rc" -ne "0" ]; then
> > > > > > >         ocf_exit_reason "nfs-mountd is not running"
> > > > > > >         return $OCF_NOT_RUNNING
> > > > > > >     fi
> > > > > > >
> > > > > > >     ocf_log debug "Status: nfs-idmapd"
> > > > > > >     fn=`mktemp`
> > > > > > >     nfs_exec status nfs-idmapd > $fn 2>&1
> > > > > > >     rc=$?
> > > > > > >     ocf_log debug "$(cat $fn)"
> > > > > > >     rm -f $fn
> > > > > > >     if [ "$rc" -ne "0" ]; then
> > > > > > >         ocf_exit_reason "nfs-idmapd is not running"
> > > > > > >         return $OCF_NOT_RUNNING
> > > > > > >     fi
> > > > > > >
> > > > > > >     ocf_log debug "Status: rpc-statd"
> > > > > > >     rpcinfo -t localhost 100024 > /dev/null 2>&1
> > > > > > >     rc=$?
> > > > > > >     if [ "$rc" -ne "0" ]; then
> > > > > > >         ocf_exit_reason "rpc-statd is not running"
> > > > > > >         return $OCF_NOT_RUNNING
> > > > > > >     fi
> > > > > > >
> > > > > > >     nfs_exec is-active nfs-server
> > > > > > >     rc=$?
> > > > > > >
> > > > > > >     # Now systemctl is-active can't detect the failure of kernel
> > > > > > > process like nfsd.
> > > > > > >     # So, if the return value of systemctl is-active is 0, check the
> > > > > > > threads number
> > > > > > >     # to make sure the process is running really.
> > > > > > >     # /proc/fs/nfsd/threads has the numbers of the nfsd threads.
> > > > > > >     if [ $rc -eq 0 ]; then
> > > > > > >         threads_num=`cat /proc/fs/nfsd/threads 2>/dev/null`
> > > > > > >         if [ $? -eq 0 ]; then
> > > > > > >             if [ $threads_num -gt 0 ]; then
> > > > > > >                 return $OCF_SUCCESS
> > > > > > >             else
> > > > > > >                 return 3
> > > > > > >             fi
> > > > > > >         else
> > > > > > >             return $OCF_ERR_GENERIC
> > > > > > >         fi
> > > > > > >     fi
> > > > > > >
> > > > > > >     return $rc
> > > > > > > }
> > > > > > > =======================================================================

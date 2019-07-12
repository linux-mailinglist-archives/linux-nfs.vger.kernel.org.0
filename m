Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D116767123
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2019 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGLORD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Jul 2019 10:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfGLORD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Jul 2019 10:17:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 516353086203;
        Fri, 12 Jul 2019 14:17:03 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-198.rdu2.redhat.com [10.10.122.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 132DE608AB;
        Fri, 12 Jul 2019 14:17:03 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 8951820791; Fri, 12 Jul 2019 10:16:57 -0400 (EDT)
Date:   Fri, 12 Jul 2019 10:16:57 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Indivar Nair <indivar.nair@techterra.in>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: rpc.statd dies because of pacemaker monitoring
Message-ID: <20190712141657.GB4131@coeurl.usersys.redhat.com>
References: <CALuPYL1_rvyn9A6gZnMCE8p87WoYjsU4BuUKT2OuxXUDiumO2w@mail.gmail.com>
 <20190711164937.GA4131@coeurl.usersys.redhat.com>
 <CALuPYL0+VdUsjeFx70xJkJUxc8SOdsTzALeeHcfd33fx4E_iTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALuPYL0+VdUsjeFx70xJkJUxc8SOdsTzALeeHcfd33fx4E_iTg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 12 Jul 2019 14:17:03 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 12 Jul 2019, Indivar Nair wrote:

> Hi Scott,
> 
> Thanks a lot.
> Yes, it is a 10+ year old AD setup, which was migrated to Samba4AD
> (samba+named) a few years ago.
> It has lot of stale entries, and fwd - rev lookup mismatches.
> 
> Will start cleaning up DNS right away.
> 
> In the meantime, is there any way to increase the rpc ping timeout?

You could build the rpcinfo.c program from source (it's in the rpcbind
git tree) with a longer timeout.

> OR
> Is there any way to temporarily disable DNS lookups by lockd?

rpc.statd is doing the DNS lookups, and no there's not a way to disable it.
Doing so would probably make the reboot notifications less reliable, and
clients wouldn't know to reclaim locks, and the risk of data corruption
goes up.

You could prevent the DNS lookups from occurring by adding entries (properly
formatted... see the hosts(5) man page) for all your clients into the
/etc/hosts file on your NFS server nodes.  That's assuming that your nsswitch
configuration has "files" before "dns" for host lookups.  Depending on how
many clients you have, that might be the easiest option.

Another option might be to try adding a simple retry mechanism to the part
of the nfsserver resource agent that checks rpc.statd, something like:

diff --git a/heartbeat/nfsserver b/heartbeat/nfsserver
index bf59da98..c9dcc74e 100755
--- a/heartbeat/nfsserver
+++ b/heartbeat/nfsserver
@@ -334,8 +334,13 @@ nfsserver_systemd_monitor()
        fi
 
        ocf_log debug "Status: rpc-statd"
-       rpcinfo -t localhost 100024 > /dev/null 2>&1
-       rc=$?
+       for i in `seq 1 3`; do
+               rpcinfo -t localhost 100024 >/dev/null 2>&1
+               rc=$?
+               if [ $rc -eq 0 ]; then
+                       break
+               fi
+       done
        if [ "$rc" -ne "0" ]; then
                ocf_exit_reason "rpc-statd is not running"
                return $OCF_NOT_RUNNING
> 
> Regards,
> 
> 
> Indivar Nair
> 
> On Thu, Jul 11, 2019 at 10:19 PM Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > On Thu, 11 Jul 2019, Indivar Nair wrote:
> >
> > > Hi ...,
> > >
> > > I have a 2 node Pacemaker cluster built using CentOS 7.6.1810
> > > It serves files using NFS and Samba.
> > >
> > > Every 15 - 20 minutes, the rpc.statd service fails, and the whole NFS
> > > service is restarted.
> > > After investigation, it was found that the service fails after a few
> > > rounds of monitoring by Pacemaker.
> > > The Pacemaker's script runs the following command to check whether all
> > > the services are running -
> > > ---------------------------------------------------------------------------------------------------------------------------------------
> > >     rpcinfo > /dev/null 2>&1
> > >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> > >     nfs_exec status nfs-idmapd > $fn 2>&1
> > >     rpcinfo -t localhost 100024 > /dev/null 2>&1
> >
> > I would check to make sure your DNS setup is working properly.
> > rpc.statd uses the canonical hostnames for comparison purposes whenever
> > it gets an SM_MON or SM_UNMON request from lockd and when it gets an
> > SM_NOTIFY from a rebooted NFS client.  That involves calls to
> > getaddrinfo() and getnameinfo() which in turn could result in requests
> > to a DNS server.  rpc.statd is single-threaded, so if it's blocked
> > waiting for one of those requests, then it's unable to respond to the
> > RPC ping (which has a timeout of 10 seconds) generated by the rpcinfo
> > program.
> >
> > I ran into a similar scenario in the past where a client was launching
> > multiple instances of rpc.statd.  When the client does a v3 mount it
> > does a similar RPC ping (with a more aggressive timeout) to see if
> > rpc.statd is running... if not then it calls out to
> > /usr/sbin/start-statd (which in the past simply called 'exec rpc.statd
> > --no-notify' but now has additional checks).  Likewise rpc.statd does
> > it's own RPC ping to make sure there's not one already running.  It
> > wound up that the user had a flakey DNS server and requests were taking
> > over 30 seconds to time out, thus thwarting all those additional checks,
> > and they wound up with multiple copies of rpc.statd running.
> >
> > You could be running into a similar scenario here and pacemaker could be
> > deciding that rpc.statd's not running when it's actually fine.
> >
> > -Scott
> >
> > > ---------------------------------------------------------------------------------------------------------------------------------------
> > > The script is scheduled to check every 20 seconds.
> > >
> > > This is the message we get in the logs -
> > > -------------------------------------------------------------------------------------------------------------------------------------
> > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > 127.0.0.1 ALLOWED
> > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > from 127.0.0.1
> > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > 127.0.0.1 ALLOWED (cached)
> > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > from 127.0.0.1
> > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > > 127.0.0.1 ALLOWED (cached)
> > > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > > from 127.0.0.1
> > > -------------------------------------------------------------------------------------------------------------------------------------
> > >
> > > After 10 seconds, we get his message -
> > > -------------------------------------------------------------------------------------------------------------------------------------
> > > Jul 09 07:34:09 virat-nd01 nfsserver(virat-nfs-daemon)[54087]: ERROR:
> > > rpc-statd is not running
> > > -------------------------------------------------------------------------------------------------------------------------------------
> > > Once we get this error, the NFS service is automatically restarted.
> > >
> > > "ERROR: rpc-statd is not running" message is from the pacemaker's
> > > monitoring script.
> > > I have pasted that part of the script below.
> > >
> > > I disabled monitoring and everything is working fine, since then.
> > >
> > > I cant keep the cluster monitoring disabled forever.
> > >
> > > Kindly help.
> > >
> > > Regards,
> > >
> > >
> > > Indivar Nair
> > >
> > > Part of the pacemaker script that does the monitoring
> > > (/usr/lib/ocf/resources.d/heartbeat/nfsserver)
> > > =======================================================================
> > > nfsserver_systemd_monitor()
> > > {
> > >     local threads_num
> > >     local rc
> > >     local fn
> > >
> > >     ocf_log debug "Status: rpcbind"
> > >     rpcinfo > /dev/null 2>&1
> > >     rc=$?
> > >     if [ "$rc" -ne "0" ]; then
> > >         ocf_exit_reason "rpcbind is not running"
> > >         return $OCF_NOT_RUNNING
> > >     fi
> > >
> > >     ocf_log debug "Status: nfs-mountd"
> > >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> > >     rc=$?
> > >     if [ "$rc" -ne "0" ]; then
> > >         ocf_exit_reason "nfs-mountd is not running"
> > >         return $OCF_NOT_RUNNING
> > >     fi
> > >
> > >     ocf_log debug "Status: nfs-idmapd"
> > >     fn=`mktemp`
> > >     nfs_exec status nfs-idmapd > $fn 2>&1
> > >     rc=$?
> > >     ocf_log debug "$(cat $fn)"
> > >     rm -f $fn
> > >     if [ "$rc" -ne "0" ]; then
> > >         ocf_exit_reason "nfs-idmapd is not running"
> > >         return $OCF_NOT_RUNNING
> > >     fi
> > >
> > >     ocf_log debug "Status: rpc-statd"
> > >     rpcinfo -t localhost 100024 > /dev/null 2>&1
> > >     rc=$?
> > >     if [ "$rc" -ne "0" ]; then
> > >         ocf_exit_reason "rpc-statd is not running"
> > >         return $OCF_NOT_RUNNING
> > >     fi
> > >
> > >     nfs_exec is-active nfs-server
> > >     rc=$?
> > >
> > >     # Now systemctl is-active can't detect the failure of kernel
> > > process like nfsd.
> > >     # So, if the return value of systemctl is-active is 0, check the
> > > threads number
> > >     # to make sure the process is running really.
> > >     # /proc/fs/nfsd/threads has the numbers of the nfsd threads.
> > >     if [ $rc -eq 0 ]; then
> > >         threads_num=`cat /proc/fs/nfsd/threads 2>/dev/null`
> > >         if [ $? -eq 0 ]; then
> > >             if [ $threads_num -gt 0 ]; then
> > >                 return $OCF_SUCCESS
> > >             else
> > >                 return 3
> > >             fi
> > >         else
> > >             return $OCF_ERR_GENERIC
> > >         fi
> > >     fi
> > >
> > >     return $rc
> > > }
> > > =======================================================================

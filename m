Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F354E665F6
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2019 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfGLFA6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Jul 2019 01:00:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38056 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfGLFA6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Jul 2019 01:00:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so8241629oth.5
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2019 22:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=techterra-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MpNOt0PW1/WkhiPA/OYXmN4uPBV9sSUKASyW2rdXzc=;
        b=a50/OiBVryoPtxIpYgzHAhKFhUXlffMwAAq+Z6wx/uaOVVJmQgJ6vGhy+MY062f51+
         90KQac+xeEDmoYQxI0yavG4Jaz+zgYu4CNz04g9RXf2bb/01oGDolhqHjNkka7vYnyoN
         1uXfChddXtImTfMXJgvBpr6g3A3FvO+xqEKEh5PbNgf+3fn3YayT8F9c5Bfx0WQ8+Bvc
         grYhOpzNSUdsBdd9V65/1Rgs4rxg4KHwqszXJiHxb5NACRj52/rrsLzlxBbu3Ng3iPh3
         rWjN1UAVBn98BPyeOJGWUJuU8kYvvBGTfOyslTCotVw7eNx7BdQ0ADNJH2llHKjaQJz3
         +Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MpNOt0PW1/WkhiPA/OYXmN4uPBV9sSUKASyW2rdXzc=;
        b=ZG0tMcOVrUyVezotXWF2gvpBeNNWrwL0HT7WbyH2rXXIusImvmVX2dnEhU2SRmuN/7
         fxL3MOYcbvVcvdWxUyVujVznr+h1p+enSzk9zOzzBm3/+HBMOFWHwP9ti9dLmNG9SxG9
         P33QhuQAkQ+E8/E3fOzfiMdL1rEgDkd5ipVADmp8xFLTb/TAlRnnGKi4JCcPr4TlRMVl
         N1t6pAAgnYK1dUls/+74OZBQARiXOD3Cnwrsv58LN0fOuKqlBabNrSc8VoiYqBuH6dfI
         6Ri4FiLXkpwMz6wL6E9i7phRqr1JLRQnNysPUDsS/zMW/xGBWZ6+LisuzaGCLXbZ6UXZ
         87TA==
X-Gm-Message-State: APjAAAXLyc4F7oQVHsBxGrqa03Mz+6uR10N+MbxXI5kj3x6kYDl3Vhno
        rEk8cx+JBNSDHNYFN2zwlBDniu5T3t4Hr4D1egI=
X-Google-Smtp-Source: APXvYqxj58NPDDZJbMBWhQws/uEhvIfwiyLpVO0oh9osLXjGWuwM5SNesrxWHstna3+QNWmD1jsfsdv/3tMkuLL+NJY=
X-Received: by 2002:a05:6830:2098:: with SMTP id y24mr6373124otq.173.1562907656681;
 Thu, 11 Jul 2019 22:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALuPYL1_rvyn9A6gZnMCE8p87WoYjsU4BuUKT2OuxXUDiumO2w@mail.gmail.com>
 <20190711164937.GA4131@coeurl.usersys.redhat.com>
In-Reply-To: <20190711164937.GA4131@coeurl.usersys.redhat.com>
From:   Indivar Nair <indivar.nair@techterra.in>
Date:   Fri, 12 Jul 2019 10:30:20 +0530
Message-ID: <CALuPYL0+VdUsjeFx70xJkJUxc8SOdsTzALeeHcfd33fx4E_iTg@mail.gmail.com>
Subject: Re: rpc.statd dies because of pacemaker monitoring
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Scott,

Thanks a lot.
Yes, it is a 10+ year old AD setup, which was migrated to Samba4AD
(samba+named) a few years ago.
It has lot of stale entries, and fwd - rev lookup mismatches.

Will start cleaning up DNS right away.

In the meantime, is there any way to increase the rpc ping timeout?
OR
Is there any way to temporarily disable DNS lookups by lockd?

Regards,


Indivar Nair

On Thu, Jul 11, 2019 at 10:19 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> On Thu, 11 Jul 2019, Indivar Nair wrote:
>
> > Hi ...,
> >
> > I have a 2 node Pacemaker cluster built using CentOS 7.6.1810
> > It serves files using NFS and Samba.
> >
> > Every 15 - 20 minutes, the rpc.statd service fails, and the whole NFS
> > service is restarted.
> > After investigation, it was found that the service fails after a few
> > rounds of monitoring by Pacemaker.
> > The Pacemaker's script runs the following command to check whether all
> > the services are running -
> > ---------------------------------------------------------------------------------------------------------------------------------------
> >     rpcinfo > /dev/null 2>&1
> >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> >     nfs_exec status nfs-idmapd > $fn 2>&1
> >     rpcinfo -t localhost 100024 > /dev/null 2>&1
>
> I would check to make sure your DNS setup is working properly.
> rpc.statd uses the canonical hostnames for comparison purposes whenever
> it gets an SM_MON or SM_UNMON request from lockd and when it gets an
> SM_NOTIFY from a rebooted NFS client.  That involves calls to
> getaddrinfo() and getnameinfo() which in turn could result in requests
> to a DNS server.  rpc.statd is single-threaded, so if it's blocked
> waiting for one of those requests, then it's unable to respond to the
> RPC ping (which has a timeout of 10 seconds) generated by the rpcinfo
> program.
>
> I ran into a similar scenario in the past where a client was launching
> multiple instances of rpc.statd.  When the client does a v3 mount it
> does a similar RPC ping (with a more aggressive timeout) to see if
> rpc.statd is running... if not then it calls out to
> /usr/sbin/start-statd (which in the past simply called 'exec rpc.statd
> --no-notify' but now has additional checks).  Likewise rpc.statd does
> it's own RPC ping to make sure there's not one already running.  It
> wound up that the user had a flakey DNS server and requests were taking
> over 30 seconds to time out, thus thwarting all those additional checks,
> and they wound up with multiple copies of rpc.statd running.
>
> You could be running into a similar scenario here and pacemaker could be
> deciding that rpc.statd's not running when it's actually fine.
>
> -Scott
>
> > ---------------------------------------------------------------------------------------------------------------------------------------
> > The script is scheduled to check every 20 seconds.
> >
> > This is the message we get in the logs -
> > -------------------------------------------------------------------------------------------------------------------------------------
> > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > 127.0.0.1 ALLOWED
> > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > from 127.0.0.1
> > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > 127.0.0.1 ALLOWED (cached)
> > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > from 127.0.0.1
> > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
> > 127.0.0.1 ALLOWED (cached)
> > Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
> > from 127.0.0.1
> > -------------------------------------------------------------------------------------------------------------------------------------
> >
> > After 10 seconds, we get his message -
> > -------------------------------------------------------------------------------------------------------------------------------------
> > Jul 09 07:34:09 virat-nd01 nfsserver(virat-nfs-daemon)[54087]: ERROR:
> > rpc-statd is not running
> > -------------------------------------------------------------------------------------------------------------------------------------
> > Once we get this error, the NFS service is automatically restarted.
> >
> > "ERROR: rpc-statd is not running" message is from the pacemaker's
> > monitoring script.
> > I have pasted that part of the script below.
> >
> > I disabled monitoring and everything is working fine, since then.
> >
> > I cant keep the cluster monitoring disabled forever.
> >
> > Kindly help.
> >
> > Regards,
> >
> >
> > Indivar Nair
> >
> > Part of the pacemaker script that does the monitoring
> > (/usr/lib/ocf/resources.d/heartbeat/nfsserver)
> > =======================================================================
> > nfsserver_systemd_monitor()
> > {
> >     local threads_num
> >     local rc
> >     local fn
> >
> >     ocf_log debug "Status: rpcbind"
> >     rpcinfo > /dev/null 2>&1
> >     rc=$?
> >     if [ "$rc" -ne "0" ]; then
> >         ocf_exit_reason "rpcbind is not running"
> >         return $OCF_NOT_RUNNING
> >     fi
> >
> >     ocf_log debug "Status: nfs-mountd"
> >     rpcinfo -t localhost 100005 > /dev/null 2>&1
> >     rc=$?
> >     if [ "$rc" -ne "0" ]; then
> >         ocf_exit_reason "nfs-mountd is not running"
> >         return $OCF_NOT_RUNNING
> >     fi
> >
> >     ocf_log debug "Status: nfs-idmapd"
> >     fn=`mktemp`
> >     nfs_exec status nfs-idmapd > $fn 2>&1
> >     rc=$?
> >     ocf_log debug "$(cat $fn)"
> >     rm -f $fn
> >     if [ "$rc" -ne "0" ]; then
> >         ocf_exit_reason "nfs-idmapd is not running"
> >         return $OCF_NOT_RUNNING
> >     fi
> >
> >     ocf_log debug "Status: rpc-statd"
> >     rpcinfo -t localhost 100024 > /dev/null 2>&1
> >     rc=$?
> >     if [ "$rc" -ne "0" ]; then
> >         ocf_exit_reason "rpc-statd is not running"
> >         return $OCF_NOT_RUNNING
> >     fi
> >
> >     nfs_exec is-active nfs-server
> >     rc=$?
> >
> >     # Now systemctl is-active can't detect the failure of kernel
> > process like nfsd.
> >     # So, if the return value of systemctl is-active is 0, check the
> > threads number
> >     # to make sure the process is running really.
> >     # /proc/fs/nfsd/threads has the numbers of the nfsd threads.
> >     if [ $rc -eq 0 ]; then
> >         threads_num=`cat /proc/fs/nfsd/threads 2>/dev/null`
> >         if [ $? -eq 0 ]; then
> >             if [ $threads_num -gt 0 ]; then
> >                 return $OCF_SUCCESS
> >             else
> >                 return 3
> >             fi
> >         else
> >             return $OCF_ERR_GENERIC
> >         fi
> >     fi
> >
> >     return $rc
> > }
> > =======================================================================

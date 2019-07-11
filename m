Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F14651FB
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfGKGt6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jul 2019 02:49:58 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46336 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKGt6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Jul 2019 02:49:58 -0400
Received: by mail-ot1-f48.google.com with SMTP id z23so4736732ote.13
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2019 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=techterra-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=+ntdsTiWVThPk9Dhmu/aXX9siFIXi+NZoeZ+1O1Wb1M=;
        b=ZwkKvpP4Tc/g8GDeKvwonkpadKcjPUZWu3kNonEm+S+YLFne5x97H+bn2RLCPeyFOY
         UnI88ggeLU1xd2ZhlsqoWIfrSv8GHiV0rf85WqyLPkQGtCoqoS/c93GHrYGUsl+CwWRe
         zhDc507Y818pv8lOAPbXQgdfomP/hLUsO13DYDQgUuo5jN+UKSyefsa+NHoGElqVZuIx
         8ste+mhSKvQ8WqvwM4q6H54nQ61ABvx5u6N7YSfXfxGxK+SPl2BDGQA7ey2iuTlr0jT6
         oV4TovGMXM0qFbBcTWlnkMKytzO8WZACjpLCzbaDEPi0g/PMLKmBPr+Mq1K74kv/Ot0P
         VEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+ntdsTiWVThPk9Dhmu/aXX9siFIXi+NZoeZ+1O1Wb1M=;
        b=RC790eesVrkKhlOMDbp8l3iacWzcflGYVP6YMYGWoxJGyreUP54zlkCFOp6hlwQb6/
         71D/X+Fwd2K1lhtuOz0FkpIba9lZUXa6X3VecTMgog2KHd+SjDrJB15cfvGlCnUke6t9
         OE04NqjJxMLIfHV/lC5zaCQY94F4uN1qkbGkdOe/4G2Uok3QF1a0CKL6SgU2v3YlqYe9
         R9EmvbqWSQo7TTJZPtFvxSxn4/kNXtVc8CsFRkYiqyIjZ5WQ9l5LEqtD8CzL+0OJTb3e
         y+xymf7gmFt7rxGtsA8nUlCjt0Dxt/prZGOp6KWWrMo/aXOhrggdr/C8LRX8tjGbjYgp
         5sdQ==
X-Gm-Message-State: APjAAAUvKLWEPGkBZp/kE9LDcUgf1VymRuC6s2dg36OL0A5TvnaiyfEw
        3AmNCxR+01R9GZCxYN6XKKBPPdcKUdfRG8191ys5e06Y
X-Google-Smtp-Source: APXvYqyXX3KlAB+w+VsySkv03lkAgek4EwqLtGg0UzdXrbIF425m8huMH/KiC/3bbNEZ0qG7kK/SSpCEFSS2dHhuFWE=
X-Received: by 2002:a05:6830:2098:: with SMTP id y24mr1934965otq.173.1562827797029;
 Wed, 10 Jul 2019 23:49:57 -0700 (PDT)
MIME-Version: 1.0
From:   Indivar Nair <indivar.nair@techterra.in>
Date:   Thu, 11 Jul 2019 12:19:21 +0530
Message-ID: <CALuPYL1_rvyn9A6gZnMCE8p87WoYjsU4BuUKT2OuxXUDiumO2w@mail.gmail.com>
Subject: rpc.statd dies because of pacemaker monitoring
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi ...,

I have a 2 node Pacemaker cluster built using CentOS 7.6.1810
It serves files using NFS and Samba.

Every 15 - 20 minutes, the rpc.statd service fails, and the whole NFS
service is restarted.
After investigation, it was found that the service fails after a few
rounds of monitoring by Pacemaker.
The Pacemaker's script runs the following command to check whether all
the services are running -
---------------------------------------------------------------------------------------------------------------------------------------
    rpcinfo > /dev/null 2>&1
    rpcinfo -t localhost 100005 > /dev/null 2>&1
    nfs_exec status nfs-idmapd > $fn 2>&1
    rpcinfo -t localhost 100024 > /dev/null 2>&1
---------------------------------------------------------------------------------------------------------------------------------------
The script is scheduled to check every 20 seconds.

This is the message we get in the logs -
-------------------------------------------------------------------------------------------------------------------------------------
Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
127.0.0.1 ALLOWED
Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
from 127.0.0.1
Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
127.0.0.1 ALLOWED (cached)
Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
from 127.0.0.1
Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: check_default: access by
127.0.0.1 ALLOWED (cached)
Jul 09 07:33:56 virat-nd01 rpc.mountd[51641]: Received NULL request
from 127.0.0.1
-------------------------------------------------------------------------------------------------------------------------------------

After 10 seconds, we get his message -
-------------------------------------------------------------------------------------------------------------------------------------
Jul 09 07:34:09 virat-nd01 nfsserver(virat-nfs-daemon)[54087]: ERROR:
rpc-statd is not running
-------------------------------------------------------------------------------------------------------------------------------------
Once we get this error, the NFS service is automatically restarted.

"ERROR: rpc-statd is not running" message is from the pacemaker's
monitoring script.
I have pasted that part of the script below.

I disabled monitoring and everything is working fine, since then.

I cant keep the cluster monitoring disabled forever.

Kindly help.

Regards,


Indivar Nair

Part of the pacemaker script that does the monitoring
(/usr/lib/ocf/resources.d/heartbeat/nfsserver)
=======================================================================
nfsserver_systemd_monitor()
{
    local threads_num
    local rc
    local fn

    ocf_log debug "Status: rpcbind"
    rpcinfo > /dev/null 2>&1
    rc=$?
    if [ "$rc" -ne "0" ]; then
        ocf_exit_reason "rpcbind is not running"
        return $OCF_NOT_RUNNING
    fi

    ocf_log debug "Status: nfs-mountd"
    rpcinfo -t localhost 100005 > /dev/null 2>&1
    rc=$?
    if [ "$rc" -ne "0" ]; then
        ocf_exit_reason "nfs-mountd is not running"
        return $OCF_NOT_RUNNING
    fi

    ocf_log debug "Status: nfs-idmapd"
    fn=`mktemp`
    nfs_exec status nfs-idmapd > $fn 2>&1
    rc=$?
    ocf_log debug "$(cat $fn)"
    rm -f $fn
    if [ "$rc" -ne "0" ]; then
        ocf_exit_reason "nfs-idmapd is not running"
        return $OCF_NOT_RUNNING
    fi

    ocf_log debug "Status: rpc-statd"
    rpcinfo -t localhost 100024 > /dev/null 2>&1
    rc=$?
    if [ "$rc" -ne "0" ]; then
        ocf_exit_reason "rpc-statd is not running"
        return $OCF_NOT_RUNNING
    fi

    nfs_exec is-active nfs-server
    rc=$?

    # Now systemctl is-active can't detect the failure of kernel
process like nfsd.
    # So, if the return value of systemctl is-active is 0, check the
threads number
    # to make sure the process is running really.
    # /proc/fs/nfsd/threads has the numbers of the nfsd threads.
    if [ $rc -eq 0 ]; then
        threads_num=`cat /proc/fs/nfsd/threads 2>/dev/null`
        if [ $? -eq 0 ]; then
            if [ $threads_num -gt 0 ]; then
                return $OCF_SUCCESS
            else
                return 3
            fi
        else
            return $OCF_ERR_GENERIC
        fi
    fi

    return $rc
}
=======================================================================

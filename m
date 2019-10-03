Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4ECC9EFA
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2019 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfJCNC1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Oct 2019 09:02:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40754 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJCNC1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Oct 2019 09:02:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93Cs6sw155418;
        Thu, 3 Oct 2019 13:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Cs6dFc4Ek2Hf06FDoIDxQK1Uolux/aNZ5Q8wiibrbGc=;
 b=mzYq84Bz+XvAMHCKPS2mbceMewQknVRroz3Fv645P3mNe1UMXk1lCl1v7zu9Kb74b1we
 HfoP6U0RyJNqCNkjmt1uBKD54aur6oK1mLOS7NT+pX2rP1ABmFttE9D8kkZdJMVsW075
 LRF9XJwo23WVsn3nj3YZb7ILJaklStxug9CP0SjkmQ8pKDchC7IdhB3oc6JVVP1zB2Rq
 A3/c8tDuO7dvD/OEVZOiAxbZRSq+7JpIZI9ioOawD44eosFADob4gjw7zVQA+XWvN+Qu
 fVBs30VeZdmdvlF32h4kKs+P4T8XUxKQ7zc+OU9cPTwz4/QQFFcY1vZfE5XnbcoYbVsJ Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2v9yfqku2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 13:01:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93Cx9dw157244;
        Thu, 3 Oct 2019 13:01:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vcx72eh58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 13:01:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x93D1p8u031317;
        Thu, 3 Oct 2019 13:01:51 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 06:01:51 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: remounting hard -> soft
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87y2y265cm.fsf@notabene.neil.brown.name>
Date:   Thu, 3 Oct 2019 09:01:48 -0400
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Neil F Brown <nfbrown@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <4C8E9327-5B84-4EA7-B9D4-37183A1FEB3C@oracle.com>
References: <489FAE7A-F9CC-46A9-84FC-127487ADC0B3@oracle.com>
 <87y2y265cm.fsf@notabene.neil.brown.name>
To:     Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030121
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 2, 2019, at 8:27 PM, NeilBrown <neilb@suse.de> wrote:
> 
> On Wed, Oct 02 2019, Chuck Lever wrote:
> 
>> Hi Trond-
>> 
>> We (Oracle) had another (fairly rare) instance of a weekend maintenance
>> window where an NFS server's IP address changed while there were mounted
>> clients. It brought up the issue again of how we (the Linux NFS community)
>> would like to deal with cases where a client administrator has to deal
>> with a moribund mount (like that alliteration :-).
> 
> What exactly is the problem that this caused?
> 
> As I understand it, a moribund mount can still be unmounted with "-l"
> and processes accessing it can still be killed

I was asking about "-o remount,soft" because I was not certain
about the outcome last time this conversation was in full swing.
The gist then is that we want "umount -l" and "umount -f" to
work reliably and as advertised?


> ... except....
> There are some waits the VFS/MM which are not TASK_KILLABLE and
> probably should be.  I think that "we" definitely want "someone" to
> track them down and fix them.

I agree... and "someone" could mean me or someone here at Oracle.


>> Does remounting with "soft" work today? That seems like the most direct
>> way to deal with this particular situation.
> 
> I don't think this does work, and it would be non-trivial (but maybe not
> impossible) to mark all the outstanding RPCs as also "soft".

The problem I've observed with umount is umount_begin does the
killall_tasks call, then the client issues some additional requests.
Those are the requests that get stuck before umount_end can finally
shutdown the RPC client. umount_end is never called because those
requests are "hard".

We have rpc_killall_tasks which loops over all of an rpc_clnt's
outstanding RPC tasks. nfs_umount_begin could do something like

- set the rpc_clnt's "soft" flag
- kill all tasks

Then any new tasks would timeout eventually. Just a thought, maybe
not a good one.

There's also using SOFTCONN for all tasks after killall is called:
if the client can't reconnect to the server, these tasks would fail
immediately.


> If we wanted to follow a path like this (and I suspect we don't), I
> would hope that we could expose the server connection (shared among
> multiple mounts) in sysfs somewhere, and could then set "soft" (or
> "dead") on that connection, rather than having to do it on every mount
> from the particular server.

I think of your use case from last time: client shutdown should be
reliable. Seems like making "umount -f" reliable would be better
for that use case, and would work for the "make client mount points
recoverable after server dies" case too.


--
Chuck Lever




Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019092534CC
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Aug 2020 18:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHZQZC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Aug 2020 12:25:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgHZQY7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Aug 2020 12:24:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGJhCf157925;
        Wed, 26 Aug 2020 16:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eva1fT1qvg9yI4O1Y1P9zT/YkhCd2MtDSGxi90apMOI=;
 b=CRLY4jaLiiMceyG5eVMqvGCcW93L+wn0VHdZJPUA21u9mpIzx16lHZenS4xtE8mxiINh
 bZa1hp68p6MwMSkKgSrKieL8qMvi4Zdt6kQUmvzWOHRs+o3PJrvSdr4pPSq6gIWKkGIC
 BTyGBXTeRKTp1hzSgiUu06WvltNAAbrdHA2rUS2JcdOogccQWC/Q71RU1AXFMCBEnrTv
 zxJuiRvepS1NCb3Grul7x+x9giho9qGgmg5RkRxc+BBh5JZOQX1dcRekgLhQHD8o3YZD
 FVRH2c518S765DQusJdpSJyUOi4Cj7NE8xeWQ8zrP2ia2jpoH7s3Q7EIixSWshMIRQcq WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6u022w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 16:24:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QGOq4X041834;
        Wed, 26 Aug 2020 16:24:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 333r9mbvx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 16:24:52 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QGOb51012748;
        Wed, 26 Aug 2020 16:24:40 GMT
Received: from dhcp-10-154-152-180.vpn.oracle.com (/10.154.152.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 09:24:37 -0700
Subject: Re: question about handling off an unresponsive server during lease
 renewal
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
References: <CAN-5tyF+NOK3bZpuTSEjnuuY3XnjrarUwHcvh5TEgCBebW=KHA@mail.gmail.com>
 <690aeae28fcf2a19c9094e4489f617ccc40c1663.camel@hammerspace.com>
From:   Dai Ngo <dai.ngo@oracle.com>
Message-ID: <51dc153a-6b1a-9739-095a-e0a453367c17@oracle.com>
Date:   Wed, 26 Aug 2020 09:24:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <690aeae28fcf2a19c9094e4489f617ccc40c1663.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=3 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260120
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga and Trond,

On 7/13/20 11:15 AM, Trond Myklebust wrote:
> Hi Olga
>
> On Mon, 2020-07-13 at 13:59 -0400, Olga Kornievskaia wrote:
>> Hi Trond,
>>
>> To the best of your knowledge, does the client implement this part of
>> the spec that deals with when the server isn't responding and the
>> lease is timing out.
>>
>> RFC5661 section 8.3 talks about:
>>
>> Transport retransmission delays might become so large as to
>>        approach or exceed the length of the lease period.  This may be
>>        particularly likely when the server is unresponsive due to a
>>        restart; see Section 8.4.2.1.  If the client implementation is
>> not
>>        careful, transport retransmission delays can result in the
>> client
>>        failing to detect a server restart before the grace period
>> ends.
>>        The scenario is that the client is using a transport with
>>        exponential backoff, such that the maximum retransmission
>> timeout
>>        exceeds both the grace period and the lease_time attribute.  A
>>        network partition causes the client's connection's
>> retransmission
>>        interval to back off, and even after the partition heals, the
>> next
>>        transport-level retransmission is sent after the server has
>>        restarted and its grace period ends.
>>
>>        The client MUST either recover from the ensuing
>> NFS4ERR_NO_GRACE
>>        errors or it MUST ensure that, despite transport-level
>>        retransmission intervals that exceed the lease_time, a SEQUENCE
>>        operation is sent that renews the lease before expiration.  The
>>        client can achieve this by associating a new connection with
>> the
>>        session, and sending a SEQUENCE operation on it.  However, if
>> the
>>        attempt to establish a new connection is delayed for some
>> reason
>>        (e.g., exponential backoff of the connection establishment
>>        packets), the client will have to abort the connection
>>        establishment attempt before the lease expires, and attempt to
>>        reconnect.
>>
>> SEQUNCE op is sent and server rebooted, it's coming up (but not
>> responding).
>> At the TCP layer, TCP is exponentially backing off before retrying.
>> At
>> some point the timeout goes more than 100s. Which means that by the
>> time the client resends the server is up and out of grace.
>>
>> Does the client have any control over not letting the TCP wait for
>> longer than the lease period and instead, it needs to abort the
>> connection and start the new one? I mean I sort of find the 2nd
>> paragraph in contradiction to the fact that the client must never
>> give
>> up on waiting for a reply from the server? But maybe this is a
>> special
>> case where the client is supposed to know its lease hasn't been
>> renewed and it's OK to give up?
> That is what this code is supposed to ensure:
>
> /**
>   * nfs4_set_lease_period - Sets the lease period on a nfs_client
>   *
>   * @clp: pointer to nfs_client
>   * @lease: new value for lease period
>   */
> void nfs4_set_lease_period(struct nfs_client *clp,
>                  unsigned long lease)
> {
>          spin_lock(&clp->cl_lock);
>          clp->cl_lease_time = lease;
>          spin_unlock(&clp->cl_lock);
>
>          /* Cap maximum reconnect timeout at 1/2 lease period */
>          rpc_set_connect_timeout(clp->cl_rpcclient, lease, lease >> 1);
> }
>
> The call to rpc_set_connect_timeout() iterates through all of the
> transports associated with that server, and calls xprt->ops-
>> set_connect_timeout() with the appropriate connect and reconnect
> timeouts.

xs_tcp_set_connect_timeout is called to setup the rpc_timeout structure
in sock_xprt based on lease and lease >> 1.  With the v4 lease period
of 90 secs, the to_initval and to_maxval are both set to 30000ms and
to_retries is set to 2 (default).

xs_tcp_set_socket_timeouts uses the rpc_timeout in sock_xprt to set up
the TCP keep-alive timer and the TCP_USER_TIMEOUT option for the socket.

Currently, with the v4 lease of 90 secs, the TCP_USER_TIMEOUT is set to
90,000ms which is the same as the lease period.  Since the lease period
and the TCP_USER_TIMEOUT are the same, there will be cases where the
client does not have enough time to reclaim its locks.  Should the
TCP_USER_TIMEOUT value be less than the lease period, perhaps the same
as the lease renewal period which is 60 secs?

Thanks,
-Dai


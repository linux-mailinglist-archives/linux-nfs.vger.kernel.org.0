Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3144324
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392394AbfFMQ12 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 12:27:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392384AbfFMQ11 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jun 2019 12:27:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGOCCp112545;
        Thu, 13 Jun 2019 16:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=wKDft2FNOwHazwVmegr4YOqjav7F6VwW4sxJ6gM78eQ=;
 b=Rl0ji4ebwG8ApPMte5Xybedb30YAfuHK0GyAcw2oURR6aZwA7UcbDDKQ1vIBefJR/8b+
 NChBkWX/sLQfpHxULgpE9AhhhPKKbPKqVmnjf1S/SIvq+0VDqrWclKg/wRBYaHnB/3uy
 iQXbb14obptVyZFgeK0957+6PO1NMNRu1A3agI44Nc6YWHLdiF3vLNaTspgcvLbX5q63
 WCamV/kzNXvuRUEZHKY6IH64Y88quVyfBYaTS7W6EHaVu14f4ct0syxV3gTz+QSXFils
 WxxLjbFQ6keRO+o6QZ8lNzDDc9KsZ7axLSHpOCKXIA+fqbsO8wASbKlVbUDYZWprUGwo HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t04eu2sad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:27:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGQw9S157551;
        Thu, 13 Jun 2019 16:27:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t04j0janq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:27:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DGREtZ020809;
        Thu, 13 Jun 2019 16:27:14 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 09:27:14 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87r27yv0hb.fsf@notabene.neil.brown.name>
Date:   Thu, 13 Jun 2019 12:27:12 -0400
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D334F0C3-A4A6-4F87-8703-41AD2EF8D225@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <874l4vwp2a.fsf@notabene.neil.brown.name>
 <412B8D10-6CE6-4FF4-8479-C93D00F0F039@oracle.com>
 <87r27yv0hb.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130121
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 12, 2019, at 7:37 PM, NeilBrown <neilb@suse.com> wrote:
> 
> On Wed, Jun 12 2019, Chuck Lever wrote:
> 
>> Hi Neil-
>> 
>> 
>>> On Jun 11, 2019, at 9:49 PM, NeilBrown <neilb@suse.com> wrote:
>>> 
>>> This enables NFS to benefit from transparent parallelism in the network
>>> stack, such as interface bonding and receive-side scaling as described
>>> earlier.
>>> 
>>> When multiple connections are available, NFS will send
>>> session-management requests on a single connection (the first
>>> connection opened)
>> 
>> Maybe you meant "lease management" requests?
> 
> Probably I do .... though maybe I can be forgiven for mistakenly
> thinking that CREATE_SESSION and DESTROY_SESSION could be described as
> "session management" :-)
> 
>> 
>> EXCHANGE_ID, RECLAIM_COMPLETE, CREATE_SESSION, DESTROY_SESSION
>> and DESTROY_CLIENTID will of course go over the main connection.
>> However, each connection will need to use BIND_CONN_TO_SESSION
>> to join an existing session. That's how the server knows
>> the additional connections are from a client instance it has
>> already recognized.
>> 
>> For NFSv4.0, SETCLIENTID, SETCLIENTID_CONFIRM, and RENEW
>> would go over the main connection (and those have nothing to do
>> with sessions).
> 
> Well.... they have nothing to do with NFSv4.1 Sessions.
> But it is useful to have a name for the collection of RPCs related to a
> particular negotiated clientid, and "session" (small 's') seems as good
> a name as any....

Lease management is the proper terminology, as it covers NFSv4.0
as well as NFSv4.1 and has been used for years to describe this
set of NFS operations. Overloading the word "session" is just going
to confuse things.


>> 3. RPC/RDMA clients always drop the connection before retransmitting
>> because they have to reset the connection's credit accounting.
>> 
>> 4. RPC/RDMA cannot depend on IP source port, because the RPC part
>> of the stack has no visibility into the choice of source port that
>> is chosen. Thus the server's DRC cannot use the source port. I
>> think server DRC's need to be prepared to deal with multiple client
>> connections.
> 
> OK, that could be an issue.

It isn't. The Linux NFS server computes a hash over the first ~200
bytes of each RPC call. We can safely ignore the client IP source
port and rely solely on that hash to sort the requests, thanks to
Jeff Layton.

My overall point is this descriptive text should ignore consideration
of IP source port in favor of describing the creation of multiple
flows of requests.


> Linux uses an independent xid sequence for each xprt, so two separate
> xprts can easily use the same xid for different requests.
> If RDMA cannot see the source port, it might depend more on the xid and
> so risk getting confused.
> 
> There was a patch floating around which reserved a few bits of the xid
> for an xprt index to ensure all xids were unique, but Trond didn't like
> sub-dividing the xid space (which is fair enough).
> So maybe it isn't safe to use nconnect with RDMA and protocol versions
> earlier than 4.1.


--
Chuck Lever




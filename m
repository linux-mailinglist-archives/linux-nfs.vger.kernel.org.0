Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903E1A0559
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1Ou6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 10:50:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1Ou6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 10:50:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SEikpx109924;
        Wed, 28 Aug 2019 14:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=dMnNkhMLQ1kni0QX9zFCYWITnCiUXwMI6hR7Jogyoag=;
 b=Itok8Z9OiBDUunY9RDzDjEc7axdvMN4SmIIpZKKBhJA8Y+h2PQDnlKmn3sEcgNfvuWRz
 +HzL7XzWw/30OP3GvLed5WFScWjqAuAd/XEMjSIdSEq7NPWwtaJhRnSm16fvgp2Ejuj5
 +vDtn1zkdo/ZWxr4ESGKUYCdgIXacx2FCrC9G6+YyyEt14l3G4ePwsPQ/PpTFUK81Pym
 9MW0IND4B1KfoBPglcBXNmD6iWQaxBPPja7/BPiPi4lOw9WKIsSDzXvUlrUyH8LJ3lGX
 fQYsPQAgFbGm5PuBBc0UJtidjC3OKBNJk7aR4VdnoLBYmCKKTEXYBOBchtc7TElRv6Ej 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2unun28203-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 14:50:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SEiBiQ118276;
        Wed, 28 Aug 2019 14:50:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2untetce3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 14:50:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7SEoVxD021357;
        Wed, 28 Aug 2019 14:50:32 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 07:50:31 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20190828144839.GA26284@fieldses.org>
Date:   Wed, 28 Aug 2019 10:50:30 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <AAF793DB-25B7-42A5-9795-5317B5052F44@oracle.com>
References: <20190827145819.GB9804@fieldses.org>
 <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
 <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
 <20190828140044.GA14249@parsley.fieldses.org>
 <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
 <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
 <20190828144031.GB14249@parsley.fieldses.org>
 <20190828144839.GA26284@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=935
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=990 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280155
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 28, 2019, at 10:48 AM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Wed, Aug 28, 2019 at 10:40:31AM -0400, J. Bruce Fields wrote:
>> On Wed, Aug 28, 2019 at 10:16:09AM -0400, Jeff Layton wrote:
>>> For the most part, these sorts of errors tend to be rare. If it turns
>>> out to be a problem we could consider moving the verifier into
>>> svc_export or something?
>> 
>> As Trond says, this isn't really a server implementation issue, it's a
>> protocol issue.  If a client detects when to resend writes by storing a
>> single verifier per server, then returning different verifiers from
>> writes to different exports will have it resending every time it writes
>> to one export then another.
> 
> The other way to limit this is by trying to detect the single-writer
> case, since it's probably also rare for multiple clients to write to the
> same file.
> 
> Are there any common cases where two clients share the same TCP
> connection?  Maybe that would be a conservative enough test?

What happens if a client reconnects? Does that bump the verifier?

If it reconnects from the same source port, can the server tell
that the connection is different?


> And you wouldn't have to track every connection that's ever sent a WRITE
> to a given file.  Just remember the first one, with a flag to track
> whether anyone else has ever written to it.
> 
> ??
> 
> --b.

--
Chuck Lever




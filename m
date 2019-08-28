Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF203A03D7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfH1N5n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 09:57:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52802 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfH1N5n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Aug 2019 09:57:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SDnGTe055412;
        Wed, 28 Aug 2019 13:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=AbkQ2IPEUcAfQjGOxfa40fgyGzigtUnZeTIfElICE7M=;
 b=JGyMckefrnnxMMfTxYzwVYC6NwyAIoZjvM9dxv2YqfBsq0nPyaAA2KArlOh/xwk3kT9k
 +URvLFtXmSDLk4VpzJNuKIVxrIIxoM2XZaLuo6xoAHEW+3BICW+R+UGBgcoFSHeqgAN7
 ZtN5p1hU1UzOwnG1aLWs1vTMvPsBBR6+DStxUmHo81MpLKzINyKwGrk4JOtnJVzIDP44
 60YlCqa45ammHppgOYDvqiPMK8cQHgtagIezNxGR7FEwaL03bzvnMN4wmouhEtB7gdPL
 5nyYMeBbk89EEVYFXwHb5lJ9LlGlMYSklegrAUXZ43ccNB0HQVNvEaTvTxVg5h11MmF0 fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2untrv03w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:57:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SDrolQ127991;
        Wed, 28 Aug 2019 13:57:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2unduq078t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:57:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7SDvQr6027202;
        Wed, 28 Aug 2019 13:57:26 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 06:57:26 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
Date:   Wed, 28 Aug 2019 09:57:25 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
 <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
 <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
 <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
To:     Jeff Layton <jlayton@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280145
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 28, 2019, at 9:51 AM, Jeff Layton <jlayton@redhat.com> wrote:
> 
> On Wed, 2019-08-28 at 09:48 -0400, bfields@fieldses.org wrote:
>> On Tue, Aug 27, 2019 at 03:15:35PM +0000, Trond Myklebust wrote:
>>> I'm open to other suggestions, but I'm having trouble finding one that
>>> can scale correctly (i.e. not require per-client tracking), prevent
>>> silent corruption (by causing clients to miss errors), while not
>>> relying on optional features that may not be implemented by all NFSv3
>>> clients (e.g. per-file write verifiers are not implemented by *BSD).
>>> 
>>> That said, it seems to me that to do nothing should not be an option,
>>> as that would imply tolerating silent corruption of file data.
>> 
>> So should we increment the boot verifier every time we discover an error
>> on an asynchronous write?
>> 
> 
> I think so. Otherwise, only one client will ever see that error.

+1

I'm not familiar with the details of how the Linux NFS server
implements the boot verifier: Will a verifier bump be effective
for all file systems that server exports? If so, is that an
acceptable cost?


--
Chuck Lever




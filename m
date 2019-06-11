Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5319B3D0F7
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbfFKPgJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:36:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36568 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388277AbfFKPgJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:36:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BFO1EK115101;
        Tue, 11 Jun 2019 15:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=G4EZfA/Bf0cLOCMj8GT8B6PZf9IIQV5BxxEkLSI/wj4=;
 b=LlYSELQtz1WIHURGvFN347Hx/Ee2TdnjXqozeFZkZ0GDY1Q9efyZSz6lMnyYmy16d50z
 ZT+dBLcr0GxblWbx65sQtUcoeRsQ3gGehqkS1ON6ebuM1/LB5wt2c9qpCoXc6vw26ONR
 iH0jE6R1pcUntSYgTFe7S6LNZom8yStNJwioNusmzWAsG2PXb7cKL80jKDJm8UeDf2aH
 PTZqy0yZ0Gpv87wsqLfeYvLCaqMegwGMY4BrMg6JVwmd5btLGLIKxu63WzUd1Qixkjhc
 ydZq83umReOPLsmpc3XEXEJPcOSNkKLgGAuau6mLhTYxeeC0fh0d1lLI+WYlqR0ag8rn CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t04etp1n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 15:35:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BFYrq3071573;
        Tue, 11 Jun 2019 15:35:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t04hye04t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 15:35:57 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BFZuYa027016;
        Tue, 11 Jun 2019 15:35:56 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 08:35:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6693beb0989c83580235526e3d1b54fad0920d82.camel@hammerspace.com>
Date:   Tue, 11 Jun 2019 11:35:54 -0400
Cc:     "neilb@suse.com" <neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <35A94418-7DE0-4656-90B4-5A0183BA371C@oracle.com>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
 <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
 <87muj3tuuk.fsf@notabene.neil.brown.name>
 <4316E30B-1BD7-4F0E-8375-03E9F85FFD2B@oracle.com>
 <87lfy9vsgf.fsf@notabene.neil.brown.name>
 <3B887552-91FB-493A-8FDF-411562811B36@oracle.com>
 <6693beb0989c83580235526e3d1b54fad0920d82.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110101
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 11, 2019, at 11:20 AM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>=20
> On Tue, 2019-06-11 at 10:51 -0400, Chuck Lever wrote:
>=20
>> If maxconn is a hint, when does the client open additional
>> connections?
>=20
> As I've already stated, that functionality is not yet available. When
> it is, it will be under the control of a userspace daemon that can
> decide on a policy in accordance with a set of user specified
> requirements.

Then why do we need a mount option at all?


--
Chuck Lever




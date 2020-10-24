Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61554297D39
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Oct 2020 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761379AbgJXPxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 24 Oct 2020 11:53:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761165AbgJXPxU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 24 Oct 2020 11:53:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09OFrIFO049662;
        Sat, 24 Oct 2020 15:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=tISJEHuuEeio8ZpYDR1/7+tC6wUt2zU8Qpy8txV4OR4=;
 b=r9KvjIqubNht/9Yyk/EHLFcz3FMx1K/C7DqXCjgV60FmdqiLT6QSxeGJ2Gb9ODiTVVuT
 PHMRSCszspnFakls+GwzbKfS1TLRSohzravAvDo9WcZuR9fbpLHrZ3jDGtNp8wNR4HKO
 CDQpozpA7Yc5IWiqtKHl0rT+86PpKxCiz1TGPBE9wQEyxIFbGo3lfBP+064NgazSFlcd
 IUqEavh8Zg9dNZPACdHMJrmuzwYbfNf5m14u4/kggjAZJVANUofOKqh4wilaVECaE8oJ
 pBGA08D62GJ6en07iDaOLuB61Y2MX3I2GC6mYekl7FEjco7T252EAIADsi3zp+i+Mmtk mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34ccwmgtfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Oct 2020 15:53:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09OFo67D116595;
        Sat, 24 Oct 2020 15:51:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34cbkhjmq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Oct 2020 15:51:17 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09OFpGhi027887;
        Sat, 24 Oct 2020 15:51:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 24 Oct 2020 08:51:16 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: sm-notify: IP vs hostname?
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAAH4uRB3Nt=veFgxVUo2pyaBhw84cWahSY+3Tf7rC6ppLZi-dw@mail.gmail.com>
Date:   Sat, 24 Oct 2020 11:51:15 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <53327CDE-1D1F-489A-BAF1-E05A803C3FB8@oracle.com>
References: <CAAH4uRB3Nt=veFgxVUo2pyaBhw84cWahSY+3Tf7rC6ppLZi-dw@mail.gmail.com>
To:     Eric Hagberg <ehagberg@janestreet.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9784 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010240123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9783 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010240123
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 24, 2020, at 8:26 AM, Eric Hagberg <ehagberg@janestreet.com> wrote:
> 
> I've noticed that sm-notify pulls info from
> /var/lib/nfs/statd/sm/$hostname files that also contain the IP address
> that was in use when the lock(s) was created.
> 
> In cases where the hostname lookup may resolve to a different IP
> address over time, would it make sense to try notifying the IP address
> from that file rather than the hostname of the file? Or try the IP and
> fall back to a hostname if the first fails (or just notify both?)?

The historical tactic has been to send the notification to all the
addresses: for example, both IPv4 and IPv6. At first glance, it
seems like notifying both would be a useful behavior.


--
Chuck Lever




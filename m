Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F013125DFA6
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIDQRh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 12:17:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgIDQRh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 12:17:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084GF3tR002054;
        Fri, 4 Sep 2020 16:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=P/C6OWW92rrwTDywWmVMqlWYZjtOIV3cEi8OIydDxlw=;
 b=Mx2hWAVMLTZMQqdlOsusb6T57mHcuQGYGqgC6RY3w0ctt3vN7CcrE9rI1eHWn5CK5QWR
 +gOJOycIBcsiwfoaJS0sNwDHjKZ027Nia/8xUqZFcoNszeqMAH75yteGMeAZxWEFKfPm
 vffGQDUipkkJzQHlCtOllfHJfaDtukjH8N10L+U7fLl2vukOujaC/o+RIObf7yt9SqGf
 5HsFhZOITA8mi5pN46K0vM0Td+GunGy9oxKD1RXOEyOG/FDN6eiGacOmP+V3ahrxN4qB
 6mjt4qFe4QyNGZsfKNRd3H2KVYzcdAyZ9mkZDoldbt2CWg5sO4YZmAy+yW1MxZX0wLzF 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eerfddh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 16:17:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084GFDvj113453;
        Fri, 4 Sep 2020 16:17:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33bhs4q6a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 16:17:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084GHU6b000483;
        Fri, 4 Sep 2020 16:17:31 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 09:17:30 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200904152429.GA1738@fieldses.org>
Date:   Fri, 4 Sep 2020 12:17:29 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <A11FE08B-0AF7-42BB-9456-2D8ECC1D5B71@oracle.com>
References: <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
 <20200901191854.GD12082@fieldses.org> <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
 <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
 <20200904142923.GE26706@fieldses.org>
 <C73640A5-E374-46D7-9F35-EF34B17E4F3C@oracle.com>
 <20200904144932.GA349848@pick.fieldses.org>
 <45DCF35D-A919-4A99-9B6D-0952ED0A78E5@oracle.com>
 <20200904152429.GA1738@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040141
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2020, at 11:24 AM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> I'm not seeing the RDMA connection, by the way.  SEEK and READ_PLUS
> should work the same over TCP and RDMA.

The READ_PLUS result is not DDP-eligible because there's no way for
the client to predict in advance whether there will be data (which
can be moved by RDMA), holes or patterns (which cannot), nor how
many of each there might be.

Therefore I've asked Anna to leave READ_PLUS disabled on RDMA mounts.


--
Chuck Lever




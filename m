Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2205B2C1260
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 18:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbgKWRtS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 12:49:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgKWRtS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 12:49:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANHjUhv029957;
        Mon, 23 Nov 2020 17:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=kUTQcWCj+U6Ib5Pkea9ZZiSSajLZyIAqMUGlVO+NZ1c=;
 b=aujPKkpr767yS0vUs+WioJNQ1aPEuYbhQB5c673euv8kZSHbpXpK6OngCoXVi4rt91FT
 FDoD4Rv1POrRTgRUpw++kbedgSVfgSlYwCyIILNoSYIBMiwLmOb58UxxAQ1MSuyvIQG/
 BSQfftdg0Mm4epYW6paaiPiewu4WI+yvxdqCyg5FIy2pEbk5H/4OFmltJtooZLjtsa/a
 57pWSsYHq/dQcgRet8vq0jiud/x34LCqsmOp4biUuvvTo1REYTFGdoQgWeGqTyma5EKB
 nt9+utRgS4nZnx5wnyeCG6c1yjBj1SgtjqIonrVqW99kW5uG5R+Z4i+PWSgBp+nDehuk 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 34xtaqj1s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 17:49:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANHdppr054774;
        Mon, 23 Nov 2020 17:49:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ycnr8bh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 17:49:12 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ANHnBOs024222;
        Mon, 23 Nov 2020 17:49:11 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 09:49:11 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Date:   Mon, 23 Nov 2020 12:49:09 -0500
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABF9FF50-36C9-4A0C-97AF-AFD77CCE61B9@oracle.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
 <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
 <20201123173802.GA26158@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2020, at 12:38 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> On Mon, Nov 23, 2020 at 11:42:46AM -0500, Olga Kornievskaia wrote:
>> Hi Frank, Chuck,
>>=20
>> I would like your option on how LISTXATTR is supposed to work over
>> RDMA. Here's my current understanding of why the listxattr is not
>> working over the RDMA.
>>=20
>> This happens when the listxattr is called with a very small buffer
>> size which RDMA wants to send an inline request. I really dont
>> understand why, Chuck, you are not seeing any problems with hardware
>> as far as I can tell it would have the same problem because the =
inline
>> threshold size would still make this size inline.
>> rcprdma_inline_fixup() is trying to write to pages that don't exist.
>>=20
>> When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
>> will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
>> TCP. RDMA doesn't have anything like that.
>>=20
>> Question: Should there be code added to RDMA that will do something
>> similar when it sees that flag set? Or, should LISTXATTR be =
re-written
>> to be like READDIR which allocates pages before calling the code.
>=20
> Hm.. so if the flag never worked for RDMA, was NFS_V3_ACL ever tested
> over RDMA? That's the only other user.
>=20
> If the flag simply doesn't work, I agree that it should either be =
fixed
> or just removed.

Shirley fixed a crasher here years ago by making SPARSE_PAGES work
for RPC/RDMA. She confirmed the fix was effective.


> It wouldn't be the end of the world to change LISTXATTRS (and =
GETXATTR)
> to use preallocated pages. But, I didn't do that because I didn't want =
to
> waste the max size (64k) every time, even though you usually just get
> a few hundred bytes at most. So it seems like fixing =
XDRBUF_SPARSE_PAGES
> is cleaner.

These are infrequent operations. We've added extra conditional branches
in the hot path of the transports to handle this rare, non-performance
sensitive case.

I also wonder how well SPARSE_PAGES will work with xdr->bvecs, since
the bio_vec array is constructed before the transport can allocate
those pages.

To me, the whole SPARSE_PAGES concept is prototype-quality code that
needs to be replaced with a robust permanent solution.


--
Chuck Lever




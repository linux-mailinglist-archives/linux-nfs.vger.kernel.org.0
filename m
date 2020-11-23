Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899D92C1224
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKWRh3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 12:37:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55128 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732939AbgKWRh3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 12:37:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANHZPXm038451;
        Mon, 23 Nov 2020 17:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Ou1mUReMY/LPyB+82QIq9GSJ66PfNuvbKZaDQ70MR8s=;
 b=u1KZjsgaNQY8KCUsOEL0U/fNHsWjAj0zZUd0C/Oy//jc87IzaWZiRCTak+xAYJyA/OdN
 D1tFKzrKKoBKSMc0wxwp8RLElwX9nqllcufJgYZR0kgVf4SlYQFcz2KtOUX0+ABspT/e
 bXbir47kLR0F75R7R0Iu1kbyHuoJPLhVVQJ5qcbE+HdEO0dJb0wXp9dkOUO58Ht8DuHv
 9gtPj/g0sld6/f4GY8osDUCb8IzxE72rlZrHn0srmDDugJBwgGdgfy/3DYiI+HyNh/AA
 M+AhoMlcwc6mIDaAF9+M4vPzzL3r5pEHohpIWRP1eyZSKE8YMPRhpWvbG8arfTP57C9F Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34xrdapkw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 17:37:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANHZoM4038501;
        Mon, 23 Nov 2020 17:37:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34ycnr7xrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 17:37:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANHbHPD021147;
        Mon, 23 Nov 2020 17:37:17 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 09:37:17 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
Date:   Mon, 23 Nov 2020 12:37:15 -0500
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4687FA42-6294-418D-9835-EDE809997AE3@oracle.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
 <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230117
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2020, at 11:42 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> Hi Frank, Chuck,
>=20
> I would like your option on how LISTXATTR is supposed to work over
> RDMA. Here's my current understanding of why the listxattr is not
> working over the RDMA.
>=20
> This happens when the listxattr is called with a very small buffer
> size which RDMA wants to send an inline request. I really dont
> understand why, Chuck, you are not seeing any problems with hardware
> as far as I can tell it would have the same problem because the inline
> threshold size would still make this size inline.
> rcprdma_inline_fixup() is trying to write to pages that don't exist.
>=20
> When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
> will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
> TCP. RDMA doesn't have anything like that.
>=20
> Question: Should there be code added to RDMA that will do something
> similar when it sees that flag set?

Isn't the logic in rpcrdma_convert_iovs() allocating those pages?


> Or, should LISTXATTR be re-written
> to be like READDIR which allocates pages before calling the code.

AIUI READDIR reads into the directory inode's page cache. I recall
that Frank couldn't do that for LISTXATTR because there's no
similar page cache associated with the xattr listing.

That said, I would prefer that the *XATTR procedures directly
allocate pages instead of relying on SPARSE_PAGES, which is a hack
IMO. I think it would have to use alloc_page() for that, and then
ensure those pages are released when the call has completed.

I'm not convinced this is the cause of the problem you're seeing,
though.

--
Chuck Lever




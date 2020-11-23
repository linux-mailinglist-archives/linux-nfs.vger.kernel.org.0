Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7A12C12EB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgKWSJu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 13:09:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56142 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKWSJu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 13:09:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANI8XkC104298;
        Mon, 23 Nov 2020 18:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=MDKJYQYPFtVwEP/5AgQ8wjc8/Mg11CqjUITtD0QpEvg=;
 b=mIiLlJYZI7w1rPTQaiWSoBYwwFYykcdaeM01GhEFKurGuENAQr92kdfMyFKPbniOnjdo
 MZiCFgaxFQ+nINo/dh6SjhVHmhojOjv6KRIKn7SQiC0jiSNE7rlc9rQkpQHBQqxUduiZ
 Fps3MEqRxl9o5/fLTvz4FpXckmYwXbhA/QpURB72QW0hxB6g4dSmAlpqjlm+hWrD590k
 A2nlVmtVVJw1u3NSmD07Ig/j3t4NK66qG6P/gLiDlmm1pVBqdyEhFq5zww6lAOEpnGFE
 wTv9Kgar1tji5xxvYhMHlHi8SViskrAl6IEGorIENN+JSMOkG1RY6ssg4SH1sdltGaB4 uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34xrdaps24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 18:09:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANI4rPV169300;
        Mon, 23 Nov 2020 18:09:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34yctv7f3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Nov 2020 18:09:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANI9eoP029042;
        Mon, 23 Nov 2020 18:09:40 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 10:09:40 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/1] NFSv4.2: fix LISTXATTR buffer receive size
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAN-5tyEd8iDfEW0WsXyPsoM73tUSAXQgyhAfRbRbRZCem_cwPw@mail.gmail.com>
Date:   Mon, 23 Nov 2020 13:09:38 -0500
Cc:     Frank van der Linden <fllinden@amazon.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F85397C8-3FFD-4A7F-92E4-DB84D80F6387@oracle.com>
References: <20201113190851.7817-1-olga.kornievskaia@gmail.com>
 <99874775-A18C-4832-A2F0-F2152BE5CE32@oracle.com>
 <CAN-5tyEyQbmc-oefF+-PdtdcS7GJ9zmJk71Dk8EED0upcorqaA@mail.gmail.com>
 <07AF9A5C-BC42-4F66-A153-19A410D312E1@oracle.com>
 <CAN-5tyFpeVf0y67tJqvbqZmNMRzyvdj_33g9nJUNWW62Tx+thg@mail.gmail.com>
 <7E0CD3F3-84F2-4D08-8D5A-37AA0FA4852D@oracle.com>
 <20201119232647.GA11369@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAN-5tyH+ZCiqxKQEE9iGURP-71Xd2BqzHuWWPMzZURePKXirfQ@mail.gmail.com>
 <CAN-5tyEJ4Lbf=Ht2P4gwd9y4EPvN=G6teAiaunL=Ayxox8MSdg@mail.gmail.com>
 <4687FA42-6294-418D-9835-EDE809997AE3@oracle.com>
 <CAN-5tyEd8iDfEW0WsXyPsoM73tUSAXQgyhAfRbRbRZCem_cwPw@mail.gmail.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9814 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 23, 2020, at 12:59 PM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>=20
> On Mon, Nov 23, 2020 at 12:37 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Nov 23, 2020, at 11:42 AM, Olga Kornievskaia =
<olga.kornievskaia@gmail.com> wrote:
>>>=20
>>> Hi Frank, Chuck,
>>>=20
>>> I would like your option on how LISTXATTR is supposed to work over
>>> RDMA. Here's my current understanding of why the listxattr is not
>>> working over the RDMA.
>>>=20
>>> This happens when the listxattr is called with a very small buffer
>>> size which RDMA wants to send an inline request. I really dont
>>> understand why, Chuck, you are not seeing any problems with hardware
>>> as far as I can tell it would have the same problem because the =
inline
>>> threshold size would still make this size inline.
>>> rcprdma_inline_fixup() is trying to write to pages that don't exist.
>>>=20
>>> When LISTXATTR sets this flag XDRBUF_SPARSE_PAGES there is code that
>>> will allocate pages in xs_alloc_sparse_pages() but this is ONLY for
>>> TCP. RDMA doesn't have anything like that.
>>>=20
>>> Question: Should there be code added to RDMA that will do something
>>> similar when it sees that flag set?
>>=20
>> Isn't the logic in rpcrdma_convert_iovs() allocating those pages?
>=20
> No, rpcrdm_convert_iovs is only called for when you have reply chunks,
> lists etc but not for the inline messages. What am I missing?

So, then, rpcrdma_marshal_req() is deciding that the LISTXATTRS
reply is supposed to fit inline. That means rqst->rq_rcv_buf.buflen
is small.

But if rpcrdma_inline_fixup() is trying to fill pages,
rqst->rq_rcv_buf.page_len must not be zero? That sounds like the
LISTXATTRS encoder is not setting up the receive buffer correctly.

The receive buffer's buflen field is supposed to be set to a value
that is at least as large as page_len, I would think.


>>> Or, should LISTXATTR be re-written
>>> to be like READDIR which allocates pages before calling the code.
>>=20
>> AIUI READDIR reads into the directory inode's page cache. I recall
>> that Frank couldn't do that for LISTXATTR because there's no
>> similar page cache associated with the xattr listing.
>>=20
>> That said, I would prefer that the *XATTR procedures directly
>> allocate pages instead of relying on SPARSE_PAGES, which is a hack
>> IMO. I think it would have to use alloc_page() for that, and then
>> ensure those pages are released when the call has completed.
>>=20
>> I'm not convinced this is the cause of the problem you're seeing,
>> though.
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



